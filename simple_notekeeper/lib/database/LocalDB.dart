
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
//all we do here is get database object to do crud but when we get it check if i created or not if not we initialize it
class SqlDb {//class name

  static Database? _db ;//? mean allow null - we create object of database this object maybe null or not


  //check _db if null r not
  //here we get db to use it on crud
  Future<Database?> get db async {
    if (_db == null){
      _db  = await intialDb() ;
      return _db ;
    }else {
      return _db ;
    }
  }
//now db represend the database to use it in crud

  intialDb() async {
    String databasepath = await getDatabasesPath() ;
    String path = join(databasepath , 'NoteKeeper.db') ;//path +database name
    Database mydb = await openDatabase(path , onCreate: _onCreate , version:8 , onUpgrade:_onUpgrade ) ;
    return mydb ;
  }

  _onUpgrade(Database db , int oldversion , int newversion ) async{
//this function called only when change the version above
//here i can create more tables or edite existing tables

//  await db.execute("ALTER TABLE mynotes ADD COLUMN color TEXT");
    print("onUpgrade =====================================") ;

  }
//this will excute only one
  _onCreate(Database db , int version) async {
    Batch batch = db.batch();

    batch.execute('''
  CREATE TABLE "mynotes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL,
      "color" TEXT NOT NULL 
  )
 ''') ;
 //    batch.execute('''
 //  CREATE TABLE "mynotes2" (
 //    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT,
 //    "title" TEXT NOT NULL,
 //    "note" TEXT NOT NULL,
 //
 //  )
 // ''') ;
   await batch.commit();
    print(" onCreate =====================================") ;

  }
  //here we use db to do all crud operations way 1 i used it from db tester
//mothods of crud raw functions
  readData(String sql) async {//this recive sql query
    Database? mydb = await db ;//asign db to mydb var
    List<Map> response = await  mydb!.rawQuery(sql);//! mean iam respansale of the mydb not null -excute query and return response -type of response is map
    return response ;//if return 0 mean not excuted else is number of row id
  }
  insertData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawInsert(sql);
    return response ;
  }
  updateData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawUpdate(sql);
    return response ;
  }
  deleteData(String sql) async {
    Database? mydb = await db ;
    int  response = await  mydb!.rawDelete(sql);
    return response ;
  }

  //query methods way 2
  read(String table) async {//this recive table name
    Database? mydb = await db ;//asign db to mydb var
    List<Map> response = await  mydb!.query(table);//! mean iam respansale of the mydb not null -excute query and return response -type of response is map
    return response ;//if return 0 mean not excuted else is number of row id
  }
  insert(String table ,Map<String, Object?> values) async {
    Database? mydb = await db ;
    int  response = await  mydb!.insert(table,values);
    return response ;
  }
  update(String table,Map<String, Object?> values,String? mywhere) async {
    Database? mydb = await db ;
    int  response = await  mydb!.update(table,values,where :mywhere);
    return response ;
  }
  delete(String table,String?mywhere) async {
    Database? mydb = await db ;
    int  response = await  mydb!.delete(table,where: mywhere);
    return response ;
  }




//func for deleting the database
  //i call it when i want to recreate the database in case of adding new columns of tables
  DBDelete()async {
     String _databases=await getDatabasesPath();
    String path = join(_databases , 'NoteKeeper.db') ;//path +database name
    await deleteDatabase(path);


  }

// SELECT
// DELETE
// UPDATE
// INSERT


}