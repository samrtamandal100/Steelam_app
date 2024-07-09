import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reusable Component Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomerCardGrid(),
        ),
      ),
    );
  }
}

class CustomerCardGrid extends StatelessWidget {
  final List<Map<String, dynamic>> customerData = [
    {'totalCustomers': '1,02,890', 'growthPercentage': 40},
    {'totalCustomers': '55,760', 'growthPercentage': 25},
    {'totalCustomers': '78,330', 'growthPercentage': 15},
    {'totalCustomers': '34,120', 'growthPercentage': 30},
    {'totalCustomers': '90,450', 'growthPercentage': 10},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;

    if (screenWidth > 1200) {
      crossAxisCount = 4; // Desktop
    } else if (screenWidth > 800) {
      crossAxisCount = 2; // Tablet
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: customerData.length,
      itemBuilder: (context, index) {
        return CustomerCard(
          totalCustomers: customerData[index]['totalCustomers'],
          growthPercentage: customerData[index]['growthPercentage'],
        );
      },
    );
  }
}

class CustomerCard extends StatelessWidget {
  final String totalCustomers;
  final int growthPercentage;

  const CustomerCard({
    Key? key,
    required this.totalCustomers,
    required this.growthPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth > 1200
        ? 60
        : screenWidth > 800
            ? 50
            : 40;
    double textSize = screenWidth > 1200
        ? 22
        : screenWidth > 800
            ? 20
            : 18;
    double numberSize = screenWidth > 1200
        ? 36
        : screenWidth > 800
            ? 32
            : 28;
    EdgeInsets padding = screenWidth > 1200
        ? EdgeInsets.all(24.0)
        : screenWidth > 800
            ? EdgeInsets.all(20.0)
            : EdgeInsets.all(16.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.people, color: Colors.purple, size: iconSize),
                  SizedBox(width: 10),
                  Text(
                    'Total Customers',
                    style: TextStyle(
                        fontSize: textSize, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                totalCustomers,
                style: TextStyle(
                    fontSize: numberSize, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Define the action for the "View All" button
                },
                child: Row(
                  children: [
                    Text('View All'),
                    Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '+$growthPercentage%',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'this month',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
