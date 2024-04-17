import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportDataSource extends DataGridSource {
  ReportDataSource(this.reportRows) {
    dataGridRows = reportRows
        .map<DataGridRow>(
          (ReportRow dataGridRow) => dataGridRow.getDataGridRow(),
        )
        .toList();
  }

  List<ReportRow> reportRows = <ReportRow>[];
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  /// Helps to hold the new value of all editable widget.
  /// Based on the new value we will commit the new value into the corresponding
  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return Future<void>.value();
    }

    if (column.columnName == 'coumn_1') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<int>(
        columnName: 'column_1',
        value: newCellValue,
      );
      reportRows[dataRowIndex].column1 = newCellValue.toString();
    } else if (column.columnName == 'column_2') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(
        columnName: 'column_2',
        value: newCellValue,
      );
      reportRows[dataRowIndex].column2 = newCellValue.toString();
    } else if (column.columnName == 'column_3') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(
        columnName: 'column_3',
        value: newCellValue,
      );
      reportRows[dataRowIndex].column3 = newCellValue.toString();
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell<String>(
        columnName: 'column_4',
        value: newCellValue,
      );
      reportRows[dataRowIndex].column4 = newCellValue.toString();
    }
    return Future<void>.value();
  }

  @override
  Future<bool> canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) {
    // Return false, to retain in edit mode.
    return Future<bool>.value(true); // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(
    DataGridRow dataGridRow,
    RowColumnIndex rowColumnIndex,
    GridColumn column,
    CellSubmit submitCell,
  ) {
    /// Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    final bool isNumericType = column.columnName == 'column_3' || column.columnName == 'column_4';

    /// The new cell value must be reset.
    /// To avoid committing the [DataGridCell] value that was previously edited
    /// into the current non-modified [DataGridCell].
    newCellValue = null;
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 6.0.h),
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0.h),
        ),
        keyboardType: TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = double.tryParse(value).toString();
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          /// In Mobile Platform.
          /// Call [CellSubmit] callback to fire the canSubmitCell and
          /// onCellSubmit to commit the new value in single place.
          submitCell();
        },
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((DataGridCell<dynamic> dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          height: 55.0.h,
          padding: EdgeInsets.symmetric(
            horizontal: 5.0.w,
            vertical: 6.0.h,
          ),
          child: AutoSizeText(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 500,
          ),
        );
      }).toList(),
    );
  }
}

class ReportRow {
  ReportRow({
    required this.column1,
    required this.column2,
    required this.column3,
    required this.column4,
  });

  String column1;
  String column2;
  String column3;
  String column4;

  DataGridRow getDataGridRow() {
    return DataGridRow(cells: <DataGridCell>[
      DataGridCell<String>(columnName: 'column_1', value: column1),
      DataGridCell<String>(columnName: 'column_2', value: column2),
      DataGridCell<String>(columnName: 'column_3', value: column3),
      DataGridCell<String>(columnName: 'column_3', value: column4),
    ]);
  }

  // from json
  factory ReportRow.fromJson(Map<String, dynamic> json) {
    return ReportRow(
      column1: json['column1'] as String,
      column2: json['column2'] as String,
      column3: json['column3'] as String,
      column4: json['column4'] as String,
    );
  }
}
