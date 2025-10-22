import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreenController extends GetxController {

  final GlobalKey addNoteKey = GlobalKey();
  final GlobalKey searchKey = GlobalKey();
  final GlobalKey themeKey = GlobalKey();
  final GlobalKey openFileKey = GlobalKey();
  final GlobalKey tagsKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    _registerShowcase();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAndShowTutorial());
  }

  void _registerShowcase() {
    ShowcaseView.register(
      onFinish: _onShowcaseFinish,
      onStart: (index, key) {
        debugPrint('Showcase started for item $index with key $key');
      },
      onComplete: (index, key) {
        debugPrint('Showcase completed for item $index with key $key');
        _onShowcaseFinish();
      },
      onDismiss: (key) {
        debugPrint('Showcase dismissed at key $key');
        _onShowcaseFinish();
      },
      blurValue: 1.0,
      autoPlay: true,
      autoPlayDelay: const Duration(seconds: 3),
      enableAutoScroll: true,
      scrollDuration: Duration(milliseconds: 500),

      // --- Global Skip Button ---
      globalFloatingActionWidget: (showcaseContext) => FloatingActionWidget(
        left: 16,
        bottom: 16,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => ShowcaseView.get().dismiss(),
            child: Text('Skip Tutorial'),
          ),
        ),
      ),
      hideFloatingActionWidgetForShowcase: [addNoteKey],
    );
  }

  void _checkAndShowTutorial() {
    final settingsBox = Hive.box('settings');
    bool hasCompletedOnboarding = settingsBox.get('hasCompletedOnboarding', defaultValue: false);

    if (!hasCompletedOnboarding) {
      Future.delayed(const Duration(milliseconds: 200), () {
        ShowcaseView.get().startShowCase(
          [
            addNoteKey,
            searchKey,
            tagsKey,
            openFileKey,
            themeKey,
          ],
        );
      });
    }
  }

  void _onShowcaseFinish() {
    final settingsBox = Hive.box('settings');
    if (!settingsBox.get('hasCompletedOnboarding', defaultValue: false)) {
        settingsBox.put('hasCompletedOnboarding', true);
        debugPrint("Onboarding marked as complete.");
    }
  }

  @override
  void onClose() {
    ShowcaseView.get().unregister();
    super.onClose();
  }
}