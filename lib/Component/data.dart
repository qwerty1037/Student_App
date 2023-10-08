class DownloadItems {
  static var homeworks = [
    DownloadItem(
      name: 'Android Programming Cookbook',
      url:
          'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf',
      deadline: DateTime(2023, 10, 12, 23, 59),
      teacherName: 'Junghyun Han',
      problemNum: 1,
    ),
    DownloadItem(
      name: 'iOS Programming Guide',
      url:
          'http://englishonlineclub.com/pdf/iOS%20Programming%20-%20The%20Big%20Nerd%20Ranch%20Guide%20(6th%20Edition)%20[EnglishOnlineClub.com].pdf',
      deadline: DateTime(2023, 10, 12, 23, 59),
      teacherName: 'Junghyun Han',
      problemNum: 1,
    ),
  ];

  static void add({
    required String name,
    required String url,
    required DateTime deadline,
    required String teacherName,
    required int problemNum,
  }) {
    homeworks.add(
      DownloadItem(
        name: name,
        url: url,
        deadline: deadline,
        teacherName: teacherName,
        problemNum: problemNum,
      ),
    );
  }
}

class DownloadItem {
  const DownloadItem({
    required this.name,
    required this.url,
    required this.deadline,
    required this.teacherName,
    required this.problemNum,
  });

  final String name;
  final String url;
  final DateTime deadline;
  final String teacherName;
  final int problemNum;
}
