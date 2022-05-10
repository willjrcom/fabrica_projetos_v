
import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: const [
          Text(
            '#',
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
        ]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'VC NA',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'CORRIDA',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
