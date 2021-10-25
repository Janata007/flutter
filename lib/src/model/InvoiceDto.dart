
import 'package:json_annotation/json_annotation.dart';
import 'package:lombok/lombok.dart';

import 'DocumentType.dart';
import 'PartnerDto.dart';
import 'TurnoverType.dart';
part'InvoiceDto.g.dart';

@JsonSerializable()
class Invoice{

  String? id;
  DocumentType? documentType;
  String? documentNumber;
  String? documentDate;
  double? quantity;
  double? vatRate;
  TurnoverType? turnoverType;
  double? divide;
  bool? confirmed;
  double? groupTotal;
  bool? groupTopRecord;
  String? partnerDocumentNumber;
  DateTime? partnerDocumentDate;
  DateTime? partnerDocumentDueDatePayment;
  double? invoicePrice;
  double? discountRate;
  double? discountAmount;
  double? purchasePrice;
  double? purchaseAmount;
  double? vatPurchaseAmount;
  double? partnerDocumentAmount;
  bool? reimbursement;
  double? retailMargin;
  double? retailPrice;
  double? fzoRefPrice;
  PartnerDto? counterParty;
  String? counterPartyPartnerId;
  String? counterPartyPartnerName;

  String? filterStartPartnerDocumentDate;
  String? filterEndPartnerDocumentDate;
  DateTime? filterStartPartnerDocumentDueDatePayment;
  DateTime? filterEndPartnerDocumentDueDatePayment;

   List<DocumentType>? filterDocumentTypes;
   DateTime? filterStartDate;
   DateTime? filterEndDate;

  Invoice({ this.filterStartDate, this.filterEndDate, this.filterDocumentTypes, this.counterParty, this.filterEndPartnerDocumentDueDatePayment,this.filterStartPartnerDocumentDueDatePayment,
    this.partnerDocumentDate, this.partnerDocumentDueDatePayment,
    this.filterStartPartnerDocumentDate, this.filterEndPartnerDocumentDate,
    this.documentDate, this.counterPartyPartnerId, this.counterPartyPartnerName, this.partnerDocumentNumber, this.invoicePrice,
    this.discountRate, this.discountAmount, this.purchaseAmount, this.purchasePrice, this.vatPurchaseAmount,
    this.partnerDocumentAmount, this.retailMargin, this.reimbursement, this.retailPrice, this.fzoRefPrice,
       this.documentType,
    this.id, this.documentNumber, this.turnoverType,  this.quantity, this.vatRate, this.divide, this.confirmed, this.groupTopRecord, this.groupTotal});


  factory Invoice.fromJson(Map<String,dynamic> data) => _$InvoiceFromJson(data);

  Map<String,dynamic> toJson() => _$InvoiceToJson(this);

}