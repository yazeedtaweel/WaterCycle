import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/helpers/shared_pref_helper.dart';
import 'package:water_cycle_android/services/main_drawer.dart';
import 'package:water_cycle_android/services/time_helper.dart';

import '../providers/regions_provider.dart';
import 'package:intl/intl.dart';
class SuggestionsList extends StatefulWidget {
  static const routeName = 'suggestions_list';

  const SuggestionsList({Key? key}) : super(key: key);

  @override
  State<SuggestionsList> createState() => _SuggestionsListState();
}

class _SuggestionsListState extends State<SuggestionsList> {
  // final _controller = StreamController<SwipeRefreshState>.broadcast();
  _SuggestionsListState();
  @override
  void initState() {
    super.initState();
    Provider.of<RegionsProvider>(context, listen: false)
        .getfeedbackFromFirestore();
  }
  Future<bool> isFavouriteItem(String id) async{
    return await preferences.getBool(id, false);
  }
  Future refresh () async {
    Completer<Null> completer = new Completer<Null>();

    await Future.delayed(Duration(seconds: 3)).then((onvalue) {
      completer.complete();
      setState(() {
        Provider.of<RegionsProvider>(context, listen: false)
            .getfeedbackFromFirestore();
      });
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('الاقتراحات والشكاوي'),
        backgroundColor: Colors.teal,

      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Consumer<RegionsProvider>(
          builder: (context, provider, x) {
            return provider.feedback == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: provider.feedback.length,
                itemBuilder: (context, index) {
                  String? feedbackText = provider.feedback[index].feedback;
                  String? phoneNum = provider.feedback[index].phoneNum;
                  DateTime? date =  TimestampConverter.timestampConverter.TimeStampToDateTime(provider.feedback[index].timestamp??Timestamp.now());
                  return Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: Text(feedbackText ?? "error"),
                          subtitle: Text(phoneNum??""),
                          trailing:
                          Text(DateFormat('yyyy-MM-dd – kk:mm').format(date) ?? Timestamp.now().toString(),
                          style: const TextStyle(
                            fontSize: 10
                          ),)
                        ),
                        // horizontalTitleGap: 80.0,
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );

  }

}
