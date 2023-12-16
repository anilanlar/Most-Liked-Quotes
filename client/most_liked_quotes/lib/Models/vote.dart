import 'package:most_liked_quotes/Utils/Enums.dart';

class Vote {
  String username;
  VoteType type;

  Vote({
    required this.username,
    required this.type,
  });

  factory Vote.fromLine(String line) {
    List<String> params = line.split(" ");
    VoteType type;
    String username = params[0].trim();
    String stringType = params[1].trim();
    if (stringType.contains("D")) {
      type = VoteType.DISLIKE;
    } else {
      type = VoteType.LIKE;
    }

    return Vote(username: username, type: type);
  }
}
