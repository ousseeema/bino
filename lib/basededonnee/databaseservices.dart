import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
//reference to our collection if she existe else create une collection avec le nom de user
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
// references to our group collection
  final CollectionReference offreCollection =
      FirebaseFirestore.instance.collection("offers");
  //references a la collection rendezvous
  final CollectionReference rendezvous =
      FirebaseFirestore.instance.collection("rendezvous");
  final CollectionReference confermation =
      FirebaseFirestore.instance.collection("confermation");
// creating rendezvous's details dans la collection rendezvous
  Future creatingrendezvous(String username, String residancyname,
      String nomutilisateur, String time) async {
    return await rendezvous.doc().set({
      "username": username,
      "residancyname": residancyname,
      "nomutlisateur": nomutilisateur,
      "timerendezvous": time,
    });
  }

  // creating collelection confermation
  Future creatingconfermation(
      String residance, String date, String time, String namerend,String owner) async {
    return await confermation.doc().set({
     "nameofperson" : namerend,
     "timeofmeeting":time,
     "dateofmeeting": date,
     "residance":residance,
     "owner":owner,



    });
  }
//creating  the user data when he create an account

  Future createUserData(String fullname, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": fullname,
      "email": email,
      "offres": [],
      "profilpic": "",
      "uid": uid,
    });
  }

  // reccupere data de user pour tester si le email donnee dans la login
  //page est existe ou non dans la base de donne
  // yyanni trajaali el doc eli fih email eli aadyt lors de lappel de la fionction
  Future gettingUserData(email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  // getting user data dapres l uid pour la page details offers
  Future gettingDataUser(uid) async {
    QuerySnapshot snapshot =
        await userCollection.where("uid", isEqualTo: uid).get();
    return snapshot;
  }

  Future creatingOffre(
    String username,
    String id,
    String type,
    String wifi,
    String electricandwater,
    String telephone,
    String nombrelait,
    String etage,
    String nomresidance,
    String dispode,
    String jusqua,
    String email,
    String montant,
  ) async {
    // cette fonction est appellee lors de la click sur le buttom  de create dans le box de dialoge avec un nom valide
    DocumentReference groupDocumentReference = await offreCollection.add({
      //rference a nootre collection "offer" pour ajoute un document qui a comme attrubie group name et id de currene user user name
      "id": id,
      "name": username,
      "residancy name": nomresidance,
      "type": type,
      "email": email,
      "phonenumber": telephone,
      "price for one month": montant,
      "floor number": etage,
      "electric and water bills": electricandwater,
      "wifi": wifi,
      "nombre de personne max": nombrelait,
      "dispo from": dispode,
      "dispo to ": jusqua,
    });

    // updating user collection baaed ma kamlt 7atit esm el group w id w members fo document nemshy ll user collection  attrubie grroup nzyd uid de groupe fiha
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "offres": FieldValue.arrayUnion(["${groupDocumentReference.id}_$type"]),
    });
  }

 
}
