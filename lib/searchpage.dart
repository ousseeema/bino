import 'package:bino/resultatsearch.dart';
import 'package:bino/widget/grouptile.dart';
import 'package:bino/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
String searchtext="s+1";
  
  @override
  void initState() {
    super.initState();

    
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("image/font1.jpg"),fit: BoxFit.cover, )
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(// row contient le champs input et le buttom de search 
               children: [
              
                Expanded(
                  flex: 3,
                  child: TextField(// text field 
                    style: const  TextStyle(color: Colors.white),
                    decoration:const  InputDecoration( // decoration de la text field
                      label: Text("search here", style: TextStyle(color: Colors.white),),
                      icon: Icon(Icons.subject,),
                      iconColor:  Colors.white,
                      enabledBorder: OutlineInputBorder
                      (borderSide: BorderSide(color: Colors.white),
                        borderRadius:  BorderRadius.all(Radius.circular(10)),
                      
                      ),
                      disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.white),
                      )  ,
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),
                        borderRadius:  BorderRadius.all(Radius.circular(10)),)
                                       
                      
                      
                    ),
                    onChanged: (value) { searchtext=value;}// dans chaque echange la variable chabge 
                      
                  ),
                ),
               const  SizedBox(width: 10,),
               TextButton(onPressed: () {// text button qui envoyer le search typoe a une autre page search resuoltat pour verifie le soffres et affiche selon le type donne 
               
                 
                  Navigator.push(context, MaterialPageRoute(builder: ((context)=> resultatsearch(searchtext: searchtext))));
                  
                  
                     
               }, 
                 // style de text button  
               style: TextButton.styleFrom(foregroundColor: Colors.white),
               child: const Text("Search")
               ),
                  
                
               ],
                  
                ),
                const SizedBox(height: 20,),
           
                
                 
                 
                
        
                
            ],
          ),
            ),
      ),
      );
    
  }
}