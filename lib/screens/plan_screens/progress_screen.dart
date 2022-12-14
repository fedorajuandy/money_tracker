import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/models/new_progress.dart';
import 'package:money_tracker/operations/progress_operation.dart';
import 'package:money_tracker/screens/plan_screens/update_progress_screen.dart';
import 'package:money_tracker/widgets/title.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({Key? key, required this.planKey}) : super(key: key);
  final String planKey;

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late ProgressOperation progressOperation;

  @override
  void initState() {
    super.initState();
    progressOperation = ProgressOperation(widget.planKey);

    WidgetsBinding.instance.addPostFrameCallback((_){
      fal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: screen(),
    );
  }

  Widget screen() {
    return Column(
      children: <Widget>[
        // header
        Container(
          decoration: BoxDecoration(
            color: dark.withOpacity(0.05),
            boxShadow: [
              BoxShadow(
                color: dark.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 24, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        titleWithBack("Progress history", context),
                        sbw8(),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: addProgressButton(widget.planKey),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                sbh24(),
              ],
            ),
          ),
        ),
        // main screen
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                fal(),
              ],
            ),
          ),
        ),
        sbh40(),
      ],
    );
  }

  Widget fal() {
    return FirebaseAnimatedList(
      query: progressOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final progress = NewProgress.fromJson(json);

        if (progress.getParentKey() == widget.planKey) {
          return progressList(snapshot.key, progress.getActiveType(), progress.getAmount(), progress.getDatetime());
        } else {
          return Container();
        }
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget addProgressButton(String? key) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Add progress",
        style: TextStyle(
          color: white,
          fontSize: 14,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => UpdateProgressScreen(planKey: key ?? "")),
        );
      },
    );
  }

  Widget progressList(String? key, int type, double amount, String datetime) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: dark.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3,
                  ),
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // upper part (datetime added)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          datetime,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: dark.withOpacity(0.6)),
                        ),
                      ],
                    ),
                    sbh12(),
                    // progress amount (green = positive (addition) red = negative (subtraction))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              CurrencyFormat.convertToIdr(amount, 2),
                              style: TextStyle(
                                color: type == 1 ? redSecondary : secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
