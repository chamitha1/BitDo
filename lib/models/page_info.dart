class PageInfo<T> {
  final List<T> list;
  final int total;
  final int pageNum;
  final int pageSize;
  final bool isEnd;

  PageInfo({
    required this.list,
    this.total = 0,
    this.pageNum = 1,
    this.pageSize = 10,
    this.isEnd = false,
  });

  factory PageInfo.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final data = json['data'] != null ? json['data'] as Map<String, dynamic> : json;
    
    final rawList = data['list'] as List<dynamic>? ?? [];
    final list = rawList.map((item) => fromJsonT(item as Map<String, dynamic>)).toList();
    
    final total = data['total'] ?? 0;
    final pages = data['pages'] ?? 0;
    final pageNum = data['pageNum'] ?? 1;
    final isEnd = pageNum >= pages; 

    return PageInfo(
      list: list,
      total: total,
      pageNum: pageNum,
      pageSize: data['pageSize'] ?? 10,
      isEnd: isEnd,
    );
  }
}
