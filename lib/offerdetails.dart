// ignore_for_file: use_build_context_synchronously

import 'searchpage.dart';
import 'basededonnee/databaseservices.dart';
import 'widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class offerdetails extends StatefulWidget {
  final String userName;
  final String resdenanceName;
  final String type;
  final String email;
  final String montant;
  final String disponiblede;
  final String jusqua;
  final String electricandwater;
  final String wifi;
  final String nomberdelait;
  final String telephone;
  final String etage;
  const offerdetails(
      {super.key,
      required this.montant,
      required this.telephone,
      required this.email,
      required this.disponiblede,
      required this.electricandwater,
      required this.etage,
      required this.jusqua,
      required this.nomberdelait,
      required this.wifi,
      required this.type,
      required this.resdenanceName,
      required this.userName});

  @override
  State<offerdetails> createState() => _offerdetailsState();
}

class _offerdetailsState extends State<offerdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 2.0,
        backgroundColor: Colors.deepOrange[200],
        shadowColor: Colors.black,
        elevation: 20,
        title: const Text("Offre details"),
      ),
      body: ListView(
        children: [
          //container de le nom de la residance
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("The residancy Name  : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.resdenanceName,
                    style: const TextStyle(color: Colors.black))
              ],
            ),
          ),

          //container de le username
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    const Text("The owner :",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17)),
                    const SizedBox(width: 10),
                    Text(widget.userName,
                        style: const TextStyle(color: Colors.black))
                  ],
                ),
              ],
            ),
          ),

          // email de user
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Email: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.email, style: const TextStyle(color: Colors.black))
              ],
            ),
          ),

          // telephone de user
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("phone Number: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.telephone,
                    style: const TextStyle(color: Colors.black))
              ],
            ),
          ),
          //type de maison
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("The type of house  : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.type,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          // nombre detage
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Number of floor : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.etage,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          // nombre de place max
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Maximun number of members: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.nomberdelait,
                    style: const TextStyle(color: Colors.black))
              ],
            ),
          ),
          // montant de electricité et eau
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Electric and water services : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.electricandwater,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          // wifi bloc
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Wi-Fi price: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.wifi,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          // disponinle de
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Available from  : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.disponiblede,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          // jusqua
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("To  : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.jusqua,
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),

          // montant de la maison
          Container(
            padding: const EdgeInsets.fromLTRB(5, 20, 30, 20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              border: Border.all(width: 2.0, color: Colors.white),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Text("Price of the house :",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
                const SizedBox(width: 10),
                Text(widget.montant,
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
          ),
          //icon de rendezvous
          TextButton.icon(
            onPressed: () async {
              QuerySnapshot snapshot = await DatabaseService(
                      uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingDataUser(FirebaseAuth.instance.currentUser!.uid);
                 await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .creatingrendezvous(widget.userName, widget.resdenanceName,
                      snapshot.docs[0]["fullname"], DateTime.now().toString());
              

              // show snack bar de confermation
              showsnackbar(context, Colors.green[200],
                  "The appointment has been taken ");
              //redirectiio, a la page hdes offers
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => const HomePage())));
            },
            icon: const Icon(Icons.phone_android),
            label: const Text("Make appointment !"),
            style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black)),
          ),
          //icon de search
          TextButton.icon(
            // redirection a la page search pour cherche un autre offer
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const searchPage())));
            },
            icon: const Icon(Icons.search),
            label: const Text("Search for more here "),
            style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.black)),
          ),
        ],
      ),
    );
  }
}
