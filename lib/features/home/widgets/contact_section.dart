import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/state/theme_notifier.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  ContactSectionState createState() => ContactSectionState();
}

class ContactSectionState extends State<ContactSection> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  bool _isSending = false;

  Future<void> _submit() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _phoneCtrl.text.isEmpty ||
        _msgCtrl.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(incompleteMessage(lenguaje.value)),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    setState(() => _isSending = true);
    try {
      await FirebaseFirestore.instance
          .collection('Web')
          .doc('Consultas Clientes')
          .update({
            'Consultas': FieldValue.arrayUnion([
              {
                'Nombre': _nameCtrl.text.trim(),
                'Mail': _emailCtrl.text.trim(),
                'Número': _phoneCtrl.text.trim(),
                'Mensaje': _msgCtrl.text.trim(),
              },
            ]),
          });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(completeMessage(lenguaje.value)),
            backgroundColor: Colors.green,
          ),
        );
        _nameCtrl.clear();
        _emailCtrl.clear();
        _phoneCtrl.clear();
        _msgCtrl.clear();
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos temaApp (ValueNotifier<ThemeMode>) y leemos isDarkMode con el getter
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: temaApp,
      builder: (context, _, __) {
        final dark = isDarkMode;
        final textPrimary = Theme.of(context).colorScheme.onSurface;
        final cardBg =
            dark
                ? Colors.white.withValues(alpha: 0.04)
                : color0.withValues(alpha: 0.03);
        const cardBorder = color3;
        final fieldFill =
            dark
                ? Colors.white.withValues(alpha: 0.05)
                : color0.withValues(alpha: 0.04);
        final fieldBorder =
            dark
                ? Colors.white.withValues(alpha: 0.12)
                : color0.withValues(alpha: 0.15);

        return ValueListenableBuilder<String>(
          valueListenable: lenguaje,
          builder: (context, lang, _) {
            return Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 800) {
                        return _buildMobile(
                          lang,
                          textPrimary,
                          cardBg,
                          cardBorder,
                          fieldFill,
                          fieldBorder,
                        );
                      }
                      return _buildDesktop(
                        lang,
                        textPrimary,
                        cardBg,
                        cardBorder,
                        fieldFill,
                        fieldBorder,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDesktop(
    String lang,
    Color textPrimary,
    Color cardBg,
    Color cardBorder,
    Color fieldFill,
    Color fieldBorder,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.only(right: 60, top: 8),
            child: _buildInfo(lang, textPrimary),
          ),
        ),
        Expanded(
          flex: 5,
          child: _buildForm(
            lang,
            textPrimary,
            cardBg,
            cardBorder,
            fieldFill,
            fieldBorder,
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(
    String lang,
    Color textPrimary,
    Color cardBg,
    Color cardBorder,
    Color fieldFill,
    Color fieldBorder,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfo(lang, textPrimary),
        const SizedBox(height: 40),
        _buildForm(
          lang,
          textPrimary,
          cardBg,
          cardBorder,
          fieldFill,
          fieldBorder,
        ),
      ],
    );
  }

  Widget _buildInfo(String lang, Color textPrimary) {
    final title =
        lang == 'EN'
            ? "Let's start a\nconversation."
            : "Comencemos una\nconversación.";
    final subtitle =
        lang == 'EN'
            ? 'We are ready to help you! Send us your questions and we will be happy to answer you.'
            : '¡Estamos listos para ayudarte! Envíanos tus dudas y estaremos encantados de responderte.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          subtitle,
          style: GoogleFonts.roboto(
            fontSize: 15,
            color: textPrimary.withValues(alpha: 0.6),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 44),
        _ContactInfoItem(
          icon: FontAwesomeIcons.envelope,
          label: 'Email',
          value: 'consultas@quarks-studio.com',
          textPrimary: textPrimary,
        ),
        const SizedBox(height: 24),
        _ContactInfoItem(
          icon: FontAwesomeIcons.whatsapp,
          label: 'WhatsApp',
          value: '+54 9 11 5855-7593',
          textPrimary: textPrimary,
        ),
        const SizedBox(height: 24),
        _ContactInfoItem(
          icon: FontAwesomeIcons.locationDot,
          label: lang == 'EN' ? 'Location' : 'Ubicación',
          value: 'Argentina / Buenos Aires',
          textPrimary: textPrimary,
        ),
      ],
    );
  }

  Widget _buildForm(
    String lang,
    Color textPrimary,
    Color cardBg,
    Color cardBorder,
    Color fieldFill,
    Color fieldBorder,
  ) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre + Teléfono en la misma fila
          LayoutBuilder(
            builder: (context, c) {
              if (c.maxWidth < 500) {
                return Column(
                  children: [
                    _Field(
                      label: nameLabel(lang),
                      hint: nameHint(lang),
                      controller: _nameCtrl,
                      textPrimary: textPrimary,
                      fieldFill: fieldFill,
                      fieldBorder: fieldBorder,
                    ),
                    const SizedBox(height: 16),
                    _Field(
                      label: phoneLabel(lang),
                      hint: phoneHint(lang),
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      textPrimary: textPrimary,
                      fieldFill: fieldFill,
                      fieldBorder: fieldBorder,
                    ),
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(
                    child: _Field(
                      label: nameLabel(lang),
                      hint: nameHint(lang),
                      controller: _nameCtrl,
                      textPrimary: textPrimary,
                      fieldFill: fieldFill,
                      fieldBorder: fieldBorder,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _Field(
                      label: phoneLabel(lang),
                      hint: phoneHint(lang),
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      textPrimary: textPrimary,
                      fieldFill: fieldFill,
                      fieldBorder: fieldBorder,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          _Field(
            label: mailLabel(lang),
            hint: mailHint(lang),
            controller: _emailCtrl,
            keyboardType: TextInputType.emailAddress,
            textPrimary: textPrimary,
            fieldFill: fieldFill,
            fieldBorder: fieldBorder,
          ),
          const SizedBox(height: 20),
          _Field(
            label: msgLabel(lang),
            hint: msgHint(lang),
            controller: _msgCtrl,
            maxLines: 5,
            textPrimary: textPrimary,
            fieldFill: fieldFill,
            fieldBorder: fieldBorder,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isSending ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: color2,
                disabledBackgroundColor: color2.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child:
                  _isSending
                      ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                      : Text(
                        lang == 'EN' ? 'Send Message' : 'Enviar Mensaje',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Campo de texto
// ---------------------------------------------------------------------------
class _Field extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Color textPrimary;
  final Color fieldFill;
  final Color fieldBorder;

  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    required this.textPrimary,
    required this.fieldFill,
    required this.fieldBorder,
    this.maxLines,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textPrimary.withValues(alpha: 0.75),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: color3,
          style: GoogleFonts.roboto(fontSize: 14, color: textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.roboto(
              fontSize: 14,
              color: textPrimary.withValues(alpha: 0.35),
            ),
            filled: true,
            fillColor: fieldFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: fieldBorder, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: color3, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Item de info de contacto
// ---------------------------------------------------------------------------
class _ContactInfoItem extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final String value;
  final Color textPrimary;

  const _ContactInfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: textPrimary.withValues(alpha: 0.06),
            border: Border.all(color: textPrimary.withValues(alpha: 0.1)),
          ),
          child: Center(
            child: FaIcon(
              icon,
              size: 18,
              color: textPrimary.withValues(alpha: 0.8),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textPrimary.withValues(alpha: 0.4),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
