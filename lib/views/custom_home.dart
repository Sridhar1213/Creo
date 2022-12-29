import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Custom_Home extends StatefulWidget {
  const Custom_Home({super.key});

  @override
  State<Custom_Home> createState() => _Custom_HomeState();
}

class _Custom_HomeState extends State<Custom_Home> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body:CustomPaint(
  size: Size(size.width,(size.width*0.5833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
  painter: RPSCustomPainter(),
),
    );
  }
}
class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
   Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
     
         
    Path path0 = Path();
    path0.moveTo(0,0);
    path0.lineTo(size.width*0.9991667,0);
    path0.quadraticBezierTo(size.width*0.9992917,size.height*0.3302143,size.width*0.9993333,size.height*0.4288571);
    path0.quadraticBezierTo(size.width*0.5008333,size.height*0.9977143,0,size.height*0.4277143);
    path0.lineTo(size.width*0.0008333,size.height*0.0342857);
    path0.close();

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}