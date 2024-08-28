import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('pt', ''),
      ],
      home: ScoreKeeper(),
    );
  }
}

class ScoreKeeper extends StatefulWidget {
  @override
  _ScoreKeeperState createState() => _ScoreKeeperState();
}

class _ScoreKeeperState extends State<ScoreKeeper> {
  int _scoreTeam1 = 0;
  int _scoreTeam2 = 0;
  int? _lastScore;
  String? _lastTeam;

  void _incrementScore(String team, int points) {
    setState(() {
      if (team == 'team1') {
        _scoreTeam1 += points;
      } else if (team == 'team2') {
        _scoreTeam2 += points;
      }
      _lastScore = points;
      _lastTeam = team;
    });
  }

  void _undo() {
    setState(() {
      if (_lastTeam == 'team1') {
        _scoreTeam1 -= _lastScore!;
      } else if (_lastTeam == 'team2') {
        _scoreTeam2 -= _lastScore!;
      }
      _lastScore = null;
      _lastTeam = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.score),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              '${strings.team1}: $_scoreTeam1\n${strings.team2}: $_scoreTeam2',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(strings.team1),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team1', 1),
                      child: Text(strings.freeThrow),
                    ),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team1', 2),
                      child: Text(strings.twoPoints),
                    ),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team1', 3),
                      child: Text(strings.threePoints),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(strings.team2),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team2', 1),
                      child: Text(strings.freeThrow),
                    ),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team2', 2),
                      child: Text(strings.twoPoints),
                    ),
                    ElevatedButton(
                      onPressed: () => _incrementScore('team2', 3),
                      child: Text(strings.threePoints),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _lastScore != null ? _undo : null,
              child: Text(strings.undo),
            ),
          ],
        ),
      ),
    );
  }
}

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get team1 => Intl.message('Team 1', name: 'team1');
  String get team2 => Intl.message('Team 2', name: 'team2');
  String get freeThrow => Intl.message('Free Throw', name: 'freeThrow');
  String get twoPoints => Intl.message('2 Points', name: 'twoPoints');
  String get threePoints => Intl.message('3 Points', name: 'threePoints');
  String get undo => Intl.message('Undo', name: 'undo');
  String get score => Intl.message('Score', name: 'score');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

