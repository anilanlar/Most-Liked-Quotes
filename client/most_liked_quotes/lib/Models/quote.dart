class Quote {
  int id;
  String author;
  String content;
  int upVotes;
  int downVotes;
  String upvotedOrDownvoted;

  Quote({
    required this.id,
    required this.author,
    required this.content,
    required this.upVotes,
    required this.downVotes,
    required this.upvotedOrDownvoted,
  });

  factory Quote.fromLine(String line) {
    List<String> params = line.split("-----");
    int id = int.parse(params[0].trim());
    String author = params[1].trim();
    String content = params[2].trim();
    int upVotes = int.parse(params[3].trim());
    int downVotes = int.parse(params[4].trim());
    String upvotedOrDownvoted = params[5].trim();
    return Quote(id: id,author: author, content: content, upVotes: upVotes, downVotes: downVotes, upvotedOrDownvoted:upvotedOrDownvoted);
  }
}
