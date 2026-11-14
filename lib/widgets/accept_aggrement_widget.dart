import 'package:flutter/material.dart';

class AcceptAgreementWidget extends StatelessWidget {
  const AcceptAgreementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text:
            'By continuing, you acknowledge that you have read and agree to our ',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontSize: 12, color: Colors.grey),
        children: [
          TextSpan(
            text: 'Terms of Use',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12, color: Colors.pink),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12, color: Colors.pink),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
