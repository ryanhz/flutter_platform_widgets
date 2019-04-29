import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

// Taken from
//https://docs.flutter.io/flutter/cupertino/CupertinoTabScaffold-class.html

class IosTabbedPage extends StatefulWidget {
  @override
  _IosTabbedPageState createState() => _IosTabbedPageState();
}

class _IosTabbedPageState extends State<IosTabbedPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Flag'),
            icon: Icon(CupertinoIcons.flag),
          ),
          BottomNavigationBarItem(
            title: Text('Book'),
            icon: Icon(CupertinoIcons.book),
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text('Page 1 of tab $index'),
              ),
              child: Center(
                child: CupertinoButton(
                  child: const Text('Next page'),
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute<void>(
                        builder: (BuildContext context) {
                          return CupertinoPageScaffold(
                            navigationBar: CupertinoNavigationBar(
                              middle: Text('Page 2 of tab $index'),
                            ),
                            child: Center(
                              child: CupertinoButton(
                                child: const Text('Back'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
