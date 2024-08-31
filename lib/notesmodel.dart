

import 'package:notes/database/local/dbhepler_page.dart';

class NotesModel{
 int? sno;
 String title;
 String desc;

 NotesModel({this.sno,required this.title,required this.desc});

 /// map to model
 factory NotesModel.fromMap(Map<String,dynamic>map){
   return NotesModel(sno:map[DbheplerPage.COLUMN_NOTE_S_NO],title:map[DbheplerPage.COLUMN_NOTE_TITLE], desc:map[DbheplerPage.COLUMN_NOTE_DESC]);
 }

 /// model to map
 Map<String,dynamic>toMap()=>{
   DbheplerPage.COLUMN_NOTE_TITLE:title,
   DbheplerPage.COLUMN_NOTE_DESC:desc,
 };
}