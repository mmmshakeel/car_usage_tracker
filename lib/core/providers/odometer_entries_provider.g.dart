// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'odometer_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$odometerEntriesHash() => r'51d8632325b7985377efc337b8677c89fd812de7';

/// Raw stream of DB entries ordered by date ascending.
///
/// Copied from [odometerEntries].
@ProviderFor(odometerEntries)
final odometerEntriesProvider =
    AutoDisposeStreamProvider<List<OdometerEntry>>.internal(
  odometerEntries,
  name: r'odometerEntriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$odometerEntriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OdometerEntriesRef = AutoDisposeStreamProviderRef<List<OdometerEntry>>;
String _$kmDrivenPerEntryHash() => r'277805edcffc7a6e180784c47d81e1e6ba69914c';

/// Entries enriched with computed [kmDriven] per entry.
///
/// Copied from [kmDrivenPerEntry].
@ProviderFor(kmDrivenPerEntry)
final kmDrivenPerEntryProvider =
    AutoDisposeProvider<List<OdometerEntryModel>>.internal(
  kmDrivenPerEntry,
  name: r'kmDrivenPerEntryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kmDrivenPerEntryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KmDrivenPerEntryRef = AutoDisposeProviderRef<List<OdometerEntryModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
