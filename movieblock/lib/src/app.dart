import 'package:flutter/material.dart';
import 'package:movieblock/src/ui/movies_list.dart';
import 'package:movieblock/src/ui/topRated_screen.dart';
import 'package:movieblock/src/ui/search_screen.dart';

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  const AppHomePage({Key? key});

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MovieList(updateAppBarTitle: () {}), // Screen for popular movies
    const TopRated(), // Screen for top rated movies
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0 ? const Text('Popular Movies') : const Text('Top Rated Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieSearchScreen(
                    searchController: TextEditingController(),
                    // onSearch: (query) {
                    //   // Perform search logic here
                    // },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            label: 'Top Rated',
          ),
        ],
      ),
    );
  }
}


