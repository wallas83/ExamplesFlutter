import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_api/src/services/pelicula_service.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller;
  @override
  void initState() { 
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScrollUpdated);
  }
  @override
  Widget build(BuildContext context) {
    final peli = Provider.of<PeliculaService>(context);
      print(peli.peli.length);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prueba'),
      ),
      body: Container(
        child: SingleChildScrollView(
          
          physics: ScrollPhysics(),
          controller: _controller,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0,),
              _HeadCategory('nombre'),
              SizedBox(height: 18.0,),

          (peli.peli.length == 0 ) 
          
              ? Center(child: CircularProgressIndicator(),)
              : ContenidoPelicula(),

            ],
          ),
        ),
      ) 
      
    );
    
  }
    void _onScrollUpdated(){
        final maxScroll = _controller.position.maxScrollExtent;
        final currentPosition = _controller.position.pixels;
        if(currentPosition  >= maxScroll - 1200){
          print('$maxScroll, $currentPosition');
            final stated = Provider.of<PeliculaService>(context, listen: false);
            stated.getPeliculaNextPage();

        }

}
}

class ContenidoPelicula extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peli = Provider.of<PeliculaService>(context);

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: peli.peli.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

      itemBuilder: (BuildContext context, int index) {
           if(index >= peli.peli.length){
                  return Center(child: CircularProgressIndicator(),);
                }
        return new Card(
          child: new GridTile(
            footer: new Text(peli.peli[index].title ),
              child: new Text(peli.peli[index].originalTitle), //just for testing, will fill with image later
          ),
        );
      },
  );
  }
}


class _HeadCategory extends StatelessWidget {
  final String name;
  _HeadCategory(this.name);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          //height: 50.0,
          width: 200.0,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Colors.orange, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12.0)),
          child: Center(
              child: Text(
            '$name',
            style: TextStyle(fontSize: 25.0),
          )),
        ),
        InkWell(
          onTap: () {
            print('presiona filtro');
          },
          //cambiar los colores y hacer pruebas del inkwell
          highlightColor: Colors.orange.withAlpha(30),
          //hoverColor: TodoTheme.primaryColor,
          borderRadius: BorderRadius.circular(25.0),
          splashColor: Colors.orange.withAlpha(30),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.tune,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Filtros',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

// class ContenidoPelicula extends StatefulWidget {

//     final List<Pelicula> peli;

//   ContenidoPelicula(this.peli);

//   @override
//   _ContenidoPeliculaState createState() => _ContenidoPeliculaState();
// }

// class _ContenidoPeliculaState extends State<ContenidoPelicula> {
  
//   ScrollController _controller;
//   @override
//   void initState() { 
//     super.initState();
//     _controller = ScrollController();
//     _controller.addListener(_onScrollUpdated);
    
//   }
//   @override
//   Widget build(BuildContext context) {
//     final prov = Provider.of<PeliculaService>(context);
//     return ListView.builder(
//             controller: _controller,
//             itemCount: prov.isloading ? widget.peli.length +1 : widget.peli.length,

//             itemBuilder:(BuildContext context, int index){
//                 if(index >= widget.peli.length){
//                   print('el index en listbuilder $index');

//                   print('widget.peli.length ${widget.peli.length}');
//                   return Center(child: CircularProgressIndicator(),);
//                 }

//                return ListTile(title: Text(widget.peli[index].title),
//               subtitle: Text(widget.peli[index].originalTitle),);  
            
//             } );
//       }
//       void _onScrollUpdated(){
//         final maxScroll = _controller.position.maxScrollExtent;
//         final currentPosition = _controller.position.pixels;
//         if(currentPosition > maxScroll - 500){

//             final stated = Provider.of<PeliculaService>(context, listen: false);
//             stated.getPeliculaNextPage();

//         }

//       }
// }
