// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $OdometerEntriesTable extends OdometerEntries
    with TableInfo<$OdometerEntriesTable, OdometerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OdometerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _odometerKmMeta =
      const VerificationMeta('odometerKm');
  @override
  late final GeneratedColumn<int> odometerKm = GeneratedColumn<int>(
      'odometer_km', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, odometerKm, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'odometer_entries';
  @override
  VerificationContext validateIntegrity(Insertable<OdometerEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
          _odometerKmMeta,
          odometerKm.isAcceptableOrUnknown(
              data['odometer_km']!, _odometerKmMeta));
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OdometerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OdometerEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      odometerKm: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}odometer_km'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $OdometerEntriesTable createAlias(String alias) {
    return $OdometerEntriesTable(attachedDatabase, alias);
  }
}

class OdometerEntry extends DataClass implements Insertable<OdometerEntry> {
  final int id;
  final DateTime date;
  final int odometerKm;
  final String? note;
  const OdometerEntry(
      {required this.id,
      required this.date,
      required this.odometerKm,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['odometer_km'] = Variable<int>(odometerKm);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  OdometerEntriesCompanion toCompanion(bool nullToAbsent) {
    return OdometerEntriesCompanion(
      id: Value(id),
      date: Value(date),
      odometerKm: Value(odometerKm),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory OdometerEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OdometerEntry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometerKm: serializer.fromJson<int>(json['odometerKm']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'odometerKm': serializer.toJson<int>(odometerKm),
      'note': serializer.toJson<String?>(note),
    };
  }

  OdometerEntry copyWith(
          {int? id,
          DateTime? date,
          int? odometerKm,
          Value<String?> note = const Value.absent()}) =>
      OdometerEntry(
        id: id ?? this.id,
        date: date ?? this.date,
        odometerKm: odometerKm ?? this.odometerKm,
        note: note.present ? note.value : this.note,
      );
  OdometerEntry copyWithCompanion(OdometerEntriesCompanion data) {
    return OdometerEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      odometerKm:
          data.odometerKm.present ? data.odometerKm.value : this.odometerKm,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OdometerEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, odometerKm, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OdometerEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.odometerKm == this.odometerKm &&
          other.note == this.note);
}

class OdometerEntriesCompanion extends UpdateCompanion<OdometerEntry> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> odometerKm;
  final Value<String?> note;
  const OdometerEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.note = const Value.absent(),
  });
  OdometerEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int odometerKm,
    this.note = const Value.absent(),
  })  : date = Value(date),
        odometerKm = Value(odometerKm);
  static Insertable<OdometerEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? odometerKm,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (note != null) 'note': note,
    });
  }

  OdometerEntriesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? odometerKm,
      Value<String?>? note}) {
    return OdometerEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      odometerKm: odometerKm ?? this.odometerKm,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<int>(odometerKm.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OdometerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $ContractSettingsTableTable extends ContractSettingsTable
    with TableInfo<$ContractSettingsTableTable, ContractSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _leaseStartDateMeta =
      const VerificationMeta('leaseStartDate');
  @override
  late final GeneratedColumn<DateTime> leaseStartDate =
      GeneratedColumn<DateTime>('lease_start_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _leaseEndDateMeta =
      const VerificationMeta('leaseEndDate');
  @override
  late final GeneratedColumn<DateTime> leaseEndDate = GeneratedColumn<DateTime>(
      'lease_end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _contractDurationDaysMeta =
      const VerificationMeta('contractDurationDays');
  @override
  late final GeneratedColumn<int> contractDurationDays = GeneratedColumn<int>(
      'contract_duration_days', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _startingOdometerKmMeta =
      const VerificationMeta('startingOdometerKm');
  @override
  late final GeneratedColumn<int> startingOdometerKm = GeneratedColumn<int>(
      'starting_odometer_km', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxKmPerContractMeta =
      const VerificationMeta('maxKmPerContract');
  @override
  late final GeneratedColumn<int> maxKmPerContract = GeneratedColumn<int>(
      'max_km_per_contract', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        leaseStartDate,
        leaseEndDate,
        contractDurationDays,
        startingOdometerKm,
        maxKmPerContract
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contract_settings';
  @override
  VerificationContext validateIntegrity(
      Insertable<ContractSettingsData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lease_start_date')) {
      context.handle(
          _leaseStartDateMeta,
          leaseStartDate.isAcceptableOrUnknown(
              data['lease_start_date']!, _leaseStartDateMeta));
    } else if (isInserting) {
      context.missing(_leaseStartDateMeta);
    }
    if (data.containsKey('lease_end_date')) {
      context.handle(
          _leaseEndDateMeta,
          leaseEndDate.isAcceptableOrUnknown(
              data['lease_end_date']!, _leaseEndDateMeta));
    } else if (isInserting) {
      context.missing(_leaseEndDateMeta);
    }
    if (data.containsKey('contract_duration_days')) {
      context.handle(
          _contractDurationDaysMeta,
          contractDurationDays.isAcceptableOrUnknown(
              data['contract_duration_days']!, _contractDurationDaysMeta));
    } else if (isInserting) {
      context.missing(_contractDurationDaysMeta);
    }
    if (data.containsKey('starting_odometer_km')) {
      context.handle(
          _startingOdometerKmMeta,
          startingOdometerKm.isAcceptableOrUnknown(
              data['starting_odometer_km']!, _startingOdometerKmMeta));
    } else if (isInserting) {
      context.missing(_startingOdometerKmMeta);
    }
    if (data.containsKey('max_km_per_contract')) {
      context.handle(
          _maxKmPerContractMeta,
          maxKmPerContract.isAcceptableOrUnknown(
              data['max_km_per_contract']!, _maxKmPerContractMeta));
    } else if (isInserting) {
      context.missing(_maxKmPerContractMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContractSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContractSettingsData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      leaseStartDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}lease_start_date'])!,
      leaseEndDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}lease_end_date'])!,
      contractDurationDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}contract_duration_days'])!,
      startingOdometerKm: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}starting_odometer_km'])!,
      maxKmPerContract: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}max_km_per_contract'])!,
    );
  }

  @override
  $ContractSettingsTableTable createAlias(String alias) {
    return $ContractSettingsTableTable(attachedDatabase, alias);
  }
}

class ContractSettingsData extends DataClass
    implements Insertable<ContractSettingsData> {
  final int id;
  final DateTime leaseStartDate;
  final DateTime leaseEndDate;
  final int contractDurationDays;
  final int startingOdometerKm;
  final int maxKmPerContract;
  const ContractSettingsData(
      {required this.id,
      required this.leaseStartDate,
      required this.leaseEndDate,
      required this.contractDurationDays,
      required this.startingOdometerKm,
      required this.maxKmPerContract});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lease_start_date'] = Variable<DateTime>(leaseStartDate);
    map['lease_end_date'] = Variable<DateTime>(leaseEndDate);
    map['contract_duration_days'] = Variable<int>(contractDurationDays);
    map['starting_odometer_km'] = Variable<int>(startingOdometerKm);
    map['max_km_per_contract'] = Variable<int>(maxKmPerContract);
    return map;
  }

  ContractSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return ContractSettingsTableCompanion(
      id: Value(id),
      leaseStartDate: Value(leaseStartDate),
      leaseEndDate: Value(leaseEndDate),
      contractDurationDays: Value(contractDurationDays),
      startingOdometerKm: Value(startingOdometerKm),
      maxKmPerContract: Value(maxKmPerContract),
    );
  }

  factory ContractSettingsData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContractSettingsData(
      id: serializer.fromJson<int>(json['id']),
      leaseStartDate: serializer.fromJson<DateTime>(json['leaseStartDate']),
      leaseEndDate: serializer.fromJson<DateTime>(json['leaseEndDate']),
      contractDurationDays:
          serializer.fromJson<int>(json['contractDurationDays']),
      startingOdometerKm: serializer.fromJson<int>(json['startingOdometerKm']),
      maxKmPerContract: serializer.fromJson<int>(json['maxKmPerContract']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'leaseStartDate': serializer.toJson<DateTime>(leaseStartDate),
      'leaseEndDate': serializer.toJson<DateTime>(leaseEndDate),
      'contractDurationDays': serializer.toJson<int>(contractDurationDays),
      'startingOdometerKm': serializer.toJson<int>(startingOdometerKm),
      'maxKmPerContract': serializer.toJson<int>(maxKmPerContract),
    };
  }

  ContractSettingsData copyWith(
          {int? id,
          DateTime? leaseStartDate,
          DateTime? leaseEndDate,
          int? contractDurationDays,
          int? startingOdometerKm,
          int? maxKmPerContract}) =>
      ContractSettingsData(
        id: id ?? this.id,
        leaseStartDate: leaseStartDate ?? this.leaseStartDate,
        leaseEndDate: leaseEndDate ?? this.leaseEndDate,
        contractDurationDays: contractDurationDays ?? this.contractDurationDays,
        startingOdometerKm: startingOdometerKm ?? this.startingOdometerKm,
        maxKmPerContract: maxKmPerContract ?? this.maxKmPerContract,
      );
  ContractSettingsData copyWithCompanion(ContractSettingsTableCompanion data) {
    return ContractSettingsData(
      id: data.id.present ? data.id.value : this.id,
      leaseStartDate: data.leaseStartDate.present
          ? data.leaseStartDate.value
          : this.leaseStartDate,
      leaseEndDate: data.leaseEndDate.present
          ? data.leaseEndDate.value
          : this.leaseEndDate,
      contractDurationDays: data.contractDurationDays.present
          ? data.contractDurationDays.value
          : this.contractDurationDays,
      startingOdometerKm: data.startingOdometerKm.present
          ? data.startingOdometerKm.value
          : this.startingOdometerKm,
      maxKmPerContract: data.maxKmPerContract.present
          ? data.maxKmPerContract.value
          : this.maxKmPerContract,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContractSettingsData(')
          ..write('id: $id, ')
          ..write('leaseStartDate: $leaseStartDate, ')
          ..write('leaseEndDate: $leaseEndDate, ')
          ..write('contractDurationDays: $contractDurationDays, ')
          ..write('startingOdometerKm: $startingOdometerKm, ')
          ..write('maxKmPerContract: $maxKmPerContract')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, leaseStartDate, leaseEndDate,
      contractDurationDays, startingOdometerKm, maxKmPerContract);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContractSettingsData &&
          other.id == this.id &&
          other.leaseStartDate == this.leaseStartDate &&
          other.leaseEndDate == this.leaseEndDate &&
          other.contractDurationDays == this.contractDurationDays &&
          other.startingOdometerKm == this.startingOdometerKm &&
          other.maxKmPerContract == this.maxKmPerContract);
}

