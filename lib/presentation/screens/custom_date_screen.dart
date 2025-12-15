import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import '../providers/energy_provider.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/energy_chart_card.dart';

class CustomDateScreen extends StatefulWidget {
  const CustomDateScreen({super.key});

  @override
  State<CustomDateScreen> createState() => _CustomDateScreenState();
}

class _CustomDateScreenState extends State<CustomDateScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _fetchData() async {
    if (_startDate != null && _endDate != null) {
      final energyProvider = context.read<EnergyProvider>();
      await energyProvider.fetchMultipleChartData(_startDate!, _endDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCM'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<EnergyProvider>(
        builder: (context, energyProvider, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Circular Progress
                if (energyProvider.customDateData != null)
                  CircularProgressWidget(
                    value: energyProvider.customDateData!.energyPerSqft,
                    maxValue: 100,
                    unit: 'kWh/Sqft',
                    size: 140,
                  )
                else
                  CircularProgressWidget(
                    value: 57.00,
                    maxValue: 100,
                    unit: 'kWh/Sqft',
                    size: 140,
                  ),
                const SizedBox(height: 24),
                // Date Range Selector
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: 'From Date',
                          date: _startDate,
                          onTap: _selectStartDate,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDateField(
                          label: 'To Date',
                          date: _endDate,
                          onTap: _selectEndDate,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: AppTheme.white),
                          onPressed: _fetchData,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Multiple Charts
                if (energyProvider.isLoadingCustomDate)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  )
                else if (energyProvider.multipleChartData.isNotEmpty)
                  ...energyProvider.multipleChartData.map((data) {
                    return EnergyChartCard(
                      totalPower: data.totalPower,
                      dataSources: data.dataSources,
                      title: 'Energy Chart',
                    );
                  })
                else
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 60,
                          color: AppTheme.textGray.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Select date range and tap search',
                          style: AppTheme.bodyTextGray,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.smallText,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date != null
                        ? DateFormat('dd/MM/yyyy').format(date)
                        : 'Select',
                    style: AppTheme.bodyText,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: AppTheme.textGray,
            ),
          ],
        ),
      ),
    );
  }
}
