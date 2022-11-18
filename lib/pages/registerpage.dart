import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';

import '../cubit/auth/auth_cubit.dart';
import '../shared/theme.dart';
import '../widget/custombutton.dart';
import '../widget/customform.dart';

class RegisterPage extends StatelessWidget {
  static const nameRoute = '/registerpage';
  RegisterPage({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 62,
        ),
        child: SingleChildScrollView(
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
                  textController: usernameController,
                  hintText: 'Username',
                  margin: const EdgeInsets.only(bottom: 15),
                ),
                CustomForm(
                  textController: emailController,
                  hintText: 'Email',
                  margin: const EdgeInsets.only(bottom: 15),
                ),
                CustomForm(
                  textController: passwordController,
                  hintText: 'Kata Sandi',
                  margin: const EdgeInsets.only(bottom: 15),
                  isPassword: true,
                ),
                CustomForm(
                  textController: confirmPasswordController,
                  hintText: 'Konfirmasi Kata Sandi',
                  margin: const EdgeInsets.only(bottom: 5),
                  isPassword: true,
                ),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.nameRoute, (route) => false);
                    } else if (state is AuthFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 37,
                          bottom: 58,
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return CustomButton(
                      text: 'Daftar',
                      margin: const EdgeInsets.only(
                        top: 37,
                        bottom: 30,
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().signUp(
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                      },
                    );
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
        ),
      ),
    );
  }
}
