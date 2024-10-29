import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/constants/themes.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/services/news_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dGreen,
        elevation: 0,
        title: Text(
          "Get News",
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: white.withOpacity(0.8)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: TextField(
                  controller: userSearch,
                  onSubmitted: (value) {
                    setState(() {
                      userSearch.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: black.withOpacity(0.8),
                    ),
                    hintText: "Search for news",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: dGreen.withOpacity(0.8)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: black.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async => {
                  print(userSearch.text),
                  await NewsDb().newsFetch(userSearch.text)
                },
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: dGreen,
                  ),
                  child: Text(
                    "Search",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: white.withOpacity(0.7)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder<List<NewsController>>(
                  future: NewsDb().newsFetch(userSearch.text),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewsController>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: dGreen,
                        strokeWidth: 4,
                        strokeCap: StrokeCap.square,
                        strokeAlign: 3,
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Unable to fetch data !");
                    } else if (snapshot.hasData) {
                      List<NewsController>? newsData = snapshot.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: newsData!.length,
                          itemBuilder: (context, index) {
                            return Text(newsData[index].title.toString());
                          });
                    }
                    return Text("data1");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
