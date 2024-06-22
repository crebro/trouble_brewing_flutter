import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trouble_brewing/constants.dart';

class BrewingSection extends StatefulWidget {
  const BrewingSection({super.key});

  @override
  State<BrewingSection> createState() => _BrewingSectionState();
}

class _BrewingSectionState extends State<BrewingSection> {
  int activeIndex = 0;
  List<List<Additive>> additiveContents = List.filled(6, [Additive.BISCUIT]);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BrewBox(activeIndex: activeIndex, additiveContents: additiveContents),
          Additives(
            onItemPressed: (Additive additiveKey) {
              setState(() {
                additiveContents[activeIndex] = [
                  ...additiveContents[activeIndex],
                  additiveKey
                ];
              });
            },
          )
        ],
      ),
    );
  }
}

class Additives extends StatelessWidget {
  final void Function(Additive additiveKey) onItemPressed;
  const Additives({super.key, required this.onItemPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AdditiveButton(
              onPressed: () {
                onItemPressed(Additive.BISCUIT);
              },
              icon: Icon(
                Icons.airlines_rounded,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => onItemPressed(Additive.CREAM),
              icon: Icon(
                Icons.icecream,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => onItemPressed(Additive.BAR),
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => onItemPressed(Additive.SUGAR),
              icon: Icon(
                Icons.check_box_outline_blank_sharp,
                color: Colors.white,
                size: 40,
              )),
          AdditiveButton(
              onPressed: () => onItemPressed(Additive.COOKIE),
              icon: Icon(
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
  final int activeIndex;
  final List<List<Additive>> additiveContents;
  const BrewBox(
      {super.key, required this.activeIndex, required this.additiveContents});

  @override
  Widget build(BuildContext context) {
    print(additiveContents);
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
                          isActive: activeIndex == index,
                          contents: additiveContents[index],
                        ))),
          )
        ],
      ),
    );
  }
}

class BrewItem extends StatefulWidget {
  final bool isActive;
  final List<Additive> contents;
  const BrewItem({super.key, required this.isActive, required this.contents});

  @override
  State<BrewItem> createState() => _BrewItemState();
}

class _BrewItemState extends State<BrewItem> {
  bool beginFilling = false;
  bool forceStop = false;
  bool goneBad = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 50,
      child: Column(
        children: [
          AdditiveButton(
              onPressed: () {
                setState(() {
                  beginFilling = !beginFilling;
                });
                if (!beginFilling) {
                  Timer(Duration(milliseconds: 2500), () {
                    setState(() {
                      goneBad = true;
                    });
                  });
                }
              },
              icon: Icon(
                !beginFilling ? Icons.water_drop_outlined : Icons.dangerous,
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
                      duration: beginFilling
                          ? Duration(seconds: 2)
                          : const Duration(seconds: 0),
                      width: 50,
                      height: beginFilling ? 100 : 0,
                      color: Colors.blue,
                    )),
                Container(
                  width: 50,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      for (var i = 0; i < widget.contents.length; i++)
                        Icon(
                            AdditiveConstants.addtiveIcons[widget.contents[i]]),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
