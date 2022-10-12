import 'package:flutter/material.dart';
import 'package:simple_notekeeper/Screens/simple_note_list.dart';
import 'package:simple_notekeeper/database/LocalDB.dart';

class add_note extends StatefulWidget {
  const add_note({Key? key}) : super(key: key);

  @override
  State<add_note> createState() => _add_noteState();
}

class _add_noteState extends State<add_note> {
  SqlDb _sqlDb = new SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textstyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(title: Text('Add Note' , style: TextStyle(
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
                child:   TextFormField(
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
                    child:   TextFormField(

                      controller: title,
                      decoration: InputDecoration(
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
                    child:   TextFormField(

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
                      // int response = await _sqlDb.insertData('''
                      //      INSERT INTO mynotes ('note','title','color')
                      //      VALUES ('${note.text}','${title.text}','${color.text}')
                      //      ''');
                      int response = await _sqlDb.insert("mynotes",{
                        "note":note.text,
                        "title":title.text,
                        "color":color.text
                      } );
                      print(response);
                      if (response > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => simple_list()),
                            (route) => false);
                      }
                    },
                    child: Text("Add Note", textScaleFactor: 1.5, style: TextStyle(
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
