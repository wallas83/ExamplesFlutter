import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_api/src/model/pelicula_model.dart';
import 'package:scroll_api/src/services/pelicula_service.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final peli = Provider.of<PeliculaService>(context);
      
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prueba'),
      ),
      body: (peli.peli.length == 0 ) 
              ? Center(child: CircularProgressIndicator(),)
              : ContenidoPelicula(peli.peli),
    );
    
  }
}
class ContenidoPelicula extends StatefulWidget {

    final List<Pelicula> peli;

  ContenidoPelicula(this.peli);

  @override
  _ContenidoPeliculaState createState() => _ContenidoPeliculaState();
}

class _ContenidoPeliculaState extends State<ContenidoPelicula> {
  
  ScrollController _controller;
  @override
  void initState() { 
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScrollUpdated);
    
  }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PeliculaService>(context);
    return ListView.builder(
            controller: _controller,
            itemCount: prov.isloading ? widget.peli.length +1 : widget.peli.length,

            itemBuilder:(BuildContext context, int index){
                if(index >= widget.peli.length){
                  print('el index en listbuilder $index');

                  print('widget.peli.length ${widget.peli.length}');
                  return Center(child: CircularProgressIndicator(),);
                }

               return ListTile(title: Text(widget.peli[index].title),
              subtitle: Text(widget.peli[index].originalTitle),);  
            
            } );
      }
      void _onScrollUpdated(){
        final maxScroll = _controller.position.maxScrollExtent;
        final currentPosition = _controller.position.pixels;
        if(currentPosition > maxScroll - 500){

            final stated = Provider.of<PeliculaService>(context, listen: false);
            stated.getPeliculaNextPage();

        }

      }
}
