import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {

  final double numberOfRecent = 0.7;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;

  double progressDegree = 0.0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController = AnimationController(
      vsync: this, 
      duration: Duration(seconds: 3)
    );
    _progressAnimation = Tween(begin: 0.0, end: 360.0)
      .animate(_radialProgressAnimationController)
      ..addListener((){
        setState(() {
          progressDegree = widget.numberOfRecent * _progressAnimation.value;  
        });
      });

    _radialProgressAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 100.0,
        width: 160.0,
      ),
      painter: RadialPainter(progressDegree),
    );
  }
}

class RadialPainter extends CustomPainter {

  double progressInDegrees;

  Color firstColor = Color(0xFF000428);
  Color secondColor = Color(0xFF004e92);

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size){

    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    Offset leftCenter = Offset(size.width/1.5, size.height/1.5);
    canvas.drawCircle(leftCenter, size.width/3, paint);

    Paint progressPaint = Paint()
      ..shader = LinearGradient(colors: [
        firstColor,
        secondColor
      ]).createShader(Rect.fromCircle(center: leftCenter, radius: size.width/3))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: leftCenter, radius: size.width/3),
      math.radians(-90), 
      math.radians(progressInDegrees), 
      false, 
      progressPaint
    );
  }

  @override 
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}