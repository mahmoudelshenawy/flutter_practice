import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List posts = [];
  int currenctPage = 1;
  bool isLoading = false;
  bool inistialLoad = true;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchPosts();

    scrollController.addListener(refetchDataOnScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts Pagination"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: inistialLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                controller: scrollController,
                itemCount: isLoading ? posts.length + 1 : posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8.0),
                    child: index < posts.length
                        ? Card(
                            // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue[500],
                                child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                posts[index]["title"]["rendered"],
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                posts[index]["yoast_head_json"]["description"],
                                maxLines: 3,
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  );
                }),
      ),
    );
  }

  Future<void> fetchPosts() async {
    var response = await http.get(Uri.parse(
        "https://techcrunch.com/wp-json/wp/v2/posts?per_page=10&page=$currenctPage"));
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      setState(() {
        posts = posts + jsonBody;
        isLoading = false;
        inistialLoad = false;
      });
    }
  }

  Future<void> refetchDataOnScroll() async {
    if (isLoading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      currenctPage = currenctPage + 1;
      await fetchPosts();
      setState(() {
        isLoading = false;
      });
    }
    // print("refetch data");
  }
}
