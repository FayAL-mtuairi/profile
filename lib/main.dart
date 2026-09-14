import 'package:flutter/material.dart';

void main() => runApp(const FayPortfolio());

class FayPortfolio extends StatelessWidget {
  const FayPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF3EEE6);
    const ink = Color(0xFF171717);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fay Al-Mutairi | Portfolio',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: ink),
        fontFamily: 'Arial',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final aboutKey = GlobalKey();
  final trainingKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  void go(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF3EEE6);
    const ink = Color(0xFF171717);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            backgroundColor: bg.withOpacity(.96),
            title: const Text(
              'FAY AL-MUTAIRI',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                letterSpacing: 1.6,
              ),
            ),
            actions: [
              _Nav(label: 'About', onTap: () => go(aboutKey)),
              _Nav(label: 'Training', onTap: () => go(trainingKey)),
              _Nav(label: 'Projects', onTap: () => go(projectsKey)),
              _Nav(label: 'Skills', onTap: () => go(skillsKey)),
              _Nav(label: 'Contact', onTap: () => go(contactKey)),
              const SizedBox(width: 18),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1180),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      _Hero(onProjects: () => go(projectsKey)),
                      const SizedBox(height: 110),
                      _Section(
                        key: aboutKey,
                        number: '01',
                        title: 'About',
                        child: const _About(),
                      ),
                      _Section(
                        key: trainingKey,
                        number: '02',
                        title: 'Training',
                        child: const _Training(),
                      ),
                      _Section(
                        key: projectsKey,
                        number: '03',
                        title: 'Projects',
                        child: const _Projects(),
                      ),
                      _Section(
                        key: skillsKey,
                        number: '04',
                        title: 'Skills',
                        child: const _Skills(),
                      ),
                      _Section(
                        key: contactKey,
                        number: '05',
                        title: 'Contact',
                        child: const _Contact(),
                      ),
                      const Divider(color: Color(0xFFB8AFA3)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Fay Al-Mutairi'),
                            Text('Information Technology • Saudi Arabia'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Nav extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _Nav({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF171717),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final VoidCallback onProjects;

  const _Hero({required this.onProjects});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 820;

        final text = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INFORMATION TECHNOLOGY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.3,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Fay\nAl-Mutairi',
              style: TextStyle(
                fontSize: small ? 58 : 86,
                height: .94,
                letterSpacing: -3,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF171717),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'IT graduate with hands-on experience in data analytics, Flutter development, databases, and AI projects. I enjoy turning ideas and data into practical digital products.',
              style: TextStyle(
                fontSize: 18,
                height: 1.65,
                color: Color(0xFF4D4842),
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton(
                  onPressed: onProjects,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF171717),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text('View my work'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF171717),
                    side: const BorderSide(color: Color(0xFF171717)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text('LinkedIn'),
                ),
              ],
            ),
          ],
        );

        final image = Container(
          height: small ? 360 : 500,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF171717)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/IMG_6645.PNG', fit: BoxFit.cover),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  color: const Color(0xFF171717).withOpacity(.88),
                  child: const Text(
                    'DATA • MOBILE • AI',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

        if (small) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [text, const SizedBox(height: 44), image],
          );
        }

        return Row(
          children: [
            Expanded(flex: 6, child: text),
            const SizedBox(width: 58),
            Expanded(flex: 4, child: image),
          ],
        );
      },
    );
  }
}

class _Section extends StatelessWidget {
  final String number;
  final String title;
  final Widget child;

  const _Section({
    super.key,
    required this.number,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(color: Color(0xFFB8AFA3)),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(width: 18),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          child,
        ],
      ),
    );
  }
}

class _About extends StatelessWidget {
  const _About();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 760;

        const lead = Text(
          'I graduated in Information Technology from Qassim University. My interests are centered around data, software development, and practical AI applications.',
          style: TextStyle(
            fontSize: 23,
            height: 1.5,
            fontWeight: FontWeight.w700,
          ),
        );

        const body = Text(
          'My portfolio brings together the areas I trained in and built projects around: dashboards and data analysis, Flutter applications, databases, web platforms, APIs, and AI-based graduation work. I prefer clean interfaces, useful outputs, and straightforward solutions.',
          style: TextStyle(
            fontSize: 16,
            height: 1.8,
            color: Color(0xFF4D4842),
          ),
        );

        if (small) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [lead, SizedBox(height: 26), body],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: lead),
            SizedBox(width: 70),
            Expanded(child: body),
          ],
        );
      },
    );
  }
}

class _Training extends StatelessWidget {
  const _Training();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TrainingItem(
          title: 'Data Analytics Training',
          description:
              'Worked with data preparation, analysis, dashboards, and reporting. This training strengthened my ability to turn raw datasets into clear visual insights.',
          tags: ['Power BI', 'Tableau', 'Excel', 'Python', 'SQL'],
        ),
        _TrainingItem(
          title: 'Application & Software Training',
          description:
              'Practiced software development through mobile and web projects, databases, Firebase, and structured development workflows.',
          tags: ['Flutter', 'Flutter Web', 'Firebase', 'Databases', 'Git'],
        ),
      ],
    );
  }
}

