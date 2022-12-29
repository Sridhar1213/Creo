import 'package:creo_task/views/home_header_view.dart';
import 'package:flutter/material.dart';
import 'ball_widget.dart';
import 'custom_home.dart';
import 'home_numbers_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  Size? size;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(191, 234, 253, 1),
        body: SafeArea(
          child: Container(
            // height: 500,
            
            // height: 500,
            child: Column(children: [
              Container(
                height: 150,
                child: CustomPaint(
      size: Size(size.width,(size.width*0.5833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
      painter: RPSCustomPainter(),child: HomeHeader()),
              ),
              SizedBox(height: 30,),
              HomeNumbersView()
            ],)
          ),
        ),
      ),
    );
  }
}