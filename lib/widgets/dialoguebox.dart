import 'package:flutter/material.dart';


class LoadingDialog {
  static bool _isDialogOpen = false; // Static variable to track dialog state

  static Future<void> show(
    BuildContext context, {
    required String message,
  }) async {
    if (_isDialogOpen) return; // Prevent showing another dialog if one is already open

    _isDialogOpen = true; // Set dialog state to open

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      _isDialogOpen = false; // Set dialog state to closed after it is dismissed
    });
  }

  static void hide(BuildContext context) {
    if (!_isDialogOpen) return; // Do nothing if the dialog is not open

    Navigator.of(context).pop();
    _isDialogOpen = false; // Ensure dialog state is set to closed
  }

  static bool isDialogOpen() {
    return _isDialogOpen;
  }
}