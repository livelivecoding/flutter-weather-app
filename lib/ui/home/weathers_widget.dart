import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherflut/model/city.dart';
import 'package:weatherflut/ui/home/weather_details_widget.dart';
import 'package:weatherflut/ui/ui_constants.dart';

DateFormat format = DateFormat('E, dd MMM yyyy');

class WeathersWidget extends StatefulWidget {
  final List<City> cities;
  final VoidCallback onTap;

  const WeathersWidget({
    Key key,
    this.cities,
    this.onTap,
  }) : super(key: key);

  @override
  _WeathersWidgetState createState() => _WeathersWidgetState();
}

class _WeathersWidgetState extends State<WeathersWidget> {
  double page = 0.0;
  final controller = PageController();

  void onListener() {
    setState(() {
      page = controller.page;
    });
  }

  @override
  void initState() {
    controller.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(onListener);
    controller.dispose();
    super.dispose();
  }

  void handleArrowPressed(City city) {
    showBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            40.0,
          ),
        ),
      ),
      builder: (_) {
        return WeatherDetailsWidget(city: city);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const ClampingScrollPhysics(),
          controller: controller,
          itemCount: widget.cities.length,
          itemBuilder: (context, index) {
            final city = widget.cities[index];
            double opacity = (index - page).abs();
            opacity = lerpDouble(1.0, 0.7, opacity);
            if (opacity > 1) opacity = 1;
            return Opacity(
              opacity: opacity,
              child: WeatherItem(
                city: city,
                onTap: () => handleArrowPressed(city),
              ),
            );
          },
        ),
        Positioned(
          left: 20,
          top: 20,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: widget.onTap,
          ),
        ),
      ],
    );
  }
}

class WeatherItem extends StatelessWidget {
  final City city;
  final VoidCallback onTap;

  const WeatherItem({
    Key key,
    this.city,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = city.weathers.first;
    final background = weather.weatherStateAbbr;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/background_states/$background.jpg',
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                city.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: shadows,
                ),
              ),
              Text(
                format.format(weather.applicableDate),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  shadows: shadows,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      weather.theTemp.toInt().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        shadows: shadows,
                        fontSize: 70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            shadows: shadows,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                weather.weatherStateName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  shadows: shadows,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
