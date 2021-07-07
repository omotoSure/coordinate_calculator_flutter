import 'dart:math';

import 'package:coordinate_calculato/input_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coordinate_calculato/calculation.dart';
import 'package:flutter/services.dart';

class OutputPage extends StatelessWidget {

  // OutputPage();
  OutputPage({required this.existingNorth, required this.existingEast, required this.adjustedDistance,
  required this.degree, required this.minutes, required this.seconds});
  // final String computedNorthing;
  // final String computedEasting;

  final String existingNorth;
  final String existingEast;
  final String adjustedDistance;
  final String degree;
  final String minutes;
  final String seconds;

  double computedNorthing = 0;
  double computedEasting = 0;
  double bearing = 0;


  // existingEast: existingEast, adjustedDistance: adjustedDistance, degree: degree, minutes: minutes, seconds: seconds)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('COORDINATE CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(
            child: Text('Your Result',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          ),
          Expanded(
              flex: 5,
              child: ReusableCard(colour: activeCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'COMPUTED NORTHING',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Expanded(
                            child: Text(
                              calculateComputedNorthing(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                          Expanded(
                              child: IconButton(
                                icon: Icon(Icons.copy),
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: calculateComputedNorthing().toString()));
                                },
                              ),
                          )
                        ],
                  ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'COMPUTED EASTING',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Expanded(
                          child: Text(
                            calculateComputedEasting(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: Icon(Icons.copy,),
                            onPressed: (){
                              Clipboard.setData(ClipboardData(text: calculateComputedEasting().toString()));
                              SnackBar(content: Text('Copied'),);
                            },

                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              ),
          ),
          BottomButton(
              buttonTitle: 'RE-CALCULATE',
              onPress: () {
                Navigator.pop(context);
              },
          )
        ],
      ),
    );
  }

  double _calculateBearing(){
    double min = double.parse(minutes);
    double sec = double.parse(seconds);
    bearing = ((double.parse(degree) + (min / 60) + (sec / 3600)) * 3.142857142857142) / 180;

    return bearing;
  }

  String calculateComputedNorthing(){
    double changeInNorthing = double.parse(adjustedDistance) * cos(_calculateBearing());
    computedNorthing = changeInNorthing + double.parse(existingNorth);

    return computedNorthing.toStringAsFixed(3);

  }

  String calculateComputedEasting(){
    double changeInEasting = double.parse(adjustedDistance) * sin(_calculateBearing());
    computedEasting = changeInEasting + double.parse(existingEast);

    return computedEasting.toStringAsFixed(3);

  }
  
}
