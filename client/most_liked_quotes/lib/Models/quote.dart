class Quote {
  int id;
  String content;
  int upVotes;
  int downVotes;

  Quote({
    required this.id,
    required this.content,
    required this.upVotes,
    required this.downVotes,
  });

  factory Quote.fromLine(String line) {
    List<String> params = line.split("\"");
    String content = params[1].trim();
    int id = int.parse(params[0].trim());
    List<String> params2 = params[2].trim().split(" ");
    int upVotes = int.parse(params2[0].trim());
    int downVotes = int.parse(params2[1].trim());

    return Quote(id: id, content: content, upVotes: upVotes, downVotes: downVotes);
  }
}
