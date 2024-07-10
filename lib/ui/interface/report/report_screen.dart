import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cqaaq_app/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportScreen extends StatefulWidget {
  static const String id = 'report_screen';
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  /// Syncfusion [SfDataGrid] [Key]
  final GlobalKey<SfDataGridState> _dataGridKey = GlobalKey<SfDataGridState>();

  /// [DataGridController] for the [SfDataGrid]
  late DataGridController _dataGridController;

  /// [FormBuilder] key for the [FormBuilderState]
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  /// [DataGridSource] for the [SfDataGrid]
  late ReportDataSource _reportDataSource;

  final List<ReportRow> _reportRows = <ReportRow>[
    ReportRow(column1: 'NUT VOID', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'NUT SPOTTED', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'NUT IMMATURE', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'NUT OIL SEEDS', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'NUT DISEASED', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'TOTAL NUTS WITH DEFECTS', column2: 'T1', column3: '', column4: ''),
    ReportRow(column1: '50% SPOTTED', column2: '', column3: '', column4: ''),
    ReportRow(column1: '50% IMMATURE', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'TOTAL NUTS WITH DEFECTS', column2: 'T2', column3: '', column4: ''),
    ReportRow(column1: '', column2: 'Gms', column3: 'Gbs', column4: ''),
    ReportRow(column1: '100% SHELLED GOOD KERNELS', column2: 'K1', column3: '', column4: ''),
    ReportRow(column1: '50% OF THE SHELLED SPOTTED KERNELS', column2: '', column3: '', column4: ''),
    ReportRow(column1: '50% OF THE SHELLED IMMATURE KERNELS', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'OVERALL OUTPUT (KOR7)', column2: '', column3: '', column4: ''),
    ReportRow(column1: 'OBSERVATION', column2: 'LBA', column3: '', column4: ''),
    ReportRow(column1: '', column2: 'ORIGIN', column3: 'GHANA', column4: ''),
    ReportRow(column1: '', column2: 'ANALYSER', column3: '', column4: ''),
  ];

  double korValue = 0.0;

  double calculateKor({
    required double immature,
    required double spotted,
    required double goodKernel,
  }) {
    // Calculate KOR using the provided formula
    double kor = (1 / 2 * (immature + spotted) + goodKernel) * 0.176;
    return kor;
  }

  @override
  void initState() {
    _reportDataSource = ReportDataSource(_reportRows);
    _dataGridController = DataGridController();
    korValue = calculateKor(immature: 0, spotted: 0, goodKernel: 0);
    super.initState();
  }

  /// space [Widget] with [Gap]
  Widget get _space => Gap(10.0.h);

  @override
  Widget build(BuildContext context) {
    var immature = _reportDataSource.dataGridRows[2].getCells().toList()[3].value;
    var spotted = _reportDataSource.dataGridRows[1].getCells().toList()[3].value;
    var goodKernel = _reportDataSource.dataGridRows[10].getCells().toList()[3].value;
    // logger.e("immature => immature $spotted $goodKernel");
    double res = calculateKor(
      immature: double.tryParse(immature) ?? 0,
      spotted: double.tryParse(spotted) ?? 0,
      goodKernel: double.tryParse(goodKernel) ?? 0,
    );
    setState(() {
      korValue = res;
    });
    // update the OVERALL OUTPUT (KOR7) of the data grid
    var columnIndex = _reportDataSource.dataGridRows.indexWhere((DataGridRow dataGridRow) {
      return dataGridRow.getCells().first.value == 'OVERALL OUTPUT (KOR7)';
    });
    _reportDataSource.dataGridRows[columnIndex].getCells()[3] = DataGridCell<String>(
      columnName: 'column4',
      value: res.toStringAsFixed(2),
    );
    // logger.e("Result => $res");
    return BasePage(
      title: StringResource.reportText,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Obx(
        () => (userController.user != null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Gap(5.0.h),
                  Expanded(
                    flex: 4,
                    child: FormBuilder(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      /// left column
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            FormBuilderDateTimePicker(
                                              name: "date",
                                              // enabled: false,
                                              initialDate: DateTime.now().toLocal(),
                                              initialValue: DateTime.now().toLocal(),
                                              inputType: InputType.date,
                                              decoration: InputDecoration(
                                                // labelText: "Email",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.calendar,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0.r),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                            ),
                                            _space,
                                            FormBuilderTextField(
                                              name: "site",
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: "Site",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.sitemap,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0.r),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                              validator: FormBuilderValidators.compose([
                                                FormBuilderValidators.required(),
                                              ]),
                                            ),
                                            _space,
                                            FormBuilderTextField(
                                              name: "moi",
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: "MOI",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.microscope,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0.r),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                              validator: FormBuilderValidators.compose([
                                                FormBuilderValidators.required(),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      _space,

                                      /// rght column
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            FormBuilderTextField(
                                              name: "truck_no",
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: "Truck No",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.truck,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0.r),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                              validator: FormBuilderValidators.compose([]),
                                            ),
                                            _space,
                                            FormBuilderTextField(
                                              name: "report_id",
                                              enabled: false,
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              initialValue: randomString(),
                                              decoration: InputDecoration(
                                                labelText: "Report Id",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.barcode,
                                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(
                                                        0.3,
                                                      ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0.r),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                              validator: FormBuilderValidators.compose([]),
                                            ),
                                            _space,
                                            FormBuilderTextField(
                                              name: "reporter_uid",
                                              enabled: false,
                                              textInputAction: TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              initialValue: userController.user?.uid,
                                              decoration: InputDecoration(
                                                labelText: "Reporter ID",
                                                prefixIcon: Icon(
                                                  LineAwesomeIcons.address_card,
                                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(
                                                        0.3,
                                                      ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  gapPadding: 5.0,
                                                ),
                                              ),
                                              validator: FormBuilderValidators.compose([
                                                FormBuilderValidators.required(),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  _space,

                                  /// grainage
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomText(
                                        "GRAINAGE per KILOGRAM",
                                        color: Theme.of(context).colorScheme.onBackground,
                                        fontWeight: FontWeight.w600,
                                        maxLines: 2,
                                        fontSize: 16.0.sp,
                                      ),
                                      Gap(5.0.h),
                                      FormBuilderTextField(
                                        name: "weight",
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        scrollPadding: EdgeInsets.all(5.0.h),
                                        decoration: InputDecoration(
                                          labelText: "0",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0.r),
                                            gapPadding: 5.0,
                                          ),
                                        ),
                                        validator: FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                      ),
                                    ],
                                  ),
                                  _space,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: SfDataGridTheme(
                      data: SfDataGridThemeData(
                        headerColor: Theme.of(context).colorScheme.primary,
                        headerHoverColor: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: SfDataGrid(
                        key: _dataGridKey,
                        columnWidthMode: ColumnWidthMode.auto,
                        gridLinesVisibility: GridLinesVisibility.both,
                        headerGridLinesVisibility: GridLinesVisibility.both,
                        source: _reportDataSource,
                        controller: _dataGridController,
                        // frozenColumnsCount: 1,
                        allowEditing: true,
                        selectionMode: SelectionMode.single,
                        navigationMode: GridNavigationMode.cell,
                        editingGestureType: EditingGestureType.tap,
                        onQueryRowHeight: (RowHeightDetails details) {
                          return details.rowIndex == 0 ? 60.0.h : 80.0.h;
                        },
                        onSelectionChanged: (addedRows, removedRows) {
                          // update state
                          setState(() {});
                        },
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
                  _space,
                  ProceedButton(
                    text: "Proceed".toUpperCase(),
                    onPressed: () => _proceedAction(),
                  ),
                  _space,
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Gap(10.0.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          "No User Logged In".toUpperCase(),
                          fontSize: 22.0.sp,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ],
                    ),
                    Gap(5.0.h),
                    CustomText(
                      "Login to submit a review, report or an update",
                      fontSize: 14.0.sp,
                      textAlign: TextAlign.center,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    Gap(20.0.h),
                    CustomOutlineButton(
                      title: StringResource.loginText.toUpperCase(),
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        NavigationService.navigateTo(
                          navigationMethod: NavigationMethod.push,
                          page: LoginScreen.id,
                          isNamed: true,
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String randomString({int length = 7}) {
    const String chars = '1234567890';
    Random rnd = Random.secure();
    String value = String.fromCharCodes(
      Iterable.generate(
        length - 2,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );

    /// add two 00 infront of the generated code
    return '00$value';
  }

  _checkInternet() async {
    List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (!mounted) return;
    // if no internet connection, show error message and return
    if (connectivityResult.contains(ConnectivityResult.none)) {
      showCustomFlushBar(
        context: context,
        message: "No internet connection",
        icon: LineAwesomeIcons.exclamation_circle,
        iconColor: Theme.of(context).colorScheme.error,
      );
      return;
    }
  }

  _proceedAction() async {
    // showLoading(context);
    try {
      /// check for internet connection
      _checkInternet();

      /// validate the form
      if (!(_formKey.currentState!.saveAndValidate())) {
        showCustomFlushBar(
          context: context,
          message: "Please fill all required fields",
          icon: LineAwesomeIcons.exclamation_circle,
          iconColor: Theme.of(context).colorScheme.error,
        );
        return;
      }

      /// end data grid editing
      _dataGridController.endEdit();
      FirebaseAuth auth = FirebaseAuth.instance;

      /// get the updated data after end edit
      List<ReportRow> updatedData = _reportDataSource.dataGridRows.map((DataGridRow dataGridRow) {
        return ReportRow(
          column1: dataGridRow.getCells()[0].value.toString(),
          column2: dataGridRow.getCells()[1].value.toString(),
          column3: dataGridRow.getCells()[2].value.toString(),
          column4: dataGridRow.getCells()[3].value.toString(),
        );
      }).toList();

      List<Map<String, dynamic>> dataGridData = <Map<String, dynamic>>[];

      /// for every item in the updated data, add to the dataGridData
      for (int i = 0; i < updatedData.length; i++) {
        dataGridData.add({
          "column1": updatedData[i].column1.isNotEmpty ? updatedData[i].column1 : "",
          "column2": updatedData[i].column2.isNotEmpty ? updatedData[i].column2 : "",
          "column3": updatedData[i].column3.isNotEmpty ? updatedData[i].column3 : "",
          "column4": updatedData[i].column4.isNotEmpty ? updatedData[i].column4 : "",
        });
      }
      // logger.i("DataGrid Data: $dataGridData");

      /// get form data
      Map<String, dynamic>? formData = _formKey.currentState?.value;
      // logger.i("Form Data: $formData");
      DateTime date = formData?['date'] ?? DateTime.now();
      String site = formData?['site'] ?? "";
      String moi = formData?['moi'] ?? "";
      String truckNo = formData?['truck_no'] ?? "";
      String reportId = formData?['report_id'] ?? "";
      String reporterUid = formData?['reporter_uid'] ?? "";
      String reporterId = auth.currentUser!.uid;
      String grainage = formData?['grainage'] ?? "";

      Map<String, dynamic> reportObject = <String, dynamic>{
        "date": date,
        "site": site,
        "moi": moi,
        "truckNumber": truckNo,
        "reportId": reportId,
        "reporterUid": reporterUid,
        "reporterId": reporterId,
        "grainage": grainage,
        "data": dataGridData,
      };
      logger.i("Report Object: $reportObject");
      String? response = await reportRepo.addReport(reportObject);
      if (!mounted) return;
      NavigationService.goBack();
      if (response == null) {
        NavigationService.navigateTo(
          navigationMethod: NavigationMethod.pushReplacement,
          page: HomeScreen.id,
          isNamed: true,
        );
        showCustomFlushBar(
          context: context,
          message: "Report submitted successfully",
          icon: LineAwesomeIcons.check_circle,
        );
      } else {
        showCustomFlushBar(
          context: context,
          message: response,
          icon: LineAwesomeIcons.exclamation_circle,
          iconColor: Theme.of(context).colorScheme.error,
        );
      }
    } catch (e) {
      logger.e("Error: $e");
      NavigationService.goBack();
      showCustomFlushBar(
        context: context,
        message: "There was an error, please try again",
      );
    }
  }
}
