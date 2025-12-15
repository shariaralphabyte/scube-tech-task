class EnergyData {
  final String id;
  final DateTime timestamp;
  final double totalPower;
  final double energyPerSqft;
  final List<DataSource> dataSources;

  EnergyData({
    required this.id,
    required this.timestamp,
    required this.totalPower,
    required this.energyPerSqft,
    required this.dataSources,
  });
}

class DataSource {
  final String id;
  final String name;
  final double data;
  final double cost;
  final double percentage;
  final String color;

  DataSource({
    required this.id,
    required this.name,
    required this.data,
    required this.cost,
    required this.percentage,
    required this.color,
  });
}

class DataType {
  final String id;
  final String name;
  final String icon;
  final bool isActive;
  final double data1;
  final double data2;

  DataType({
    required this.id,
    required this.name,
    required this.icon,
    required this.isActive,
    required this.data1,
    required this.data2,
  });
}
