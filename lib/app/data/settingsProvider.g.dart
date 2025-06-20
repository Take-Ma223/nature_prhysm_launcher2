// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsProvider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchConfigurationHash() =>
    r'616c9845a04ee39ee6816bc475b6e41f9a24f109';

/// See also [fetchConfiguration].
@ProviderFor(fetchConfiguration)
final fetchConfigurationProvider = AutoDisposeFutureProvider<Settings>.internal(
  fetchConfiguration,
  name: r'fetchConfigurationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchConfigurationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchConfigurationRef = AutoDisposeFutureProviderRef<Settings>;
String _$settingsNotifierHash() => r'b697b68071664b6cf5344fe9cc77e1444ac64314';

/// See also [SettingsNotifier].
@ProviderFor(SettingsNotifier)
final settingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SettingsNotifier, Settings>.internal(
      SettingsNotifier.new,
      name: r'settingsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$settingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SettingsNotifier = AutoDisposeAsyncNotifier<Settings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
