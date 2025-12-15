import 'package:flutter/material.dart';

class DataItemModel {
  final String id;
  final String? title;
  final String? status;
  final bool? isActive;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? colorIndicator;
  final String? data1Label;
  final String? data1Value;
  final String? data2Label;
  final String? data2Value;

  DataItemModel({
    required this.id,
    this.title,
    this.status,
    this.isActive,
    this.iconPath,
    this.backgroundColor,
    this.colorIndicator,
    this.data1Label,
    this.data1Value,
    this.data2Label,
    this.data2Value,
  });

  factory DataItemModel.fromJson(Map<String, dynamic> json) {
    return DataItemModel(
      id: json['id'] ?? '',
      title: json['title'],
      status: json['status'],
      isActive: json['isActive'],
      iconPath: json['iconPath'],
      backgroundColor: json['backgroundColor'] != null
          ? Color(int.parse(json['backgroundColor']))
          : null,
      colorIndicator: json['colorIndicator'] != null
          ? Color(int.parse(json['colorIndicator']))
          : null,
      data1Label: json['data1Label'],
      data1Value: json['data1Value'],
      data2Label: json['data2Label'],
      data2Value: json['data2Value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'isActive': isActive,
      'iconPath': iconPath,
      'backgroundColor': backgroundColor?.value.toString(),
      'colorIndicator': colorIndicator?.value.toString(),
      'data1Label': data1Label,
      'data1Value': data1Value,
      'data2Label': data2Label,
      'data2Value': data2Value,
    };
  }
}
