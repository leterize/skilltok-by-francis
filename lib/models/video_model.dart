class VideoModel {
  final String id;
  final String title;
  final String path; // URL or asset path
  final String uploaderId;
  final String uploaderName;
  final DateTime uploadDate;
  int likeCount;
  bool isLiked;

  VideoModel({
    required this.id,
    required this.title,
    required this.path,
    required this.uploaderId,
    required this.uploaderName,
    required this.uploadDate,
    this.likeCount = 0,
    this.isLiked = false,
  });

  // Convert to Firebase Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'uploaderId': uploaderId,
      'uploaderName': uploaderName,
      'uploadDate': uploadDate.toIso8601String(),
      'likeCount': likeCount,
      // isLiked is not stored globally
    };
  }

  // Create from Firebase Map
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      path: map['path'] ?? '',
      uploaderId: map['uploaderId'] ?? '',
      uploaderName: map['uploaderName'] ?? '',
      uploadDate: DateTime.tryParse(map['uploadDate'] ?? '') ?? DateTime.now(),
      likeCount: map['likeCount'] ?? 0,
      isLiked: false, // This is handled locally per user
    );
  }
}