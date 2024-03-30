import 'dart:developer';

import 'package:flutter/material.dart';

final _list = [1, 2, 3, 4, 5, 6, 7, 8, 9, "*", 0, '%'];

class AppKeypad extends StatefulWidget {
  const AppKeypad({
    super.key,
    this.onAdd,
    this.onDelete,
  });

  final Function(int)? onAdd;
  final Function()? onDelete;

  @override
  State<AppKeypad> createState() => _AppKeypadState();
}

class _AppKeypadState extends State<AppKeypad> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.08),
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          if (widget.onAdd != null) {
            if (i != 9 && i != 11) {
              widget.onAdd!(int.tryParse(_list[i].toString())!);
            }
          }
          if (i == 11) {
            //Delete the last element in the array.
            if (widget.onDelete != null) {
              widget.onDelete!();
            }
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: i < _list.length - 1
                ? Text(
                    "${_list[i]}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 26),
                  )
                : const Icon(
                    Icons.cancel_presentation,
                    color: Colors.black,
                  ),
          ),
        ),
      ),
    );
  }
}
