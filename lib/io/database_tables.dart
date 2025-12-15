import 'package:drift/drift.dart';

// Define the Projects table
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get globalSystemInstruction => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

// Define the Nodes table
class Nodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer()();
  IntColumn get parentId => integer().nullable()();

  TextColumn get role => text()();
  TextColumn get content => text()();

  // Audit Metadata
  TextColumn get modelId => text().nullable()();
  RealColumn get temperature => real().nullable()();
  IntColumn get tokenCount => integer().nullable()();
  IntColumn get executionTimeMs => integer().nullable()();

  DateTimeColumn get timestamp => dateTime()();
}
