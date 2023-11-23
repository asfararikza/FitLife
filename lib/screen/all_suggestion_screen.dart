import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/user_model.dart';
import 'package:fit_life/screen/premium_page.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/api/suggestion_recipe_api.dart';
import 'package:fit_life/api/suggestion_recipe_model.dart';
import 'package:fit_life/screen/detaill_recipe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllSuggestionScreen extends StatefulWidget {
  const AllSuggestionScreen(
      {super.key, required this.minCal, required this.maxCal});
  final String minCal;
  final String maxCal;

  @override
  State<AllSuggestionScreen> createState() => _AllSuggestionScreenState();
}

class _AllSuggestionScreenState extends State<AllSuggestionScreen> {
  Account _user = Account(email: '', username: '', password: '', isPremium: 0);
  late SharedPreferences _logindata;
  String _email = '';

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
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    Account? user = await DatabaseHelper.instance.getCurrentUser(_email);

    if (user != null) {
      setState(() {
        _user = user;
      });
    } else {
      // Handle case when user is not found
      print('User not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Suggestions Recipes",
            style: TextStyle(
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: _user.isPremium == 0 ? _buildNotPremium() : _loadRecipes(),
    );
  }

  Widget _loadRecipes() {
    return FutureBuilder(
      future: ApiSuggestionRecipes.instance
          .allSuggestionRecipe(widget.minCal, widget.maxCal),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ADA ERROR");
        }
        if (snapshot.hasData && snapshot.data != null) {
          List<Map<String, dynamic>> listRecipes =
              List.from(snapshot.data! as List<dynamic>);

          List<SuggestionRecipesModel> recipes = listRecipes
              .map((jsonRecipe) => SuggestionRecipesModel.fromJson(jsonRecipe))
              .toList();
          return _buildHomeScreen(recipes: recipes);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildNotPremium() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   "(*╯-╰)ノ",
          //   style: TextStyle(
          //     fontSize: 30,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.red,
          //   ),
          // ),
          Image.asset('assets/sorry.png', height: 150),
          SizedBox(
            height: 30,
          ),
          Text(
            "You are not premium user",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Upgrade to premium to get more recipes",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PremiumPage()));
            },
            child: Text(
              "Upgrade to Premium",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildHomeScreen extends StatelessWidget {
  const _buildHomeScreen({super.key, required this.recipes});
  final List<SuggestionRecipesModel> recipes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.85,
      ),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        var recipe = recipes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailRecipeScreen(RecipeId: recipe.id.toString())));
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recipe.image.toString(),
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  recipe.title.toString(),
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          recipe.calories.toString() + " kcal",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.grey[400],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
