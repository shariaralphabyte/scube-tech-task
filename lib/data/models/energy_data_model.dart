import '../../domain/entities/energy_data.dart';

class EnergyDataModel extends EnergyData {
  EnergyDataModel({
    required super.id,
    required super.timestamp,
    required super.totalPower,
    required super.energyPerSqft,
    required super.dataSources,
  });

  factory EnergyDataModel.fromJson(Map<String, dynamic> json) {
    return EnergyDataModel(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      totalPower: (json['totalPower'] as num).toDouble(),
      energyPerSqft: (json['energyPerSqft'] as num).toDouble(),
      dataSources: (json['dataSources'] as List)
          .map((e) => DataSourceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'totalPower': totalPower,
      'energyPerSqft': energyPerSqft,
      'dataSources': dataSources
          .map((e) => (e as DataSourceModel).toJson())
          .toList(),
    };
  }
}

class DataSourceModel extends DataSource {
  DataSourceModel({
    required super.id,
    required super.name,
    required super.data,
    required super.cost,
    required super.percentage,
    required super.color,
  });

  factory DataSourceModel.fromJson(Map<String, dynamic> json) {
    return DataSourceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      data: (json['data'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data,
      'cost': cost,
      'percentage': percentage,
      'color': color,
    };
  }
}

class DataTypeModel extends DataType {
  DataTypeModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.isActive,
    required super.data1,
    required super.data2,
  });

  factory DataTypeModel.fromJson(Map<String, dynamic> json) {
    return DataTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      isActive: json['isActive'] as bool,
      data1: (json['data1'] as num).toDouble(),
      data2: (json['data2'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'isActive': isActive,
      'data1': data1,
      'data2': data2,
    };
  }
}
