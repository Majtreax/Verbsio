class PhrasalVerb {
  final int id;
  final String verb;
  final String prep;
  final String answer;
  final String question;
  final String definition;
  final List<String> synonyms;
  final List<String> examples;

  PhrasalVerb({
    required this.id,
    required this.verb,
    required this.prep,
    required this.answer,
    required this.question,
    required this.definition,
    required this.synonyms,
    required this.examples,
  });

  factory PhrasalVerb.fromJson(Map<String, dynamic> json) {
    return PhrasalVerb(
      id: json['id'],
      verb: json['verb'],
      prep: json['prep'],
      answer: json['answer'],
      question: json['question'],
      definition: json['definition'],
      synonyms: List<String>.from(json['synonyms']),
      examples: List<String>.from(json['examples']),
    );
  }
}
