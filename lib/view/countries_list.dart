import 'package:covid_tracker/services/states_services.dart';
import 'package:covid_tracker/view/countries_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          FutureBuilder(
            future: StatesServices().getApi1(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      String country = snapshot.data![index]['country'];
                      if (controller.text.isEmpty) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['countryInfo']['flag'],
                            ),
                          ),
                          title: Text(data['country']),
                          subtitle: Text('Total Cases: ${data['cases']}'),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CountriesDetailsScreen(
                                    title: data['country'],
                                    image: data['countryInfo']['flag'],
                                    cases: data['cases'],
                                    deaths: data['deaths'],
                                    recovered: data['recovered'],
                                    active: data['active'],
                                    critical: data['critical'],
                                    tests: data['tests'],
                                    population: data['population'],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 26,
                            ),
                          ),
                        );
                      } else if (country
                          .toLowerCase()
                          .contains(controller.text.toLowerCase())) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              data['countryInfo']['flag'],
                            ),
                          ),
                          title: Text(data['country']),
                          subtitle: Text('Total Cases: ${data['cases']}'),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CountriesDetailsScreen(
                                    title: data['country'],
                                    image: data['countryInfo']['flag'],
                                    cases: data['cases'],
                                    deaths: data['deaths'],
                                    recovered: data['recovered'],
                                    active: data['active'],
                                    critical: data['critical'],
                                    tests: data['tests'],
                                    population: data['population'],
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              size: 26,
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
