import 'package:flutter/material.dart';
import '../RegisterPage/widgets/custom_button.dart';
import '../RegisterPage/widgets/custom_text_field.dart';
import 'edit_profile_model.dart';

class EditProfileForm extends StatelessWidget {
  final EditProfileModel model;
  final bool isKeyboardVisible;

  const EditProfileForm({
    super.key,
    required this.model,
    required this.isKeyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 670),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        _buildFormFields(context),
                      ],
                    ),
                  ),
                ),
                if (!isKeyboardVisible) _buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 32, 0, 8),
          child: Text(
            'Edit Your Profile',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
          child: Text(
            'Update your personal information below.',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: model.fullNameController,
          labelText: 'Full Name',
          textCapitalization: TextCapitalization.words,
        ),
        CustomTextField(
          controller: model.telephoneController,
          labelText: 'Telephone Number',
        ),
        const SizedBox(height: 28),
        TextFormField(
          controller: model.descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            labelStyle: Theme.of(context).textTheme.labelLarge,
            border: const OutlineInputBorder(),
          ),
          maxLines: null, // Cho phép nhập nhiều dòng
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 28),
        DropdownButtonFormField<int>(
          value: model.zodiacId,
          decoration: const InputDecoration(
            labelText: 'Zodiac',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 1, child: Text('Aries')),
            DropdownMenuItem(value: 2, child: Text('Taurus')),
            DropdownMenuItem(value: 3, child: Text('Gemini')),
            DropdownMenuItem(value: 4, child: Text('Cancer')),
            DropdownMenuItem(value: 5, child: Text('Leo')),
            DropdownMenuItem(value: 6, child: Text('Virgo')),
            DropdownMenuItem(value: 7, child: Text('Libra')),
            DropdownMenuItem(value: 8, child: Text('Scorpio')),
            DropdownMenuItem(value: 9, child: Text('Sagittarius')),
            DropdownMenuItem(value: 10, child: Text('Capricorn')),
            DropdownMenuItem(value: 11, child: Text('Aquarius')),
            DropdownMenuItem(value: 12, child: Text('Pisces')),
          ],
          onChanged: (int? value) {
            if (value != null) {
              model.zodiacId = value;
            }
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: CustomButton(
        onPressed: () async {
          try {
            model.setLoading(true);
            await model.updateProfile();

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Update successful!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              // Pop với result true để báo hiệu đã update thành công
              Navigator.of(context).pop(true);
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(' ${e.toString().replaceAll('Exception:', '')}'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          } finally {
            model.setLoading(false);
          }
        },
        text: 'Save',
      ),
    );
  }
}
