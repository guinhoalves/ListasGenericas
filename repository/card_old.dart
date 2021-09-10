// Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("images/background-folha-com-pauta.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         padding: EdgeInsets.all(15.0),
//         child: Obx(
//           () => ListView.builder(
//             itemCount: ct.listas.length,
//             itemBuilder: (context, index) => Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 10,
//                     horizontal: 5,
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       enableFeedback: true,
//                       // onTap: () => print(ct.listas[index].status),
//                       onLongPress: () => null,
//                       splashColor: Get.theme.primaryColor,
//                       child: Container(
//                         height: 65,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.blueGrey.shade900,
//                             width: 2.0,
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                           color: Colors.transparent,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Container(
//                               width: 8,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
//                                 color: Get.theme.primaryColor,
//                               ),
//                             ),
//                             Center(
//                               child: Text(
//                                 ct.listas[index].titulo ?? '',
//                                 // ct.listas[index].titulo,
//                                 style: TextStyle(color: Colors.black, fontSize: 18),
//                               ),
//                             ),
//                             Icon(
//                               Icons.touch_app_outlined,
//                               color: Colors.black,
//                               size: 36,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),