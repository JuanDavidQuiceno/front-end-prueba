import 'package:flutter/material.dart';
import '../../Bloc/Provider.dart';
import '../../Models/Categoria_model.dart';
import '../../Page/dashboard/Class/TarjetaCategoria.dart';
import '../../Page/dashboard/Class/getCategorias.dart';
import '../../Utils/Utils.dart';
import '../../Widgets/Fondo.dart';
import '../../Widgets/Loading.dart';


class CategoriasPage extends StatefulWidget {

  @override
  _CategoriasPageState createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {

  bool _isLoading = false;

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  void dispose() { 
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsBase(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Fondo(),
          SafeArea(
            child: _body(context)
          ),
          Loading(loading: _isLoading,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Agregar Categoria',
        child: Icon(Icons.add,size: 30.0,),
        onPressed: (){
          Navigator.pushNamed(context, 'add_category');
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    final bloc = Provider.of(context);
    return StreamBuilder(
      stream: bloc.listaCategoriasFormStream,
      builder: (BuildContext context, AsyncSnapshot<List<CategoriaModel>> snapshot){
        if(snapshot.hasData){
          return RefreshIndicator(
            onRefresh: refres,
            child: ListView(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (CategoriaModel item in snapshot.data)
                      TarjetasCategoria(categoria: item,)
                    ,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.4,
                        height: 170.0,
                        // color: Colors.white30,
                      ),
                    )
                  ],

                ),
                SizedBox(height: 100,)
              ],
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> refres(){
    return getCategorias(context);
  }
}