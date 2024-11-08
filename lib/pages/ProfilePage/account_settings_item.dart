import 'package:flutter/material.dart';
import '../EditProfilePage/edit_profile_page.dart';
import '../ForgotPage/forgot_page.dart';
import 'package:provider/provider.dart';
import 'profile_page_model.dart';

Widget accountSettingsItem(BuildContext context, String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () async {
            // Thêm async ở đây
            if (title == 'Edit Profile') {
              // Đợi kết quả từ Edit Profile Page
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfilePageWidget(),
                ),
              );

              // Nếu edit thành công và context vẫn valid
              if (result == true && context.mounted) {
                // Refresh lại data thông qua ProfilePageModel
                context.read<ProfilePageModel>().loadUserInfo();
              }
            }
            if (title == 'Change Password') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ForgotPageWidget(),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right_rounded,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
