import 'package:flutter/material.dart';
import 'package:home_page/course.dart';
import 'package:home_page/profile.dart';

void main() {//comment 
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Homestate();
}

class _Homestate extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 8, vsync: this); // Replace 3 with the number of tabs you want
  }

  List all = [
    {
      "image": "images/math.png",
      'title': 'all',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List general = [
    {
      "image": "images/math.png",
      'title': 'general',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List cs = [
    {
      "image": "images/math.png",
      'title': 'cs',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List it = [
    {
      "image": "images/math.png",
      'title': 'it',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List level1 = [
    {
      "image": "images/math.png",
      'title': 'level1',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List level2 = [
    {
      "image": "images/math.png",
      'title': 'level2',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List level3 = [
    {
      "image": "images/math.png",
      'title': 'level3',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  List level4 = [
    {
      "image": "images/math.png",
      'title': 'level4',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    },
    {
      "image": "images/math.png",
      'title': 'math',
      'subtitle': 'its a mathematical course'
    }
  ];
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: const Card(
                    elevation: 0.0,
                    child: ListTile(
                      title: Text("Good morning"),
                      subtitle: Text(
                        "shimaa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      iconColor: Colors.blue,
                      trailing: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  )),
              Container(
                height: 45,
                width: 350,
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    hintText: "search",
                    suffixIcon: Icon(Icons.search_outlined),
                  ),
                ),
              ),
              Container(
                height: 10,
              ),
              TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                automaticIndicatorColorAdjustment: true,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'General'),
                  Tab(text: 'Computer Science'),
                  Tab(text: 'Information Technology'),
                  Tab(text: 'Level 1'),
                  Tab(text: 'Level 2'),
                  Tab(text: 'Level 3'),
                  Tab(text: 'Level 4'),
                ],
              ),
              Container(
                height: 25,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Replace these with your tab contents
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: all.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        all[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        all[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        all[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),

                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: general.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        general[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        general[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        general[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: cs.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        cs[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        cs[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        cs[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: it.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        it[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        it[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        it[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: level1.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        level1[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        level1[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        level1[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: level2.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        level2[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        level2[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        level2[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: level3.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        level3[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        level3[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        level3[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: level4.length,
                        itemBuilder: (context, index) {
                          return (InkWell(
                              onTap: () {
                                // Navigate to the second page on tap
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Course()));
                              },
                              child: Card(
                                elevation: 4.0,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      child: Image.asset(
                                        level4[index]['image'],
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        level4[index]['title'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        level4[index]['subtitle'],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: _onTabTapped,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profile',
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
