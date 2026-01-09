import 'package:BitOwi/core/widgets/common_appbar.dart';
import 'package:BitOwi/models/article_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:wallet/models/article_detail.dart';
// import 'package:wallet/providers/theme_provider.dart';
// import 'package:wallet/utils/index.dart';
// import 'package:wallet/widgets/app_bar_pro.dart';
// import 'package:wallet/widgets/common_image.dart';
// import 'package:wallet/widgets/container_body.dart';

class ContactUs extends StatefulWidget {
  final List<ArticleDetail> articleDetailList;
  const ContactUs({super.key, required this.articleDetailList});

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // onLineTap(int index) {
  //   final url = widget.articleDetailList[index].content;
  //   Uri launchUri = Uri.parse(url);
  //   launchUrl(launchUri, mode: LaunchMode.externalApplication);
  // }


  @override
  Widget build(BuildContext context) {
    // CommonUtils.setTitle(context, '联系我们'.tr);

    return Scaffold(
      // appBar: AppBarPro(
      //   title: Text('联系我们'.tr),
      //   centerTitle: false,
      //   titleSpacing: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      appBar: CommonAppBar(title: "Contact Us", onBack: () => Get.back()),

      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       // customTheme.scaffoldBgStart,
        //       // customTheme.scaffoldBgEnd,
        //     ],
        //     stops: const [0.24, 1],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: List.generate(
              widget.articleDetailList.length,
              (index) => _line(
                title: widget.articleDetailList[index].title,
                iconUrl: widget.articleDetailList[index].pic,
                onTap: () {
                  // onLineTap(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _line({
    required String title,
    required String iconUrl,
    required VoidCallback onTap,
  }) {
    // final customTheme = Provider.of<ThemeProvider>(context).customTheme;
    // final customThemeImage =
    //     Provider.of<ThemeProvider>(context).customThemeImage;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 21),
        child: Row(
          children: [
            // CommonImage(
            //   iconUrl,
            //   width: 22,
            //   height: 22,
            //   fit: BoxFit.fill,
            // ),
            SizedBox(width: 10.5),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            // Image.asset(
            //   customThemeImage.meRightImg,
            //   width: 22,
            //   height: 22,
            //   fit: BoxFit.fill,
            // ),
          ],
        ),
      ),
    );
  }
}
