import 'package:flutter/material.dart';
import 'package:tactix_academy_admin/Core/Constants/Theme/appcolour.dart';
import 'package:tactix_academy_admin/Core/Widgets/custom_widgets.dart';
import 'package:tactix_academy_admin/Features/All%20Players/data/models/player_model.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel player;
  final Function(dynamic player)? onDelete;

  const PlayerCard({
    super.key,
    required this.player,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Profile Image
                Positioned.fill(
                  child: player.userProfile != null && player.userProfile.isNotEmpty
                      ? Image.network(
                          player.userProfile,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: kPrimaryColor.withOpacity(0.1),
                            child: const Icon(Icons.person, size: 48, color: kPrimaryColor),
                          ),
                        )
                      : Container(
                          color: kPrimaryColor.withOpacity(0.1),
                          child: const Icon(Icons.person, size: 48, color: kPrimaryColor),
                        ),
                ),
                // Gradient Overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                ),
                // Delete Button
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: kErrorColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => _showDeleteConfirmation(context),
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ),
                // Name and Team (Overlayed)
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        player.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: kPrimaryColor.withOpacity(0.5)),
                        ),
                        child: Text(
                          player.teamName ?? "Free Agent",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kSurfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Player', style: TextStyle(color: kTextColorPrimary)),
        content: Text(
          'Are you sure you want to delete ${player.name}? This action cannot be undone.',
          style: const TextStyle(color: kTextColorSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: kTextColorSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kErrorColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              if (onDelete != null) onDelete!(player);
              Navigator.pop(context);
              AppSnackBar.showError(context, '${player.name} has been deleted');
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
