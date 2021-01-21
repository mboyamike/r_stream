import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:r_stream/controllers/auth_controller.dart';
import 'package:r_stream/screens/sign_up_page.dart';

class SignInPage extends StatelessWidget {
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
                'Sign In',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 32,
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Get.snackbar(
                  'Signing In',
                  'Please Wait as we sign you in',
                  snackPosition: SnackPosition.BOTTOM,
                );
                _authController.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }

            },
            color: Colors.blue,
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Don't have an Account"),
              FlatButton(
                onPressed: () {
                  Get.off(SignUpPage());
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
