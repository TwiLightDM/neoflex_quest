import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyInfoPage extends StatelessWidget {
  const CompanyInfoPage({super.key});

  void _launchURL() async {
    final Uri url = Uri.parse('https://www.neoflex.ru/about/company');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Не удалось открыть $url');
    }
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О компании Neoflex')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Описание компании с проверенными датами
            _sectionText(
              'Neoflex — ведущая российская ИТ‑компания, основанная в 2005 году и базирующаяся в Москве. '
              'Компания насчитывает от 1 001 до 5 000 сотрудников и более 50 % клиентов из ТОП‑100 банков России, '
              'а также организаций более чем из 10 стран Европы, Азии и Африки.',
            ),

            // Изображение офиса/логотипа
            const SizedBox(height: 20),
            Image.asset('lib/assets/images/info/neoflex_training.jpg'),

            // Миссия и ценности
            _sectionTitle('Миссия и ценности'),
            _sectionText(
              'Мы стремимся ускорить цифровую трансформацию бизнеса клиентов за счёт инновационных ИТ‑решений, '
              'основанных на искусственном интеллекте и современных архитектурах. Основные ценности: '
              'профессионализм, клиентоориентированность и постоянное совершенствование.',
            ),

            // Направления деятельности
            _sectionTitle('Направления деятельности'),
            _sectionText('• Разработка корпоративных и банковских платформ'),
            _sectionText('• Внедрение решений на базе LLM и Generative AI'),
            _sectionText('• Data & Analytics: хранилища данных, Big Data, BI'),
            _sectionText('• DevOps и облачные инфраструктуры (Kubernetes, Openshift)'),
            _sectionText('• Кибербезопасность и соответствие требованиям ЦБ'),

            // Изображение учебного центра
            const SizedBox(height: 20),
            Image.asset('lib/assets/images/info/neoflex_office.jpg'),

            // Учебный центр
            _sectionTitle('Учебный центр Neoflex'),
            _sectionText(
              'Neoflex Academy — внутренний учебный центр, где проходят обучение как начинающие стажёры, '
              'так и опытные инженеры. Программы включают курсы по современным языкам программирования, '
              'архитектуре микросервисов, DevOps‑практикам и управлению данными.',
            ),

            // Партнёрская сеть и достижения
            _sectionTitle('Партнёрства и достижения'),
            _sectionText(
              '· Партнёр Cisco, Microsoft, Red Hat и Oracle;\n'
              '· Ежегодно реализует более 50 проектов цифровой трансформации;\n'
              '· Награждена отраслевыми премиями за инновации в финансах и страховании.',
            ),

            // Кликабельная ссылка
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: _launchURL,
                child: const Text(
                  'Перейти на официальный сайт Neoflex',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
