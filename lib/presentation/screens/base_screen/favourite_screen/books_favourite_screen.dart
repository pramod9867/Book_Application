import 'package:book_application/domain/entities/book.dart';
import 'package:book_application/presentation/bloc/bloc/book_bloc.dart';
import 'package:book_application/presentation/bloc/event/book_event.dart';
import 'package:book_application/presentation/bloc/state/book_state.dart';
import 'package:book_application/presentation/screens/base_screen/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksFavouriteScreen extends StatefulWidget {
  const BooksFavouriteScreen({super.key});

  @override
  State<BooksFavouriteScreen> createState() => _BooksFavouriteScreenState();
}

class _BooksFavouriteScreenState extends State<BooksFavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        isFavScreen: false,
        baseWidget: BlocBuilder<BookBloc, BookBasicState>(
          builder: (context, state) {
            if (state is BooksLoadingState) {
              return _getCircularWidget();
            }
            if (state is BooksLoadedState) {
              return _getListWidget(state);
            }

            if (state is BooksErrorState) {
              return _getErrorWidget();
            }

            return Container();
          },
        ));
  }

  Widget _getCircularWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _getListWidget(BooksLoadedState booksLoadedState) {
    List<Book> favList = booksLoadedState.booksList
        .where((element) => element.isFavorite)
        .toList();

    return GridView.builder(
      itemCount: favList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final book = favList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        book.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => {
                          BlocProvider.of<BookBloc>(context)
                              .add(AddBookFav(book.id, true, "FAV"))
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            book.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        book.author,
                        style: TextStyle(color: Colors.grey[600]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getErrorWidget() {
    return Center(
      child: Text("No Data Found"),
    );
  }
}
