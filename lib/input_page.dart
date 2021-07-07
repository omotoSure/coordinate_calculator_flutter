import 'package:coordinate_calculato/output_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'output_page.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const bottomContainerHeight = 80.0;
const activeCardColour = Color(0xFF1D1E33);
const bottomContainerColour = Color(0xFFEB1555);

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  TextEditingController controllerNorth = new TextEditingController();
  TextEditingController controllerEast = new TextEditingController();
  TextEditingController controllerDegree = new TextEditingController();
  TextEditingController controllerMinute = new TextEditingController();
  TextEditingController controllerSecond = new TextEditingController();
  TextEditingController controllerAdjustedDistance = new TextEditingController();

  String eastValue = '';
  String northValue ='';
  String adjustedValue ='';
  String degreeValue ='';
  String minuteValue ='';
  String secondValue ='';

  String eastAnswer ='';
  String northAnswer = '';
  @override
  void dispose(){
    controllerNorth.dispose(); controllerAdjustedDistance.dispose();
    controllerEast.dispose(); controllerSecond.dispose();
    controllerDegree.dispose(); controllerMinute.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COORDINATE CALCULATOR'),
        elevation: 30.0,
      ),
    body: Column(
      children: [
        Expanded(child: Row(
          children: [Expanded(child:  ReusableCard(colour: activeCardColour,
            cardChild:TextContent(hintTexts: 'Existing N', textValue: controllerNorth,),),),
                     Expanded(child: ReusableCard(colour: activeCardColour,
                     cardChild: TextContent(hintTexts: 'Existing E', textValue: controllerEast,),),),],
        ),),
        Expanded(child: Row(
            children: [Expanded(child: ReusableCard(colour: activeCardColour,
              cardChild: TextContent(hintTexts: 'Deg(DD)', textValue: controllerDegree,),),),
              Expanded(child: ReusableCard(colour: activeCardColour,
                cardChild: TextContent(hintTexts: 'Min(M\')', textValue: controllerMinute,),),),
              Expanded(child: ReusableCard(colour: activeCardColour,
                cardChild: TextContent(hintTexts: 'Secs(S")', textValue: controllerSecond,),),),
            ],
          ),
        ),
        Expanded(child: Row(
          children: [Expanded(child:  ReusableCard(colour: activeCardColour,
              cardChild:TextContent(hintTexts: 'Adjusted Distance', textValue: controllerAdjustedDistance,)),),
            ],
        ),),


        Container(
          child: ElevatedButton(
            onPressed: () {

              eastValue = controllerEast.text;
              northValue = controllerNorth.text;
              adjustedValue = controllerAdjustedDistance.text;
              degreeValue = controllerDegree.text;
              minuteValue = controllerMinute.text;
              secondValue = controllerSecond.text;

              Navigator.push(context, MaterialPageRoute(builder: (context)=> OutputPage(
                existingNorth: northValue, existingEast: eastValue, adjustedDistance: adjustedValue,
                degree: degreeValue, minutes: minuteValue, seconds: secondValue,),),) ;
              },
            child: Text('CALCULATE'),
        ),
          ),
      ],
    )
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.colour, required this.cardChild});

  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: cardChild,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colour,
      ),
      height: 150.0,
      width: 220.0,
    );
  }
}


class TextContent extends StatelessWidget {

  TextContent({required this.hintTexts, required this.textValue});
  final String hintTexts;
  TextEditingController textValue;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: textValue,
          onTap: () => print(textValue),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            fillColor: Colors.white,
            filled: true,
            hintText: hintTexts,
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomButton extends StatelessWidget {

  BottomButton({required this.buttonTitle, required this.onPress});

  final Function onPress;
  final String buttonTitle;


  @override
  Widget build(BuildContext context) {
     return Container(
       child: ElevatedButton(
         onPressed: () => onPress,
         child: Text(buttonTitle),
       ),
     );
  }
}
