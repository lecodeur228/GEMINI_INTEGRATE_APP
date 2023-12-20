import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class UserRequetWidget extends StatelessWidget {
  String question;
  String user;
  UserRequetWidget({super.key, required this.question, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              child: Text(
                user.substring(0, 1),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Gap(20),
            const Spacer(),
            Container(
              padding: const EdgeInsetsDirectional.all(7),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Icon(Icons.refresh),
            )
          ],
        ),
        const Gap(10),
        const Text("Question :",
            style: TextStyle(
                color: Colors.white54,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(question,
              style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
