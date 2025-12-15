import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/energy_data.dart';

class DataSourceCard extends StatelessWidget {
  final DataType dataType;
  final VoidCallback? onTap;

  const DataSourceCard({
    super.key,
    required this.dataType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppTheme.veryLightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lightBlue),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildIcon(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            dataType.name,
                            style: AppTheme.bodyText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (dataType.isActive)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '(Active)',
                                style: AppTheme.smallText.copyWith(
                                  color: AppTheme.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.textGray.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '(Inactive)',
                                style: AppTheme.smallText.copyWith(
                                  color: AppTheme.textGray,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Data 1',
                              style: AppTheme.smallText,
                            ),
                          ),
                          Text(
                            ': ${dataType.data1.toStringAsFixed(2)}',
                            style: AppTheme.bodyText,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Data 2',
                              style: AppTheme.smallText,
                            ),
                          ),
                          Text(
                            ': ${dataType.data2.toStringAsFixed(2)}',
                            style: AppTheme.bodyText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: AppTheme.textGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData iconData;
    Color iconColor;

    switch (dataType.icon) {
      case 'solar_panel':
        iconData = Icons.solar_power;
        iconColor = AppTheme.primaryBlue;
        break;
      case 'generator':
        iconData = Icons.power;
        iconColor = AppTheme.orange;
        break;
      case 'wind_turbine':
        iconData = Icons.wind_power;
        iconColor = AppTheme.purple;
        break;
      default:
        iconData = Icons.electrical_services;
        iconColor = AppTheme.textGray;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 28,
      ),
    );
  }
}
