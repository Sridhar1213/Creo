import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  // const Alert({ Key? key }) : super(key: key);
  final String title;
  final Color color;
  final String header;
  final Function() onPressOfRestart;
  Alert(this.title, this.color, this.header, this.onPressOfRestart);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Center(
          child: AlertDialog(
        content: SizedBox(
          // width: 100,
          child: Container(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$header",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                    child: Container(
                      height: 25,
                          width: 70,
                          //color: Colors.red,
                          decoration: BoxDecoration(color: Colors.red, border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(
                              20) //                 <--- border radius here
                          ),),
                      child: Center(
                        child: Text("Restart",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    onTap: onPressOfRestart),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
