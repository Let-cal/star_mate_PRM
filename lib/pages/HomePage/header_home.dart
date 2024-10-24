import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

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
                              debugPrint('Sort button pressed');
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
