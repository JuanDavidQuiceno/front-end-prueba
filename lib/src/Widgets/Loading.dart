import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  final bool loading;
  Loading({Key key,  @required this.loading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/Helios-pyp.png', width: MediaQuery.of(context).size.width*0.5),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width*0.6,
                child: LinearProgressIndicator(
                  minHeight: 5.0,
                  // value: 0.5,
                  backgroundColor: Colors.grey[300],
                ),
              ),
              SizedBox(height: 5.0,),
              Text('Cargando...'),
            ], 
          ),
        ],
      );
    }else {
      return Container();
    }
  }
}