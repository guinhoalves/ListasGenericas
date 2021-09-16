// Stack(
//               children: [
//                 Positioned(
//                   right: 30,
//                   bottom: 30,
//                   child: Stack(
//                     children: [
//                       Transform.translate(
//                         offset: Offset.fromDirection(
//                           ct.getRadiansFromDegree(270),
//                           ct.degOneTranslationAnimation.value * 100,
//                         ),
//                         child: Transform(
//                           transform: Matrix4.rotationZ(
//                             ct.getRadiansFromDegree(ct.rotationAnimation.value),
//                           )..scale(ct.degOneTranslationAnimation.value),
//                           alignment: Alignment.center,
//                           child: CircularButton(
//                             width: 50,
//                             height: 50,
//                             color: Colors.blue,
//                             icon: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                             onClick: () {},
//                           ),
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: Offset.fromDirection(
//                           ct.getRadiansFromDegree(225),
//                           ct.degTwoTranslationAnimation.value * 100,
//                         ),
//                         child: Transform(
//                           transform: Matrix4.rotationZ(
//                             ct.getRadiansFromDegree(ct.rotationAnimation.value),
//                           )..scale(ct.degTwoTranslationAnimation.value),
//                           alignment: Alignment.center,
//                           child: CircularButton(
//                             width: 50,
//                             height: 50,
//                             color: Colors.black,
//                             icon: Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                             ),
//                             onClick: () {},
//                           ),
//                         ),
//                       ),
//                       Transform.translate(
//                         offset: Offset.fromDirection(
//                             ct.getRadiansFromDegree(180), ct.degThreeTranslationAnimation.value * 100),
//                         child: Transform(
//                           transform: Matrix4.rotationZ(
//                             ct.getRadiansFromDegree(ct.rotationAnimation.value),
//                           )..scale(ct.degThreeTranslationAnimation.value),
//                           alignment: Alignment.center,
//                           child: CircularButton(
//                             width: 50,
//                             height: 50,
//                             color: Colors.orangeAccent,
//                             icon: Icon(
//                               Icons.person,
//                               color: Colors.white,
//                             ),
//                             onClick: () {},
//                           ),
//                         ),
//                       ),
//                       Transform(
//                         transform: Matrix4.rotationZ(
//                           ct.getRadiansFromDegree(ct.rotationAnimation.value),
//                         ),
//                         alignment: Alignment.center,
//                         child: CircularButton(
//                           width: 60,
//                           height: 60,
//                           color: Colors.red,
//                           icon: Icon(
//                             Icons.menu,
//                             color: Colors.white,
//                           ),
//                           onClick: () => ct.mostraOpcoes(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             );

// import 'package:flutter/animation.dart';
// import 'package:get/get.dart';

// import 'package:listas_genericas/models/lista_model.dart';

// class DetalhesListaController extends GetxController with SingleGetTickerProviderMixin {
//   late ListaModel lista;
//   late AnimationController animationController;
//   late Animation degOneTranslationAnimation, degTwoTranslationAnimation, degThreeTranslationAnimation;
//   late Animation rotationAnimation;
//   @override
//   void onClose() {
//     super.onClose();
//   }

//   @override
//   void onInit() {
//     if (Get.arguments != null) lista = Get.arguments[0];

//     animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 250),
//     );
//     degOneTranslationAnimation = TweenSequence(
//       [
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
//       ],
//     ).animate(animationController);
//     degTwoTranslationAnimation = TweenSequence(
//       [
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
//       ],
//     ).animate(animationController);
//     degThreeTranslationAnimation = TweenSequence(
//       [
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
//         TweenSequenceItem<double>(tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
//       ],
//     ).animate(animationController);
//     rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.easeOut,
//       ),
//     );
//     super.onInit();
//     animationController.addListener(() {
//       update();
//     });
//   }

//   double getRadiansFromDegree(double degree) {
//     double unitRadian = 57.295779513;
//     return degree / unitRadian;
//   }

//   mostraOpcoes() {
//     if (animationController.isCompleted) {
//       animationController.reverse();
//     } else {
//       animationController.forward();
//     }
//     update();
//   }
// }
