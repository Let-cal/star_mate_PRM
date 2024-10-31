import 'package:flutter/material.dart';
import 'list_person.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
            child: Text(
              'Matched People',
              style: textTheme.bodyMedium?.copyWith(
                fontFamily: 'Abel',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return Container(
                  width: screenWidth * 0.9,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: const Color(0xFF353333)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 8, 0, 0),
                              child: Text(
                                person.name,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'Abel',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 8, 0, 0),
                            child: Text(
                              person.gender,
                              style: textTheme.bodyLarge?.copyWith(
                                fontFamily: 'Abel',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 8, 0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 24,
                              ),
                              onPressed: () {
                                debugPrint('IconButton pressed ...');
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12, 0, 0, 0),
                              child: Text(
                                person.zodiac,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontFamily: 'Abel',
                                  color: const Color(0xFFE12222),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
