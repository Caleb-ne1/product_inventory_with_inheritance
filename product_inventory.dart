import 'dart:io'; 

class Product {
  String name;
  double price;
  Product(this.name, this.price);
  double calculateTotalPrice(double taxRate) => price + calculateTax(price, taxRate);
  double calculateTax(double price, double taxRate) => 0.0;
}

abstract class Taxable {
  double calculateTax(double price, double taxRate);
}

class ElectronicProduct extends Product implements Taxable {
  int warranty;

  ElectronicProduct(String name, double price, this.warranty) : super(name, price);
  
  @override
  double calculateTax(double price, double taxRate) => price * taxRate * 0.8; 
}

class FileReader {
  static List<Product> readProductsFromFile() {
    List<Product> products = [];
    final file = File('products.txt');
    if (file.existsSync()) {
      final lines = file.readAsLinesSync();
      for (var line in lines) {
        final parts = line.split(',');
        if (parts.length == 4 && parts[0] == 'electronic') {
          products.add(ElectronicProduct(parts[1], double.parse(parts[2]), int.parse(parts[3])));
        } else if (parts.length == 3) {
          products.add(Product(parts[1], double.parse(parts[2])));
        }
      }
    }
    return products;
  }
}

void main() {
  final products = FileReader.readProductsFromFile();
  
  for (var product in products) {
    final totalPrice = product.calculateTotalPrice(0.1); 
    print('Product: ${product.name}, Price: \Ksh ${product.price}, Warranty: ${product is ElectronicProduct ? product.warranty.toString() + ' months' : 'N/A'}, Total Price: \Ksh ${totalPrice.toStringAsFixed(2)}');
  }
}
