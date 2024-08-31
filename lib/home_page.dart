
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notes/input_page.dart';
import 'package:notes/notesmodel.dart';
import 'package:notes/provider_page.dart';
import 'package:notes/uihelper_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>HomeState();
}
class HomeState extends State<HomePage>{
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProviderPage>().getInitialNotes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff252525),
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Notes",style: mTextStyle20(mFontColor: Colors.white),),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff3B3B3B),
              ),
              child: Center(
                child: IconButton(onPressed: (){

                }, icon: Icon(Icons.search)),
              ),
            ),
          )
        ],
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        child:
            Consumer<ProviderPage>(builder: (_,provider,__){
              List<NotesModel>addAllNotes=provider.getAllNotes();
              return  Container(
                width: double.infinity,
                height: 500,
                child:GridView.builder(
                    itemCount: addAllNotes.length,
                    gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 220
                    ), itemBuilder: (_,index){
                  return Stack(
                    children: [
                      Card(
                        elevation: 5,
                        child: InkWell(
                          onTap: (){
                            titleController.text=addAllNotes[index].title;
                            descController.text=addAllNotes[index].desc;
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>InputPage(page:bottomCoustom(sno:addAllNotes[index].sno!,isUpdate: true),)));
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:Colors.primaries[(Random().nextInt(Colors.primaries.length-1))],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// delete
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed:()async{
                                        context.read<ProviderPage>().delete(sno: addAllNotes[index].sno!);
                                      }, icon:Icon(Icons.close,color: Colors.white,size: 20,))
                                    ],
                                  ),
                                  Text(addAllNotes[index].title,textAlign: TextAlign.start,style: mTextStyle16(),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              );
            },),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white.withOpacity(0.2),
        onPressed: (){
          titleController.clear();
          descController.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>InputPage(page: bottomCoustom(),)));
        },child: Row(
        children: [
          Icon(Icons.add,color: Colors.white,size: 20,),
          Text("Add",style:mTextStyle16(mFontWeight: FontWeight.normal,mFontColor:Colors.white),)
        ],
      ),
      ),
    );
  }
  Widget bottomCoustom({bool isUpdate = false,int sno=0}){
    return Scaffold(
      backgroundColor:Color(0xff252525),
      appBar:AppBar(
        backgroundColor:Color(0xff252525),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xff3B3B3B),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 20,),),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 90,
              height: 40,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xff3B3B3B),
              ),

              /// add and update
              child: TextButton(onPressed: ()async{
                  isUpdate ? context.read<ProviderPage>().update(NotesModel(title: titleController.text, desc:descController.text,), sno: sno) : context.read<ProviderPage>().addNotes(NotesModel(title: titleController.text, desc: descController.text));
                  Navigator.pop(context);
              },child: Text("Save",style: mTextStyle15(mFontColor: Colors.white),),),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(isUpdate ? "Update Notes" : "Add  Notes",style: mTextStyle20(mFontColor: Colors.white),),
              Container(
                width: 400,
                child: TextField(
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText:"Title",hintStyle:TextStyle(fontSize: 50,color: Color(0xff929292)),
                      border: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                width: 400,
                child: TextField(
                  controller: descController,
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  decoration: InputDecoration(
                    hintText: "Type something...",hintStyle: TextStyle(fontSize: 30,color: Color(0xff929292)),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
