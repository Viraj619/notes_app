
import 'dart:io';

import 'package:notes/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DbheplerPage {
  DbheplerPage._();
  static final String TABLE_NOTE="note";
  static final  String COLUMN_NOTE_S_NO="s_no";
  static final String COLUMN_NOTE_TITLE="title";
  static final String COLUMN_NOTE_DESC="desc";

  static DbheplerPage getInstance()=> DbheplerPage._();
  Database? mDb;
  Future<Database>getDB()async{
    mDb??=await openDB();
    return mDb!;
  }
  Future<Database>openDB()async{
    Directory appDir= await getApplicationDocumentsDirectory();
    String dbPath=join(appDir.path,"notesDb.db");
    return await openDatabase(dbPath,onCreate: (db,version){
      db.execute("create table $TABLE_NOTE ( $COLUMN_NOTE_S_NO integer primary key autoincrement , $COLUMN_NOTE_TITLE text , $COLUMN_NOTE_DESC text)");
    },version: 1);
  }
  Future<bool>addNotes({required NotesModel newNotes})async{
    var mDb= await getDB();
   int rowEffected = await mDb.insert(TABLE_NOTE,newNotes.toMap());
    return rowEffected>0;
  }
  Future<bool>updateNotes({required NotesModel updatedNotes,required sno})async{
    var mDb= await getDB();
    int rowEffected = await mDb.update(TABLE_NOTE,updatedNotes.toMap(),where: '$COLUMN_NOTE_S_NO=?',whereArgs: [sno]);
    return rowEffected>0;
  }
  Future<bool>delete({required int sno})async{
    var mDb= await getDB();
    int rowEffected = await mDb.delete(TABLE_NOTE,where: "$COLUMN_NOTE_S_NO=?",whereArgs: [sno]);
    return rowEffected>0;
  }
  Future<List<NotesModel>> fatchAllNotes()async{
    var mDb=await getDB();
   var data= await mDb.query(TABLE_NOTE);
   List<NotesModel> mNotes=[];
   for(Map<String,dynamic> eachData in data){
     NotesModel eachNotes=NotesModel.fromMap(eachData);
     mNotes.add(eachNotes);

   }
   return mNotes;

  }
}

