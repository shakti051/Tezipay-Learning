import 'package:api_archi_bloc/config/components/loading_widget.dart';
import 'package:flutter/material.dart';

import '../color/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({
    super.key,
    required this.title,
    this.loading = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Center(
        child:
            loading
                ? const LoadingWidget()
                : Text(
                  title,
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
      ),
    );
  }
}
