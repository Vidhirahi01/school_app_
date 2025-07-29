import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

import 'utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_app_/screens/s_Home_Screen.dart';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Profile());
}

class Profile extends StatefulWidget {
  Profile({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController travelModeController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedValue = 1;
  Uint8List? _image;
  String? _imageUrl;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<String?> uploadImageToStorage(String uid, Uint8List file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/$uid.jpg');
      UploadTask uploadTask =
          ref.putData(file, SettableMetadata(contentType: 'image/jpeg'));

      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Clear previous data
    setState(() {
      widget.nameController.clear();
      widget.classController.clear();
      widget.rollNoController.clear();
      widget.dobController.clear();
      widget.contactController.clear();
      widget.emailController.clear();
      widget.addressController.clear();
      widget.travelModeController.clear();
      widget.heightController.clear();
      widget.weightController.clear();
      _imageUrl = null; // Reset the image URL
    });

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        widget.nameController.text = userDoc['name'] ?? '';
        widget.classController.text = userDoc['class'] ?? '';
        widget.rollNoController.text = userDoc['roll_no'] ?? '';
        widget.dobController.text = userDoc['dob'] ?? '';
        widget.contactController.text = userDoc['contact'] ?? '';
        widget.emailController.text = userDoc['email'] ?? '';
        widget.addressController.text = userDoc['address'] ?? '';
        widget.travelModeController.text = userDoc['travel_mode'] ?? '';
        widget.heightController.text = userDoc['height'] ?? '';
        widget.weightController.text = userDoc['weight'] ?? '';
        _imageUrl = userDoc['profile_image']; // Load the image URL
      });
    }
  }

  Future<void> saveProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    if (widget.nameController.text.isEmpty ||
        widget.classController.text.isEmpty ||
        widget.rollNoController.text.isEmpty ||
        widget.dobController.text.isEmpty ||
        widget.contactController.text.isEmpty ||
        widget.emailController.text.isEmpty ||
        widget.addressController.text.isEmpty ||
        widget.heightController.text.isEmpty ||
        widget.weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    String? imageUrlToSave = _imageUrl; // Start with existing URL

    // Upload image only if a new image is selected
    if (_image != null) {
      imageUrlToSave = await uploadImageToStorage(currentUser.uid, _image!);
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'name': widget.nameController.text,
        'class': widget.classController.text,
        'roll_no': widget.rollNoController.text,
        'dob': widget.dobController.text,
        'contact': widget.contactController.text,
        'email': widget.emailController.text,
        'address': widget.addressController.text,
        'travel_mode': widget.travelModeController.text,
        'height': widget.heightController.text,
        'weight': widget.weightController.text,
        'profile_image': imageUrlToSave, // Use the determined URL
      }, SetOptions(merge: true)); // Merges data instead of overwriting

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Saved Successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const S_Home()),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            (_image != null)
                ? CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(_image!),
                  )
                : (_imageUrl != null && _imageUrl!.isNotEmpty)
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_imageUrl!),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/boy.png'),
                      ),
            Positioned(
              left: 80,
              child: IconButton(
                  onPressed: selectImage, icon: const Icon(Icons.add_a_photo)),
            ),
            const SizedBox(height: 20),
            buildTextField(widget.nameController, "Name"),
            buildTextField(widget.classController, "Class-Division"),
            Row(
              children: [
                Expanded(
                    child: buildTextField(widget.rollNoController, "Roll No.")),
                const SizedBox(width: 10),
                Expanded(child: buildTextField(widget.dobController, "DOB")),
              ],
            ),
            buildTextField(widget.contactController, "Contact",
                keyboardType: TextInputType.phone),
            buildTextField(widget.emailController, "E-mail",
                keyboardType: TextInputType.emailAddress),
            buildTextField(widget.addressController, "Address", maxLines: 3),
            buildTravelModeSelector(),
            Row(
              children: [
                Expanded(
                    child: buildTextField(widget.heightController, "Height")),
                const SizedBox(width: 10),
                Expanded(
                    child: buildTextField(widget.weightController, "Weight")),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildTravelModeSelector() {
    return Row(
      children: [
        Radio(
          value: 0,
          groupValue: _selectedValue,
          onChanged: (value) => setState(() => _selectedValue = value!),
        ),
        const Text("By Own", style: TextStyle(color: Colors.white)),
        Radio(
          value: 1,
          groupValue: _selectedValue,
          onChanged: (value) => setState(() => _selectedValue = value!),
        ),
        const Text("Rickshaw/Van", style: TextStyle(color: Colors.white)),
        Radio(
          value: 2,
          groupValue: _selectedValue,
          onChanged: (value) => setState(() => _selectedValue = value!),
        ),
        const Text("By Bus", style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
