import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';

import '../shared/theme.dart';
import '../widget/custombutton.dart';
import '../widget/customform.dart';

class RegisterPage extends StatelessWidget {
  static const nameRoute = '/registerpage';
  RegisterPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 62,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gabung dan \nnikmati hidup sehat',
              style: cHeader1Style,
            ),
            const SizedBox(
              height: 31,
            ),
            Image.asset('assets/images/runheader.png'),
            const Spacer(),
            //
            //
            //
            CustomForm(
              textController: emailController,
              hintText: 'Email',
              margin: const EdgeInsets.only(bottom: 15),
            ),
            CustomForm(
              textController: passwordController,
              hintText: 'Kata Sandi',
              margin: const EdgeInsets.only(bottom: 15),
            ),
            CustomForm(
              textController: confirmPasswordController,
              hintText: 'Konfirmasi Kata Sandi',
              margin: const EdgeInsets.only(bottom: 5),
              isPassword: true,
            ),

            CustomButton(
              text: 'Masuk',
              margin: const EdgeInsets.only(
                top: 37,
                bottom: 58,
              ),
              onPressed: () {
                Navigator.pushNamed(context, HomePage.nameRoute);
              },
            ),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sudah punya akun? Login Disini",
                        style: cTextButtonBlack,
                      ),
                      TextSpan(
                        text: " Login disini",
                        style: cTextButtonBlack.copyWith(fontWeight: bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
