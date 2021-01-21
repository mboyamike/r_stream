import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/screens/sign_in_page.dart';
import 'package:r_stream/controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('R Stream'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return 'please enter your Email';
              if (!value.isEmail) return 'Please enter a valid email';
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'example@gmail.com',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value.isNumericOnly || value.isAlphabetOnly)
                return 'Mix letters, numbers and symbols to make your password stronger';
              if (value.length < 8)
                return 'Password should be longer than 8 characters';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) return 'Please confirm your password';
              if (value != _passwordController.text)
                return 'Does not match password';
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Confirm Password',
            ),
          ),
          SizedBox(
            height: 32,
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Get.snackbar(
                  'Signing Up',
                  'Please Wait as we sign you Up',
                  snackPosition: SnackPosition.BOTTOM,
                );
                _authController.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
            },
            color: Colors.blue,
            child: Text(
              'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Already have an Account"),
              FlatButton(
                onPressed: () {
                  Get.off(SignInPage());
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
