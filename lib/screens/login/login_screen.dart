import 'dart:convert';

import 'package:daelim_project/common/widgets/gradient_divider.dart';
import 'package:daelim_project/config.dart';
import 'package:daelim_project/enums/sso_enum.dart';
import 'package:daelim_project/extensions/context_extension.dart';
import 'package:daelim_project/helpers/storage_helper.dart';
import 'package:daelim_project/models/auth_data.dart';
import 'package:daelim_project/routes/app_screen.dart';
import 'package:easy_extension/easy_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(0),
    borderSide: BorderSide.none,
  );

  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  // NOTE: 패스워드 재설정
  void _onRecoveryPassword() {}

  // NOTE: 로그인 버튼
  void _onSignIn() async {
    final email = _emailController.text;
    final password = _pwController.text;

    final loginData = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(authUrl),
      body: jsonEncode(loginData),
    );

    final statusCode = response.statusCode;
    final body = utf8.decode(response.bodyBytes);

    if (statusCode != 200) {
      if (mounted) {
        context.showSnackBar(
          content: Text(body),
        );
      }
    }

    // NOTE: AuthData 로 변환
    final authData = AuthData.fromMap(jsonDecode(body));
    await StorageHelper.setAuthData(authData);
    final savedAuthData = StorageHelper.authData;
    Log.green(savedAuthData);
    if (mounted) context.goNamed(AppScreen.main.name);
    return;
  }

  // NOTE: SSO 로그인 버튼
  void _onSsoSignIn(SsoEnum type) {
    switch (type) {
      case SsoEnum.google:
        context.showSnackBarText('구글 로그인 시작');
      case SsoEnum.apple:
        context.showSnackBarText('준비 중인 기능입니다.');
      case SsoEnum.github:
        context.showSnackBarText('준비 중인 기능입니다.');
    }
  }

  // NOTE: 타이틀 텍스트 위젯들
  List<Widget> _buildTitleTexts() => [
        const Text(
          'Hello Again!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        15.heightBox,
        const Text(
          'Wellcome back you\'ve\nbeen missed!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        )
      ];

  // NOTE: 텍스트 입력 위젯들
  List<Widget> _buildTextFields() => [
        _buildTextField(
          controller: _emailController,
          hintText: 'Enter email',
        ),
        10.heightBox,
        _buildTextField(
          onObscure: (down) {
            setState(() {
              _isObscure = !down;
            });
          },
          controller: _pwController,
          hintText: 'Password',
          obscure: _isObscure,
        ),
      ];

  // NOTE: 텍스트 입력 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool? obscure,
    Function(bool down)? onObscure,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        enabledBorder: border,
        focusedBorder: border,
        hintText: hintText,
        suffixIcon: obscure != null
            ? GestureDetector(
                onTapDown: (details) => onObscure?.call(true),
                onTapUp: (details) => onObscure?.call(false),
                child: Icon(
                  obscure //
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : null,
      ),
      obscureText: obscure ?? false,
    );
  }

  // NOTE: SSO 버튼 위젯
  Widget _buildSsoButton({
    required String iconUrl,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(10),
        child: Image.network(iconUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDEDEE2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: DefaultTextStyle(
            style: GoogleFonts.poppins(
              color: context.textTheme.bodyMedium?.color,
            ),
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    36.heightBox,

                    ..._buildTitleTexts(),

                    40.heightBox,

                    ..._buildTextFields(),

                    // Recovery Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _onRecoveryPassword,
                        child: const Text(
                          'Recovery Password',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    30.heightBox,

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE46A61),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    40.heightBox,

                    // Or continue with
                    Row(
                      children: [
                        const Expanded(
                          child: GradientDivider(),
                        ),
                        15.widthBox,
                        const Text('Or continue with'),
                        15.widthBox,
                        const Expanded(
                          child: GradientDivider(reverse: true),
                        ),
                      ],
                    ),

                    40.heightBox,

                    // SSO Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSsoButton(
                          onTap: () => _onSsoSignIn(SsoEnum.google),
                          iconUrl: icGoogle,
                        ),
                        _buildSsoButton(
                          onTap: () => _onSsoSignIn(SsoEnum.apple),
                          iconUrl: icApple,
                        ),
                        _buildSsoButton(
                          onTap: () => _onSsoSignIn(SsoEnum.github),
                          iconUrl: icGithub,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
