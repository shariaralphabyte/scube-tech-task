import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../models/energy_dashboard_model.dart';
import './custom_image_view.dart';

class DataItemWidget extends StatelessWidget {
  final DataItemModel model;
  final VoidCallback? onTap;

  const DataItemWidget({
    Key? key,
    required this.model,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 6.h),
        decoration: BoxDecoration(
          color: model.backgroundColor ?? const Color(0xFFE5F4FE),
          border: Border.all(color: AppTheme.blue_gray_300_01, width: 1.h),
          borderRadius: BorderRadius.circular(4.h),
        ),
        child:
            model.id == 'data_type_3' ? _buildStackLayout() : _buildRowLayout(),
      ),
    );
  }

  Widget _buildRowLayout() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 4.h),
          child: _buildIcon(),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 12.h),
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleRow(),
                _buildDataRow(model.data1Label ?? '', model.data1Value ?? ''),
                _buildDataRow(model.data2Label ?? '', model.data2Value ?? ''),
              ],
            ),
          ),
        ),
        _buildArrowIcon(),
      ],
    );
  }

  Widget _buildStackLayout() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 70.h,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 8.h),
                  child: _buildIcon(),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 44.h),
                  child: _buildDataRow(
                      model.data1Label ?? '', model.data1Value ?? ''),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h, left: 44.h),
                  child: _buildDataRow(
                      model.data2Label ?? '', model.data2Value ?? ''),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: _buildTitleRow(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 4.h),
                  child: _buildArrowIcon(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 28.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIcon() {
    if (model.iconPath != null && model.iconPath!.isNotEmpty) {
      return CustomImageView(
        imagePath: model.iconPath!,
        width: 24.h,
        height: 24.h,
      );
    }
    return Icon(
      Icons.electrical_services,
      size: 24.h,
      color: AppTheme.primaryBlue,
    );
  }

  Widget _buildArrowIcon() {
    return Icon(
      Icons.arrow_forward_ios,
      size: 16.h,
      color: AppTheme.textGray,
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Container(
          width: 12.h,
          height: 12.h,
          decoration: BoxDecoration(
            color: model.colorIndicator ?? const Color(0xFF78C6FF),
            borderRadius: BorderRadius.circular(2.h),
          ),
        ),
        SizedBox(width: 8.h),
        Text(
          model.title ?? '',
          style: TextStyleHelper.instance.body14MediumInter,
        ),
        SizedBox(width: 4.h),
        Text(
          '(${model.status ?? 'Active'})',
          style: TextStyleHelper.instance.label10MediumInter.copyWith(
              color: (model.isActive ?? true)
                  ? const Color(0xFF0096FC)
                  : AppTheme.red_700),
        ),
      ],
    );
  }

  Widget _buildDataRow(String label, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label      : ',
            style: TextStyleHelper.instance.body12RegularInter,
          ),
          TextSpan(
            text: value,
            style: TextStyleHelper.instance.body12RegularInter
                .copyWith(color: AppTheme.gray_900),
          ),
        ],
      ),
    );
  }
}
