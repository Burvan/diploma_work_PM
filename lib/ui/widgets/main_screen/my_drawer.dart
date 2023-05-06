import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black87,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //DrawerHeader(child: Image(image: AppImages.drawerNikeLogo)),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: Divider(color: Colors.grey),
            // ),
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 5),
              child: Text('Application settings', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
            ),
            ListTile(
              leading: const Icon(Icons.water_drop_outlined, color: Colors.white),
              title: const Text('Change theme', style: TextStyle(color: Colors.white, fontSize: 16),),
              onTap: ()=>Navigator.of(context).pushNamed('/change_theme_screen'),
            ),
          ],
        ),
      ),
    );
  }
}