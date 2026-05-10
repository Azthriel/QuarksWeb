// lib/screens/home_screen.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quark_web/lenguajes.dart';
import 'package:quark_web/master.dart';
import '../widgets/header.dart';
import '../widgets/introduction_section.dart';
import '../widgets/services_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/tools.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final String localeCode; // 'en' o 'es'

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
    // Establece el idioma inicial según la ruta
    changeLanguage(widget.localeCode);
  }

  @override
  Widget build(BuildContext context) {
    widget.analytics
        .logScreenView(screenName: 'Home Screen (${widget.localeCode})');
    return Scaffold(
      backgroundColor: color1,
      appBar: Header(
        scrollController: _scrollController,
        keyIntroduction: _keyIntroduction,
        keyServices: _keyServices,
        keyPortfolio: _keyPortfolio,
        keyContact: _keyContact,
        keyTools: _keyTools,
        onChangeLanguage: _changeLanguage,
      ),
      endDrawer: Drawer(
        child: Container(
          color: color1,
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: color1,
                child: Center(
                  child: Text(
                    menu(lenguaje.value),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    buildProfessionalDrawerButton(
                        nosotros(lenguaje.value), _keyIntroduction),
                    const SizedBox(height: 10),
                    buildProfessionalDrawerButton(
                        servicios(lenguaje.value), _keyServices),
                    const SizedBox(height: 10),
                    buildProfessionalDrawerButton(
                        herramientas(lenguaje.value), _keyTools),
                    const SizedBox(height: 10),
                    buildProfessionalDrawerButton(
                        clientes(lenguaje.value), _keyPortfolio),
                    const SizedBox(height: 10),
                    buildProfessionalDrawerButton(
                        contacto(lenguaje.value), _keyContact),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '© 2024 Quarks Studio',
                  style: TextStyle(
                    color: color0,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  // Construye botón en Drawer (igual que antes)
  Widget buildProfessionalDrawerButton(String label, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color1,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Cambio de idioma y navegación
  void _changeLanguage(String newLanguage) {
    setState(() {
      changeLanguage(newLanguage);
    });
    if (newLanguage == 'es') {
      context.go('/es');
    } else {
      context.go('/');
    }
  }
}
