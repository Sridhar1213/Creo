import 'dart:math';

import 'package:creo_task/views/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../controllers/numbers_controller.dart';

class HomeNumbersView extends StatefulWidget {

  HomeNumbersView({super.key});

  @override
  State<HomeNumbersView> createState() => _HomeNumbersViewState();
}

class _HomeNumbersViewState extends State<HomeNumbersView> {
  var numbersController = Get.find<NumbersController>();

  @override
  void initState(){
    numbersController.updateallowRandomPositions(false);
    super.initState();
  }

  // void showAlert(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NumbersController>(
      builder: (snapshot) {
        return Expanded(
          // height: 500,
          // width: MediaQuery.of(context).size.width * 0.5,
          child: Container(
            // decoration: BoxDecoration(gradient: LinearGradient(
            //                                     colors: [
            //                                       Color(0xFF147EC1),
            //                                       Color(0xFFECF4F8)
            //                                     ],
            //                                     begin: Alignment.topCenter,
            //                                     end: Alignment.bottomCenter),),
            color: Color.fromRGBO(191, 234, 253, 1),
            child: StaggeredGridView.count(crossAxisCount: 5,
        //   itemCount: snapshot.numbersList.length,
        //   itemBuilder: (context, index) {
        //     return Center(
        //       child: GestureDetector(
        //         onTap: (){
        //           var checkLifes = snapshot.lifeList.indexWhere((element) => element.isAlive == true);
        // //           if(checkLifes == -1){
        // //             showDialog(
        // // barrierDismissible: false,
        // //   context: context,
        // //   builder: (context) => Alert("Lost the game", Colors.black, "Game", (){}, (){}));
        // //           }else{
        //             numbersController.onSelectOfNumber(index, context);
        //           // }
        //         },
        //         child: Container(
        //           height: 26, width: 26,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(26),
        //           color: snapshot.numbersList[index].color, border: Border.all(color: Color(0xFF0E4B8B))),
        //           child: Center(child: Text("${snapshot.numbersList[index].number}"))),
        //       ),
        //     );
        //   },
        //   staggeredTileBuilder: (ind) => generateRandomTiles(snapshot.data.documents.length),
              children: List.generate(snapshot.numbersList.length, (index) => Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Material(
                    child: InkWell(
                      highlightColor: Colors.grey.withOpacity(0.5),
                      onTap: (){
                      // var checkLifes = snapshot.lifeList.indexWhere((element) => element.isAlive == true);
                          //           if(checkLifes == -1){
                          //             showDialog(
                          // barrierDismissible: false,
                          //   context: context,
                          //   builder: (context) => Alert("Lost the game", Colors.black, "Game", (){}, (){}));
                          //           }else{
                        
                        numbersController.onSelectOfNumber(index, context);
                      // }
                    },
                      splashColor: Colors.grey.withOpacity(0.3),
                      child: Ink(
                        height: 40, width: 40,
                        // color: Colors.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        color: snapshot.numbersList[index].color, border: Border.all(color: Color(0xFF0E4B8B))),
                        child: Center(child: Text("${snapshot.numbersList[index].number}"))),
                    ),
                  ),
                ),
              )),
              staggeredTiles: snapshot.previousPositions
            ),
          )
        );
      }
    );
  }

  List<StaggeredTile> generateRandomTiles(int count) {
  Random rnd = new Random();
  List<StaggeredTile> _staggeredTiles = [];
  for (int i=0; i<count; i++) {
    num mainAxisCellCount = 0;
    double temp = rnd.nextDouble();

    if (temp > 0.6) {
      mainAxisCellCount = temp + 0.5;
    } else if (temp < 0.3) {
      mainAxisCellCount = temp + 0.9;
    } else {
      mainAxisCellCount = temp + 0.7;
    }
    _staggeredTiles.add(new StaggeredTile.count(rnd.nextInt(1) + 1, double.parse("$mainAxisCellCount")));
  }
  numbersController.updatePreviousPositions(_staggeredTiles);
  return _staggeredTiles;
}
}