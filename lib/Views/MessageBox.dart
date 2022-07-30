import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/Controller/HomeController.dart';
import 'package:messenger/Models/Messages.dart';
import 'package:messenger/Repository/DBHelper.dart';
import 'package:messenger/Widgets/MessageBoxAppBar.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
class MessageBox extends GetView {
  @override
  Widget build(BuildContext context) {
    HomeController _controller = Get.find();
    TextEditingController messagecontrol = TextEditingController();
    var tempdir;
    final record = Record();
    return Scaffold(
      appBar: MessageBoxAppBar(),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Expanded(child: _controller.getAllMessages),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () async {
                      var file = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 1800,
                          maxWidth: 1800);
                      if (file != null) {
                        var messagekey = DateTime.now().microsecondsSinceEpoch;
                        var myref = DBHelper.storage
                            .ref()
                            .child("images")
                            .child(messagekey.toString());
                        var newmsg = File(file.path);
                        await myref.putFile(newmsg);
                        var myurl = await myref.getDownloadURL();
                        await _controller.SendMessage(
                            HomeController.openedChat,
                            Messages(
                                key: messagekey,
                                message: "",
                                isImage: true,
                                isAudio: false,
                                link: myurl));
                      }
                    },
                    child: Icon(
                      Icons.photo,
                      color: Colors.blue.shade700,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTapDown: (press) async {

                    tempdir=await getApplicationDocumentsDirectory();
                    if (await record.hasPermission()) {
                    // Start recording
                    await record.start(
                    path: tempdir.path+"/temp.mp3",
                    );
                    _controller.voiceIconSize.value=40;
                    }
                  },
                    onTapUp: (press) async {
                    _controller.voiceIconSize.value=24;
                      var path = await record.stop();
                      var messagekey = DateTime.now().microsecondsSinceEpoch;
                      var myref = DBHelper.storage
                          .ref()
                          .child("audio")
                          .child(messagekey.toString());
                      var newmsg = File(path!);
                      await myref.putFile(newmsg);
                      var myurl = await myref.getDownloadURL();
                      await _controller.SendMessage(
                          HomeController.openedChat,
                          Messages(
                              key: messagekey,
                              message: "",
                              isImage: false,
                              isAudio: true,
                              link: myurl));
                    },
                    child: Obx(()=>Icon(Icons.mic, color: Colors.blue.shade700,size:_controller.voiceIconSize.value))),
              ),
              Expanded(
                  child: TextFormField(
                controller: messagecontrol,
                onChanged: (val) {
                  _controller.message = val;
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                    hintText: "Enter Here",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Icon(Icons.send, color: Colors.blue.shade700),
                  onTap: () async {
                    var newmsg=Messages(
                        key: DateTime
                            .now()
                            .microsecondsSinceEpoch,
                        message: _controller.message,
                        isImage: false,
                        isAudio: false,
                        link: "");
                    messagecontrol.clear();
                    _controller.message = "";
                    if (newmsg.message!= "" || newmsg.isAudio || newmsg.isImage) {
                      await _controller.SendMessage(
                          HomeController.openedChat,newmsg
                          );
                    }
                  }
                ),
              )
            ],
          ),
          SizedBox(
            height: 3,
          )
        ],
      ))),
    );
  }
}
