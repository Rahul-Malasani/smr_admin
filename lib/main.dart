import 'package:flutter/material.dart';

// Screens
import 'package:smr_admin/screens/auth/login_screen.dart';
import 'package:smr_admin/screens/dashboard_screen.dart';
import 'package:smr_admin/screens/companies/company_list_screen.dart';
import 'package:smr_admin/screens/branches/branch_list_screen.dart';
import 'package:smr_admin/screens/staff/staff_list_screen.dart';
import 'package:smr_admin/screens/products/product_list_screen.dart';
import 'package:smr_admin/screens/cadres/cadre_list_screen.dart';
import 'package:smr_admin/screens/user/user_list_screen.dart';
import 'package:smr_admin/screens/branch-product/branch-product_list_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ Hides the DEBUG banner
      title: 'SMR Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // App always starts at Login screen
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/companies': (context) => const CompanyListScreen(),
        '/branches': (context) => const BranchListScreen(),
        '/staff': (context) => const StaffListScreen(),
        '/products': (context) => const ProductListScreen(),
        '/cadres': (context) => const CadreListScreen(),
        '/users': (context) => const UserListScreen(), 
        '/branch-products': (context) => const BranchProductListScreen(),
      },
    );
  }
}
