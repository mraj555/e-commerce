import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Internet_Connection/connectivity_provider.dart';
import 'package:project/Internet_Connection/no_internet.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CarouselController controller = CarouselController();
  int isSelected = 0;
  int carouselindex = 0;
  Map<String, dynamic> item = {};
  Map<String, dynamic> variety = {};
  DocumentReference documentreference = FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email);

  @override
  void initState() {
    item = widget.product;
    variety = widget.product['Products']['0'];
    print(item);
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer<ConnectivityProvider>(
          builder: (context, model, child) {
            if (model.isOnline != null) {
              return model.isOnline
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              // color: Colors.yellow,
                              padding: EdgeInsets.fromLTRB(size.width * 0.02, size.width * 0.02, size.width * 0.05, size.width * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                  ),
                                  StreamBuilder(
                                    stream: documentreference.collection('Favourite').where('Title', isEqualTo: item['Title']).snapshots(),
                                    builder: (context, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (snapshot.data.docs.length == 0) {
                                              Map<String, dynamic> productData = {
                                                'Title': item['Title'],
                                                'Rating': item['Ratings'],
                                                'BackgroundColor': item['BackgroundColor'].toString(),
                                                'Unit': item['Unit'],
                                                'Colors': item['Colors'].toString(),
                                                'Description': item['Description'],
                                                'Image': item['ThumbnailURL'],
                                                'Products': item['Products'],
                                                'Price': item['Products']['0']['Price'],
                                              };
                                              await documentreference.collection('Favourite').doc(item['Title']).set(productData);
                                            }
                                            if (snapshot.data.docs.length != 0) {
                                              documentreference.collection('Favourite').doc(item['Title']).delete();
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: snapshot.data.docs.length != 0 ? Colors.red : Colors.transparent,
                                            child: Icon(
                                              Icons.favorite,
                                              color: snapshot.data.docs.length != 0 ? Colors.white : Colors.grey,
                                              size: size.width * 0.05,
                                            ),
                                          ),
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  )
                                ],
                              ),
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                CarouselSlider.builder(
                                  itemCount: variety['Images'].length,
                                  itemBuilder: (context, itemindex, pageviewindex) => Container(
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: variety['Images'][itemindex],
                                      width: size.width * 0.4,
                                      placeholder: (context, url) => Lottie.asset('assets/94423-jelly-loading.json'),
                                    ),
                                  ),
                                  carouselController: controller,
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    height: size.height / 2.4,
                                    aspectRatio: 16 / 9,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    initialPage: 0,
                                    onPageChanged: (cr_index, reason) {
                                      setState(
                                        () {
                                          carouselindex = cr_index;
                                        },
                                      );
                                    },
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                DotsIndicator(
                                  dotsCount: variety['Images'].length,
                                  position: carouselindex.toDouble(),

                                ),
                                Container(
                                  height: size.height / 2.3,
                                  padding: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.07, size.width * 0.05, size.width * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['Title'],
                                        style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                                      ),
                                      variety['Size'] != null && item['Unit'] != null
                                          ? Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text('Size : '),
                                                Expanded(
                                                  child: Container(
                                                    height: size.width * 0.09,
                                                    child: ListView(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      children: List.generate(
                                                        variety['Size'].length,
                                                        (index) => InkWell(
                                                          onTap: () {
                                                            setState(
                                                              () {
                                                                isSelected = index;
                                                              },
                                                            );
                                                          },
                                                          child: Card(
                                                            shadowColor: Colors.transparent,
                                                            color: isSelected == index ? Colors.lightBlueAccent.shade100 : Colors.transparent,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                            ),
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              padding: EdgeInsets.symmetric(vertical: size.width * 0.012, horizontal: size.width * 0.019),
                                                              child: Text(
                                                                ' ${item['Unit']} ${variety['Size'][index]}',
                                                                style: const TextStyle(fontWeight: FontWeight.w600),
                                                              ),
                                                              constraints: BoxConstraints(
                                                                minWidth: size.width * 0.145,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Available Color : '),
                                          Expanded(
                                            child: Container(
                                              height: size.width * 0.12,
                                              child: ListView(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                children: List.generate(
                                                  item['Colors'].length,
                                                  (index) {
                                                    print(item['Colors'][index].runtimeType);
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            variety = item['Products']['${index}'];
                                                          },
                                                        );
                                                      },
                                                      child: Container(
                                                        height: size.width * 0.085,
                                                        width: size.width * 0.085,
                                                        margin: EdgeInsets.symmetric(horizontal: size.width * 0.019),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: item['Colors'][index] is! List<Color> ? item['Colors'][index] : null,
                                                          border: Border.all(color: Colors.white),
                                                          gradient: item['Colors'][index] is List<Color>
                                                              ? LinearGradient(
                                                                  begin: Alignment.topLeft,
                                                                  end: Alignment.bottomRight,
                                                                  stops: [0.5, 0.5],
                                                                  colors: item['Colors'][index],
                                                                )
                                                              : null,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            height: size.width * 0.2,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text('\$ '),
                                    Text(
                                      variety['Price'],
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
                                    ),
                                  ],
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[100],
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: size.width * 0.02, horizontal: size.width * 0.03)),
                                  icon: Icon(Icons.shopping_cart, color: Colors.lightBlue),
                                  label: Text(
                                    'Add To Cart',
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const NoInternet();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
