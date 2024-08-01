import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Proforma Invoice')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              header(),
              SizedBox(height: 10),
              customerDetails(),
              Divider(),
              productTable(),
              SizedBox(height: 10),
              notice(),
              SizedBox(height: 10),
              totals(),
              Divider(),
              bankDetails(),
              SizedBox(height: 20),
              signatureSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Text('PROFORMA INVOICE',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
  }

  Widget customerDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer ID: 9YWS6HYEA1'),
        Text('Customer Name: Chiranjit Das'),
        Text('Address: Hasnabad'),
        Text('Contact No: 8274827707'),
        Text('Buyer\'s GSTIN: '),
        Text('Proforma Invoice: SI/DT/2024-25/185'),
        Text('Order Date: 27-Jul-2024'),
        Text('Salesman ID: STLM0001'),
      ],
    );
  }

  Widget productTable() {
    return Table(
      border: TableBorder.all(),
      columnWidths: {
        0: FixedColumnWidth(40),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(100),
        3: FixedColumnWidth(100),
        4: FixedColumnWidth(100),
      },
      children: [
        TableRow(children: [
          Text('#', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Product', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Rate', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
        ]),
        TableRow(children: [
          Text('1'),
          Text('Bed'),
          Text('1'),
          Text('₹8474.58'),
          Text('₹8474.58'),
        ]),
      ],
    );
  }

  Widget notice() {
    return Text('** Please Do Not Pay Any Tips To Anyone');
  }

  Widget totals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Non-Taxable Amount ₹8474.58'),
        Text('(+) CGST: 9% ₹762.71'),
        Text('(+) SGST: 9% ₹762.71'),
        Text('Round Off (-) ₹0.00'),
        Text('Net Total with ₹10000'),
      ],
    );
  }

  Widget bankDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bank Details'),
        Text('A/C Name: STEELAM INDUSTRIES'),
        Text('A/C No.: 50200078987439'),
        Text('Bank Name: HDFC Bank'),
        Text('IFSC Code: HDFC0000023'),
        Text('Branch: MADHYAMGRAM'),
        // Insert Image.asset('assets/qr_code.png') here for the QR code
      ],
    );
  }

  Widget signatureSection() {
    return Text('Authorized Signature & Stamp');
  }
}
