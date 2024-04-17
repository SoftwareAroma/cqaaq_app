import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cqaaq_app/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportRepo {
  static final ReportRepo _instance = ReportRepo();
  static ReportRepo get instance => _instance;

  final FirebaseCaller _firebaseCaller = FirebaseCaller.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// add report to firebase
  Future<String?> addReport(Map<String, dynamic> reportData) async {
    try {
      String resp = await _firebaseCaller.addDataToCollection(
        path: FirestorePaths.reportsCollection,
        data: reportData,
      );
      logger.i('Report added successfully with id: $resp');
      // update the report with the id
      await _firebaseCaller.updateData(
        path: FirestorePaths.reportDocument(resp),
        data: {
          'id': resp,
        },
      );
      // update user reports with the id
      await _firebaseCaller.updateData(
        path: FirestorePaths.userDocument(_auth.currentUser!.uid),
        data: {
          'reports': FieldValue.arrayUnion([resp]),
        },
      );
      return null;
    } catch (e) {
      logger.e('Error adding report: $e');
      // remove [**] and return the error message
      String error = e.toString().replaceAll(RegExp(r'\[.*\]'), '');
      return error;
    }
  }

  /// get all reports from firebase
  Future<List<ReportModel>> getReports() async {
    try {
      return await _firebaseCaller.getCollectionData(
        path: FirestorePaths.reportsCollection,
        builder: (List<QueryDocumentSnapshot<Map<String, dynamic>>>? data) async {
          if (data != null) {
            // logger.i('Data >>>> ::: $data');
            List<ReportModel> reports = <ReportModel>[];
            for (QueryDocumentSnapshot<Map<String, dynamic>> document in data) {
              Map<String, dynamic> dataObject = document.data();
              Timestamp timestamp = dataObject['date'] as Timestamp;

              /// convert date to string
              dataObject['date'] = timestamp.toDate().toString();
              ReportModel reportModel = ReportModel.fromJson(dataObject);
              // logger.i('Report >>>> ::: ${reportModel.toJson()}');
              reports.add(reportModel);
            }
            return reports;
          }
          return [];
        },
      );
    } catch (e) {
      logger.e('Error getting reports: $e');
      rethrow;
    }
  }

  // get user reports
  Future<List<ReportModel>> getUserReports() async {
    try {
      List<ReportModel> reports = [];
      var _ = await _firebaseCaller.getCollectionData(
        path: FirestorePaths.reportsCollection,
        queryBuilder: (Query<Map<String, dynamic>> query) {
          return query.where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
        },
        builder: (List<QueryDocumentSnapshot<Map<String, dynamic>>>? data) async {
          if (data != null) {
            List<ReportModel> reports = <ReportModel>[];
            for (QueryDocumentSnapshot<Map<String, dynamic>> document in data) {
              Map<String, dynamic> dataObject = document.data();
              Timestamp timestamp = dataObject['date'] as Timestamp;

              /// convert date to string
              dataObject['date'] = timestamp.toDate().toString();
              ReportModel reportModel = ReportModel.fromJson(dataObject);
              logger.i('Report >>>> ::: ${reportModel.toJson()}');
              reports.add(reportModel);
            }
            return reports;
          }
        },
      );
      return reports;
    } catch (e) {
      logger.e('Error getting user reports: $e');
      rethrow;
    }
  }

  // get a report
  Future<ReportModel?> getReport(String reportId) async {
    try {
      Map<String, dynamic>? data = await _firebaseCaller.getData(
        path: FirestorePaths.reportDocument(reportId),
        builder: (data, documentId) => data,
      );
      if (data != null) {
        // logger.i('Data >>>> ::: $data');
        Map<String, dynamic> dataObject = data;
        Timestamp timestamp = dataObject['date'] as Timestamp;

        /// convert date to string
        dataObject['date'] = timestamp.toDate().toString();
        ReportModel reportModel = ReportModel.fromJson(dataObject);
        // logger.i('Report >>>> ::: ${reportModel.toJson()}');
        return reportModel;
      }
      return null;
    } catch (e) {
      logger.e('Error getting report: $e');
      rethrow;
    }
  }

  // update report in firebase
  Future<void> updateReport(String reportId, Map<String, dynamic> reportData) async {
    try {
      await _firebaseCaller.updateData(
        path: FirestorePaths.reportDocument(reportId),
        data: reportData,
      );
      logger.i('Report updated successfully');
    } catch (e) {
      logger.e('Error updating report: $e');
      rethrow;
    }
  }

  // delete report from firebase
  Future<void> deleteReport(String reportId) async {
    try {
      await _firebaseCaller.deleteData(
        path: FirestorePaths.reportDocument(reportId),
      );
      logger.i('Report deleted successfully');
    } catch (e) {
      logger.e('Error deleting report: $e');
      rethrow;
    }
  }
}
