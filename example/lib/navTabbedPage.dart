import 'package:flutter/cupertino.dart'
    show CupertinoIcons, CupertinoNavigationBar;
import 'package:flutter/material.dart' show Icons, Colors;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class NavTabbedPage extends StatefulWidget {
  @override
  _NavTabbedPageState createState() => _NavTabbedPageState();
}

class _NavTabbedPageState extends State<NavTabbedPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      iosContentBottomPadding: true,
      // Required for Android but not for Tabbed ios if iosNavigationTabBarBuilder is defined
      appBar: PlatformAppBar(
        title: Text('Platform Widgets $_selectedTabIndex'),
      ),
      bottomNavBar: PlatformNavBar(
        // Required for Android tabbing
        currentIndex: _selectedTabIndex,
        itemChanged: (index) => setState(() => _selectedTabIndex = index),
        //-----------------------------
        items: [
          BottomNavigationBarItem(
            title: Text('Flag'),
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.flag),
              android: (_) => Icon(Icons.flag),
            ),
          ),
          BottomNavigationBarItem(
            title: Text('Book'),
            icon: PlatformWidget(
              ios: (_) => Icon(CupertinoIcons.book),
              android: (_) => Icon(Icons.book),
            ),
          ),
        ],
      ),
      ios: (_) => new CupertinoPageScaffoldData(
            //Optionally for setting the header. If not used will use parent appBar
            iosNavigationTabBarBuilder: (BuildContext context, int idx) =>
                CupertinoNavigationBar(
                  middle: Text('Platform Widgetz $idx'),
                ),
            // For ios tabbed page this is used
            iosTabBodyBuilder: (BuildContext context, int idx) => Column(
                  children: <Widget>[
                    Text('Pagez $idx - Item 1'),
                    PlatformButton(
                      child: Text('Push Page'),
                      onPressed: () {
                        Navigator.of(context).push(platformPageRoute(
                            builder: (BuildContext context) =>
                                SubPage(_selectedTabIndex + 10)));
                      },
                    ),
                    PlatformButton(
                      child: Text('Pop Page'),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    )
                  ],
                ),
          ),
      // If ios tabs is used, then this is ignored
      // otherwise it will be used.
      bodyBuilder: (BuildContext context) => Column(
            children: <Widget>[
              Text('Page $_selectedTabIndex - Item 1'),
              PlatformButton(
                child: Text('Push Page'),
                onPressed: () {
                  Navigator.of(context).push(platformPageRoute(
                      builder: (BuildContext context) =>
                          SubPage(_selectedTabIndex + 10)));
                },
              ),
              PlatformButton(
                child: Text('Pop Page'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
    );
  }
}

class SubPage extends StatefulWidget {
  final int index;

  SubPage(this.index);

  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: Text('Child Page'),
      ),
      body: Column(children: <Widget>[
        Text('Sub Page ${widget.index} - $_counter'),
        PlatformButton(
          child: Text('Increment Counter'),
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
        ),
        PlatformButton(
          child: Text('Push Page'),
          onPressed: () {
            Navigator.of(context).push(platformPageRoute(
                builder: (BuildContext context) => SubPage(widget.index + 10)));
          },
        )
      ]),
    );
  }
}
