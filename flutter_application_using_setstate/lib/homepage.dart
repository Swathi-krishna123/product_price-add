import 'package:flutter/material.dart';
import 'package:flutter_application_using_setstate/customwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, TextEditingController>> _controllers = [];
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _addNewRow();
    super.initState();
  }

  void _addNewRow() {
    setState(() {
      _controllers.add({
        'productName': TextEditingController(),
        'productRate': TextEditingController(),
      });
    });
  }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var controllers in _controllers) {
      double price = double.tryParse(controllers['productRate']!.text) ?? 0.00;
      subtotal = subtotal + price;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey.withOpacity(0.2),
        elevation: 2,
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Home',
          style: GoogleFonts.aBeeZee(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _controllers.length,
                        itemBuilder: (context, index) {
                          final productNameController =
                              _controllers[index]['productName']!;
                          final productPriceController =
                              _controllers[index]['productRate']!;
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFormField(
                                  isProductName: true,
                                  labelText: 'Product Name',
                                  controller: productNameController,
                                ),
                                CustomTextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  onChanged: (value) {
                                    setState(() {}); // Update UI on rate change
                                  },
                                  isProductName: false,
                                  labelText: 'Price',
                                  controller: productPriceController,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        _controllers.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: SizedBox(
                    //     width: 70.0,
                    //     height: 70.0,
                    //     child: FloatingActionButton(
                    //       elevation: 8.0,
                    //       backgroundColor: Colors.blue[400],
                    //       onPressed: () async {
                    //         _addNewRow();
                    //       },
                    //       child: const Icon(
                    //         Icons.add,
                    //         color: Colors.white,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(50),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(0.10),
                          )),
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.20,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 73, 73, 73)),
                                  ),
                                  Text(
                                    '\$${calculateSubtotal().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color.fromARGB(255, 73, 73, 73)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.07,
                                decoration: BoxDecoration(
                                    color: Colors.blue[400],
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    'Place order',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 180.0,
                right: 15.0,
                child: FloatingActionButton(
                  elevation: 8.0,
                  backgroundColor: Colors.blue[400],
                  onPressed: _addNewRow,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}