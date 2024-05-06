import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lab4_5/second_page.dart';
import 'package:lab4_5/p_viewer.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PviewerPage(),
    );
  }
}
class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      child: Container(
        padding:const EdgeInsets.all(8.0),
        height: 250,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Our Pricing', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  for (var i = 0; i < 3; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PagePricing(price1: i == 0 ? '\$100/hr' : '\$770/hr', price2: i == 0 ? '\$331/hr' : '\$44/hr', price3: i == 0 ? '\$88/hr' : '\$22/hr')),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        height: 130,
                        width: 110,
                        decoration: BoxDecoration(
                          color: i == 1 ? Colors.teal : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: i == 1? Colors.white : Colors.teal,
                              child: Icon(i == 0 ? Icons.star : i == 1 ? Icons.design_services : Icons.public, color: i == 1?  Colors.teal : Colors.white),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(i == 0 ? 'Branding' : i == 1 ? 'Visual Design' : 'Digital Marketing',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: i == 1 ? Colors.white : Colors.black,
                                  ),
                                ),
                                Text('\$53/hr',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: i == 1 ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCarouselItem extends StatelessWidget {
  final int index;

  MyCarouselItem(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 70),
              child:  Column(
                children: [
                  Text(
                    'Hotel Booking App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'UI & UX',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return MyBottomSheet();
                  },
                );
              },
              child: Image.asset('assets/telefon1.png'),
            ),
          ],
        );
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding:  EdgeInsets.only(top: 70),
              child: Column(
                children: [
                   Text(
                    'Financial App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'UI & UX',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          GestureDetector(
          onTap: () {
            showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return MyBottomSheet();
              },
            );
            },
          child: Image.asset('assets/telefon2.jpg'),
        ),
    ],
        );
     /* case 3:
        return Text('Text for item 3');
      case 4:
        return Text('Text for item 4');*/
      default:
        return const Text('Default text');
    }
  }
}


class MyTab extends StatelessWidget {
  final String text;
  final bool isActive;

  MyTab({required this.text, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? null : () {},
      child: Opacity(
        opacity: isActive ? 1 : 0.5,
        child: Tab(text: text),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Think ',
                          style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            color:  Colors.black,
                          ),
                          children: <TextSpan>[
                           const TextSpan(
                              text: '& design',
                              style: TextStyle(
                                color: Colors.tealAccent,
                                fontFamily: 'Satisfy',
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.tealAccent
                              ),
                            ),
                           const TextSpan(text: ' for\n future'),
                          ],
                        ),
                      ),
                    ),
                    TabBar(
                      tabs: [
                        MyTab(text: 'UI DESIGN'),
                        MyTab(text: 'UX RESEARCH', isActive: false),
                        MyTab(text: 'BRANDING', isActive: false),
                        MyTab(text: 'SOCIAL', isActive: false),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 500.0,
                          enableInfiniteScroll: false, ),
                      items: [1,2,/*3,4*/].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: i == 1 ? Color.fromRGBO(29, 163, 166, 0.8) : (i == 2 ? Color.fromRGBO(252, 239, 219, 1) : (i == 3 ? Colors.pink : Colors.blue)), // Задайте разные цвета для каждого блока
                                borderRadius: BorderRadius.circular(55.0),
                              ),
                              child: MyCarouselItem(i),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    // Добавьте содержимое для других вкладок
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text('Our Story',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('It was in 2008 when we (Rohan & Adnan) started our journey in this industry...',
                        style: TextStyle(
                          fontSize: 16,
                          ),
                        ),
                        TextButton(
                          child: const Text('Close',
                          style: TextStyle(
                            fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.lightGreen,
        ),
      ),
    );
  }
}
