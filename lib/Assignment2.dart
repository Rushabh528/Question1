import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}

Future<List<Post>> fetchPosts() async {
  final apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Post> posts = jsonData.map((json) => Post.fromJson(json)).toList();
      return posts;
    } else {
      print('Can\'t fetch posts. Status code: ${response.statusCode}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

List<Post> filterPosts(List<Post> posts, int userId) {
  return posts.where((post) => post.userId == userId).toList();
}

void display(List<Post> posts) {
  print('Filtered Posts:');
  print('\n');

  for (var post in posts) {
    print('Post ID: ${post.id}');
    print('Title: ${post.title}');
    print('Body: ${post.body}');
    print('---');
    print('\n');
  }
}

void main() async {
  List<Post> allPosts = await fetchPosts();

  int UserID = 1;
  List<Post> filterPosts1 = filterPosts(allPosts, UserID);

  display(filterPosts1);
}
