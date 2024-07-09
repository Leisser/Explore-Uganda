import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_uganda/home/profile/morePages/admin_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  QuerySnapshot? snapshot;

  Future<List<DocumentSnapshot>> getChatMessages() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('chatList').get();
    return snapshot.docs;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: bpadding,
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: appcolor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 10, left: 20),
                      child: Text(
                        'Chats',
                        style: subheadings,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 200,
                child: FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('chatList').get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminChatPage(
                                        name: data['name'],
                                        url: data['image'],
                                        chatId: document.id,
                                      )));
                        },
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(data['image'].toString()),
                        ),
                        title: Text(data['name']),
                        trailing: const Icon(Icons.send),
                      );
                    }).toList());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
