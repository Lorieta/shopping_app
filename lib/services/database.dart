import 'dart:async';

import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final String dbpath = await getDatabasesPath();
    final String path = join(dbpath, 'shopping_app.db');

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    // users table
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstName TEXT,
      lastName TEXT,
      username TEXT UNIQUE,
      password TEXT,
      region TEXT,
      province TEXT,
      municipality TEXT,
      profile_image_url TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE items (
      itemId TEXT PRIMARY KEY,
      itemName TEXT,
      itemType TEXT,
      itemImage TEXT,
      itemPrice REAL,
      itemDescription TEXT,
      onCarousel INTEGER
    )
  ''');

    // batch insert (correct way)
    Batch batch = db.batch();

    batch.insert('items', {
      'itemId': 'ROB-001',
      'itemName': 'Arduino Uno R3',
      'itemType': 'Microcontroller',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/9a95a6030d400bfa29c20a04725ea20bbd527fa8.jpg',
      'itemPrice': 850.00,
      'itemDescription':
          'Entry-level microcontroller board for prototyping robots and automation projects. Includes 14 digital I/O pins, 6 analog inputs, USB interface.',
      'onCarousel': 1,
    });

    batch.insert('items', {
      'itemId': 'ROB-002',
      'itemName': 'Raspberry Pi 5 Starter Kit',
      'itemType': 'Single Board Computer',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/7fc43b89bec2465068208bbc023df253cecf574c.jpg',
      'itemPrice': 4500.00,
      'itemDescription':
          'Powerful SBC for AI robotics and computer vision. 4GB RAM model with case, power supply, and microSD card.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-003',
      'itemName': 'MG996R Servo Motor',
      'itemType': 'Actuator',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/9f954cc20437dfd412269a472755484d813847fb.jpg',
      'itemPrice': 350.00,
      'itemDescription':
          'High-torque metal gear servo for robotic arms and grippers.',
      'onCarousel': 1,
    });

    batch.insert('items', {
      'itemId': 'ROB-004',
      'itemName': 'L298N Motor Driver Module',
      'itemType': 'Motor Driver',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/c92b181fb8d2c6b32c5375ce6700317a77af08f6.jpg',
      'itemPrice': 250.00,
      'itemDescription': 'Dual H-bridge driver for DC motors.',
      'onCarousel': 1,
    });

    batch.insert('items', {
      'itemId': 'ROB-005',
      'itemName': 'HC-SR04 Ultrasonic Sensor',
      'itemType': 'Sensor',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/bda9253977faf00e8cae1084bc186794a26be0b5.jpg',
      'itemPrice': 150.00,
      'itemDescription': 'Distance measurement sensor.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-006',
      'itemName': 'ESP32 DevKit',
      'itemType': 'WiFi/Bluetooth Module',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/16200192ef385b2f7638d6ff22da56962d9e07d6.jpg',
      'itemPrice': 450.00,
      'itemDescription': 'ESP32 with WiFi/BLE for IoT robotics.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-007',
      'itemName': 'NEMA 17 Stepper Motor',
      'itemType': 'Stepper Motor',
      'itemImage': 'https://example.com/images/nema17-stepper.jpg',
      'itemPrice': 650.00,
      'itemDescription': 'Precision stepper motor.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-008',
      'itemName': 'DHT22 Temperature/Humidity Sensor',
      'itemType': 'Environmental Sensor',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/800b5538253645399c356be2d063f745c71115b9.jpg',
      'itemPrice': 200.00,
      'itemDescription': 'Temp and humidity sensor.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-009',
      'itemName': 'TB6612FNG Motor Driver',
      'itemType': 'Motor Driver',
      'itemImage': 'https://example.com/images/tb6612fng.jpg',
      'itemPrice': 180.00,
      'itemDescription': 'Compact dual motor driver.',
      'onCarousel': 0,
    });

    batch.insert('items', {
      'itemId': 'ROB-010',
      'itemName': 'Chassis Robot Kit',
      'itemType': 'Robot Kit',
      'itemImage':
          'https://pplx-res.cloudinary.com/image/upload/pplx_search_images/e28aefb900b7e82df6d4d9b3195c7e897e085354.jpg',
      'itemPrice': 1200.00,
      'itemDescription': '4WD robot chassis kit.',
      'onCarousel': 0,
    });

    await batch.commit();
  }
}
