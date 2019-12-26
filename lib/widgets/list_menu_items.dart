import 'package:flutter/material.dart';

class ButtonMaterialMenuItem extends StatelessWidget {
  const ButtonMaterialMenuItem(
      {Key key, @required this.title, this.subtitle, this.isLastItem = false, this.leading, this.onPressed})
      : super(key: key);

  final String title;
  final String subtitle;
  final bool isLastItem;
  final Widget leading;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onPressed,
          child: ListTile(
            leading: leading,
            title: Text(title),
            subtitle: subtitle != null ? Text(subtitle) : null,
            enabled: onPressed != null,
          ),
        ),
        (!isLastItem) ? Divider(height: 1) : Semantics()
      ],
    );
  }
}

class TextMaterialMenuItem extends StatelessWidget {
  const TextMaterialMenuItem(
      {Key key, @required this.title, this.subtitle, this.isLastItem = false})
      : super(key: key);

  final String title;
  final String subtitle;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle) : null,
        ),
        (!isLastItem) ? Divider(height: 1) : Semantics()
      ],
    );
  }
}
