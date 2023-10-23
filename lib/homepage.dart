import 'rendezvous.dart';
import 'searchpage.dart';
import 'widget/grouptile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'profildetails.dart';
import 'searchpage.dart';
import 'basededonnee/auth.dart';
import 'basededonnee/databaseservices.dart';
import 'widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'boitecinfermation.dart';
import 'helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formkey = GlobalKey<FormState>();
  authService authservice = authService();
  String username = "";
  String email = "";
  String typeofhome = "";
  String montant = "";
  String disponiblede = "";
  String jusqua = "";
  String electricandwater = "";
  String wifi = "";
  String nomberdelait = "";
  String telephone = "";
  String contactemail = "";
  String nomresidance = "";
  String etage = "";

  Stream? offers;

  getuserdetails() async {
    await HelperFunction.getuseremailkeyfromsf().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunction.getusernamefromSf().then((value) {
      setState(() {
        username = value!;
      });
    });
  }

  @override
  void initState() {
    getuserdetails();

    super.initState();
  }

  getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  //lors de la premiere fois de utilisation de lapp
  nogroupWidget() {
    // if le personne qui utlise le application est n'a pas un groupe ou il quite tout les group qui il appartient
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        //column pour mettre les element foug baadhhom ema kol ma nkaber fi taille mta text kol ma column tzyd takber aala jnab
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                popupdialoge(
                    context); // if lr utilisateur click sur le buttom + au centre de ecran
              },
              child: const Icon(Icons.add_circle,
                  size: 75, color: Colors.deepOrange)),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "you've not joined any group yet!, Tap on the add icon to create an offer ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // the main role is to affiche the list of group that the user is goined in !
  groupList() {
    return StreamBuilder(
      //creating a strem to the collection offers
      stream: FirebaseFirestore.instance.collection("offers").snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                int inverseindex = snapshot.data.docs.length - index - 1;
                DocumentSnapshot offer = snapshot.data.docs[inverseindex];
                return GroupTile(
                    montant: offer["price for one month"],
                    telephone: offer["phonenumber"],
                    email: offer["email"],
                    disponiblede: offer["dispo from"],
                    electricandwater: offer["electric and water bills"],
                    etage: offer["floor number"],
                    jusqua: offer["dispo to "],
                    nomberdelait: offer["nombre de personne max"],
                    wifi: offer["wifi"],
                    type: offer["type"],
                    resdenanceName: offer["residancy name"],
                    userName: offer["name"]);
              });
        } else {
          return nogroupWidget();
        }
      },
    );
  }

  popupdialoge(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.deepOrange[200],
            title: const Text(
              "Add your home :",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.left,
            ),
            content: Form(
              key: formkey,
              child: Column(
                children: [
                  //champ type
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Type :',
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
                        typeofhome = value;
                      });
                    }),
                    validator: (value) {
                      (value != "s+0" ||
                              value != "s+1" ||
                              value != "s+2" ||
                              value != "s+3" ||
                              value != "s+4")
                          ? "verifie s+0,s+1,s+2,s+3,s+4"
                          : null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //champs de nom de resedance
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Name of residancy :',
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
                        nomresidance = value;
                      });
                    }),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // champs de montant
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Price per/month :',
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
                        montant = value;
                      });
                    }),
                  ),

                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Electrecity and Water  per/month :',
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
                        electricandwater = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Wifi :',
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
                        wifi = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Floor number  :',
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
                        etage = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Disponible from  :',
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
                        disponiblede = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Disponible to :',
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
                        jusqua = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Phone number  :',
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
                        telephone = value;
                      });
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Email :',
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
                        contactemail = value;
                      });
                    }),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Maximum number of people :',
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
                        nomberdelait = value;
                      });
                    }),
                  ),
                ],
              ),
            ),
            actions: [
              //icons de creation et anunnlation
              TextButton.icon(
                  onPressed: () {
                    // if details has been declareted we will create a document in offre collection with  the details
                    if (typeofhome != "" &&
                        montant != "" &&
                        contactemail != "" &&
                        etage != "" &&
                        telephone != "" &&
                        nomberdelait != "" &&
                        disponiblede != "" &&
                        jusqua != "" &&
                        wifi != "" &&
                        electricandwater != "" &&
                        nomresidance != "") {
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .creatingOffre(
                              username,
                              FirebaseAuth.instance.currentUser!.uid,
                              typeofhome,
                              wifi,
                              electricandwater,
                              telephone,
                              nomberdelait,
                              etage,
                              nomresidance,
                              disponiblede,
                              jusqua,
                              email,
                              montant) //baaed ma nkml nfaskh el contenu mtaa kol variable
                          .whenComplete(() {
                        typeofhome = "";
                        montant = "";
                        contactemail = "";
                        etage = "";
                        telephone = "";
                        nomberdelait = "";
                        disponiblede = "";
                        jusqua = "";
                        wifi = "";
                        electricandwater = "";
                        nomresidance = "";
                      });
                      Navigator.of(context).pop();
                      showsnackbar(context, Colors.green,
                          "offre has been  added successfully.");
                    } else {
                      //else affiche un snackbar  d'erruer
                      showsnackbar(context, Colors.red,
                          "Cheeck your offre details or your connection Please!");
                    }
                  },
                  icon: const Icon(
                    Icons.create,
                    color: Colors.white,
                  ),
                  label: const Text("Done",
                      style: TextStyle(color: Colors.white))),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //buttom search
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const searchPage())));
              },
              icon: const Icon(Icons.search)),
        ],
        // les propr de appbar
        elevation: 0,
        backgroundColor: Colors.deepOrange[200],
        centerTitle: true,
        title: const Text(
          "Offres",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),

      //jdjdjd
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
                "User Name:  $username",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "User Email :  $email",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                //icons groups si je click sur le buttom il ma affiche les groupe entre dans eux
                onTap: () {},
                selected: true,
                selectedColor: Colors.white,

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
                          builder: ((context) =>
                              rendezvous(username: username, email: email))));
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (((context) => confermationrendez(
                              email: email, username: username)))));
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
                //icon account <ith text inside the list tile  take us  to see details  of the user
                onTap: () {
                  // function quii declanche lorsque on tap sur le tile list
                  Navigator.pushReplacement(
                      //
                      context,
                      MaterialPageRoute(
                          builder: ((context) => profildetails(
                                email: email,
                                username: username,
                              ))));
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
      body: groupList(),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange[200],
        onPressed: () {
          popupdialoge(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
