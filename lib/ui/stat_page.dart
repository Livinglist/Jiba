import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jiba/bloc/journal_bloc.dart';
import 'package:jiba/ui/components/activity_panel.dart';
import 'package:jiba/ui/components/journal_overview_card.dart';
import 'package:jiba/ui/settings_page.dart';
import 'package:jiba/ui/year_page.dart';
import 'components/section_header.dart';
import 'bookmarks_page.dart';

///This is the page that displays bookmarked journals and today in history.
class StatPage extends StatefulWidget {
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  @override
  Widget build(BuildContext context) {
    Color fontColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black;
    Color foregroundColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black;
    Color backgroundColor = MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black : Colors.white;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: StreamBuilder(
          stream: journalBloc.allJournals,
          builder: (_, AsyncSnapshot<List<Journal>> snapshot) {
            if (snapshot.hasData) {
              DateTime now = DateTime.now();

              var todayInHistory = snapshot.data.reversed.where((e) {
                var created = e.createdDate;
                return created.day == now.day && created.isTheSameDay(now) == false;
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 48,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.collections_bookmark,
                        color: foregroundColor,
                      ),
                      title: Text(
                        '書籤',
                        style: TextStyle(fontWeight: FontWeight.bold, color: foregroundColor),
                      ),
                      trailing: Text(
                        snapshot.data.where((element) => element.isBookmarked).length.toString() + ' 篇',
                        style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => BookmarksPage())),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.list,
                        color: foregroundColor,
                      ),
                      title: Text(
                        '歷年',
                        style: TextStyle(fontWeight: FontWeight.bold, color: foregroundColor),
                      ),
                      trailing: Text(
                        snapshot.data.length.toString() + ' 篇',
                        style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => YearPage(journals: snapshot.data))),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: foregroundColor,
                      ),
                      title: Text(
                        '設置',
                        style: TextStyle(fontWeight: FontWeight.bold, color: foregroundColor),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SettingsPage())),
                    ),
                    ActivityPanel(journals: snapshot.data),
                    SectionHeader(
                      headerText: "过往今日",
                    ),
                    if (todayInHistory.isEmpty)
                      Container(
                        height: 220,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            '空',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ...buildChildren(todayInHistory)
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ));
  }

  List<Widget> buildChildren(List<Journal> journals) {
    return journals.map((e) => JournalOverviewCard(journal: e, lengthRestricted: true)).toList();
  }
}
