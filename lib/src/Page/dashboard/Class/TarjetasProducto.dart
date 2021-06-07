import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/Models/Producto_model.dart';


class TarjetasProducto extends StatelessWidget {
  final ProductoModel producto;
  TarjetasProducto({Key key,  @required this.producto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detalle_product', arguments: producto);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white30,
          ),
          height: 100.0,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset('assets/image/not-found.png', height: 100.0,)
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.0,),
                      Text('${producto.id} - ${producto.nombre}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      // SizedBox(height: 5.0,),
                      Expanded(child: Container(),),
                      Text('Precio: ${producto.precio}', style: TextStyle(color: Colors.white, fontSize: 10.0), maxLines: 2, overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 5.0,),
                      Text('Categoria: ${producto.categoria.categoria} - ${producto.categoria.id}', style: TextStyle(color: Colors.white, fontSize: 10.0),),
                      SizedBox(height: 5.0,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}