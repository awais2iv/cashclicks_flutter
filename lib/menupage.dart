import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'addamount.dart';
import 'settings.dart';
import 'transactions.dart';
import 'homepage.dart';
import 'reciept.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //list of widgets showing different screens
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  final List<Widget> _children = [
    const Homepage(),
    const TransactionScreen(),
    const AddAmount(),
     const Settings(),
  ];
  int index = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              this.index = index;
            });
          },
          itemCount: _children.length,
          itemBuilder: (context, index) {
            return _children[index];
          },
        ),
        bottomNavigationBar: SafeArea(
          child: GNav(
            curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 300),
              gap: 8,
                tabs:[
                  GButton(
                    text: 'Home',
                    backgroundColor: Colors.deepPurple.withOpacity(0.2),
                      icon: Icons.home,
                      iconActiveColor: Colors.deepPurple,
                  ),

                  GButton(
                      text: 'List',
                      backgroundColor: Colors.deepPurple.withOpacity(0.2),
                      icon: Icons.list,
                    iconActiveColor: Colors.deepPurple),
                  GButton(
                      text: 'Add',
                    backgroundColor: Colors.deepPurple.withOpacity(0.2),
                      icon: Icons.payment,
                    iconActiveColor: Colors.deepPurple,),
                  GButton(
                      text: 'Settings',
                      backgroundColor: Colors.deepPurple.withOpacity(0.2),
                      icon: Icons.settings,
                    iconActiveColor: Colors.deepPurple,),
                ],
                selectedIndex: index,
                onTabChange: (index) {
                  setState(() {
                    this.index = index;
                    _pageController.jumpToPage(index);
                  });
                },
          ),
          ),
        ),
    );
  }
}
