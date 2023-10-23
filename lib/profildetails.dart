import 'rendezvous.dart';
import 'basededonnee/auth.dart';
import 'package:flutter/material.dart';

import 'boitecinfermation.dart';
import 'homepage.dart';
import 'loginpage.dart';

class profildetails extends StatefulWidget {
  String username;
  String email;
  profildetails({super.key, required this.email, required this.username});

  @override
  State<profildetails> createState() => _profildetailsState();
}

class _profildetailsState extends State<profildetails> {
  authService authservice = authService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("profil details"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange[200],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Center(
              child: Icon(
            Icons.account_circle,
            size: 150.0,
            color: Colors.deepOrange,
          )),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: [
                const Text(
                  "Username : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(widget.username),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: [
                const Text(
                  "Email : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(widget.email),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: const [
                Text("Location : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  width: 15,
                ),
                Text("Mahdia "),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: const [
                Text(" Adresse complete : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  width: 10,
                ),
                Text("Hiboun , Mahdia , Tunisie"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: const [
                Text("Numero de telephone  : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  width: 15,
                ),
                Text("97388***"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: const [
                Text("Numero cin  : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  width: 15,
                ),
                Text("14755***"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 10, 20, 20),
            child: Row(
              children: const [
                Text("Id dans l'application : ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(
                  width: 15,
                ),
                Text("ABJ5879M"),
              ],
            ),
          ),
        ],
      ),
      // drawer
      drawer: Drawer(
          shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20) )),

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
                //icons OFFERS si je click sur le buttom il ma affiche les groupe entre dans eux
                onTap: () {
                  // function quii declanche lorsque on tap sur le tile list
                  Navigator.pushReplacement(
                      //
                      context,
                      MaterialPageRoute(
                          builder: ((context) => rendezvous(
                              username: widget.username,
                              email: widget.email))));
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
                //icons boite si je click sur le buttom il ma affiche les confermation
                
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (((context) => confermationrendez(email: widget.email, username: widget.username)))));

                },

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
                selected: true,
                selectedColor: Colors.white,
                //icon account <ith text inside the list tile  take us  to see details  of the user
                onTap: () {
                  // function quii declanche lorsque on tap sur le tile list
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
