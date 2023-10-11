import 'package:flutter/material.dart';

class CableTvDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Example'),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(), // Add borders to cells
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text('Header 1'),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Header 2'),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text('Data 1'),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text('Data 2'),
                  ),
                ),
              ],
            ),
            // You can add more rows here...
          ],
        ),
      ),
    );
  }
}
