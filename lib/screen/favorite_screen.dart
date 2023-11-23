import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/favorite_model.dart';
import 'package:fit_life/screen/detaill_recipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences _logindata;
  late String _email = '';
  List<FavoriteRecipe> _favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _getLoginData();
  }

  Future<void> _getLoginData() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    List<Map<String, dynamic>> favoriteList =
        await DatabaseHelper.instance.getListFavorite(_email);
    List<FavoriteRecipe> favoriteRecipes =
        favoriteList.map((map) => FavoriteRecipe.fromMap(map)).toList();

    setState(() {
      _favoriteRecipes = favoriteRecipes;
    });
    print(favoriteList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Recipes',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onSelected: (value) {
              if (value == 'deleteAll') {
                DatabaseHelper.instance.deleteAllFavorites(_email);
                _loadFavoriteRecipes();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Recipe removed from favorites.'),
                    duration: Duration(seconds: 2),
                  ),
                );
                print("list : ${_favoriteRecipes}");
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'deleteAll',
                child: Text('Delete All Favorites'),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: _favoriteRecipes.isEmpty
          ? Center(
              child: Text('No favorite recipes.'),
            )
          : ListView.builder(
              itemCount: _favoriteRecipes.length,
              itemBuilder: (context, index) {
                return _buildFavoriteRecipeCard(_favoriteRecipes[index]);
              },
            ),
    );
  }

  Widget _buildFavoriteRecipeCard(FavoriteRecipe favoriteRecipe) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DetailRecipeScreen(RecipeId: favoriteRecipe.recipeId)),
        );
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 240, 239, 239),
          ),
          height: 130,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 140.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(favoriteRecipe.image)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0)),
                  // color: Colors.redAccent,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.only(top: 18),
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          favoriteRecipe.title,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          // softWrap: true,
                        ),
                        Text('${favoriteRecipe.calories} Calories',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              color: Colors.grey,
                              size: 13,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${favoriteRecipe.readyInMinutes} m',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Icon(
                              Icons.room_service_outlined,
                              color: Colors.grey,
                              size: 13,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${favoriteRecipe.servings} serv.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () {
                            _removeFavoriteRecipe(favoriteRecipe);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _removeFavoriteRecipe(FavoriteRecipe favoriteRecipe) async {
    await DatabaseHelper.instance
        .deleteFavorite(_email, favoriteRecipe.recipeId, 'favorite_recipes');
    _loadFavoriteRecipes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Recipe removed from favorites.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
