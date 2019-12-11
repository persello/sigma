// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sigma/main.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';

void main() {
  testWidgets('Main app pump test', (WidgetTester tester) async {
    // Build main widget
    await tester.pumpWidget(SigmaApp());
  });

  testWidgets('Add page open test', (WidgetTester tester) async {
    // Build main widget
    await tester.pumpWidget(SigmaApp());

    // Tap FAB and wait for animation to finish
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle(Duration(milliseconds: 500));
  });

  // testWidgets('Add page content', (WidgetTester tester) async {
  //   // Build main widget
  //   await tester.pumpWidget(SigmaApp());
  // });

  testWidgets('Scaffold with backdrop drawer responds to menu taps', (WidgetTester tester) async {
    int drawerWidth = 500;

    // Build scaffold
    await tester.pumpWidget(MaterialApp(
        home: ScaffoldWithBackdropDrawer(
      maximumDrawerWidth: drawerWidth,
      drawerContent: Text('DRAWER CONTENT'),
      body: Text('BODY CONTENT'),
    )));

    // Check widget presence
    expect(find.text('DRAWER CONTENT'), findsOneWidget);
    expect(find.text('BODY CONTENT'), findsOneWidget);

    // Drawer icon tap

    // Menu is closed
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == 0);

    // Tap icon
    await tester.tap(find.byType(AnimatedIcon));
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is opened
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == drawerWidth.toDouble());

    // Tap icon again
    await tester.tap(find.byType(AnimatedIcon));
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is closed
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == 0);

    // Drawer drag

    // Drag menu from side to center
    await tester.dragFrom(Offset(10, 100), Offset(drawerWidth.toDouble() / 2, 0));
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is opened
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == drawerWidth.toDouble());

    // Drag menu from center to side
    await tester.dragFrom(
        Offset(drawerWidth.toDouble() + 40, 100), Offset(-(drawerWidth.toDouble() / 2 + 1), 0));
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is closed
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == 0);

    // Drawer fling

    // Fling menu from side to center
    await tester.flingFrom(Offset(10, 100), Offset(drawerWidth.toDouble() / 4, 0), 500);
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is opened
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == drawerWidth.toDouble());

    // Drag menu from center to side
    await tester.flingFrom(
        Offset(drawerWidth.toDouble() + 40, 100), Offset(-(drawerWidth.toDouble() / 4), 0), 500);
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is closed
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == 0);

    // Gesture rejection

    // Drag menu from side but out of start area to center
    await tester.dragFrom(Offset(51, 100), Offset(drawerWidth.toDouble() / 2, 0));
    await tester.pumpAndSettle(Duration(milliseconds: 500));

    // Menu is closed
    assert(tester.getTopLeft(find.byType(Scaffold)).dx == 0);
  });
}
