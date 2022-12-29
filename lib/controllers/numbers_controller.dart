import 'dart:math';

import 'package:creo_task/models/life_model.dart';
import 'package:creo_task/models/numbers_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../views/alert.dart';

class NumbersController extends GetxController{
  var headerNumbers = <NumbersModel>[];
  var headerCount = 3;
  var randomMaxVal = 100;
  var numbersList = <NumbersModel>[];
  var numbersCount = 15;
  var lifeList = <LifeModel>[];
  var lifeCount = 3;
  var isGameOver = false;
  var allowRandomPositions = true;
  var previousPositions;

  @override
  void onInit(){
    initialLifeList();
    generateHeaderNumbers();
    generateNumbers();
    super.onInit();
  }

  generateHeaderNumbers(){
    // for(var i = 0; i < 100; i++){
    //   var newNum = Random().nextInt(randomMaxVal);
    //   if(numbersList.any((element) => element.number != newNum)){
    //   headerNumbers.add(NumbersModel(number: Random().nextInt(randomMaxVal), color: Colors.white));
    //   break;
    // }
    // }
    update();
  }

  generateNumbers(){
    var newNumbersList = [];
    for(var i = 0; i < randomMaxVal; i++){
      if(numbersCount == numbersList.length){

      }else{
        var newNumber = Random().nextInt(randomMaxVal);
        var checkIfNumExists = numbersList.indexWhere((element) => element.number == newNumber);
        if(checkIfNumExists == -1){
          numbersList.add(NumbersModel(number: newNumber, color: Colors.white));
          newNumbersList.add(newNumber);
        }
      }
    }
    newNumbersList.shuffle();
    for(var i = 0; i < 2; i++){
      headerNumbers.add(NumbersModel(number: newNumbersList[i], color: Colors.white));
    }
    var newNum = Random().nextInt(randomMaxVal);
    for(var i = 0; i < 100; i++){
      var numInd = numbersList.indexWhere((element) => element.number == newNum);
      if(numInd == -1){
      headerNumbers.add(NumbersModel(number: Random().nextInt(randomMaxVal), color: Colors.white));
      break;
    }else{
      newNum = Random().nextInt(randomMaxVal);
    }
    }
    // generateHeaderNumbers();
    generateRandomTiles(numbersList.length);
    update();
  }

  onSelectOfNumber(index, context){
    var newHeaderList = headerNumbers;
    var newNumbersList = numbersList;
    var indOfHeader = headerNumbers.indexWhere((element) => element.number == numbersList[index].number);
    if(indOfHeader != -1){
      newHeaderList[indOfHeader].color = Color(0xFF22F400);
      headerNumbers = newHeaderList;
      var indOfNumbers = numbersList.indexWhere((element) => element.number == headerNumbers[indOfHeader].number);
      if(indOfNumbers != -1){
        newNumbersList[indOfNumbers].color = Color(0xFF22F400);
        numbersList = newNumbersList;
      }
    }else{
      var lifeInd = lifeList.indexWhere((element) => element.isAlive == false);
      if(lifeInd == -1){
        lifeList[lifeList.length - 1].color = Colors.black;
        lifeList[lifeList.length - 1].isAlive = false;
      }else{
        var checkLifes = lifeList.indexWhere((element) => element.isAlive == true);
        if(checkLifes == -1){
          isGameOver = true;
        }else{
          lifeList[lifeInd - 1].color = Colors.black;
          lifeList[lifeInd - 1].isAlive = false;
        }
        var checkLifes1 = lifeList.indexWhere((element) => element.isAlive == true);
        if(checkLifes1 == -1){
          showDialog(
        barrierDismissible: false,
          context: context,
          builder: (context) => Alert("Lost the game", Colors.black, "You have lost! Boooooo Loser", (){
            headerNumbers = [];
            numbersList = [];
            lifeList = [];
            generateHeaderNumbers();
            generateNumbers();
            initialLifeList();
            updateallowRandomPositions(true);
            Navigator.pop(context);
          },));
        }
      }
    }
    update();
  }

  initialLifeList(){
    for(var i = 0; i < lifeCount; i++){
      lifeList.add(LifeModel(color: Colors.red, isAlive: true));
    }
    update();
  }

  updateallowRandomPositions(val){
    allowRandomPositions = val;
    update();
  }

  updatePreviousPositions(data){
    previousPositions = data;
    Future.delayed(Duration(seconds: 1), (){
      update();
    });
  }

  List<StaggeredTile> generateRandomTiles(int count) {
  Random rnd = new Random();
  List<StaggeredTile> _staggeredTiles = [];
  for (int i=0; i<count; i++) {
    num mainAxisCellCount = 0;
    double temp = rnd.nextDouble();

    if (temp > 0.6) {
      mainAxisCellCount = temp + 1.5;
    } else if (temp < 0.3) {
      mainAxisCellCount = temp + 2.5;
    } else {
      mainAxisCellCount = temp + 01.0;
    }
    _staggeredTiles.add(new StaggeredTile.count(rnd.nextInt(1) + 1, double.parse("$mainAxisCellCount")));
  }
  updatePreviousPositions(_staggeredTiles);
  return _staggeredTiles;
}

}