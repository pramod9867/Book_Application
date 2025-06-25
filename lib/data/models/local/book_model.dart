import 'package:book_application/domain/entities/book.dart';
import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class BookModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final bool isFavorite;

  BookModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.image,
      required this.isFavorite});

  Book toEntity() => Book(
        id: id,
        title: title,
        author: author,
        image: image,
        isFavorite: isFavorite,
      );

  factory BookModel.fromEntity(Book book) => BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        image: book.image,
        isFavorite: book.isFavorite,
      );
}
