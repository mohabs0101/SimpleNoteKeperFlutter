import 'package:flutter/material.dart';
import 'package:simple_notekeeper/Screens/simple_note_list.dart';
import 'package:simple_notekeeper/database/LocalDB.dart';



class edit_note extends StatefulWidget {

  final note;
  final title;
  final id;
  final color;
  const edit_note({Key? key, this.note, this.title, this.id,this.color}) : super(key: key);

  @override
  State<edit_note> createState() => _edit_notetate();
}

class _edit_notetate extends State<edit_note> {

  SqlDb _sqlDb = new SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();


  @override
  void initState() {
    note.text=widget.note;
    title.text=widget.title;
    color.text=widget.color;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Note' , style: TextStyle(
        color: Colors.blueGrey,
      ),),   backgroundColor: Colors.yellow,),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
              Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
               child: TextFormField(
                  controller: note,
                  decoration: InputDecoration(
                    labelText: 'note',
                      labelStyle: textstyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                  ),

                ),
              ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextFormField(
            controller: title,
            decoration:InputDecoration(
                labelText: 'title',
                labelStyle: textstyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
            ),
          ),
        ),

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child:  TextFormField(
                      controller: color,
                      decoration: InputDecoration(
                          labelText: 'color',
                          labelStyle: textstyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )
                      ),
                    ),
                  ),

                  Container(height: 20.0),


                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.yellow),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 20, color: Colors.white))),
                    onPressed: () async {
                      // int response = await _sqlDb.updateData('''
                      //       UPDATE mynotes SET
                      //       note="${note.text}",
                      //       title="${title.text}",
                      //       color="${color.text}"
                      //       WHERE id =${widget.id}
                      //      ''');
                      int response = await _sqlDb.update("mynotes",{
                        "note":note.text,
                        "title":title.text,
                        "color":color.text

                      },
                          "id=${widget.id}");
                      print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => simple_list()),
                                (route) => false);
                      }
                    },
                    child: Text("save", textScaleFactor: 1.5, style: TextStyle(
                      color: Colors.blueGrey,
                    ),),

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
