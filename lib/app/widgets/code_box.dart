import 'dart:developer';

import 'package:flutter/material.dart';

class CodeBox extends StatelessWidget {
  const CodeBox({
    super.key,
    required this.list,
    this.pin = false,
  });

  final List<int> list;
  final bool pin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(
          5,
          (i) {
            return Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: pin ? Colors.transparent : Colors.grey.withOpacity(0.1),
                borderRadius: pin ? null : BorderRadius.circular(10),
                border: pin
                    ? const Border(
                        bottom: BorderSide(
                          color: Colors.teal,
                          width: 1.5,
                        ),
                      )
                    : null,
              ),
              child: Center(
                child: pin
                    ? Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                list.length > i ? Colors.black : Colors.white),
                      )
                    : Text(
                        list.length > i ? "${list[i]}" : '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                      ),
              ),
            );
          },
        )
      ],
    );
  }
}
