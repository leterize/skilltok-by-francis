import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/video_model.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  bool _isUploading = false;

  Future<void> _uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      setState(() => _isUploading = true);

      try {
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref('videos/$fileName.mp4')
            .putFile(file);

        String downloadURL = await snapshot.ref.getDownloadURL();

        // Create video model
        VideoModel video = VideoModel(
          id: fileName,
          title: _titleController.text.trim(),
          path: downloadURL,
          uploaderId: 'demo_user', // Replace with real auth user later
          uploaderName: 'Demo User',
          uploadDate: DateTime.now(),
        );

        await FirebaseFirestore.instance
            .collection('videos')
            .doc(video.id)
            .set(video.toMap());

        Navigator.pop(context, video);
      } catch (e) {
        print("Upload failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload video')),
        );
      } finally {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Skill Video')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Enter video title'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text(_isUploading ? 'Uploading...' : 'Pick & Upload Video'),
              onPressed: _isUploading ? null : _uploadVideo,
            ),
          ],
        ),
      ),
    );
  }
}