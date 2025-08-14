import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  
  String _selectedCategory = 'Ana Yemek';
  String _selectedStatus = 'Aktif';
  
  final List<String> _categoryOptions = [
    'Ana Yemek',
    'Çorba',
    'Salata',
    'Tatlı',
    'İçecek',
    'Kahvaltı',
    'Aperatif',
    'Pizza',
    'Burger',
    'Döner',
  ];
  
  final List<String> _statusOptions = ['Aktif', 'Pasif', 'Stokta Yok'];
  
  // Örnek ürün verileri
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'PRD-001',
      'name': 'Karışık Pizza',
      'description': 'Sucuk, sosis, mantar, biber, mısır ile',
      'price': 85.50,
      'category': 'Pizza',
      'status': 'Aktif',
      'image': '🍕',
      'stock': 50,
      'isVegetarian': false,
      'isSpicy': false,
    },
    {
      'id': 'PRD-002',
      'name': 'Mercimek Çorbası',
      'description': 'Geleneksel Türk mutfağından',
      'price': 25.00,
      'category': 'Çorba',
      'status': 'Aktif',
      'image': '🥣',
      'stock': 100,
      'isVegetarian': true,
      'isSpicy': false,
    },
    {
      'id': 'PRD-003',
      'name': 'Döner Porsiyon',
      'description': 'Tavuk döner, pilav, salata ile',
      'price': 65.00,
      'category': 'Ana Yemek',
      'status': 'Aktif',
      'image': '🥙',
      'stock': 75,
      'isVegetarian': false,
      'isSpicy': false,
    },
    {
      'id': 'PRD-004',
      'name': 'Tiramisu',
      'description': 'İtalyan usulü tiramisu',
      'price': 35.00,
      'category': 'Tatlı',
      'status': 'Aktif',
      'image': '🍰',
      'stock': 30,
      'isVegetarian': true,
      'isSpicy': false,
    },
    {
      'id': 'PRD-005',
      'name': 'Cola',
      'description': 'Soğuk içecek',
      'price': 15.00,
      'category': 'İçecek',
      'status': 'Aktif',
      'image': '🥤',
      'stock': 200,
      'isVegetarian': true,
      'isSpicy': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Yönetimi'),
        backgroundColor: const Color(0xFF9C27B0),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Ürün ekleme formu
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: const Color(0xFF9C27B0),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Yeni Ürün Ekle',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Ürün Adı',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.shopping_cart),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ürün adı gerekli';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(
                            labelText: 'Fiyat (₺)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Fiyat gerekli';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Geçerli sayı girin';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category),
                          ),
                          items: _categoryOptions.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Durum',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.info),
                          ),
                          items: _statusOptions.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStatus = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Açıklama',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.description),
                    ),
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Açıklama gerekli';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Ürün Ekle',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Ürün listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return _buildProductCard(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    Color statusColor;
    switch (product['status']) {
      case 'Aktif':
        statusColor = Colors.green;
        break;
      case 'Pasif':
        statusColor = Colors.red;
        break;
      case 'Stokta Yok':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Ürün emoji
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  product['image'],
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Ürün bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: statusColor),
                        ),
                        child: Text(
                          product['status'],
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['description'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.category, color: Colors.blue, size: 16),
                      const SizedBox(width: 8),
                      Text(product['category']),
                      const SizedBox(width: 24),
                      Icon(Icons.attach_money, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '₺${product['price'].toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.inventory, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Text('Stok: ${product['stock']}'),
                      const SizedBox(width: 24),
                      if (product['isVegetarian'])
                        Row(
                          children: [
                            Icon(Icons.eco, color: Colors.green, size: 16),
                            const SizedBox(width: 4),
                            const Text('Vejetaryen', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      if (product['isSpicy'])
                        Row(
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.red, size: 16),
                            const SizedBox(width: 4),
                            const Text('Acılı', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Aksiyon butonları
            Column(
              children: [
                IconButton(
                  onPressed: () => _editProduct(product),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  tooltip: 'Düzenle',
                ),
                IconButton(
                  onPressed: () => _deleteProduct(product['id']),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Sil',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = {
        'id': 'PRD-${(_products.length + 1).toString().padLeft(3, '0')}',
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'status': _selectedStatus,
        'image': '🍽️', // Varsayılan emoji
        'stock': 100, // Varsayılan stok
        'isVegetarian': false,
        'isSpicy': false,
      };
      
      setState(() {
        _products.add(newProduct);
      });
      
      // Formu temizle
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ürün başarıyla eklendi!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _editProduct(Map<String, dynamic> product) {
    // Burada ürün düzenleme modalı açılabilir
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} düzenleniyor...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteProduct(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ürün Sil'),
          content: const Text('Bu ürünü silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _products.removeWhere((product) => product['id'] == id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ürün silindi!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Sil'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
