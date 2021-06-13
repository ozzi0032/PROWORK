import 'dart:io';

import 'package:PROWORK/indexProvider.dart';
import 'package:PROWORK/menu.dart';
import 'package:PROWORK/screens/buyer/index.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'serproprofile.dart';

class MainTabControlDelegate {
  int index;
  Function(String nameTab) changeTab;
  Function(int index) tabAnimateTo;

  static MainTabControlDelegate _instance;
  static MainTabControlDelegate getInstance() {
    return _instance ??= MainTabControlDelegate._();
  }

  MainTabControlDelegate._();
}

class MainTabs extends StatefulWidget {
  final bool isBuyer;
  MainTabs({this.isBuyer = true});
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _tabView = [];
  TabController tabController;

  @override
  void afterFirstLayout(BuildContext context) {
    loadTabBar(context);
  }

  void loadTabBar(context) {
    List<Widget> _buyerTabs = [
      BuyerHomeFragment(),
      Center(
        child: Text("Tasks Buyer"),
      ),
      Center(child: Profile())
    ];

    List<Widget> _providerTabs = [
      Center(
        child: Text("Provider Home"),
      ),
      /*Center(
        child: Text("Provider Tasks"),
      ),*/
      ProviderHomeFragment(),
      Center(child: Profile())
    ];

    if (widget.isBuyer) {
      _buyerTabs.forEach((element) {
        _tabView.add(element);
      });
    } else {
      _providerTabs.forEach((element) {
        _tabView.add(element);
      });
    }

    setState(() {
      tabController = TabController(length: _tabView.length, vsync: this);
    });

    if (MainTabControlDelegate.getInstance().index != null) {
      tabController.animateTo(MainTabControlDelegate.getInstance().index);
    } else {
      MainTabControlDelegate.getInstance().index = 0;
    }
  }

  @override
  void initState() {
    MainTabControlDelegate.getInstance().tabAnimateTo = (int index) {
      tabController?.animateTo(index);
    };
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        elevation: 10,
        child: MenuBar(),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (tabController.index != 0) {
            tabController.animateTo(0);
            return false;
          } else {
            return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure'),
                    content: Text('Really want to leave the app?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => SystemNavigator.pop(),
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                ) ??
                false;
          }
        },
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: _tabView,
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          width: screenSize.width,
          child: FittedBox(
            child: Container(
              width: screenSize.width /
                  (2 / (screenSize.height / screenSize.width)),
              child: TabBar(
                controller: tabController,
                tabs: renderTabbar(),
                isScrollable: false,
                labelColor: Theme.of(context).primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.all(4.0),
                indicatorColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> renderTabbar() {
    List<Widget> list = [];
    for (var i = 0; i < _tabView.length; i++) {
      list.add(Tab(
        icon: Icon(Icons.home),
        //text: 'Text',
      ));
    }
    return list;
  }
}
