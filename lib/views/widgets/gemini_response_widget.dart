import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gemini_integrate_app/constants.dart';

class GeminiResponseWidget extends StatelessWidget {
  String response;
  String user;
  GeminiResponseWidget({super.key, required this.response, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Constants.conatiner_ia_background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Constants.background_color,
                child: Text(
                  user.substring(0, 1),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Gap(10),
              const Spacer(),
              const Gap(10),
              const Icon(Icons.copy)
            ],
          ),
          const Gap(5),
          const Text(
              softWrap: true,
              maxLines: 5,
              "Response :",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              )),
          const Gap(10),
          Text(
              softWrap: true,
              maxLines: 5,
              response,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              )),
          const Gap(15),
        ],
      ),
    );
  }
}
