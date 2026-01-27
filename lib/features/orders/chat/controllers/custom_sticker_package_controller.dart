import 'package:get/get.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class CustomStickerPackageController extends GetxController {
  /// Sticker package list
  final RxList<CustomStickerPackage> _customStickerPackageList =
      <CustomStickerPackage>[].obs;

  /// Selected index
  final RxInt _selectedIdx = 0.obs;

  /// Emoji index list
  final RxList<int> _emojiIndexList = <int>[].obs;

  /// Same as your original `late` field
  late StickerListUtil stickerListUtil;

  // =====================
  // Getters (same API)
  // =====================

  List<CustomStickerPackage> get customStickerPackageList =>
      List.unmodifiable(_customStickerPackageList);

  int get selectedIdx => _selectedIdx.value;

  List<int> get emojiIndexList => _emojiIndexList;

  // =====================
  // Setters (same logic)
  // =====================

  set selectedIdx(int idx) {
    _selectedIdx.value = idx;
  }

  set customStickerPackageList(List<CustomStickerPackage> list) {
    _customStickerPackageList.assignAll(list);

    _emojiIndexList.clear();
    list.asMap().forEach((customStickerPackageIndex, package) {
      if (!package.isCustomSticker) {
        _emojiIndexList.add(customStickerPackageIndex);
      }
    });
  }

  // =====================
  // Methods (unchanged)
  // =====================

  void addStickerPackage(CustomStickerPackage sticker) {
    if (!sticker.isCustomSticker) {
      _emojiIndexList.add(_customStickerPackageList.length);
    }
    _customStickerPackageList.add(sticker);
  }

  void removeEmojiPackage(CustomStickerPackage sticker) {
    // intentionally empty (same as original)
  }

  void clearStickerPackageList() {
    _customStickerPackageList.clear();
    _selectedIdx.value = 0;
    _emojiIndexList.clear();
  }
}
