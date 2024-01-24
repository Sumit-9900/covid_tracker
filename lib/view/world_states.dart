import 'package:covid_tracker/services/states_services.dart';
import 'package:covid_tracker/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final colorlist = [
    const Color(0xffde5246),
    const Color(0xff4285F4),
    const Color(0xff1aa260),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
              future: StatesServices().getApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        PieChart(
                          dataMap: {
                            'Total': snapshot.data!.cases!.toDouble(),
                            'Recovered': snapshot.data!.recovered!.toDouble(),
                            'Deaths': snapshot.data!.deaths!.toDouble(),
                          },
                          // chartType: ChartType.ring,
                          // legendOptions: LegendOptions(
                          //   legendPosition: LegendPosition.left,
                          // ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          animationDuration: const Duration(milliseconds: 1800),
                          colorList: colorlist,
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                  title: 'Total',
                                  details: snapshot.data!.cases.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Recovered',
                                  details: snapshot.data!.recovered.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Deaths',
                                  details: snapshot.data!.deaths.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Active',
                                  details: snapshot.data!.active.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Critical',
                                  details: snapshot.data!.critical.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Today Cases',
                                  details: snapshot.data!.todayCases.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Today Recovered',
                                  details:
                                      snapshot.data!.todayRecovered.toString(),
                                ),
                                const Divider(),
                                ReusableRow(
                                  title: 'Today Deaths',
                                  details:
                                      snapshot.data!.todayDeaths.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CountriesListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      controller: controller,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({
    super.key,
    required this.title,
    required this.details,
  });

  final String title;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(details),
        ],
      ),
    );
  }
}
