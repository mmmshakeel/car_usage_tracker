// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contractSettingsHash() => r'c325ed0856d1a1fae3e6e720fffa29c242eb53bb';

/// Raw stream from the DB, converted to the domain model.
///
/// Copied from [contractSettings].
@ProviderFor(contractSettings)
final contractSettingsProvider =
    AutoDisposeStreamProvider<ContractSettingsModel?>.internal(
  contractSettings,
  name: r'contractSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$contractSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContractSettingsRef
    = AutoDisposeStreamProviderRef<ContractSettingsModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
