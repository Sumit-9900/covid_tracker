import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';

class CountriesDetailsScreen extends StatefulWidget {
  const CountriesDetailsScreen({
    super.key,
    required this.title,
    required this.image,
    required this.cases,
    required this.deaths,
    required this.recovered,
    required this.active,
    required this.critical,
    required this.tests,
    required this.population,
  });

  final String title;
  final String image;
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int critical;
  final int tests;
  final int population;

  @override
  State<CountriesDetailsScreen> createState() => _CountriesDetailsScreenState();
}

class _CountriesDetailsScreenState extends State<CountriesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 13),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 16),
                      ReusableRow(
                        title: 'Cases',
                        details: widget.cases.toString(),
                      ),
                      ReusableRow(
                        title: 'Deaths',
                        details: widget.deaths.toString(),
                      ),
                      ReusableRow(
                        title: 'Recovered',
                        details: widget.recovered.toString(),
                      ),
                      ReusableRow(
                        title: 'Active',
                        details: widget.active.toString(),
                      ),
                      ReusableRow(
                        title: 'Critical',
                        details: widget.critical.toString(),
                      ),
                      ReusableRow(
                        title: 'Tests',
                        details: widget.tests.toString(),
                      ),
                      ReusableRow(
                        title: 'Population',
                        details: widget.population.toString(),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  widget.image,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
