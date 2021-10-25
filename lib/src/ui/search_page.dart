
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ss/src/model/InvoiceDto.dart';
import 'package:ss/src/model/PartnerDto.dart';
import 'package:ss/src/model/formatter.dart';
import 'package:ss/src/resource/invoice_api_proivder.dart';
import 'package:ss/src/ui/widgets/my_invoice_widget.dart';
import 'package:ss/src/ui/widgets/my_text_form_field.dart';

import 'invoice_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

Invoice invoiceToSend = Invoice();
List<Invoice> invoices = [];
final _formKey = GlobalKey<FormState>();

class _SearchPageState extends State<SearchPage> {
  InvoiceApiProvider apiProvider = InvoiceApiProvider();

  TextEditingController _typeaheadController = TextEditingController();
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _workDayController = TextEditingController();

  @override
  void initState() {
    super.initState();

    PartnerDto partner = PartnerDto();
   partner.partnerName = 'lek';
    invoiceToSend.counterParty = partner;
    _typeaheadController.text = invoiceToSend.counterParty!.partnerName!;
    if (invoiceToSend.filterStartDate != null) {
      DateTime startDate = DateTime.parse(
          invoiceToSend.filterStartDate.toString());
      _fromController.text = formatter.format(startDate!.toLocal());
    }
    if (invoiceToSend.filterEndDate != null) {
      DateTime startDate =
          DateTime.parse(invoiceToSend.filterEndDate.toString());
      _fromController.text = formatter.format(startDate!.toLocal());
    }
    if (_fromController.text == _toController.text) {
      _workDayController.value = _fromController.value;
    }
  }

  @override
  void dispose() {
    _typeaheadController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _workDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchInvoice = TypeAheadFormField<dynamic>(

        errorBuilder: (BuildContext context, Object error) =>
            Text(
                '$error',
                style: TextStyle(
                    color: Theme.of(context).errorColor
                )
            ),
      loadingBuilder: (context) {
        return CircularProgressIndicator();
      },
      textFieldConfiguration: TextFieldConfiguration(
          decoration: MyInputDecoration(hintText: 'име на партнер'),
          controller: _typeaheadController),
      suggestionsCallback: (pattern) {
        return apiProvider.autocompletePartner(pattern);
      },
      itemBuilder: (BuildContext context, dynamic suggestion) {
        final partner = suggestion!;
        return ListTile(
          title: Text((partner as PartnerDto).toString()),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) =>
          suggestionsBox,
      noItemsFoundBuilder: (_) => Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("нема резултати"),
      ),
      onSuggestionSelected: (p) {
        PartnerDto partner = p as PartnerDto;
        invoiceToSend.counterParty = partner;
        _typeaheadController.text = partner.toString();
      },
    );

    final from = DateTimePickerFormField(
        controller: _fromController,
        initialValue: DateTime(1,1,1,1,1,0),
        format: formatter,
        dateOnly: true,
        decoration: InputDecoration(labelText: 'од'),
        onChanged: (dt) => setState(() => invoiceToSend
            .filterStartPartnerDocumentDate = dt.toUtc().toIso8601String()));
    final to = DateTimePickerFormField(
        controller: _toController,
        initialValue: DateTime(1,1,1,1,1,0),
        format: formatter,
        dateOnly: true,
        decoration: InputDecoration(labelText: 'до'),
        onChanged: (dt) => setState(() => invoiceToSend
            .filterEndPartnerDocumentDate = dt.toUtc().toIso8601String()));

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Пребарување",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() => _resetFields());
              }),
          new IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_typeaheadController.text.isEmpty) {}
                _formKey.currentState!.save();
              })
        ],
      ),
      body: Column(
        children: [
          padding,
          Form(
              key: _formKey,
              child: ListView(
                itemExtent: 80,
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  new ListTile(
                      leading: const Icon(
                        Icons.text_fields,
                        size: 40,
                      ),
                      title: searchInvoice),
                  new ListTile(
                      leading: const Icon(
                        Icons.today,
                        size: 40,
                      ),
                      title: from),
                  new ListTile(
                      leading: const Icon(
                        Icons.today,
                        size: 40,
                      ),
                      title: to),
                ],
              )),
          padding,
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListPage(
                            invoice: invoiceToSend,
                          )),
                );
              },
              child: Text(
                'Пребарајте фактури',
                style: TextStyle(fontSize: 23),
              ))
        ],
      ),
    );
  }

  void _resetFields() {
    _formKey.currentState!.reset();
    _typeaheadController.clear();
    _workDayController.clear();
    _fromController.clear();
    _toController.clear();
  }
}
