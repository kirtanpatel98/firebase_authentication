import 'package:firebase_authentication/data/constants/size_constants.dart';
import 'package:firebase_authentication/data/controllers/firebase_controller.dart';
import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:firebase_authentication/screens/auth/ui/registration_page.dart';
import 'package:firebase_authentication/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController;
  TextEditingController passwordContoller;

  final FirebaseController firebaseController = Get.find<FirebaseController>();
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);

  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final FocusScopeNode _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordContoller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formStateKey,
                  child: FocusScope(
                    node: _focusNode,
                    child: ListView(
                      padding:
                          const EdgeInsets.all(SizeConstant.kDefaultPadding),
                      shrinkWrap: true,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.accentColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          onEditingComplete: _focusNode.nextFocus,
                          controller: emailController,
                          validator: Validator.validateEmail,
                          style: const TextStyle(color: AppTheme.kBlack),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.email],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ValueListenableBuilder(
                          valueListenable: _passwordVisible,
                          builder:
                              (BuildContext context, bool value, Widget child) {
                            return TextFormField(
                              onEditingComplete: _focusNode.nextFocus,
                              controller: passwordContoller,
                              validator: Validator.validatePassword,
                              style: const TextStyle(color: AppTheme.kBlack),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: !value,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppTheme.kBlack,
                                  ),
                                  onPressed: () {
                                    _passwordVisible.value =
                                        !_passwordVisible.value;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (formStateKey.currentState.validate()) {
                          firebaseController.login(
                            emailController.text.trim(),
                            passwordContoller.text.trim(),
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Log In",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    Get.to(() => RegistrationPage());
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "First time here?",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: AppTheme.kBlack,
                        ),
                        children: [
                          TextSpan(
                            text: " Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0,
                              color: AppTheme.accentColor,
                            ),
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
