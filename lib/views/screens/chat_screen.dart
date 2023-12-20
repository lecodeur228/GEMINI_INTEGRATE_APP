import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:gemini_integrate_app/constants.dart';
import 'package:gemini_integrate_app/services/gemini_service.dart';
import 'package:gemini_integrate_app/views/widgets/gemini_response_widget.dart';
import 'package:gemini_integrate_app/views/widgets/user_requet_widget.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isPhoto = false;
  bool _isLoad = false;
  final TextEditingController _questionController = TextEditingController();
  final ScrollController _controller = ScrollController();
  List textChat = [];
  XFile? image_url;
  void scrollToTheEnd() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        image_url = image;
      });
    } catch (e) {
      print("Erreur lors de la sélection de l'image : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Constants.background_color,
                Constants.background_color_second
              ],
            ),
          ),
          child: Column(
            children: [
              const Gap(15),
              const Text(
                "Gemini ChatBot",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              const Gap(10),
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: textChat.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> item = textChat[index];
                    print(item["text"]);
                    if (item["role"] == "User") {
                      return UserRequetWidget(
                        question: item["text"],
                        user: item["role"],
                      );
                    } else {
                      return GeminiResponseWidget(
                          response: item["text"], user: item["role"]);
                    }
                  },
                ),
              ),
              const Gap(20),
              _isPhoto
                  ? InkWell(
                      onDoubleTap: () {
                        print("toff: ");
                        setState(() {
                          _isPhoto = false;
                        });
                      },
                      onTap: () {
                        pickImage();
                        // if (image_url!.path.isNotEmpty) {
                          _showDialog();
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(Icons.photo),
                      ),
                    )
                  : TextField(
                      controller: _questionController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          suffixIcon: _isLoad
                              ? const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: CircularProgressIndicator(),
                                )
                              : InkWell(
                                  onDoubleTap: () {
                                    setState(() {
                                      _isPhoto = true;
                                    });
                                  },
                                  onTap: () {
                                    if (_questionController.text.isNotEmpty) {
                                      setState(() {
                                        textChat.add({
                                          "role": "User",
                                          "text": _questionController.text
                                        });
                                        _questionController.clear();
                                      });
                                      scrollToTheEnd();
                                      GeminiServices.gemini
                                          .generateFromText(
                                              _questionController.text)
                                          .then((value) {
                                        print(value.text);
                                        setState(() {
                                          textChat.add({
                                            "role": "Gemini",
                                            "text": value.text
                                          });
                                          _isLoad = false;
                                        });
                                        scrollToTheEnd();
                                      }).onError((error, stackTrace) {
                                        setState(() {
                                          textChat.add({
                                            "role": "Gemini",
                                            "text": error.toString(),
                                          });
                                        });
                                        scrollToTheEnd();
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                          fillColor: Constants.input_background_color,
                          filled: true,
                          hintText: "Votre question...",
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              gapPadding: 2.0,
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15))),
                    ),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Image.file(File(image_url!.path))],
            ),
          );
        });
  }
}
