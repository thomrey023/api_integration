import 'dart:convert';

import 'package:api_integration/core/models/university_model.dart';
import 'package:api_integration/utilities/constants/themes_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversityListScreen extends StatefulWidget {
  const UniversityListScreen({super.key});

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  List<UniversityModel> universities = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final res = await http.get(Uri.parse(
        'http://universities.hipolabs.com/search?country=Philippines'));

    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      universities = data.map((uni) {
        return UniversityModel.fromMap(uni);
      }).toList();

      setState(() {});
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CColors.trueWhite,
        appBar: AppBar(
          elevation: 0,
        ),
        body: universities.isEmpty
            ? const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                color: CColors.trueWhite,
                child: ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final university = universities[index];
                    return Container(
                      height: 100.0,
                      color:
                          (index % 2 == 0 ? Colors.grey[350] : CColors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          children: [
                            Text(
                              'Name: ${university.name}',
                              textAlign: TextAlign.center,
                            ),
                            Text(university.stateProvince.toString() != 'null'
                                ? 'Province: ${university.stateProvince}'
                                : 'Province:'),
                            Text(university.domain.toString() != 'null'
                                ? 'Domain: ${university.domain}'
                                : 'Domain:'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
