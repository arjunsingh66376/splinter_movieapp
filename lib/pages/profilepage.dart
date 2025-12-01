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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'profile',
          style: TextStyle(fontFamily: 'pdark', color: Colors.red),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: Firebasedb().getuserinfo(
                  FirebaseAuth.instance.currentUser!.uid,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text("User data not found");
                  }

                  final data = snapshot.data!.data() as Map<String, dynamic>;

                  return Center(
                    child: Container(
                      width: screenw * 0.8,
                      child: Material(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black54,
                        child: Center(
                          child: ListTile(
                            isThreeLine: true,
                            minVerticalPadding: 20,
                            minTileHeight: screenh * 0.3,
                            leading: Container(
                              width: screenw * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
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
                              style: GoogleFonts.merriweather(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
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
                                    color: Colors.grey,
                                  ),
                                ),

                                SizedBox(height: 5),
                                Text(
                                  'Free Plan',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 15,
                                    color: Colors.redAccent,
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

              SizedBox(height: 20),

              PremiumCard(
                planName: "Standard",
                priceInfo: "₹99 for 3 months",
                afterPrice: "₹199/month after",
                features: [
                  "1 Standard account",
                  "Download to listen offline",
                  "Very high audio quality (up to ~320kbps)",
                  "Cancel anytime",
                  "Subscribe or one-time payment",
                ],
                buttonText: "Try 3 months for ₹99",
                buttonColor: Color(0xff1ed760), // Spotify Green
              ),
              SizedBox(height: 20),

              PremiumCard(
                planName: "Platinum",
                priceInfo: "₹299 / month",
                afterPrice: "",
                features: [
                  "Up to 3 Platinum accounts",
                  "Download to listen offline",
                  "Lossless audio quality (up to ~24-bit/44.1kHz)",
                  "Mix your playlists",
                  "Your personal AI DJ",
                  "AI playlist creation",
                  "Connect your DJ software",
                  "Cancel anytime",
                ],
                buttonText: "Get Premium Platinum",
                buttonColor: Color(0xffffff00), // Yellow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
