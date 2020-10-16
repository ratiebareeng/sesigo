import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sesigo/model/member.dart';
import 'package:sesigo/screens/home/add_user_record.dart';

class MemberCard extends StatelessWidget {
  final Member member;

  MemberCard({this.member});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        //margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        elevation: 8.0,
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              fit: BoxFit.cover,
              imageUrl: member.img,
            ),
          ),
          title: Text(member.name),
          subtitle: Text('Joined: ${member.joined}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddUserRecord(
                        member: member,
                      )),
            );
          },
        ),
      ),
    );
  }
}
