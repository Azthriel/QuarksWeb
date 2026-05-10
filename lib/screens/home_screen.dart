// lib/screens/home_screen.dart
import 'dart:html' as html;

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
    // Establece el idioma inicial según la ruta
    changeLanguage(widget.localeCode);
    // Sincroniza el atributo lang del HTML al cargar la pantalla
    _updateHtmlLang(widget.localeCode);
  }

  /// Actualiza el atributo [lang] del <html> para SEO y accesibilidad.
  /// Se llama al iniciar y cada vez que el usuario cambia el idioma.
  void _updateHtmlLang(String localeCode) {
    html.document.documentElement?.lang = localeCode.toLowerCase();
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
              DrawerHeader(
                decoration: BoxDecoration(color: color3),
                child: Center(
                  child: ValueListenableBuilder<String>(
                    valueListenable: lenguaje,
                    builder: (context, value, child) {
                      return Text(
                        menu(value),
                        style: const TextStyle(
                          color: color1,
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
                builder: (context, value, child) {
                  return Column(
                    children: [
                      buildProfessionalDrawerButton(nosotros(value), _keyIntroduction),
                      buildProfessionalDrawerButton(servicios(value), _keyServices),
                      buildProfessionalDrawerButton(herramientas(value), _keyTools),
                      buildProfessionalDrawerButton(clientes(value), _keyPortfolio),
                      buildProfessionalDrawerButton(contacto(value), _keyContact),
                    ],
                  );
                },
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

  // Construye botón en Drawer
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
    _updateHtmlLang(newLanguage);
    if (newLanguage == 'ES') {
      context.go('/es');
    } else {
      context.go('/');
    }
  }
}