import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sociomusic/api/socio_music/response/getRooms.dart';

var imagesArray = [
  'https://cdn.shopify.com/s/files/1/0969/9128/products/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_a12704bd-2b25-4aa7-8c8d-8f40cf467dc7_large.jpg?v=1582781089',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/action-movie-poster-template-design-0f5fff6262fdefb855e3a9a3f0fdd361_screen.jpg?ts=1573101130',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/adventure-movie-poster-template-design-7b13ea2ab6f64c1ec9e1bb473f345547_screen.jpg?ts=1576732289'
];

class RoomCarousel extends StatefulWidget {
  const RoomCarousel({
    Key? key,
    required Future<GetRoomsResponse> rooms,
    required void Function(int pos, String roomId) onRoomChange,
  })  : _rooms = rooms,
        _onRoomChange = onRoomChange,
        super(key: key);

  final Future<GetRoomsResponse> _rooms;
  final Function(int pos, String roomId) _onRoomChange;
  @override
  _RoomCarouselState createState() => _RoomCarouselState();
}

class _RoomCarouselState extends State<RoomCarousel> {
  var index = 0;
  var rnd = new Random();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<GetRoomsResponse>(
          future: widget._rooms,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var rooms = snapshot.data?.data;
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: PageView.builder(
                          onPageChanged: (pos) {
                            widget._onRoomChange(pos, rooms![pos].id);
                            setState(() {
                              index = pos;
                            });
                          },
                          itemCount: rooms?.length ?? 0,
                          controller: PageController(viewportFraction: 0.5),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                imagesArray[index % 3],
                                height: 100,
                              ),
                            );
                          }),
                    ),
                    Container(
                      width: 200,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xde4A4040),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Center(
                        child: Text(
                          rooms![index].name,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasError) {
              return Text('error');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
