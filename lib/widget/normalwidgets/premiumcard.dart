import 'package:flutter/material.dart';

class PremiumCard extends StatelessWidget {
  final String planName;
  final String priceInfo;
  final String afterPrice;
  final List<String> features;
  final String buttonText;
  final Color buttonColor;

  const PremiumCard({
    super.key,
    required this.planName,
    required this.priceInfo,
    required this.afterPrice,
    required this.features,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/cardbgimage1.jpg'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Premium",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            planName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            priceInfo,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),

          if (afterPrice.isNotEmpty)
            Text(
              afterPrice,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: features
                  .map(
                    (feat) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          const Icon(Icons.circle, size: 6),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feat,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
