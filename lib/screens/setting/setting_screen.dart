import 'dart:convert';
import 'dart:io';

import 'package:daelim_project/common/scaffold/app_scaffold.dart';
import 'package:daelim_project/helpers/storage_helper.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:daelim_project/config.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Future<Map<String, dynamic>> fetchUserData() async {
    final token = StorageHelper.authData!.accessToken;
    final tokenType = StorageHelper.authData!.tokenType.firstUpperCase;

    final response = await http.get(
      Uri.parse(getUserDataUrl),
      headers: {
        HttpHeaders.authorizationHeader: '$tokenType $token',
      },
    );

    final statuscode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);
    if (statuscode != 200) throw Exception(body);

    return jsonDecode(body);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appScren: AppScreen.settings,
      child: Column(
        children: [
          FutureBuilder(
              future: fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 100),
                    child: const CircularProgressIndicator(),
                  );
                }
                final err = snapshot.error;
                final userData = snapshot.data;
                String name = '';
                String studentNumber = '';
                String profileImg = '';
                if (err != null) {
                  name = '데이터를 불러올수없습니다';
                  studentNumber = '$err';
                }
                Log.black(userData);

                if (userData != null) {
                  name = userData['name'];
                  studentNumber = userData['student_number'];
                  profileImg = userData['profile_image'];
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(profileImg),
                  ),
                  title: Text(name),
                  subtitle: Text(studentNumber),
                );
              }),
        ],
      ),
    );
  }
}
