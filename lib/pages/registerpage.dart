import 'package:flutter/material.dart';

import '../shared/theme.dart';
import '../widget/custombutton.dart';
import '../widget/customform.dart';

class RegisterPage extends StatelessWidget {
  static const nameRoute = '/registerpage';
  RegisterPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              margin: const EdgeInsets.only(bottom: 5),
              isPassword: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Lupa Password?',
                style: cTextButtonBlack.copyWith(
                  fontWeight: regular,
                ),
              ),
            ),
            const CustomButton(text: 'Masuk'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: cGreyColor,
                    height: 1,
                    margin: const EdgeInsets.only(
                      right: 10,
                    ),
                  ),
                ),
                Text(
                  'Masuk Menggunakan',
                  style: cTextButtonBlack,
                ),
                Expanded(
                  child: Container(
                    color: cGreyColor,
                    height: 1,
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 200),
                      content: Text(
                        'Coming Soon',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/logogoogle.png',
                  height: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Tidak mempunyai akun?",
                        style: cTextButtonBlack,
                      ),
                      TextSpan(
                        text: " Daftar disini",
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
