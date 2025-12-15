import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sceube_tech/presentation/screens/summary_screen.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/text_style_helper.dart';
import '../../core/utils/size_utils.dart';
import '../models/energy_dashboard_model.dart';
import '../providers/energy_provider.dart';
import '../widgets/circular_progress_widget.dart';
import '../widgets/data_source_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/data_item_widget.dart';
import 'no_data_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showSource = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final energyProvider = context.read<EnergyProvider>();
    await Future.wait([
      energyProvider.fetchTodayData(),
    ]);
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
        leading: Icon(Icons.arrow_back),
      ),
      body:Container(
        color: AppTheme.blue_gray_300,

        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.only( topRight: Radius.circular(12), topLeft: Radius.circular(12)),

              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: false, // 👈 equal width
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,

                indicator: BoxDecoration(
                  color: AppTheme.primaryBlue, // selected color
                  borderRadius: BorderRadius.circular(10),
                ),

                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,

                tabs: const [
                  Tab(text: 'Summary'),
                  Tab(text: 'SLD'),
                  Tab(text: 'Data'),
                ],

              ),
            ),


            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSummaryTab(),
                  _buildSLDTab(),
                  _buildDataTab(),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildSummaryTab() {
    return Consumer<EnergyProvider>(
      builder: (context, energyProvider, _) {
        if (energyProvider.isLoading || energyProvider.isLoadingDataTypes) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = energyProvider.todayData;
        if (data == null) {
          return const Center(child: Text('No data available'));
        }
        final dataItems = _getSampleDataItems();

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [

                    const SizedBox(height: 8),
                    // Electricity Header
                    Text(
                      'Electricity',
                      style: TextStyleHelper.instance.title20SemiBoldInter
                          .copyWith(color: AppTheme.textGray),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                      height: 16,
                    ),
                    const SizedBox(height: 16),
                    // Circular Progress
                    CircularProgressWidget(
                      value: data.totalPower,
                      maxValue: 1,
                      unit: 'kw',
                      size: 160,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Power',
                      style: AppTheme.bodyText.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    // Source / Load Toggle
                    _buildSourceLoadToggle(),
                    const Divider(
                      color: Colors.grey,
                      thickness: 2,
                      height: 16,
                    ),
                    const SizedBox(height: 16),
                    // Data Types List - Show only 3 items
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Energy Data Sources',
                            style: AppTheme.screenTitle,
                          ),
                          SizedBox(height: 16.h),
                          // Show only first 3 items
                          SizedBox(
                            height: 200, // Fixed height for scrollable area
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: dataItems.length ,
                              itemBuilder: (context, index) {
                                final item = dataItems[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: DataItemWidget(
                                    model: item,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SummaryScreen(),
                                        ),
                                      );
                                    },

                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Action Buttons
              _buildMenuGrid(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSLDTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_tree_outlined,
            size: 80,
            color: AppTheme.textGray.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Single Line Diagram',
            style: AppTheme.screenTitle,
          ),
          const SizedBox(height: 8),
          Text(
            'Coming Soon',
            style: AppTheme.bodyTextGray,
          ),
        ],
      ),
    );
  }

  Widget _buildDataTab() {
    return Consumer<EnergyProvider>(
      builder: (context, energyProvider, _) {
        if (energyProvider.isLoadingDataTypes) {
          return const Center(child: CircularProgressIndicator());
        }

        final dataItems = _getSampleDataItems();

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_tree_outlined,
                size: 80,
                color: AppTheme.textGray.withOpacity(0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'Data Table',
                style: AppTheme.screenTitle,
              ),
              const SizedBox(height: 8),
              Text(
                'Coming Soon',
                style: AppTheme.bodyTextGray,
              ),
            ],
          ),
        );
      },
    );
  }

  List<DataItemModel> _getSampleDataItems() {
    return [
      DataItemModel(
        id: 'data_type_1',
        title: 'Main Grid',
        status: 'Active',
        isActive: true,
        backgroundColor: const Color(0xFFE5F4FE),
        colorIndicator: const Color(0xFF78C6FF),
        data1Label: 'Voltage',
        data1Value: '415 V',
        data2Label: 'Current',
        data2Value: '125 A',
        iconPath: 'assets/battry.png',
      ),
      DataItemModel(
        id: 'data_type_2',
        title: 'Solar Panel',
        status: 'Active',
        isActive: true,
        backgroundColor: const Color(0xFFFFF8E1),
        colorIndicator: const Color(0xFFFFB300),
        data1Label: 'Power',
        data1Value: '12.5 kW',
        data2Label: 'Efficiency',
        data2Value: '92%',
        iconPath: 'assets/solar-cell.png',


      ),
      DataItemModel(
        id: 'data_type_3',
        title: 'Backup Generator',
        status: 'Inactive',
        isActive: false,
        backgroundColor: const Color(0xFFFFEBEE),
        colorIndicator: const Color(0xFFEF5350),
        data1Label: 'Fuel Level',
        data1Value: '75%',
        data2Label: 'Runtime',
        data2Value: '0 hrs',
        iconPath: 'assets/power.png',
      ),
      DataItemModel(
        id: 'data_type_4',
        title: 'Battery Bank',
        status: 'Active',
        isActive: true,
        backgroundColor: const Color(0xFFE8F5E9),
        colorIndicator: const Color(0xFF66BB6A),
        data1Label: 'Charge',
        data1Value: '85%',
        data2Label: 'Health',
        data2Value: 'Good',
        iconPath: 'assets/solar-cell.png',

      ),
      DataItemModel(
        id: 'data_type_5',
        title: 'Wind Turbine',
        status: 'Active',
        isActive: true,
        backgroundColor: const Color(0xFFE0F2F1),
        colorIndicator: const Color(0xFF26A69A),
        data1Label: 'Speed',
        data1Value: '15 m/s',
        data2Label: 'Output',
        data2Value: '8.2 kW',
        iconPath: 'assets/power.png',
      ),
    ];
  }

  Widget _buildSourceLoadToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.veryLightBlue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton('Source', _showSource, () {
              setState(() {
                _showSource = true;
              });
            }),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildToggleButton('Load', !_showSource, () {
              setState(() {
                _showSource = false;
              });
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
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          style: AppTheme.tabText.copyWith(
            color: isSelected ? AppTheme.white : AppTheme.textGray,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16.h,
        mainAxisSpacing: 16.h,
        childAspectRatio: 2.8,
        children: [
          ShortcutItemWidget(
            title: 'Analysis Pro',
            iconPath: 'assets/chart.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
          ShortcutItemWidget(
            title: 'G. Generator',
            iconPath: 'assets/generator.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
          ShortcutItemWidget(
            title: 'Plant Summary',
            iconPath: 'assets/charge.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
          ShortcutItemWidget(
            title: 'Natural Gas',
            iconPath: 'assets/fire.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
          ShortcutItemWidget(
            title: 'D. Generator',
            iconPath: 'assets/generator.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
          ShortcutItemWidget(
            title: 'Water Process',
            iconPath: 'assets/faucet.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NoData(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }



}
