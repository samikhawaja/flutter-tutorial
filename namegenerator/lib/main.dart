import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()
{
  runApp(MyApp());
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved,)
          ],
        ),
        body: _buildSuggestion(),
      );
  }

  _pushSaved()
  {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair wp) {
            return ListTile(
              title: Text(
                wp.asPascalCase,
                style: _biggerFont,),

            );
          }
        );

        final List<Widget> listWidget = ListTile.divideTiles(
          tiles: tiles,
          context: context,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text("Saved Suggestions"),            
            ),
            body: ListView(children: listWidget,),
        );

      })
    );
  }

  Widget _buildRow(WordPair wp) 
  {
    final bool alreadySaved = _saved.contains(wp);
    return ListTile(
      title: Text(
        wp.asPascalCase, style: _biggerFont
      ),
      trailing: Icon(
        alreadySaved? Icons.favorite:Icons.favorite_border,
        color: alreadySaved? Colors.red: null
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(wp);
          } else {
            _saved.add(wp);
          }
        });
      },
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