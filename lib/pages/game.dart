import 'package:flutter/material.dart';
import 'package:trouble_brewing/components/brewing_section.dart';
import 'package:trouble_brewing/components/keep_alive_page.dart';

class OrdersSection extends StatelessWidget {
  const OrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 500,
      color: Colors.blue,
    );
  }
}

class MainGame extends StatefulWidget {
  const MainGame({super.key});

  @override
  State<MainGame> createState() => _MainGameState();
}

class _MainGameState extends State<MainGame> {
  PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height - 200,
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            //   controller: _pageController,
            children: [
              KeepAlivePage(child: BrewingSection()),
              OrdersSection(),
              KeepAlivePage(child: BrewingSection())
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: (MediaQuery.of(context).size.height - 200) / 2,
          child: InkWell(
            onTap: () {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.arrow_left)),
          ),
        ),
        Positioned(
          right: 0,
          top: (MediaQuery.of(context).size.height - 200) / 2,
          child: InkWell(
            onTap: () => {
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.ease)
            },
            child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.arrow_right)),
          ),
        )
      ],
    );
  }
}
