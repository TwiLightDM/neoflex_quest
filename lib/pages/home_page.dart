import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'achievements_page.dart';
import 'daily_tasks_page.dart';
import 'video_page.dart';
import 'shop_page.dart';
import 'programming_tasks_page.dart';
import 'notifications_page.dart';
import 'company_info_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Главный экран")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.question_answer, color: Colors.orange),
            title: Text("Квизы"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizPage())),
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.orange),
            title: Text("Ачивки"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AchievementsPage())),
          ),
          ListTile(
            leading: Icon(Icons.check_circle, color: Colors.orange),
            title: Text("Дейлики"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DailyTasksPage())),
          ),
          ListTile(
            leading: Icon(Icons.video_collection, color: Colors.orange),
            title: Text("Ролики"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPage())),
          ),
          ListTile(
            leading: Icon(Icons.shop, color: Colors.orange),
            title: Text("Магазин"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopPage())),
          ),
          ListTile(
            leading: Icon(Icons.code, color: Colors.orange),
            title: Text("Программистские задачи"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProgrammingTasksPage())),
          ),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.orange),
            title: Text("Уведомления"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsPage())),
          ),
          ListTile(
            leading: Icon(Icons.info, color: Colors.orange),
            title: Text("Информация о компании"),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CompanyInfoPage())),
          ),
        ],
      ),
    );
  }
}
