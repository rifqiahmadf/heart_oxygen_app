import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';
import 'package:heart_oxygen_alarm/pages/registerpage.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';
import 'package:heart_oxygen_alarm/widget/custombutton.dart';
import 'package:heart_oxygen_alarm/widget/customform.dart';

class LoginPage extends StatelessWidget {
  static const nameRoute = '/loginpage';
  LoginPage({super.key});
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
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Lupa Password?',
                    style: cTextButtonBlack.copyWith(
                      fontWeight: regular,
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Masuk',
              onPressed: () {
                Navigator.pushNamed(context, HomePage.nameRoute);
              },
            ),
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
                onPressed: () {
                  Navigator.pushNamed(context, RegisterPage.nameRoute);
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
