import 'package:BitOwi/api/common_api.dart';
import 'package:BitOwi/models/article_type.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> with TickerProviderStateMixin {
  List<ArticleType> helpCententList = [];
  late EasyRefreshController _controller;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(controlFinishRefresh: true);
    onRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  Future<void> onRefresh() async {
    try {
      final list = await CommonApi.getArticleList("0");
      if (!mounted) return;

      setState(() {
        helpCententList = list;
        expandedSectionIndex = -1;
        expandedQuestionIndex.clear();
        isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } finally {
      _controller.finishRefresh();
    }
  }

  int expandedSectionIndex = -1;
  final Map<int, int> expandedQuestionIndex = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Help', style: TextStyle(color: Colors.black)),
      ),
      body: EasyRefresh(
        controller: _controller,
        onRefresh: onRefresh,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  ...List.generate(
                    helpCententList.length,
                    (index) => _buildSectionCard(
                      section: helpCententList[index],
                      sectionIndex: index,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B8CFF), Color(0xFF6A4CFF)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, Jonathan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Welcome to Help Center',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(Icons.help_outline, color: Colors.white, size: 32),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required ArticleType section,
    required int sectionIndex,
  }) {
    final isExpanded = expandedSectionIndex == sectionIndex;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              setState(() {
                expandedSectionIndex = isExpanded ? -1 : sectionIndex;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _sectionIcon(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isExpanded ? 0.5 : 0,
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: isExpanded
                ? _buildQuestions(section, sectionIndex)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestions(ArticleType section, int sectionIndex) {
    return Column(
      children: List.generate(section.articleList.length, (qIndex) {
        final isOpen = expandedQuestionIndex[sectionIndex] == qIndex;

        return Column(
          children: [
            const Divider(height: 1),
            ListTile(
              title: Text(
                section.articleList[qIndex].title,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: isOpen ? 0.5 : 0,
                child: const Icon(Icons.keyboard_arrow_down),
              ),
              onTap: () {
                setState(() {
                  expandedQuestionIndex[sectionIndex] = isOpen ? -1 : qIndex;
                });
              },
            ),
            // AnimatedCrossFade(
            //   duration: const Duration(milliseconds: 200),
            //   crossFadeState: isOpen
            //       ? CrossFadeState.showFirst
            //       : CrossFadeState.showSecond,
            //   firstChild: Padding(
            //     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            //     child: Html(data: section.articles[qIndex].content),
            //   ),
            //   secondChild: const SizedBox.shrink(),
            // ),
            Container(
              color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: isOpen
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child:
                            //   Html(
                            //     data: normalizeHtml(section.articles[qIndex].content),
                            //     shrinkWrap: true,
                            //     // style: {
                            //     //   "body": Style(
                            //     //     margin: Margins.zero,
                            //     //     padding: HtmlPaddings.zero,
                            //     //     fontSize: FontSize(14),
                            //     //     lineHeight: LineHeight.number(1.5),
                            //     //   ),
                            //     //   // ✅ TABLE FIXES
                            //     //   "table": Style(
                            //     //     width: Width(100, Unit.percent),
                            //     //     border: Border.all(color: Colors.grey.shade300),
                            //     //     margin: Margins.only(bottom: 12),
                            //     //   ),
                            //     //   "tr": Style(
                            //     //     border: Border(
                            //     //       bottom: BorderSide(color: Colors.grey.shade300),
                            //     //     ),
                            //     //   ),
                            //     //   "td": Style(
                            //     //     padding: HtmlPaddings.all(8),
                            //     //     fontSize: FontSize(14),
                            //     //   ),
                            //     //   "th": Style(
                            //     //     padding: HtmlPaddings.all(8),
                            //     //     fontWeight: FontWeight.w600,
                            //     //     backgroundColor: Colors.grey.shade100,
                            //     //   ),
                            //     // },
                            //     style: {
                            //       "body": Style(
                            //         margin: Margins.zero,
                            //         padding: HtmlPaddings.zero,
                            //         fontSize: FontSize(14),
                            //         lineHeight: LineHeight.number(1.5),
                            //       ),
                            //       // ✅ TABLE
                            //       "table": Style(
                            //         width: Width(100, Unit.percent),
                            //         margin: Margins.only(bottom: 12),
                            //       ),
                            //       // ✅ ROW
                            //       "tr": Style(
                            //         display: Display.block, // 🔥 IMPORTANT
                            //         width: Width(100, Unit.percent),
                            //       ),
                            //       // ✅ CELLS
                            //       "td": Style(
                            //         display: Display.block, // 🔥 IMPORTANT
                            //         width: Width(100, Unit.percent),
                            //         padding: HtmlPaddings.only(bottom: 8),
                            //         fontSize: FontSize(14),
                            //       ),
                            //       "th": Style(
                            //         display: Display.block, // 🔥 IMPORTANT
                            //         width: Width(100, Unit.percent),
                            //         padding: HtmlPaddings.only(bottom: 8),
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     },
                            //     extensions: const [
                            //       TableHtmlExtension(), // 🔥 REQUIRED
                            //     ],
                            //   ),
                            Html(
                              data: normalizeHtml(
                                section.articleList[qIndex].content!,
                              ),
                              shrinkWrap: true,
                              // style: {
                              //   "body": Style(
                              //     margin: Margins.zero,
                              //     padding: HtmlPaddings.zero,
                              //     fontSize: FontSize(14),
                              //     lineHeight: LineHeight.number(1.5),
                              //     // width: Width(100, Unit.percent),
                              //     width: Width.auto(),
                              //   ),

                              //   "p": Style(margin: Margins.only(bottom: 8)),
                              // },
                              style: {
                                // Base document style
                                "body": Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(14),
                                  lineHeight: LineHeight.number(1.5),
                                  width:
                                      Width.auto(), // ✅ take maximum available width
                                ),

                                // Required because flutter_html internally uses divs
                                "div": Style(
                                  display: Display.block,
                                  width:
                                      Width.auto(), // ✅ max width, no percent
                                  whiteSpace: WhiteSpace.normal,
                                ),

                                // Paragraphs (your flattened table rows)
                                "p": Style(
                                  display: Display.block,
                                  width: Width.auto(), // ✅ max width
                                  margin: Margins.only(bottom: 8),
                                  whiteSpace: WhiteSpace.normal,
                                ),

                                // Headings created from <th>
                                "strong": Style(fontWeight: FontWeight.w600),
                              },
                            ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _sectionIcon() {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF2FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.help_outline, color: Color(0xFF5B8CFF), size: 20),
    );
  }
}

// String normalizeHtml(String html) {
//   // Force tables to be visible on mobile by converting them to divs.
//   // This is a pragmatic solution when table rendering is not supported.

//   var out = html;

//   // Remove problematic fixed sizes
//   out = out
//       .replaceAll(RegExp(r'height:\s*\d+px;?'), '')
//       .replaceAll(RegExp(r'width:\s*\d+%;?'), 'width: 100%;');

//   // Convert table structure to simple block layout
//   out = out
//       .replaceAll(RegExp(r'<table[^>]*>'), '<div style="width:100%;">')
//       .replaceAll('</table>', '</div>')
//       .replaceAll(RegExp(r'<tbody[^>]*>'), '<div>')
//       .replaceAll('</tbody>', '</div>')
//       .replaceAll(RegExp(r'<tr[^>]*>'), '<div style="margin-bottom:12px;">')
//       .replaceAll('</tr>', '</div>')
//       .replaceAll(RegExp(r'<td[^>]*>'), '<div style="padding:6px 0;">')
//       .replaceAll('</td>', '</div>')
//       .replaceAll(
//         RegExp(r'<th[^>]*>'),
//         '<div style="padding:6px 0; font-weight:600;">',
//       )
//       .replaceAll('</th>', '</div>');

//   return out;
// }

String normalizeHtml(String html) {
  return html
      // remove problematic fixed sizes
      .replaceAll(RegExp(r'height:\s*\d+px;?'), '')
      .replaceAll(RegExp(r'width:\s*\d+%;?'), '')
      // flatten table structure into text blocks
      .replaceAll(RegExp(r'<table[^>]*>'), '')
      .replaceAll('</table>', '')
      .replaceAll(RegExp(r'<tbody[^>]*>'), '')
      .replaceAll('</tbody>', '')
      .replaceAll(RegExp(r'<tr[^>]*>'), '<p>')
      .replaceAll('</tr>', '</p>')
      .replaceAll(RegExp(r'<td[^>]*>'), '')
      .replaceAll('</td>', '')
      .replaceAll(RegExp(r'<th[^>]*>'), '<strong>')
      .replaceAll('</th>', '</strong>');
}
