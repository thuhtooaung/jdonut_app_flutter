import 'package:flutter/material.dart';
import 'package:jdonut_app_flutter/theme/app_assets.dart';
import 'package:jdonut_app_flutter/theme/app_typo.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Stack to allow the quantity widget to overlap the bottom edge of the card
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Main Card Container (with bottom margin to create room for the overlap)
                          Container(
                            margin: const EdgeInsets.only(bottom: 28.0),
                            padding: const EdgeInsets.fromLTRB(
                              20.0,
                              20.0,
                              20.0,
                              48.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header Row: Product Code & "New" Badge
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'JD022123',
                                      style: TextStyle(
                                        fontFamily: AppTypo.generalSans,
                                        color: const Color(0xFF9E9E9E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF6D00),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      child: Text(
                                        'New',
                                        style: TextStyle(
                                          fontFamily: AppTypo.generalSans,
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Product Title
                                Text(
                                  'Coconut Donut',
                                  style: TextStyle(
                                    fontFamily: AppTypo.generalSans,
                                    color: Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),

                                // Price
                                Text(
                                  '3200 MMK',
                                  style: TextStyle(
                                    fontFamily: AppTypo.generalSans,
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Static Product Donut Image
                                Center(
                                  child: SizedBox(
                                    width: 220,
                                    height: 220,
                                    child: Image.asset(
                                      AppAssets.donut,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Quantity Stepper Selector overlapping the bottom edge
                          Positioned(
                            bottom: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6F8),
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Decrement Button
                                  IconButton(
                                    onPressed: _decrement,
                                    icon: const Icon(Icons.remove),
                                    color: const Color(0xFF00BCD4),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: Text(
                                      '$_quantity',
                                      style: TextStyle(
                                        fontFamily: AppTypo.generalSans,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  // Increment Button
                                  IconButton(
                                    onPressed: _increment,
                                    icon: const Icon(Icons.add),
                                    color: Colors.white,
                                    style: IconButton.styleFrom(
                                      backgroundColor: const Color(0xFF00BCD4),
                                      shape: const CircleBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Description Section ("What's this?")
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.help,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "What's\nthis?",
                            style: TextStyle(
                              fontFamily: AppTypo.generalSans,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Enjoy our scrumptious donuts – soft, sweet, and satisfying in every bite. Choose from classic glazed, rich chocolate, or fun sprinkles. Dive into deliciousness now!',
                              style: TextStyle(
                                fontFamily: AppTypo.generalSans,
                                color: Colors.grey.shade600,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button: Add to Cart
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Add to Cart action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4DD0E1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ADD TO CART',
                          style: TextStyle(
                            fontFamily: AppTypo.generalSans,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '|',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Text(
                          '3,200 MMK',
                          style: TextStyle(
                            fontFamily: AppTypo.generalSans,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
