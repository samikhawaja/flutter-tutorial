import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()
{
  runApp(MyApp());
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
        ),
        body: _buildSuggestion(),
      );
  }

  Widget _buildRow(WordPair wp) 
  {
    return ListTile(
      title: Text(
        wp.asPascalCase, style: _biggerFont
      )
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(padding: EdgeInsets.all(16.0),
                            itemBuilder: (context, i)
    {
      if (i.isOdd) return Divider();

      final index = i ~/ 2;
      if (i >= _suggestions.length) {
        _suggestions.addAll(generateWordPairs().take(10));
      }

      return _buildRow(_suggestions[index]);

    });
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() {
    return RandomWordsState();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}