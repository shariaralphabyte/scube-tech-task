import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/utils.dart';
import '../../domain/entities/energy_data.dart';

class EnergyChartCard extends StatelessWidget {
  final double totalPower;
  final List<DataSource> dataSources;
  final String? title;

  const EnergyChartCard({
    super.key,
    required this.totalPower,
    required this.dataSources,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? 'Energy Chart',
                  style: AppTheme.screenTitle,
                ),
                Text(
                  '${totalPower.toStringAsFixed(2)} kw',
                  style: AppTheme.dataValue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...dataSources.map((source) => _buildDataRow(source)),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(DataSource source) {
    final color = Color(int.parse(source.color));
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.veryLightBlue,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.lightBlue),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source.name,
                      style: AppTheme.bodyText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Data',
                      style: AppTheme.smallText,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cost',
                      style: AppTheme.smallText,
                    ),
                    Text(
                      ': ${NumberUtils.formatNumber(source.data)} (${NumberUtils.formatPercentage(source.percentage)})',
                      style: AppTheme.bodyText,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      ': ${NumberUtils.formatCurrency(source.cost)} ৳',
                      style: AppTheme.bodyText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
