class InfoRecipeModel {
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  bool? lowFodmap;
  int? weightWatcherSmartPoints;
  String? gaps;
  int? preparationMinutes;
  int? cookingMinutes;
  int? aggregateLikes;
  int? healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredients>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? imageType;
  Nutrition? nutrition;
  String? summary;
  List<dynamic>? cuisines;
  List<String>? dishTypes;
  List<dynamic>? diets;
  List<dynamic>? occasions;
  WinePairing? winePairing;
  String? instructions;
  List<dynamic>? analyzedInstructions;
  dynamic originalId;
  String? spoonacularSourceUrl;

  InfoRecipeModel({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
    this.imageType,
    this.nutrition,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    this.winePairing,
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularSourceUrl,
  });

  InfoRecipeModel.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'] as bool?;
    vegan = json['vegan'] as bool?;
    glutenFree = json['glutenFree'] as bool?;
    dairyFree = json['dairyFree'] as bool?;
    veryHealthy = json['veryHealthy'] as bool?;
    cheap = json['cheap'] as bool?;
    veryPopular = json['veryPopular'] as bool?;
    sustainable = json['sustainable'] as bool?;
    lowFodmap = json['lowFodmap'] as bool?;
    weightWatcherSmartPoints = json['weightWatcherSmartPoints'] as int?;
    gaps = json['gaps'] as String?;
    preparationMinutes = json['preparationMinutes'] as int?;
    cookingMinutes = json['cookingMinutes'] as int?;
    aggregateLikes = json['aggregateLikes'] as int?;
    healthScore = json['healthScore'] as int?;
    creditsText = json['creditsText'] as String?;
    license = json['license'] as String?;
    sourceName = json['sourceName'] as String?;
    pricePerServing = json['pricePerServing'] as double?;
    extendedIngredients = (json['extendedIngredients'] as List?)
        ?.map((dynamic e) =>
            ExtendedIngredients.fromJson(e as Map<String, dynamic>))
        .toList();
    id = json['id'] as int?;
    title = json['title'] as String?;
    readyInMinutes = json['readyInMinutes'] as int?;
    servings = json['servings'] as int?;
    sourceUrl = json['sourceUrl'] as String?;
    image = json['image'] as String?;
    imageType = json['imageType'] as String?;
    nutrition = (json['nutrition'] as Map<String, dynamic>?) != null
        ? Nutrition.fromJson(json['nutrition'] as Map<String, dynamic>)
        : null;
    summary = json['summary'] as String?;
    cuisines = json['cuisines'] as List?;
    dishTypes =
        (json['dishTypes'] as List?)?.map((dynamic e) => e as String).toList();
    diets = json['diets'] as List?;
    occasions = json['occasions'] as List?;
    winePairing = (json['winePairing'] as Map<String, dynamic>?) != null
        ? WinePairing.fromJson(json['winePairing'] as Map<String, dynamic>)
        : null;
    instructions = json['instructions'] as String?;
    analyzedInstructions = json['analyzedInstructions'] as List?;
    originalId = json['originalId'];
    spoonacularSourceUrl = json['spoonacularSourceUrl'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['vegetarian'] = vegetarian;
    json['vegan'] = vegan;
    json['glutenFree'] = glutenFree;
    json['dairyFree'] = dairyFree;
    json['veryHealthy'] = veryHealthy;
    json['cheap'] = cheap;
    json['veryPopular'] = veryPopular;
    json['sustainable'] = sustainable;
    json['lowFodmap'] = lowFodmap;
    json['weightWatcherSmartPoints'] = weightWatcherSmartPoints;
    json['gaps'] = gaps;
    json['preparationMinutes'] = preparationMinutes;
    json['cookingMinutes'] = cookingMinutes;
    json['aggregateLikes'] = aggregateLikes;
    json['healthScore'] = healthScore;
    json['creditsText'] = creditsText;
    json['license'] = license;
    json['sourceName'] = sourceName;
    json['pricePerServing'] = pricePerServing;
    json['extendedIngredients'] =
        extendedIngredients?.map((e) => e.toJson()).toList();
    json['id'] = id;
    json['title'] = title;
    json['readyInMinutes'] = readyInMinutes;
    json['servings'] = servings;
    json['sourceUrl'] = sourceUrl;
    json['image'] = image;
    json['imageType'] = imageType;
    json['nutrition'] = nutrition?.toJson();
    json['summary'] = summary;
    json['cuisines'] = cuisines;
    json['dishTypes'] = dishTypes;
    json['diets'] = diets;
    json['occasions'] = occasions;
    json['winePairing'] = winePairing?.toJson();
    json['instructions'] = instructions;
    json['analyzedInstructions'] = analyzedInstructions;
    json['originalId'] = originalId;
    json['spoonacularSourceUrl'] = spoonacularSourceUrl;
    return json;
  }
}

