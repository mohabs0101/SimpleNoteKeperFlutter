import 'package:flutter/material.dart';
 import 'package:simple_notekeeper/database/LocalDB.dart';

//this page for testingcrud on db watch the resolte in console output


class dbtest extends StatelessWidget {
  SqlDb sqldb = new SqlDb();

  @override
  Widget build(BuildContext context) {

return Scaffold(

  appBar:AppBar(
    title: Center(
      child:   Text('db tester',

        style: TextStyle(

          color: Colors.blueGrey,

        ),



      ),
    ),

    backgroundColor: Colors.yellow,
  ),
body: Center(
      child: Container(
          padding: EdgeInsets.only(left: 10.0, top: 10.0),
          alignment: Alignment.center,
          color: Colors.black,
          child: Column(

            children: <Widget>[
SizedBox(height: 20.0),
              Row(

                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('insert'),
                      onPressed: () async{
                        int response =await sqldb.insertData("INSERT INTO 'mynotes' ('note','title','color') VALUES ('NOTE ONE','title one','red')");
                        print(response);
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('select'),
                      onPressed: () async{
                        List<Map> response =await sqldb.readData("SELECT * FROM 'mynotes'");
                        print("$response");

                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('update'),
                      onPressed: ()async{
                        int response =await sqldb.updateData("UPDATE  'mynotes' SET 'note' ='note 3 updated'  WHERE id=1");
                        print(response);

                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text('delete'),
                      onPressed: ()async{
                        int response =await sqldb.deleteData("DELETE FROM 'mynotes' WHERE id=1");
                        print(response);

                      },
                    ),
                  ),


                ],
              ),
              Row(

                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Delete database'),
                      onPressed: () async{
                       await sqldb.DBDelete();

                      },
                    ),
                  ),


                ],
              ),
           ]
          )))




);


  }
}





