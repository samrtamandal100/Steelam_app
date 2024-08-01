import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: InvoiceScreen()));
}

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 800,
          width: 700,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PROFORMA INVOICE",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "PROFORMA INVOICE",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "PROFORMA INVOICE",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(thickness: 1),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("Customer ID: 9YWS6HYEA1"),
                      Text("Customer Name: Chiranjit Das"),
                      Text("Address: Hasnabad"),
                      Text("Contact No: 8274827707"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Proforma Invoice: SI/DT/2024-25/185"),
                      Text("Order Date: 27-Jul-2024"),
                      Text("Salesman ID: STLM0001"),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Product"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Quantity"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Rate"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Amount"),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Bed"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("1"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("₹8474.58"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("₹8474.58"),
                    ),
                  ]),
                ],
              ),
              SizedBox(height: 20),
              Text("** Please Do Not Pay Any Tips To Anyone"),
              SizedBox(height: 10),
              Divider(thickness: 1),
              SizedBox(height: 10),
              Text("Non-Taxable Amount: ₹8474.58"),
              Text("(+) CGST : 9% : ₹762.71"),
              Text("(+) SGST : 9% : ₹762.71"),
              Text("Round Off (-) : ₹0.00"),
              Text(
                "Net Total with : ₹10000",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Divider(thickness: 2),
              SizedBox(height: 20),
              Text("Bank Details"),
              Text("A/c Name : STEELAM INDUSTRIES"),
              Text("A/c No. : 50200078987439"),
              Text("Bank Name : HDFC Bank"),
              Text("IFSC Code : HDFC0000023"),
              Text("Branch : MADHYAMGRAM"),
              Spacer(),
              Divider(thickness: 2),
              Center(
                child: Text(
                  "STEELAM INDUSTRIES\nAuthorized Signature & Stamp",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
