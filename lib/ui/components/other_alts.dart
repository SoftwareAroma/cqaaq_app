// // /// [Key] for [EditableState]
// // final GlobalKey<EditableState> _editableKey = GlobalKey<EditableState>();

// // List rows = const <Map<String, dynamic>>[
// //   {
// //     "commodity": 'NUT VOID',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'NUT SPOTTED',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'NUT IMATURE',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'NUT OIL SEEDS',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'NUT DISEASED',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'TOTAL NUTS WITH DEFECTS',
// //     "tonnage": 'T1',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '50% SPOTTED',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '50% IMMATURE',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'TOTAL NUTS WITH DEFECTS',
// //     "tonnage": 'T2',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '',
// //     "tonnage": 'Gms',
// //     "total_pods": 'Gbs',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '100% SHELLED GOOD KERNELS',
// //     "tonnage": 'K1',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '50% OF THE SHELLED SPOTTED KERNELS',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '50% OF THE SHELLED IMMATURE KERNELS',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'OVERALL OUTPUT (KOR7)',
// //     "tonnage": '',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": 'OBSERVATION',
// //     "tonnage": 'LBA',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '',
// //     "tonnage": 'ORIGIN',
// //     "total_pods": 'GHANA',
// //     "total_percentage": '',
// //   },
// //   {
// //     "commodity": '',
// //     "tonnage": 'ANALYSER',
// //     "total_pods": '',
// //     "total_percentage": '',
// //   },
// // ];

// // List cols = const <Map<String, dynamic>>[
// //   {"title": 'COMMODITY', 'key': 'commodity', 'editable': false},
// //   {"title": 'TONNAGE', 'key': 'tonnage'},
// //   {"title": 'TOTAL PODS (GRAMME)', 'key': 'total_pods'},
// //   {"title": 'TOTAL PERCENTAGE (%)', 'key': 'total_percentage'},
// // ];

// // /// Function to add a new row
// // /// Using the global key assigined to Editable widget
// // /// Access the current state of Editable
// // void _addNewRow() {
// //   setState(() {
// //     _editableKey.currentState?.createRow();
// //   });
// // }

// // Container(
// //   padding: EdgeInsets.symmetric(
// //     horizontal: 3.0.w,
// //     vertical: 2.0.h,
// //   ),
// //   decoration: BoxDecoration(
// //     borderRadius: BorderRadius.circular(10.0.r),
// //     border: Border.all(
// //       color: Theme.of(context).colorScheme.primary,
// //       width: 1.0.w,
// //     ),
// //   ),
// //   child: Column(
// //     children: <Widget>[
// //       Gap(5.0.h),
// //       InkWell(
// //         onTap: () => _addNewRow(),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: <Widget>[
// //             _space,
// //             Container(
// //               padding: EdgeInsets.all(5.0.w),
// //               decoration: BoxDecoration(
// //                 color: Theme.of(context).colorScheme.background,
// //                 borderRadius: BorderRadius.circular(5.0.r),
// //                 boxShadow: const <BoxShadow>[
// //                   BoxShadow(
// //                     color: Colors.black12,
// //                     blurRadius: 5.0,
// //                     spreadRadius: 2.0,
// //                     offset: Offset(0.0, 2.0),
// //                   ),
// //                 ],
// //               ),
// //               child: Icon(
// //                 LineAwesomeIcons.plus,
// //                 color: Theme.of(context).colorScheme.primary,
// //               ),
// //             ),
// //             _space,
// //             _space,
// //             CustomText(
// //               "Add New Row".toUpperCase(),
// //               color: Theme.of(context).colorScheme.primary,
// //               fontWeight: FontWeight.bold,
// //               fontSize: 14.0.sp,
// //             ),
// //           ],
// //         ),
// //       ),
// //       Expanded(
// //         child: Editable(
// //           key: _editableKey,
// //           columns: cols,
// //           rows: rows,
// //           zebraStripe: true,
// //           columnRatio: 0.4,
// //           saveIcon: LineAwesomeIcons.save,
// //           stripeColor1: Colors.grey[50]!,
// //           stripeColor2: Colors.grey[200]!,
// //           onRowSaved: (dynamic value) {
// //             logger.i(value);
// //           },
// //           onSubmitted: (String value) {
// //             logger.i(value);
// //           },
// //           borderColor: Theme.of(context).colorScheme.primary,
// //           tdStyle: GoogleFonts.poppins(
// //             fontWeight: FontWeight.normal,
// //           ),
// //           trHeight: 80.0.h,
// //           thStyle: GoogleFonts.poppins(
// //             fontSize: 10.0.sp,
// //             fontWeight: FontWeight.w900,
// //             letterSpacing: 1.2,
// //             color: Theme.of(context).colorScheme.primary,
// //           ),
// //           thAlignment: TextAlign.start,
// //           thVertAlignment: CrossAxisAlignment.end,
// //           thPaddingBottom: 2.0.w,
// //           showSaveIcon: true,
// //           saveIconColor: Theme.of(context).colorScheme.primary,
// //           showCreateButton: false,
// //           createButtonIcon: null,
// //           tdAlignment: TextAlign.center,
// //           tdEditableMaxLines: 500, // don't limit and allow data to wrap
// //           tdPaddingTop: 5.0.h,
// //           tdPaddingBottom: 5.0.h,
// //           tdPaddingLeft: 5.0.w,
// //           tdPaddingRight: 5.0.w,
// //           focusedBorder: OutlineInputBorder(
// //             borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
// //             borderRadius: BorderRadius.all(
// //               Radius.circular(0.0.r),
// //             ),
// //           ),
// //         ),
// //       ),
// //     ],
// //   ),
// // ),

