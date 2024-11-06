import 'dart:convert';
import 'dart:io';

import 'package:daelim_project/common/scaffold/app_scaffold.dart';
import 'package:daelim_project/config.dart';
import 'package:daelim_project/helpers/storage_helper.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? _name;
  String? _studentNumber;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  // NOTE: 유저 정보 가져오기
  Future<void> _fetchUserData() async {
    final tokenType = StorageHelper.authData!.tokenType.firstUpperCase;
    final token = StorageHelper.authData!.token;

    final response = await http.get(
      Uri.parse(getUserDataUrl),
      headers: {
        HttpHeaders.authorizationHeader: '$tokenType $token',
      },
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);

    // NOTE: 유저 정보 에러 발생
    if (statusCode != 200) {
      setState(() {
        _name = '데이터를 불러올 수 없습니다.';
        _studentNumber = body;
        _profileImageUrl = '';
      });
      return;
    }

    final userData = jsonDecode(body);

    setState(() {
      _name = userData['name'];
      _studentNumber = userData['student_number'];
      _profileImageUrl = userData['profile_image'];
    });
  }

  /// NOTE: 프로필 이미지 업로드
  Future<void> _uploadProfileImage() async {
    if (_profileImageUrl == null || _profileImageUrl?.isEmpty == true) {
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    final imageFile = result.files.single;
    final imageName = imageFile.name;
    final imageMime = lookupMimeType(imageName) ?? 'image/jpeg';
    Uint8List? imageBytes;

    String? imagePath;

    if (kIsWeb) {
      imageBytes = imageFile.bytes;
    } else {
      imagePath = imageFile.path!;
    }

    Log.green('이미지 업로드: $imageName / Bytes: ${imageBytes?.length} / Path: $imagePath');

    final tokenType = StorageHelper.authData!.tokenType.firstUpperCase;
    final token = StorageHelper.authData!.token;

    final uploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(setProfileImageUrl),
    )
      ..headers.addAll(
        {
          HttpHeaders.authorizationHeader: '$tokenType $token',
        },
      )
      ..files.add(
        imageBytes != null
            ? http.MultipartFile.fromBytes(
                'image',
                imageBytes,
                filename: imageName,
                contentType: MediaType.parse(imageMime),
              )
            : await http.MultipartFile.fromPath(
                'image',
                imagePath!,
                contentType: MediaType.parse(imageMime),
              ),
      );

    final response = await uploadRequest.send();
    final uploadResult = await http.Response.fromStream(response);

    Log.green(
      '이미지 업로드 결과: ${uploadResult.statusCode}, ${uploadResult.body}',
    );

    if (uploadResult.statusCode != 200) return;

    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appScreen: AppScreen.setting,
      child: Column(
        children: [
          ListTile(
            leading: InkWell(
              onTap: _uploadProfileImage,
              child: CircleAvatar(
                backgroundImage: _profileImageUrl != null //
                    ? _profileImageUrl!.isNotEmpty
                        ? NetworkImage(_profileImageUrl!)
                        : null
                    : null,
                child: _profileImageUrl != null //
                    ? _profileImageUrl!.isEmpty
                        ? const Icon(Icons.cancel)
                        : null
                    : const CircularProgressIndicator(),
              ),
            ),
            title: Text(_name ?? '데이터 로딩 중..'),
            subtitle: _studentNumber != null //
                ? Text(
                    _studentNumber!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
