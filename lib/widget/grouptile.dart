import 'package:flutter/material.dart';

import '../offerdetails.dart';

class GroupTile extends StatefulWidget {
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
 

  const GroupTile(
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
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    // create a liste tile fi wasta circle avatar w esm el group eli baathta
    // b construct eli fi page home w ki netki 3le kol list group thezni ll chat mtaaha
    return GestureDetector(
      onTap: () {
        // send us to the offre details
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => offerdetails(montant:widget.montant, telephone: widget.telephone, email: widget.email, disponiblede: widget.disponiblede, electricandwater: widget.electricandwater, etage: widget.etage, jusqua: widget.jusqua, nomberdelait: widget.nomberdelait, wifi: widget.wifi, type: widget.type, resdenanceName: widget.resdenanceName, userName: widget.userName))));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsetsDirectional.fromSTEB(7, 7, 7, 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepOrange[200]),
        child: ListTile(
          leading: CircleAvatar(
            // leading fih circle avatar w fi wasetha awel 7aref mn groupname
            backgroundColor: Colors.deepOrange[300],
            radius: 30,
            child: Text(
              widget.type.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
              "THE RESIDANCY NAME: ${widget.resdenanceName.toUpperCase()}", // title mtaa list tile
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(
            //subtitle de listtile
            'Tap to se more details on  ${widget.userName} offre',
            style: const TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 34, 20, 20)),
          ),
        ),
      ),
    );
  }
}
