import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socketfront/Models/message_model.dart';

import '../../../../Config/config.dart';
import '../../../../Models/chat_model.dart';

class InputChat extends StatefulWidget {
  InputChat({
    Key? key,
    required TextEditingController controller,
    required this.isMic,
    required this.chat,
    required this.sendMessage,
    required this.sendMessageServer,
    required this.message,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final MessageModel message;
  bool isMic = true;
  bool isImage = false;
  Function sendMessageServer;
  Function sendMessage;
  Chat chat;

  @override
  State<InputChat> createState() => _InputChatState();
}

class _InputChatState extends State<InputChat> {
  final ImagePicker imagePicker = ImagePicker();

  Uint8List? imageMsg;
  void selectImages() async {
    Uint8List? bytes;
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      for (var i in selectedImages) {
        bytes = await i.readAsBytes();
        String extensao = i.path.substring(i.path.lastIndexOf('.') + 1);
      }
    }
    setState(() {
      if (bytes != null) {
        widget._controller.text = '';
        widget._controller.text = '[.IMAGE.]';
        widget.message.mensagem = 'uImage${String.fromCharCodes(bytes!)}';
        widget.isImage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color:
                  currentTheme.isdark ? const Color(0xff1C2D35) : Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextFormField(
                onChanged: ((value) {
                  setState(
                    () {
                      widget.isMic = value.isEmpty ? true : false;
                    },
                  );
                  setState(() {
                    widget.message.mensagem = value;
                  });
                }),
                readOnly: widget.isImage,
                controller: widget._controller,
                style: TextStyle(
                  color: currentTheme.isdark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (() {
                      if (widget.isImage) {
                        setState(() {
                          widget._controller.text = '';
                          widget.message.mensagem = '';
                          widget.isImage = false;
                        });
                      } else {
                        selectImages();
                      }
                    }),
                    icon: Icon(
                      widget.isImage ? Icons.delete : Icons.add_photo_alternate,
                      color: currentTheme.isdark ? Colors.white : Colors.grey,
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Mensagem',
                  hintStyle: TextStyle(
                    color: currentTheme.isdark
                        ? const Color(0xff8097A1)
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff03AA82),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: IconButton(
              onPressed: (() {
                widget.chat.isServer
                    ? widget.sendMessageServer()
                    : widget.sendMessage();
              }),
              icon: Icon(
                widget.isMic ? Icons.mic : Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
