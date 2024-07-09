import 'package:cqaaq_app/index.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  static final ReportsController _instance = Get.find();
  static ReportsController get instance => _instance;

  final RxList<ReportModel> _reports = <ReportModel>[].obs;

  fetchReports() async {
    List<ReportModel> reports = await reportRepo.getReports();
    // logger.i("reports >>> $reports");
    updateReports(reports);
  }

  updateReports(List<ReportModel> reports) {
    _reports.clear();
    _reports.addAll(reports);
    update();
  }

  searchReports(String query) {
    if (query.isEmpty) {
      fetchReports();
      return;
    }
    List<ReportModel> searchResults = _reports
        .where((ReportModel report) => report.site.toLowerCase().contains(
              query.toLowerCase(),
            ))
        .toList();
    if (searchResults.isNotEmpty) {
      updateReports(searchResults);
    } else {
      fetchReports();
    }
  }

  clearReports() {
    _reports.clear();
    update();
  }

  List<ReportModel> get reports => _reports;
}
