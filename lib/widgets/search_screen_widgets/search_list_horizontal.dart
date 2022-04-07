import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:movieapp2/bloc/theme_bloc/theme_controller.dart';
import 'package:movieapp2/model/movie.dart';
import 'package:movieapp2/repositories/movie_repository.dart';

class SearchListHorizontal extends StatefulWidget {
  const SearchListHorizontal(
      {Key? key,
      required this.movies,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);

  final List<Movie> movies;
  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  State<SearchListHorizontal> createState() => _SearchListHorizontalState();
}

class _SearchListHorizontalState extends State<SearchListHorizontal> {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  // static List<String> getSuggestions1(String query) {
  //   List<String> matches = <String>[];
  //   matches.addAll(cities);
  //
  //   matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  //   return matches;
  // }
  Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future<void>.delayed(Duration(seconds: 1));
    // widget.movies.forEach((element) {
    //   Person p1 = Person(element.title, element.poster, element.id);
    //   people.add(p1);
    //   fruits.add(element.title);
    // });
    List<Map<String, String>> _map = [];
    for (var element in people) {
      _map.add({
        'name': element.name,
      });
    }
    for (var element in _map) {
      if (element.containsKey('name')) {
        if (element['name'].toString().contains(query)) {
          print('=========> ${element['name']}');
        }
      }
    }
    print('Person......$query...${_map}');
    return List.generate(people.length, (i) {
      return {
        'name': query + i.toString(),
        'image': Random().nextInt(100).toString()
      };
    });
  }

  var fruits = [];
  final people = <Person>[];
  Person? selectedPerson;

  final formKey = GlobalKey<FormState>();
  int id = 28;
  bool autovalidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();

