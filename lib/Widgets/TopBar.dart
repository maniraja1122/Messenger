import 'package:flutter/material.dart';

import 'UserImageTop.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  String toptitle = "";
  Widget? action1;
  Widget action2;

  TopBar(
      {Key? key,
      required this.toptitle,
      required this.action1,
      required this.action2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: UserImageTop(),
      title: Text(
        toptitle,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        action1!=null?Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: CircleAvatar(foregroundColor: Colors.black,backgroundColor:Colors.grey.shade200, child: action1),
        ):SizedBox(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: CircleAvatar(foregroundColor: Colors.black,backgroundColor: Colors.grey.shade200,child: action2),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
