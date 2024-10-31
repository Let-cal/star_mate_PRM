import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  // Hàm mở bottom sheet
  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const SortBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  icon: const Icon(Icons.notifications_none, size: 24),
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    debugPrint('Notification button pressed');
                  },
                ),
              ],
            ),
            // Search and Sort Container
            Material(
              elevation: 0,
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.surface,
                      const Color(0x9AFFFFFF)
                    ],
                    stops: const [0, 1],
                    begin: const AlignmentDirectional(0, -1),
                    end: const AlignmentDirectional(0, 1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white, // Ô search sẽ có màu trắng
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            Theme.of(context).dividerColor, // Màu viền từ theme
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
                            color: Theme.of(context)
                                .iconTheme
                                .color, // Màu icon từ theme
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
                                        .color, // Màu chữ từ theme
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                  fillColor:
                                      Colors.white, // Ô tìm kiếm có màu trắng
                                ),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color, // Màu chữ từ theme
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                cursorColor: Theme.of(context)
                                    .colorScheme
                                    .primary, // Màu con trỏ từ theme
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.tune_rounded,
                              color: Theme.of(context)
                                  .iconTheme
                                  .color, // Màu icon từ theme
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
class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  final List<List<String>> zodiacSignsByElement = [
    ['Aries', 'Leo', 'Sagittarius'],
    ['Taurus', 'Virgo', 'Capricorn'],
    ['Cancer', 'Scorpio', 'Pisces'],
    ['Gemini', 'Libra', 'Aquarius'],
  ];

  final List<String> genders = ['Male', 'Female'];

  List<String> selectedZodiacs = [];
  String? selectedGender;

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
        children: [
          Text(
            'Choose Zodiac Signs (Max 3):',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              children: zodiacSignsByElement.map((zodiacRow) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: zodiacRow.map((zodiac) {
                      return buildChoiceChip(
                        label: zodiac,
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
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose Gender:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
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
                Navigator.pop(context);
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
