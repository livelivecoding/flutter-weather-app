import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/model/city.dart';
import 'package:weatherflut/ui/cities/add/add_city_page.dart';
import 'package:weatherflut/ui/cities/cities_bloc.dart';
import 'package:weatherflut/ui/common/header_widget.dart';
import 'package:weatherflut/ui/ui_constants.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  CitiesBloc bloc;

  void handleDeleteTap(City city) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: AlertDialog(
          title: Text('Confirmación'),
          content: Text('Seguro que desea eliminar la ciudad ${city.title}?'),
          actions: <Widget>[
            OutlineButton(
              child: Text('NO'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            OutlineButton(
              child: Text('SI'),
              onPressed: () => Navigator.of(context).pop(true),
            )
          ],
        ),
      ),
    );
    if (result) {
      bloc.deleteCity(city);
    }
  }

  @override
  void initState() {
    bloc = CitiesBloc(
      storage: context.read<StoreRepository>(),
    );
    bloc.loadCities();
    super.initState();
  }

  void handleNavigatePress(BuildContext context) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(
          milliseconds: 400,
        ),
        pageBuilder: (_, animation1, animation2) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(animation1),
            child: AddCityPage(),
          );
        },
      ),
    );
    bloc.loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: primaryColor,
            onPressed: () => handleNavigatePress(context),
          ),
          body: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderWidget(
                  title: 'Mis ciudades',
                ),
                Expanded(
                  child: bloc.cities.isEmpty
                      ? Center(
                          child: Text('No tienes ciudades :('),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          itemCount: bloc.cities.length,
                          itemBuilder: (context, index) {
                            final city = bloc.cities[index];
                            return CityItem(
                              city: city,
                              onTap: () => handleDeleteTap(city),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CityItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const CityItem({
    Key key,
    this.city,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              city.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
