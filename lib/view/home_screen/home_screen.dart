import 'package:education_app/view/home_screen/widgets/category_card.dart';
import 'package:education_app/view/home_screen/widgets/course_card.dart';
import 'package:education_app/view/home_screen/widgets/promo_banner.dart';
import 'package:education_app/view/home_screen/widgets/search_bar.dart';
import 'package:education_app/view/home_screen/widgets/section%7C_title.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
   
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, size: 30),
                  Row(
                    children: [
                      Icon(Icons.notifications_none, size: 28),
                      SizedBox(width: 15),
                      Icon(Icons.shopping_cart_outlined, size: 28),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 15),

              const SearchBarWidget(),

              const SizedBox(height: 25),

              Row(
                children: [
                  const SectionTitle(title: "Subject Tutoring"),
                  const Spacer(),
                  Text(
                    "All Subjects",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryCard(
                      title: "Mathematics",
                      icon: Icons.calculate,
                      gradient: [Color(0xFFFF6E6E), Color(0xFFFF8A8A)],
                    ),
                    SizedBox(width: 12),
                    CategoryCard(
                      title: "Architecture",
                      icon: Icons.apartment,
                      gradient: [Color(0xFF5CB3FF), Color(0xFF6ED3FF)],
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const PromoBanner(),

              const SizedBox(height: 25),

              const SectionTitle(title: "All Courses"),
              const SizedBox(height: 12),

              const CourseCard(
                image: 'assets/course1.jpg',
                title: "JavaScript for Modern Web Development",
                author: "Robert Fox • 3 hr",
                price: "\$10.99",
              ),
              CourseCard(
                image: 'assets/course2.jpg',
                title: "Python Programming for Data Analysis",
                author: "Eleanor Pena • 3 hr",
                price: "\$10.99",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
