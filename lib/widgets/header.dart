import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userprovider.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String? province = userProvider.user?['province']?.toString();
    String? municipality = userProvider.user?['municipality']?.toString();
    return Stack(
      children: [
        // Background / base layer (optional — add color or image here)
        Positioned.fill(child: Container(color: colorScheme.surface)),

        // Content layer
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top row: avatar + location text
              Row(
                children: [
                  // Avatar circle
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.location_on_outlined,
                      color: colorScheme.onSurface.withOpacity(0.5),
                      size: 40,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // "Deliver to" + location text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deliver to',
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${province ?? 'Unknown'}, ${municipality ?? ''}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Search bar
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  hintStyle: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withOpacity(
                    0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
