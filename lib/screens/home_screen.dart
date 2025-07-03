import 'package:flutter/material.dart';
import 'video_feed_screen.dart';
import 'upload_screen.dart';
import 'youtube_search_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎓 SkillTok"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 📺 View Skill Videos (from Firestore)
            ElevatedButton.icon(
              icon: const Icon(Icons.video_library),
              label: const Text("📺 View Skill Videos"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideoFeedScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            // ⬆️ Upload New Skill
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text("⬆️ Upload New Skill"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UploadScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            // 🔍 Search YouTube Skills (Play inside app)
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text("🔍 Search YouTube Skills"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const YouTubeSearchScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            // 👤 My Profile (coming soon)
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text("👤 My Profile (Coming Soon)"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile screen coming soon!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}