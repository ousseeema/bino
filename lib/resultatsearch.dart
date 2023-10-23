import 'package:bino/widget/grouptile.dart';
import 'package:bino/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class resultatsearch extends StatefulWidget {
  String searchtext;
   resultatsearch({super.key, required this.searchtext});

  @override
  State<resultatsearch> createState() => _resultatsearchState();
}

class _resultatsearchState extends State<resultatsearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[200],
        title:  const Text("your search result ")
       
           ),
      body:  StreamBuilder(
         

        // verifie que la type est cotrrect apres affche le resultat de la recherche entre  apres lutilisateur 
      
        stream:  FirebaseFirestore.instance.collection("offers").snapshots(),
        
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.hasData){
            
            
            return ListView.builder(
              //list view avec les offre entre par lutilisateur 
    
              itemCount: snapshot.data.docs.length,
             itemBuilder: (context, index) {
              int inverseindex = snapshot.data.docs.length - index - 1;
              DocumentSnapshot search = snapshot.data.docs[inverseindex];
              if (widget.searchtext==search["type"]){
                
                // if condition = true appelleee la widget de la crraetion de les offre 
                return GroupTile(montant: search["price for one month"], telephone:  search["phonenumber"], email:  search["email"], disponiblede:  search["dispo from"], electricandwater:  search["electric and water bills"], etage:  search["floor number"], jusqua:  search["dispo to "], nomberdelait:  search["nombre de personne max"], wifi:  search["wifi"], type:  search["type"], resdenanceName:  search["residancy name"], userName:  search["name"]);
              }
              else 
              {
                return const SizedBox(height: 1,);
              }
              

             
            
             
    
               } );
           
            }
               else {
                return const  Center(child: CircularProgressIndicator(color: Colors.deepOrange),);
          }
          
            }),
    ) ;
  }
}