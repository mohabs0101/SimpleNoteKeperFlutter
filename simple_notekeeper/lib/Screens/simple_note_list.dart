import 'package:flutter/material.dart';
import 'package:simple_notekeeper/Screens/simple_note_edite.dart';
import 'package:simple_notekeeper/database/LocalDB.dart';


class simple_list extends StatefulWidget {
  @override
  State<simple_list> createState() => _simple_listState();
}

class _simple_listState extends State<simple_list> {
  SqlDb sqldb = new SqlDb();

  bool Isloading = true;
  List notes = []; //empty list to fill it with map data later

  //normal function  map list of type future
  //we can reciveapi data or an map data in this function
  // Future _readData() async {
  //   List<Map> response = await sqldb.readData("SELECT * FROM mynotes");
  //   notes.addAll(response); // add map result to list
  //   Isloading = false;
  //   if (this.mounted) {
  //     setState(() {}); //refresh ui
  //   }
  // }
  Future _readData() async {
    List<Map> response = await sqldb.read("mynotes");
    notes.addAll(response); // add map result to list
    Isloading = false;
    if (this.mounted) {
      setState(() {}); //refresh ui
    }
  }

  @override
  void initState() {
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addnote");
          },
          tooltip: 'Add Note',
          child: Icon(Icons.add,color: Colors.black, ),
          backgroundColor: Colors.yellow,
        ),
        appBar: AppBar(
          title: Center(
            child: Text(
              'notes list',
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
          ),
          backgroundColor: Colors.yellow,
        ),
        body: Isloading == true
            ? Center(child: Text("loading..."))
            //else
            : Container(
                child: ListView(
                  children: [
                    //if data is ready
                    ListView.builder(
                        itemCount: notes.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: ListTile(
                              // leading: CircleAvatar(
                              //   backgroundColor: Colors.yellow,
                              //   child: Icon(Icons.keyboard_arrow_right),
                              // ),
                              title: Text("${notes[i]['title']}"),
                              subtitle: Text("${notes[i]['note']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton( // go to edite page andsend par
                                    onPressed: ()   {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context)=>
                                        //send parameters to edite class constractor
                                            edit_note(
                                        //constractor parameters
                                          note:notes[i]['note'] ,
                                          title: notes[i]['title'],
                                          id:notes[i]['id'] ,
                                          color:notes[i]['color'] ,
                                        )

                                        )
                                      );
                                    },
                                    icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      // int response = await sqldb.deleteData(
                                      //     "DELETE FROM mynotes WHERE id =${notes[i]['id']}"); //delete from db
                                      int response = await sqldb.delete("mynotes",
                                          "id =${notes[i]['id']}");

                                      if (response > 0) {
                                        notes.removeWhere((element) =>
                                            element['id'] ==
                                            notes[i]['id']); //delete from ui
                                        setState(() {
                                          //refresh ui
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ));
  }
}

//this way caller future builder or snapshot
//this way of display data work fine but i used above coz this way do refresh (call pae after delete item )
//and it cost mone i it was online
//this code below used future builder to display map list

// import 'package:flutter/material.dart';
// import 'package:simple_notekeeper/database/LocalDB.dart';
//
// class simple_list extends StatefulWidget {
//   @override
//   State<simple_list> createState() => _simple_listState();
// }
//
// class _simple_listState extends State<simple_list> {
//   SqlDb sqldb = new SqlDb();
//
//   //normal function  map list of type future
//   //we can reciveapi data or an map data in this function
//   Future<List<Map>> _readData() async {
//     List<Map> response = await sqldb.readData("SELECT * FROM mynotes");
//     return response;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.of(context).pushNamed("addnote");
//           },
//           tooltip: 'Add Note',
//           child: Icon(Icons.add),
//         ),
//         appBar: AppBar(
//           title: Center(
//             child: Text(
//               'notes list',
//               style: TextStyle(
//                 color: Colors.blueGrey,
//               ),
//             ),
//           ),
//           backgroundColor: Colors.yellow,
//         ),
//         body: Center(
//             child: Container(
//               child: ListView(
//                 children: [
//                   FutureBuilder(
//                       future: _readData(), //read the list from above function it take map
//                       builder: (BuildContext context,
//                           AsyncSnapshot<List<Map>> snapshot) {
//                         //assign list to snapshot of same type
//                         if (snapshot.hasData) {
//                           //if data is ready
//                           return ListView.builder(
//                               itemCount: snapshot.data!.length,
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemBuilder: (context, i) {
//                                 return Card(
//                                   child: ListTile(
//                                     title: Text("${snapshot.data![i]['title']}"),
//                                     subtitle: Text("${snapshot.data![i]['note']}"),
//                                     trailing: IconButton(
//                                       onPressed: () async {
//                                         int response = await sqldb.deleteData(
//                                             "DELETE FROM mynotes WHERE id =${snapshot.data![i]['id']}");
//                                         if (response > 0) {
//                                           Navigator.of(context).pushReplacement(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       simple_list()));
//                                         }
//                                       },
//                                       icon: Icon(Icons.delete, color: Colors.red),
//                                     ),
//                                   ),
//                                 );
//                               });
//                         }
//                         return Center(child: CircularProgressIndicator());
//                       })
//                 ],
//               ),
//             )));
//   }
// }
//
