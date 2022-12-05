import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';
import 'package:heart_oxygen_alarm/pages/registerpage.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';
import 'package:heart_oxygen_alarm/widget/custombutton.dart';
import 'package:heart_oxygen_alarm/widget/customform.dart';

import '../cubit/auth/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  static const nameRoute = '/loginpage';
  LoginPage({super.key});
  final TextEditingController emailController =
      TextEditingController(text: 'usertest3@gmail.com');
  final TextEditingController passwordController =
      TextEditingController(text: 'usertest3');

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 62,
          ),
          child: SizedBox(
            height: h,
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
                // const Spacer(),
                const SizedBox(
                  height: 40,
                ),
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
                      onPressed: () {
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
                      child: Text(
                        'Lupa Password?',
                        style: cTextButtonBlack.copyWith(
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                ),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.nameRoute, (route) => false);
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        backgroundColor: cRedColor,
                        content: Text(state.error),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 14,
                          bottom: 28,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    //print(nameController.text);
                    return CustomButton(
                      text: 'Masuk',
                      onPressed: () {
                        if (emailController.text == '' ||
                            passwordController.text == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: cRedColor,
                              duration: Duration(milliseconds: 200),
                              content: Text(
                                'Pastikan Form Tidak Kosong',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text)) {
                          //NOTE:EMAIL VALIDATION menggunakan RegExp
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: cRedColor,
                              duration: Duration(milliseconds: 200),
                              content: Text(
                                'Cek Penulisan Email Anda',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else if (passwordController.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: cRedColor,
                              duration: Duration(milliseconds: 200),
                              content: Text(
                                'Password Minimal 8 Karakter',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          context.read<AuthCubit>().signIn(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                    );
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
        ),
      ),
    );
  }
}