  String? _selectedCity;
  void initState() {
    super.initState();
    print("TTTT  ${widget.movies.length}");

    widget.movies.forEach((element) {
      Person p1 = Person(element.title, element.poster, element.id);
      people.add(p1);
      fruits.add(element.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SizedBox(
        // height: 700.0,
        child: Column(
          children: [
            // Expanded(
            //   flex: 2,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: widget.movies.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 10.0, left: 8.0),
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => MovieDetailScreen(
            //                     themeController: widget.themeController,
            //                     movieRepository: widget.movieRepository,
            //                     movieId: widget.movies[index].id),
            //               ),
            //             );
            //           },
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: <Widget>[
            //               Container(
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(50.0)),
            //                 child: Stack(
            //                   children: [
            //                     Shimmer.fromColors(
            //                       baseColor: Colors.white,
            //                       highlightColor: Colors.white54,
            //                       enabled: true,
            //                       child: const SizedBox(
            //                         height: 160.0,
            //                         child: AspectRatio(
            //                             aspectRatio: 2 / 3,
            //                             child: Icon(
            //                               FontAwesome5.film,
            //                               color: Colors.black26,
            //                               size: 40.0,
            //                             )),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 160.0,
            //                       child: AspectRatio(
            //                           aspectRatio: 2 / 3,
            //                           child: ClipRRect(
            //                             borderRadius:
            //                                 BorderRadius.circular(5.0),
            //                             child: FadeInImage.memoryNetwork(
            //                                 fit: BoxFit.cover,
            //                                 placeholder: kTransparentImage,
            //                                 image:
            //                                     "https://image.tmdb.org/t/p/w300/" +
            //                                         widget
            //                                             .movies[index].poster),
            //                           )),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              flex: 8,
              child: Container(
                color: Colors.black45,
                height: 100,
                child: Builder(
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: this._formKey,
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          children: <Widget>[
                            Text('Tìm phim ?'),
                            TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                autofocus: true,
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(fontStyle: FontStyle.italic),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Phim?'),
                              ),
                              suggestionsCallback: (pattern) async {
                                return await getSuggestions(pattern);
                              },
                              itemBuilder:
                                  (context, Map<String, String> suggestion) {
                                return ListTile(
                                  leading: Icon(Icons.shopping_cart),
                                  title: Text(suggestion['name']!),
                                  subtitle: Text('\$${suggestion['image']}'),
                                );
                              },
                              onSuggestionSelected:
                                  (Map<String, String> suggestion) {
                                // Navigator.of(context).push<void>(MaterialPageRoute(
                                //     builder: (context) => ProductPage(product: suggestion)));
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            ElevatedButton(
                              child: Text('Tìm kiếm'),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    ),
                    // Form(
                    //   key: formKey,
                    //   autovalidateMode: autovalidate
                    //       ? AutovalidateMode.always
                    //       : AutovalidateMode.disabled,
                    //   child: SizedBox(
                    //     child: Column(children: <Widget>[
                    //       const SizedBox(height: 16.0),
                    //       Text('Chọn phim: "$selectedPerson"'),
                    //       const SizedBox(height: 16.0),
                    //       SimpleAutocompleteFormField<Person>(
                    //         itemFromString: (string) {
                    //           final matches = people.where((person) =>
                    //               person.name.toLowerCase() ==
                    //               string.toLowerCase());
                    //           return matches.isEmpty ? null : matches.first;
                    //         },
                    //         onTap: () {
                    //           print(
                    //               'SimpleAutocompleteFormFieldSimpleAutocompleteFormFieldSimpleAutocompleteFormField');
                    //         },
                    //         decoration: const InputDecoration(
                    //           labelText: 'Tên phim *',
                    //           border: OutlineInputBorder(),
                    //         ),
                    //         suggestionsHeight: 300.0,
                    //         itemBuilder: (context, person) {
                    //           return Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Container(
                    //                   decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(5.0)),
                    //                   height: 80.0,
                    //                   child: Stack(
                    //                     children: [
                    //                       Center(
                    //                         child: Shimmer.fromColors(
                    //                           baseColor: Colors.black87,
                    //                           highlightColor: Colors.white54,
                    //                           enabled: true,
                    //                           child: const SizedBox(
                    //                             height: 160.0,
                    //                             child: Icon(
                    //                               FontAwesome5.film,
                    //                               color: Colors.black26,
                    //                               size: 40.0,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 200.0,
                    //                         child: Column(
                    //                           children: [
                    //                             Expanded(
                    //                               child: ClipRRect(
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(
                    //                                         5.0),
                    //                                 child: FadeInImage.memoryNetwork(
                    //                                     fit: BoxFit.cover,
                    //                                     placeholder:
                    //                                         kTransparentImage,
                    //                                     image:
                    //                                         "https://image.tmdb.org/t/p/w300/" +
                    //                                             person!
                    //                                                 .address),
                    //                               ),
                    //                             ),
                    //                             const SizedBox(
                    //                               height: 10,
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 12,
                    //                 ),
                    //                 Text(person.name,
                    //                     style: const TextStyle(
                    //                         fontWeight: FontWeight.bold)),
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //         onSearch: (search) async {
                    //           print("search " + search);
                    //           return people
                    //               .where((person) => person.name
                    //                   .toLowerCase()
                    //                   .contains(search.toLowerCase()))
                    //               .toList();
                    //         },
                    //         onChanged: (value) {
                    //           print('onChangedonChangedonChanged .$value..');
                    //           setState(() => selectedPerson = value);
                    //         },
                    //         onSaved: (value) {
                    //           print('onSavedonSavedonSaved ...');
                    //           setState(() => selectedPerson = value);
                    //         },
                    //         validator: (person) => person == null
                    //             ? 'Không tìn thấy phim $person ! '
                    //             : null,
                    //       ),
                    //       const SizedBox(height: 16.0),
                    //       ElevatedButton(
                    //           child: const Text('Tìm kiếm'),
                    //           onPressed: () {
                    //             if (formKey.currentState?.validate() ?? false) {
                    //               formKey.currentState!.save();
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                   const SnackBar(
                    //                       content: Text('Không thành công!')));
                    //             } else {
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                   const SnackBar(
                    //                       content:
                    //                           Text('Khổng thể tìm kiếm.')));
                    //               setState(() => autovalidate = true);
                    //             }
                    //           })
                    //     ]),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Person {
  Person(this.name, this.address, this.id);

  final String name, address;
  final int id;

  @override
  String toString() => name;
}

// class BackendService {
//   static Future<List<Map<String, String>>> getSuggestions(String query) async {
//     await Future<void>.delayed(Duration(seconds: 1));
//     return List.generate(3, (index) {
//       return {
//         'name': query + index.toString(),
//         'image': Random().nextInt(100).toString()
//       };
//     });
//   }
// }
