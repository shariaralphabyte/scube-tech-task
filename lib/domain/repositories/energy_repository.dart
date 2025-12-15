import '../entities/energy_data.dart';

abstract class EnergyRepository {
  Future<EnergyData?> getTodayData();
  Future<EnergyData?> getDataByDateRange(DateTime startDate, DateTime endDate);
  Future<List<EnergyData>> getMultipleChartData(DateTime startDate, DateTime endDate);
}
