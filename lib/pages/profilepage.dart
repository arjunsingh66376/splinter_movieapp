import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/api/api_service/tmdb_service.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';
import 'package:movies_app/model/movie.dart';
import 'package:movies_app/utils/context_extension.dart';
import 'package:movies_app/widget/apiwidgets/upcoming.dart';
import 'package:movies_app/widget/normalwidgets/premiumcard.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late Future<List<Movie>> upcoming;

  @override
  void initState() {
    upcoming = TmdbService().getupcoming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenh = context.h;
    final screenw = context.w;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'profile',
          style: TextStyle(fontFamily: 'pdark', color: Colors.red),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/profilebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            StreamBuilder(
              stream: Firebasedb().getuserinfo(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(
                    child: Text(
                      "User data not found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),

                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: screenw * 0.7,

                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),

                        child: ListTile(
                          isThreeLine: true,

                          leading: Container(
                            width: screenw * 0.2,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('images/avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          title: Text(
                            data["name"] ?? "unknown",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['email'] ?? 'unknownemail',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.merriweather(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Free Plan',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ---------------- PREMIUM PLANS -----------------
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.62,
              children: const [
                PremiumCard(
                  planName: "Standard",
                  priceInfo: "₹99 for 3 months",
                  afterPrice: "₹199/month after",
                  features: [
                    "1 Standard account",
                    "Download offline",
                    "High audio quality",
                    "Cancel anytime",
                  ],
                  buttonText: "Try 3 months for ₹99",
                  buttonColor: Color(0xff1ed760),
                ),
                PremiumCard(
                  planName: "Platinum",
                  priceInfo: "₹299 / month",
                  afterPrice: "",
                  features: [
                    "3 accounts",
                    "Lossless audio",
                    "AI DJ",
                    "Mix playlists",
                  ],
                  buttonText: "Get Platinum for ₹299",
                  buttonColor: Colors.yellowAccent,
                ),
              ],
            ),

            SizedBox(height: 30),
            Text(
              'Upcoming',
              style: TextStyle(
                fontFamily: 'pdark',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Upcoming(future: upcoming),
          ],
        ),
      ),
    );
  }
}
