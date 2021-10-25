import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ss/src/model/InvoiceDto.dart';
import 'package:ss/src/ui/search_page.dart';
import 'package:ss/src/ui/widgets/my_invoice_widget.dart';

class MyInvoicePage extends StatelessWidget {
  const MyInvoicePage({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              title: Text('Фактура'),
            ),
            InvoiceCard(invoice),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: Text('Пребарување ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
