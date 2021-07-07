import 'dart:math';

class CalculatorBrain {

  CalculatorBrain({required this.existingNorth, required this.existingEast, required this.adjustedDistance,
  required this.degree, required this.minutes, required this.seconds});

  final double existingNorth;
  final double existingEast;
  final double adjustedDistance;
  final int degree;
  final int minutes;
  final int seconds;

  double computedNorthing = 0;
  double computedEasting = 0;
  double bearing = 0;

  double _calculateBearing(){
    bearing = degree + (minutes / 60) + (seconds / 3600);
     return bearing;
  }

  String calculateComputedNorthing(){
    double changeInNorthing = adjustedDistance * cos(_calculateBearing());
    computedNorthing = changeInNorthing + existingNorth;

    return computedNorthing.toStringAsFixed(3);

  }

  String calculateComputedEasting(){
    double changeInEasting = adjustedDistance * sin(_calculateBearing());
    computedEasting = changeInEasting + existingEast;

    return computedEasting.toStringAsFixed(3);

  }
}