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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.textGray),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title ?? 'Energy Chart',
                  style: AppTheme.screenTitle,
                ),
                Text(
                  '${totalPower.toStringAsFixed(2)} kw',
                  style: AppTheme.largeValue,
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

        border: Border.all(color: AppTheme.textLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                source.name,
                style: AppTheme.bodyText.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
            child: VerticalDivider(
              thickness: 1.5,
              width: 24,
              color: Colors.grey.withOpacity(0.4),
            ),
          ),          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Data ',
                      style: AppTheme.smallText,
                    ),
                    Text(
                      ': ${NumberUtils.formatNumber(source.data)} (${NumberUtils.formatPercentage(source.percentage)})',
                      style: AppTheme.bodyText,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Cost ',
                      style: AppTheme.smallText,
                    ),
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
