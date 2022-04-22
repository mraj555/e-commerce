import 'package:flutter/material.dart';
import 'package:project/Internet_Connection/connectivity_provider.dart';
import 'package:project/Internet_Connection/no_internet.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  late bool isFavourite;
  final Map<String, dynamic> items;
  final String title;
  final String? unit;
  final colors;

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
                                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
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
                                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          widget.isFavourite = !widget.isFavourite;
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: widget.isFavourite == true ? Colors.red : Colors.transparent,
                                      child: Icon(
                                        Icons.favorite,
                                        color: widget.isFavourite == true ? Colors.white : Colors.grey,
                                        size: 20,
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
                                children: List.generate(product['Images'].length, (index) => Image.network(product['Images'][index])),
                              ),
                            ),
                            Container(
                              height: 600,
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.title,
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  product['Size'] != null && widget.unit != null ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Text('Size : '),
                                      Expanded(
                                        child: Container(
                                          height: 40,
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
                                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                                    child: Text(
                                                      ' ${widget.unit} ${product['Size'][index]}',
                                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                                    ),
                                                    constraints: const BoxConstraints(
                                                      minWidth: 60,
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
                                          height: 50,
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
                                                    height: 35,
                                                    width: 35,
                                                    margin: EdgeInsets.symmetric(horizontal: 8),
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
                            height: 80,
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
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
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
