class ResultSearchModel {
  List<Results>? results;
  int? offset;
  int? number;
  int? totalResults;

  ResultSearchModel({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  ResultSearchModel.fromJson(Map<String, dynamic> json) {
    results = (json['results'] as List?)
        ?.map((dynamic e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
    offset = json['offset'] as int?;
    number = json['number'] as int?;
    totalResults = json['totalResults'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['results'] = results?.map((e) => e.toJson()).toList();
    json['offset'] = offset;
    json['number'] = number;
    json['totalResults'] = totalResults;
    return json;
  }
}

class Results {
  int? id;
  String? title;
  String? image;
  String? imageType;

  Results({
    this.id,
    this.title,
    this.image,
    this.imageType,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    image = json['image'] as String?;
    imageType = json['imageType'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['image'] = image;
    json['imageType'] = imageType;
    return json;
  }
}
