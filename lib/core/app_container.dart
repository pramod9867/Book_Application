import 'package:book_application/data/datasources/localdatasource.dart';
import 'package:book_application/data/datasources/remotedatasource.dart';
import 'package:book_application/data/models/local/book_model.dart';
import 'package:book_application/data/repositories/book_repository/book_repositories.dart';
import 'package:book_application/domain/repositories/book_repository.dart';
import 'package:book_application/domain/usecases/get_books.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppContainer{
  static late final LocalDataSource local;
  static late final RemoteDataSource remote;
  static late final BookRepository repo;
  static late final GetBooks getBooks;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BookModelAdapter()); // Generated from @HiveType
    final box = await Hive.openBox<BookModel>('booksBox');
     local = LocalDataSource(box);
     remote = RemoteDataSource();
     repo = BookRepositories(remote, local);
     getBooks = GetBooks(repo);
  }
}