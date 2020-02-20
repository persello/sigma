import 'package:flutter/material.dart';

class CardCarousel extends StatelessWidget {
  CardCarousel({Key key, this.cards}) : super(key: key);

  final List<Widget> cards;

  final PageController cardPageController = PageController(initialPage: -1, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 106,
            child: ((cards?.length ?? 0) > 0)
                ? PageView(controller: cardPageController, children: cards)
                : Center(child: Text('No accounts or cards available.')),
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 15, spreadRadius: -8.5, offset: Offset(0, -12))],
                color: Theme.of(context).cardColor),
            height: 20,
          ),
        ],
      ),
    );
  }
}