// import 'package:flutter/material.dart';
// import 'package:get/utils.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// class SampleWidget extends StatefulWidget {
//   const SampleWidget({super.key});

//   @override
//   State<SampleWidget> createState() => _SampleWidgetState();
// }

// class _SampleWidgetState extends State<SampleWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SfDataGrid(
//             source: _employeeDataSource,
//             allowEditing: true,
//             selectionMode: SelectionMode.single,
//             navigationMode: GridNavigationMode.cell,
//             columns: [
//           GridColumn(
//               columnName: 'id',
//               label: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'ID',
//                     overflow: TextOverflow.ellipsis,
//                   ))),
//           GridColumn(
//               columnName: 'name',
//               label: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Name',
//                     overflow: TextOverflow.ellipsis,
//                   ))),
//           GridColumn(
//               columnName: 'designation',
//               label: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'Designation',
//                     overflow: TextOverflow.ellipsis,
//                   ))),
//           GridColumn(
//               columnName: 'salary',
//               label: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'Salary',
//                     overflow: TextOverflow.ellipsis,
//                   ))),
//         ]));
//   }
// }

// class EmployeeDataSource extends DataGridSource {
//   /// Helps to hold the new value of all editable widgets.
//   /// Based on the new value we will commit the new value into the corresponding
//   /// DataGridCell on the onCellSubmit method.
//   dynamic newCellValue;

//   /// Helps to control the editable text in the [TextField] widget.
//   TextEditingController editingController = TextEditingController();

//   @override
//   Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
//     final dynamic oldValue = dataGridRow
//             .getCells()
//             .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
//             ?.value ??
//         '';

//     final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

//     if (newCellValue == null || oldValue == newCellValue) {
//       return Future<void>.value();
//     }

//     if (column.columnName == 'id') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<int>(columnName: 'id', value: newCellValue);
//       _employees[dataRowIndex].id = newCellValue as int;
//     } else if (column.columnName == 'name') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'name', value: newCellValue);
//       _employees[dataRowIndex].name = newCellValue.toString();
//     } else if (column.columnName == 'designation') {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<String>(columnName: 'designation', value: newCellValue);
//       _employees[dataRowIndex].designation = newCellValue.toString();
//     } else {
//       dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
//           DataGridCell<int>(columnName: 'salary', value: newCellValue);
//       _employees[dataRowIndex].salary = newCellValue as int;
//     }
//     return Future<void>.value();
//   }

//   @override
//   Widget? buildEditWidget(
//     DataGridRow dataGridRow,
//     RowColumnIndex rowColumnIndex,
//     GridColumn column,
//     CellSubmit submitCell,
//   ) {
//     // Text going to display on editable widget
//     final String displayText = dataGridRow
//             .getCells()
//             .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
//             ?.value
//             ?.toString() ??
//         '';

//     // The new cell value must be reset.
//     // To avoid committing the [DataGridCell] value that was previously edited
//     // into the current non-modified [DataGridCell].
//     newCellValue = null;

//     final bool isNumericType = column.columnName == 'id' || column.columnName == 'salary';

//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
//       child: TextField(
//         autofocus: true,
//         controller: editingController..text = displayText,
//         textAlign: isNumericType ? TextAlign.right : TextAlign.left,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
//         ),
//         keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
//         onChanged: (String value) {
//           if (value.isNotEmpty) {
//             if (isNumericType) {
//               newCellValue = int.parse(value);
//             } else {
//               newCellValue = value;
//             }
//           } else {
//             newCellValue = null;
//           }
//         },
//         onSubmitted: (String value) {
//           // In Mobile Platform.
//           // Call [CellSubmit] callback to fire the canSubmitCell and
//           // onCellSubmit to commit the new value in single place.
//           submitCell();
//         },
//       ),
//     );
//   }

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     throw UnimplementedError();
//   }
// }



