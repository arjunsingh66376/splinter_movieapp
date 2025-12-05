import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/firebase_function/firebasedb.dart';
import 'package:movies_app/utils/context_extension.dart';
import 'package:movies_app/widget/normalwidgets/premiumcard.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
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

        // ---- BACKGROUND IMAGE FIX (covers entire screen) ----
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/profilebg.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        // ---- USE LISTVIEW (NOT SingleChildScrollView) ----
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
                  return const Text("User data not found");
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                return Center(
                  child: Container(
                    width: screenw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('images/cardbgimage1.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListTile(
                          isThreeLine: true,
                          minVerticalPadding: 20,
                          minTileHeight: screenh * 0.3,

                          leading: Container(
                            width: screenw * 0.2,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('images/avatar.png'),
                              ),
                            ),
                          ),

                          title: Text(
                            data["name"] ?? "unknown",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {},

                                child: Text(
                                  'Free Plan',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
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

            // ---- PLANS GRID ----
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
                  buttonText: "Get Platinum for ₹299 ",
                  buttonColor: Colors.yellowAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
