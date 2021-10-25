import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ss/src/model/InvoiceDto.dart';
import 'package:ss/src/resource/token.dart';
import 'package:ss/src/ui/selected_invoice.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key, required this.invoice}) : super(key: key);
  final Invoice invoice;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Invoice> list = invoiceList;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  final globalKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    getListOfInvoices(widget.invoice);
    list = invoiceList;
    print(invoiceList.length);
  }

  _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _isLoading = true;
      });
      //_fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        appBar: new AppBar(
          title: Text('Листа на фактури'),
        ),
        body: new Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Flexible(
                  child: new ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  if (list.length == index)
                    return Center(child: CircularProgressIndicator());
                  String listData =
                      list[index].counterPartyPartnerName.toString();
                  String listData2 = list[index].documentNumber.toString();
                  Invoice listInvoice = list[index];
                  return new ListTile(
                      title: new Text(listData.toString()),
                      subtitle: new Text(listData2.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyInvoicePage(
                                    invoice: listInvoice,
                                  )),
                        );
                      });
                },
              )),
            ],
          ),
        ));
  }
}
