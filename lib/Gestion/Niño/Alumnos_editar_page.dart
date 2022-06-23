import 'package:flutter/material.dart';
import 'package:trabajo/providers/Alumnos_provider.dart';

class Alumnos_editar_page extends StatefulWidget {
  String codAlumno;
  Alumnos_editar_page(this.codAlumno,{Key? key}) : super(key: key);

  @override
  State<Alumnos_editar_page> createState() => _Alumnos_editar_pageState();
}

class _Alumnos_editar_pageState extends State<Alumnos_editar_page> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController edadCtrl = TextEditingController();
  TextEditingController cursoCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Alumno'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: AlumnosProvider().getAlumno(widget.codAlumno),
        builder:(context, AsyncSnapshot snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data;
          codigoCtrl.text = data['cod_alumno'];
          nombreCtrl.text = data['nom_alumno'];
          direccionCtrl.text = data['direccion'];
          telefonoCtrl.text = data['telefono'];
          edadCtrl.text = data['edad'].toString();
          cursoCtrl.text = data['nom_curso'];

          return Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: codigoCtrl,
                  decoration: InputDecoration(labelText: 'Codigo'),
                ),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: direccionCtrl,
                  decoration: InputDecoration(labelText: 'Direccion'),
                ),
                TextFormField(
                  controller: telefonoCtrl,
                  decoration: InputDecoration(labelText: 'Telefono'),
                ),
                TextFormField(
                  controller: edadCtrl,
                  decoration: InputDecoration(labelText: 'Edad'),
                ),
                TextFormField(
                  controller: cursoCtrl,
                  decoration: InputDecoration(labelText: 'Curso'),
                ),
                
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Editar'),
                    onPressed: (){
                      AlumnosProvider().alumnosEditar(widget.codAlumno, codigoCtrl.text.trim(), nombreCtrl.text.trim(), direccionCtrl.text.trim(), telefonoCtrl.text.trim(), int.tryParse(edadCtrl.text.trim())??0, cursoCtrl.text.trim());
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                    )
                  ),
                )

              ],
            ),
          );
        }
      ),
    );
  }
}