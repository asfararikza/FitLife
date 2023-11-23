import 'package:fit_life/data/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'foods_db.db');
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE accounts (
        email TEXT PRIMARY KEY,
        username TEXT,
        password TEXT,
        isPremium INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_recipes (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        emailUser TEXT,
        recipeId TEXT,
        image TEXT,
        title TEXT,
        readyInMinutes TEXT,
        servings TEXT,
        calories TEXT,
        FOREIGN KEY (emailUser) REFERENCES accounts (email)
      )
    ''');

    await db.execute('''
      CREATE TABLE payment (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        emailUser TEXT,
        paymentDate TEXT,
        expiredDate TEXT,
        categoryPremium TEXT,
        price TEXT,
        FOREIGN KEY (emailUser) REFERENCES accounts (email)
      )
    ''');
  }

  Future<int> insertFavorite(String email, String recipeId, String image,
      String title, String mins, String servings, String cal) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'emailUser': email,
      'recipeId': recipeId,
      'image': image,
      'title': title,
      'readyInMinutes': mins,
      'servings': servings,
      'calories': cal,
    };
    return await db.insert("favorite_recipes", row);
  }

  Future<int> insertAccount(
      String email, String username, String password) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'email': email,
      'username': username,
      'password': password,
    };
    return await db.insert("accounts", row);
  }

  Future<int> updateAccount(
      String email, String username, String password, int isPremium) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'email': email,
      'username': username,
      'password': password,
      'isPremium': isPremium,
    };
    return await db
        .update("accounts", row, where: 'email = ?', whereArgs: [email]);
  }

  Future<int> updateUsername(String email, String newUsername) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'username': newUsername,
    };
    return await db
        .update("accounts", row, where: 'email = ?', whereArgs: [email]);
  }

  Future<List<Map<String, dynamic>>> getAccount(String email) async {
    Database db = await instance.database;
    return await db.query("accounts", where: 'email = ?', whereArgs: [email]);
  }

  Future<List<Map<String, dynamic>>> getListFavorite(String email) async {
    Database db = await instance.database;
    return await db
        .query("favorite_recipes", where: 'emailUser = ?', whereArgs: [email]);
  }

  Future<int> deleteFavorite(
      String email, String recipeId, String table) async {
    Database db = await instance.database;
    return await db.delete(table,
        where: 'emailUser = ? AND recipeId = ?', whereArgs: [email, recipeId]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<Account?> getCurrentUser(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query("accounts", where: 'email = ?', whereArgs: [email]);
    return Account.fromMap(result.first);
  }

  Future<void> deleteAllFavorites(String email) async {
    Database db = await instance.database;
    await db
        .delete('favorite_recipes', where: 'emailUser = ?', whereArgs: [email]);
  }

  Future<int> insertPayment(String email, String date, String category,
      String price, String expired) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'emailUser': email,
      'paymentDate': date,
      'expiredDate': expired,
      'categoryPremium': category,
      'price': price,
    };
    updateIsPremium(email, 1);
    return await db.insert("payment", row);
  }

  Future<List<Map<String, dynamic>>> getListPayment(String email) async {
    Database db = await instance.database;
    return await db
        .query("payment", where: 'emailUser = ?', whereArgs: [email]);
  }

  Future<void> deleteAllPayment(String email) async {
    Database db = await instance.database;
    await db.delete('payment', where: 'emailUser = ?', whereArgs: [email]);
  }

  Future<int> updateIsPremium(String email, int isPremium) async {
    Database db = await instance.database;
    Map<String, dynamic> row = {
      'isPremium': isPremium,
    };
    return await db
        .update("accounts", row, where: 'email = ?', whereArgs: [email]);
  }

  Future<int> deleteAccount(String email) async {
    Database db = await instance.database;

    // Delete from favorite_recipes table
    await db
        .delete("favorite_recipes", where: 'emailUser = ?', whereArgs: [email]);

    // Delete from payment table
    await db.delete("payment", where: 'emailUser = ?', whereArgs: [email]);

    // Delete from accounts table
    await db.delete("accounts", where: 'email = ?', whereArgs: [email]);

    return 1; // indicating the success of the operation
  }
}
