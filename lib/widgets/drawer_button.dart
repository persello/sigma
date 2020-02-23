import 'package:flutter/material.dart';

/// A customizable button to be used in a scaffold.
///
/// It can contain a [name] and an [icon]. Its shape can be customized by adding a corner radius to the right side.
/// The default color when selected is picked by the current [Theme]'s [accentColor].
/// Set the [selected] property to [true] when the related page/function is active.
class DrawerButton extends StatelessWidget {
  const DrawerButton(
      {Key key,
      this.icon,
      @required this.name,
      this.rightSideCornerRadius = 0,
      this.selected = false,
      this.selectedColor,
      this.selectedColorOpacity = 0.2,
      @required this.onPressed})
      : super(key: key);

  /// The icon to be displayed at the beginning of the button.
  final IconData icon;

  /// The main text of the button.
  final String name;

  /// The radius applied to the right side border (defaults to zero).
  final double rightSideCornerRadius;

  /// Whether the button should be transparent or colored.
  final bool selected;

  /// The color to display when selected.
  final Color selectedColor;

  /// The default opacity of the selection color (defaults to 20%).
  final double selectedColorOpacity;

  /// The callback function for the touch event.
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    Color _selectedColor = selectedColor ?? Theme.of(context).accentColor;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(rightSideCornerRadius),
          bottomRight: Radius.circular(rightSideCornerRadius)),
      child: FlatButton(
        color: selected ? _selectedColor.withOpacity(selectedColorOpacity) : Colors.transparent,
        child: ListTile(
          leading: Icon(icon),
          title: Text(name),
          selected: selected,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
