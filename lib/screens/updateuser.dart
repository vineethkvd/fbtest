import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({Key? key}) : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final donorNameController = TextEditingController();
  final donorPhoneController = TextEditingController();
  String? updateSelectedGroup;
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void upadteDonor(docId) {
    final data = {
      'name':  donorNameController.text,
      'phone': donorPhoneController.text,
      'group': updateSelectedGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    donorNameController.text = args?['name'];
    donorPhoneController.text = args?['phone'];
    updateSelectedGroup = args?['group'];
    final docId = args?['id'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update user"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: donorNameController,
              decoration: const InputDecoration(
                labelText: "Donor name",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: donorPhoneController,
              decoration: const InputDecoration(
                labelText: "Phone number",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Selected blood group",
                border: OutlineInputBorder(),
              ),
              value: updateSelectedGroup,
              items: bloodGroups
                  .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  updateSelectedGroup = value as String; // Update selectedGroup here
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              upadteDonor(docId!);
              print(args);
            },
            child: Text("Update"),
          ),
        ],
      ),
    );
  }
}
