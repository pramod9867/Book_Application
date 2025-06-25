import 'package:book_application/presentation/bloc/bloc/book_bloc.dart';
import 'package:book_application/presentation/bloc/event/book_event.dart';
import 'package:book_application/presentation/screens/base_screen/book_list_screen/book_list_screen.dart';
import 'package:book_application/presentation/screens/base_screen/favourite_screen/books_favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScreen extends StatelessWidget {
  final Widget baseWidget;
  final bool isFavScreen;
  const BaseScreen(
      {super.key, required this.baseWidget, required this.isFavScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Book Store'),
          actions: [
            this.isFavScreen
                ? IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BooksFavouriteScreen(),
                        ),
                      );
                    },
                  )
                : Container()
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search by title',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (text) {
                  BlocProvider.of<BookBloc>(context)
                      .add(FilteredBooksByName(text));
                },
              ),
            ),
          ),
        ),
        body: this.baseWidget);
  }
}
