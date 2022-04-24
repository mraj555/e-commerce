import 'package:flutter/material.dart';
import 'package:project/fav_page.dart';
import 'package:project/order_page.dart';
import 'package:project/settings_page.dart';

import 'home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [Home(), const FavouritePage(), const OrderPage(), const SettingsPage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: size.width * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.4375,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            _currentIndex = 0;
                          },
                        );
                      },
                      child: Icon(Icons.home, size: 30, color: _currentIndex == 0 ? Colors.deepPurple : Colors.grey),
                      minWidth: size.width * 0.09,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            _currentIndex = 1;
                          },
                        );
                      },
                      child: Icon(Icons.favorite, size: size.width * 0.07, color: _currentIndex == 1 ? Colors.deepPurple : Colors.grey),
                      minWidth: 40,
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.4375,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            _currentIndex = 2;
                          },
                        );
                      },
                      child: Icon(Icons.reorder,size: size.width * 0.07, color: _currentIndex == 2 ? Colors.deepPurple : Colors.grey),
                      minWidth: 40,
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            _currentIndex = 3;
                          },
                        );
                      },
                      child: Icon(Icons.settings,size: size.width * 0.07, color: _currentIndex == 3 ? Colors.deepPurple : Colors.grey),
                      minWidth: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.grey[300],
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
