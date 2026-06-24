// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GroupsTableTable extends GroupsTable
    with TableInfo<$GroupsTableTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('TRY'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    currency,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Group> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GroupsTableTable createAlias(String alias) {
    return $GroupsTableTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  final int id;
  final String name;
  final String? category;
  final String currency;
  final DateTime createdAt;
  const Group({
    required this.id,
    required this.name,
    this.category,
    required this.currency,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['currency'] = Variable<String>(currency);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GroupsTableCompanion toCompanion(bool nullToAbsent) {
    return GroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      currency: Value(currency),
      createdAt: Value(createdAt),
    );
  }

  factory Group.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      currency: serializer.fromJson<String>(json['currency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'currency': serializer.toJson<String>(currency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Group copyWith({
    int? id,
    String? name,
    Value<String?> category = const Value.absent(),
    String? currency,
    DateTime? createdAt,
  }) => Group(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    currency: currency ?? this.currency,
    createdAt: createdAt ?? this.createdAt,
  );
  Group copyWithCompanion(GroupsTableCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      currency: data.currency.present ? data.currency.value : this.currency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, currency, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.currency == this.currency &&
          other.createdAt == this.createdAt);
}

class GroupsTableCompanion extends UpdateCompanion<Group> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<String> currency;
  final Value<DateTime> createdAt;
  const GroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.currency = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Group> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? currency,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (currency != null) 'currency': currency,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GroupsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? category,
    Value<String>? currency,
    Value<DateTime>? createdAt,
  }) {
    return GroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('currency: $currency, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MembersTableTable extends MembersTable
    with TableInfo<$MembersTableTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarColorMeta = const VerificationMeta(
    'avatarColor',
  );
  @override
  late final GeneratedColumn<String> avatarColor = GeneratedColumn<String>(
    'avatar_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES groups_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    avatarColor,
    groupId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar_color')) {
      context.handle(
        _avatarColorMeta,
        avatarColor.isAcceptableOrUnknown(
          data['avatar_color']!,
          _avatarColorMeta,
        ),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      avatarColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_color'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MembersTableTable createAlias(String alias) {
    return $MembersTableTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final String id;
  final String name;
  final String? avatarColor;
  final int groupId;
  final DateTime createdAt;
  const Member({
    required this.id,
    required this.name,
    this.avatarColor,
    required this.groupId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatarColor != null) {
      map['avatar_color'] = Variable<String>(avatarColor);
    }
    map['group_id'] = Variable<int>(groupId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MembersTableCompanion toCompanion(bool nullToAbsent) {
    return MembersTableCompanion(
      id: Value(id),
      name: Value(name),
      avatarColor: avatarColor == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarColor),
      groupId: Value(groupId),
      createdAt: Value(createdAt),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatarColor: serializer.fromJson<String?>(json['avatarColor']),
      groupId: serializer.fromJson<int>(json['groupId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'avatarColor': serializer.toJson<String?>(avatarColor),
      'groupId': serializer.toJson<int>(groupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Member copyWith({
    String? id,
    String? name,
    Value<String?> avatarColor = const Value.absent(),
    int? groupId,
    DateTime? createdAt,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    avatarColor: avatarColor.present ? avatarColor.value : this.avatarColor,
    groupId: groupId ?? this.groupId,
    createdAt: createdAt ?? this.createdAt,
  );
  Member copyWithCompanion(MembersTableCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatarColor: data.avatarColor.present
          ? data.avatarColor.value
          : this.avatarColor,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, avatarColor, groupId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatarColor == this.avatarColor &&
          other.groupId == this.groupId &&
          other.createdAt == this.createdAt);
}

class MembersTableCompanion extends UpdateCompanion<Member> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> avatarColor;
  final Value<int> groupId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MembersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarColor = const Value.absent(),
    this.groupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersTableCompanion.insert({
    required String id,
    required String name,
    this.avatarColor = const Value.absent(),
    required int groupId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       groupId = Value(groupId);
  static Insertable<Member> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? avatarColor,
    Expression<int>? groupId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatarColor != null) 'avatar_color': avatarColor,
      if (groupId != null) 'group_id': groupId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? avatarColor,
    Value<int>? groupId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MembersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarColor: avatarColor ?? this.avatarColor,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarColor.present) {
      map['avatar_color'] = Variable<String>(avatarColor.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionsTableTable extends SectionsTable
    with TableInfo<$SectionsTableTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconBgColorMeta = const VerificationMeta(
    'iconBgColor',
  );
  @override
  late final GeneratedColumn<String> iconBgColor = GeneratedColumn<String>(
    'icon_bg_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconColorMeta = const VerificationMeta(
    'iconColor',
  );
  @override
  late final GeneratedColumn<String> iconColor = GeneratedColumn<String>(
    'icon_color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES groups_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    iconBgColor,
    iconColor,
    groupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Section> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('icon_bg_color')) {
      context.handle(
        _iconBgColorMeta,
        iconBgColor.isAcceptableOrUnknown(
          data['icon_bg_color']!,
          _iconBgColorMeta,
        ),
      );
    }
    if (data.containsKey('icon_color')) {
      context.handle(
        _iconColorMeta,
        iconColor.isAcceptableOrUnknown(data['icon_color']!, _iconColorMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      iconBgColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_bg_color'],
      ),
      iconColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_color'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
    );
  }

  @override
  $SectionsTableTable createAlias(String alias) {
    return $SectionsTableTable(attachedDatabase, alias);
  }
}

class Section extends DataClass implements Insertable<Section> {
  final int id;
  final String name;
  final String icon;
  final String? iconBgColor;
  final String? iconColor;
  final int groupId;
  const Section({
    required this.id,
    required this.name,
    required this.icon,
    this.iconBgColor,
    this.iconColor,
    required this.groupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    if (!nullToAbsent || iconBgColor != null) {
      map['icon_bg_color'] = Variable<String>(iconBgColor);
    }
    if (!nullToAbsent || iconColor != null) {
      map['icon_color'] = Variable<String>(iconColor);
    }
    map['group_id'] = Variable<int>(groupId);
    return map;
  }

  SectionsTableCompanion toCompanion(bool nullToAbsent) {
    return SectionsTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      iconBgColor: iconBgColor == null && nullToAbsent
          ? const Value.absent()
          : Value(iconBgColor),
      iconColor: iconColor == null && nullToAbsent
          ? const Value.absent()
          : Value(iconColor),
      groupId: Value(groupId),
    );
  }

  factory Section.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      iconBgColor: serializer.fromJson<String?>(json['iconBgColor']),
      iconColor: serializer.fromJson<String?>(json['iconColor']),
      groupId: serializer.fromJson<int>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'iconBgColor': serializer.toJson<String?>(iconBgColor),
      'iconColor': serializer.toJson<String?>(iconColor),
      'groupId': serializer.toJson<int>(groupId),
    };
  }

  Section copyWith({
    int? id,
    String? name,
    String? icon,
    Value<String?> iconBgColor = const Value.absent(),
    Value<String?> iconColor = const Value.absent(),
    int? groupId,
  }) => Section(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    iconBgColor: iconBgColor.present ? iconBgColor.value : this.iconBgColor,
    iconColor: iconColor.present ? iconColor.value : this.iconColor,
    groupId: groupId ?? this.groupId,
  );
  Section copyWithCompanion(SectionsTableCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      iconBgColor: data.iconBgColor.present
          ? data.iconBgColor.value
          : this.iconBgColor,
      iconColor: data.iconColor.present ? data.iconColor.value : this.iconColor,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconBgColor: $iconBgColor, ')
          ..write('iconColor: $iconColor, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, icon, iconBgColor, iconColor, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.iconBgColor == this.iconBgColor &&
          other.iconColor == this.iconColor &&
          other.groupId == this.groupId);
}

class SectionsTableCompanion extends UpdateCompanion<Section> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String?> iconBgColor;
  final Value<String?> iconColor;
  final Value<int> groupId;
  const SectionsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.iconBgColor = const Value.absent(),
    this.iconColor = const Value.absent(),
    this.groupId = const Value.absent(),
  });
  SectionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    this.iconBgColor = const Value.absent(),
    this.iconColor = const Value.absent(),
    required int groupId,
  }) : name = Value(name),
       icon = Value(icon),
       groupId = Value(groupId);
  static Insertable<Section> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? iconBgColor,
    Expression<String>? iconColor,
    Expression<int>? groupId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (iconBgColor != null) 'icon_bg_color': iconBgColor,
      if (iconColor != null) 'icon_color': iconColor,
      if (groupId != null) 'group_id': groupId,
    });
  }

  SectionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String?>? iconBgColor,
    Value<String?>? iconColor,
    Value<int>? groupId,
  }) {
    return SectionsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      iconBgColor: iconBgColor ?? this.iconBgColor,
      iconColor: iconColor ?? this.iconColor,
      groupId: groupId ?? this.groupId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (iconBgColor.present) {
      map['icon_bg_color'] = Variable<String>(iconBgColor.value);
    }
    if (iconColor.present) {
      map['icon_color'] = Variable<String>(iconColor.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('iconBgColor: $iconBgColor, ')
          ..write('iconColor: $iconColor, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payerIdMeta = const VerificationMeta(
    'payerId',
  );
  @override
  late final GeneratedColumn<String> payerId = GeneratedColumn<String>(
    'payer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members_table (id)',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _splitTypeMeta = const VerificationMeta(
    'splitType',
  );
  @override
  late final GeneratedColumn<String> splitType = GeneratedColumn<String>(
    'split_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('equal'),
  );
  static const VerificationMeta _sectionIdMeta = const VerificationMeta(
    'sectionId',
  );
  @override
  late final GeneratedColumn<int> sectionId = GeneratedColumn<int>(
    'section_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sections_table (id)',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES groups_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    amount,
    payerId,
    description,
    category,
    splitType,
    sectionId,
    groupId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payer_id')) {
      context.handle(
        _payerIdMeta,
        payerId.isAcceptableOrUnknown(data['payer_id']!, _payerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_payerIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('split_type')) {
      context.handle(
        _splitTypeMeta,
        splitType.isAcceptableOrUnknown(data['split_type']!, _splitTypeMeta),
      );
    }
    if (data.containsKey('section_id')) {
      context.handle(
        _sectionIdMeta,
        sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      payerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payer_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      splitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}split_type'],
      )!,
      sectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}section_id'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final String title;
  final double amount;
  final String payerId;
  final String? description;
  final String? category;
  final String splitType;
  final int? sectionId;
  final int groupId;
  final DateTime createdAt;
  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.payerId,
    this.description,
    this.category,
    required this.splitType,
    this.sectionId,
    required this.groupId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['payer_id'] = Variable<String>(payerId);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['split_type'] = Variable<String>(splitType);
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<int>(sectionId);
    }
    map['group_id'] = Variable<int>(groupId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      payerId: Value(payerId),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      splitType: Value(splitType),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      groupId: Value(groupId),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      payerId: serializer.fromJson<String>(json['payerId']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      splitType: serializer.fromJson<String>(json['splitType']),
      sectionId: serializer.fromJson<int?>(json['sectionId']),
      groupId: serializer.fromJson<int>(json['groupId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'payerId': serializer.toJson<String>(payerId),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String?>(category),
      'splitType': serializer.toJson<String>(splitType),
      'sectionId': serializer.toJson<int?>(sectionId),
      'groupId': serializer.toJson<int>(groupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    String? payerId,
    Value<String?> description = const Value.absent(),
    Value<String?> category = const Value.absent(),
    String? splitType,
    Value<int?> sectionId = const Value.absent(),
    int? groupId,
    DateTime? createdAt,
  }) => Expense(
    id: id ?? this.id,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    payerId: payerId ?? this.payerId,
    description: description.present ? description.value : this.description,
    category: category.present ? category.value : this.category,
    splitType: splitType ?? this.splitType,
    sectionId: sectionId.present ? sectionId.value : this.sectionId,
    groupId: groupId ?? this.groupId,
    createdAt: createdAt ?? this.createdAt,
  );
  Expense copyWithCompanion(ExpensesTableCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      payerId: data.payerId.present ? data.payerId.value : this.payerId,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      splitType: data.splitType.present ? data.splitType.value : this.splitType,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('payerId: $payerId, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('splitType: $splitType, ')
          ..write('sectionId: $sectionId, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    amount,
    payerId,
    description,
    category,
    splitType,
    sectionId,
    groupId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.payerId == this.payerId &&
          other.description == this.description &&
          other.category == this.category &&
          other.splitType == this.splitType &&
          other.sectionId == this.sectionId &&
          other.groupId == this.groupId &&
          other.createdAt == this.createdAt);
}

class ExpensesTableCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> payerId;
  final Value<String?> description;
  final Value<String?> category;
  final Value<String> splitType;
  final Value<int?> sectionId;
  final Value<int> groupId;
  final Value<DateTime> createdAt;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.payerId = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.splitType = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double amount,
    required String payerId,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.splitType = const Value.absent(),
    this.sectionId = const Value.absent(),
    required int groupId,
    this.createdAt = const Value.absent(),
  }) : title = Value(title),
       amount = Value(amount),
       payerId = Value(payerId),
       groupId = Value(groupId);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? payerId,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? splitType,
    Expression<int>? sectionId,
    Expression<int>? groupId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (payerId != null) 'payer_id': payerId,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (splitType != null) 'split_type': splitType,
      if (sectionId != null) 'section_id': sectionId,
      if (groupId != null) 'group_id': groupId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<double>? amount,
    Value<String>? payerId,
    Value<String?>? description,
    Value<String?>? category,
    Value<String>? splitType,
    Value<int?>? sectionId,
    Value<int>? groupId,
    Value<DateTime>? createdAt,
  }) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      payerId: payerId ?? this.payerId,
      description: description ?? this.description,
      category: category ?? this.category,
      splitType: splitType ?? this.splitType,
      sectionId: sectionId ?? this.sectionId,
      groupId: groupId ?? this.groupId,
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
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (payerId.present) {
      map['payer_id'] = Variable<String>(payerId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (splitType.present) {
      map['split_type'] = Variable<String>(splitType.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<int>(sectionId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('payerId: $payerId, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('splitType: $splitType, ')
          ..write('sectionId: $sectionId, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ExpenseSplitsTableTable extends ExpenseSplitsTable
    with TableInfo<$ExpenseSplitsTableTable, ExpenseSplit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseSplitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members_table (id)',
    ),
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseIdMeta = const VerificationMeta(
    'expenseId',
  );
  @override
  late final GeneratedColumn<int> expenseId = GeneratedColumn<int>(
    'expense_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES expenses_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberId,
    percentage,
    amount,
    expenseId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_splits_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseSplit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('expense_id')) {
      context.handle(
        _expenseIdMeta,
        expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_expenseIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseSplit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseSplit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      expenseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expense_id'],
      )!,
    );
  }

  @override
  $ExpenseSplitsTableTable createAlias(String alias) {
    return $ExpenseSplitsTableTable(attachedDatabase, alias);
  }
}

class ExpenseSplit extends DataClass implements Insertable<ExpenseSplit> {
  final int id;
  final String memberId;
  final double percentage;
  final double amount;
  final int expenseId;
  const ExpenseSplit({
    required this.id,
    required this.memberId,
    required this.percentage,
    required this.amount,
    required this.expenseId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member_id'] = Variable<String>(memberId);
    map['percentage'] = Variable<double>(percentage);
    map['amount'] = Variable<double>(amount);
    map['expense_id'] = Variable<int>(expenseId);
    return map;
  }

  ExpenseSplitsTableCompanion toCompanion(bool nullToAbsent) {
    return ExpenseSplitsTableCompanion(
      id: Value(id),
      memberId: Value(memberId),
      percentage: Value(percentage),
      amount: Value(amount),
      expenseId: Value(expenseId),
    );
  }

  factory ExpenseSplit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseSplit(
      id: serializer.fromJson<int>(json['id']),
      memberId: serializer.fromJson<String>(json['memberId']),
      percentage: serializer.fromJson<double>(json['percentage']),
      amount: serializer.fromJson<double>(json['amount']),
      expenseId: serializer.fromJson<int>(json['expenseId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'memberId': serializer.toJson<String>(memberId),
      'percentage': serializer.toJson<double>(percentage),
      'amount': serializer.toJson<double>(amount),
      'expenseId': serializer.toJson<int>(expenseId),
    };
  }

  ExpenseSplit copyWith({
    int? id,
    String? memberId,
    double? percentage,
    double? amount,
    int? expenseId,
  }) => ExpenseSplit(
    id: id ?? this.id,
    memberId: memberId ?? this.memberId,
    percentage: percentage ?? this.percentage,
    amount: amount ?? this.amount,
    expenseId: expenseId ?? this.expenseId,
  );
  ExpenseSplit copyWithCompanion(ExpenseSplitsTableCompanion data) {
    return ExpenseSplit(
      id: data.id.present ? data.id.value : this.id,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      amount: data.amount.present ? data.amount.value : this.amount,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseSplit(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('percentage: $percentage, ')
          ..write('amount: $amount, ')
          ..write('expenseId: $expenseId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, memberId, percentage, amount, expenseId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseSplit &&
          other.id == this.id &&
          other.memberId == this.memberId &&
          other.percentage == this.percentage &&
          other.amount == this.amount &&
          other.expenseId == this.expenseId);
}

class ExpenseSplitsTableCompanion extends UpdateCompanion<ExpenseSplit> {
  final Value<int> id;
  final Value<String> memberId;
  final Value<double> percentage;
  final Value<double> amount;
  final Value<int> expenseId;
  const ExpenseSplitsTableCompanion({
    this.id = const Value.absent(),
    this.memberId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.amount = const Value.absent(),
    this.expenseId = const Value.absent(),
  });
  ExpenseSplitsTableCompanion.insert({
    this.id = const Value.absent(),
    required String memberId,
    required double percentage,
    required double amount,
    required int expenseId,
  }) : memberId = Value(memberId),
       percentage = Value(percentage),
       amount = Value(amount),
       expenseId = Value(expenseId);
  static Insertable<ExpenseSplit> custom({
    Expression<int>? id,
    Expression<String>? memberId,
    Expression<double>? percentage,
    Expression<double>? amount,
    Expression<int>? expenseId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberId != null) 'member_id': memberId,
      if (percentage != null) 'percentage': percentage,
      if (amount != null) 'amount': amount,
      if (expenseId != null) 'expense_id': expenseId,
    });
  }

  ExpenseSplitsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? memberId,
    Value<double>? percentage,
    Value<double>? amount,
    Value<int>? expenseId,
  }) {
    return ExpenseSplitsTableCompanion(
      id: id ?? this.id,
      memberId: memberId ?? this.memberId,
      percentage: percentage ?? this.percentage,
      amount: amount ?? this.amount,
      expenseId: expenseId ?? this.expenseId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<int>(expenseId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseSplitsTableCompanion(')
          ..write('id: $id, ')
          ..write('memberId: $memberId, ')
          ..write('percentage: $percentage, ')
          ..write('amount: $amount, ')
          ..write('expenseId: $expenseId')
          ..write(')'))
        .toString();
  }
}

class $LogsTableTable extends LogsTable with TableInfo<$LogsTableTable, Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberNameMeta = const VerificationMeta(
    'memberName',
  );
  @override
  late final GeneratedColumn<String> memberName = GeneratedColumn<String>(
    'member_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES groups_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    description,
    memberName,
    amount,
    groupId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<Log> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('member_name')) {
      context.handle(
        _memberNameMeta,
        memberName.isAcceptableOrUnknown(data['member_name']!, _memberNameMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Log(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      memberName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_name'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LogsTableTable createAlias(String alias) {
    return $LogsTableTable(attachedDatabase, alias);
  }
}

class Log extends DataClass implements Insertable<Log> {
  final int id;
  final String action;
  final String description;
  final String? memberName;
  final double? amount;
  final int groupId;
  final DateTime createdAt;
  const Log({
    required this.id,
    required this.action,
    required this.description,
    this.memberName,
    this.amount,
    required this.groupId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || memberName != null) {
      map['member_name'] = Variable<String>(memberName);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    map['group_id'] = Variable<int>(groupId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LogsTableCompanion toCompanion(bool nullToAbsent) {
    return LogsTableCompanion(
      id: Value(id),
      action: Value(action),
      description: Value(description),
      memberName: memberName == null && nullToAbsent
          ? const Value.absent()
          : Value(memberName),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      groupId: Value(groupId),
      createdAt: Value(createdAt),
    );
  }

  factory Log.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Log(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      description: serializer.fromJson<String>(json['description']),
      memberName: serializer.fromJson<String?>(json['memberName']),
      amount: serializer.fromJson<double?>(json['amount']),
      groupId: serializer.fromJson<int>(json['groupId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'description': serializer.toJson<String>(description),
      'memberName': serializer.toJson<String?>(memberName),
      'amount': serializer.toJson<double?>(amount),
      'groupId': serializer.toJson<int>(groupId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Log copyWith({
    int? id,
    String? action,
    String? description,
    Value<String?> memberName = const Value.absent(),
    Value<double?> amount = const Value.absent(),
    int? groupId,
    DateTime? createdAt,
  }) => Log(
    id: id ?? this.id,
    action: action ?? this.action,
    description: description ?? this.description,
    memberName: memberName.present ? memberName.value : this.memberName,
    amount: amount.present ? amount.value : this.amount,
    groupId: groupId ?? this.groupId,
    createdAt: createdAt ?? this.createdAt,
  );
  Log copyWithCompanion(LogsTableCompanion data) {
    return Log(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      description: data.description.present
          ? data.description.value
          : this.description,
      memberName: data.memberName.present
          ? data.memberName.value
          : this.memberName,
      amount: data.amount.present ? data.amount.value : this.amount,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Log(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('description: $description, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    action,
    description,
    memberName,
    amount,
    groupId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Log &&
          other.id == this.id &&
          other.action == this.action &&
          other.description == this.description &&
          other.memberName == this.memberName &&
          other.amount == this.amount &&
          other.groupId == this.groupId &&
          other.createdAt == this.createdAt);
}

class LogsTableCompanion extends UpdateCompanion<Log> {
  final Value<int> id;
  final Value<String> action;
  final Value<String> description;
  final Value<String?> memberName;
  final Value<double?> amount;
  final Value<int> groupId;
  final Value<DateTime> createdAt;
  const LogsTableCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.description = const Value.absent(),
    this.memberName = const Value.absent(),
    this.amount = const Value.absent(),
    this.groupId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    required String description,
    this.memberName = const Value.absent(),
    this.amount = const Value.absent(),
    required int groupId,
    this.createdAt = const Value.absent(),
  }) : action = Value(action),
       description = Value(description),
       groupId = Value(groupId);
  static Insertable<Log> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? description,
    Expression<String>? memberName,
    Expression<double>? amount,
    Expression<int>? groupId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (description != null) 'description': description,
      if (memberName != null) 'member_name': memberName,
      if (amount != null) 'amount': amount,
      if (groupId != null) 'group_id': groupId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LogsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String>? description,
    Value<String?>? memberName,
    Value<double?>? amount,
    Value<int>? groupId,
    Value<DateTime>? createdAt,
  }) {
    return LogsTableCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      description: description ?? this.description,
      memberName: memberName ?? this.memberName,
      amount: amount ?? this.amount,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (memberName.present) {
      map['member_name'] = Variable<String>(memberName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('description: $description, ')
          ..write('memberName: $memberName, ')
          ..write('amount: $amount, ')
          ..write('groupId: $groupId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GroupsTableTable groupsTable = $GroupsTableTable(this);
  late final $MembersTableTable membersTable = $MembersTableTable(this);
  late final $SectionsTableTable sectionsTable = $SectionsTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $ExpenseSplitsTableTable expenseSplitsTable =
      $ExpenseSplitsTableTable(this);
  late final $LogsTableTable logsTable = $LogsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    groupsTable,
    membersTable,
    sectionsTable,
    expensesTable,
    expenseSplitsTable,
    logsTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('members_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sections_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'expenses_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expense_splits_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'groups_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('logs_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GroupsTableTableCreateCompanionBuilder =
    GroupsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> category,
      Value<String> currency,
      Value<DateTime> createdAt,
    });
typedef $$GroupsTableTableUpdateCompanionBuilder =
    GroupsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> category,
      Value<String> currency,
      Value<DateTime> createdAt,
    });

final class $$GroupsTableTableReferences
    extends BaseReferences<_$AppDatabase, $GroupsTableTable, Group> {
  $$GroupsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MembersTableTable, List<Member>>
  _membersTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.membersTable,
    aliasName: $_aliasNameGenerator(db.groupsTable.id, db.membersTable.groupId),
  );

  $$MembersTableTableProcessedTableManager get membersTableRefs {
    final manager = $$MembersTableTableTableManager(
      $_db,
      $_db.membersTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_membersTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SectionsTableTable, List<Section>>
  _sectionsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sectionsTable,
    aliasName: $_aliasNameGenerator(
      db.groupsTable.id,
      db.sectionsTable.groupId,
    ),
  );

  $$SectionsTableTableProcessedTableManager get sectionsTableRefs {
    final manager = $$SectionsTableTableTableManager(
      $_db,
      $_db.sectionsTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sectionsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<Expense>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.groupsTable.id,
      db.expensesTable.groupId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogsTableTable, List<Log>> _logsTableRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.logsTable,
    aliasName: $_aliasNameGenerator(db.groupsTable.id, db.logsTable.groupId),
  );

  $$LogsTableTableProcessedTableManager get logsTableRefs {
    final manager = $$LogsTableTableTableManager(
      $_db,
      $_db.logsTable,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupsTableTable> {
  $$GroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> membersTableRefs(
    Expression<bool> Function($$MembersTableTableFilterComposer f) f,
  ) {
    final $$MembersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableFilterComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sectionsTableRefs(
    Expression<bool> Function($$SectionsTableTableFilterComposer f) f,
  ) {
    final $$SectionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionsTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableTableFilterComposer(
            $db: $db,
            $table: $db.sectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logsTableRefs(
    Expression<bool> Function($$LogsTableTableFilterComposer f) f,
  ) {
    final $$LogsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logsTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogsTableTableFilterComposer(
            $db: $db,
            $table: $db.logsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupsTableTable> {
  $$GroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupsTableTable> {
  $$GroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> membersTableRefs<T extends Object>(
    Expression<T> Function($$MembersTableTableAnnotationComposer a) f,
  ) {
    final $$MembersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sectionsTableRefs<T extends Object>(
    Expression<T> Function($$SectionsTableTableAnnotationComposer a) f,
  ) {
    final $$SectionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sectionsTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logsTableRefs<T extends Object>(
    Expression<T> Function($$LogsTableTableAnnotationComposer a) f,
  ) {
    final $$LogsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logsTable,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.logsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GroupsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupsTableTable,
          Group,
          $$GroupsTableTableFilterComposer,
          $$GroupsTableTableOrderingComposer,
          $$GroupsTableTableAnnotationComposer,
          $$GroupsTableTableCreateCompanionBuilder,
          $$GroupsTableTableUpdateCompanionBuilder,
          (Group, $$GroupsTableTableReferences),
          Group,
          PrefetchHooks Function({
            bool membersTableRefs,
            bool sectionsTableRefs,
            bool expensesTableRefs,
            bool logsTableRefs,
          })
        > {
  $$GroupsTableTableTableManager(_$AppDatabase db, $GroupsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GroupsTableCompanion(
                id: id,
                name: name,
                category: category,
                currency: currency,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> category = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GroupsTableCompanion.insert(
                id: id,
                name: name,
                category: category,
                currency: currency,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GroupsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                membersTableRefs = false,
                sectionsTableRefs = false,
                expensesTableRefs = false,
                logsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (membersTableRefs) db.membersTable,
                    if (sectionsTableRefs) db.sectionsTable,
                    if (expensesTableRefs) db.expensesTable,
                    if (logsTableRefs) db.logsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (membersTableRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTableTable,
                          Member
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableTableReferences
                              ._membersTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).membersTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sectionsTableRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTableTable,
                          Section
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableTableReferences
                              ._sectionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).sectionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTableTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (logsTableRefs)
                        await $_getPrefetchedData<
                          Group,
                          $GroupsTableTable,
                          Log
                        >(
                          currentTable: table,
                          referencedTable: $$GroupsTableTableReferences
                              ._logsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GroupsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).logsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.groupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GroupsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupsTableTable,
      Group,
      $$GroupsTableTableFilterComposer,
      $$GroupsTableTableOrderingComposer,
      $$GroupsTableTableAnnotationComposer,
      $$GroupsTableTableCreateCompanionBuilder,
      $$GroupsTableTableUpdateCompanionBuilder,
      (Group, $$GroupsTableTableReferences),
      Group,
      PrefetchHooks Function({
        bool membersTableRefs,
        bool sectionsTableRefs,
        bool expensesTableRefs,
        bool logsTableRefs,
      })
    >;
typedef $$MembersTableTableCreateCompanionBuilder =
    MembersTableCompanion Function({
      required String id,
      required String name,
      Value<String?> avatarColor,
      required int groupId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$MembersTableTableUpdateCompanionBuilder =
    MembersTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> avatarColor,
      Value<int> groupId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$MembersTableTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTableTable, Member> {
  $$MembersTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupsTable.createAlias(
        $_aliasNameGenerator(db.membersTable.groupId, db.groupsTable.id),
      );

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableTableManager(
      $_db,
      $_db.groupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<Expense>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.membersTable.id,
      db.expensesTable.payerId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.payerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpenseSplitsTableTable, List<ExpenseSplit>>
  _expenseSplitsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.expenseSplitsTable,
        aliasName: $_aliasNameGenerator(
          db.membersTable.id,
          db.expenseSplitsTable.memberId,
        ),
      );

  $$ExpenseSplitsTableTableProcessedTableManager get expenseSplitsTableRefs {
    final manager = $$ExpenseSplitsTableTableTableManager(
      $_db,
      $_db.expenseSplitsTable,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _expenseSplitsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTableTable> {
  $$MembersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.payerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expenseSplitsTableRefs(
    Expression<bool> Function($$ExpenseSplitsTableTableFilterComposer f) f,
  ) {
    final $$ExpenseSplitsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseSplitsTable,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseSplitsTableTableFilterComposer(
            $db: $db,
            $table: $db.expenseSplitsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTableTable> {
  $$MembersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTableTable> {
  $$MembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.payerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expenseSplitsTableRefs<T extends Object>(
    Expression<T> Function($$ExpenseSplitsTableTableAnnotationComposer a) f,
  ) {
    final $$ExpenseSplitsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.expenseSplitsTable,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExpenseSplitsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.expenseSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MembersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTableTable,
          Member,
          $$MembersTableTableFilterComposer,
          $$MembersTableTableOrderingComposer,
          $$MembersTableTableAnnotationComposer,
          $$MembersTableTableCreateCompanionBuilder,
          $$MembersTableTableUpdateCompanionBuilder,
          (Member, $$MembersTableTableReferences),
          Member,
          PrefetchHooks Function({
            bool groupId,
            bool expensesTableRefs,
            bool expenseSplitsTableRefs,
          })
        > {
  $$MembersTableTableTableManager(_$AppDatabase db, $MembersTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatarColor = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersTableCompanion(
                id: id,
                name: name,
                avatarColor: avatarColor,
                groupId: groupId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> avatarColor = const Value.absent(),
                required int groupId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersTableCompanion.insert(
                id: id,
                name: name,
                avatarColor: avatarColor,
                groupId: groupId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembersTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                expensesTableRefs = false,
                expenseSplitsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expensesTableRefs) db.expensesTable,
                    if (expenseSplitsTableRefs) db.expenseSplitsTable,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$MembersTableTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$MembersTableTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          Member,
                          $MembersTableTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.payerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expenseSplitsTableRefs)
                        await $_getPrefetchedData<
                          Member,
                          $MembersTableTable,
                          ExpenseSplit
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableTableReferences
                              ._expenseSplitsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseSplitsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MembersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTableTable,
      Member,
      $$MembersTableTableFilterComposer,
      $$MembersTableTableOrderingComposer,
      $$MembersTableTableAnnotationComposer,
      $$MembersTableTableCreateCompanionBuilder,
      $$MembersTableTableUpdateCompanionBuilder,
      (Member, $$MembersTableTableReferences),
      Member,
      PrefetchHooks Function({
        bool groupId,
        bool expensesTableRefs,
        bool expenseSplitsTableRefs,
      })
    >;
typedef $$SectionsTableTableCreateCompanionBuilder =
    SectionsTableCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      Value<String?> iconBgColor,
      Value<String?> iconColor,
      required int groupId,
    });
typedef $$SectionsTableTableUpdateCompanionBuilder =
    SectionsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<String?> iconBgColor,
      Value<String?> iconColor,
      Value<int> groupId,
    });

final class $$SectionsTableTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTableTable, Section> {
  $$SectionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GroupsTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupsTable.createAlias(
        $_aliasNameGenerator(db.sectionsTable.groupId, db.groupsTable.id),
      );

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableTableManager(
      $_db,
      $_db.groupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpensesTableTable, List<Expense>>
  _expensesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expensesTable,
    aliasName: $_aliasNameGenerator(
      db.sectionsTable.id,
      db.expensesTable.sectionId,
    ),
  );

  $$ExpensesTableTableProcessedTableManager get expensesTableRefs {
    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.sectionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTableTable> {
  $$SectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconBgColor => $composableBuilder(
    column: $table.iconBgColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconColor => $composableBuilder(
    column: $table.iconColor,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> expensesTableRefs(
    Expression<bool> Function($$ExpensesTableTableFilterComposer f) f,
  ) {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTableTable> {
  $$SectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconBgColor => $composableBuilder(
    column: $table.iconBgColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconColor => $composableBuilder(
    column: $table.iconColor,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTableTable> {
  $$SectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get iconBgColor => $composableBuilder(
    column: $table.iconBgColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconColor =>
      $composableBuilder(column: $table.iconColor, builder: (column) => column);

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> expensesTableRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.sectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SectionsTableTable,
          Section,
          $$SectionsTableTableFilterComposer,
          $$SectionsTableTableOrderingComposer,
          $$SectionsTableTableAnnotationComposer,
          $$SectionsTableTableCreateCompanionBuilder,
          $$SectionsTableTableUpdateCompanionBuilder,
          (Section, $$SectionsTableTableReferences),
          Section,
          PrefetchHooks Function({bool groupId, bool expensesTableRefs})
        > {
  $$SectionsTableTableTableManager(_$AppDatabase db, $SectionsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String?> iconBgColor = const Value.absent(),
                Value<String?> iconColor = const Value.absent(),
                Value<int> groupId = const Value.absent(),
              }) => SectionsTableCompanion(
                id: id,
                name: name,
                icon: icon,
                iconBgColor: iconBgColor,
                iconColor: iconColor,
                groupId: groupId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                Value<String?> iconBgColor = const Value.absent(),
                Value<String?> iconColor = const Value.absent(),
                required int groupId,
              }) => SectionsTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                iconBgColor: iconBgColor,
                iconColor: iconColor,
                groupId: groupId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SectionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({groupId = false, expensesTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expensesTableRefs) db.expensesTable,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$SectionsTableTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$SectionsTableTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expensesTableRefs)
                        await $_getPrefetchedData<
                          Section,
                          $SectionsTableTable,
                          Expense
                        >(
                          currentTable: table,
                          referencedTable: $$SectionsTableTableReferences
                              ._expensesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SectionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SectionsTableTable,
      Section,
      $$SectionsTableTableFilterComposer,
      $$SectionsTableTableOrderingComposer,
      $$SectionsTableTableAnnotationComposer,
      $$SectionsTableTableCreateCompanionBuilder,
      $$SectionsTableTableUpdateCompanionBuilder,
      (Section, $$SectionsTableTableReferences),
      Section,
      PrefetchHooks Function({bool groupId, bool expensesTableRefs})
    >;
typedef $$ExpensesTableTableCreateCompanionBuilder =
    ExpensesTableCompanion Function({
      Value<int> id,
      required String title,
      required double amount,
      required String payerId,
      Value<String?> description,
      Value<String?> category,
      Value<String> splitType,
      Value<int?> sectionId,
      required int groupId,
      Value<DateTime> createdAt,
    });
typedef $$ExpensesTableTableUpdateCompanionBuilder =
    ExpensesTableCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<double> amount,
      Value<String> payerId,
      Value<String?> description,
      Value<String?> category,
      Value<String> splitType,
      Value<int?> sectionId,
      Value<int> groupId,
      Value<DateTime> createdAt,
    });

final class $$ExpensesTableTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTableTable, Expense> {
  $$ExpensesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MembersTableTable _payerIdTable(_$AppDatabase db) =>
      db.membersTable.createAlias(
        $_aliasNameGenerator(db.expensesTable.payerId, db.membersTable.id),
      );

  $$MembersTableTableProcessedTableManager get payerId {
    final $_column = $_itemColumn<String>('payer_id')!;

    final manager = $$MembersTableTableTableManager(
      $_db,
      $_db.membersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SectionsTableTable _sectionIdTable(_$AppDatabase db) =>
      db.sectionsTable.createAlias(
        $_aliasNameGenerator(db.expensesTable.sectionId, db.sectionsTable.id),
      );

  $$SectionsTableTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<int>('section_id');
    if ($_column == null) return null;
    final manager = $$SectionsTableTableTableManager(
      $_db,
      $_db.sectionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupsTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupsTable.createAlias(
        $_aliasNameGenerator(db.expensesTable.groupId, db.groupsTable.id),
      );

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableTableManager(
      $_db,
      $_db.groupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExpenseSplitsTableTable, List<ExpenseSplit>>
  _expenseSplitsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.expenseSplitsTable,
        aliasName: $_aliasNameGenerator(
          db.expensesTable.id,
          db.expenseSplitsTable.expenseId,
        ),
      );

  $$ExpenseSplitsTableTableProcessedTableManager get expenseSplitsTableRefs {
    final manager = $$ExpenseSplitsTableTableTableManager(
      $_db,
      $_db.expenseSplitsTable,
    ).filter((f) => f.expenseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _expenseSplitsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableTableFilterComposer get payerId {
    final $$MembersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableFilterComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableTableFilterComposer get sectionId {
    final $$SectionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableTableFilterComposer(
            $db: $db,
            $table: $db.sectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> expenseSplitsTableRefs(
    Expression<bool> Function($$ExpenseSplitsTableTableFilterComposer f) f,
  ) {
    final $$ExpenseSplitsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseSplitsTable,
      getReferencedColumn: (t) => t.expenseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseSplitsTableTableFilterComposer(
            $db: $db,
            $table: $db.expenseSplitsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get splitType => $composableBuilder(
    column: $table.splitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableTableOrderingComposer get payerId {
    final $$MembersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableOrderingComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableTableOrderingComposer get sectionId {
    final $$SectionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.sectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableAnnotationComposer({
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

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get splitType =>
      $composableBuilder(column: $table.splitType, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MembersTableTableAnnotationComposer get payerId {
    final $$MembersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.payerId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SectionsTableTableAnnotationComposer get sectionId {
    final $$SectionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sectionId,
      referencedTable: $db.sectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SectionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.sectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> expenseSplitsTableRefs<T extends Object>(
    Expression<T> Function($$ExpenseSplitsTableTableAnnotationComposer a) f,
  ) {
    final $$ExpenseSplitsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.expenseSplitsTable,
          getReferencedColumn: (t) => t.expenseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExpenseSplitsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.expenseSplitsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExpensesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTableTable,
          Expense,
          $$ExpensesTableTableFilterComposer,
          $$ExpensesTableTableOrderingComposer,
          $$ExpensesTableTableAnnotationComposer,
          $$ExpensesTableTableCreateCompanionBuilder,
          $$ExpensesTableTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableTableReferences),
          Expense,
          PrefetchHooks Function({
            bool payerId,
            bool sectionId,
            bool groupId,
            bool expenseSplitsTableRefs,
          })
        > {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> payerId = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String> splitType = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesTableCompanion(
                id: id,
                title: title,
                amount: amount,
                payerId: payerId,
                description: description,
                category: category,
                splitType: splitType,
                sectionId: sectionId,
                groupId: groupId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required double amount,
                required String payerId,
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String> splitType = const Value.absent(),
                Value<int?> sectionId = const Value.absent(),
                required int groupId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesTableCompanion.insert(
                id: id,
                title: title,
                amount: amount,
                payerId: payerId,
                description: description,
                category: category,
                splitType: splitType,
                sectionId: sectionId,
                groupId: groupId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                payerId = false,
                sectionId = false,
                groupId = false,
                expenseSplitsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (expenseSplitsTableRefs) db.expenseSplitsTable,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (payerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.payerId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._payerIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._payerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (sectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sectionId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._sectionIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._sectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$ExpensesTableTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$ExpensesTableTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (expenseSplitsTableRefs)
                        await $_getPrefetchedData<
                          Expense,
                          $ExpensesTableTable,
                          ExpenseSplit
                        >(
                          currentTable: table,
                          referencedTable: $$ExpensesTableTableReferences
                              ._expenseSplitsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExpensesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseSplitsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.expenseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExpensesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTableTable,
      Expense,
      $$ExpensesTableTableFilterComposer,
      $$ExpensesTableTableOrderingComposer,
      $$ExpensesTableTableAnnotationComposer,
      $$ExpensesTableTableCreateCompanionBuilder,
      $$ExpensesTableTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableTableReferences),
      Expense,
      PrefetchHooks Function({
        bool payerId,
        bool sectionId,
        bool groupId,
        bool expenseSplitsTableRefs,
      })
    >;
typedef $$ExpenseSplitsTableTableCreateCompanionBuilder =
    ExpenseSplitsTableCompanion Function({
      Value<int> id,
      required String memberId,
      required double percentage,
      required double amount,
      required int expenseId,
    });
typedef $$ExpenseSplitsTableTableUpdateCompanionBuilder =
    ExpenseSplitsTableCompanion Function({
      Value<int> id,
      Value<String> memberId,
      Value<double> percentage,
      Value<double> amount,
      Value<int> expenseId,
    });

final class $$ExpenseSplitsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ExpenseSplitsTableTable, ExpenseSplit> {
  $$ExpenseSplitsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MembersTableTable _memberIdTable(_$AppDatabase db) =>
      db.membersTable.createAlias(
        $_aliasNameGenerator(
          db.expenseSplitsTable.memberId,
          db.membersTable.id,
        ),
      );

  $$MembersTableTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableTableManager(
      $_db,
      $_db.membersTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExpensesTableTable _expenseIdTable(_$AppDatabase db) =>
      db.expensesTable.createAlias(
        $_aliasNameGenerator(
          db.expenseSplitsTable.expenseId,
          db.expensesTable.id,
        ),
      );

  $$ExpensesTableTableProcessedTableManager get expenseId {
    final $_column = $_itemColumn<int>('expense_id')!;

    final manager = $$ExpensesTableTableTableManager(
      $_db,
      $_db.expensesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_expenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpenseSplitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTableTable> {
  $$ExpenseSplitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$MembersTableTableFilterComposer get memberId {
    final $$MembersTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableFilterComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpensesTableTableFilterComposer get expenseId {
    final $$ExpensesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableFilterComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseSplitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTableTable> {
  $$ExpenseSplitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$MembersTableTableOrderingComposer get memberId {
    final $$MembersTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableOrderingComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpensesTableTableOrderingComposer get expenseId {
    final $$ExpensesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableOrderingComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseSplitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseSplitsTableTable> {
  $$ExpenseSplitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$MembersTableTableAnnotationComposer get memberId {
    final $$MembersTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.membersTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableTableAnnotationComposer(
            $db: $db,
            $table: $db.membersTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExpensesTableTableAnnotationComposer get expenseId {
    final $$ExpensesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.expenseId,
      referencedTable: $db.expensesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.expensesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpenseSplitsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseSplitsTableTable,
          ExpenseSplit,
          $$ExpenseSplitsTableTableFilterComposer,
          $$ExpenseSplitsTableTableOrderingComposer,
          $$ExpenseSplitsTableTableAnnotationComposer,
          $$ExpenseSplitsTableTableCreateCompanionBuilder,
          $$ExpenseSplitsTableTableUpdateCompanionBuilder,
          (ExpenseSplit, $$ExpenseSplitsTableTableReferences),
          ExpenseSplit,
          PrefetchHooks Function({bool memberId, bool expenseId})
        > {
  $$ExpenseSplitsTableTableTableManager(
    _$AppDatabase db,
    $ExpenseSplitsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseSplitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseSplitsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseSplitsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<double> percentage = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int> expenseId = const Value.absent(),
              }) => ExpenseSplitsTableCompanion(
                id: id,
                memberId: memberId,
                percentage: percentage,
                amount: amount,
                expenseId: expenseId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String memberId,
                required double percentage,
                required double amount,
                required int expenseId,
              }) => ExpenseSplitsTableCompanion.insert(
                id: id,
                memberId: memberId,
                percentage: percentage,
                amount: amount,
                expenseId: expenseId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpenseSplitsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({memberId = false, expenseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable:
                                    $$ExpenseSplitsTableTableReferences
                                        ._memberIdTable(db),
                                referencedColumn:
                                    $$ExpenseSplitsTableTableReferences
                                        ._memberIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (expenseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.expenseId,
                                referencedTable:
                                    $$ExpenseSplitsTableTableReferences
                                        ._expenseIdTable(db),
                                referencedColumn:
                                    $$ExpenseSplitsTableTableReferences
                                        ._expenseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseSplitsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseSplitsTableTable,
      ExpenseSplit,
      $$ExpenseSplitsTableTableFilterComposer,
      $$ExpenseSplitsTableTableOrderingComposer,
      $$ExpenseSplitsTableTableAnnotationComposer,
      $$ExpenseSplitsTableTableCreateCompanionBuilder,
      $$ExpenseSplitsTableTableUpdateCompanionBuilder,
      (ExpenseSplit, $$ExpenseSplitsTableTableReferences),
      ExpenseSplit,
      PrefetchHooks Function({bool memberId, bool expenseId})
    >;
typedef $$LogsTableTableCreateCompanionBuilder =
    LogsTableCompanion Function({
      Value<int> id,
      required String action,
      required String description,
      Value<String?> memberName,
      Value<double?> amount,
      required int groupId,
      Value<DateTime> createdAt,
    });
typedef $$LogsTableTableUpdateCompanionBuilder =
    LogsTableCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String> description,
      Value<String?> memberName,
      Value<double?> amount,
      Value<int> groupId,
      Value<DateTime> createdAt,
    });

final class $$LogsTableTableReferences
    extends BaseReferences<_$AppDatabase, $LogsTableTable, Log> {
  $$LogsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTableTable _groupIdTable(_$AppDatabase db) =>
      db.groupsTable.createAlias(
        $_aliasNameGenerator(db.logsTable.groupId, db.groupsTable.id),
      );

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$GroupsTableTableTableManager(
      $_db,
      $_db.groupsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberName => $composableBuilder(
    column: $table.memberName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableFilterComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberName => $composableBuilder(
    column: $table.memberName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableOrderingComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogsTableTable> {
  $$LogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get memberName => $composableBuilder(
    column: $table.memberName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groupsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.groupsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogsTableTable,
          Log,
          $$LogsTableTableFilterComposer,
          $$LogsTableTableOrderingComposer,
          $$LogsTableTableAnnotationComposer,
          $$LogsTableTableCreateCompanionBuilder,
          $$LogsTableTableUpdateCompanionBuilder,
          (Log, $$LogsTableTableReferences),
          Log,
          PrefetchHooks Function({bool groupId})
        > {
  $$LogsTableTableTableManager(_$AppDatabase db, $LogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> memberName = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LogsTableCompanion(
                id: id,
                action: action,
                description: description,
                memberName: memberName,
                amount: amount,
                groupId: groupId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                required String description,
                Value<String?> memberName = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                required int groupId,
                Value<DateTime> createdAt = const Value.absent(),
              }) => LogsTableCompanion.insert(
                id: id,
                action: action,
                description: description,
                memberName: memberName,
                amount: amount,
                groupId: groupId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LogsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable: $$LogsTableTableReferences
                                    ._groupIdTable(db),
                                referencedColumn: $$LogsTableTableReferences
                                    ._groupIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogsTableTable,
      Log,
      $$LogsTableTableFilterComposer,
      $$LogsTableTableOrderingComposer,
      $$LogsTableTableAnnotationComposer,
      $$LogsTableTableCreateCompanionBuilder,
      $$LogsTableTableUpdateCompanionBuilder,
      (Log, $$LogsTableTableReferences),
      Log,
      PrefetchHooks Function({bool groupId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GroupsTableTableTableManager get groupsTable =>
      $$GroupsTableTableTableManager(_db, _db.groupsTable);
  $$MembersTableTableTableManager get membersTable =>
      $$MembersTableTableTableManager(_db, _db.membersTable);
  $$SectionsTableTableTableManager get sectionsTable =>
      $$SectionsTableTableTableManager(_db, _db.sectionsTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
  $$ExpenseSplitsTableTableTableManager get expenseSplitsTable =>
      $$ExpenseSplitsTableTableTableManager(_db, _db.expenseSplitsTable);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db, _db.logsTable);
}
