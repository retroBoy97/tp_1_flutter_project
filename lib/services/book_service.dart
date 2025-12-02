import 'package:sqflite/sqflite.dart';
import '../models/book.dart';
import 'database_helper.dart';

class BookService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertBook(Book book, {String? userEmail}) async {
    Database database = await _dbHelper.database;
    
    int id = 0;
    await database.transaction((txn) async {
      id = await txn.rawInsert(
        "INSERT INTO ${DatabaseHelper.tableBook}(name, price, image, user_email) VALUES(?, ?, ?, ?)",
        [book.name, book.price, book.image, userEmail]
      );
    });

    return id;
  }

  Future<List<Book>> fetchBasketBooks() async {
    Database database = await _dbHelper.database;
    List<Book> books = [];
    
    await database.transaction((txn) async {
      List<Map> list = await txn.rawQuery("SELECT * FROM ${DatabaseHelper.tableBook}");
      
      for (var element in list) {
        books.add(Book(
          element["name"] as String,
          element["price"] as int,
          element["image"].toString(),
        ));
      }
    });
    
    print("Fetched ${books.length} books from basket");
    return books;
  }

  Future<List<Book>> fetchBooksByUser(String userEmail) async {
    Database database = await _dbHelper.database;
    List<Book> books = [];
    
    await database.transaction((txn) async {
      List<Map> list = await txn.rawQuery(
        "SELECT * FROM ${DatabaseHelper.tableBook} WHERE user_email = ?",
        [userEmail]
      );
      
      for (var element in list) {
        books.add(Book(
          element["name"] as String,
          element["price"] as int,
          element["image"].toString(),
        ));
      }
    });
    
    print("Fetched ${books.length} books for user: $userEmail");
    return books;
  }

  Future<int> deleteBook(String name) async {
    Database database = await _dbHelper.database;
    
    int count = await database.delete(
      DatabaseHelper.tableBook,
      where: 'name = ?',
      whereArgs: [name],
    );
    
    print("Deleted $count book(s) with name: $name");
    return count;
  }

  Future<int> deleteBookById(int id) async {
    Database database = await _dbHelper.database;
    
    int count = await database.delete(
      DatabaseHelper.tableBook,
      where: 'id = ?',
      whereArgs: [id],
    );
    
    print("Deleted $count book(s) with id: $id");
    return count;
  }

  Future<int> clearBasket() async {
    Database database = await _dbHelper.database;
    
    int count = await database.delete(DatabaseHelper.tableBook);
    
    print("Cleared basket: $count book(s) deleted");
    return count;
  }

  Future<int> updateBook(int id, Book book) async {
    Database database = await _dbHelper.database;
    
    int count = await database.update(
      DatabaseHelper.tableBook,
      {
        'name': book.name,
        'price': book.price,
        'image': book.image,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    
    print("Updated $count book(s)");
    return count;
  }

  Future<int> countBooks() async {
    Database database = await _dbHelper.database;
    
    List<Map> result = await database.rawQuery(
      "SELECT COUNT(*) as count FROM ${DatabaseHelper.tableBook}"
    );
    
    return result.first['count'] as int;
  }
}
