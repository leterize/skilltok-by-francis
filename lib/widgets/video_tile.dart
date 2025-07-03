import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/video_model.dart';

class VideoTile extends StatefulWidget {
  final VideoModel video;
  final VoidCallback? onLike;

  const VideoTile({
    required this.video,
    this.onLike,
    Key? key,
  }) : super(key: key);

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.path)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleLike() {
    setState(() {
      widget.video.isLiked = !widget.video.isLiked;
      if (widget.video.isLiked) {
        widget.video.likeCount += 1;
      } else {
        widget.video.likeCount -= 1;
      }
    });

    if (widget.onLike != null) widget.onLike!();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            const Center(child: CircularProgressIndicator()),

          ListTile(
            title: Text(widget.video.title),
            subtitle: Text(
              "Uploaded by ${widget.video.uploaderName}\nLikes: ${widget.video.likeCount}",
              style: const TextStyle(fontSize: 12),
            ),
            trailing: IconButton(
              icon: Icon(
                widget.video.isLiked ? Icons.favorite : Icons.favorite_border,
                color: widget.video.isLiked ? Colors.red : null,
              ),
              onPressed: toggleLike,
            ),
          ),
        ],
      ),
    );
  }
}