import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lab4_5/main.dart';

class PagePricing extends StatelessWidget {
  late final String price1;
  late final String price2;
  late final String price3;

  PagePricing({Key? key, required this.price1, required this.price2, required this.price3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.open_in_new, color: Colors.teal),
              onPressed: () {
                // Здесь добавьте код для открытия URL
              },
            ),
          )
        ],
        title: const Text('Our Pricing', style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26)),
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
                children:[
                  buildCard('Branding', price1, 'Logo, typography, Illustrations...', Icons.star, Colors.tealAccent),
                  buildCard('Visual Design', price2, 'Website design, Landing page design, WebApp visual design, \nColor analysis, Typography', Icons.design_services, Colors.tealAccent, hasButton: true),
                  buildCard('Digital Marketing', price3, 'Email Marketing, Social media...', Icons.public, Colors.tealAccent),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text('What our clients say?', style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 26)),
                    ),
                  ),
                  CarouselSlider.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: items[itemIndex],
                      );
                    },
                    options: CarouselOptions(
                      height: 300.0,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      aspectRatio: 16/9,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.8,
                    ),
                  ),

                  const SizedBox(height: 10.0),
                ]
            )
        ),
      ),
    );
  }

  Card buildCard(String title, String price, String description, IconData icon, Color color, {bool hasButton = false}) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(price),
            const SizedBox(height: 4.0),
            Text(description, style: const TextStyle(fontSize: 16.0)),
            if (hasButton)
              Padding(
                padding:const  EdgeInsets.only(top: 4.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Send mail', style: TextStyle(color: Colors.black, fontSize: 18.0)),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

  }
}

List<CarouselItem> items = [
  CarouselItem(
    name: 'Rosie Evans',
    position: 'Product Manager',
    review: 'Helped a lot with our design team and we enjoyed the result of working with qualified developers!',
    avatarColor: Colors.white,
    textColor: Colors.black,
    avatarImage: 'assets/gleb4.jpg',
    borderColor: Colors.teal,
  ),
  CarouselItem(
    name: 'Louise Aguilar',
    position: 'Sales Manager',
    review: 'Helped a lot with our design team and we enjoyed the result of working with qualified developers!',
    avatarColor: Colors.teal,
    textColor: Colors.white,
    avatarImage: 'assets/gleb4.jpg',
    borderColor: Colors.white,
  ),
  CarouselItem(
    name: 'Ilya Korobkin',
    position: 'Product Manager',
    review: 'Helped a lot with our design team and we enjoyed the result of working with qualified developers!',
    avatarColor: Colors.white,
    textColor: Colors.black,
    avatarImage: 'assets/gleb4.jpg',
    borderColor: Colors.teal,
  ),
];

class CarouselItem extends StatelessWidget {
  final String name;
  final String position;
  final String review;
  final Color avatarColor;
  final Color textColor;
  final String avatarImage;
  final Color borderColor;

  CarouselItem({
    required this.name,
    required this.position,
    required this.review,
    required this.avatarColor,
    required this.textColor,
    required this.avatarImage,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: avatarColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 28.0,
            backgroundColor: borderColor,
            child: CircleAvatar(
              radius: 26.0,
              backgroundImage: AssetImage(avatarImage),
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor)),
          Text(position, style: TextStyle(fontSize: 14.0, color: textColor)),
          const SizedBox(height: 10.0),
          Expanded(
            child: Text(review, textAlign: TextAlign.left, style: TextStyle(color: textColor.withOpacity(0.80), fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
