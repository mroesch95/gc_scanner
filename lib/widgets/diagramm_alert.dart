import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/theme/zeplin_text_style.dart';

class DiagramAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100, left: 17, right: 17, bottom: 99),
      child: Container(
        width: 326,
        height: 441,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, right: 81.8),
                    child: Icon(Icons.close)),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Eventname',
                      style: ZeplinTextStyles.HeadlinePrimaryBlue24SP),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 28, bottom: 8.0),
              child: Text('Total ticket sales',
                  style: ZeplinTextStyles.BodyBoldCAPSBlack14SP),
            ),
          ],
        ),
      ),
    );
  }
}
