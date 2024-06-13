import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) : markers = [];

  List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    markers.add(
      const Marker(
        height: 30,
        width: 30,
        point: LatLng(-30.776, -51.3594),
        child: Icon(Icons.pin_drop),
      ),
    );

    markers.add(
      const Marker(
        height: 30,
        width: 30,
        point: LatLng(-31.776, -51.3594),
        child: Icon(Icons.pin_drop),
      ),
    );

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Abrigos de animais próximos a você'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(-31.776, -52.3594),
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
            maxClusterRadius: 45,
            size: const Size(40, 40),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50),
            maxZoom: 15,
            markers: markers,
            builder: (context, markers) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: Center(
                  child: Text(
                    markers.length.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          )),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
