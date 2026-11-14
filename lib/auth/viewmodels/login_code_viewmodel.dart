import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_code_viewmodel.g.dart';

@riverpod
class LoginCodeViewModel extends _$LoginCodeViewModel {
  Timer? _timer;

  //late AuthRepository _authRepository;

  @override
  OtpCodeState build(OtpCodeArgs args) {
    //_authRepository = ref.read(authRepositoryProvider);
    ref.onDispose(() {
      _timer?.cancel();
    });
    _startTimer(args.expireIn);
    return OtpCodeState(
      verifyStatus: OtpVerifyStatus(),
      resendStatus: OtpResendStatus(
        remainingSeconds: args.expireIn,
        canResend: false,
      ),
    );
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendStatus.remainingSeconds > 1) {
        state = state.copyWith(
          resendStatus: OtpResendStatus(
            remainingSeconds: state.resendStatus.remainingSeconds - 1,
            canResend: false,
          ),
        );
      } else {
        _timer?.cancel();
        state = state.copyWith(
          resendStatus: OtpResendStatus(remainingSeconds: 0, canResend: true),
        );
      }
    });
  }

  Future<void> resendCode() async {
    if (!state.resendStatus.canResend) return;
    state = state.copyWith(
      resendStatus: OtpResendStatus(
        remainingSeconds: args.expireIn,
        canResend: false,
      ),
    );
    try {
      _startTimer(100);
      // final result = await _authRepository.getOtp({
      //   "channel": args.channel,
      //   "identifier": args.identifier,
      // });
      // if (result.success) {
      //   _startTimer(args.expireIn);
      // } else {
      //   throw ApiException(message: result.message);
      // }
    } catch (e) {
      state = state.copyWith(
        resendStatus: OtpResendStatus(remainingSeconds: 0, canResend: true),
      );
    }
  }
}

class OtpCodeArgs {
  final String phone;
  final int expireIn;

  OtpCodeArgs({required this.phone, required this.expireIn});
}

class OtpCodeState {
  final OtpVerifyStatus verifyStatus;
  final OtpResendStatus resendStatus;

  OtpCodeState({required this.verifyStatus, required this.resendStatus});

  OtpCodeState copyWith({
    OtpVerifyStatus? verifyStatus,
    OtpResendStatus? resendStatus,
  }) {
    return OtpCodeState(
      verifyStatus: verifyStatus ?? this.verifyStatus,
      resendStatus: resendStatus ?? this.resendStatus,
    );
  }
}

class OtpVerifyStatus {
  final bool isLoading;
  final bool? data;
  final String? error;

  OtpVerifyStatus({this.isLoading = false, this.data, this.error});
}

class OtpResendStatus {
  final int remainingSeconds;
  final bool canResend;

  OtpResendStatus({required this.remainingSeconds, required this.canResend});
}
