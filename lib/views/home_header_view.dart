import 'dart:math';

import 'package:creo_task/controllers/numbers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  var numbersController = Get.find<NumbersController>();
  HomeHeader({super.key});

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NumbersController>(
      builder: (snapshot) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                height: 40,
                margin: EdgeInsets.only(left: 15),
                width: MediaQuery.of(context).size.width * 0.3,
                child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.lifeList.length,
                itemBuilder: ((context, index) {
                return Container(
                  child: Center(child: snapshot.lifeList[index].isAlive == true ?  Icon(Icons.favorite, color: snapshot.lifeList[index].color,) : Icon(Icons.favorite_border_outlined, color: Colors.black,),),
                );
                }))),
                GestureDetector(
                  onTap: (){
                    numbersController.headerNumbers = [];
                    numbersController.numbersList = [];
                    numbersController.lifeList = [];
                    numbersController.generateHeaderNumbers();
                    numbersController.generateNumbers();
                    numbersController.initialLifeList();
                    // numbersController.updateallowRandomPositions(true);
                    // generateRandomTiles(numbersController.numbersList.length);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 30, height: 30, decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(24)), child: Icon(Icons.replay_outlined, color: Colors.white, size: 18,)),
                )
              ],
            ),
            SizedBox(height: 16,),
            Align(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.headerNumbers.length,
                  itemBuilder: ((context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 30, width: 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                    color: snapshot.headerNumbers[index].color, border: Border.all(color: Color(0xFF0E4B8B))),
                    child: Center(child: Text("${snapshot.headerNumbers[index].number}"),),
                  );
                }))),
              ),
            )
          ]),
        );
      }
    );
  }
}