import 'dart:convert';

import 'package:book_application/core/model/generic_model.dart';
import 'package:book_application/data/datasources/localdatasource.dart';
import 'package:book_application/data/datasources/remotedatasource.dart';
import 'package:book_application/data/models/local/book_model.dart';
import 'package:book_application/data/models/remote/book/book_remote.dart';
import 'package:book_application/domain/entities/book.dart';
import 'package:book_application/domain/repositories/book_repository.dart';

class BookRepositories extends BookRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  BookRepositories(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Book>> getBooks() async {
    List<Book> books = [];

    List<BookModel> bookModel = await localDataSource.getCachedBooks();

    if (bookModel == null || bookModel.length == 0) {
      print("Data Loaded From Remote Source");

      GenericModel genericModel = await remoteDataSource.fetchBooksDetails();

      if (genericModel.status == "S") {
        //this logic needs to be fixed
        List<BookModel> cachedBooks = [];

        BookRemoteModel bookRemoteModel =
            BookRemoteModel.fromJson(genericModel.data);

        bookRemoteModel.items.forEach((element) {
          books.add(new Book(
              id: element.id ?? "",
              title: element.volumeInfo?.title ?? "",
              author: element.volumeInfo?.authors.join(",") ?? "",
              image: element.volumeInfo?.imageLinks?.thumbnail ?? "",
              isFavorite: false));

          cachedBooks.add(BookModel(
              id: element.id ?? "",
              title: element.volumeInfo?.title ?? "",
              author: element.volumeInfo?.authors.join(",") ?? "",
              image: element.volumeInfo?.imageLinks?.thumbnail ?? "",
              isFavorite: false));
        });

        await localDataSource.cacheBooks(cachedBooks);
        return books;
      }
    } else {
      print("Data Loaded Local Source");
      bookModel.forEach((element) {
        books.add(element.toEntity());
      });
    }

    return books;
  }

  @override
  Future<bool> toggleBooks(String id) async {
    bool toggle = await localDataSource.updateFavourites(id);
    return toggle;
  }
}
