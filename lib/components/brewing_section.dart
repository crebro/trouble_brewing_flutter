import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trouble_brewing/constants.dart';
import 'package:trouble_brewing/providers/game_state_provider.dart';

class BrewingSection extends StatelessWidget {
  final int sectionIndex;
  const BrewingSection({super.key, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BrewBox(sectionIndex: sectionIndex),
          Additives(
            sectionIndex: sectionIndex,
          )
        ],
      ),
    );
  }
}

class Additives extends StatelessWidget {
  final int sectionIndex;
  const Additives({super.key, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdditiveButton(
              onPressed: () {
                gameStateProvider.setAdditiveContent(Additive.BISCUIT,
                    sectionIndex: sectionIndex);
              },
              icon: const Icon(
                Icons.airlines_rounded,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => gameStateProvider.setAdditiveContent(
                  Additive.CREAM,
                  sectionIndex: sectionIndex),
              icon: const Icon(
                Icons.icecream,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => gameStateProvider
                  .setAdditiveContent(Additive.BAR, sectionIndex: sectionIndex),
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => gameStateProvider.setAdditiveContent(
                  Additive.SUGAR,
                  sectionIndex: sectionIndex),
              icon: const Icon(
                Icons.check_box_outline_blank_sharp,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => gameStateProvider.setAdditiveContent(
                  Additive.COOKIE,
                  sectionIndex: sectionIndex),
              icon: const Icon(
                Icons.cookie,
                color: Colors.white,
                size: 40,
              )),
        ],
      ),
    );
  }
}

class AdditiveButton extends StatelessWidget {
  final Function onPressed;
  final Icon icon;

  const AdditiveButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xff638388)),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}

class BrewBox extends StatelessWidget {
  final int sectionIndex;
  const BrewBox({super.key, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameStateProvider>(
        builder: (context, gameStateProvider, _) {
      List<List<Additive>> additiveContents =
          gameStateProvider.getAdditiveContents(sectionIndex);
      return Container(
        height: 400,
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                  // scrollDirection: Axis.vertical,
                  primary: false,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  childAspectRatio: 50 / 100,
                  children: List.generate(
                      6,
                      (index) => BrewItem(
                            clearContents: () {
                              gameStateProvider.clearAdditiveContent(index,
                                  sectionIndex: sectionIndex);
                            },
                            onPressed: () {
                              gameStateProvider.setActiveIndex(index,
                                  sectionIndex: sectionIndex);
                            },
                            isActive: gameStateProvider.activeIndex == index,
                            contents: additiveContents[index],
                          ))),
            )
          ],
        ),
      );
    });
  }
}

class BrewItem extends StatefulWidget {
  final bool isActive;
  final List<Additive> contents;
  final Function onPressed;
  final Function clearContents;
  const BrewItem(
      {super.key,
      required this.isActive,
      required this.contents,
      required this.onPressed,
      required this.clearContents});

  @override
  State<BrewItem> createState() => _BrewItemState();
}

class _BrewItemState extends State<BrewItem> {
  bool isFilling = false;
  bool forceStop = false;
  bool goneBad = false;
  Timer? goneBadConversionTimer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        height: 150,
        width: 50,
        child: Column(
          children: [
            AdditiveButton(
                onPressed: () {
                  if (!isFilling) {
                    goneBadConversionTimer =
                        Timer(Duration(milliseconds: 2500), () {
                      setState(() {
                        goneBad = true;
                      });
                    });
                  }
                  if (isFilling) {
                    goneBadConversionTimer?.cancel();
                    setState(() {
                      goneBad = false;
                    });
                    widget.clearContents();
                  }
                  setState(() {
                    isFilling = !isFilling;
                  });
                },
                icon: Icon(
                  !isFilling ? Icons.water_drop_outlined : Icons.dangerous,
                  color: Colors.white,
                )),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 50,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: widget.isActive ? Colors.grey[200] : Colors.white),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: isFilling
                            ? Duration(seconds: 2)
                            : const Duration(seconds: 0),
                        width: 50,
                        height: isFilling ? 100 : 0,
                        color: goneBad ? Colors.brown : Colors.blue,
                      )),
                  Container(
                    width: 50,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        for (var i = 0; i < widget.contents.length; i++)
                          Icon(AdditiveConstants
                              .addtiveIcons[widget.contents[i]]),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
