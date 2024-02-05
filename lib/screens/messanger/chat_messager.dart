import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:btl/data/data.dart';
import 'package:btl/data/post_data.dart';

import 'package:flutter/material.dart';
import 'package:btl/data/convert_data.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class Chat_Messanger extends StatefulWidget {
  Data dataa;
  Data dataother;
  Chat_Messanger(this.dataa, this.dataother);
  State<Chat_Messanger> createState() => _Messanger();
}

class _Messanger extends State<Chat_Messanger> {
  late IO.Socket socketUser;
  late ConvertData cv = ConvertData();
  List<dynamic> messages = [];
  List<dynamic> mymess = [];
  String? message;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (this.mounted)
        setState(() {
          message = remoteMessage!.data["mess"];
        });
    });
    connectToSockets();
    fetch();
  }

  void connectToSockets() {
    socketUser = IO.io(
      'https://sherlockhome.io.vn/',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socketUser.connect();
    socketUser.on('messager', (data) {
      setState(() {
        if (data["id_sender"] == widget.dataa.id &&
            data["id_receiver"] == widget.dataother.id) {
          mymess.add(messages.length);
        } else if (data["id_receiver"] == widget.dataa.id &&
            data["id_sender"] == widget.dataother.id) {
          messages.add(data["mess"]);
        }
        showNotification(data["mess"], data["id_receiver"]);
      });
    });
  }

  void showNotification(String message, String idReceiver) {
    if (idReceiver == widget.dataa.id) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'chat_channel',
          title: '${widget.dataother.name}',
          body: message,
        ),
      );
    }
  }

  Future<void> sendMessageUser() async {
    String message = textEditingController.text;
    if (message.isNotEmpty) {
      setState(() {
        mymess.add(messages.length);
        messages.add(message);
      });
      socketUser.emit('messager', {
        "id_sender": "${widget.dataa.id}",
        "id_receiver": "${widget.dataother.id}",
        "mess": message,
      });
      DateTime now = DateTime.now();
      PostTakeData _postTakeData = PostTakeData();
      _postTakeData.post_take_data({
        "id_sender": widget.dataa.id,
        "id_receiver": widget.dataother.id,
        "mess": message,
        "token": widget.dataother.token,
        "times": "${now}",
        "name": widget.dataother.name
      }, "message");
      textEditingController.clear();
    }
  }

  void fetch() async {
    if (this.mounted) {
      await cv.fetchMess();
      setState(() {
        for (int i = 0; i < cv.mess.length; i++) {
          if (cv.mess[i].id_receiver == widget.dataa.id &&
                  cv.mess[i].id_sender == widget.dataother.id ||
              cv.mess[i].id_receiver == widget.dataother.id &&
                  cv.mess[i].id_sender == widget.dataa.id) {
            messages.add(cv.mess[i].mess);
          }
          if (cv.mess[i].id_sender == widget.dataa.id &&
              cv.mess[i].id_receiver == widget.dataother.id) {
            mymess.add(i);
          }
        }
        ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messenger'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = messages.length - 1 - index;
                final message = messages[reversedIndex];

                return Align(
                  alignment: mymess.contains(messages.length - 1 - index)
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: mymess.contains(messages.length - 1 - index)
                        ? const EdgeInsets.only(left: 80.0)
                        : const EdgeInsets.only(right: 80.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: mymess.contains(messages.length - 1 - index)
                            ? Color.fromARGB(255, 231, 229, 222)
                            : const Color.fromARGB(255, 47, 187, 78),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message != null ? message : "",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                FloatingActionButton(
                  onPressed: sendMessageUser,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    message = null;
    messages.clear();
    mymess.clear();
    socketUser.disconnect();
    super.dispose();
  }
}
