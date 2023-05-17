import 'package:flutter/material.dart';
import 'package:taxi_app/app/shared/design_system/design_system.dart';

import 'widgets/custom_drawer_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawerWidget(),
      body: Stack(
        children: [
          Container(
            color: Colors.black12,
          ),
          SafeArea(
            child: GestureDetector(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                  height: 44,
                  width: 44,
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10.0,
                          color: Color(0xffd9dede),
                          offset: Offset(0, 5))
                    ],
                    color: AppColors.cardBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.menu)),
            ),
          )
        ],
      ),
    );
  }
}
