// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VideoGameNotesTable extends VideoGameNotes
    with TableInfo<$VideoGameNotesTable, VideogameNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoGameNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _videoGameIdMeta = const VerificationMeta(
    'videoGameId',
  );
  @override
  late final GeneratedColumn<int> videoGameId = GeneratedColumn<int>(
    'video_game_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    videoGameId,
    note,
    rating,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_game_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<VideogameNoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('video_game_id')) {
      context.handle(
        _videoGameIdMeta,
        videoGameId.isAcceptableOrUnknown(
          data['video_game_id']!,
          _videoGameIdMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {videoGameId};
  @override
  VideogameNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideogameNoteRow(
      videoGameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}video_game_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $VideoGameNotesTable createAlias(String alias) {
    return $VideoGameNotesTable(attachedDatabase, alias);
  }
}

class VideogameNoteRow extends DataClass
    implements Insertable<VideogameNoteRow> {
  final int videoGameId;
  final String note;
  final int rating;
  final DateTime updatedAt;
  final bool pendingSync;
  const VideogameNoteRow({
    required this.videoGameId,
    required this.note,
    required this.rating,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['video_game_id'] = Variable<int>(videoGameId);
    map['note'] = Variable<String>(note);
    map['rating'] = Variable<int>(rating);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  VideoGameNotesCompanion toCompanion(bool nullToAbsent) {
    return VideoGameNotesCompanion(
      videoGameId: Value(videoGameId),
      note: Value(note),
      rating: Value(rating),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory VideogameNoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideogameNoteRow(
      videoGameId: serializer.fromJson<int>(json['videoGameId']),
      note: serializer.fromJson<String>(json['note']),
      rating: serializer.fromJson<int>(json['rating']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'videoGameId': serializer.toJson<int>(videoGameId),
      'note': serializer.toJson<String>(note),
      'rating': serializer.toJson<int>(rating),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  VideogameNoteRow copyWith({
    int? videoGameId,
    String? note,
    int? rating,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => VideogameNoteRow(
    videoGameId: videoGameId ?? this.videoGameId,
    note: note ?? this.note,
    rating: rating ?? this.rating,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  VideogameNoteRow copyWithCompanion(VideoGameNotesCompanion data) {
    return VideogameNoteRow(
      videoGameId: data.videoGameId.present
          ? data.videoGameId.value
          : this.videoGameId,
      note: data.note.present ? data.note.value : this.note,
      rating: data.rating.present ? data.rating.value : this.rating,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VideogameNoteRow(')
          ..write('videoGameId: $videoGameId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(videoGameId, note, rating, updatedAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideogameNoteRow &&
          other.videoGameId == this.videoGameId &&
          other.note == this.note &&
          other.rating == this.rating &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class VideoGameNotesCompanion extends UpdateCompanion<VideogameNoteRow> {
  final Value<int> videoGameId;
  final Value<String> note;
  final Value<int> rating;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  const VideoGameNotesCompanion({
    this.videoGameId = const Value.absent(),
    this.note = const Value.absent(),
    this.rating = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  VideoGameNotesCompanion.insert({
    this.videoGameId = const Value.absent(),
    required String note,
    required int rating,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
  }) : note = Value(note),
       rating = Value(rating),
       updatedAt = Value(updatedAt);
  static Insertable<VideogameNoteRow> custom({
    Expression<int>? videoGameId,
    Expression<String>? note,
    Expression<int>? rating,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (videoGameId != null) 'video_game_id': videoGameId,
      if (note != null) 'note': note,
      if (rating != null) 'rating': rating,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  VideoGameNotesCompanion copyWith({
    Value<int>? videoGameId,
    Value<String>? note,
    Value<int>? rating,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
  }) {
    return VideoGameNotesCompanion(
      videoGameId: videoGameId ?? this.videoGameId,
      note: note ?? this.note,
      rating: rating ?? this.rating,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (videoGameId.present) {
      map['video_game_id'] = Variable<int>(videoGameId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoGameNotesCompanion(')
          ..write('videoGameId: $videoGameId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VideoGameNotesTable videoGameNotes = $VideoGameNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [videoGameNotes];
}

typedef $$VideoGameNotesTableCreateCompanionBuilder =
    VideoGameNotesCompanion Function({
      Value<int> videoGameId,
      required String note,
      required int rating,
      required DateTime updatedAt,
      Value<bool> pendingSync,
    });
typedef $$VideoGameNotesTableUpdateCompanionBuilder =
    VideoGameNotesCompanion Function({
      Value<int> videoGameId,
      Value<String> note,
      Value<int> rating,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
    });

class $$VideoGameNotesTableFilterComposer
    extends Composer<_$AppDatabase, $VideoGameNotesTable> {
  $$VideoGameNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get videoGameId => $composableBuilder(
    column: $table.videoGameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VideoGameNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $VideoGameNotesTable> {
  $$VideoGameNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get videoGameId => $composableBuilder(
    column: $table.videoGameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VideoGameNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VideoGameNotesTable> {
  $$VideoGameNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get videoGameId => $composableBuilder(
    column: $table.videoGameId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$VideoGameNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VideoGameNotesTable,
          VideogameNoteRow,
          $$VideoGameNotesTableFilterComposer,
          $$VideoGameNotesTableOrderingComposer,
          $$VideoGameNotesTableAnnotationComposer,
          $$VideoGameNotesTableCreateCompanionBuilder,
          $$VideoGameNotesTableUpdateCompanionBuilder,
          (
            VideogameNoteRow,
            BaseReferences<
              _$AppDatabase,
              $VideoGameNotesTable,
              VideogameNoteRow
            >,
          ),
          VideogameNoteRow,
          PrefetchHooks Function()
        > {
  $$VideoGameNotesTableTableManager(
    _$AppDatabase db,
    $VideoGameNotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VideoGameNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VideoGameNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VideoGameNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> videoGameId = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => VideoGameNotesCompanion(
                videoGameId: videoGameId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> videoGameId = const Value.absent(),
                required String note,
                required int rating,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
              }) => VideoGameNotesCompanion.insert(
                videoGameId: videoGameId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VideoGameNotesTable, VideogameNoteRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $VideoGameNotesTable,
                    VideogameNoteRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VideoGameNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VideoGameNotesTable,
      VideogameNoteRow,
      $$VideoGameNotesTableFilterComposer,
      $$VideoGameNotesTableOrderingComposer,
      $$VideoGameNotesTableAnnotationComposer,
      $$VideoGameNotesTableCreateCompanionBuilder,
      $$VideoGameNotesTableUpdateCompanionBuilder,
      (
        VideogameNoteRow,
        BaseReferences<_$AppDatabase, $VideoGameNotesTable, VideogameNoteRow>,
      ),
      VideogameNoteRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VideoGameNotesTableTableManager get videoGameNotes =>
      $$VideoGameNotesTableTableManager(_db, _db.videoGameNotes);
}
