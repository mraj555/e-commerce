import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/Internet_Connection/connectivity_provider.dart';
import 'package:project/Internet_Connection/no_internet.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  late bool isFavourite;
  final Map<String, dynamic> items;
  final String title;
  final String? unit;
  final List colors;

  ProductPage({Key? key,required this.unit, required this.isFavourite, required this.items, required this.title, required this.colors}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  PageController controller = PageController();
  int isSelected = 0;
  Map<String, dynamic> product = {};

  @override
  void initState() {
    product = widget.items['0'];
    print(product);
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
                  ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(size.width * 0.02, size.width * 0.05, 0, 0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, size.width * 0.05, size.width * 0.05, 0),
                            child: GestureDetector(
                              onTap: () {
                                setState(
                                      () {
                                    widget.isFavourite = !widget.isFavourite;
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: size.width * 0.04,
                                backgroundColor: widget.isFavourite == true ? Colors.red : Colors.transparent,
                                child: Icon(
                                  Icons.favorite,
                                  color: widget.isFavourite == true ? Colors.white : Colors.grey,
                                  size: size.width * 0.05,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: size.height / 2.4,
                        child: PageView(
                          controller: controller,
                                children: List.generate(
                                  product['Images'].length,
                                  (index) => CachedNetworkImage(
                                    imageUrl: product['Images'][index],
                                      placeholder: (context, url) => Lottie.asset('assets/94423-jelly-loading.json'),
                                  ),
                                ),
                              ),
                      ),
                      Container(
                        height: 600,
                        padding: EdgeInsets.fromLTRB(size.width * 0.05, size.width * 0.07, size.width * 0.05, size.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
                            ),
                            product['Size'] != null && widget.unit != null ? Row(
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
                                        product['Size'].length,
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
                                                ' ${widget.unit} ${product['Size'][index]}',
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
                            ) : const SizedBox(),
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
                                        widget.colors.length,
                                            (index) {
                                          print(widget.colors[index].runtimeType);
                                          return GestureDetector(
                                            onTap: () {
                                              setState(
                                                    () {
                                                  product = widget.items['${index}'];
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: size.width * 0.085,
                                              width: size.width * 0.085,
                                              margin: EdgeInsets.symmetric(horizontal: size.width * 0.019),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: widget.colors[index] is! List<Color> ? widget.colors[index] : null,
                                                border: Border.all(color: Colors.white),
                                                gradient: widget.colors[index] is List<Color>
                                                    ? LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  stops: [0.5, 0.5],
                                                  colors: widget.colors[index],
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
                                product['Price'],
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
