import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/Repository/DBHelper.dart';
import 'package:story_view/story_view.dart';
import 'package:intl/intl.dart';
class StatusViewer extends StatefulWidget {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> arr;
  int index;

  StatusViewer({Key? key, required this.arr, required this.index})
      : super(key: key);

  @override
  State<StatusViewer> createState() => _StatusViewerState();
}

class _StatusViewerState extends State<StatusViewer> {
  var _controller = StoryController();

  @override
  Widget build(BuildContext context) {
    _controller.previous();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            StoryView(
              progressPosition: ProgressPosition.top,
              onComplete: () {
                if (widget.index < widget.arr.length - 1) {
                  setState(() {
                    widget.index++;
                  });
                } else {
                  _controller.dispose();
                  Get.back();
                }
              },
              onVerticalSwipeComplete: (dir) {
                Get.back();
              },
              controller: _controller,
              storyItems: [
                StoryItem.pageImage(
                    url: widget.arr[widget.index].get("link"),
                    controller: _controller),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
              child: StreamBuilder(
                stream: DBHelper.db
                    .collection("Users")
                    .where("key",
                        isEqualTo: widget.arr[widget.index].get("userkey"))
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    var currentuser = snapshot.data!.docs[0];
                    final DateTime now = DateTime.fromMicrosecondsSinceEpoch(
                        widget.arr[widget.index].get("key"));
                    final DateFormat formatter = DateFormat('E');
                    final String formatted = formatter.format(now);
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: currentuser.get("dplink") == ""
                            ? AssetImage("assets/images/placeholder.png")
                                as ImageProvider
                            : NetworkImage(currentuser.get("dplink")),
                      ),
                      title: Text(
                        currentuser.get("name"),
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(formatted,style: TextStyle(color: Colors.grey),)
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
