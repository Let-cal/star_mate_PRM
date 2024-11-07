import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../filter_provider.dart';
import './friend_request_provider.dart';
import 'notificaiton_fragment.dart';

class HeaderHome extends StatefulWidget {
  final Function(List<int> zodiacIds, String gender) onFiltersUpdated;

  const HeaderHome({
    super.key,
    required this.onFiltersUpdated,
  });

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  // Load friend requests when the widget is initialized
 @override
  void initState() {
    super.initState();
    // Fetch friend requests as soon as HeaderHome is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FriendRequestProvider>(context, listen: false)
          .fetchFriendRequests();
    });
  }

  void _showNotificationFragment() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationFragment()),
    );
  }

  void _showSortBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return const SortBottomSheet();
      },
    );

    if (result != null) {
      final zodiacIds = result['zodiacIds'] as List<int>;
      final gender = result['gender'] as String;
      widget.onFiltersUpdated(
          zodiacIds, gender); // Gọi callback để cập nhật state ở Home
    }
  }

  @override
  Widget build(BuildContext context) {
    final friendRequestProvider = Provider.of<FriendRequestProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 20), // Thêm margin ở trên
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Avatar container
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 6, 16, 6),
                  child: Container(
                    width: 53,
                    height: 53,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://picsum.photos/seed/626/600',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Welcome text
                Expanded(
                  child: Text(
                    'Welcome, Bao',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                // Notification icon
                IconButton(
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_none, size: 24),
                      if (friendRequestProvider.totalFriendRequests > 0)
                        Positioned(
                          top: -4,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              friendRequestProvider.totalFriendRequests
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: _showNotificationFragment,
                )
              ],
            ),
            // Search and Sort Container
            Material(
              elevation: 0,
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: Theme.of(context).iconTheme.color,
                            size: 24,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  4, 0, 0, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Search listings...',
                                  labelStyle: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                ),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.tune_rounded,
                              color: Theme.of(context).iconTheme.color,
                              size: 24,
                            ),
                            onPressed: () {
                              _showSortBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom sheet để chọn cung hoàng đạo và giới tính
class Zodiac {
  final int id;
  final String name;

  Zodiac(this.id, this.name);
}

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  // Danh sách cung hoàng đạo với ID
  final List<Zodiac> zodiacSigns = [
    Zodiac(1, 'Aries'),
    Zodiac(2, 'Taurus'),
    Zodiac(3, 'Gemini'),
    Zodiac(4, 'Cancer'),
    Zodiac(5, 'Leo'),
    Zodiac(6, 'Virgo'),
    Zodiac(7, 'Libra'),
    Zodiac(8, 'Scorpio'),
    Zodiac(9, 'Sagittarius'),
    Zodiac(10, 'Capricorn'),
    Zodiac(11, 'Aquarius'),
    Zodiac(12, 'Pisces'),
  ];

  final List<String> genders = ['Male', 'Female'];

  List<Zodiac> selectedZodiacs = [];
  String? selectedGender;
  String errorMessage = '';

  Widget buildChoiceChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
    required double width,
  }) {
    return SizedBox(
      width: width,
      child: ChoiceChip(
        label: Container(
          width: width - 24,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        selected: selected,
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        onSelected: onSelected,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        side: BorderSide(
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
          width: 1,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị từ FilterProvider
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    if (filterProvider.selectedZodiacIds != null) {
      selectedZodiacs = zodiacSigns
          .where((z) => filterProvider.selectedZodiacIds!.contains(z.id))
          .toList();
    }
    selectedGender = filterProvider.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final chipWidth = (screenWidth - 32 - 16) / 3;

    return Container(
      padding: const EdgeInsets.all(16),
      height: 500,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 8),
              child: Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Center(
            child: Text(
              'Choose Zodiac Signs (Max 3):',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              children: List.generate(
                zodiacSigns.length ~/ 3 + (zodiacSigns.length % 3 == 0 ? 0 : 1),
                (rowIndex) {
                  final startIndex = rowIndex * 3;
                  final endIndex = (rowIndex + 1) * 3;
                  final zodiacRow = zodiacSigns.sublist(
                    startIndex,
                    endIndex > zodiacSigns.length
                        ? zodiacSigns.length
                        : endIndex,
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: zodiacRow.map((zodiac) {
                        return buildChoiceChip(
                          label: zodiac.name,
                          selected: selectedZodiacs.contains(zodiac),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected && selectedZodiacs.length < 3) {
                                selectedZodiacs.add(zodiac);
                              } else {
                                selectedZodiacs.remove(zodiac);
                              }
                            });
                          },
                          width: chipWidth,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Choose Gender:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: genders.map((gender) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: buildChoiceChip(
                  label: gender,
                  selected: selectedGender == gender,
                  onSelected: (isSelected) {
                    setState(() {
                      selectedGender = isSelected ? gender : null;
                    });
                  },
                  width: 120,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (selectedZodiacs.isEmpty || selectedGender == null) {
                  setState(() {
                    errorMessage =
                        'Please select at least one zodiac and gender.';
                  });
                } else {
                  setState(() {
                    errorMessage = '';
                  });
                  // Return the selected data as a Map
                  Navigator.pop(context, {
                    'zodiacIds': selectedZodiacs.map((z) => z.id).toList(),
                    'gender': selectedGender,
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
