import 'dart:ui';

import 'package:flutter/material.dart';

class PurseWidget extends StatelessWidget {
  const PurseWidget(
      {Key key,
      this.amount,
      this.amountTextStyle,
      this.color = Colors.white,
      this.backgroundImage,
      this.elevation = 8,
      this.cutBottom = true})
      : super(key: key);

  /// Balance of the card.
  final String amount;

  /// [TextStyle] for the amount label.
  final TextStyle amountTextStyle;

  /// Background color.
  final Color color;

  /// Image.
  final ImageProvider backgroundImage;

  /// Material elevation.
  final double elevation;

  /// Set to [true] if the bottom should not have rounded corners.
  final bool cutBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: color,
        elevation: elevation,
        borderRadius: cutBottom
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.all(Radius.circular(8)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: backgroundImage,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity((Theme.of(context).brightness == Brightness.dark) ? 0.4 : 0),
                    BlendMode.multiply)),
            borderRadius: cutBottom
                ? BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )
                : BorderRadius.all(Radius.circular(8)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cash',
                style: TextStyle(color: Colors.white),
              ),
              Text(amount ?? '',
                  style: amountTextStyle?.copyWith(color: Colors.white)?.copyWith(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
