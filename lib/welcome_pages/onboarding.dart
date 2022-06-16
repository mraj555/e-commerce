import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project/user_details/decision_tree.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  var index = 0.0;

  @override
  void initState() {
    pageController.addListener(
      () {
        setState(() {
          index = pageController.page!;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: pageController,
              children: [
                titleContainer(
                  imageUrl: 'https://assets7.lottiefiles.com/packages/lf20_5ngs2ksb.json',
                  size: size,
                  subtitle: 'Explore Your Favourite Products That You Want To Buy Easily.',
                  title: 'DISCOVER',
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                ),
                titleContainer(
                  imageUrl: 'https://assets10.lottiefiles.com/packages/lf20_ntwucvqz.json',
                  size: size,
                  subtitle: 'Add The Product You Want To Buy Into Cart.',
                  title: 'ADD TO CART',
                  color: Colors.amber,
                  textColor: Colors.black,
                ),
                titleContainer(
                  imageUrl: 'https://assets1.lottiefiles.com/private_files/lf30_sM28Fo.json',
                  size: size,
                  subtitle: 'Choose The Preferable Option Of Payment.',
                  title: 'MAKE THE PAYMENT',
                  color: Colors.greenAccent,
                  textColor: Colors.black,
                ),
                titleContainer(
                  imageUrl: 'https://assets7.lottiefiles.com/packages/lf20_pk38qx3u.json',
                  size: size,
                  subtitle: 'Your Product is Delivered To Your Home Safely And Securely.',
                  title: 'DELIVERY',
                  color: Colors.orange,
                  textColor: Colors.white,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.02, top: size.height * 0.01),
                child: TextButton(
                  onPressed: () {
                    pageController.animateToPage(3, duration: const Duration(milliseconds: 1000), curve: Curves.ease);
                  },
                  child: Text(
                    'SKIP',
                    style: GoogleFonts.roboto(color: index == 1.0 || index == 2.0 ? Colors.black : Colors.white, fontSize: size.width * 0.04),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.07, bottom: size.height * 0.07),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.5),
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.04, right: size.width * 0.08),
                child: InkWell(
                  onTap: () {
                    if (index != 3.0) {
                      pageController.nextPage(duration: const Duration(milliseconds: 50), curve: Curves.fastLinearToSlowEaseIn);
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DecisionTree()));
                    }
                  },
                  child: CircleAvatar(
                    radius: size.width / 9.5,
                    backgroundColor: Colors.white,
                    child: Text(
                      index == 3.0 ? 'Get Started' : 'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: index == 0.0
                              ? Colors.deepOrange
                              : index == 1.0
                                  ? Colors.amber
                                  : index == 2.0
                                      ? Colors.greenAccent
                                      : Colors.orange,
                          fontSize: size.width * 0.04),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  titleContainer({
    required String imageUrl,
    required var size,
    required String subtitle,
    required String title,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: color,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: size.height * 0.035, top: size.height * 0.07, right: size.width * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: size.width * 0.08),
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: textColor, fontSize: size.width * 0.035),
                  ),
                ],
              ),
            ),
          ),
          Lottie.network(imageUrl, width: size.width),
        ],
      ),
    );
  }
}
