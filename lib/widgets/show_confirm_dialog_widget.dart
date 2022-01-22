import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listas_genericas/config/app_theme.dart';

Future<void> showConfirme({
  BuildContext? context,
  String? label,
  required void Function()? confirme,
  required void Function()? cancel,
}) async {
  Get.dialog(
    AlertDialog(
      backgroundColor: AppTheme.notWhite.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: FittedBox(
                child: Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OutlinedButton(
              onPressed: cancel,
              child: Text(
                'Não',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 2.0,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: confirme,
              child: Text(
                'Sim',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 2.0,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
