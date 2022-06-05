import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:scanner/constants/strings.dart';
import 'package:scanner/theme/zeplin_colors.dart';
import 'package:scanner/theme/zeplin_text_style.dart';

import '../pages/ticket_page.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 99, right: 99),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 36,
                width: 162,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ZeplinColors.primary_pink),
                    //Background Color
                    elevation: MaterialStateProperty.all(3),
                    //Defines Elevation
                    shadowColor: MaterialStateProperty.all(
                        ZeplinColors.primary_pink), //Defines shadowColor
                  ),
                  onPressed: () {
                    scanQR().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TicketPage(scanQRcode: value)));
                    });
                  },
                  child: Text(Strings.button_ticket_scannen.toUpperCase(),
                      style: ZeplinTextStyles.BodyBoldCAPSWhite14SP),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#2E9AFE', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;
  }
}
