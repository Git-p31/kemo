import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  StreamPageState createState() => StreamPageState();
}

class StreamPageState extends State<StreamPage> {
  final String apiKey = 'AIzaSyC7SgfsXWy-MGe78rrD_40xk9d2sIKg8Fs'; // Убедись, что ключ правильный
  final Map<String, String> channels = {
    'UCWLxarOxx4Aeh959lrV31Lg': 'KEMO',
    'UCELCPjx3rq0d-G6WfhjwXyA': 'ShomerTV',
  };

  Map<String, List<Map<String, String>>> channelVideos = {};

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  Future<void> fetchVideos() async {
    Map<String, List<Map<String, String>>> videos = {};

    for (var entry in channels.entries) {
      String channelId = entry.key;
      String channelName = entry.value;

      List<Map<String, String>> streamList = [];

      // Запрос активных стримов
      final liveUrl = Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channelId&eventType=live&type=video&key=$apiKey',
      );

      final liveResponse = await http.get(liveUrl);
      if (liveResponse.statusCode == 200) {
        final liveData = jsonDecode(liveResponse.body);
        final liveItems = liveData['items'] as List<dynamic>;

        for (var item in liveItems) {
          streamList.add({
            'title': item['snippet']['title'],
            'thumbnail': item['snippet']['thumbnails']['high']['url'],
            'videoId': item['id']['videoId'],
          });
        }
      }

      // Если нет стримов, получаем последнее видео
      if (streamList.isEmpty) {
        final latestUrl = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$channelId&order=date&type=video&maxResults=1&key=$apiKey',
        );

        final latestResponse = await http.get(latestUrl);
        if (latestResponse.statusCode == 200) {
          final latestData = jsonDecode(latestResponse.body);
          final latestItems = latestData['items'] as List<dynamic>;

          for (var item in latestItems) {
            streamList.add({
              'title': item['snippet']['title'],
              'thumbnail': item['snippet']['thumbnails']['high']['url'],
              'videoId': item['id']['videoId'],
            });
          }
        }
      }

      videos[channelName] = streamList;
    }

    setState(() {
      channelVideos = videos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: channelVideos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: channelVideos.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.black87,
                      child: Text(
                        entry.key, // Название канала (KEMO / ShomerTV)
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ...entry.value.map((video) => ListTile(
                          leading: Image.network(video['thumbnail']!),
                          title: Text(video['title']!),
                          onTap: () => _openStream(video['videoId']!),
                        )),
                    const Divider(), // Разделитель между каналами
                  ],
                );
              }).toList(),
            ),
    );
  }

  void _openStream(String videoId) {
    final url = 'https://www.youtube.com/watch?v=$videoId';
    debugPrint('Открываем: $url');
    // Открой ссылку в браузере или WebView
  }
}
