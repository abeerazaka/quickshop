import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_details_screen.dart';
import 'add_product_screen.dart';
import 'gestures_animation_screen.dart';
import 'webview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // In-memory product list
  final List<Product> _products = [
    Product(
      name: 'Wireless Headphones',
      price: 59.99,
      description: 'Noise-cancelling over-ear Bluetooth headphones with 30-hour battery life.',
      icon: Icons.headphones,
    ),
    Product(
      name: 'Smart Watch',
      price: 129.50,
      description: 'Fitness tracker with heart rate monitor, GPS, and OLED display.',
      icon: Icons.watch,
    ),
    Product(
      name: 'Mechanical Keyboard',
      price: 85.00,
      description: 'Compact RGB backlit mechanical keyboard with tactile switches.',
      icon: Icons.keyboard,
    ),
    Product(
      name: 'Running Sneakers',
      price: 74.00,
      description: 'Lightweight breathable mesh running shoes for daily training.',
      icon: Icons.directions_run,
    ),
  ];

  Future<void> _navigateToAddProduct() async {
    final newProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (context) => const AddProductScreen()),
    );

    if (newProduct != null) {
      setState(() {
        _products.add(newProduct);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${newProduct.name} added to QuickShop!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickShop'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.shopping_bag, color: Colors.white, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'QuickShop Menu',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Products'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Showing all available products')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text('Add Product'),
              onTap: () {
                Navigator.pop(context);
                _navigateToAddProduct();
              },
            ),
            ListTile(
              leading: const Icon(Icons.touch_app),
              title: const Text('Gestures & Animation'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GesturesAnimationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('WebView'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WebViewScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.indigo.shade50,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Tip: Tap for details • Double-tap to favorite • Long-press for quick info',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.indigo),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return GestureDetector(
                  // 1. onTap Gesture: Open Product Details
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  // 2. onDoubleTap Gesture: Toggle Favorite
                  onDoubleTap: () {
                    setState(() {
                      product.isFavorite = !product.isFavorite;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text(
                          product.isFavorite
                              ? '${product.name} marked as Favourite!'
                              : '${product.name} removed from Favourites.',
                        ),
                      ),
                    );
                  },
                  // 3. onLongPress Gesture: Display additional message
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Quick Preview: ${product.name} costs \$${product.price.toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.indigo.shade100,
                        child: Icon(product.icon, size: 30, color: Colors.indigo),
                      ),
                      title: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.isFavorite ? Colors.red : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddProduct,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}