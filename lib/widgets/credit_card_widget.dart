import 'package:flutter/material.dart';

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

  final String name;
  final String lastNumbers;
  final String amount;
  final TextStyle amountTextStyle;
  final Color color;
  final double elevation;
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
              Text(amount ?? '', style: amountTextStyle.copyWith(color: _textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
