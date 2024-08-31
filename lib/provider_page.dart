
import 'package:flutter/material.dart';
import 'package:notes/database/local/dbhepler_page.dart';
import 'package:notes/notesmodel.dart';

class ProviderPage extends ChangeNotifier{
  DbheplerPage dbHepler;
  ProviderPage({required this.dbHepler});
List<NotesModel> addAllNotes=[];

  /// adding
void addNotes(NotesModel newNotes)async{
  var check=await dbHepler.addNotes(newNotes: newNotes);
  if(check){
    addAllNotes=await dbHepler.fatchAllNotes();
    notifyListeners();
  }
}
  /// update
void update(NotesModel updateNotes,{required int sno})async{
  var check =await dbHepler.updateNotes(updatedNotes: updateNotes, sno: sno);
  if(check){
    addAllNotes=await dbHepler.fatchAllNotes();
    notifyListeners();
  }
}
 /// delete
  void delete({required int sno})async{
  var check=await dbHepler.delete(sno: sno);
  if(check){
    addAllNotes= await dbHepler.fatchAllNotes();
    notifyListeners();
  }
  }
 void getInitialNotes()async{
   addAllNotes=await dbHepler.fatchAllNotes();
   notifyListeners();
 }
 List<NotesModel> getAllNotes()=>addAllNotes;
}