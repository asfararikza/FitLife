import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_life/api/get_random_recipes_api.dart';
import 'package:fit_life/api/info_recipe_model.dart';
import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRecipeScreen extends StatefulWidget {
  const DetailRecipeScreen({super.key, required this.RecipeId});
  final String RecipeId;

  @override
  State<DetailRecipeScreen> createState() => _DetailRecipeScreenState();
}

class _DetailRecipeScreenState extends State<DetailRecipeScreen> {
  late SharedPreferences _logindata;
  late String _email = '';
  bool _isFavorite = false;
  List<FavoriteRecipe> _favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    List<Map<String, dynamic>> favoriteList =
        await DatabaseHelper.instance.getListFavorite(_email);
    List<FavoriteRecipe> favoriteRecipes =
        favoriteList.map((map) => FavoriteRecipe.fromMap(map)).toList();

    setState(() {
      _favoriteRecipes = favoriteRecipes;
      _isFavorite =
          _favoriteRecipes.any((recipe) => recipe.recipeId == widget.RecipeId);
    });
    print(_isFavorite);
    print(_favoriteRecipes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail Recipe",
              style: TextStyle(
                color: Colors.black,
              )),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: FutureBuilder(
          future: ApiRandomRecipes.instance.informationRecipe(widget.RecipeId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("ADA ERROR");
            }
            if (snapshot.hasData && snapshot.data != null) {
              InfoRecipeModel recipe = InfoRecipeModel.fromJson(snapshot.data!);
              return ListView(
                children: [
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Image.network(
                                recipe.image.toString(),
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                    icon: _isFavorite
                                        ? Icon(
                                            Icons.favorite_rounded,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.favorite_border_outlined),
                                    onPressed: () {
                                      var mins = recipe.readyInMinutes;
                                      var serving = recipe.servings;
                                      var image = recipe.image;
                                      var title = recipe.title;
                                      var cal = recipe
                                          .nutrition?.nutrients![0].amount
                                          .toString();

                                      _toggleFavoriteStatus(
                                          image.toString(),
                                          title.toString(),
                                          mins.toString(),
                                          serving.toString(),
                                          cal.toString());
                                    }),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          recipe.title.toString(),
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 280,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //calories
                                    Column(
                                      children: [
                                        Text(
                                          "${recipe.nutrition?.nutrients![0].amount}",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "calories",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),

                                    //time
                                    Column(
                                      children: [
                                        Text(
                                          "${recipe.readyInMinutes} m",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "time",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),

                                    //servings
                                    Column(
                                      children: [
                                        Text(
                                          "${recipe.servings}",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "servings",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ])
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipe.extendedIngredients?.length,
                            itemBuilder: (BuildContext context, int index) {
                              var ingredients =
                                  recipe.extendedIngredients?[index];
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 70,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${ingredients?.nameClean}",
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${ingredients?.amount}",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[700]),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "${ingredients?.unit}",
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[700]),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "Instructions",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipe
                                    .analyzedInstructions?[0]["steps"].length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              var instruction = recipe.analyzedInstructions?[0]
                                  ["steps"][index];

                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          instruction["number"].toString(),
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            "${instruction["step"]}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            softWrap: true,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Container(
                                    //     width: MediaQuery.of(context).size.width,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       color: Colors.green,
                                    //     ),
                                    //     padding: EdgeInsets.all(15.0),
                                    //     child: Text("${instruction["step"]}",
                                    //         style: GoogleFonts.poppins(
                                    //           textStyle: const TextStyle(
                                    //               fontSize: 16.0,
                                    //               color: Colors.white),
                                    //         ))),
                                    Divider(
                                      color: Colors.grey[200],
                                      thickness: 1,
                                    ),

                                    SizedBox(height: 8.0),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Future<void> _toggleFavoriteStatus(String image, String title, String ready,
      String serving, String cal) async {
    String message = '';
    late Color color;
    if (_isFavorite) {
      // Hapus dari daftar favorit
      await DatabaseHelper.instance
          .deleteFavorite(_email, widget.RecipeId, 'favorite_recipes');
      message = 'Recipe removed from favorite';
      color = Colors.red;
    } else {
      // Tambahkan ke daftar favorit
      await DatabaseHelper.instance.insertFavorite(
        _email,
        widget.RecipeId,
        image,
        title,
        ready,
        serving,
        cal,
      );
      message = 'Recipe added to favorite';
      color = Colors.green;
    }

    // Perbarui status favorit
    _checkFavoriteStatus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
    print(message);
  }
}
