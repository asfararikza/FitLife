import 'package:fit_life/data/database.dart';
import 'package:fit_life/data/user_model.dart';
import 'package:fit_life/screen/calci_track_screen.dart';
import 'package:fit_life/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_life/api/get_random_recipes_api.dart';
import 'package:fit_life/api/recipes_model.dart';
import 'package:fit_life/screen/detaill_recipe_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchQuery = TextEditingController();
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black87,
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${_user.username}!",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Subscription",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                _user.isPremium == 1 ? "Premium" : "Free",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Image.asset('assets/home.png', height: 180),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Check your BMI and get information about your minimal calories intake',
                          style: GoogleFonts.fanwoodText(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalciInputScreen()));
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                //Popular Recipes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trends Recipe",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => CategoryScreen(
                    //                   categoryName: "Popular Recipe",
                    //                   tags: "asian",
                    //                 )));
                    //   },
                    //   child: Text(
                    //     "See All",
                    //     style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.deepOrange),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                FutureBuilder(
                  future: ApiRandomRecipes.instance.loadRandomRecipes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("ADA ERROR");
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      RecipeModel recipes =
                          RecipeModel.fromJson(snapshot.data!);
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recipes.recipes!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = recipes.recipes![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailRecipeScreen(
                                              RecipeId: data.id.toString(),
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[200],
                                ),
                                padding: EdgeInsets.all(15),
                                width: 220,
                                margin: EdgeInsets.only(right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Recipe Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        data.image.toString(),
                                        height: 130,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),

                                    //Recipe Title
                                    Text(
                                      data.title.toString(),
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),

                                    //Recipe Calories

                                    // FutureBuilder(
                                    //   future: ApiRandomRecipes.instance
                                    //       .informationRecipe(data.id.toString()),
                                    //   builder: (BuildContext context,
                                    //       AsyncSnapshot snapshot) {
                                    //     if (snapshot.hasData &&
                                    //         snapshot.data != null) {
                                    //       InfoRecipeModel dataInfo =
                                    //           InfoRecipeModel.fromJson(
                                    //               snapshot.data!);
                                    //       return Text(
                                    //           " ${dataInfo.nutrition?.nutrients?[0].amount} Calories",
                                    //           style: TextStyle(
                                    //               color: Colors.deepOrange));
                                    //     }
                                    //     return Text(
                                    //       "Calories",
                                    //       style:
                                    //           TextStyle(color: Colors.deepOrange),
                                    //     );
                                    //   },
                                    // ),

                                    SizedBox(
                                      height: 10,
                                    ),

                                    //Recipe Info
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.schedule_outlined,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${data.readyInMinutes} mins",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.room_service_outlined,
                                              color: Colors.grey,
                                              size: 15,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${data.servings} servings",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ])));
  }
}