class _TrainingItem extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tags;

  const _TrainingItem({
    required this.title,
    required this.description,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFB8AFA3))),
      ),
      child: LayoutBuilder(
        builder: (context, c) {
          final small = c.maxWidth < 760;
          final left = Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          );
          final right = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Color(0xFF4D4842),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((e) => _Tag(e)).toList(),
              ),
            ],
          );

          if (small) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [left, const SizedBox(height: 16), right],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 4, child: left),
              Expanded(flex: 6, child: right),
            ],
          );
        },
      ),
    );
  }
}

class _Projects extends StatelessWidget {
  const _Projects();

  static const data = [
    _Project(
      title: 'MindConnect',
      type: 'Graduation Project • AI',
      description:
          'A multimodal emotion-recognition project using audio, facial, and video inputs. The project worked with datasets including RAVDESS and MELD and explored practical AI for emotion understanding.',
      tags: ['AI', 'Deep Learning', 'RAVDESS', 'MELD'],
    ),
    _Project(
      title: 'Graduation Projects Platform',
      type: 'Flutter Web',
      description:
          'A web platform built with Flutter Web where students could submit and showcase their graduation projects through a dedicated project-upload form.',
      tags: ['Flutter Web', 'Forms', 'UI/UX'],
    ),
    _Project(
      title: 'Weather Dashboard',
      type: 'Data Analytics',
      description:
          'A weather dashboard connected to an API. It retrieves live weather data and refreshes periodically so the displayed information stays current.',
      tags: ['API', 'Dashboard', 'Data'],
    ),
    _Project(
      title: 'Sales Dashboard',
      type: 'Power BI',
      description:
          'A simple sales dashboard created to demonstrate data-analysis and visualization skills, including KPI summaries and clear business-focused views.',
      tags: ['Power BI', 'KPIs', 'Sales'],
    ),
    _Project(
      title: 'COVID-19 Analysis',
      type: 'Tableau',
      description:
          'An interactive Tableau dashboard built from a large COVID-19 dataset to explore key trends, comparisons, and important metrics.',
      tags: ['Tableau', 'Large Dataset', 'Analytics'],
    ),
    _Project(
      title: 'Real Estate App',
      type: 'Flutter',
      description:
          'A simple real-estate mobile application developed with Flutter, including property browsing and filters to help users narrow listings.',
      tags: ['Flutter', 'Mobile', 'Filters'],
    ),
    _Project(
      title: 'SaudiSesh',
      type: 'Web Development',
      description:
          'A web project used to practice front-end structure, project organization, Git workflows, and deployment-oriented development.',
      tags: ['Web', 'Git', 'Development'],
    ),
    _Project(
      title: 'Library Database Schema',
      type: 'Database Design',
      description:
          'A database project focused on structuring a university library system using entities, relationships, and organized data design.',
      tags: ['SQL', 'ERD', 'Database'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final cols = c.maxWidth >= 980 ? 3 : c.maxWidth >= 650 ? 2 : 1;
        const gap = 18.0;
        final width = (c.maxWidth - gap * (cols - 1)) / cols;

        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: data
              .map((e) => SizedBox(width: width, child: _ProjectCard(project: e)))
              .toList(),
        );
      },
    );
  }
}

class _Project {
  final String title;
  final String type;
  final String description;
  final List<String> tags;

  const _Project({
    required this.title,
    required this.type,
    required this.description,
    required this.tags,
  });
}

class _ProjectCard extends StatelessWidget {
  final _Project project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 320),
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F2EA),
        border: Border.all(color: const Color(0xFF171717)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.type.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 25,
              height: 1.05,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            project.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.65,
              color: Color(0xFF4D4842),
            ),
          ),
          const Spacer(),
          const SizedBox(height: 20),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: project.tags.map((e) => _Tag(e)).toList(),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFB8AFA3)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _Skills extends StatelessWidget {
  const _Skills();

  @override
  Widget build(BuildContext context) {
    const groups = {
      'Data': ['Power BI', 'Tableau', 'Excel', 'Python', 'SQL'],
      'Development': ['Flutter', 'Flutter Web', 'Firebase', 'Web Development', 'Git'],
      'Technical': ['APIs', 'Database Design', 'Machine Learning', 'Deep Learning'],
    };

    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: groups.entries
          .map(
            (e) => Container(
              width: 350,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFB8AFA3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.key,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: e.value.map((x) => _Tag(x)).toList(),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final small = c.maxWidth < 760;

        const lead = Text(
          'Open to opportunities in data analytics, software development, and practical technology projects.',
          style: TextStyle(
            fontSize: 28,
            height: 1.4,
            fontWeight: FontWeight.w800,
          ),
        );

        const links = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactLine(label: 'Email', value: 'fayalmtuairi@gmail.com'),
            _ContactLine(label: 'GitHub', value: 'github.com/FayAL-mtuairi'),
            _ContactLine(
              label: 'LinkedIn',
              value: 'linkedin.com/in/fay-al-mutairi-834a4a246',
            ),
          ],
        );

        if (small) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [lead, SizedBox(height: 30), links],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: lead),
            SizedBox(width: 70),
            Expanded(child: links),
          ],
        );
      },
    );
  }
}

class _ContactLine extends StatelessWidget {
  final String label;
  final String value;

  const _ContactLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.7,
            ),
          ),
          const SizedBox(height: 5),
          SelectableText(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
