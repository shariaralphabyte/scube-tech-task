import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/utils.dart';
import '../providers/energy_provider.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/energy_chart_card.dart';
import '../widgets/semi_circular_progress_widget.dart';
import 'custom_date_screen.dart';
import 'dart:math' as math;

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showTodayData = true;
  bool _isExpanded = false; // Revenue card expanded state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final energyProvider = context.read<EnergyProvider>();
    await energyProvider.fetchTodayData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
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
      body: Container(
        color: AppTheme.blue_gray_300,
        child: Stack(
          children: [
            Positioned.fill(
              top: 60,
              child: Container(
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildDataView(), _buildRevenueView()],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  labelColor: AppTheme.primaryBlue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    _buildTab(title: AppConstants.dataViewTab, index: 0),
                    _buildTab(title: AppConstants.revenueViewTab, index: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab({required String title, required int index}) {
    final bool isSelected = _tabController.index == index;
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTripleLayerDot(isSelected),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isSelected ? AppTheme.primaryBlue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripleLayerDot(bool isSelected) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppTheme.primaryBlue : Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataView() {
    return Consumer<EnergyProvider>(
      builder: (context, energyProvider, _) {
        if (energyProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = energyProvider.currentData;
        if (data == null) {
          return _buildNoDataView();
        }

        return RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16),
                CircularProgressWidget(
                  value: data.energyPerSqft,
                  maxValue: 1,
                  unit: AppConstants.energyUnit,
                  size: 160,
                ),
                const SizedBox(height: 24),
                _buildDataToggle(),
                const SizedBox(height: 16),
                EnergyChartCard(
                  totalPower: data.totalPower,
                  dataSources: data.dataSources,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRevenueView() {
    return Consumer<EnergyProvider>(
      builder: (context, energyProvider, _) {
        if (energyProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = energyProvider.currentData;
        if (data == null) {
          return _buildNoDataView();
        }

        final totalRevenue = data.dataSources.fold<double>(
          0,
          (sum, source) => sum + source.cost,
        );

        return RefreshIndicator(
          onRefresh: _loadData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16),
                SemiCircularProgressWidget(
                  value: totalRevenue / 100000,
                  maxValue: 1,
                  unit: '৳',
                  width: 160,
                  height: 160,
                  strokeWidth: 14,
                ),
                const SizedBox(height: 16),
                // Expandable card
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.textGray),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Header
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Data & Cost Info',
                                style: AppTheme.screenTitle,
                              ),
                              Icon(
                                _isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: AppTheme.primaryBlue,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Expandable list
                      if (_isExpanded)
                        Column(
                          children: data.dataSources.map((source) {
                            final color = Color(int.parse(source.color));
                            return Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                                left: 12,
                                right: 12,
                              ),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.textGray),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Data 1',
                                              style: AppTheme.bodyText.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              ': ${NumberUtils.formatNumber(source.data)} (${NumberUtils.formatPercentage(source.percentage)})',
                                              style: AppTheme.dataValue
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              'Cost ',
                                              style: AppTheme.bodyText.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              ': ${source.cost.toStringAsFixed(0)}',
                                              style: AppTheme.dataValue
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton('Today Data', _showTodayData, () {
              setState(() {
                _showTodayData = true;
              });
              context.read<EnergyProvider>().toggleDataView(true);
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildToggleButton('Custom Date Data', !_showTodayData, () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CustomDateScreen()),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppTheme.white : AppTheme.textGray,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: AppTheme.tabText.copyWith(
                  color: isSelected ? AppTheme.white : AppTheme.textGray,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppTheme.textGray.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No data is here,\nplease wait.',
            style: AppTheme.bodyTextGray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
