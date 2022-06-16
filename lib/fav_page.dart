import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff7f6f6),
        body: StreamBuilder<QuerySnapshot>(
          stream: documentReference.collection('Favourite').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02,vertical: size.width * 0.05),
                child: GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 5, childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, size.width * 0.05, size.width * 0.05, 0),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: documentReference.collection('Favourite').snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    return GestureDetector(
                                      onTap: () async {
                                          documentReference.collection('Favourite').doc(snapshot.data!.docs[index]['Title']).delete();
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: snapshot.data!.docs.length != 0 ? Colors.red : Colors.transparent,
                                        child: Icon(
                                          Icons.favorite,
                                          color: snapshot.data!.docs.length != 0 ? Colors.white : Colors.grey,
                                          size: size.width * 0.05,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
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
                                      radius: size.width * 0.17,
                                      backgroundColor: Color(int.parse(snapshot.data!.docs[index]['BackgroundColor'])).withOpacity(0.5),
                                      child: CircleAvatar(
                                        radius: size.width * 0.14,
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.transparent, shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                                        ),
                                        backgroundColor: Color(int.parse(snapshot.data!.docs[index]['BackgroundColor'])).withOpacity(0.01),
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: snapshot.data!.docs[index]['Image'],
                                      width: size.width * 0.4,
                                      placeholder: (context, url) => Lottie.asset('assets/97952-loading-animation-blue.json', width: size.width * 0.4),
                                    ), /* 0.4 - Shoes , 0.25 - Watches */
                                  ],
                                ),
                                SizedBox(height: size.width * 0.05),
                                Text(
                                  snapshot.data!.docs[index]['Title'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.notoSerif(color: Colors.deepPurple),
                                ),
                                SizedBox(height: size.width * 0.02),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(text: '\$', style: GoogleFonts.notoSerif(color: Colors.deepPurple), children: [
                                    TextSpan(text: '${snapshot.data!.docs[index]['Products']['0']['Price']}', style: GoogleFonts.notoSerif(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: size.width * 0.05)),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