class ExtendedIngredients {
  int? id;
  String? aisle;
  String? image;
  String? consistency;
  String? name;
  String? nameClean;
  String? original;
  String? originalName;
  num? amount;
  String? unit;
  List<dynamic>? meta;
  Measures? measures;

  ExtendedIngredients({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    aisle = json['aisle'] as String?;
    image = json['image'] as String?;
    consistency = json['consistency'] as String?;
    name = json['name'] as String?;
    nameClean = json['nameClean'] as String?;
    original = json['original'] as String?;
    originalName = json['originalName'] as String?;
    amount = json['amount'];
    unit = json['unit'] as String?;
    meta = json['meta'] as List?;
    measures = (json['measures'] as Map<String, dynamic>?) != null
        ? Measures.fromJson(json['measures'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['aisle'] = aisle;
    json['image'] = image;
    json['consistency'] = consistency;
    json['name'] = name;
    json['nameClean'] = nameClean;
    json['original'] = original;
    json['originalName'] = originalName;
    json['amount'] = amount;
    json['unit'] = unit;
    json['meta'] = meta;
    json['measures'] = measures?.toJson();
    return json;
  }
}

class Measures {
  Us? us;
  Metric? metric;

  Measures({
    this.us,
    this.metric,
  });

  Measures.fromJson(Map<String, dynamic> json) {
    us = (json['us'] as Map<String, dynamic>?) != null
        ? Us.fromJson(json['us'] as Map<String, dynamic>)
        : null;
    metric = (json['metric'] as Map<String, dynamic>?) != null
        ? Metric.fromJson(json['metric'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['us'] = us?.toJson();
    json['metric'] = metric?.toJson();
    return json;
  }
}

class Us {
  num? amount;
  String? unitShort;
  String? unitLong;

  Us({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  Us.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitShort = json['unitShort'] as String?;
    unitLong = json['unitLong'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['unitShort'] = unitShort;
    json['unitLong'] = unitLong;
    return json;
  }
}

class Metric {
  num? amount;
  String? unitShort;
  String? unitLong;

  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  Metric.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitShort = json['unitShort'] as String?;
    unitLong = json['unitLong'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['unitShort'] = unitShort;
    json['unitLong'] = unitLong;
    return json;
  }
}

class Nutrition {
  List<Nutrients>? nutrients;
  List<Properties>? properties;
  List<Flavonoids>? flavonoids;
  List<Ingredients>? ingredients;
  CaloricBreakdown? caloricBreakdown;
  WeightPerServing? weightPerServing;

  Nutrition({
    this.nutrients,
    this.properties,
    this.flavonoids,
    this.ingredients,
    this.caloricBreakdown,
    this.weightPerServing,
  });

  Nutrition.fromJson(Map<String, dynamic> json) {
    nutrients = (json['nutrients'] as List?)
        ?.map((dynamic e) => Nutrients.fromJson(e as Map<String, dynamic>))
        .toList();
    properties = (json['properties'] as List?)
        ?.map((dynamic e) => Properties.fromJson(e as Map<String, dynamic>))
        .toList();
    flavonoids = (json['flavonoids'] as List?)
        ?.map((dynamic e) => Flavonoids.fromJson(e as Map<String, dynamic>))
        .toList();
    ingredients = (json['ingredients'] as List?)
        ?.map((dynamic e) => Ingredients.fromJson(e as Map<String, dynamic>))
        .toList();
    caloricBreakdown =
        (json['caloricBreakdown'] as Map<String, dynamic>?) != null
            ? CaloricBreakdown.fromJson(
                json['caloricBreakdown'] as Map<String, dynamic>)
            : null;
    weightPerServing =
        (json['weightPerServing'] as Map<String, dynamic>?) != null
            ? WeightPerServing.fromJson(
                json['weightPerServing'] as Map<String, dynamic>)
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['nutrients'] = nutrients?.map((e) => e.toJson()).toList();
    json['properties'] = properties?.map((e) => e.toJson()).toList();
    json['flavonoids'] = flavonoids?.map((e) => e.toJson()).toList();
    json['ingredients'] = ingredients?.map((e) => e.toJson()).toList();
    json['caloricBreakdown'] = caloricBreakdown?.toJson();
    json['weightPerServing'] = weightPerServing?.toJson();
    return json;
  }
}

class Nutrients {
  String? name;
  double? amount;
  String? unit;
  double? percentOfDailyNeeds;

  Nutrients({
    this.name,
    this.amount,
    this.unit,
    this.percentOfDailyNeeds,
  });

  Nutrients.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'] as double?;
    unit = json['unit'] as String?;
    percentOfDailyNeeds = json['percentOfDailyNeeds'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    json['percentOfDailyNeeds'] = percentOfDailyNeeds;
    return json;
  }
}

class Properties {
  String? name;
  num? amount;
  String? unit;

  Properties({
    this.name,
    this.amount,
    this.unit,
  });

  Properties.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'];
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}

class Flavonoids {
  String? name;
  num? amount;
  String? unit;

  Flavonoids({
    this.name,
    this.amount,
    this.unit,
  });

  Flavonoids.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    amount = json['amount'];
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}

class Ingredients {
  int? id;
  String? name;
  double? amount;
  String? unit;
  List<Nutrients>? nutrients;

  Ingredients({
    this.id,
    this.name,
    this.amount,
    this.unit,
    this.nutrients,
  });

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    amount = json['amount'] as double?;
    unit = json['unit'] as String?;
    nutrients = (json['nutrients'] as List?)
        ?.map((dynamic e) => Nutrients.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['amount'] = amount;
    json['unit'] = unit;
    json['nutrients'] = nutrients?.map((e) => e.toJson()).toList();
    return json;
  }
}

// class Nutrients {
//   String? name;
//   int? amount;
//   String? unit;
//   int? percentOfDailyNeeds;

//   Nutrients({
//     this.name,
//     this.amount,
//     this.unit,
//     this.percentOfDailyNeeds,
//   });

//   Nutrients.fromJson(Map<String, dynamic> json) {
//     name = json['name'] as String?;
//     amount = json['amount'] as int?;
//     unit = json['unit'] as String?;
//     percentOfDailyNeeds = json['percentOfDailyNeeds'] as int?;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> json = <String, dynamic>{};
//     json['name'] = name;
//     json['amount'] = amount;
//     json['unit'] = unit;
//     json['percentOfDailyNeeds'] = percentOfDailyNeeds;
//     return json;
//   }
// }

class CaloricBreakdown {
  double? percentProtein;
  double? percentFat;
  double? percentCarbs;

  CaloricBreakdown({
    this.percentProtein,
    this.percentFat,
    this.percentCarbs,
  });

  CaloricBreakdown.fromJson(Map<String, dynamic> json) {
    percentProtein = json['percentProtein'] as double?;
    percentFat = json['percentFat'] as double?;
    percentCarbs = json['percentCarbs'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['percentProtein'] = percentProtein;
    json['percentFat'] = percentFat;
    json['percentCarbs'] = percentCarbs;
    return json;
  }
}

class WeightPerServing {
  int? amount;
  String? unit;

  WeightPerServing({
    this.amount,
    this.unit,
  });

  WeightPerServing.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] as int?;
    unit = json['unit'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['unit'] = unit;
    return json;
  }
}

class WinePairing {
  List<dynamic>? pairedWines;
  String? pairingText;
  List<dynamic>? productMatches;

  WinePairing({
    this.pairedWines,
    this.pairingText,
    this.productMatches,
  });

  WinePairing.fromJson(Map<String, dynamic> json) {
    pairedWines = json['pairedWines'] as List?;
    pairingText = json['pairingText'] as String?;
    productMatches = json['productMatches'] as List?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['pairedWines'] = pairedWines;
    json['pairingText'] = pairingText;
    json['productMatches'] = productMatches;
    return json;
  }
}
