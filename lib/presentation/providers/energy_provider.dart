import 'package:flutter/foundation.dart';
import '../../domain/entities/energy_data.dart';
import '../../domain/repositories/energy_repository.dart';

class EnergyProvider with ChangeNotifier {
  final EnergyRepository _energyRepository;

  EnergyProvider(this._energyRepository);

  EnergyData? _todayData;
  EnergyData? _customDateData;
  List<DataType> _dataTypes = [];
  List<EnergyData> _multipleChartData = [];
  
  bool _isLoading = false;
  bool _isLoadingCustomDate = false;
  bool _isLoadingDataTypes = false;
  String? _errorMessage;

  DateTime? _startDate;
  DateTime? _endDate;
  bool _showTodayData = true;

  // Getters
  EnergyData? get todayData => _todayData;
  EnergyData? get customDateData => _customDateData;
  List<DataType> get dataTypes => _dataTypes;
  List<EnergyData> get multipleChartData => _multipleChartData;
  bool get isLoading => _isLoading;
  bool get isLoadingCustomDate => _isLoadingCustomDate;
  bool get isLoadingDataTypes => _isLoadingDataTypes;
  String? get errorMessage => _errorMessage;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  bool get showTodayData => _showTodayData;

  EnergyData? get currentData => _showTodayData ? _todayData : _customDateData;

  // Fetch today's data
  Future<void> fetchTodayData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _todayData = await _energyRepository.getTodayData();
    } catch (e) {
      _errorMessage = 'Failed to fetch today\'s data: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch custom date range data
  Future<void> fetchCustomDateData(DateTime start, DateTime end) async {
    _isLoadingCustomDate = true;
    _errorMessage = null;
    _startDate = start;
    _endDate = end;
    notifyListeners();

    try {
      _customDateData = await _energyRepository.getDataByDateRange(start, end);
      _showTodayData = false;
    } catch (e) {
      _errorMessage = 'Failed to fetch custom date data: ${e.toString()}';
    } finally {
      _isLoadingCustomDate = false;
      notifyListeners();
    }
  }

  // Fetch multiple chart data
  Future<void> fetchMultipleChartData(DateTime start, DateTime end) async {
    _isLoadingCustomDate = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _multipleChartData = await _energyRepository.getMultipleChartData(start, end);
    } catch (e) {
      _errorMessage = 'Failed to fetch chart data: ${e.toString()}';
    } finally {
      _isLoadingCustomDate = false;
      notifyListeners();
    }
  }



  // Toggle between today and custom date data
  void toggleDataView(bool showToday) {
    _showTodayData = showToday;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
