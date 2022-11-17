import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class HomeUtama extends StatelessWidget {
  const HomeUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: cGreyColor,
                  height: 2,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                ),
              ),
              Text(
                'Status Kamu',
                style: cNavBarText.copyWith(
                  fontSize: 20,
                  color: cPurpleDarkColor,
                ),
              ),
              Expanded(
                child: Container(
                  color: cGreyColor,
                  height: 2,
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          //
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 50,
                    color: cRedColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '75 DPM',
                    style: cHeader1Style.copyWith(
                      color: cBlackColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 50,
                    color: cRedColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '94 %',
                    style: cHeader1Style.copyWith(
                      color: cBlackColor,
                    ),
                  ),
                ],
              )
            ],
          ),
          //
          //
          const SizedBox(
            height: 26,
          ),
          Text(
            'Normal',
            style: cNavBarText.copyWith(
              fontSize: 20,
              color: cPurpleDarkColor,
            ),
          ),
        ],
      ),
    );
  }
}
