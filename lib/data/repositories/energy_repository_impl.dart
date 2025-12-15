import '../../domain/entities/energy_data.dart';
import '../../domain/repositories/energy_repository.dart';
import '../datasources/mock_data.dart';

class EnergyRepositoryImpl implements EnergyRepository {
  @override
  Future<EnergyData?> getTodayData() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.getTodayEnergy();
  }

  @override
  Future<EnergyData?> getDataByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));
    return MockData.getCustomDateEnergy();
  }


  @override
  Future<List<EnergyData>> getMultipleChartData(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 1000));
    return MockData.getMultipleCharts();
  }
}
