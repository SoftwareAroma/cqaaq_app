import 'package:cached_network_image/cached_network_image.dart';
import 'package:cqaaq_app/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportDetailScreen extends StatefulWidget {
  static const String id = 'report_detail_screen';
  final ReportModel reportModel;
  const ReportDetailScreen({
    super.key,
    required this.reportModel,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // dynamic reportModel = widget.arguments['reportModel'];
    // logger.i('reportModel: ${widget.reportModel}');
    return BasePage(
      title: StringResource.reportDetailText,
      leading: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 4.0.r,
          vertical: 4.0.r,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        child: IconButton(
          onPressed: () {
            NavigationService.goBack();
          },
          icon: Icon(
            LineAwesomeIcons.angle_left,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // date
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    LineAwesomeIcons.calendar,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: CustomText(
                    "${DateFormat.EEEE().format(DateTime.parse(widget.reportModel.date)).toString()} ${DateFormat.yMMMMd().format(DateTime.parse(widget.reportModel.date)).toString()}",
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  subtitle: CustomText(
                    DateFormat.jm().format(DateTime.parse(widget.reportModel.date)).toString(),
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  trailing: CustomText(
                    widget.reportModel.reportId,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
              // site
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    LineAwesomeIcons.globe,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: CustomText(
                    widget.reportModel.site,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    StringResource.siteText,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              // moi
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    LineAwesomeIcons.modx,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: CustomText(
                    widget.reportModel.moi ?? 'N/A',
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    StringResource.moiText,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              // truck number
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    LineAwesomeIcons.truck,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: CustomText(
                    widget.reportModel.truckNumber!.isNotEmpty ? widget.reportModel.truckNumber! : 'N/A',
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    'Truck Number',
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              // reporter card
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                    child: CachedNetworkImage(
                      imageUrl: appController.getUser(widget.reportModel.reporterId)?.avatar ?? defaultAvatarUrl,
                      placeholder: (BuildContext context, String url) => const CircularProgressIndicator(),
                      errorWidget: (BuildContext context, String url, Object error) => const Icon(Icons.error),
                    ),
                  ),
                  title: CustomText(
                    appController.getUser(widget.reportModel.reporterId)?.firstName ?? widget.reportModel.reporterUid,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    appController.getUser(widget.reportModel.reporterId)?.uid ?? widget.reportModel.reporterUid,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 8.0.sp,
                  ),
                  trailing: CustomText(
                    appController.getUser(widget.reportModel.reporterId)?.district ?? widget.reportModel.reporterUid,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 10.0.sp,
                    fontWeight: FontWeight.bold,
                    maxLines: 3,
                  ),
                ),
              ),
              // grainage per kilogram
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(
                    LineAwesomeIcons.balance_scale,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  title: CustomText(
                    widget.reportModel.grainage.isNotEmpty ? widget.reportModel.grainage : 'N/A',
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  subtitle: CustomText(
                    'Grainage per Kilogram',
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              // SfDataGrid for data field of report
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                color: Theme.of(context).colorScheme.background,
                elevation: 4.0,
                shadowColor: Colors.black12,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: Theme.of(context).colorScheme.primary,
                    headerHoverColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: SfDataGrid(
                    allowEditing: false,
                    columnWidthMode: ColumnWidthMode.fill,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    gridLinesVisibility: GridLinesVisibility.both,
                    selectionMode: SelectionMode.none,
                    navigationMode: GridNavigationMode.cell,
                    onQueryRowHeight: (RowHeightDetails details) {
                      return details.rowIndex == 0 ? 60.0.h : 80.0.h;
                    },
                    source: ReportDataSource(
                      widget.reportModel.data.map((ReportCategory e) => ReportRow.fromJson(e.toJson())).toList(),
                    ),
                    columns: <GridColumn>[
                      GridColumn(
                        columnName: 'commodity',
                        allowEditing: false,
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          alignment: Alignment.center,
                          child: CustomText(
                            'Commodity',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'tonnage',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          alignment: Alignment.center,
                          child: CustomText(
                            'Tonnage',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'total_pods',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          alignment: Alignment.center,
                          child: CustomText(
                            'Total Pods (GRAM)',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      GridColumn(
                        columnName: 'total_percentage',
                        label: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                          alignment: Alignment.center,
                          child: CustomText(
                            'Total Percentage (%)',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
