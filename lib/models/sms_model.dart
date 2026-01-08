class Sms {
  final String id;
  final String type; // '1' = Announcement, '2' = Notification
  final String title;
  final String content;
  String isRead; // '0' = Unread, '1' = Read
  final String createDatetime;

  Sms({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.isRead,
    required this.createDatetime,
  });

  factory Sms.fromJson(Map<String, dynamic> json) {
    return Sms(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      isRead: json['status']?.toString() ?? '0', 
      createDatetime: json['createDatetime']?.toString() ?? '',
    );
  }
}
