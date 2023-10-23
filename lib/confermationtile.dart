import 'package:flutter/material.dart';


class confermationtile extends StatefulWidget {
  String dateofmeeting;
  String nameofperson;
  String owner;
  String residance;
  String timeofmeeting;
  confermationtile(
      {super.key,
      required this.owner,
      required this.nameofperson,
      required this.residance,
      required this.dateofmeeting,
      required this.timeofmeeting});

  @override
  State<confermationtile> createState() => _confermationtileState();
}

class _confermationtileState extends State<confermationtile> {
  popupdetails() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("About appointment"),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.deepOrange[100],
            content: Column(
              
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Hello Mr ${widget.nameofperson}", style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                const SizedBox(height: 5,),
                Text("You have an appointment "),
                const SizedBox(height: 5,),
                Text( "with the owner Mr ${widget.owner}  "),
                const SizedBox(height: 5,),
                Text("The ${widget.dateofmeeting}"),
                const SizedBox(height: 5,),
                Text("At ${widget.timeofmeeting} in ${widget.residance} residance"),
                const SizedBox(height: 5,),
                const Text("Please be there for the appointment ", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold ),)
               

              ]
            ),


          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        onTap: () {
          popupdetails();
        },
        leading: Icon(
          Icons.notification_important,
          color: Colors.red[600],
          size: 40,
        ),
        title: const Text("You have one message from ",
            style: TextStyle(color: Colors.white)),
        subtitle: Text(
          widget.owner,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.deepOrange[200],
      ),
    );
  }
}
