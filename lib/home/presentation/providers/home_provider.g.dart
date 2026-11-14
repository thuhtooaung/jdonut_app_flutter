// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeCacheBox)
final homeCacheBoxProvider = HomeCacheBoxProvider._();

final class HomeCacheBoxProvider
    extends
        $FunctionalProvider<
          Box<Map<dynamic, dynamic>>,
          Box<Map<dynamic, dynamic>>,
          Box<Map<dynamic, dynamic>>
        >
    with $Provider<Box<Map<dynamic, dynamic>>> {
  HomeCacheBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeCacheBoxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeCacheBoxHash();

  @$internal
  @override
  $ProviderElement<Box<Map<dynamic, dynamic>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Box<Map<dynamic, dynamic>> create(Ref ref) {
    return homeCacheBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<Map<dynamic, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<Map<dynamic, dynamic>>>(value),
    );
  }
}

String _$homeCacheBoxHash() => r'8945914be57c13b712d766e160ac84d620ffa56c';

@ProviderFor(homeRemoteDataSource)
final homeRemoteDataSourceProvider = HomeRemoteDataSourceProvider._();

final class HomeRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          HomeRemoteDataSource,
          HomeRemoteDataSource,
          HomeRemoteDataSource
        >
    with $Provider<HomeRemoteDataSource> {
  HomeRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<HomeRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeRemoteDataSource create(Ref ref) {
    return homeRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRemoteDataSource>(value),
    );
  }
}

String _$homeRemoteDataSourceHash() =>
    r'f03a63788ffe2318b185ecf3a5fd27d8dd0581e3';

@ProviderFor(homeLocalDataSource)
final homeLocalDataSourceProvider = HomeLocalDataSourceProvider._();

final class HomeLocalDataSourceProvider
    extends
        $FunctionalProvider<
          HomeLocalDataSource,
          HomeLocalDataSource,
          HomeLocalDataSource
        >
    with $Provider<HomeLocalDataSource> {
  HomeLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<HomeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeLocalDataSource create(Ref ref) {
    return homeLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeLocalDataSource>(value),
    );
  }
}

String _$homeLocalDataSourceHash() =>
    r'224565924dd26991354c65be3deaee6df9825855';

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'76c66a6130b689db673356ccabebad399905b26d';

@ProviderFor(getHomeDataUseCase)
final getHomeDataUseCaseProvider = GetHomeDataUseCaseProvider._();

final class GetHomeDataUseCaseProvider
    extends
        $FunctionalProvider<
          GetHomeDataUseCase,
          GetHomeDataUseCase,
          GetHomeDataUseCase
        >
    with $Provider<GetHomeDataUseCase> {
  GetHomeDataUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getHomeDataUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getHomeDataUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetHomeDataUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetHomeDataUseCase create(Ref ref) {
    return getHomeDataUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetHomeDataUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetHomeDataUseCase>(value),
    );
  }
}

String _$getHomeDataUseCaseHash() =>
    r'8da7b178e37120bf5158db964a01f954397c63b1';

@ProviderFor(homeData)
final homeDataProvider = HomeDataProvider._();

final class HomeDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeDataEntity>,
          HomeDataEntity,
          FutureOr<HomeDataEntity>
        >
    with $FutureModifier<HomeDataEntity>, $FutureProvider<HomeDataEntity> {
  HomeDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeDataHash();

  @$internal
  @override
  $FutureProviderElement<HomeDataEntity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeDataEntity> create(Ref ref) {
    return homeData(ref);
  }
}

String _$homeDataHash() => r'2bee06595a2b4dbd4e07728d09544facdbaf947a';
