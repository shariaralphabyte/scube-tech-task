import 'package:flutter/material.dart';
import 'package:sceube_tech/presentation/screens/dashboard.dart';

import '../../core/app_export.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_edit_text.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_image_view.dart';
import './provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final loginProvider = context.read<LoginProvider>();

      final success = await authProvider.login(
        loginProvider.usernameController.text.trim(),
        loginProvider.passwordController.text,
      );

      if (success && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login failed'),
            backgroundColor: AppTheme.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.light_blue_A700,
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 80.h),
                    CustomImageView(
                      imagePath: ImageConstant.imgAsset14x81,
                      width: 96.h,
                      height: 98.h,
                    ),
                    SizedBox(height: 18.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 41.h),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'SCUBE \n',
                              style: TextStyleHelper
                                  .instance.headline24SemiBoldInter
                                  .copyWith(height: 1.2),
                            ),
                            TextSpan(
                              text: 'Control & Monitoring System',
                              style: TextStyleHelper
                                  .instance.title20SemiBoldInter
                                  .copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 76.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.white_A700,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.h),
                          topRight: Radius.circular(20.h),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.h, vertical: 34.h),
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          Text(
                            'Login',
                            style: TextStyleHelper.instance.headline24BoldInter,
                          ),
                          SizedBox(height: 22.h),
                          CustomEditText(
                            controller: provider.usernameController,
                            placeholder: 'Username',
                            backgroundColor: AppTheme.white_A700,
                            borderColor: AppTheme.blue_gray_200,
                            borderRadius: 10.h,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20.h,
                              horizontal: 12.h,
                            ),
                            validator: provider.validateUsername,
                          ),
                          SizedBox(height: 12.h),
                          CustomEditText(
                            controller: provider.passwordController,
                            placeholder: 'Password',
                            isPasswordField: true,
                            backgroundColor: AppTheme.white_A700,
                            borderColor: AppTheme.blue_gray_200,
                            borderRadius: 10.h,
                            contentPadding:
                                EdgeInsets.fromLTRB(12.h, 18.h, 30.h, 18.h),
                            validator: provider.validatePassword,
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: provider.onForgetPasswordTap,
                              child: Text(
                                'Forget password?',
                                style: TextStyleHelper
                                    .instance.body12MediumInter
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, _) {
                              return CustomElevatedButton(
                                text: 'Login',
                                width: double.infinity,
                                height: 55.h,
                                backgroundColor: AppTheme.light_blue_A700,
                                textColor: AppTheme.white_A700,
                                fontSize: 18.fSize,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                borderRadius: 10.h,
                                isLoading: authProvider.isLoading,
                                onPressed: _handleLogin,
                              );
                            },
                          ),
                          SizedBox(height: 8.h),
                          GestureDetector(
                            onTap: provider.onRegisterNowTap,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t have any account?',
                                    style: TextStyleHelper
                                        .instance.body12MediumInter,
                                  ),
                                  TextSpan(
                                    text: ' ',
                                    style: TextStyleHelper
                                        .instance.body14MediumInter
                                        .copyWith(
                                            color: AppTheme.blue_gray_300),
                                  ),
                                  TextSpan(
                                    text: 'Register Now',
                                    style: TextStyleHelper
                                        .instance.body14SemiBoldInter
                                        .copyWith(
                                            color: AppTheme.light_blue_A700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 116.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
