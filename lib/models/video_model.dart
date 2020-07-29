class Video {
  final String channelName;
  final String title;
  final String description;
  final String publishedDate;
  final String thumbnailImage;
  final String likes;
  final String dislikes;
  final String comments;
  final String views;

  Video(
      {this.likes,
      this.dislikes,
      this.comments,
      this.views,
      this.description,
      this.publishedDate,
      this.thumbnailImage,
      this.title,
      this.channelName});

  factory Video.fromMap(Map<String, dynamic> json) {
    print(json['snippet']['description'].split('\n')[0]);
    return Video(
        title: json['snippet']['title'],
        description: json['snippet']['description'].split('\n')[0],
        publishedDate: json['snippet']['publishedAt'],
        thumbnailImage: json['snippet']['thumbnails']['high']['url'],
        channelName: json['snippet']['channelTitle'],
        likes: json['statistics']['likeCount'],
        dislikes: json['statistics']['dislikeCount'],
        comments: json['statistics']['commentCount'],
        views: json['statistics']['viewCount']);
  }
}
