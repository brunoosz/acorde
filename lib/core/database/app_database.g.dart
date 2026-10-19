// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _objectiveMeta =
      const VerificationMeta('objective');
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
      'objective', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _spanishLevelMeta =
      const VerificationMeta('spanishLevel');
  @override
  late final GeneratedColumn<int> spanishLevel = GeneratedColumn<int>(
      'spanish_level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dailyMinutesMeta =
      const VerificationMeta('dailyMinutes');
  @override
  late final GeneratedColumn<int> dailyMinutes = GeneratedColumn<int>(
      'daily_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentKnowledgeMeta =
      const VerificationMeta('currentKnowledge');
  @override
  late final GeneratedColumn<String> currentKnowledge = GeneratedColumn<String>(
      'current_knowledge', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _musicPreferencesMeta =
      const VerificationMeta('musicPreferences');
  @override
  late final GeneratedColumn<String> musicPreferences = GeneratedColumn<String>(
      'music_preferences', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        objective,
        spanishLevel,
        dailyMinutes,
        currentKnowledge,
        musicPreferences,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserProfileTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('objective')) {
      context.handle(_objectiveMeta,
          objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta));
    } else if (isInserting) {
      context.missing(_objectiveMeta);
    }
    if (data.containsKey('spanish_level')) {
      context.handle(
          _spanishLevelMeta,
          spanishLevel.isAcceptableOrUnknown(
              data['spanish_level']!, _spanishLevelMeta));
    } else if (isInserting) {
      context.missing(_spanishLevelMeta);
    }
    if (data.containsKey('daily_minutes')) {
      context.handle(
          _dailyMinutesMeta,
          dailyMinutes.isAcceptableOrUnknown(
              data['daily_minutes']!, _dailyMinutesMeta));
    } else if (isInserting) {
      context.missing(_dailyMinutesMeta);
    }
    if (data.containsKey('current_knowledge')) {
      context.handle(
          _currentKnowledgeMeta,
          currentKnowledge.isAcceptableOrUnknown(
              data['current_knowledge']!, _currentKnowledgeMeta));
    } else if (isInserting) {
      context.missing(_currentKnowledgeMeta);
    }
    if (data.containsKey('music_preferences')) {
      context.handle(
          _musicPreferencesMeta,
          musicPreferences.isAcceptableOrUnknown(
              data['music_preferences']!, _musicPreferencesMeta));
    } else if (isInserting) {
      context.missing(_musicPreferencesMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      objective: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}objective'])!,
      spanishLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}spanish_level'])!,
      dailyMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}daily_minutes'])!,
      currentKnowledge: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}current_knowledge'])!,
      musicPreferences: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}music_preferences'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileTableData extends DataClass
    implements Insertable<UserProfileTableData> {
  final int id;
  final String objective;
  final int spanishLevel;
  final int dailyMinutes;
  final String currentKnowledge;
  final String musicPreferences;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfileTableData(
      {required this.id,
      required this.objective,
      required this.spanishLevel,
      required this.dailyMinutes,
      required this.currentKnowledge,
      required this.musicPreferences,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['objective'] = Variable<String>(objective);
    map['spanish_level'] = Variable<int>(spanishLevel);
    map['daily_minutes'] = Variable<int>(dailyMinutes);
    map['current_knowledge'] = Variable<String>(currentKnowledge);
    map['music_preferences'] = Variable<String>(musicPreferences);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      objective: Value(objective),
      spanishLevel: Value(spanishLevel),
      dailyMinutes: Value(dailyMinutes),
      currentKnowledge: Value(currentKnowledge),
      musicPreferences: Value(musicPreferences),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfileTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      objective: serializer.fromJson<String>(json['objective']),
      spanishLevel: serializer.fromJson<int>(json['spanishLevel']),
      dailyMinutes: serializer.fromJson<int>(json['dailyMinutes']),
      currentKnowledge: serializer.fromJson<String>(json['currentKnowledge']),
      musicPreferences: serializer.fromJson<String>(json['musicPreferences']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'objective': serializer.toJson<String>(objective),
      'spanishLevel': serializer.toJson<int>(spanishLevel),
      'dailyMinutes': serializer.toJson<int>(dailyMinutes),
      'currentKnowledge': serializer.toJson<String>(currentKnowledge),
      'musicPreferences': serializer.toJson<String>(musicPreferences),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfileTableData copyWith(
          {int? id,
          String? objective,
          int? spanishLevel,
          int? dailyMinutes,
          String? currentKnowledge,
          String? musicPreferences,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserProfileTableData(
        id: id ?? this.id,
        objective: objective ?? this.objective,
        spanishLevel: spanishLevel ?? this.spanishLevel,
        dailyMinutes: dailyMinutes ?? this.dailyMinutes,
        currentKnowledge: currentKnowledge ?? this.currentKnowledge,
        musicPreferences: musicPreferences ?? this.musicPreferences,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserProfileTableData copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      objective: data.objective.present ? data.objective.value : this.objective,
      spanishLevel: data.spanishLevel.present
          ? data.spanishLevel.value
          : this.spanishLevel,
      dailyMinutes: data.dailyMinutes.present
          ? data.dailyMinutes.value
          : this.dailyMinutes,
      currentKnowledge: data.currentKnowledge.present
          ? data.currentKnowledge.value
          : this.currentKnowledge,
      musicPreferences: data.musicPreferences.present
          ? data.musicPreferences.value
          : this.musicPreferences,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableData(')
          ..write('id: $id, ')
          ..write('objective: $objective, ')
          ..write('spanishLevel: $spanishLevel, ')
          ..write('dailyMinutes: $dailyMinutes, ')
          ..write('currentKnowledge: $currentKnowledge, ')
          ..write('musicPreferences: $musicPreferences, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, objective, spanishLevel, dailyMinutes,
      currentKnowledge, musicPreferences, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileTableData &&
          other.id == this.id &&
          other.objective == this.objective &&
          other.spanishLevel == this.spanishLevel &&
          other.dailyMinutes == this.dailyMinutes &&
          other.currentKnowledge == this.currentKnowledge &&
          other.musicPreferences == this.musicPreferences &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileTableData> {
  final Value<int> id;
  final Value<String> objective;
  final Value<int> spanishLevel;
  final Value<int> dailyMinutes;
  final Value<String> currentKnowledge;
  final Value<String> musicPreferences;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.objective = const Value.absent(),
    this.spanishLevel = const Value.absent(),
    this.dailyMinutes = const Value.absent(),
    this.currentKnowledge = const Value.absent(),
    this.musicPreferences = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required String objective,
    required int spanishLevel,
    required int dailyMinutes,
    required String currentKnowledge,
    required String musicPreferences,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : objective = Value(objective),
        spanishLevel = Value(spanishLevel),
        dailyMinutes = Value(dailyMinutes),
        currentKnowledge = Value(currentKnowledge),
        musicPreferences = Value(musicPreferences);
  static Insertable<UserProfileTableData> custom({
    Expression<int>? id,
    Expression<String>? objective,
    Expression<int>? spanishLevel,
    Expression<int>? dailyMinutes,
    Expression<String>? currentKnowledge,
    Expression<String>? musicPreferences,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (objective != null) 'objective': objective,
      if (spanishLevel != null) 'spanish_level': spanishLevel,
      if (dailyMinutes != null) 'daily_minutes': dailyMinutes,
      if (currentKnowledge != null) 'current_knowledge': currentKnowledge,
      if (musicPreferences != null) 'music_preferences': musicPreferences,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfileTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? objective,
      Value<int>? spanishLevel,
      Value<int>? dailyMinutes,
      Value<String>? currentKnowledge,
      Value<String>? musicPreferences,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      objective: objective ?? this.objective,
      spanishLevel: spanishLevel ?? this.spanishLevel,
      dailyMinutes: dailyMinutes ?? this.dailyMinutes,
      currentKnowledge: currentKnowledge ?? this.currentKnowledge,
      musicPreferences: musicPreferences ?? this.musicPreferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (spanishLevel.present) {
      map['spanish_level'] = Variable<int>(spanishLevel.value);
    }
    if (dailyMinutes.present) {
      map['daily_minutes'] = Variable<int>(dailyMinutes.value);
    }
    if (currentKnowledge.present) {
      map['current_knowledge'] = Variable<String>(currentKnowledge.value);
    }
    if (musicPreferences.present) {
      map['music_preferences'] = Variable<String>(musicPreferences.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('objective: $objective, ')
          ..write('spanishLevel: $spanishLevel, ')
          ..write('dailyMinutes: $dailyMinutes, ')
          ..write('currentKnowledge: $currentKnowledge, ')
          ..write('musicPreferences: $musicPreferences, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SongsTableTable extends SongsTable
    with TableInfo<$SongsTableTable, SongsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fullLyricsMeta =
      const VerificationMeta('fullLyrics');
  @override
  late final GeneratedColumn<String> fullLyrics = GeneratedColumn<String>(
      'full_lyrics', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, artist, fullLyrics, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'songs_table';
  @override
  VerificationContext validateIntegrity(Insertable<SongsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('full_lyrics')) {
      context.handle(
          _fullLyricsMeta,
          fullLyrics.isAcceptableOrUnknown(
              data['full_lyrics']!, _fullLyricsMeta));
    } else if (isInserting) {
      context.missing(_fullLyricsMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SongsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SongsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      fullLyrics: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_lyrics'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SongsTableTable createAlias(String alias) {
    return $SongsTableTable(attachedDatabase, alias);
  }
}

class SongsTableData extends DataClass implements Insertable<SongsTableData> {
  final int id;
  final String title;
  final String artist;
  final String fullLyrics;
  final DateTime createdAt;
  const SongsTableData(
      {required this.id,
      required this.title,
      required this.artist,
      required this.fullLyrics,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['full_lyrics'] = Variable<String>(fullLyrics);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SongsTableCompanion toCompanion(bool nullToAbsent) {
    return SongsTableCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      fullLyrics: Value(fullLyrics),
      createdAt: Value(createdAt),
    );
  }

  factory SongsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SongsTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      fullLyrics: serializer.fromJson<String>(json['fullLyrics']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'fullLyrics': serializer.toJson<String>(fullLyrics),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SongsTableData copyWith(
          {int? id,
          String? title,
          String? artist,
          String? fullLyrics,
          DateTime? createdAt}) =>
      SongsTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        fullLyrics: fullLyrics ?? this.fullLyrics,
        createdAt: createdAt ?? this.createdAt,
      );
  SongsTableData copyWithCompanion(SongsTableCompanion data) {
    return SongsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      fullLyrics:
          data.fullLyrics.present ? data.fullLyrics.value : this.fullLyrics,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SongsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('fullLyrics: $fullLyrics, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, artist, fullLyrics, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.fullLyrics == this.fullLyrics &&
          other.createdAt == this.createdAt);
}

class SongsTableCompanion extends UpdateCompanion<SongsTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> fullLyrics;
  final Value<DateTime> createdAt;
  const SongsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.fullLyrics = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SongsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    required String fullLyrics,
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist),
        fullLyrics = Value(fullLyrics);
  static Insertable<SongsTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? fullLyrics,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (fullLyrics != null) 'full_lyrics': fullLyrics,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SongsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? fullLyrics,
      Value<DateTime>? createdAt}) {
    return SongsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      fullLyrics: fullLyrics ?? this.fullLyrics,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (fullLyrics.present) {
      map['full_lyrics'] = Variable<String>(fullLyrics.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('fullLyrics: $fullLyrics, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SongSectionsTableTable extends SongSectionsTable
    with TableInfo<$SongSectionsTableTable, SongSectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongSectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
      'song_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES songs_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _sectionOrderMeta =
      const VerificationMeta('sectionOrder');
  @override
  late final GeneratedColumn<int> sectionOrder = GeneratedColumn<int>(
      'section_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _textContentMeta =
      const VerificationMeta('textContent');
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
      'text_content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, sectionOrder, label, textContent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'song_sections_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SongSectionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('section_order')) {
      context.handle(
          _sectionOrderMeta,
          sectionOrder.isAcceptableOrUnknown(
              data['section_order']!, _sectionOrderMeta));
    } else if (isInserting) {
      context.missing(_sectionOrderMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
          _textContentMeta,
          textContent.isAcceptableOrUnknown(
              data['text_content']!, _textContentMeta));
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SongSectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SongSectionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}song_id'])!,
      sectionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}section_order'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      textContent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}text_content'])!,
    );
  }

  @override
  $SongSectionsTableTable createAlias(String alias) {
    return $SongSectionsTableTable(attachedDatabase, alias);
  }
}

class SongSectionsTableData extends DataClass
    implements Insertable<SongSectionsTableData> {
  final int id;
  final int songId;
  final int sectionOrder;
  final String label;
  final String textContent;
  const SongSectionsTableData(
      {required this.id,
      required this.songId,
      required this.sectionOrder,
      required this.label,
      required this.textContent});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<int>(songId);
    map['section_order'] = Variable<int>(sectionOrder);
    map['label'] = Variable<String>(label);
    map['text_content'] = Variable<String>(textContent);
    return map;
  }

  SongSectionsTableCompanion toCompanion(bool nullToAbsent) {
    return SongSectionsTableCompanion(
      id: Value(id),
      songId: Value(songId),
      sectionOrder: Value(sectionOrder),
      label: Value(label),
      textContent: Value(textContent),
    );
  }

  factory SongSectionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SongSectionsTableData(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<int>(json['songId']),
      sectionOrder: serializer.fromJson<int>(json['sectionOrder']),
      label: serializer.fromJson<String>(json['label']),
      textContent: serializer.fromJson<String>(json['textContent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<int>(songId),
      'sectionOrder': serializer.toJson<int>(sectionOrder),
      'label': serializer.toJson<String>(label),
      'textContent': serializer.toJson<String>(textContent),
    };
  }

  SongSectionsTableData copyWith(
          {int? id,
          int? songId,
          int? sectionOrder,
          String? label,
          String? textContent}) =>
      SongSectionsTableData(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        sectionOrder: sectionOrder ?? this.sectionOrder,
        label: label ?? this.label,
        textContent: textContent ?? this.textContent,
      );
  SongSectionsTableData copyWithCompanion(SongSectionsTableCompanion data) {
    return SongSectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      sectionOrder: data.sectionOrder.present
          ? data.sectionOrder.value
          : this.sectionOrder,
      label: data.label.present ? data.label.value : this.label,
      textContent:
          data.textContent.present ? data.textContent.value : this.textContent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SongSectionsTableData(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('label: $label, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, songId, sectionOrder, label, textContent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongSectionsTableData &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.sectionOrder == this.sectionOrder &&
          other.label == this.label &&
          other.textContent == this.textContent);
}

class SongSectionsTableCompanion
    extends UpdateCompanion<SongSectionsTableData> {
  final Value<int> id;
  final Value<int> songId;
  final Value<int> sectionOrder;
  final Value<String> label;
  final Value<String> textContent;
  const SongSectionsTableCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.sectionOrder = const Value.absent(),
    this.label = const Value.absent(),
    this.textContent = const Value.absent(),
  });
  SongSectionsTableCompanion.insert({
    this.id = const Value.absent(),
    required int songId,
    required int sectionOrder,
    required String label,
    required String textContent,
  })  : songId = Value(songId),
        sectionOrder = Value(sectionOrder),
        label = Value(label),
        textContent = Value(textContent);
  static Insertable<SongSectionsTableData> custom({
    Expression<int>? id,
    Expression<int>? songId,
    Expression<int>? sectionOrder,
    Expression<String>? label,
    Expression<String>? textContent,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (sectionOrder != null) 'section_order': sectionOrder,
      if (label != null) 'label': label,
      if (textContent != null) 'text_content': textContent,
    });
  }

  SongSectionsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? songId,
      Value<int>? sectionOrder,
      Value<String>? label,
      Value<String>? textContent}) {
    return SongSectionsTableCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      sectionOrder: sectionOrder ?? this.sectionOrder,
      label: label ?? this.label,
      textContent: textContent ?? this.textContent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (sectionOrder.present) {
      map['section_order'] = Variable<int>(sectionOrder.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongSectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('sectionOrder: $sectionOrder, ')
          ..write('label: $label, ')
          ..write('textContent: $textContent')
          ..write(')'))
        .toString();
  }
}

class $LessonPlansTableTable extends LessonPlansTable
    with TableInfo<$LessonPlansTableTable, LessonPlansTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
      'song_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES songs_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _totalDaysMeta =
      const VerificationMeta('totalDays');
  @override
  late final GeneratedColumn<int> totalDays = GeneratedColumn<int>(
      'total_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _planJsonMeta =
      const VerificationMeta('planJson');
  @override
  late final GeneratedColumn<String> planJson = GeneratedColumn<String>(
      'plan_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentDayMeta =
      const VerificationMeta('currentDay');
  @override
  late final GeneratedColumn<int> currentDay = GeneratedColumn<int>(
      'current_day', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, totalDays, planJson, currentDay, isCompleted, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_plans_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<LessonPlansTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('total_days')) {
      context.handle(_totalDaysMeta,
          totalDays.isAcceptableOrUnknown(data['total_days']!, _totalDaysMeta));
    } else if (isInserting) {
      context.missing(_totalDaysMeta);
    }
    if (data.containsKey('plan_json')) {
      context.handle(_planJsonMeta,
          planJson.isAcceptableOrUnknown(data['plan_json']!, _planJsonMeta));
    } else if (isInserting) {
      context.missing(_planJsonMeta);
    }
    if (data.containsKey('current_day')) {
      context.handle(
          _currentDayMeta,
          currentDay.isAcceptableOrUnknown(
              data['current_day']!, _currentDayMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonPlansTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonPlansTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}song_id'])!,
      totalDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_days'])!,
      planJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_json'])!,
      currentDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_day'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LessonPlansTableTable createAlias(String alias) {
    return $LessonPlansTableTable(attachedDatabase, alias);
  }
}

class LessonPlansTableData extends DataClass
    implements Insertable<LessonPlansTableData> {
  final int id;
  final int songId;
  final int totalDays;
  final String planJson;
  final int currentDay;
  final bool isCompleted;
  final DateTime createdAt;
  const LessonPlansTableData(
      {required this.id,
      required this.songId,
      required this.totalDays,
      required this.planJson,
      required this.currentDay,
      required this.isCompleted,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<int>(songId);
    map['total_days'] = Variable<int>(totalDays);
    map['plan_json'] = Variable<String>(planJson);
    map['current_day'] = Variable<int>(currentDay);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LessonPlansTableCompanion toCompanion(bool nullToAbsent) {
    return LessonPlansTableCompanion(
      id: Value(id),
      songId: Value(songId),
      totalDays: Value(totalDays),
      planJson: Value(planJson),
      currentDay: Value(currentDay),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
    );
  }

  factory LessonPlansTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonPlansTableData(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<int>(json['songId']),
      totalDays: serializer.fromJson<int>(json['totalDays']),
      planJson: serializer.fromJson<String>(json['planJson']),
      currentDay: serializer.fromJson<int>(json['currentDay']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<int>(songId),
      'totalDays': serializer.toJson<int>(totalDays),
      'planJson': serializer.toJson<String>(planJson),
      'currentDay': serializer.toJson<int>(currentDay),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LessonPlansTableData copyWith(
          {int? id,
          int? songId,
          int? totalDays,
          String? planJson,
          int? currentDay,
          bool? isCompleted,
          DateTime? createdAt}) =>
      LessonPlansTableData(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        totalDays: totalDays ?? this.totalDays,
        planJson: planJson ?? this.planJson,
        currentDay: currentDay ?? this.currentDay,
        isCompleted: isCompleted ?? this.isCompleted,
        createdAt: createdAt ?? this.createdAt,
      );
  LessonPlansTableData copyWithCompanion(LessonPlansTableCompanion data) {
    return LessonPlansTableData(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      totalDays: data.totalDays.present ? data.totalDays.value : this.totalDays,
      planJson: data.planJson.present ? data.planJson.value : this.planJson,
      currentDay:
          data.currentDay.present ? data.currentDay.value : this.currentDay,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonPlansTableData(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('totalDays: $totalDays, ')
          ..write('planJson: $planJson, ')
          ..write('currentDay: $currentDay, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, songId, totalDays, planJson, currentDay, isCompleted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonPlansTableData &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.totalDays == this.totalDays &&
          other.planJson == this.planJson &&
          other.currentDay == this.currentDay &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt);
}

class LessonPlansTableCompanion extends UpdateCompanion<LessonPlansTableData> {
  final Value<int> id;
  final Value<int> songId;
  final Value<int> totalDays;
  final Value<String> planJson;
  final Value<int> currentDay;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  const LessonPlansTableCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.totalDays = const Value.absent(),
    this.planJson = const Value.absent(),
    this.currentDay = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LessonPlansTableCompanion.insert({
    this.id = const Value.absent(),
    required int songId,
    required int totalDays,
    required String planJson,
    this.currentDay = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : songId = Value(songId),
        totalDays = Value(totalDays),
        planJson = Value(planJson);
  static Insertable<LessonPlansTableData> custom({
    Expression<int>? id,
    Expression<int>? songId,
    Expression<int>? totalDays,
    Expression<String>? planJson,
    Expression<int>? currentDay,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (totalDays != null) 'total_days': totalDays,
      if (planJson != null) 'plan_json': planJson,
      if (currentDay != null) 'current_day': currentDay,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LessonPlansTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? songId,
      Value<int>? totalDays,
      Value<String>? planJson,
      Value<int>? currentDay,
      Value<bool>? isCompleted,
      Value<DateTime>? createdAt}) {
    return LessonPlansTableCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      totalDays: totalDays ?? this.totalDays,
      planJson: planJson ?? this.planJson,
      currentDay: currentDay ?? this.currentDay,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (totalDays.present) {
      map['total_days'] = Variable<int>(totalDays.value);
    }
    if (planJson.present) {
      map['plan_json'] = Variable<String>(planJson.value);
    }
    if (currentDay.present) {
      map['current_day'] = Variable<int>(currentDay.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('totalDays: $totalDays, ')
          ..write('planJson: $planJson, ')
          ..write('currentDay: $currentDay, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $LessonContentTableTable extends LessonContentTable
    with TableInfo<$LessonContentTableTable, LessonContentTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonContentTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
      'song_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES songs_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
      'day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentJsonMeta =
      const VerificationMeta('contentJson');
  @override
  late final GeneratedColumn<String> contentJson = GeneratedColumn<String>(
      'content_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, day, contentJson, isCompleted, generatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_content_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<LessonContentTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
          _dayMeta, day.isAcceptableOrUnknown(data['day']!, _dayMeta));
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('content_json')) {
      context.handle(
          _contentJsonMeta,
          contentJson.isAcceptableOrUnknown(
              data['content_json']!, _contentJsonMeta));
    } else if (isInserting) {
      context.missing(_contentJsonMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {songId, day},
      ];
  @override
  LessonContentTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonContentTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}song_id'])!,
      day: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day'])!,
      contentJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content_json'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}generated_at'])!,
    );
  }

  @override
  $LessonContentTableTable createAlias(String alias) {
    return $LessonContentTableTable(attachedDatabase, alias);
  }
}

class LessonContentTableData extends DataClass
    implements Insertable<LessonContentTableData> {
  final int id;
  final int songId;
  final int day;
  final String contentJson;
  final bool isCompleted;
  final DateTime generatedAt;
  const LessonContentTableData(
      {required this.id,
      required this.songId,
      required this.day,
      required this.contentJson,
      required this.isCompleted,
      required this.generatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<int>(songId);
    map['day'] = Variable<int>(day);
    map['content_json'] = Variable<String>(contentJson);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  LessonContentTableCompanion toCompanion(bool nullToAbsent) {
    return LessonContentTableCompanion(
      id: Value(id),
      songId: Value(songId),
      day: Value(day),
      contentJson: Value(contentJson),
      isCompleted: Value(isCompleted),
      generatedAt: Value(generatedAt),
    );
  }

  factory LessonContentTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonContentTableData(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<int>(json['songId']),
      day: serializer.fromJson<int>(json['day']),
      contentJson: serializer.fromJson<String>(json['contentJson']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<int>(songId),
      'day': serializer.toJson<int>(day),
      'contentJson': serializer.toJson<String>(contentJson),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  LessonContentTableData copyWith(
          {int? id,
          int? songId,
          int? day,
          String? contentJson,
          bool? isCompleted,
          DateTime? generatedAt}) =>
      LessonContentTableData(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        day: day ?? this.day,
        contentJson: contentJson ?? this.contentJson,
        isCompleted: isCompleted ?? this.isCompleted,
        generatedAt: generatedAt ?? this.generatedAt,
      );
  LessonContentTableData copyWithCompanion(LessonContentTableCompanion data) {
    return LessonContentTableData(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      day: data.day.present ? data.day.value : this.day,
      contentJson:
          data.contentJson.present ? data.contentJson.value : this.contentJson,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentTableData(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('day: $day, ')
          ..write('contentJson: $contentJson, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, songId, day, contentJson, isCompleted, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonContentTableData &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.day == this.day &&
          other.contentJson == this.contentJson &&
          other.isCompleted == this.isCompleted &&
          other.generatedAt == this.generatedAt);
}

class LessonContentTableCompanion
    extends UpdateCompanion<LessonContentTableData> {
  final Value<int> id;
  final Value<int> songId;
  final Value<int> day;
  final Value<String> contentJson;
  final Value<bool> isCompleted;
  final Value<DateTime> generatedAt;
  const LessonContentTableCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.day = const Value.absent(),
    this.contentJson = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.generatedAt = const Value.absent(),
  });
  LessonContentTableCompanion.insert({
    this.id = const Value.absent(),
    required int songId,
    required int day,
    required String contentJson,
    this.isCompleted = const Value.absent(),
    this.generatedAt = const Value.absent(),
  })  : songId = Value(songId),
        day = Value(day),
        contentJson = Value(contentJson);
  static Insertable<LessonContentTableData> custom({
    Expression<int>? id,
    Expression<int>? songId,
    Expression<int>? day,
    Expression<String>? contentJson,
    Expression<bool>? isCompleted,
    Expression<DateTime>? generatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (day != null) 'day': day,
      if (contentJson != null) 'content_json': contentJson,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (generatedAt != null) 'generated_at': generatedAt,
    });
  }

  LessonContentTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? songId,
      Value<int>? day,
      Value<String>? contentJson,
      Value<bool>? isCompleted,
      Value<DateTime>? generatedAt}) {
    return LessonContentTableCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      day: day ?? this.day,
      contentJson: contentJson ?? this.contentJson,
      isCompleted: isCompleted ?? this.isCompleted,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (contentJson.present) {
      map['content_json'] = Variable<String>(contentJson.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonContentTableCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('day: $day, ')
          ..write('contentJson: $contentJson, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }
}

class $VocabularyTableTable extends VocabularyTable
    with TableInfo<$VocabularyTableTable, VocabularyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<int> songId = GeneratedColumn<int>(
      'song_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES songs_table (id) ON DELETE SET NULL'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
      'translation', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 300),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _exampleSentenceMeta =
      const VerificationMeta('exampleSentence');
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
      'example_sentence', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, word, translation, exampleSentence, origin, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<VocabularyTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
          _exampleSentenceMeta,
          exampleSentence.isAcceptableOrUnknown(
              data['example_sentence']!, _exampleSentenceMeta));
    } else if (isInserting) {
      context.missing(_exampleSentenceMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}song_id']),
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      translation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation'])!,
      exampleSentence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}example_sentence'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $VocabularyTableTable createAlias(String alias) {
    return $VocabularyTableTable(attachedDatabase, alias);
  }
}

class VocabularyTableData extends DataClass
    implements Insertable<VocabularyTableData> {
  final int id;
  final int? songId;
  final String word;
  final String translation;
  final String exampleSentence;
  final String origin;
  final DateTime createdAt;
  const VocabularyTableData(
      {required this.id,
      this.songId,
      required this.word,
      required this.translation,
      required this.exampleSentence,
      required this.origin,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || songId != null) {
      map['song_id'] = Variable<int>(songId);
    }
    map['word'] = Variable<String>(word);
    map['translation'] = Variable<String>(translation);
    map['example_sentence'] = Variable<String>(exampleSentence);
    map['origin'] = Variable<String>(origin);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VocabularyTableCompanion toCompanion(bool nullToAbsent) {
    return VocabularyTableCompanion(
      id: Value(id),
      songId:
          songId == null && nullToAbsent ? const Value.absent() : Value(songId),
      word: Value(word),
      translation: Value(translation),
      exampleSentence: Value(exampleSentence),
      origin: Value(origin),
      createdAt: Value(createdAt),
    );
  }

  factory VocabularyTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyTableData(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<int?>(json['songId']),
      word: serializer.fromJson<String>(json['word']),
      translation: serializer.fromJson<String>(json['translation']),
      exampleSentence: serializer.fromJson<String>(json['exampleSentence']),
      origin: serializer.fromJson<String>(json['origin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<int?>(songId),
      'word': serializer.toJson<String>(word),
      'translation': serializer.toJson<String>(translation),
      'exampleSentence': serializer.toJson<String>(exampleSentence),
      'origin': serializer.toJson<String>(origin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VocabularyTableData copyWith(
          {int? id,
          Value<int?> songId = const Value.absent(),
          String? word,
          String? translation,
          String? exampleSentence,
          String? origin,
          DateTime? createdAt}) =>
      VocabularyTableData(
        id: id ?? this.id,
        songId: songId.present ? songId.value : this.songId,
        word: word ?? this.word,
        translation: translation ?? this.translation,
        exampleSentence: exampleSentence ?? this.exampleSentence,
        origin: origin ?? this.origin,
        createdAt: createdAt ?? this.createdAt,
      );
  VocabularyTableData copyWithCompanion(VocabularyTableCompanion data) {
    return VocabularyTableData(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      word: data.word.present ? data.word.value : this.word,
      translation:
          data.translation.present ? data.translation.value : this.translation,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
      origin: data.origin.present ? data.origin.value : this.origin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTableData(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('word: $word, ')
          ..write('translation: $translation, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('origin: $origin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, songId, word, translation, exampleSentence, origin, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyTableData &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.word == this.word &&
          other.translation == this.translation &&
          other.exampleSentence == this.exampleSentence &&
          other.origin == this.origin &&
          other.createdAt == this.createdAt);
}

class VocabularyTableCompanion extends UpdateCompanion<VocabularyTableData> {
  final Value<int> id;
  final Value<int?> songId;
  final Value<String> word;
  final Value<String> translation;
  final Value<String> exampleSentence;
  final Value<String> origin;
  final Value<DateTime> createdAt;
  const VocabularyTableCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.word = const Value.absent(),
    this.translation = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.origin = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VocabularyTableCompanion.insert({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    required String word,
    required String translation,
    required String exampleSentence,
    required String origin,
    this.createdAt = const Value.absent(),
  })  : word = Value(word),
        translation = Value(translation),
        exampleSentence = Value(exampleSentence),
        origin = Value(origin);
  static Insertable<VocabularyTableData> custom({
    Expression<int>? id,
    Expression<int>? songId,
    Expression<String>? word,
    Expression<String>? translation,
    Expression<String>? exampleSentence,
    Expression<String>? origin,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (word != null) 'word': word,
      if (translation != null) 'translation': translation,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (origin != null) 'origin': origin,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VocabularyTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? songId,
      Value<String>? word,
      Value<String>? translation,
      Value<String>? exampleSentence,
      Value<String>? origin,
      Value<DateTime>? createdAt}) {
    return VocabularyTableCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      origin: origin ?? this.origin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<int>(songId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTableCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('word: $word, ')
          ..write('translation: $translation, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('origin: $origin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReviewScheduleTableTable extends ReviewScheduleTable
    with TableInfo<$ReviewScheduleTableTable, ReviewScheduleTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewScheduleTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vocabIdMeta =
      const VerificationMeta('vocabId');
  @override
  late final GeneratedColumn<int> vocabId = GeneratedColumn<int>(
      'vocab_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES vocabulary_table (id) ON DELETE CASCADE'));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _nextReviewAtMeta =
      const VerificationMeta('nextReviewAt');
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
      'next_review_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastReviewedAtMeta =
      const VerificationMeta('lastReviewedAt');
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>('last_reviewed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _reviewCountMeta =
      const VerificationMeta('reviewCount');
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
      'review_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, vocabId, level, nextReviewAt, lastReviewedAt, reviewCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_schedule_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReviewScheduleTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vocab_id')) {
      context.handle(_vocabIdMeta,
          vocabId.isAcceptableOrUnknown(data['vocab_id']!, _vocabIdMeta));
    } else if (isInserting) {
      context.missing(_vocabIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
          _nextReviewAtMeta,
          nextReviewAt.isAcceptableOrUnknown(
              data['next_review_at']!, _nextReviewAtMeta));
    } else if (isInserting) {
      context.missing(_nextReviewAtMeta);
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
          _lastReviewedAtMeta,
          lastReviewedAt.isAcceptableOrUnknown(
              data['last_reviewed_at']!, _lastReviewedAtMeta));
    }
    if (data.containsKey('review_count')) {
      context.handle(
          _reviewCountMeta,
          reviewCount.isAcceptableOrUnknown(
              data['review_count']!, _reviewCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewScheduleTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewScheduleTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vocabId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vocab_id'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      nextReviewAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_at'])!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_reviewed_at']),
      reviewCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}review_count'])!,
    );
  }

  @override
  $ReviewScheduleTableTable createAlias(String alias) {
    return $ReviewScheduleTableTable(attachedDatabase, alias);
  }
}

class ReviewScheduleTableData extends DataClass
    implements Insertable<ReviewScheduleTableData> {
  final int id;
  final int vocabId;
  final int level;
  final DateTime nextReviewAt;
  final DateTime? lastReviewedAt;
  final int reviewCount;
  const ReviewScheduleTableData(
      {required this.id,
      required this.vocabId,
      required this.level,
      required this.nextReviewAt,
      this.lastReviewedAt,
      required this.reviewCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vocab_id'] = Variable<int>(vocabId);
    map['level'] = Variable<int>(level);
    map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['review_count'] = Variable<int>(reviewCount);
    return map;
  }

  ReviewScheduleTableCompanion toCompanion(bool nullToAbsent) {
    return ReviewScheduleTableCompanion(
      id: Value(id),
      vocabId: Value(vocabId),
      level: Value(level),
      nextReviewAt: Value(nextReviewAt),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      reviewCount: Value(reviewCount),
    );
  }

  factory ReviewScheduleTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewScheduleTableData(
      id: serializer.fromJson<int>(json['id']),
      vocabId: serializer.fromJson<int>(json['vocabId']),
      level: serializer.fromJson<int>(json['level']),
      nextReviewAt: serializer.fromJson<DateTime>(json['nextReviewAt']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vocabId': serializer.toJson<int>(vocabId),
      'level': serializer.toJson<int>(level),
      'nextReviewAt': serializer.toJson<DateTime>(nextReviewAt),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'reviewCount': serializer.toJson<int>(reviewCount),
    };
  }

  ReviewScheduleTableData copyWith(
          {int? id,
          int? vocabId,
          int? level,
          DateTime? nextReviewAt,
          Value<DateTime?> lastReviewedAt = const Value.absent(),
          int? reviewCount}) =>
      ReviewScheduleTableData(
        id: id ?? this.id,
        vocabId: vocabId ?? this.vocabId,
        level: level ?? this.level,
        nextReviewAt: nextReviewAt ?? this.nextReviewAt,
        lastReviewedAt:
            lastReviewedAt.present ? lastReviewedAt.value : this.lastReviewedAt,
        reviewCount: reviewCount ?? this.reviewCount,
      );
  ReviewScheduleTableData copyWithCompanion(ReviewScheduleTableCompanion data) {
    return ReviewScheduleTableData(
      id: data.id.present ? data.id.value : this.id,
      vocabId: data.vocabId.present ? data.vocabId.value : this.vocabId,
      level: data.level.present ? data.level.value : this.level,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      reviewCount:
          data.reviewCount.present ? data.reviewCount.value : this.reviewCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewScheduleTableData(')
          ..write('id: $id, ')
          ..write('vocabId: $vocabId, ')
          ..write('level: $level, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('reviewCount: $reviewCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, vocabId, level, nextReviewAt, lastReviewedAt, reviewCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewScheduleTableData &&
          other.id == this.id &&
          other.vocabId == this.vocabId &&
          other.level == this.level &&
          other.nextReviewAt == this.nextReviewAt &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.reviewCount == this.reviewCount);
}

class ReviewScheduleTableCompanion
    extends UpdateCompanion<ReviewScheduleTableData> {
  final Value<int> id;
  final Value<int> vocabId;
  final Value<int> level;
  final Value<DateTime> nextReviewAt;
  final Value<DateTime?> lastReviewedAt;
  final Value<int> reviewCount;
  const ReviewScheduleTableCompanion({
    this.id = const Value.absent(),
    this.vocabId = const Value.absent(),
    this.level = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.reviewCount = const Value.absent(),
  });
  ReviewScheduleTableCompanion.insert({
    this.id = const Value.absent(),
    required int vocabId,
    this.level = const Value.absent(),
    required DateTime nextReviewAt,
    this.lastReviewedAt = const Value.absent(),
    this.reviewCount = const Value.absent(),
  })  : vocabId = Value(vocabId),
        nextReviewAt = Value(nextReviewAt);
  static Insertable<ReviewScheduleTableData> custom({
    Expression<int>? id,
    Expression<int>? vocabId,
    Expression<int>? level,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? lastReviewedAt,
    Expression<int>? reviewCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocabId != null) 'vocab_id': vocabId,
      if (level != null) 'level': level,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (reviewCount != null) 'review_count': reviewCount,
    });
  }

  ReviewScheduleTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? vocabId,
      Value<int>? level,
      Value<DateTime>? nextReviewAt,
      Value<DateTime?>? lastReviewedAt,
      Value<int>? reviewCount}) {
    return ReviewScheduleTableCompanion(
      id: id ?? this.id,
      vocabId: vocabId ?? this.vocabId,
      level: level ?? this.level,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vocabId.present) {
      map['vocab_id'] = Variable<int>(vocabId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewScheduleTableCompanion(')
          ..write('id: $id, ')
          ..write('vocabId: $vocabId, ')
          ..write('level: $level, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('reviewCount: $reviewCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfileTableTable userProfileTable =
      $UserProfileTableTable(this);
  late final $SongsTableTable songsTable = $SongsTableTable(this);
  late final $SongSectionsTableTable songSectionsTable =
      $SongSectionsTableTable(this);
  late final $LessonPlansTableTable lessonPlansTable =
      $LessonPlansTableTable(this);
  late final $LessonContentTableTable lessonContentTable =
      $LessonContentTableTable(this);
  late final $VocabularyTableTable vocabularyTable =
      $VocabularyTableTable(this);
  late final $ReviewScheduleTableTable reviewScheduleTable =
      $ReviewScheduleTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userProfileTable,
        songsTable,
        songSectionsTable,
        lessonPlansTable,
        lessonContentTable,
        vocabularyTable,
        reviewScheduleTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('songs_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('song_sections_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('songs_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('lesson_plans_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('songs_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('lesson_content_table', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('songs_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('vocabulary_table', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('vocabulary_table',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('review_schedule_table', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UserProfileTableTableCreateCompanionBuilder
    = UserProfileTableCompanion Function({
  Value<int> id,
  required String objective,
  required int spanishLevel,
  required int dailyMinutes,
  required String currentKnowledge,
  required String musicPreferences,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserProfileTableTableUpdateCompanionBuilder
    = UserProfileTableCompanion Function({
  Value<int> id,
  Value<String> objective,
  Value<int> spanishLevel,
  Value<int> dailyMinutes,
  Value<String> currentKnowledge,
  Value<String> musicPreferences,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get spanishLevel => $composableBuilder(
      column: $table.spanishLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyMinutes => $composableBuilder(
      column: $table.dailyMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentKnowledge => $composableBuilder(
      column: $table.currentKnowledge,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get musicPreferences => $composableBuilder(
      column: $table.musicPreferences,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get objective => $composableBuilder(
      column: $table.objective, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get spanishLevel => $composableBuilder(
      column: $table.spanishLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyMinutes => $composableBuilder(
      column: $table.dailyMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentKnowledge => $composableBuilder(
      column: $table.currentKnowledge,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get musicPreferences => $composableBuilder(
      column: $table.musicPreferences,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<int> get spanishLevel => $composableBuilder(
      column: $table.spanishLevel, builder: (column) => column);

  GeneratedColumn<int> get dailyMinutes => $composableBuilder(
      column: $table.dailyMinutes, builder: (column) => column);

  GeneratedColumn<String> get currentKnowledge => $composableBuilder(
      column: $table.currentKnowledge, builder: (column) => column);

  GeneratedColumn<String> get musicPreferences => $composableBuilder(
      column: $table.musicPreferences, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfileTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfileTableTable,
    UserProfileTableData,
    $$UserProfileTableTableFilterComposer,
    $$UserProfileTableTableOrderingComposer,
    $$UserProfileTableTableAnnotationComposer,
    $$UserProfileTableTableCreateCompanionBuilder,
    $$UserProfileTableTableUpdateCompanionBuilder,
    (
      UserProfileTableData,
      BaseReferences<_$AppDatabase, $UserProfileTableTable,
          UserProfileTableData>
    ),
    UserProfileTableData,
    PrefetchHooks Function()> {
  $$UserProfileTableTableTableManager(
      _$AppDatabase db, $UserProfileTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> objective = const Value.absent(),
            Value<int> spanishLevel = const Value.absent(),
            Value<int> dailyMinutes = const Value.absent(),
            Value<String> currentKnowledge = const Value.absent(),
            Value<String> musicPreferences = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserProfileTableCompanion(
            id: id,
            objective: objective,
            spanishLevel: spanishLevel,
            dailyMinutes: dailyMinutes,
            currentKnowledge: currentKnowledge,
            musicPreferences: musicPreferences,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String objective,
            required int spanishLevel,
            required int dailyMinutes,
            required String currentKnowledge,
            required String musicPreferences,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserProfileTableCompanion.insert(
            id: id,
            objective: objective,
            spanishLevel: spanishLevel,
            dailyMinutes: dailyMinutes,
            currentKnowledge: currentKnowledge,
            musicPreferences: musicPreferences,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$UserProfileTableTable, UserProfileTableData>(
                        table),
                    BaseReferences<_$AppDatabase, $UserProfileTableTable,
                        UserProfileTableData>(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfileTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfileTableTable,
    UserProfileTableData,
    $$UserProfileTableTableFilterComposer,
    $$UserProfileTableTableOrderingComposer,
    $$UserProfileTableTableAnnotationComposer,
    $$UserProfileTableTableCreateCompanionBuilder,
    $$UserProfileTableTableUpdateCompanionBuilder,
    (
      UserProfileTableData,
      BaseReferences<_$AppDatabase, $UserProfileTableTable,
          UserProfileTableData>
    ),
    UserProfileTableData,
    PrefetchHooks Function()>;
typedef $$SongsTableTableCreateCompanionBuilder = SongsTableCompanion Function({
  Value<int> id,
  required String title,
  required String artist,
  required String fullLyrics,
  Value<DateTime> createdAt,
});
typedef $$SongsTableTableUpdateCompanionBuilder = SongsTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String> fullLyrics,
  Value<DateTime> createdAt,
});

final class $$SongsTableTableReferences
    extends BaseReferences<_$AppDatabase, $SongsTableTable, SongsTableData> {
  $$SongsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SongSectionsTableTable,
      List<SongSectionsTableData>> _songSectionsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.songSectionsTable,
          aliasName: 'songs_table__id__song_sections_table__song_id');

  $$SongSectionsTableTableProcessedTableManager get songSectionsTableRefs {
    final manager =
        $$SongSectionsTableTableTableManager($_db, $_db.songSectionsTable)
            .filter((f) => f.songId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_songSectionsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LessonPlansTableTable, List<LessonPlansTableData>>
      _lessonPlansTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.lessonPlansTable,
              aliasName: 'songs_table__id__lesson_plans_table__song_id');

  $$LessonPlansTableTableProcessedTableManager get lessonPlansTableRefs {
    final manager =
        $$LessonPlansTableTableTableManager($_db, $_db.lessonPlansTable)
            .filter((f) => f.songId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_lessonPlansTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LessonContentTableTable,
      List<LessonContentTableData>> _lessonContentTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.lessonContentTable,
          aliasName: 'songs_table__id__lesson_content_table__song_id');

  $$LessonContentTableTableProcessedTableManager get lessonContentTableRefs {
    final manager =
        $$LessonContentTableTableTableManager($_db, $_db.lessonContentTable)
            .filter((f) => f.songId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_lessonContentTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$VocabularyTableTable, List<VocabularyTableData>>
      _vocabularyTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.vocabularyTable,
              aliasName: 'songs_table__id__vocabulary_table__song_id');

  $$VocabularyTableTableProcessedTableManager get vocabularyTableRefs {
    final manager =
        $$VocabularyTableTableTableManager($_db, $_db.vocabularyTable)
            .filter((f) => f.songId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_vocabularyTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SongsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SongsTableTable> {
  $$SongsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullLyrics => $composableBuilder(
      column: $table.fullLyrics, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> songSectionsTableRefs(
      Expression<bool> Function($$SongSectionsTableTableFilterComposer f) f) {
    final $$SongSectionsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.songSectionsTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongSectionsTableTableFilterComposer(
              $db: $db,
              $table: $db.songSectionsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lessonPlansTableRefs(
      Expression<bool> Function($$LessonPlansTableTableFilterComposer f) f) {
    final $$LessonPlansTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lessonPlansTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LessonPlansTableTableFilterComposer(
              $db: $db,
              $table: $db.lessonPlansTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> lessonContentTableRefs(
      Expression<bool> Function($$LessonContentTableTableFilterComposer f) f) {
    final $$LessonContentTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lessonContentTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LessonContentTableTableFilterComposer(
              $db: $db,
              $table: $db.lessonContentTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> vocabularyTableRefs(
      Expression<bool> Function($$VocabularyTableTableFilterComposer f) f) {
    final $$VocabularyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vocabularyTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VocabularyTableTableFilterComposer(
              $db: $db,
              $table: $db.vocabularyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SongsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SongsTableTable> {
  $$SongsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullLyrics => $composableBuilder(
      column: $table.fullLyrics, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SongsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SongsTableTable> {
  $$SongsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get fullLyrics => $composableBuilder(
      column: $table.fullLyrics, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> songSectionsTableRefs<T extends Object>(
      Expression<T> Function($$SongSectionsTableTableAnnotationComposer a) f) {
    final $$SongSectionsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.songSectionsTable,
            getReferencedColumn: (t) => t.songId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SongSectionsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.songSectionsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> lessonPlansTableRefs<T extends Object>(
      Expression<T> Function($$LessonPlansTableTableAnnotationComposer a) f) {
    final $$LessonPlansTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.lessonPlansTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LessonPlansTableTableAnnotationComposer(
              $db: $db,
              $table: $db.lessonPlansTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> lessonContentTableRefs<T extends Object>(
      Expression<T> Function($$LessonContentTableTableAnnotationComposer a) f) {
    final $$LessonContentTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.lessonContentTable,
            getReferencedColumn: (t) => t.songId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LessonContentTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.lessonContentTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> vocabularyTableRefs<T extends Object>(
      Expression<T> Function($$VocabularyTableTableAnnotationComposer a) f) {
    final $$VocabularyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.vocabularyTable,
        getReferencedColumn: (t) => t.songId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VocabularyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.vocabularyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SongsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SongsTableTable,
    SongsTableData,
    $$SongsTableTableFilterComposer,
    $$SongsTableTableOrderingComposer,
    $$SongsTableTableAnnotationComposer,
    $$SongsTableTableCreateCompanionBuilder,
    $$SongsTableTableUpdateCompanionBuilder,
    (SongsTableData, $$SongsTableTableReferences),
    SongsTableData,
    PrefetchHooks Function(
        {bool songSectionsTableRefs,
        bool lessonPlansTableRefs,
        bool lessonContentTableRefs,
        bool vocabularyTableRefs})> {
  $$SongsTableTableTableManager(_$AppDatabase db, $SongsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> fullLyrics = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SongsTableCompanion(
            id: id,
            title: title,
            artist: artist,
            fullLyrics: fullLyrics,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            required String fullLyrics,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              SongsTableCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            fullLyrics: fullLyrics,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SongsTableTable, SongsTableData>(table),
                    $$SongsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {songSectionsTableRefs = false,
              lessonPlansTableRefs = false,
              lessonContentTableRefs = false,
              vocabularyTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (songSectionsTableRefs) db.songSectionsTable,
                if (lessonPlansTableRefs) db.lessonPlansTable,
                if (lessonContentTableRefs) db.lessonContentTable,
                if (vocabularyTableRefs) db.vocabularyTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (songSectionsTableRefs)
                    await $_getPrefetchedData<SongsTableData, $SongsTableTable,
                            SongSectionsTableData>(
                        currentTable: table,
                        referencedTable: $$SongsTableTableReferences
                            ._songSectionsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SongsTableTableReferences(db, table, p0)
                                .songSectionsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.songId == item.id),
                        typedResults: items),
                  if (lessonPlansTableRefs)
                    await $_getPrefetchedData<SongsTableData, $SongsTableTable,
                            LessonPlansTableData>(
                        currentTable: table,
                        referencedTable: $$SongsTableTableReferences
                            ._lessonPlansTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SongsTableTableReferences(db, table, p0)
                                .lessonPlansTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.songId == item.id),
                        typedResults: items),
                  if (lessonContentTableRefs)
                    await $_getPrefetchedData<SongsTableData, $SongsTableTable,
                            LessonContentTableData>(
                        currentTable: table,
                        referencedTable: $$SongsTableTableReferences
                            ._lessonContentTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SongsTableTableReferences(db, table, p0)
                                .lessonContentTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.songId == item.id),
                        typedResults: items),
                  if (vocabularyTableRefs)
                    await $_getPrefetchedData<SongsTableData, $SongsTableTable,
                            VocabularyTableData>(
                        currentTable: table,
                        referencedTable: $$SongsTableTableReferences
                            ._vocabularyTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SongsTableTableReferences(db, table, p0)
                                .vocabularyTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.songId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SongsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SongsTableTable,
    SongsTableData,
    $$SongsTableTableFilterComposer,
    $$SongsTableTableOrderingComposer,
    $$SongsTableTableAnnotationComposer,
    $$SongsTableTableCreateCompanionBuilder,
    $$SongsTableTableUpdateCompanionBuilder,
    (SongsTableData, $$SongsTableTableReferences),
    SongsTableData,
    PrefetchHooks Function(
        {bool songSectionsTableRefs,
        bool lessonPlansTableRefs,
        bool lessonContentTableRefs,
        bool vocabularyTableRefs})>;
typedef $$SongSectionsTableTableCreateCompanionBuilder
    = SongSectionsTableCompanion Function({
  Value<int> id,
  required int songId,
  required int sectionOrder,
  required String label,
  required String textContent,
});
typedef $$SongSectionsTableTableUpdateCompanionBuilder
    = SongSectionsTableCompanion Function({
  Value<int> id,
  Value<int> songId,
  Value<int> sectionOrder,
  Value<String> label,
  Value<String> textContent,
});

final class $$SongSectionsTableTableReferences extends BaseReferences<
    _$AppDatabase, $SongSectionsTableTable, SongSectionsTableData> {
  $$SongSectionsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SongsTableTable _songIdTable(_$AppDatabase db) => db.songsTable
      .createAlias('song_sections_table__song_id__songs_table__id');

  $$SongsTableTableProcessedTableManager get songId {
    final $_column = $_itemColumn<int>('song_id')!;

    final manager = $$SongsTableTableTableManager($_db, $_db.songsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_songIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SongSectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SongSectionsTableTable> {
  $$SongSectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnFilters(column));

  $$SongsTableTableFilterComposer get songId {
    final $$SongsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableFilterComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SongSectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SongSectionsTableTable> {
  $$SongSectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => ColumnOrderings(column));

  $$SongsTableTableOrderingComposer get songId {
    final $$SongsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableOrderingComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SongSectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SongSectionsTableTable> {
  $$SongSectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sectionOrder => $composableBuilder(
      column: $table.sectionOrder, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get textContent => $composableBuilder(
      column: $table.textContent, builder: (column) => column);

  $$SongsTableTableAnnotationComposer get songId {
    final $$SongsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SongSectionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SongSectionsTableTable,
    SongSectionsTableData,
    $$SongSectionsTableTableFilterComposer,
    $$SongSectionsTableTableOrderingComposer,
    $$SongSectionsTableTableAnnotationComposer,
    $$SongSectionsTableTableCreateCompanionBuilder,
    $$SongSectionsTableTableUpdateCompanionBuilder,
    (SongSectionsTableData, $$SongSectionsTableTableReferences),
    SongSectionsTableData,
    PrefetchHooks Function({bool songId})> {
  $$SongSectionsTableTableTableManager(
      _$AppDatabase db, $SongSectionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongSectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongSectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongSectionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> songId = const Value.absent(),
            Value<int> sectionOrder = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> textContent = const Value.absent(),
          }) =>
              SongSectionsTableCompanion(
            id: id,
            songId: songId,
            sectionOrder: sectionOrder,
            label: label,
            textContent: textContent,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int songId,
            required int sectionOrder,
            required String label,
            required String textContent,
          }) =>
              SongSectionsTableCompanion.insert(
            id: id,
            songId: songId,
            sectionOrder: sectionOrder,
            label: label,
            textContent: textContent,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SongSectionsTableTable, SongSectionsTableData>(
                        table),
                    $$SongSectionsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({songId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (songId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.songId,
                    referencedTable:
                        $$SongSectionsTableTableReferences._songIdTable(db),
                    referencedColumn:
                        $$SongSectionsTableTableReferences._songIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SongSectionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SongSectionsTableTable,
    SongSectionsTableData,
    $$SongSectionsTableTableFilterComposer,
    $$SongSectionsTableTableOrderingComposer,
    $$SongSectionsTableTableAnnotationComposer,
    $$SongSectionsTableTableCreateCompanionBuilder,
    $$SongSectionsTableTableUpdateCompanionBuilder,
    (SongSectionsTableData, $$SongSectionsTableTableReferences),
    SongSectionsTableData,
    PrefetchHooks Function({bool songId})>;
typedef $$LessonPlansTableTableCreateCompanionBuilder
    = LessonPlansTableCompanion Function({
  Value<int> id,
  required int songId,
  required int totalDays,
  required String planJson,
  Value<int> currentDay,
  Value<bool> isCompleted,
  Value<DateTime> createdAt,
});
typedef $$LessonPlansTableTableUpdateCompanionBuilder
    = LessonPlansTableCompanion Function({
  Value<int> id,
  Value<int> songId,
  Value<int> totalDays,
  Value<String> planJson,
  Value<int> currentDay,
  Value<bool> isCompleted,
  Value<DateTime> createdAt,
});

final class $$LessonPlansTableTableReferences extends BaseReferences<
    _$AppDatabase, $LessonPlansTableTable, LessonPlansTableData> {
  $$LessonPlansTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SongsTableTable _songIdTable(_$AppDatabase db) =>
      db.songsTable.createAlias('lesson_plans_table__song_id__songs_table__id');

  $$SongsTableTableProcessedTableManager get songId {
    final $_column = $_itemColumn<int>('song_id')!;

    final manager = $$SongsTableTableTableManager($_db, $_db.songsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_songIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LessonPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $LessonPlansTableTable> {
  $$LessonPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalDays => $composableBuilder(
      column: $table.totalDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get planJson => $composableBuilder(
      column: $table.planJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentDay => $composableBuilder(
      column: $table.currentDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SongsTableTableFilterComposer get songId {
    final $$SongsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableFilterComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonPlansTableTable> {
  $$LessonPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalDays => $composableBuilder(
      column: $table.totalDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planJson => $composableBuilder(
      column: $table.planJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentDay => $composableBuilder(
      column: $table.currentDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SongsTableTableOrderingComposer get songId {
    final $$SongsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableOrderingComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonPlansTableTable> {
  $$LessonPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalDays =>
      $composableBuilder(column: $table.totalDays, builder: (column) => column);

  GeneratedColumn<String> get planJson =>
      $composableBuilder(column: $table.planJson, builder: (column) => column);

  GeneratedColumn<int> get currentDay => $composableBuilder(
      column: $table.currentDay, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SongsTableTableAnnotationComposer get songId {
    final $$SongsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonPlansTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonPlansTableTable,
    LessonPlansTableData,
    $$LessonPlansTableTableFilterComposer,
    $$LessonPlansTableTableOrderingComposer,
    $$LessonPlansTableTableAnnotationComposer,
    $$LessonPlansTableTableCreateCompanionBuilder,
    $$LessonPlansTableTableUpdateCompanionBuilder,
    (LessonPlansTableData, $$LessonPlansTableTableReferences),
    LessonPlansTableData,
    PrefetchHooks Function({bool songId})> {
  $$LessonPlansTableTableTableManager(
      _$AppDatabase db, $LessonPlansTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonPlansTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> songId = const Value.absent(),
            Value<int> totalDays = const Value.absent(),
            Value<String> planJson = const Value.absent(),
            Value<int> currentDay = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LessonPlansTableCompanion(
            id: id,
            songId: songId,
            totalDays: totalDays,
            planJson: planJson,
            currentDay: currentDay,
            isCompleted: isCompleted,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int songId,
            required int totalDays,
            required String planJson,
            Value<int> currentDay = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              LessonPlansTableCompanion.insert(
            id: id,
            songId: songId,
            totalDays: totalDays,
            planJson: planJson,
            currentDay: currentDay,
            isCompleted: isCompleted,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LessonPlansTableTable, LessonPlansTableData>(
                        table),
                    $$LessonPlansTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({songId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (songId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.songId,
                    referencedTable:
                        $$LessonPlansTableTableReferences._songIdTable(db),
                    referencedColumn:
                        $$LessonPlansTableTableReferences._songIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LessonPlansTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonPlansTableTable,
    LessonPlansTableData,
    $$LessonPlansTableTableFilterComposer,
    $$LessonPlansTableTableOrderingComposer,
    $$LessonPlansTableTableAnnotationComposer,
    $$LessonPlansTableTableCreateCompanionBuilder,
    $$LessonPlansTableTableUpdateCompanionBuilder,
    (LessonPlansTableData, $$LessonPlansTableTableReferences),
    LessonPlansTableData,
    PrefetchHooks Function({bool songId})>;
typedef $$LessonContentTableTableCreateCompanionBuilder
    = LessonContentTableCompanion Function({
  Value<int> id,
  required int songId,
  required int day,
  required String contentJson,
  Value<bool> isCompleted,
  Value<DateTime> generatedAt,
});
typedef $$LessonContentTableTableUpdateCompanionBuilder
    = LessonContentTableCompanion Function({
  Value<int> id,
  Value<int> songId,
  Value<int> day,
  Value<String> contentJson,
  Value<bool> isCompleted,
  Value<DateTime> generatedAt,
});

final class $$LessonContentTableTableReferences extends BaseReferences<
    _$AppDatabase, $LessonContentTableTable, LessonContentTableData> {
  $$LessonContentTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SongsTableTable _songIdTable(_$AppDatabase db) => db.songsTable
      .createAlias('lesson_content_table__song_id__songs_table__id');

  $$SongsTableTableProcessedTableManager get songId {
    final $_column = $_itemColumn<int>('song_id')!;

    final manager = $$SongsTableTableTableManager($_db, $_db.songsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_songIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LessonContentTableTableFilterComposer
    extends Composer<_$AppDatabase, $LessonContentTableTable> {
  $$LessonContentTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get day => $composableBuilder(
      column: $table.day, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));

  $$SongsTableTableFilterComposer get songId {
    final $$SongsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableFilterComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonContentTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonContentTableTable> {
  $$LessonContentTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get day => $composableBuilder(
      column: $table.day, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));

  $$SongsTableTableOrderingComposer get songId {
    final $$SongsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableOrderingComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonContentTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonContentTableTable> {
  $$LessonContentTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get contentJson => $composableBuilder(
      column: $table.contentJson, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);

  $$SongsTableTableAnnotationComposer get songId {
    final $$SongsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LessonContentTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LessonContentTableTable,
    LessonContentTableData,
    $$LessonContentTableTableFilterComposer,
    $$LessonContentTableTableOrderingComposer,
    $$LessonContentTableTableAnnotationComposer,
    $$LessonContentTableTableCreateCompanionBuilder,
    $$LessonContentTableTableUpdateCompanionBuilder,
    (LessonContentTableData, $$LessonContentTableTableReferences),
    LessonContentTableData,
    PrefetchHooks Function({bool songId})> {
  $$LessonContentTableTableTableManager(
      _$AppDatabase db, $LessonContentTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonContentTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonContentTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonContentTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> songId = const Value.absent(),
            Value<int> day = const Value.absent(),
            Value<String> contentJson = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              LessonContentTableCompanion(
            id: id,
            songId: songId,
            day: day,
            contentJson: contentJson,
            isCompleted: isCompleted,
            generatedAt: generatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int songId,
            required int day,
            required String contentJson,
            Value<bool> isCompleted = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
          }) =>
              LessonContentTableCompanion.insert(
            id: id,
            songId: songId,
            day: day,
            contentJson: contentJson,
            isCompleted: isCompleted,
            generatedAt: generatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$LessonContentTableTable,
                        LessonContentTableData>(table),
                    $$LessonContentTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({songId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (songId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.songId,
                    referencedTable:
                        $$LessonContentTableTableReferences._songIdTable(db),
                    referencedColumn:
                        $$LessonContentTableTableReferences._songIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LessonContentTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LessonContentTableTable,
    LessonContentTableData,
    $$LessonContentTableTableFilterComposer,
    $$LessonContentTableTableOrderingComposer,
    $$LessonContentTableTableAnnotationComposer,
    $$LessonContentTableTableCreateCompanionBuilder,
    $$LessonContentTableTableUpdateCompanionBuilder,
    (LessonContentTableData, $$LessonContentTableTableReferences),
    LessonContentTableData,
    PrefetchHooks Function({bool songId})>;
typedef $$VocabularyTableTableCreateCompanionBuilder = VocabularyTableCompanion
    Function({
  Value<int> id,
  Value<int?> songId,
  required String word,
  required String translation,
  required String exampleSentence,
  required String origin,
  Value<DateTime> createdAt,
});
typedef $$VocabularyTableTableUpdateCompanionBuilder = VocabularyTableCompanion
    Function({
  Value<int> id,
  Value<int?> songId,
  Value<String> word,
  Value<String> translation,
  Value<String> exampleSentence,
  Value<String> origin,
  Value<DateTime> createdAt,
});

final class $$VocabularyTableTableReferences extends BaseReferences<
    _$AppDatabase, $VocabularyTableTable, VocabularyTableData> {
  $$VocabularyTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SongsTableTable _songIdTable(_$AppDatabase db) =>
      db.songsTable.createAlias('vocabulary_table__song_id__songs_table__id');

  $$SongsTableTableProcessedTableManager? get songId {
    final $_column = $_itemColumn<int>('song_id');
    if ($_column == null) return null;
    final manager = $$SongsTableTableTableManager($_db, $_db.songsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_songIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ReviewScheduleTableTable,
      List<ReviewScheduleTableData>> _reviewScheduleTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.reviewScheduleTable,
          aliasName: 'vocabulary_table__id__review_schedule_table__vocab_id');

  $$ReviewScheduleTableTableProcessedTableManager get reviewScheduleTableRefs {
    final manager =
        $$ReviewScheduleTableTableTableManager($_db, $_db.reviewScheduleTable)
            .filter((f) => f.vocabId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_reviewScheduleTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$VocabularyTableTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SongsTableTableFilterComposer get songId {
    final $$SongsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableFilterComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> reviewScheduleTableRefs(
      Expression<bool> Function($$ReviewScheduleTableTableFilterComposer f) f) {
    final $$ReviewScheduleTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reviewScheduleTable,
        getReferencedColumn: (t) => t.vocabId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReviewScheduleTableTableFilterComposer(
              $db: $db,
              $table: $db.reviewScheduleTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$VocabularyTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SongsTableTableOrderingComposer get songId {
    final $$SongsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableOrderingComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VocabularyTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyTableTable> {
  $$VocabularyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => column);

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SongsTableTableAnnotationComposer get songId {
    final $$SongsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.songId,
        referencedTable: $db.songsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SongsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.songsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> reviewScheduleTableRefs<T extends Object>(
      Expression<T> Function($$ReviewScheduleTableTableAnnotationComposer a)
          f) {
    final $$ReviewScheduleTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.reviewScheduleTable,
            getReferencedColumn: (t) => t.vocabId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ReviewScheduleTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.reviewScheduleTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$VocabularyTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabularyTableTable,
    VocabularyTableData,
    $$VocabularyTableTableFilterComposer,
    $$VocabularyTableTableOrderingComposer,
    $$VocabularyTableTableAnnotationComposer,
    $$VocabularyTableTableCreateCompanionBuilder,
    $$VocabularyTableTableUpdateCompanionBuilder,
    (VocabularyTableData, $$VocabularyTableTableReferences),
    VocabularyTableData,
    PrefetchHooks Function({bool songId, bool reviewScheduleTableRefs})> {
  $$VocabularyTableTableTableManager(
      _$AppDatabase db, $VocabularyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> songId = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> translation = const Value.absent(),
            Value<String> exampleSentence = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              VocabularyTableCompanion(
            id: id,
            songId: songId,
            word: word,
            translation: translation,
            exampleSentence: exampleSentence,
            origin: origin,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> songId = const Value.absent(),
            required String word,
            required String translation,
            required String exampleSentence,
            required String origin,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              VocabularyTableCompanion.insert(
            id: id,
            songId: songId,
            word: word,
            translation: translation,
            exampleSentence: exampleSentence,
            origin: origin,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$VocabularyTableTable, VocabularyTableData>(
                        table),
                    $$VocabularyTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {songId = false, reviewScheduleTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewScheduleTableRefs) db.reviewScheduleTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (songId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.songId,
                    referencedTable:
                        $$VocabularyTableTableReferences._songIdTable(db),
                    referencedColumn:
                        $$VocabularyTableTableReferences._songIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewScheduleTableRefs)
                    await $_getPrefetchedData<VocabularyTableData,
                            $VocabularyTableTable, ReviewScheduleTableData>(
                        currentTable: table,
                        referencedTable: $$VocabularyTableTableReferences
                            ._reviewScheduleTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$VocabularyTableTableReferences(db, table, p0)
                                .reviewScheduleTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.vocabId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$VocabularyTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabularyTableTable,
    VocabularyTableData,
    $$VocabularyTableTableFilterComposer,
    $$VocabularyTableTableOrderingComposer,
    $$VocabularyTableTableAnnotationComposer,
    $$VocabularyTableTableCreateCompanionBuilder,
    $$VocabularyTableTableUpdateCompanionBuilder,
    (VocabularyTableData, $$VocabularyTableTableReferences),
    VocabularyTableData,
    PrefetchHooks Function({bool songId, bool reviewScheduleTableRefs})>;
typedef $$ReviewScheduleTableTableCreateCompanionBuilder
    = ReviewScheduleTableCompanion Function({
  Value<int> id,
  required int vocabId,
  Value<int> level,
  required DateTime nextReviewAt,
  Value<DateTime?> lastReviewedAt,
  Value<int> reviewCount,
});
typedef $$ReviewScheduleTableTableUpdateCompanionBuilder
    = ReviewScheduleTableCompanion Function({
  Value<int> id,
  Value<int> vocabId,
  Value<int> level,
  Value<DateTime> nextReviewAt,
  Value<DateTime?> lastReviewedAt,
  Value<int> reviewCount,
});

final class $$ReviewScheduleTableTableReferences extends BaseReferences<
    _$AppDatabase, $ReviewScheduleTableTable, ReviewScheduleTableData> {
  $$ReviewScheduleTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $VocabularyTableTable _vocabIdTable(_$AppDatabase db) =>
      db.vocabularyTable
          .createAlias('review_schedule_table__vocab_id__vocabulary_table__id');

  $$VocabularyTableTableProcessedTableManager get vocabId {
    final $_column = $_itemColumn<int>('vocab_id')!;

    final manager =
        $$VocabularyTableTableTableManager($_db, $_db.vocabularyTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vocabIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReviewScheduleTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewScheduleTableTable> {
  $$ReviewScheduleTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
      column: $table.lastReviewedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnFilters(column));

  $$VocabularyTableTableFilterComposer get vocabId {
    final $$VocabularyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vocabId,
        referencedTable: $db.vocabularyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VocabularyTableTableFilterComposer(
              $db: $db,
              $table: $db.vocabularyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewScheduleTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewScheduleTableTable> {
  $$ReviewScheduleTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
      column: $table.lastReviewedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnOrderings(column));

  $$VocabularyTableTableOrderingComposer get vocabId {
    final $$VocabularyTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vocabId,
        referencedTable: $db.vocabularyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VocabularyTableTableOrderingComposer(
              $db: $db,
              $table: $db.vocabularyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewScheduleTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewScheduleTableTable> {
  $$ReviewScheduleTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
      column: $table.nextReviewAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
      column: $table.lastReviewedAt, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => column);

  $$VocabularyTableTableAnnotationComposer get vocabId {
    final $$VocabularyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.vocabId,
        referencedTable: $db.vocabularyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VocabularyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.vocabularyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReviewScheduleTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewScheduleTableTable,
    ReviewScheduleTableData,
    $$ReviewScheduleTableTableFilterComposer,
    $$ReviewScheduleTableTableOrderingComposer,
    $$ReviewScheduleTableTableAnnotationComposer,
    $$ReviewScheduleTableTableCreateCompanionBuilder,
    $$ReviewScheduleTableTableUpdateCompanionBuilder,
    (ReviewScheduleTableData, $$ReviewScheduleTableTableReferences),
    ReviewScheduleTableData,
    PrefetchHooks Function({bool vocabId})> {
  $$ReviewScheduleTableTableTableManager(
      _$AppDatabase db, $ReviewScheduleTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewScheduleTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewScheduleTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewScheduleTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> vocabId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<DateTime> nextReviewAt = const Value.absent(),
            Value<DateTime?> lastReviewedAt = const Value.absent(),
            Value<int> reviewCount = const Value.absent(),
          }) =>
              ReviewScheduleTableCompanion(
            id: id,
            vocabId: vocabId,
            level: level,
            nextReviewAt: nextReviewAt,
            lastReviewedAt: lastReviewedAt,
            reviewCount: reviewCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int vocabId,
            Value<int> level = const Value.absent(),
            required DateTime nextReviewAt,
            Value<DateTime?> lastReviewedAt = const Value.absent(),
            Value<int> reviewCount = const Value.absent(),
          }) =>
              ReviewScheduleTableCompanion.insert(
            id: id,
            vocabId: vocabId,
            level: level,
            nextReviewAt: nextReviewAt,
            lastReviewedAt: lastReviewedAt,
            reviewCount: reviewCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ReviewScheduleTableTable,
                        ReviewScheduleTableData>(table),
                    $$ReviewScheduleTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({vocabId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (vocabId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.vocabId,
                    referencedTable:
                        $$ReviewScheduleTableTableReferences._vocabIdTable(db),
                    referencedColumn: $$ReviewScheduleTableTableReferences
                        ._vocabIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReviewScheduleTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewScheduleTableTable,
    ReviewScheduleTableData,
    $$ReviewScheduleTableTableFilterComposer,
    $$ReviewScheduleTableTableOrderingComposer,
    $$ReviewScheduleTableTableAnnotationComposer,
    $$ReviewScheduleTableTableCreateCompanionBuilder,
    $$ReviewScheduleTableTableUpdateCompanionBuilder,
    (ReviewScheduleTableData, $$ReviewScheduleTableTableReferences),
    ReviewScheduleTableData,
    PrefetchHooks Function({bool vocabId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
  $$SongsTableTableTableManager get songsTable =>
      $$SongsTableTableTableManager(_db, _db.songsTable);
  $$SongSectionsTableTableTableManager get songSectionsTable =>
      $$SongSectionsTableTableTableManager(_db, _db.songSectionsTable);
  $$LessonPlansTableTableTableManager get lessonPlansTable =>
      $$LessonPlansTableTableTableManager(_db, _db.lessonPlansTable);
  $$LessonContentTableTableTableManager get lessonContentTable =>
      $$LessonContentTableTableTableManager(_db, _db.lessonContentTable);
  $$VocabularyTableTableTableManager get vocabularyTable =>
      $$VocabularyTableTableTableManager(_db, _db.vocabularyTable);
  $$ReviewScheduleTableTableTableManager get reviewScheduleTable =>
      $$ReviewScheduleTableTableTableManager(_db, _db.reviewScheduleTable);
}
