import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/product_page.dart';

import 'product_details.dart' as data;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = FirebaseAuth.instance.currentUser;

  List<String> items = ['Shoes', 'Watch', 'Backpack'];

  List<String> images = ['sneakers.png', 'watch.png', 'backpack.png'];
  var isFavourite = List.generate(data.shoes.length, (index) => false);
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xfff7f6f6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(left: size.width * 0.03),
          child: Image.asset('assets/logo.png', width: size.width * 0.1),
        ),
        toolbarHeight: size.width * 0.2,
        title: Text(
          'E-com',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: size.width * 0.08,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(size.width * 0.03, 0, size.width * 0.03, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Our Product',
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: size.width * 0.08, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                items.length,
                (index) => InkWell(
                  onTap: () {
                    setState(
                      () {
                        currentIndex = index;
                      },
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: currentIndex == index ? 15 : 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: size.width * 0.25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/Items/' + images[index],
                            ),
                            Text(
                              items[index],
                              style: GoogleFonts.notoSerif(
                                color: currentIndex == index ? Colors.deepPurple : Colors.black,
                                fontWeight: currentIndex == index ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: data.shoes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 5, childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            colors: data.shoes[index]['Colors'],
                            isFavourite: isFavourite[index],
                            items: data.shoes[index]['Products'],
                            title: data.shoes[index]['Title'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      isFavourite[index] = !isFavourite[index];
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: isFavourite[index] == true ? Colors.red : Colors.transparent,
                                  child: Icon(
                                    Icons.favorite,
                                    color: isFavourite[index] == true ? Colors.white : Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 70,
                                      backgroundColor: data.shoes[index]['BackgroundColor'].withOpacity(0.5),
                                      child: CircleAvatar(
                                        radius: 60,
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                                        ),
                                        backgroundColor: data.shoes[index]['BackgroundColor'].withOpacity(0.01),
                                      ),
                                    ),
                                    Image.network(data.shoes[index]['ThumbnailURL'], width: size.width * 0.4),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  data.shoes[index]['Title'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.notoSerif(color: Colors.deepPurple),
                                ),
                                SizedBox(height: 10),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(text: '\$', style: GoogleFonts.notoSerif(color: Colors.deepPurple), children: [
                                    TextSpan(text: '${data.shoes[index]['Products']['0']['Price']}', style: GoogleFonts.notoSerif(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20)),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
