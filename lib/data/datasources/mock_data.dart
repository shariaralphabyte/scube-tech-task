import '../models/user_model.dart';
import '../models/energy_data_model.dart';

class MockData {
  // Mock Users
  static final Map<String, dynamic> mockUsersJson = {
    'users': [
      {
        'id': '1',
        'email': 'admin@scm.com',
        'name': 'Admin User',
        'password': 'admin123',
        'avatar': null,
      },
      {
        'id': '2',
        'email': 'user@scm.com',
        'name': 'Regular User',
        'password': 'user123',
        'avatar': null,
      },
    ],
  };

  // Mock Energy Data for Today
  static final Map<String, dynamic> mockTodayEnergyJson = {
    'id': 'energy_today_1',
    'timestamp': DateTime.now().toIso8601String(),
    'totalPower': 5.53,
    'energyPerSqft': 55.00,
    'dataSources': [
      {
        'id': 'ds_1',
        'name': 'Data A',
        'data': 2798.50,
        'cost': 35689,
        'percentage': 29.53,
        'color': '0xFF2196F3', // Blue
      },
      {
        'id': 'ds_2',
        'name': 'Data B',
        'data': 72598.50,
        'cost': 5259689,
        'percentage': 35.39,
        'color': '0xFF00BCD4', // Light Cyan
      },
      {
        'id': 'ds_3',
        'name': 'Data C',
        'data': 6598.36,
        'cost': 5698756,
        'percentage': 83.90,
        'color': '0xFF9C27B0', // Purple
      },
      {
        'id': 'ds_4',
        'name': 'Data D',
        'data': 6598.26,
        'cost': 356987,
        'percentage': 36.59,
        'color': '0xFFFF9800', // Orange
      },
    ],
  };

  // Mock Energy Data for Custom Date Range
  static final Map<String, dynamic> mockCustomDateEnergyJson = {
    'id': 'energy_custom_1',
    'timestamp': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
    'totalPower': 20.05,
    'energyPerSqft': 57.00,
    'dataSources': [
      {
        'id': 'ds_1',
        'name': 'Data A',
        'data': 2798.50,
        'cost': 35689,
        'percentage': 29.53,
        'color': '0xFF2196F3',
      },
      {
        'id': 'ds_2',
        'name': 'Data B',
        'data': 72598.50,
        'cost': 5259689,
        'percentage': 35.39,
        'color': '0xFF00BCD4',
      },
      {
        'id': 'ds_3',
        'name': 'Data C',
        'data': 6598.36,
        'cost': 5698756,
        'percentage': 83.90,
        'color': '0xFF9C27B0',
      },
      {
        'id': 'ds_4',
        'name': 'Data D',
        'data': 6598.26,
        'cost': 356987,
        'percentage': 36.59,
        'color': '0xFFFF9800',
      },
    ],
  };

  // Mock Data Types for Summary Screen
  static final List<Map<String, dynamic>> mockDataTypesJson = [
    {
      'id': 'dt_1',
      'name': 'Data View',
      'icon': 'solar_panel',
      'isActive': true,
      'data1': 55505.63,
      'data2': 58805.63,
    },
    {
      'id': 'dt_2',
      'name': 'Data Type 2',
      'icon': 'generator',
      'isActive': true,
      'data1': 55505.63,
      'data2': 58805.63,
    },
    {
      'id': 'dt_3',
      'name': 'Data Type 3',
      'icon': 'wind_turbine',
      'isActive': false,
      'data1': 55505.63,
      'data2': 58805.63,
    },
  ];

  // Mock Multiple Chart Data
  static List<Map<String, dynamic>> getMockMultipleChartData() {
    return [
      {
        'id': 'chart_1',
        'timestamp': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
        'totalPower': 5.53,
        'energyPerSqft': 55.00,
        'dataSources': [
          {
            'id': 'ds_1',
            'name': 'Data A',
            'data': 2798.50,
            'cost': 35689,
            'percentage': 29.53,
            'color': '0xFF2196F3',
          },
          {
            'id': 'ds_2',
            'name': 'Data B',
            'data': 72598.50,
            'cost': 5259689,
            'percentage': 35.39,
            'color': '0xFF00BCD4',
          },
          {
            'id': 'ds_3',
            'name': 'Data C',
            'data': 6598.36,
            'cost': 5698756,
            'percentage': 83.90,
            'color': '0xFF9C27B0',
          },
          {
            'id': 'ds_4',
            'name': 'Data D',
            'data': 6598.26,
            'cost': 356987,
            'percentage': 36.59,
            'color': '0xFFFF9800',
          },
        ],
      },
      {
        'id': 'chart_2',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'totalPower': 20.05,
        'energyPerSqft': 57.00,
        'dataSources': [
          {
            'id': 'ds_1',
            'name': 'Data A',
            'data': 2798.50,
            'cost': 35689,
            'percentage': 29.53,
            'color': '0xFF2196F3',
          },
          {
            'id': 'ds_2',
            'name': 'Data B',
            'data': 72598.50,
            'cost': 5259689,
            'percentage': 35.39,
            'color': '0xFF00BCD4',
          },
          {
            'id': 'ds_3',
            'name': 'Data C',
            'data': 6598.36,
            'cost': 5698756,
            'percentage': 83.90,
            'color': '0xFF9C27B0',
          },
          {
            'id': 'ds_4',
            'name': 'Data D',
            'data': 6598.26,
            'cost': 356987,
            'percentage': 36.59,
            'color': '0xFFFF9800',
          },
        ],
      },
    ];
  }



  // Helper methods to get models
  static UserModel? getUserByCredentials(String email, String password) {
    final users = mockUsersJson['users'] as List;
    try {
      final userJson = users.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
      );
      return UserModel.fromJson(userJson as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }

  static EnergyDataModel getTodayEnergy() {
    return EnergyDataModel.fromJson(mockTodayEnergyJson);
  }

  static EnergyDataModel getCustomDateEnergy() {
    return EnergyDataModel.fromJson(mockCustomDateEnergyJson);
  }



  static List<EnergyDataModel> getMultipleCharts() {
    return getMockMultipleChartData()
        .map((json) => EnergyDataModel.fromJson(json))
        .toList();
  }
}
