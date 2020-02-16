import 'package:flutter/material.dart';

/// Presents a credit card as a widget.
/// 
/// The card should have a [name]. [lastNumbers] is optional and fixed to a maximum of 16 characters.
/// The displayed number of the card will be [lastNumbers] padded with dots and with correct spacing.
/// [amount] is a string representing the amount of money contained by the card, and its text is
/// styled accordingly to what specified in [amountTextStyle]. You can also specify a card [color].
/// The color of the text contained in the card will be selected automatically in order to be
/// readable over the selected background. The [elevation] is applied to the [Material] layer of the
/// card and [cutBottom] specifies whether the card should have its bottom side completely flat, not
/// rounded (for example when used inside a [CutCarousel]).
class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget(
      {Key key,
      this.name,
      this.lastNumbers,
      this.amount,
      this.amountTextStyle,
      this.color = Colors.amber,
      this.elevation = 8,
      this.cutBottom = true})
      : super(key: key);

  /// The name of the card.
  final String name;

  /// The last numers of the card (maximum length is 16 characters).
  final String lastNumbers;

  /// Balance of the card.
  final String amount;

  /// [TextStyle] for the amount label.
  final TextStyle amountTextStyle;

  /// Background color.
  final Color color;

  /// Material elevation.
  final double elevation;

  /// Set to [true] if the bottom should not have rounded corners.
  final bool cutBottom;

  @override
  Widget build(BuildContext context) {
    assert((lastNumbers?.length ?? 0) <= 16);
    String _num = lastNumbers?.padLeft(16, '•');

    // Split in four groups
    if (_num != null) {
      RegExp _exp = RegExp(r".{4}", dotAll: true);
      List<String> _groups = List<String>();
      _exp.allMatches(_num).forEach((m) => _groups.add(m.group(0)));
      _num = _groups.join(' ');
    }

    // Decide text color based on background color
    Color _textColor = (color.computeLuminance() > 0.4) ? Colors.black : Colors.white;

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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name ?? '',
                      style: TextStyle(color: _textColor, fontWeight: FontWeight.w800, fontSize: 14)),
                  Divider(height: 8),
                  Text(_num ?? '',
                      style: TextStyle(color: _textColor, fontWeight: FontWeight.w300, fontSize: 13))
                ],
              ),
              Text(amount ?? '', style: amountTextStyle?.copyWith(color: _textColor)?.copyWith(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
