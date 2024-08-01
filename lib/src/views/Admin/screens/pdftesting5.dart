// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data';

// void main() {
//   runApp(MaterialApp(home: InvoiceScreen()));
// }

// class InvoiceScreen extends StatelessWidget {
//   const InvoiceScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Generate Invoice PDF'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.print),
//             onPressed: () async {
//               // Load the image asynchronously
//               Uint8List imageData = await networkImage(
//                   'https://api.qrserver.com/v1/create-qr-code/?data=Example');

//               // Generate PDF with the loaded image
//               await Printing.layoutPdf(
//                 onLayout: (PdfPageFormat format) async {
//                   final pdf = pw.Document();
//                   pdf.addPage(
//                     pw.Page(
//                       build: (context) => pw.Container(
//                         padding: pw.EdgeInsets.all(16.0),
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Row(
//                               mainAxisAlignment:
//                                   pw.MainAxisAlignment.spaceBetween,
//                               children: [
//                                 pw.Text("Original For Recipient",
//                                     style: pw.TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: pw.FontWeight.bold)),
//                                 pw.Text("PROFORMA INVOICE",
//                                     style: pw.TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: pw.FontWeight.bold)),
//                               ],
//                             ),
//                             pw.Divider(thickness: 1, color: PdfColors.black),
//                             pw.Row(
//                               mainAxisAlignment:
//                                   pw.MainAxisAlignment.spaceBetween,
//                               children: [
//                                 pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Text("Customer ID: 9YWS6HYEA1"),
//                                     pw.Text("Customer Name: Chiranjit Das"),
//                                     pw.Text("Address: Hasnabad"),
//                                     pw.Text("Contact No: 8274827707"),
//                                     pw.Text("Buyer's GSTIN: "),
//                                   ],
//                                 ),
//                                 pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Text(
//                                         "Proforma Invoice: SI/DT/2024-25/185"),
//                                     pw.Text("Order Date: 27-Jul-2024"),
//                                     pw.Text("Salesman ID: STLM0001"),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             pw.Divider(thickness: 1, color: PdfColors.black),
//                             pw.Table(
//                               border:
//                                   pw.TableBorder.all(color: PdfColors.black),
//                               columnWidths: {
//                                 0: pw.FlexColumnWidth(0.5),
//                                 1: pw.FlexColumnWidth(2),
//                                 2: pw.FlexColumnWidth(1),
//                                 3: pw.FlexColumnWidth(1),
//                                 4: pw.FlexColumnWidth(1),
//                               },
//                               children: [
//                                 pw.TableRow(
//                                   children: [
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("#",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("Product",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("Quantity",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("Rate",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("Amount",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                   ],
//                                 ),
//                                 pw.TableRow(
//                                   children: [
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("1"),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("Bed"),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("1"),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("₹8474.58"),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text("₹8474.58"),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             pw.Table(
//                               border:
//                                   pw.TableBorder.all(color: PdfColors.black),
//                               columnWidths: {
//                                 0: pw.FlexColumnWidth(2.5),
//                                 1: pw.FlexColumnWidth(1),
//                               },
//                               children: [
//                                 pw.TableRow(
//                                   children: [
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Text(
//                                           "** Please Do Not Pay Any Tips To Anyone",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                     ),
//                                     pw.Padding(
//                                       padding: pw.EdgeInsets.all(8.0),
//                                       child: pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text(
//                                               "Non-Taxable Amount: ₹8474.58"),
//                                           pw.Text("(+) CGST : 9% : ₹762.71"),
//                                           pw.Text("(+) SGST : 9% : ₹762.71"),
//                                           pw.Text("Round Off (-) : ₹0.00"),
//                                           pw.Text("Net Total with : ₹10000",
//                                               style: pw.TextStyle(
//                                                   fontWeight:
//                                                       pw.FontWeight.bold)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             pw.Divider(thickness: 1, color: PdfColors.black),
//                             pw.Row(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Expanded(
//                                   child: pw.Column(
//                                     crossAxisAlignment:
//                                         pw.CrossAxisAlignment.start,
//                                     children: [
//                                       pw.Text("Bank Details",
//                                           style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold)),
//                                       pw.Text("A/c Name : STEELAM INDUSTRIES"),
//                                       pw.Text("A/c No. : 50200078987439"),
//                                       pw.Text("Bank Name : HDFC Bank"),
//                                       pw.Text("IFSC Code : HDFC0000023"),
//                                       pw.Text("Branch : MADHYAMGRAM"),
//                                     ],
//                                   ),
//                                 ),
//                                 pw.Column(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.center,
//                                   children: [
//                                     pw.Container(
//                                       width: 100,
//                                       height: 100,
//                                       child:
//                                           pw.Image(pw.MemoryImage(imageData)),
//                                     ),
//                                     pw.Text("Scan To Pay",
//                                         style: pw.TextStyle(
//                                             fontWeight: pw.FontWeight.bold)),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             pw.Divider(thickness: 1, color: PdfColors.black),
//                             pw.Center(
//                               child: pw.Text(
//                                 "STEELAM INDUSTRIES\nAuthorized Signature & Stamp",
//                                 textAlign: pw.TextAlign.center,
//                                 style: pw.TextStyle(
//                                     fontWeight: pw.FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                   return pdf.save();
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Click the print icon to generate the PDF'),
//       ),
//     );
//   }

//   Future<Uint8List> networkImage(String url) async {
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       return response.bodyBytes;
//     } else {
//       throw Exception('Failed to load image');
//     }
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Scaffold(body: MyCustomTable())));
}

class MyCustomTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          // First Table
          Container(
            width: 100.0,
            color: Colors.cyan,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FixedColumnWidth(50.0),
                1: FixedColumnWidth(50.0),
              },
              children: [
                TableRow(children: [
                  Container(
                    color: Colors.green,
                    height: 50.0,
                    child: const Text(
                        "1111111111111111111111111111111111111111111"),
                  ),
                  Container(
                    color: Colors.red,
                    height: 50.0,
                    child: const Text("2"),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: Colors.deepPurple,
                    height: 50.0,
                    child: const Text("5"),
                  ),
                  Container(
                    color: Colors.cyan,
                    height: 50.0,
                    child: const Text("6"),
                  ),
                ]),
                TableRow(children: [
                  Container(
                    color: Colors.amberAccent,
                    height: 50.0,
                    child: const Text("7"),
                  ),
                  Container(
                    color: Colors.black87,
                    height: 50.0,
                    child: const Text("8"),
                  ),
                ]),
              ],
            ),
          ),
          // Second Table
          Container(
            width: 100.0,
            color: Colors.cyan,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(0.7),
                1: FlexColumnWidth(0.3),
              },
              children: [
                TableRow(children: [
                  Container(
                    color: Colors.green,
                    height: 50.0,
                    child: const Text(
                        "1111111111111111111111111111111111111111111"),
                  ),
                  Container(
                    color: Colors.red,
                    height: 50.0,
                    child: const Text("2"),
                  ),
                ]),
                // Simulating a rowspan by using a Column inside a TableCell
                TableRow(children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.fill,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.deepPurple,
                          height: 50.0,
                          child: const Text("5"),
                        ),
                        Container(
                          color: Colors.deepPurple,
                          height: 50.0,
                          child: const Text("5 again"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.cyan,
                    height: 100.0, // double height for rowspan effect
                    child: const Text("6"),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
