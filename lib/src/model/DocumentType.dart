enum DocumentType {
  FISCAL, // Fiskalna smetka
  FISCALSTOR, // Storno fiskalna smetka;
  INVOICEIN, // Priemnica/Vlezna faktura/Kalkulacija;
  INVOICEOUT, // Izlezna faktura;
  INVOICEOUTSTOR, // Storno Izlezna faktura;
  INVOICESTOR, // Povratnica
  INVOICEML, // Faktura Makeodnija Lek
  INVOICEINT, // Faktura Integral
  INVOICEEL, // Faktura Eurolek
  INVENTORY, // Popis;
  TRANSFER, // Prenosnica;
  PRICECHNG, // Promena na cena. Izvestaj za menuvanje na ceni;
  INTERNALOUT, // Interna izlezna ispratnica
  INTERNALIN, // Interna vlezna ispratnica// Interna vlezna ispratnica
  INTERNALREIMBIN, // Interna prenosnica od komercijalna vo pozitivna
  INTERNALREIMBOUT, // Interna prenosnica od pozitivna vo komercijalna
  DFI //Dneven promet kako filter vo reportot Evidencija vo trgovija

}

extension DocumentTypeExtension on DocumentType {
  String prefix() {
    String ret = "";
    String getType(DocumentType type) {
      switch (type) {
        case DocumentType.FISCAL: // Fiskalna smetka
          return "FIS";
        case DocumentType.FISCALSTOR: // Storno fiskalna smetka;
          return "FIS";
        case DocumentType.INVOICEIN: // Priemnica/Vlezna faktura/Kalkulacija;
        case DocumentType.INVOICEINT: // Integral
        case DocumentType.INVOICEML: // Makedonija lek
        case DocumentType.INVOICEEL: // Eurolek
          return "PRI";
        case DocumentType.INVOICEOUT: // Izlezna faktura;
          return "FAK";
        case DocumentType.INVOICEOUTSTOR: // Storno Izlezna faktura;
          return "FAK";
        case DocumentType.INVOICESTOR: // Povratnica
          return "PRI";
        case DocumentType.INVENTORY: // Popis;
          return "POP";
        case DocumentType.TRANSFER: // Prenosnica;
          return "PRN";
        case DocumentType
            .PRICECHNG: // Promena na cena. Izvestaj za menuvanje na ceni;
          return "NIV";
        case DocumentType.INTERNALOUT: // Interna izlezna ispratnica.
        case DocumentType.INTERNALIN: // Interna izlezna ispratnica.
          return "INT";
        case DocumentType
            .INTERNALREIMBIN: // Interna prenosnica od komercijalna vo pozitivna
          return "PKP";
        case DocumentType
            .INTERNALREIMBOUT: // Interna prenosnica od pozitivna vo komercijalna
          return "PPK";
        default:
          return "";
      }
    }

    return ret;
  }

  double fixQuantity(double quantity) {
    double getQuantity(DocumentType type) {
      switch (type) {
        case DocumentType.FISCAL:
        case DocumentType.FISCALSTOR:
        case DocumentType.INVOICEOUT:
        case DocumentType.INVOICEOUTSTOR:
        case DocumentType.INTERNALREIMBOUT:
        case DocumentType.INTERNALOUT:
          quantity *= -1.0;
          break;
        case DocumentType.PRICECHNG:
          quantity = 0.0;
          break;
        default:
      }
      return quantity;
    }

    return quantity;
  }
}
