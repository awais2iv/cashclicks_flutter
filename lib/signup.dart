import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'onboarding.dart';
import 'firebase_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  String email = '';
  String password = '';
  String firstname = '';

  void register() async {
    if (_formKey.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;
      firstname = firstnameController.text;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);

        await _firebaseService.UserDetails(firstname, email);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Onboarding()));

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Registered Successfully')));

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The password provided is too weak.')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('The account already exists for that email.')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('An error occurred')));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text("Sign Up"),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: <Widget>[
                Container(
                padding: const EdgeInsets.only(bottom: 25),
                child: const Text('Register an account', style: TextStyle(fontSize: 30, fontFamily: 'calibri', fontWeight: FontWeight.bold)),
              ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  // Added horizontal padding
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter First Name';
                      }
                      return null;
                    },
                    controller: firstnameController,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'First Name',
                      hintText: 'Enter your first name',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  // Added horizontal padding
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Email Address';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  // Added horizontal padding
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration:  InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color.fromRGBO(198, 124, 75, 1)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Already on our platform?',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('Sign in instead', style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}






