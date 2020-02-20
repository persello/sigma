import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sigma/widgets/credit_card_widget.dart';
import 'dart:math' as Math;
import 'package:sigma/widgets/fab_hero_radius.dart';
import 'package:sigma/widgets/list_menu_items.dart';
import 'package:sigma/widgets/custom_text_styles.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with TickerProviderStateMixin {
  AnimationController opacityController;
  Animation<double> opacityAnimation;

  AnimationController rotationController;
  Animation<double> rotationAnimation;

  bool flipped = false;

  List titles = ['item', 'income', 'expense', 'internal transfer'];

  int selectedMenu = 0;

  @override
  void initState() {
    super.initState();
    // Initialize opacity animation
    opacityController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(opacityController)
      ..addListener(() {
        setState(() {});
      });

    // Start opacity animation
    opacityController.forward();

    // Initialize rotation animation
    rotationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    Animation rotationCurve =
        CurvedAnimation(curve: Curves.easeInOut, parent: rotationController);
    rotationAnimation = Tween(begin: 0.0, end: Math.pi).animate(rotationCurve)
      ..addListener(() {
        setState(() {
          flipped = rotationController.value >= 0.5;
        });
      });
  }

  Widget buildSubmenu(int selected, bool isFlipped) {
    if (isFlipped)
      return Container(
        color: Colors.amber,
        height: 300,
      );
    else
      switch (selected) {
        case 0:
          return FadeTransition(
              opacity: opacityAnimation, child: buildFirstMenu());
          break;
        case 1:
          return FadeTransition(
              opacity: opacityAnimation, child: buildIncomeMenu());
          break;
        default:
          return FadeTransition(
              opacity: opacityAnimation, child: buildFirstMenu());
      }
  }

  Widget buildIncomeMenu() {
    final PageController accountPageController =
        PageController(initialPage: -1, viewportFraction: 0.8);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 106,
            child: PageView(
              controller: accountPageController,
              children: <Widget>[
                CreditCardWidget(
                  color: Colors.amberAccent,
                  name: 'Card 1',
                  amount: '171.43€',
                  lastNumbers: '1283',
                  amountTextStyle:
                      CustomTextStyles.moneyDisplayStyle.copyWith(fontSize: 22),
                ),
                CreditCardWidget(
                  color: Colors.redAccent,
                  name: 'Card 1',
                  amount: '171.43€',
                  lastNumbers: '07341283',
                  amountTextStyle:
                      CustomTextStyles.moneyDisplayStyle.copyWith(fontSize: 22),
                ),
                CreditCardWidget(
                  color: Colors.blueAccent,
                  name: 'Card 1',
                  amount: '171.43€',
                  lastNumbers: '712',
                  amountTextStyle:
                      CustomTextStyles.moneyDisplayStyle.copyWith(fontSize: 22),
                ),
                CreditCardWidget(
                  color: Colors.tealAccent,
                  name: 'Card 1',
                  amount: '171.43€',
                  amountTextStyle:
                      CustomTextStyles.moneyDisplayStyle.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 16, spreadRadius: -16, offset: Offset(0, -16))
            ], color: Theme.of(context).cardColor),
            height: 40,
          ),
          Container(
              child: FlatButton(
            child: Text('FLIP CARD!'),
            onPressed: () {
              if (rotationController.status == AnimationStatus.completed)
                rotationController.reverse();
              else
                rotationController.forward();
            },
          ))
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: EdgeInsets.all(6),
      height: 60,
      alignment: AlignmentDirectional.topStart,
      child: Stack(
        children: <Widget>[
          (selectedMenu == 0)
              ? IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (!flipped) {
                      setState(() {
                        selectedMenu = 0;
                      });
                      opacityController
                        ..reset()
                        ..forward();
                    } else {
                      rotationController.reverse();
                    }
                  },
                ),
          Center(
            child: Text(
              'Add ${titles[selectedMenu]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFirstMenu() {
    return Column(
      children: <Widget>[
        ButtonMaterialMenuItem(
            title: 'Income',
            leading: Icon(Icons.file_download, color: Colors.tealAccent),
            onPressed: () {
              setState(() {
                selectedMenu = 1;
              });
              opacityController
                ..reset()
                ..forward();
            }),
        ButtonMaterialMenuItem(
            title: 'Expense',
            leading: Icon(Icons.file_upload, color: Colors.amberAccent),
            onPressed: () {}),
        ButtonMaterialMenuItem(
            title: 'Internal transfer',
            leading: Icon(Icons.compare_arrows, color: Colors.pinkAccent),
            onPressed: () {}),
        ButtonMaterialMenuItem(
            title: 'Exchange',
            leading: Icon(Icons.attach_money, color: Colors.blueAccent),
            isLastItem: true,
            onPressed: () {})
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black.withOpacity(0.55),
          //padding: EdgeInsets.symmetric(horizontal: 40, vertical: 120),
          child: Center(
            child: Hero(
              createRectTween:
                  FloatingActionButtonWithCornerHeroTransition.createRectTween,
              tag: 'fab',
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0009)
                  // Correct behavior with different screen sizes
                  ..translate((MediaQuery.of(context).size.width - 80) *
                      (rotationAnimation.value / Math.pi))
                  ..rotateY(rotationAnimation.value),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  type: MaterialType.card,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: (MediaQuery.of(context).size.width < 800)
                              ? MediaQuery.of(context).size.width - 80
                              : 720),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FadeTransition(
                              opacity: opacityAnimation, child: buildHeader()),
                          buildSubmenu(selectedMenu, flipped),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
