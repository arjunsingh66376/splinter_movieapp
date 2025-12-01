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
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Premium",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            planName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            priceInfo,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          if (afterPrice.isNotEmpty)
            Text(
              afterPrice,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),

          const SizedBox(height: 12),

          /// FEATURES
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map(
                  (feat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 6,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feat,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 14),

          /// BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 0,
                backgroundColor: buttonColor,
                foregroundColor: Colors.black,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
