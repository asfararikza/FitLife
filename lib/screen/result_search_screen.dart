import 'package:flutter/material.dart';
import 'package:fit_life/api/get_random_recipes_api.dart';
import 'package:fit_life/api/result_search_model.dart';
import 'package:fit_life/screen/detaill_recipe_screen.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({super.key, required this.query});
  final String query;
  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("search result",
                  style: TextStyle(color: Colors.black, fontSize: 13)),
              Text(" ${widget.query.toUpperCase()}",
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: ApiRandomRecipes.instance.searchRecipe(widget.query),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ADA ERROR");
          }
          if (snapshot.hasData && snapshot.data != null) {
            ResultSearchModel result =
                ResultSearchModel.fromJson(snapshot.data!);
            if (result.results!.isEmpty) {
              return Center(
                child: Text("No recipes found."),
              );
            }
            return buildResultScreen(result: result);
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class buildResultScreen extends StatelessWidget {
  const buildResultScreen({super.key, required this.result});
  final ResultSearchModel result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: result.results!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = result.results![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailRecipeScreen(
                              RecipeId: data.id.toString())));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data.image.toString(),
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Tap to see detail recipe",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
