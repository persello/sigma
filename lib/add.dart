import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:sigma/widgets/amount_input.dart';
import 'package:sigma/widgets/carousel_with_cut.dart';
import 'package:sigma/widgets/credit_card_widget.dart';
import 'package:sigma/widgets/flippable.dart';
import 'package:sigma/widgets/list_menu_items.dart';
import 'package:sigma/widgets/custom_text_styles.dart';
import 'package:sigma/widgets/purse_widget.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with TickerProviderStateMixin {
  FlippableController _controller = FlippableController();

  Widget headerBuilder(String title, bool close, {Function onEllipsisPressed}) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 60,
      alignment: AlignmentDirectional.topStart,
      child: Stack(
        children: <Widget>[
          close
              ? IconButton(
                  icon: Icon(Icons.close),
                  tooltip: 'Close popup',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : IconButton(
                  icon: Icon(Icons.arrow_back),
                  tooltip: 'Go back',
                  onPressed: () {
                    _controller.pop();
                  },
                ),
          Center(
            child: AnimatedOpacity(
              opacity: (title?.length ?? 0) > 0 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          if (onEllipsisPressed != null)
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: Icon(Icons.more_horiz), tooltip: 'More details', onPressed: onEllipsisPressed)),
        ],
      ),
    );
  }

  Widget mainMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        headerBuilder('Add item', true),
        ButtonMaterialMenuItem(
          title: 'Income',
          leading: Icon(Icons.file_download, color: Colors.tealAccent),
          onPressed: () {
            _controller.navigate('add/income');
          },
        ),
        ButtonMaterialMenuItem(
            title: 'Expense', leading: Icon(Icons.file_upload, color: Colors.amberAccent), onPressed: () {}),
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

  Widget addIncome(BuildContext context) {
    List<Widget> sampleCards = [
      PurseWidget(
        amount: '145.12€',
        amountTextStyle: CustomTextStyles.moneyDisplayStyle,
        backgroundImage: AssetImage('res/purse.png'),
      ),
      CreditCardWidget(
        amount: '171.43€',
        name: 'Postepay Evolution',
        color: Colors.amber,
        amountTextStyle: CustomTextStyles.moneyDisplayStyle,
        lastNumbers: '1283',
      ),
      CreditCardWidget(
        amount: '171.43€',
        name: 'Postepay Evolution',
        color: Colors.teal,
        amountTextStyle: CustomTextStyles.moneyDisplayStyle,
        lastNumbers: '1283',
      ),
      CreditCardWidget(
        amount: '171.43€',
        name: 'Postepay Evolution',
        color: Colors.pink,
        amountTextStyle: CustomTextStyles.moneyDisplayStyle,
        lastNumbers: '1283',
      ),
      CreditCardWidget(
        amount: '171.43€',
        name: 'Postepay Evolution',
        color: Colors.blueAccent,
        amountTextStyle: CustomTextStyles.moneyDisplayStyle,
        lastNumbers: '1283',
      ),
    ];

    return Column(
      children: <Widget>[
        headerBuilder('Add income', false,
            onEllipsisPressed: () => _controller.navigate('add/incomeDetails')),
        CardCarousel(cards: sampleCards),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: SingleChildScrollView(
            // TODO: Scroll not working
            child: Form(
              child: Column(
                children: <Widget>[
                  FormField<String>(
                    builder: (_) => InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          textInputAction: TextInputAction.next, // TODO: Go to next field
                          decoration:
                              InputDecoration.collapsed(hintText: 'Description', border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 0, color: Colors.transparent, height: 8),
                  FormField<double>(
                    // TODO: double -> Money
                    builder: (_) => CurrencyAmountInput(),
                  ),
                ],
              ),
            ),
          ),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Text('Add'),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  Widget incomeDetails(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          headerBuilder('Details', false),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Form(
              child: Column(
                children: <Widget>[
                  FormField<String>(
                    builder: (_) => TextField(
                      textInputAction: TextInputAction.next, // TODO: Go to next field
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Source',
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                    ),
                  ),
                  Divider(thickness: 0, color: Colors.transparent, height: 8),
                  FormField<double>(
                    // TODO: Change text to taxes (will be deducted from the amount set in the previous page) and shown!!!
                    // TODO: double -> Money
                    builder: (_) => CurrencyAmountInput(),
                  ),
                  Divider(thickness: 0, color: Colors.transparent, height: 8),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text('Finish'),
                onPressed: () => _controller.pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.4),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: KeyboardAvoider(
          child: Flippable(
            onNavigationComplete: () {
              setState(() {});
            },
            heroTag: 'fab',
            controller: _controller,
            frontPages: <String, WidgetBuilder>{
              'add/item': mainMenu,
              'add/income': addIncome,
            },
            backPages: <String, WidgetBuilder>{
              'add/incomeDetails': incomeDetails,
            },
          ),
        ),
      ),
    );
  }
}
