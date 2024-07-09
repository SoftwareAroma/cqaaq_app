import "package:auto_size_text/auto_size_text.dart";
import "package:cqaaq_app/index.dart";
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:form_builder_validators/form_builder_validators.dart";
import "package:gap/gap.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_awesome_flutter/line_awesome_flutter.dart";

class WorkHistoryScreen extends StatefulWidget {
  static const String id = "work_history";
  const WorkHistoryScreen({super.key});

  @override
  State<WorkHistoryScreen> createState() => _WorkHistoryScreenState();
}

class _WorkHistoryScreenState extends State<WorkHistoryScreen> {
  Widget get _space => Gap(10.0.h);
  bool isLoading = true;

  @override
  void initState() {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: StringResource.workHistoryText,
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
      fab: FloatingActionButton(
        onPressed: () => openAddHistory(),
        child: const Icon(LineAwesomeIcons.plus),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12.0.w,
            vertical: 5.0.h,
          ),
          child: Column(
            children: <Widget>[
              if (userController.user!.history.isEmpty)
                Container(
                  padding: EdgeInsets.all(10.0.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2.0.r),
                  ),
                  child: AutoSizeText(
                    "No work history",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    WorkHistoryModel history = userController.user!.history[index];
                    String endDate = history.stillWorking ? "Current" : history.endDate ?? "";
                    return WorkHistoryTile(
                      company: history.company,
                      position: history.position,
                      startDate: history.startDate.split(" ")[0],
                      endDate: endDate.split(" ")[0],
                    );
                  },
                  separatorBuilder: (context, index) => _space,
                  itemCount: userController.user?.history.length ?? 0,
                ),
              ),

              /// space bottom
              _space,
            ],
          ),
        ),
      ),
    );
  }

  // add work history popup
  openAddHistory() {
    GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
    onSubmit(GlobalKey<FormBuilderState> fbKey) async {
      if (!fbKey.currentState!.saveAndValidate()) {
        showCustomFlushBar(
          context: context,
          message: "Fill all required fields",
        );
        return;
      }
      FocusScope.of(context).unfocus();
      showLoading(context);
      Map<String, dynamic> data = {
        "company": fbKey.currentState!.fields["company"]?.value ?? "",
        "position": fbKey.currentState!.fields["position"]?.value ?? "",
        "startDate": fbKey.currentState!.fields["startDate"]?.value.toString(),
        "stillWorking": fbKey.currentState!.fields["stillWorking"]?.value ?? false,
        "endDate": fbKey.currentState!.fields["endDate"]?.value.toString(),
      };
      WorkHistoryModel dataModel = WorkHistoryModel.fromJson(data);
      // logger.i(dataModel.toJson());
      bool isDone = await userController.addWorkHistory(dataModel);
      if (!mounted) return;
      if (isDone) {
        Navigator.pop(context);
        Navigator.pop(context);
        showCustomFlushBar(context: context, message: "History Added");
      } else {
        Navigator.pop(context);
        showCustomFlushBar(context: context, message: "Error adding history");
      }
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Work History"),
          content: Container(
            height: 280.0.h,
            width: 360.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            child: FormBuilder(
              key: fbKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      name: "company",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "Company",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    _space,
                    FormBuilderTextField(
                      name: "position",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "Position",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    _space,
                    FormBuilderDateTimePicker(
                      name: "startDate",
                      inputType: InputType.date,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: "Start Date",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                    Gap(5.0.h),
                    FormBuilderCheckbox(
                      name: "stillWorking",
                      title: Text(
                        "Still Works here",
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                    _space,
                    FormBuilderDateTimePicker(
                      name: "endDate",
                      inputType: InputType.date,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: "End Date",
                      ),
                      validator: FormBuilderValidators.compose([]),
                    ),
                    _space,
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.error,
                ),
              ),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
            TextButton(
              onPressed: () => onSubmit(fbKey),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                "Add",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class WorkHistoryTile extends StatelessWidget {
  final String company;
  final String position;
  final String startDate;
  final String endDate;
  const WorkHistoryTile({
    super.key,
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AutoSizeText(
        company.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w900,
          fontSize: 14.0.sp,
        ),
      ),
      subtitle: AutoSizeText(
        position.toUpperCase(),
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(),
      ),
      trailing: AutoSizeText(
        "$startDate - $endDate",
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(),
      ),
    );
  }
}
