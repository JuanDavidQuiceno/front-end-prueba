import 'package:flutter/material.dart';
import '../../../Models/Categoria_model.dart';

class TarjetasCategoria extends StatelessWidget {
  final CategoriaModel categoria;
  TarjetasCategoria({Key key,  @required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detalle_category', arguments: categoria);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white30,
          ),
          height: 160.0,
          width: MediaQuery.of(context).size.width*0.4,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10.0,),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset('assets/image/not-found.png', width: MediaQuery.of(context).size.width*0.25,)
              ),
              SizedBox(height: 5.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('${categoria.id} - ${categoria.categoria}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}