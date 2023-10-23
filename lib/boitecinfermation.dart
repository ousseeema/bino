import 'profildetails.dart';
import 'rendezvous.dart';
import 'basededonnee/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'confermationtile.dart';
import 'homepage.dart';
import 'loginpage.dart';

class confermationrendez extends StatefulWidget {
  String username;
  String email;
  confermationrendez({super.key, required this.email, required this.username});

  @override
  State<confermationrendez> createState() => _confermationrendezState();
}

class _confermationrendezState extends State<confermationrendez> {
  authService authservice = authService();
  confermationlist() {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("confermation").snapshots(),// stream entre la collection confermation dans la base de donnee et le stream builder
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                int inverseindex = snapshot.data.docs.length - index - 1;
                DocumentSnapshot confermation =
                    snapshot.data.docs[inverseindex];
                if (widget.username == confermation["nameofperson"]) {// teste si le nom de utilisateur cest le meme  de la person qui a recu un confermation 
                  return confermationtile(// envoyer les information ala page confermation tile pour puis return un  container qui contient les information ordonnee
                      owner: confermation["owner"],
                      nameofperson: confermation["nameofperson"],
                      residance: confermation["residance"],
                      dateofmeeting: confermation["dateofmeeting"],
                      timeofmeeting: confermation["timeofmeeting"]);
                }
              },
            );
          } else {
            return const Text(
                "you do not have confermation for your appointment");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boite de confermation"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[200],
        elevation: 0,
      ),
      body: confermationlist(),
      // drawer
      drawer: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: Colors.deepOrange[200],
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50),
            children: <Widget>[
              const Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "User Name:  ${widget.username}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "User Email :  ${widget.email}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                //icons groups si je click sur le buttom il ma affiche les groupe entre dans eux
                onTap: () {
                  Navigator.pushReplacement(
                      //
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomePage())));
                },

                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(
                  Icons.list_alt,
                ),
                title:
                    const Text('Offers', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                //icons appointment si je click sur le buttom il ma affiche les rendezvous

                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => rendezvous(
                                username: widget.username,
                                email: widget.email,
                              ))));
                },

                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(
                  Icons.content_paste,
                ),
                title: const Text(
                  'Appointment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                selected: true,
                selectedColor: Colors.white,
                //icons boite si je click sur le buttom il ma affiche les confermation

                onTap: () {},

                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(
                  Icons.message,
                ),
                title: const Text(
                  'Boite de confermation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                //icon account <ith text inside the list tile  take us  to see details  of the user
                onTap: () {
                  // profil avec un click
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (((context) => profildetails(
                                email: widget.email,
                                username: widget.username,
                              )))));
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),

                leading: const Icon(Icons.manage_accounts),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                //logout icons si en click sur cette icons
                // la session ferme et renvoyer vers la page login
                onTap: () async {
                  showDialog(
                      //un widget qui return un dialog box lors de le click sur le buttom loug out

                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          //le dialog box qui return au showdialog with back ground color and shaped bordeer

                          backgroundColor: Colors.deepOrange[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          title: const Text(' Logout '),
                          content:
                              const Text('Are you sure you want to logout '),
                          actions: [
                            // les action que on peut faire sur cette dialog box (yaani iconnuttom with function qui execute lors de le click)

                            IconButton(
                                //icon buttom de annulation de demande de logout
                                onPressed: () {
                                  Navigator.pop(
                                      context); // pop widget de dialog box de lecran et annuler le action de sortir
                                },
                                icon: const Icon(
                                  //icon cancel
                                  Icons.cancel,
                                  color: Colors.red,
                                )),
                            IconButton(
                                //icon buttom de validation de demande de logout
                                onPressed: () async {
                                  await authservice
                                      .logout(); //logout de le auth firebase et efface le shared preference

                                  // ignore: use_build_context_synchronously
                                  Navigator.pushAndRemoveUntil(
                                      // sortir de le compte et affiche le page de login
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const LogInPage())),
                                      (route) => false);
                                },
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )),
                          ],
                        );
                      });
                },

                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(
                  Icons.exit_to_app,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
