import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/page_layout.dart';

const String _mapsUrl = 'https://www.google.com/maps/search/?api=1&query='
    'Bansal+Institute+of+Engineering+and+Technology+Sitapur+Road+Lucknow';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  static final RegExp _emailPattern =
      RegExp(r'^[\w.+\-]+@([\w\-]+\.)+[A-Za-z]{2,}$');
  static final RegExp _phonePattern = RegExp(r'^\+?[0-9]{10,13}$');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(
    String label, {
    IconData? icon,
    bool alignLabelWithHint = false,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecoration(
      labelText: label,
      alignLabelWithHint: alignLabelWithHint,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      fillColor: AppColors.grey,
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.primary, 1.6),
    );
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!_emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final String cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    if (!_phonePattern.hasMatch(cleaned)) {
      return 'Please enter a valid phone number (10 to 13 digits)';
    }
    return null;
  }

  void _submit() {
    final FormState? form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    final String name = _nameController.text.trim();
    form.reset();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          icon: const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF2E7D32),
            size: 48,
          ),
          title: const Text('Form Submitted (Demo)'),
          content: Text(
            'Thank you, $name. Your details passed validation.\n\n'
            'This is a frontend demonstration form, so nothing has been sent '
            'to the college. To reach the institute, please use the phone '
            'number or email shown on this page.',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PageBanner(
            title: 'Get in Touch',
            subtitle: 'Contact details for Bansal Institute of Engineering '
                '& Technology, Lucknow.',
          ),
          PageSection(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool sideBySide = constraints.maxWidth >= 850;
                if (sideBySide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 2, child: _ContactDetails()),
                      const SizedBox(width: 28),
                      Expanded(flex: 3, child: _buildFormCard()),
                    ],
                  );
                }
                return Column(
                  children: [
                    const _ContactDetails(),
                    const SizedBox(height: 28),
                    _buildFormCard(),
                  ],
                );
              },
            ),
          ),
          const _MapSection(),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return AppCard(
      padding: const EdgeInsets.all(28),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send us a message',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 20, color: AppColors.primary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Demo form: this is a frontend demonstration. Messages '
                      'are not sent to the college.',
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.45,
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration:
                  _inputDecoration('Full Name', icon: Icons.person_outline),
              validator: (value) => _requiredValidator(value, 'full name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration:
                  _inputDecoration('Email Address', icon: Icons.mail_outline),
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration:
                  _inputDecoration('Phone Number', icon: Icons.phone_outlined),
              validator: _phoneValidator,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _subjectController,
              textInputAction: TextInputAction.next,
              decoration: _inputDecoration('Subject', icon: Icons.subject),
              validator: (value) => _requiredValidator(value, 'subject'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 5,
              decoration: _inputDecoration('Message', alignLabelWithHint: true),
              validator: (value) => _requiredValidator(value, 'message'),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send),
              label: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactDetails extends StatelessWidget {
  const _ContactDetails();

  @override
  Widget build(BuildContext context) {
    return const AppCard(
      color: AppColors.navy,
      borderColor: AppColors.navy,
      padding: EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          _DetailRow(
            icon: Icons.school_outlined,
            label: 'Institute',
            value: 'Bansal Institute of Engineering & Technology',
          ),
          SizedBox(height: 20),
          _DetailRow(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: 'NH-24, Sitapur Road, Behind Sewa Hospital, Lucknow, '
                'Uttar Pradesh – 226021.',
          ),
          SizedBox(height: 20),
          _DetailRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: '+91 9554 9999 37 / 38 / 39',
          ),
          SizedBox(height: 20),
          _DetailRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: 'info@bansaliet.in',
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0x26FFFFFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9FB7DC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Static map placeholder with a button that opens Google Maps in a new tab.
/// No API key is needed.
class _MapSection extends StatelessWidget {
  const _MapSection();

  @override
  Widget build(BuildContext context) {
    return PageSection(
      color: AppColors.grey,
      child: Column(
        children: [
          const SectionHeading(
            title: 'Find Us',
            subtitle: 'Open the institute location in Google Maps.',
          ),
          const SizedBox(height: 28),
          AppCard(
            padding: EdgeInsets.zero,
            child: Container(
              height: 260,
              width: double.infinity,
              color: AppColors.lightBlue,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 52,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bansal Institute of Engineering & Technology',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'NH-24, Sitapur Road, Behind Sewa Hospital, Lucknow',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.5, color: AppColors.textMuted),
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: () => openLink(_mapsUrl),
                      icon: const Icon(Icons.map_outlined),
                      label: const Text('Open in Google Maps'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
