// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_code_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginCodeViewModel)
final loginCodeViewModelProvider = LoginCodeViewModelFamily._();

final class LoginCodeViewModelProvider
    extends $NotifierProvider<LoginCodeViewModel, OtpCodeState> {
  LoginCodeViewModelProvider._({
    required LoginCodeViewModelFamily super.from,
    required OtpCodeArgs super.argument,
  }) : super(
         retry: null,
         name: r'loginCodeViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$loginCodeViewModelHash();

  @override
  String toString() {
    return r'loginCodeViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LoginCodeViewModel create() => LoginCodeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OtpCodeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OtpCodeState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LoginCodeViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$loginCodeViewModelHash() =>
    r'be98b994f31440683d983c21ee801fe9a8484922';

final class LoginCodeViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          LoginCodeViewModel,
          OtpCodeState,
          OtpCodeState,
          OtpCodeState,
          OtpCodeArgs
        > {
  LoginCodeViewModelFamily._()
    : super(
        retry: null,
        name: r'loginCodeViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LoginCodeViewModelProvider call(OtpCodeArgs args) =>
      LoginCodeViewModelProvider._(argument: args, from: this);

  @override
  String toString() => r'loginCodeViewModelProvider';
}

abstract class _$LoginCodeViewModel extends $Notifier<OtpCodeState> {
  late final _$args = ref.$arg as OtpCodeArgs;
  OtpCodeArgs get args => _$args;

  OtpCodeState build(OtpCodeArgs args);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<OtpCodeState, OtpCodeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OtpCodeState, OtpCodeState>,
              OtpCodeState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
