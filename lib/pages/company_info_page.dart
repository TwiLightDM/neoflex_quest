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
            _sectionText(
              'Neoflex — ведущая российская ИТ‑компания, основанная в 2005 году, с широкой географией присутствия: филиалы компании работают в различных регионах страны — от крупных мегаполисов до перспективных региональных центров, включая Саратов. '
              'Компания объединяет крупную команду высококвалифицированных специалистов и сотрудничает с большинством ведущих банков страны, '
              'а также с другими успешными организациями более чем из 10 стран Европы, Азии и Африки.',
            ),

            const SizedBox(height: 20),
            Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'lib/assets/images/info/neoflex_training_dark.jpg'
                  : 'lib/assets/images/info/neoflex_training.jpg',
            ),

            _sectionTitle('Миссия и ценности'),
            _sectionText(
              'Мы стремимся ускорить цифровую трансформацию бизнеса клиентов за счёт инновационных ИТ‑решений, '
              'основанных на искусственном интеллекте и современных архитектурах. Основные ценности: '
              'профессионализм, клиентоориентированность и постоянное совершенствование.',
            ),

            _sectionTitle('Направления деятельности'),
            _sectionText('• Разработка корпоративных и банковских платформ'),
            _sectionText('• Внедрение решений на базе LLM и Generative AI'),
            _sectionText('• Data & Analytics: хранилища данных, Big Data, BI'),
            _sectionText('• DevOps и облачные инфраструктуры (Kubernetes, Openshift)'),
            _sectionText('• Кибербезопасность и соответствие требованиям ЦБ'),

            const SizedBox(height: 20),
            Image.asset('lib/assets/images/info/neoflex_office.jpg'),

            _sectionTitle('Учебный центр Neoflex'),
            _sectionText(
              'Neoflex Academy — внутренний учебный центр, где проходят обучение как начинающие стажёры, '
              'так и опытные инженеры. Программы включают курсы по современным языкам программирования, '
              'архитектуре микросервисов, DevOps‑практикам и управлению данными.',
            ),

            _sectionTitle('Партнёрства и достижения'),
            _sectionText(
              '· Партнёр Cisco, Microsoft, Red Hat и Oracle;\n'
              '· Ежегодно реализует более 50 проектов цифровой трансформации;\n'
              '· Награждена отраслевыми премиями за инновации в финансах и страховании.',
            ),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _launchURL,
                icon: const Icon(Icons.open_in_new),
                label: const Text('Официальный сайт Neoflex'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
