import 'package:BitOwi/api/c2c_api.dart';
import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/core/widgets/confirm_dialog.dart';
import 'package:BitOwi/core/widgets/custom_snackbar.dart';
import 'package:BitOwi/core/widgets/soft_circular_loader.dart';
import 'package:BitOwi/models/ads_my_page_res.dart';
import 'package:BitOwi/models/ads_page_res.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  int selectedTab = 0; // 0: Draft, 1: Posted, 2: Archived

  late EasyRefreshController _controller;

  List<AdsMyPageRes> list = [];
  int pageNum = 1;
  bool isEnd = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    try {
      await getList(true);
      if (!mounted) {
        return;
      }
    } catch (e) {
      print("getMyAdsPageList onRefresh error: $e");
    }

    _controller.finishRefresh();
    _controller.resetFooter();
  }

  Future<void> onLoad() async {
    await getList();
    if (!mounted) {
      return;
    }
  }

  /// Get list from API based on selected tab
  Future<void> getList([bool isRefresh = false]) async {
    if (isLoading) return;
    try {
      setState(() {
        isLoading = true;
        if (isRefresh) {
          pageNum = 1;
        }
      });
      // Map tab index to status: 0=Draft, 1=Posted, 2=Archived
      final res = await C2CApi.getMyAdsPageList({
        "pageNum": pageNum,
        "pageSize": 10,
        "statusList": selectedTab == 0
            ? ['0']
            : selectedTab == 1
            ? ['1']
            : ['2'],
      });
      setState(() {
        isEnd = res.isEnd;
        if (isRefresh) {
          list = res.list;
        } else {
          list.addAll(res.list);
        }
        pageNum++;
      });
    } catch (e) {
      print("getMyAdsPageList getList error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool get isEmpty {
    return isEnd && list.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: CommonAppBar(title: "My Ads", onBack: () => Get.back()),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                _buildTab("Draft", 0),
                const SizedBox(width: 12),
                _buildTab("Posted", 1),
                const SizedBox(width: 12),
                _buildTab("Archived", 2),
              ],
            ),
          ),
          // List Content with Pull-to-Refresh
          Expanded(
            child: EasyRefresh(
              controller: _controller,
              onRefresh: onRefresh,
              refreshOnStart: true,
              onLoad: onLoad,
              child: isLoading
                  ? SoftCircularLoader()
                  : isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No ads found",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildAdCard(ad: list[index]);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (selectedTab != index) {
            setState(() {
              selectedTab = index;
              list.clear();
              pageNum = 1;
              isEnd = false;
            });
            onRefresh(); // Fetch new data for selected tab
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2F6CFF)
                : const Color(0xFFF6F7FB),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF8F9BB3),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdCard({required AdsMyPageRes ad}) {
    // Calculate completion rate from userStatistics
    final stats = ad.userStatistics;
    final completionRate = stats.orderCount > 0
        ? ((stats.orderFinishCount / stats.orderCount) * 100).toStringAsFixed(1)
        : "0.0";

    // Format currency symbol based on tradeCurrency
    final currencySymbol = ad.tradeCurrency == "NGN" ? "₦" : "\$";

    // Payment type display
    final payTypeDisplay = ad.payType == "0"
        ? (ad.bankName ?? "Bank Transfer")
        : "Other Payment";

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* User Info Row
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 20,
                backgroundImage: ad.photo.isNotEmpty
                    ? NetworkImage(ad.photo)
                    : null,
                backgroundColor: const Color(0xFF2F6CFF),
                child: ad.photo.isEmpty
                    ? Text(
                        ad.nickname.isNotEmpty
                            ? ad.nickname[0].toUpperCase()
                            : "?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              // Name and Badge
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        ad.nickname,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Show Certified badge if user has good stats
                    if (stats.orderFinishCount > 50 &&
                        completionRate != "0.0" &&
                        double.parse(completionRate) >= 95) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.verified,
                              size: 12,
                              color: Color(0xFF2F6CFF),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Certified",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF2F6CFF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          //* Stats Row
          Row(
            children: [
              const Icon(Icons.thumb_up, size: 14, color: Color(0xFFFF9500)),
              const SizedBox(width: 4),
              Text(
                "$completionRate%",
                style: const TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
              ),
              const SizedBox(width: 12),
              const Text(
                "Trust",
                style: TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
              ),
              const SizedBox(width: 4),
              Text(
                stats.confidenceCount.toString(),
                style: const TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
              ),
              const SizedBox(width: 12),
              const Text(
                "Trade",
                style: TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
              ),
              const SizedBox(width: 4),
              Text(
                "${stats.totalTradeCount} / $completionRate%",
                style: const TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          //* Price
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$currencySymbol ${ad.truePrice} ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: "Per USDT",
                  style: TextStyle(fontSize: 13, color: Color(0xFF8F9BB3)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          //* Total and Limit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${ad.leftCount} ${ad.tradeCoin}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Limit",
                    style: TextStyle(fontSize: 12, color: Color(0xFF8F9BB3)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$currencySymbol${ad.minTrade}-$currencySymbol${ad.maxTrade}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          //* Payment Type
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              payTypeDisplay,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFFF9500),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFECEFF5)),
          const SizedBox(height: 4),

          //* Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedTab == 0) ...[
                // Draft: Edit and Post buttons
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to edit ad page
                    print("Edit ad: ${ad.id}");
                  },
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text("Edit"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2F6CFF),
                    side: const BorderSide(color: Color(0xFFE4E9F2)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    onPostTap(ad);
                  },
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text("Post"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6CFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ] else if (selectedTab == 1) ...[
                // Posted: Edit and Off buttons
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to edit ad page
                    print("Edit ad: ${ad.id}");
                  },
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text("Edit"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2F6CFF),
                    side: const BorderSide(color: Color(0xFFE4E9F2)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    offDownTap(ad);
                  },
                  icon: const Icon(Icons.power_settings_new, size: 16),
                  label: const Text("Off"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6CFF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
              // Archived tab (selectedTab == 2): No buttons shown
            ],
          ),
        ],
      ),
    );
  }

  //   onDownTap(BuildContext context) {
  //     // todo: only for web this feature
  //   // if (!PlatformUtils().isMobile) {
  //   //   DownloadModal.showModal(context);
  //   //   return;
  //   // }
  //   ConfirmModal.showModal(
  //     context: context,
  //     title: '确认下架广告?'.tr,
  //     onConfirm: () async {
  //       try {
  //         ToastUtil.showLoading();
  //         await C2CApi.upDownAds(info.id, "0");
  //         ToastUtil.dismiss();
  //         ToastUtil.showToast('下架成功'.tr);
  //         if (afterDown != null) {
  //           afterDown!();
  //         }
  //       } catch (e) {
  //         ToastUtil.dismiss();
  //       }
  //     },
  //   );
  // }

  // Post ad (Draft → Posted)
  void onPostTap(AdsMyPageRes ad) {
    //todo:
    // if (!PlatformUtils().isMobile) {
    //   DownloadModal.showModal(context);
    //   return;
    // }
    print("Post ad: ${ad.id}");

    showCommonConfirmDialog(
      context,
      title: "Confirm to post ad?",
      message: "Are you sure you want to post this ad?",
      primaryText: "Post",
      secondaryText: "Cancel",
      onPrimary: () async {
        if (isLoading) return;

        setState(() {
          isLoading = true;
        });

        try {
          await C2CApi.upDownAds(ad.id, "1"); // 1 = on shelf

          setState(() {
            list.removeWhere((e) => e.id == ad.id);
          });

          CustomSnackbar.showSuccess(
            title: "Success",
            message: "Ad posted successfully",
          );
        } catch (e) {
          debugPrint("Post ad error: $e");

          CustomSnackbar.showError(
            title: "Error",
            message: "Something went wrong",
          );
        } finally {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      onSecondary: () {
        debugPrint("User cancelled post ad");
      },
    );
  }

  // Archive ad (Posted → Archived)
  void offDownTap(AdsMyPageRes ad) {
    //todo:
    // if (!PlatformUtils().isMobile) {
    //   DownloadModal.showModal(context);
    //   return;
    // }
    print("Turn off ad: ${ad.id}");

    showCommonConfirmDialog(
      context,
      title: "Confirm to off ads?",
      message: "Are you sure you want to turn off this ad?",
      primaryText: "Confirm",
      secondaryText: "Cancel",
      onPrimary: () async {
        if (isLoading) return;
        setState(() {
          isLoading = true;
        });

        try {
          await C2CApi.upDownAds(ad.id, "0");
          setState(() {
            list.removeWhere((e) => e.id == ad.id);
          });
          CustomSnackbar.showSuccess(
            title: "Success",
            message: "Ad turned off successfully",
          );
        } catch (e) {
          debugPrint("Off ad error: $e");
          CustomSnackbar.showError(
            title: "Error",
            message: "Something went wrong",
          );
        } finally {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      onSecondary: () {
        debugPrint("User cancelled off ad");
      },
    );
  }

  // Edit ad
  void onEditTap() {
    // Get.toNamed(Routes.publishAd, parameters: {'id': info.id});
  }
}