class ContractSettingsTableCompanion
    extends UpdateCompanion<ContractSettingsData> {
  final Value<int> id;
  final Value<DateTime> leaseStartDate;
  final Value<DateTime> leaseEndDate;
  final Value<int> contractDurationDays;
  final Value<int> startingOdometerKm;
  final Value<int> maxKmPerContract;
  const ContractSettingsTableCompanion({
    this.id = const Value.absent(),
    this.leaseStartDate = const Value.absent(),
    this.leaseEndDate = const Value.absent(),
    this.contractDurationDays = const Value.absent(),
    this.startingOdometerKm = const Value.absent(),
    this.maxKmPerContract = const Value.absent(),
  });
  ContractSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime leaseStartDate,
    required DateTime leaseEndDate,
    required int contractDurationDays,
    required int startingOdometerKm,
    required int maxKmPerContract,
  })  : leaseStartDate = Value(leaseStartDate),
        leaseEndDate = Value(leaseEndDate),
        contractDurationDays = Value(contractDurationDays),
        startingOdometerKm = Value(startingOdometerKm),
        maxKmPerContract = Value(maxKmPerContract);
  static Insertable<ContractSettingsData> custom({
    Expression<int>? id,
    Expression<DateTime>? leaseStartDate,
    Expression<DateTime>? leaseEndDate,
    Expression<int>? contractDurationDays,
    Expression<int>? startingOdometerKm,
    Expression<int>? maxKmPerContract,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (leaseStartDate != null) 'lease_start_date': leaseStartDate,
      if (leaseEndDate != null) 'lease_end_date': leaseEndDate,
      if (contractDurationDays != null)
        'contract_duration_days': contractDurationDays,
      if (startingOdometerKm != null)
        'starting_odometer_km': startingOdometerKm,
      if (maxKmPerContract != null) 'max_km_per_contract': maxKmPerContract,
    });
  }

  ContractSettingsTableCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? leaseStartDate,
      Value<DateTime>? leaseEndDate,
      Value<int>? contractDurationDays,
      Value<int>? startingOdometerKm,
      Value<int>? maxKmPerContract}) {
    return ContractSettingsTableCompanion(
      id: id ?? this.id,
      leaseStartDate: leaseStartDate ?? this.leaseStartDate,
      leaseEndDate: leaseEndDate ?? this.leaseEndDate,
      contractDurationDays: contractDurationDays ?? this.contractDurationDays,
      startingOdometerKm: startingOdometerKm ?? this.startingOdometerKm,
      maxKmPerContract: maxKmPerContract ?? this.maxKmPerContract,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (leaseStartDate.present) {
      map['lease_start_date'] = Variable<DateTime>(leaseStartDate.value);
    }
    if (leaseEndDate.present) {
      map['lease_end_date'] = Variable<DateTime>(leaseEndDate.value);
    }
    if (contractDurationDays.present) {
      map['contract_duration_days'] = Variable<int>(contractDurationDays.value);
    }
    if (startingOdometerKm.present) {
      map['starting_odometer_km'] = Variable<int>(startingOdometerKm.value);
    }
    if (maxKmPerContract.present) {
      map['max_km_per_contract'] = Variable<int>(maxKmPerContract.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('leaseStartDate: $leaseStartDate, ')
          ..write('leaseEndDate: $leaseEndDate, ')
          ..write('contractDurationDays: $contractDurationDays, ')
          ..write('startingOdometerKm: $startingOdometerKm, ')
          ..write('maxKmPerContract: $maxKmPerContract')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $OdometerEntriesTable odometerEntries =
      $OdometerEntriesTable(this);
  late final $ContractSettingsTableTable contractSettingsTable =
      $ContractSettingsTableTable(this);
  late final OdometerDao odometerDao = OdometerDao(this as AppDatabase);
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [odometerEntries, contractSettingsTable];
}

typedef $$OdometerEntriesTableCreateCompanionBuilder = OdometerEntriesCompanion
    Function({
  Value<int> id,
  required DateTime date,
  required int odometerKm,
  Value<String?> note,
});
typedef $$OdometerEntriesTableUpdateCompanionBuilder = OdometerEntriesCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<int> odometerKm,
  Value<String?> note,
});

class $$OdometerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$OdometerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$OdometerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OdometerEntriesTable> {
  $$OdometerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get odometerKm => $composableBuilder(
      column: $table.odometerKm, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$OdometerEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OdometerEntriesTable,
    OdometerEntry,
    $$OdometerEntriesTableFilterComposer,
    $$OdometerEntriesTableOrderingComposer,
    $$OdometerEntriesTableAnnotationComposer,
    $$OdometerEntriesTableCreateCompanionBuilder,
    $$OdometerEntriesTableUpdateCompanionBuilder,
    (
      OdometerEntry,
      BaseReferences<_$AppDatabase, $OdometerEntriesTable, OdometerEntry>
    ),
    OdometerEntry,
    PrefetchHooks Function()> {
  $$OdometerEntriesTableTableManager(
      _$AppDatabase db, $OdometerEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OdometerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OdometerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OdometerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> odometerKm = const Value.absent(),
            Value<String?> note = const Value.absent(),
          }) =>
              OdometerEntriesCompanion(
            id: id,
            date: date,
            odometerKm: odometerKm,
            note: note,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime date,
            required int odometerKm,
            Value<String?> note = const Value.absent(),
          }) =>
              OdometerEntriesCompanion.insert(
            id: id,
            date: date,
            odometerKm: odometerKm,
            note: note,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OdometerEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OdometerEntriesTable,
    OdometerEntry,
    $$OdometerEntriesTableFilterComposer,
    $$OdometerEntriesTableOrderingComposer,
    $$OdometerEntriesTableAnnotationComposer,
    $$OdometerEntriesTableCreateCompanionBuilder,
    $$OdometerEntriesTableUpdateCompanionBuilder,
    (
      OdometerEntry,
      BaseReferences<_$AppDatabase, $OdometerEntriesTable, OdometerEntry>
    ),
    OdometerEntry,
    PrefetchHooks Function()>;
typedef $$ContractSettingsTableTableCreateCompanionBuilder
    = ContractSettingsTableCompanion Function({
  Value<int> id,
  required DateTime leaseStartDate,
  required DateTime leaseEndDate,
  required int contractDurationDays,
  required int startingOdometerKm,
  required int maxKmPerContract,
});
typedef $$ContractSettingsTableTableUpdateCompanionBuilder
    = ContractSettingsTableCompanion Function({
  Value<int> id,
  Value<DateTime> leaseStartDate,
  Value<DateTime> leaseEndDate,
  Value<int> contractDurationDays,
  Value<int> startingOdometerKm,
  Value<int> maxKmPerContract,
});

class $$ContractSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ContractSettingsTableTable> {
  $$ContractSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get leaseStartDate => $composableBuilder(
      column: $table.leaseStartDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get leaseEndDate => $composableBuilder(
      column: $table.leaseEndDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get contractDurationDays => $composableBuilder(
      column: $table.contractDurationDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get startingOdometerKm => $composableBuilder(
      column: $table.startingOdometerKm,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxKmPerContract => $composableBuilder(
      column: $table.maxKmPerContract,
      builder: (column) => ColumnFilters(column));
}

class $$ContractSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractSettingsTableTable> {
  $$ContractSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get leaseStartDate => $composableBuilder(
      column: $table.leaseStartDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get leaseEndDate => $composableBuilder(
      column: $table.leaseEndDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get contractDurationDays => $composableBuilder(
      column: $table.contractDurationDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startingOdometerKm => $composableBuilder(
      column: $table.startingOdometerKm,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxKmPerContract => $composableBuilder(
      column: $table.maxKmPerContract,
      builder: (column) => ColumnOrderings(column));
}

class $$ContractSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractSettingsTableTable> {
  $$ContractSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get leaseStartDate => $composableBuilder(
      column: $table.leaseStartDate, builder: (column) => column);

  GeneratedColumn<DateTime> get leaseEndDate => $composableBuilder(
      column: $table.leaseEndDate, builder: (column) => column);

  GeneratedColumn<int> get contractDurationDays => $composableBuilder(
      column: $table.contractDurationDays, builder: (column) => column);

  GeneratedColumn<int> get startingOdometerKm => $composableBuilder(
      column: $table.startingOdometerKm, builder: (column) => column);

  GeneratedColumn<int> get maxKmPerContract => $composableBuilder(
      column: $table.maxKmPerContract, builder: (column) => column);
}

class $$ContractSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContractSettingsTableTable,
    ContractSettingsData,
    $$ContractSettingsTableTableFilterComposer,
    $$ContractSettingsTableTableOrderingComposer,
    $$ContractSettingsTableTableAnnotationComposer,
    $$ContractSettingsTableTableCreateCompanionBuilder,
    $$ContractSettingsTableTableUpdateCompanionBuilder,
    (
      ContractSettingsData,
      BaseReferences<_$AppDatabase, $ContractSettingsTableTable,
          ContractSettingsData>
    ),
    ContractSettingsData,
    PrefetchHooks Function()> {
  $$ContractSettingsTableTableTableManager(
      _$AppDatabase db, $ContractSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractSettingsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractSettingsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractSettingsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> leaseStartDate = const Value.absent(),
            Value<DateTime> leaseEndDate = const Value.absent(),
            Value<int> contractDurationDays = const Value.absent(),
            Value<int> startingOdometerKm = const Value.absent(),
            Value<int> maxKmPerContract = const Value.absent(),
          }) =>
              ContractSettingsTableCompanion(
            id: id,
            leaseStartDate: leaseStartDate,
            leaseEndDate: leaseEndDate,
            contractDurationDays: contractDurationDays,
            startingOdometerKm: startingOdometerKm,
            maxKmPerContract: maxKmPerContract,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime leaseStartDate,
            required DateTime leaseEndDate,
            required int contractDurationDays,
            required int startingOdometerKm,
            required int maxKmPerContract,
          }) =>
              ContractSettingsTableCompanion.insert(
            id: id,
            leaseStartDate: leaseStartDate,
            leaseEndDate: leaseEndDate,
            contractDurationDays: contractDurationDays,
            startingOdometerKm: startingOdometerKm,
            maxKmPerContract: maxKmPerContract,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ContractSettingsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ContractSettingsTableTable,
        ContractSettingsData,
        $$ContractSettingsTableTableFilterComposer,
        $$ContractSettingsTableTableOrderingComposer,
        $$ContractSettingsTableTableAnnotationComposer,
        $$ContractSettingsTableTableCreateCompanionBuilder,
        $$ContractSettingsTableTableUpdateCompanionBuilder,
        (
          ContractSettingsData,
          BaseReferences<_$AppDatabase, $ContractSettingsTableTable,
              ContractSettingsData>
        ),
        ContractSettingsData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$OdometerEntriesTableTableManager get odometerEntries =>
      $$OdometerEntriesTableTableManager(_db, _db.odometerEntries);
  $$ContractSettingsTableTableTableManager get contractSettingsTable =>
      $$ContractSettingsTableTableTableManager(_db, _db.contractSettingsTable);
}
