import 'package:flutter/material.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/filter_toggles_widget.dart';
import 'package:ticketron/widgets/home/searchbar_widget.dart';
import 'package:ticketron/widgets/home/suggestions_foryou_widget.dart';
import 'package:ticketron/widgets/home/upcoming_events_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut,);
  }
  
  void _showPopupMenu(BuildContext context, Offset tapPosition) {
    _controller.forward();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx + 100,
        tapPosition.dy + 100,
        0,
        0,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'settings',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
              ),
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'remove',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remove'),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _controller.reverse();
        if (value == 'logout') {
          _authService.signOut(context);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find events near you',
                style: TextStyle(
                  color: Color.fromARGB(90, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'California, USA',
                    style: Constants.heading3,
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Color.fromARGB(57, 0, 0, 0)),
                        onPressed: () {
                          // Logic for notification button
                        },
                      ),
                      Positioned(
                        right: 15,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(169, 247, 59, 1),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Color.fromARGB(57, 0, 0, 0)),
                    onPressed: () {
                      final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;
                      final Offset tapPosition = overlay.localToGlobal(Offset.zero);
                      _showPopupMenu(context, tapPosition);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchBox(),
                const SizedBox(height: Constants.paddingMedium),
                const FilterToggles(),
                const SizedBox(height: Constants.paddingMedium),
                UpcomingEvents(),
                const SizedBox(height: Constants.paddingLarge),
                SuggestionsForYou(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
