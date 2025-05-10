import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../widgets/custome_footer.dart';
import 'package:Kdru_Guide_app/header.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // CustomHeader is not wrapped inside Directionality, so it remains LTR
          const CustomHeader(
            userName: 'Guest User',
            bannerImagePath: 'images/kdr_logo.png',
            fullText: 'د کند هار پوهنتون ته شه راغلاست',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeroSection(context, screenWidth),
                  _buildKandaharUniversityInfoSection(),
                  _buildMapSection(),
                  _buildWelcomeSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'images/kdr_logo.png',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildKandaharUniversityInfoSection() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1607237138185-eedd9c632b0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=2000&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black54,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'کندهار پوهنتون',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'pashto'),
              ),
              SizedBox(height: 8),
              Text(
                'کندهار پوهنتون د افغانستان په سویلي ولایت کندهار کې یو دولتي پوهنتون دی، چې په ۱۳۶۹ لمریز کال (۱۹۹۰ میلادي) د وخت د حکومت لخوا د کرنې پوهنځي په پرانیستلو سره تأسیس شو',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18, color: Colors.white, fontFamily: 'pashto'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(8.0),
      child: FlutterMap(
        options: const MapOptions(
          center: LatLng(31.6107, 65.6910), // Kandahar University coordinates
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          const MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(31.6107, 65.6910),
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(32.0),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.blue[100]!],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }
}
