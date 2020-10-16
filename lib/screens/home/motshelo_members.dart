import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesigo/model/member.dart';

import 'member_card.dart';

class MemberList extends StatefulWidget {
  @override
  _MemberListState createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
    // get members from provider in add home
    final members = Provider.of<List<Member>>(context);
    // loop through snapshot

    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return MemberCard(member: members[index]);
      },
    );
  }
}
