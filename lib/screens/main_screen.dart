import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/dependency_injection.dart';
import 'package:todo_app/core/hive_helper.dart';
import 'package:todo_app/cubits/add_todo_cubit.dart';
import 'package:todo_app/cubits/completed_cubit.dart';
import 'package:todo_app/cubits/edit_todo_cubit.dart';
import 'package:todo_app/cubits/todos_cubit.dart';
import 'package:todo_app/cubits/uncompleted_cubit.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/screens/all_todo_screen.dart';
import 'package:todo_app/screens/completed_screen.dart';
import 'package:todo_app/screens/uncompleted_screen.dart';
import 'package:todo_app/utils/strings.dart';
import 'package:todo_app/utils/todo_dialogs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _tabController = PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    HiveHelper().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _tabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        hideNavigationBarWhenKeyboardShows: true,
        navBarStyle: NavBarStyle.style12,
        onItemSelected: (value) {
          // if (value == 0)
          //   locator<TodosCubit>().fetchTodos();
          // else if (value == 1)
          //   locator<TodosCubit>().fetchUncompletedTodos();
          // else
          //   locator<TodosCubit>().fetchCompletedTodos();
          // _handleSeletedTab(value); // this was used
        },
        screenTransitionAnimation: ScreenTransitionAnimation(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          animateTabTransition: true
        ),
        itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 300), curve: Curves.ease),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: locator<AddTodoCubit>()),
          BlocProvider.value(value: locator<EditTodoCubit>()),
          BlocProvider.value(value: locator<TodosCubit>())
        ],
        child: AllTodoScreen(),
      ),
      MultiBlocProvider(providers: [
        BlocProvider.value(value: locator<AddTodoCubit>()),
        BlocProvider.value(value: locator<EditTodoCubit>()),
        BlocProvider.value(value: locator<UncompletedCubit>())
      ], child: UncompletedScreen()),
      MultiBlocProvider(providers: [
        BlocProvider.value(value: locator<AddTodoCubit>()),
        BlocProvider.value(value: locator<EditTodoCubit>()),
        BlocProvider.value(value: locator<CompletedCubit>())
      ], child: CompletedScreen()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.list_bullet),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.check_mark),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  void _handleSeletedTab(int value) {
    var _title = TitleType.ALL_TODO;
    if (value == 1) _title = TitleType.UNCOMPLETED_TODO;
    if (value == 2) _title = TitleType.COMPLETED_TODO;
    Provider.of<MainProvider>(context, listen: false).getTitle(_title);
  }
}
