import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Invoice Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InvoiceView(),
    );
  }
}

class Product {
  String name;
  int quantity;
  double rate;
  double amount;

  Product(this.name, this.quantity, this.rate) : amount = quantity * rate;
}

class InvoiceController extends GetxController {
  var customerID = '9YWS6HYE1'.obs;
  var customerName = 'Chiranjit Das'.obs;
  var address = 'Hasnabad'.obs;
  var contactNo = '8274827707'.obs;
  var products = <Product>[].obs;
  var cgst = 0.0.obs;
  var sgst = 0.0.obs;
  var netTotal = 0.0.obs;

  void addProduct(String name, int quantity, double rate) {
    products.add(Product(name, quantity, rate));
    calculateTotals();
  }

  void calculateTotals() {
    double totalAmount = products.fold(0.0, (sum, item) => sum + item.amount);
    cgst.value = totalAmount * 0.09;
    sgst.value = totalAmount * 0.09;
    netTotal.value = totalAmount + cgst.value + sgst.value;
  }
}

class InvoiceView extends StatelessWidget {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text('Customer ID: ${controller.customerID.value}')),
            Obx(() => Text('Customer Name: ${controller.customerName.value}')),
            Obx(() => Text('Address: ${controller.address.value}')),
            Obx(() => Text('Contact No: ${controller.contactNo.value}')),
            SizedBox(height: 20),
            Obx(() => Column(
                  children: controller.products.map((product) {
                    return Text(
                        '${product.name} - ${product.quantity} x ₹${product.rate} = ₹${product.amount}');
                  }).toList(),
                )),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add sample products
                  controller.addProduct('Bed', 1, 8474.58);
                  controller.addProduct('Chair', 2, 1200.00);
                  controller.addProduct("Table", 1, 4444.50);

                  generateInvoice();
                },
                child: Text('Generate Invoice PDF'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _loadAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  void generateInvoice() async {
    final pdf = pw.Document();
    final Uint8List image = await _loadAsset('assets/image/header.jpeg');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Positioned.fill(
                child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.cover),
              ),
              pw.Positioned(
                top: 120, // Adjust based on template
                left: 0,
                right: 0,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Original For Recipient',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('PROFORMA INVOICE',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text('PROFORMA INVOICE',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                  'Customer ID: ${controller.customerID.value}'),
                              pw.Text(
                                  'Customer Name: ${controller.customerName.value}'),
                              pw.Text('Address: ${controller.address.value}'),
                              pw.Text(
                                  'Contact No: ${controller.contactNo.value}'),
                              pw.Text('Buyer\'s GSTIN:'),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text('Proforma Invoice: SI/DT/2024-25/185'),
                              pw.Text('Order Date: 27-Jul-2024'),
                              pw.Text('Salesman ID: STLUM001'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.Divider(thickness: 1),
                    pw.SizedBox(height: 10),
                    pw.Table.fromTextArray(
                      context: context,
                      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      headers: <String>[
                        '#',
                        'Product',
                        'Quantity',
                        'Rate',
                        'Amount'
                      ],
                      data: List<List<String>>.generate(
                        controller.products.length,
                        (index) {
                          final product = controller.products[index];
                          return [
                            '${index + 1}',
                            product.name,
                            '${product.quantity}',
                            'INR ${product.rate}',
                            'INR ${product.amount}'
                          ];
                        },
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text('** Please Do Not Pay Any Tips To Anyone',
                        style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
                    pw.SizedBox(height: 10),
                    pw.Divider(thickness: 1),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Non-Taxable Amount:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('(+) CGST : 9%:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('(+) SGST : 9%:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Round Off:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('Net Total with GST:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                  '${controller.products.fold(0.0, (sum, item) => sum + item.amount)}'),
                              pw.Text('INR ${controller.cgst.value}'),
                              pw.Text('INR ${controller.sgst.value}'),
                              pw.Text('INR 0.00'),
                              pw.Text('INR ${controller.netTotal.value}',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Divider(thickness: 1),
                    pw.SizedBox(height: 10),
                    pw.Text('Bank Details',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('A/c Name: STEELAM INDUSTRIES'),
                              pw.Text('A/c No.: 50200078987439'),
                              pw.Text('Bank Name: HDFC Bank'),
                              pw.Text('IFSC Code: HDFC0000023'),
                              pw.Text('Branch: MADHYAMGRAM'),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.BarcodeWidget(
                                barcode: pw.Barcode.qrCode(),
                                data: 'https://www.steelamindustries.com',
                                width: 50,
                                height: 50,
                              ),
                              pw.SizedBox(height: 3),
                              pw.Text(
                                "Scan & Pay",
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 20),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('STEELAM INDUSTRIES',
                                  style: pw.TextStyle(fontSize: 10)),
                              pw.Text('Authorized Signature & Stamp',
                                  style: pw.TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Divider(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Invoice Generator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: InvoiceView(),
//     );
//   }
// }

// class Product {
//   String name;
//   int quantity;
//   double rate;
//   double amount;

//   Product(this.name, this.quantity, this.rate) : amount = quantity * rate;
// }

// class InvoiceController extends GetxController {
//   var customerID = '9YWS6HYE1'.obs;
//   var customerName = 'Chiranjit Das'.obs;
//   var address = 'Hasnabad'.obs;
//   var contactNo = '8274827707'.obs;
//   var products = <Product>[].obs;
//   var cgst = 0.0.obs;
//   var sgst = 0.0.obs;
//   var netTotal = 0.0.obs;

//   void addProduct(String name, int quantity, double rate) {
//     products.add(Product(name, quantity, rate));
//     calculateTotals();
//   }

//   void calculateTotals() {
//     double totalAmount = products.fold(0.0, (sum, item) => sum + item.amount);
//     cgst.value = totalAmount * 0.09;
//     sgst.value = totalAmount * 0.09;
//     netTotal.value = totalAmount + cgst.value + sgst.value;
//   }
// }

// class InvoiceView extends StatelessWidget {
//   final InvoiceController controller = Get.put(InvoiceController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Generator'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(() => Text('Customer ID: ${controller.customerID.value}')),
//             Obx(() => Text('Customer Name: ${controller.customerName.value}')),
//             Obx(() => Text('Address: ${controller.address.value}')),
//             Obx(() => Text('Contact No: ${controller.contactNo.value}')),
//             SizedBox(height: 20),
//             Obx(() => Column(
//                   children: controller.products.map((product) {
//                     return Text(
//                         '${product.name} - ${product.quantity} x ₹${product.rate} = ₹${product.amount}');
//                   }).toList(),
//                 )),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Add sample products
//                   controller.addProduct('Bed', 1, 8474.58);
//                   controller.addProduct('Chair', 2, 1200.00);
//                   controller.addProduct("Table", 1, 4444.50);

//                   generateInvoice();
//                 },
//                 child: Text('Generate Invoice PDF'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<Uint8List> _loadAsset(String path) async {
//     final ByteData data = await rootBundle.load(path);
//     return data.buffer.asUint8List();
//   }

//   void generateInvoice() async {
//     final pdf = pw.Document();
//     final Uint8List image = await _loadAsset('assets/image/header.jpeg');

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Stack(
//             children: [
//               pw.Positioned.fill(
//                 child: pw.Image(pw.MemoryImage(image), fit: pw.BoxFit.cover),
//               ),
//               pw.Positioned(
//                 top: 120, // Adjust based on template
//                 left: 0,
//                 right: 0,
//                 child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text('Original For Recipient',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                         pw.Text('PROFORMA INVOICE',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                         pw.Text('PROFORMA INVOICE',
//                             style:
//                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                       ],
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text(
//                                   'Customer ID: ${controller.customerID.value}'),
//                               pw.Text(
//                                   'Customer Name: ${controller.customerName.value}'),
//                               pw.Text('Address: ${controller.address.value}'),
//                               pw.Text(
//                                   'Contact No: ${controller.contactNo.value}'),
//                               pw.Text('Buyer\'s GSTIN:'),
//                             ],
//                           ),
//                         ),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.end,
//                             children: [
//                               pw.Text('Proforma Invoice: SI/DT/2024-25/185'),
//                               pw.Text('Order Date: 27-Jul-2024'),
//                               pw.Text('Salesman ID: STLUM001'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Table.fromTextArray(
//                       context: context,
//                       headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                       headers: <String>[
//                         '#',
//                         'Product',
//                         'Quantity',
//                         'Rate',
//                         'Amount'
//                       ],
//                       data: List<List<String>>.generate(
//                         controller.products.length,
//                         (index) {
//                           final product = controller.products[index];
//                           return [
//                             '${index + 1}',
//                             product.name,
//                             '${product.quantity}',
//                             'INR ${product.rate}',
//                             'INR ${product.amount}'
//                           ];
//                         },
//                       ),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Text('** Please Do Not Pay Any Tips To Anyone',
//                         style: pw.TextStyle(fontStyle: pw.FontStyle.italic)),
//                     pw.SizedBox(height: 10),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('Non-Taxable Amount:',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                               pw.Text('(+) CGST : 9%:',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                               pw.Text('(+) SGST : 9%:',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                               pw.Text('Round Off:',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                               pw.Text('Net Total with GST:',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                             ],
//                           ),
//                         ),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.end,
//                             children: [
//                               pw.Text(
//                                   '${controller.products.fold(0.0, (sum, item) => sum + item.amount)}'),
//                               pw.Text('INR ${controller.cgst.value}'),
//                               pw.Text('INR ${controller.sgst.value}'),
//                               pw.Text('INR 0.00'),
//                               pw.Text('INR ${controller.netTotal.value}',
//                                   style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Text('Bank Details',
//                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('A/c Name: STEELAM INDUSTRIES'),
//                               pw.Text('A/c No.: 50200078987439'),
//                               pw.Text('Bank Name: HDFC Bank'),
//                               pw.Text('IFSC Code: HDFC0000023'),
//                               pw.Text('Branch: MADHYAMGRAM'),
//                             ],
//                           ),
//                         ),
//                         pw.SizedBox(height: 10),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.BarcodeWidget(
//                                 barcode: pw.Barcode.qrCode(),
//                                 data: 'https://www.steelamindustries.com',
//                                 width: 50,
//                                 height: 50,
//                               ),
//                               pw.SizedBox(height: 3),
//                               pw.Text(
//                                 "Scan & Pay",
//                               ),
//                             ],
//                           ),
//                         ),
//                         pw.SizedBox(width: 20),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('STEELAM INDUSTRIES',
//                                   style: pw.TextStyle(fontSize: 10)),
//                               pw.Text('Authorized Signature & Stamp',
//                                   style: pw.TextStyle(fontSize: 10)),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Divider(),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Invoice Generator',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: InvoiceView(),
//     );
//   }
// }

// class Product {
//   String name;
//   int quantity;
//   double rate;
//   double amount;

//   Product(this.name, this.quantity, this.rate) : amount = quantity * rate;
// }

// class InvoiceController extends GetxController {
//   var customerID = '9YWS6HYE1'.obs;
//   var customerName = 'Chiranjit Das'.obs;
//   var address = 'Hasnabad'.obs;
//   var contactNo = '8274827707'.obs;
//   var products = <Product>[].obs;
//   var cgst = 0.0.obs;
//   var sgst = 0.0.obs;
//   var netTotal = 0.0.obs;

//   void addProduct(String name, int quantity, double rate) {
//     products.add(Product(name, quantity, rate));
//     calculateTotals();
//   }

//   void calculateTotals() {
//     double totalAmount = products.fold(0.0, (sum, item) => sum + item.amount);
//     cgst.value = totalAmount * 0.09;
//     sgst.value = totalAmount * 0.09;
//     netTotal.value = totalAmount + cgst.value + sgst.value;
//   }
// }

// class InvoiceView extends StatefulWidget {
//   @override
//   _InvoiceViewState createState() => _InvoiceViewState();
// }

// class _InvoiceViewState extends State<InvoiceView> {
//   final InvoiceController controller = Get.put(InvoiceController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Generator'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(() => Text('Customer ID: ${controller.customerID.value}')),
//             Obx(() => Text('Customer Name: ${controller.customerName.value}')),
//             Obx(() => Text('Address: ${controller.address.value}')),
//             Obx(() => Text('Contact No: ${controller.contactNo.value}')),
//             SizedBox(height: 20),
//             Obx(() => Column(
//                   children: controller.products.map((product) {
//                     return Text(
//                         '${product.name} - ${product.quantity} x ₹${product.rate} = ₹${product.amount}');
//                   }).toList(),
//                 )),
//             SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   print('Button pressed');
//                   // Add sample products
//                   controller.addProduct('Bed', 1, 8474.58);
//                   controller.addProduct('Chair', 2, 1200.00);
//                   controller.addProduct('Table', 1, 5000.00);
//                   controller.addProduct('Sofa', 1, 15000.00);
//                   controller.addProduct('Lamp', 2, 800.00);
//                   controller.addProduct('Bookshelf', 1, 7000.00);

//                   generateInvoice();
//                 },
//                 child: Text('Generate Invoice PDF'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void generateInvoice() async {
//     print('Generating invoice...');
//     final pdf = pw.Document();

//     // Load the image from assets
//     final ByteData bytes = await rootBundle.load('assets/image/header.jpeg');
//     final Uint8List imageData = bytes.buffer.asUint8List();

//     final image = pw.MemoryImage(imageData);

//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return [
//             pw.Stack(
//               children: [
//                 pw.Positioned.fill(
//                   child: pw.Image(image),
//                 ),
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.SizedBox(height: 120),
//                     pw.Divider(),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text(
//                           'Original For Recipient',
//                         ),
//                         pw.Text(
//                           'PROFORMA INVOICE',
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text(
//                                   'Customer ID: ${controller.customerID.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text(
//                                   'Customer Name: ${controller.customerName.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Address: ${controller.address.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text(
//                                   'Contact No: ${controller.contactNo.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Buyer\'s GSTIN:',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                             ],
//                           ),
//                         ),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('Proforma Invoice: SI/DT/2024-25/185',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Order Date: 27-Jul-2024',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Salesman ID: STLUM001',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Table.fromTextArray(
//                       context: context,
//                       headerStyle: pw.TextStyle(font: pw.Font.helveticaBold()),
//                       headers: <String>[
//                         '#',
//                         'Product',
//                         'Quantity',
//                         'Rate',
//                         'Amount'
//                       ],
//                       data: List<List<String>>.generate(
//                         controller.products.length,
//                         (index) {
//                           final product = controller.products[index];
//                           return [
//                             '${index + 1}',
//                             product.name,
//                             '${product.quantity}',
//                             '₹${product.rate}',
//                             '₹${product.amount}'
//                           ];
//                         },
//                       ),
//                     ),
//                     pw.SizedBox(height: 10),
//                     pw.Text('** Please Do Not Pay Any Tips To Anyone',
//                         style: pw.TextStyle(
//                             font: pw.Font.helvetica(),
//                             fontStyle: pw.FontStyle.italic)),
//                     pw.SizedBox(height: 10),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('Non-Taxable Amount:',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                               pw.Text('(+) CGST : 9%:',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                               pw.Text('(+) SGST : 9%:',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                               pw.Text('Round Off:',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                               pw.Text('Net Total with GST:',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                             ],
//                           ),
//                         ),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.end,
//                             children: [
//                               pw.Text(
//                                   '₹${controller.products.fold(0.0, (sum, item) => sum + item.amount)}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('₹${controller.cgst.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('₹${controller.sgst.value}',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('₹0.00',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('₹${controller.netTotal.value}',
//                                   style: pw.TextStyle(
//                                       font: pw.Font.helveticaBold())),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Text('Bank Details',
//                         style: pw.TextStyle(font: pw.Font.helveticaBold())),
//                     pw.SizedBox(height: 10),
//                     pw.Row(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             children: [
//                               pw.Text('A/c Name: STEELAM INDUSTRIES',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('A/c No.: 50200078987439',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Bank Name: HDFC Bank',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('IFSC Code: HDFC0000023',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                               pw.Text('Branch: MADHYAMGRAM',
//                                   style:
//                                       pw.TextStyle(font: pw.Font.helvetica())),
//                             ],
//                           ),
//                         ),
//                         pw.Expanded(
//                           child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.end,
//                             children: [
//                               pw.BarcodeWidget(
//                                 barcode: pw.Barcode.qrCode(),
//                                 data: 'https://www.steelamindustries.com',
//                                 width: 50,
//                                 height: 50,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     pw.SizedBox(height: 20),
//                     pw.Divider(thickness: 1),
//                     pw.SizedBox(height: 10),
//                     pw.Text(
//                         '**Note: Product will be delivered after full realization of payment.',
//                         style: pw.TextStyle(
//                             font: pw.Font.helvetica(),
//                             fontStyle: pw.FontStyle.italic)),
//                   ],
//                 ),
//               ],
//             ),
//           ];
//         },
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => pdf.save(),
//     );
//     print('Invoice generated.');
//   }
// }
