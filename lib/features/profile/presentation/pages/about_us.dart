import 'package:BitOwi/api/common_api.dart';
import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/features/profile/presentation/pages/contact_us.dart';
import 'package:BitOwi/features/profile/presentation/widgets/profile_widgets.dart';
import 'package:BitOwi/features/rich_text_config.dart';
import 'package:BitOwi/models/article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/article_type.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List<Article> articlee = [];
  List<ArticleType> articleType = [];

  String versionName = '';

  String newVersionName = '';
  bool isNewVersion = false;
  String downloadUrl = '';

  bool isLoading = true;

  @override
  void initState() {
    getArticleList();
    // getLocalVersion();
    super.initState();
  }

  Future<void> getArticleList() async {
    try {
      setState(() {
        isLoading = true;
      });
      final list = await CommonApi.getArticleList("2");
      if (!mounted) {
        isLoading = true;
        return;
      }
      setState(() {
        if (list.isNotEmpty) {
          articleType = list;
          isLoading = false;
        }
      });
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  void onLineTap(int index) {
    if (index < articleType.length) {
      final articleList = articleType[index].articleList;

      // Ensure the articleList is not empty and index is within bounds
      if (articleList.isNotEmpty) {
        // Access the first article or use a specific index as needed
        final article =
            articleList[0]; // Change this if you need to access another index within articleList

        debugPrint('Not Empty--> 131 $article');
        //!tempory alternative path
        if (article.contentType == '3') {
          Get.to(
            () => ContactUs(articleDetailList: article.articleDetailList ?? []),
          );
        } else {
          debugPrint('else--> 112 ${article.content}');
          Get.to(
            () => RichTextConfig.content(
              title: article.title,
              content: article.content ?? '',
            ),
          );
          // Get.to(
          //   () => ContactUs(articleDetailList: article.articleDetailList ?? []),
          // );
        }
      } else {
        debugPrint('Article list is empty for this type.');
      }
    } else {
      debugPrint('Invalid article type index.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final articleWidgets = List.generate(articleType.length, (index) {
      final name = articleType[index].name;
      final meta = articleMetaMap[name];

      debugPrint("🚀🚀 ${meta?['icon']}");

      return Column(
        children: [
          ProfileMenuItem(
            iconPath:
                meta?['icon'] ??
                'assets/icons/public/help_general.svg',
            title: name,
            subtitle: meta?['subtitle'] ?? name,
            onTap: () {
              onLineTap(index);
            },
          ),

          // Divider except last item
          if (index != articleType.length - 1)
            const Divider(height: 1, color: Color(0xFFF0F4FF)),
        ],
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),

      appBar: CommonAppBar(title: "About Us", onBack: () => Get.back()),

      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF1D5DE5),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/public/bitowi_app_icon.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ProfileGroupCard(children: [...articleWidgets]),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}

final Map<String, Map<String, String>> articleMetaMap = {
  'Risk Policy': {
    'subtitle': 'Understand how risks are managed',
    'icon': 'assets/icons/profile_page/about_us/ic_risk_policy.svg',
  },
  'User Agreement': {
    'subtitle': 'Review terms governing platform usage',
    'icon': 'assets/icons/profile_page/about_us/ic_user_agreement.svg',
  },
  'Privacy Policy': {
    'subtitle': 'Learn how your data is protected',
    'icon': 'assets/icons/profile_page/about_us/ic_privacy_policy.svg',
  },
  'Contact us': {
    'subtitle': 'Get help or reach support',
    'icon': 'assets/icons/profile_page/about_us/ic_contact_us.svg',
  },
  'Terms of use': {
    'subtitle': 'Rules and conditions for usage',
    'icon': 'assets/icons/profile_page/about_us/ic_terms_of_use.svg',
  },
};
