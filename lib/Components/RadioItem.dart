import 'package:flutter/material.dart';
import 'package:todoApp/Models/Radio.dart';

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      child: Center(
        child: Text(_item.buttonText,
            style: TextStyle(
              color: _item.isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      decoration: BoxDecoration(
        color: _item.isSelected ? Theme.of(context).buttonColor : Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
    );
  }
}
