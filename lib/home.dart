import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;
import 'package:pac_app_thesis/loading.dart';
import 'desc.dart';
import 'dart:convert';
import 'notFound.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  String? lastScannedBarcode;
  bool showAllProducts = false;

  Future<List<Map<String, dynamic>>> fetchAllProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://blockchain-api-pt82.onrender.com/api/products/all'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['products'] != null) {
          return List<Map<String, dynamic>>.from(data['products']);
        }
        throw Exception('Invalid response format from API');
      }
      throw Exception('Failed to fetch products: ${response.statusCode}');
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Error fetching products: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> findProductByBarcode(String scannedBarcode) async {
    try {
      final products = await fetchAllProducts();
      
      for (var product in products) {
        final tracking = product['tracking'];
        if (tracking != null && tracking['barcode'] == scannedBarcode) {
          return product;
        }
      }
      return null;
    } catch (e) {
      print('Error finding product by barcode: $e');
      return null;
    }
  }

  Future<void> details(String barcode) async {
    print("Fetching details for barcode: $barcode");
    
    try {
      // First show loading screen
      if (!isLoading) {
        isLoading = true;
        Navigator.push(context, MaterialPageRoute(builder: (_) => Loading()));
      }
      
      // Find product by barcode
      final product = await findProductByBarcode(barcode);
      
      // Hide loading screen
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      
      if (product != null) {
        final basicDetails = product["basicDetails"];
        final tracking = product["tracking"];
        final exp = product["expiration"];
        
        // Show product details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Desc(
              title: basicDetails["productName"]?.toString() ?? 'Unknown',
              desc: basicDetails["description"]?.toString() ?? 'No description',
              brand: basicDetails["brand"]?.toString() ?? 'Unknown',
              price: basicDetails["price"]?.toString() ?? '0',
              weight: basicDetails["weight"]?.toString() ?? 'Unknown',
              url: basicDetails["productImg"]?.toString() ?? '',
              serialNo: tracking["serialNumber"]?.toString() ?? 'Unknown',
              mfgDate: exp["manufacturingDate"]?.toString() ?? 'Unknown',
              expDate: exp["expirationDate"]?.toString() ?? 'Unknown',
              sellStatus: product["sellStatus"]?.toString() ?? 'Unknown',
            ),
          ),
        );
      } else {
        // Product not found
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotFound()),
        );
      }
    } catch (e) {
      print("Error fetching details: $e");
      // Only pop if we're on the loading screen
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      // Show not found page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotFound()),
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      print("Scanned barcode: ${result.rawContent}");
      
      if (result.rawContent.isNotEmpty) {
        setState(() {
          lastScannedBarcode = result.rawContent;
        });
        
        // Fetch product details
        await details(result.rawContent);
      }
    } catch (e) {
      print('Error scanning barcode: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning barcode: $e')),
      );
    }
  }

  Future<void> scanBarcodeWithBarcode(String barcode) async {
    try {
      setState(() {
        lastScannedBarcode = barcode;
      });
      await details(barcode);
    } catch (e) {
      print('Error scanning with barcode: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PAC Scanner",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.white),
            onPressed: () {
              setState(() {
                showAllProducts = !showAllProducts;
              });
            },
          ),
        ],
      ),
      body: showAllProducts
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'All Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchAllProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products found'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          final basicDetails = product["basicDetails"];
                          final tracking = product["tracking"];
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(basicDetails["productName"]?.toString() ?? 'Unknown'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Brand: ${basicDetails["brand"]?.toString() ?? 'Unknown'}'),
                                  Text('Price: \$${basicDetails["price"]?.toString() ?? '0'}'),
                                  Text('Barcode: ${tracking["barcode"]?.toString() ?? 'Unknown'}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.qr_code_scanner, color: Colors.teal),
                                onPressed: () {
                                  setState(() {
                                    showAllProducts = false;
                                  });
                                  scanBarcodeWithBarcode(tracking["barcode"]?.toString() ?? '');
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              'assets/scanner.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Tap to Scan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: scanBarcode,
                  ),
                ),
                if (lastScannedBarcode != null)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Last scanned: $lastScannedBarcode',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
