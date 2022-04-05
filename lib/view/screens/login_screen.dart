import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/view_models/auth_vm.dart';
import '../../utils/validator.dart';
import '../widgets/custom_button.dart';
import '../widgets/password_input_field.dart';
import '../widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emailTextField(),
                const SizedBox(height: 10),
                passwordTextField(),
                const SizedBox(height: 20),
                authVM.getIsLoading
                    ? const CircularProgressIndicator()
                    : loginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextInputField(
      labelText: 'Email Address',
      controller: _emailController,
      inputAction: TextInputAction.next,
      inputType: TextInputType.emailAddress,
      validator: Validator.email,
    );
  }

  Widget passwordTextField() {
    return PasswordInputField(
      labelText: 'Password',
      controller: _passwordController,
      inputAction: TextInputAction.done,
      validator: Validator.password,
      obscureText: _showPassword,
      toggle: () => setState(() => _showPassword = !_showPassword),
    );
  }

  Widget loginButton() {
    return CustomButton(
      action: 'Login',
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await Provider.of<AuthVM>(context, listen: false).login(
            username: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
        }
      },
    );
  }
}
