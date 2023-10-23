// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'basededonnee/databaseservices.dart';
import 'widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class appointmentTile extends StatefulWidget {
  String utilisateur;
  String time;
  String resdancename;
  String iddoc;
  String owner;
  appointmentTile(
      {super.key,
      required this.utilisateur,
      required this.time,
      required this.resdancename,
      required this.iddoc,
      required this.owner});

  @override
  State<appointmentTile> createState() => _appointmentTileState();
}

class _appointmentTileState extends State<appointmentTile> {
  final formkey = GlobalKey<FormState>();

  String daterendez = "";
  String timerendez = "";

  popupvalide() {
    return showDialog( // dialog box qui contient la date de rendez vous et le temps de rendez vous 
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Acceptation "),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.deepOrange[200],
            content: Form(
                key: formkey,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextFormField(
                    maxLength: 8,
                    decoration: const InputDecoration(
                      label: Text(
                        'Date of appointment  ',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      // le icon de email fixed dans le debut de la champs de text
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),

                      // la decoration lorsque en clik sur le champs de text
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),

                      // decration de champs de text lorsque on ne clik pas sur elle
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 2),
                      ),
                    ),
                    onChanged: ((value) {
                      //on change le state de le champs lors de lecriteur de l utilisateur
                      setState(() {
                        daterendez = value;
                      });
                    }),
                    validator: (value) {
                      (value!.length != 8)
                          ? "verifie la date ou la form denla date "
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLength: 5,
                    decoration: const InputDecoration(
                      label: Text(
                        'Time of appointment  :',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                      // le icon de email fixed dans le debut de la champs de text
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),

                      // la decoration lorsque en clik sur le champs de text
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),

                      // decration de champs de text lorsque on ne clik pas sur elle
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepOrange, width: 2),
                      ),
                    ),
                    onChanged: ((value) {
                      //on change le state de le champs lors de lecriteur de l utilisateur
                      setState(() {
                        timerendez = value;
                      });
                    }),
                    validator: (value) {
                      (value!.length != 5) ? "verifie votre temps" : null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(// deux buttom de rfuse et accepte 
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async {
                            DatabaseService(
                                    uid: FirebaseAuth.instance.currentUser!.uid)
                                .creatingconfermation(
                                    widget.resdancename,
                                    daterendez,
                                    timerendez,
                                    widget.utilisateur,
                                    widget.owner);

                            Navigator.pop(context);
                            showsnackbar(context, Colors.green[200], "Acceptation envoye");

                            await Future.delayed(const Duration(seconds: 3),
                                () {
                              FirebaseFirestore.instance
                                  .collection("rendezvous")
                                  .doc(widget.iddoc)
                                  .delete();
                            });
                          },
                          icon: const Icon(Icons.done)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel)),
                    ],
                  )
                ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(// la form de la container qui contient les information de rendez vous 
      padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
      margin: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
      decoration: BoxDecoration(
        color: Colors.deepOrange[100],
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Column(children: [
        Row(
          children: [
            const Text("Name of person :  ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17)),
            const SizedBox(width: 20),
            Text(widget.utilisateur,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text("Name of residance :  ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                )),
            const SizedBox(width: 20),
            Text(widget.resdancename,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const Text("Time of request:  ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                )),
            const SizedBox(width: 20),
            Text(widget.time.substring(0, 19),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                popupvalide();// fonction qui va return un widget de contient les information a remplir lors de l'acceptation
              },
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              child: const Text("Accepte"),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                   showsnackbar(context, Colors.red, "Demande refuse");
                  // supprime le rendez vous de la data base et de la rendez vous list 
                  await FirebaseFirestore.instance
                      .collection("rendezvous")
                      .doc(widget.iddoc)
                      .delete();
                      
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                child: const Text("Refuse")),
          ],
        )
      ]),
    );
  }
}
