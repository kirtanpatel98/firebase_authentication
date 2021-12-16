import 'package:firebase_authentication/data/constants/size_constants.dart';
import 'package:firebase_authentication/data/controllers/firebase_controller.dart';
import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:firebase_authentication/screens/auth/controllers/registration_controller.dart';
import 'package:firebase_authentication/utils/validators.dart';
import 'package:firebase_authentication/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController;
  TextEditingController dateOfBirthController;
  TextEditingController passwordController;
  TextEditingController confirmPasswordController;

  final RegistrationController registrationController =
      Get.put<RegistrationController>(RegistrationController());
  final FirebaseController firebaseController = Get.find<FirebaseController>();
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);

  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  final FocusScopeNode _focusNode = FocusScopeNode();

  String _validatePassword(String value) {
    if (passwordController.text != confirmPasswordController.text) {
      return "Password does not match";
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    dateOfBirthController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    [
      emailController,
      dateOfBirthController,
      passwordController,
      confirmPasswordController,
    ].forEach((controller) {
      controller.dispose();
    });
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppTheme.kBlack,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Spacer(),
              Form(
                key: formStateKey,
                child: FocusScope(
                  node: _focusNode,
                  child: ListView(
                    padding: const EdgeInsets.all(SizeConstant.kDefaultPadding),
                    shrinkWrap: true,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'SIGN UP',
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
                        autofillHints: [AutofillHints.email],
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        onEditingComplete: _focusNode.nextFocus,
                        controller: dateOfBirthController,
                        validator: Validator.validatePassword,
                        style: const TextStyle(color: AppTheme.kBlack),
                        onTap: () {
                          registrationController.pickDate(
                            context: context,
                            firstDate: DateTime(1800),
                            textController: dateOfBirthController,
                          );
                        },
                        decoration: InputDecoration(
                          labelText: "BirthDate",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      ValueListenableBuilder(
                        valueListenable: _showPassword,
                        builder:
                            (BuildContext context, bool value, Widget child) {
                          return TextFormField(
                            onEditingComplete: _focusNode.nextFocus,
                            controller: passwordController,
                            validator: Validator.validatePassword,
                            style: const TextStyle(color: AppTheme.kBlack),
                            obscureText: !value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15.0),
                      ValueListenableBuilder(
                        valueListenable: _showPassword,
                        builder:
                            (BuildContext context, bool value, Widget child) {
                          return TextFormField(
                            onEditingComplete: _focusNode.nextFocus,
                            controller: confirmPasswordController,
                            validator: _validatePassword,
                            style: const TextStyle(color: AppTheme.kBlack),
                            obscureText: !value,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showPassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppTheme.kBlack,
                                ),
                                onPressed: () {
                                  _showPassword.value = !_showPassword.value;
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
                  Obx(
                    () => CartButton(
                      title: "Sign up",
                      height: 60.0,
                      width: Get.width / 2,
                      isLoading: firebaseController.regLoader.value,
                      onTap: () {
                        if (formStateKey.currentState.validate()) {
                          firebaseController.createUser(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            dateOfBirth: dateOfBirthController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Flexible(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an Account?",
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: AppTheme.kBlack,
                        ),
                        children: [
                          TextSpan(
                            text: " Login",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
