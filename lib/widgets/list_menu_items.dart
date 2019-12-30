import 'package:flutter/material.dart';

/// A wide Material flat button menu item.
class ButtonMaterialMenuItem extends StatelessWidget {
  const ButtonMaterialMenuItem(
      {Key key, @required this.title, this.subtitle, this.isLastItem = false, this.leading, this.onPressed})
      : super(key: key);

  /// The title of the item.
  final String title;

  /// The second line of the content.
  final String subtitle;

  /// Set to [true] to remove the bottom separator.
  final bool isLastItem;

  /// A widget shown at the horizontal beginning of the widget.
  final Widget leading;

  /// The callback function for the pressed event.
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

/// A static Material menu item containing only text.
class TextMaterialMenuItem extends StatelessWidget {
  const TextMaterialMenuItem(
      {Key key, @required this.title, this.subtitle, this.isLastItem = false})
      : super(key: key);

  /// The title of the item.
  final String title;

  /// The second line of the content.
  final String subtitle;

  /// Set to [true] to remove the bottom separator.
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
