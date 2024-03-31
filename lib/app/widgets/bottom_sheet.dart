import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartpay/app/util/extension.dart';

final countries = [
  'us',
  'gb',
  'sg',
  'cn',
  'nl',
  'id',
];

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Column(
        children: [
          TextField(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                10.verticalSpace,
                ...List.generate(countries.length, (i) {
                  log(countries[i]);
                  return GestureDetector(
                    onTap: () {
                      widget.controller.text = countries[i].toUpperCase();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: widget.controller.text.toLowerCase() ==
                                  countries[i]
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.transparent),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  'asset/img/${countries[i]}.png',
                                  height: 26,
                                ),
                                30.horizontalSpace,
                                Text(
                                  countries[i].toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: const Color(0xFF6B7280)),
                                ),
                                30.horizontalSpace,
                                Text(
                                  i == 0
                                      ? "Unite states"
                                      : i == 1
                                          ? "United Kingdom"
                                          : i == 2
                                              ? "Singapore"
                                              : i == 3
                                                  ? "China"
                                                  : i == 4
                                                      ? "Netherlands"
                                                      : 'Indonesia',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          if (widget.controller.text.toLowerCase() ==
                              countries[i])
                            Icon(
                              Icons.check,
                              color: Colors.green,
                            )
                        ],
                      ),
                    ),
                  );
                }),
                30.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
