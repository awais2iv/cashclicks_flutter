import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login.dart';
import 'signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller= PageController();
  List<String> images = [
    'images/onboarding1.png',
    'images/onboarding2.png',
    'images/onboarding3.png',
  ];
  List<String> titles = [
    'Gain total control of your money',
    'Know where your money goes',
    'Planning Ahead'
  ];
  List<String> descriptions = [
    'Become your own money manager and make every cent count',
    'Track your transactions easily and get insights on your spending habits',
    'Setup your budget and plan your expenses ahead of time'
  ];
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: 500,
              child: PageView.builder(
                controller: _controller,
                itemCount: 3,
                itemBuilder: (context, index) => OnboardingPage(
                  image: images[index],
                  title: titles[index],
                  description: descriptions[index],
                ),

              )
            ),

          SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: Color.fromRGBO(44, 44, 44, 1),
                dotHeight: 12,
                dotWidth: 12,
              ),
          ),
          Container(
            width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Signup()),
                );
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
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 20),),
            ),

          ),


        ]),
      );
  }
}




class OnboardingPage extends StatelessWidget {

  final String image;
  final String title;
  final String description;

  const OnboardingPage({super.key, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Align(

      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,width: 300,height: 300,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(title, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(description,style: const TextStyle(fontSize: 15),),
          ),
        ],
      ),
    );
  }
}

