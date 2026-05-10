import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quark_web/core/constants/app_colors.dart';
import 'package:quark_web/core/state/language_notifier.dart';
import 'package:quark_web/core/l10n/app_strings.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  ContactSectionState createState() => ContactSectionState();
}

class ContactSectionState extends State<ContactSection> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void validateAndSubmit() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        messageController.text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(incompleteMessage(lenguaje.value)),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      final userDoc = FirebaseFirestore.instance
          .collection('Web')
          .doc('Consultas Clientes');
      try {
        Map<String, String> map = {
          "Nombre": nameController.text.trim(),
          "Mail": emailController.text.trim(),
          "Número": phoneController.text.trim(),
          "Mensaje": messageController.text.trim(),
        };
        await userDoc.update({
          'Consultas': FieldValue.arrayUnion([map]),
        });
        debugPrint('Mapa añadido con éxito');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(completeMessage(lenguaje.value)),
              backgroundColor: Colors.green,
            ),
          );
        }
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        messageController.clear();
      } catch (e) {
        debugPrint('Error al añadir el mapa: $e');
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color1,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                contactTitle(lenguaje.value),
                style: GoogleFonts.roboto(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: color0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                contactSubtitle(lenguaje.value),
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: color0.withValues(alpha:0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInputField(
                      label: nameLabel(lenguaje.value),
                      hintText: nameHint(lenguaje.value),
                      icon: Icons.person,
                      controller: nameController,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: mailLabel(lenguaje.value),
                      hintText: mailHint(lenguaje.value),
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: phoneLabel(lenguaje.value),
                      hintText: phoneHint(lenguaje.value),
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 16),
                    _buildInputField(
                      label: mailLabel(lenguaje.value),
                      hintText: mailHint(lenguaje.value),
                      icon: Icons.message,
                      maxLines: 4,
                      controller: messageController,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: validateAndSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 10,
                          shadowColor: color0.withValues(alpha:0.5),
                        ),
                        child: Text(
                          sendButton(lenguaje.value),
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      cursorColor: color3,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: color0),
        labelText: label,
        labelStyle: GoogleFonts.roboto(
          color: color0.withValues(alpha:0.7),
          fontSize: 18,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          color: color0.withValues(alpha:0.5),
          fontSize: 16,
        ),
        filled: true,
        fillColor: color3.withValues(alpha:0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: color0.withValues(alpha:0.5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: color0, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
