import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSheetWidget extends GetView {
  final void Function()? onPressed;
  final TextEditingController nmLista;

  ButtonSheetWidget({
    required this.nmLista,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0.70),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          TextField(
            controller: nmLista,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              color: Get.theme.accentColor,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              contentPadding: EdgeInsets.all(10),
              labelText: 'Nome da Lista',
              labelStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 120,
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.blue.shade600,
                    onTap: () {
                      nmLista.clear();
                      Get.back();
                    },
                    onLongPress: () {},
                    child: Center(
                      child: Text(
                        'CANCELAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[
                      Colors.teal.shade300,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 120,
                child: Material(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.blue.shade600,
                    onTap: onPressed,
                    onLongPress: () {},
                    child: Center(
                      child: Text(
                        'CONFIRMAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  color: Colors.transparent,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: <Color>[
                      Colors.teal.shade300,
                      Colors.blue.shade700,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
