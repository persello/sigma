import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// An input field for specifying a monetary amount with related currency
/// selector. Allows for search and custom default suggestion text.
/// 
/// Set [allowCurrencySelector] to [false] to inhibit currency selection.
/// With [defaultText], which defaults to 'Amount', you change the content of
/// the suggestion label of the amount field.
/// 
/// ADD HERE DOCUMENTATION FOR CURRENCIES
class CurrencyAmountInput extends StatefulWidget {
  CurrencyAmountInput({
    Key key,
    this.allowCurrencySelector = true,
    this.defaultText = 'Amount',
  }) : super(key: key);

  final bool allowCurrencySelector;
  final String defaultText;

  /* List of currencies and default currency */

  @override
  _CurrencyAmountInputState createState() => _CurrencyAmountInputState();
}

class _CurrencyAmountInputState extends State<CurrencyAmountInput> with TickerProviderStateMixin {
  bool isCurrencyChooserShown = false;
  bool isSearchBoxShown = false;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration:
          InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
      child: AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(width: 20),
                Flexible(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'^[0-9]*[.]?[0-9]{0,2}'))],
                    decoration: InputDecoration.collapsed(hintText: widget.defaultText, border: InputBorder.none),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                Container(
                    child: Text('🇺🇸'),
                    padding: EdgeInsets.only(right: widget.allowCurrencySelector ? 0 : 20)),
                if (widget.allowCurrencySelector)
                  IconButton(
                    icon: Icon(isCurrencyChooserShown ? Icons.arrow_drop_up : Icons.arrow_drop_down),
                    onPressed: () {
                      setState(() {
                        isCurrencyChooserShown = !isCurrencyChooserShown;
                        isSearchBoxShown = false;
                      });
                    },
                  ),
              ],
            ),
            if (isSearchBoxShown && isCurrencyChooserShown) Divider(height: 16, thickness: 1),
            if (isSearchBoxShown && isCurrencyChooserShown)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(width: 20),
                  Flexible(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Search a currency...', border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isSearchBoxShown = false;
                      });
                    },
                  )
                ],
              ),
            if (isCurrencyChooserShown) Divider(height: 16, thickness: 1),
            if (isCurrencyChooserShown)
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    if (!isSearchBoxShown)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: InkWell(
                            child: Icon(Icons.search),
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                isSearchBoxShown = true;
                              });
                            },
                          ),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: true,
                        label: Text('Dollars'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: false,
                        label: Text('Other common currency'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: false,
                        label: Text('Another'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: false,
                        label: Text('Another...'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: false,
                        label: Text('Another...'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        selected: false,
                        label: Text('Enough.'),
                        avatar: Text('🇺🇸'),
                        selectedColor: Theme.of(context).accentColor,
                        onSelected: (_) {},
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
