// lib/features/home/screens/home_screen.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/l10n/app_strings.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/utils/html_utils.dart';
import 'package:quark_web/core/utils/scroll_utils.dart';
import 'package:quark_web/features/home/widgets/contact_section.dart';
import 'package:quark_web/features/home/widgets/footer.dart';
import 'package:quark_web/features/home/widgets/header.dart';
import 'package:quark_web/features/home/widgets/introduction_section.dart';
import 'package:quark_web/features/home/widgets/portfolio_section.dart';
import 'package:quark_web/features/home/widgets/services_section.dart';
import 'package:quark_web/features/home/widgets/tools_section.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final String localeCode; // 'EN' o 'ES'

  const HomeScreen({
    super.key,
    required this.analytics,
    required this.localeCode,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _keyIntroduction = GlobalKey();
  final GlobalKey _keyServices = GlobalKey();
  final GlobalKey _keyPortfolio = GlobalKey();
  final GlobalKey _keyContact = GlobalKey();
  final GlobalKey _keyTools = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    changeLanguage(widget.localeCode);
    updateHtmlLang(widget.localeCode);
  }

  @override
  Widget build(BuildContext context) {
    widget.analytics.logScreenView(
      screenName: 'Home Screen (${widget.localeCode})',
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: Header(
        scrollController: _scrollController,
        keyIntroduction: _keyIntroduction,
        keyServices: _keyServices,
        keyPortfolio: _keyPortfolio,
        keyContact: _keyContact,
        keyTools: _keyTools,
        onChangeLanguage: _changeLanguage,
      ),
      endDrawer: _buildDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            IntroductionSection(
              key: _keyIntroduction,
              onGoToServices: () => scrollToSection(_keyServices),
            ),
            ServicesSection(key: _keyServices),
            ToolsSection(key: _keyTools),
            PortfolioSection(key: _keyPortfolio),
            ContactSection(key: _keyContact),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildDrawer() {
    final bg = Theme.of(context).colorScheme.surface;
    final fg = Theme.of(context).colorScheme.onSurface;
    return Drawer(
      child: Container(
        color: bg,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: color3),
              child: Center(
                child: ValueListenableBuilder<String>(
                  valueListenable: lenguaje,
                  builder: (context, value, _) {
                    return Text(
                      menu(value),
                      style: TextStyle(
                        color: fg,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: lenguaje,
              builder: (context, value, _) {
                return Column(
                  children: [
                    _buildDrawerButton(nosotros(value), _keyIntroduction),
                    _buildDrawerButton(servicios(value), _keyServices),
                    _buildDrawerButton(herramientas(value), _keyTools),
                    _buildDrawerButton(clientes(value), _keyPortfolio),
                    _buildDrawerButton(contacto(value), _keyContact),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerButton(String label, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          scrollToSection(key);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color3,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeLanguage(String newLanguage) {
    setState(() => changeLanguage(newLanguage));
    updateHtmlLang(newLanguage);
    if (newLanguage == 'ES') {
      context.go('/es');
    } else {
      context.go('/');
    }
  }
}
