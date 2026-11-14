// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'ae4eb59a334282115803fc0dd0a965f2273c670f';

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

String _$homeRepositoryHash() => r'fc8a39d67a23dbbff7c7f9a4001309acfc480c7c';

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
