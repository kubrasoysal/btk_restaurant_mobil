import 'package:flutter/material.dart';

class RestaurantManagementScreen extends StatefulWidget {
  const RestaurantManagementScreen({super.key});

  @override
  State<RestaurantManagementScreen> createState() => _RestaurantManagementScreenState();
}

class _RestaurantManagementScreenState extends State<RestaurantManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _openingTimeController = TextEditingController();
  final _closingTimeController = TextEditingController();
  
  bool _isOpen24Hours = false;
  String _selectedCategory = 'Restoran';

  final List<String> _categories = [
    'Restoran',
    'Kafe',
    'Pizzacı',
    'Dönerci',
    'Pastane',
    'Diğer'
  ];

  @override
  void initState() {
    super.initState();
    _loadRestaurantInfo();
  }

  void _loadRestaurantInfo() {
    // Burada mevcut restoran bilgileri yüklenebilir
    _nameController.text = 'Örnek Restoran';
    _addressController.text = 'Örnek Mahallesi, Örnek Sokak No:1';
    _phoneController.text = '0212 123 45 67';
    _emailController.text = 'info@ornekrestoran.com';
    _openingTimeController.text = '09:00';
    _closingTimeController.text = '23:00';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restoran Yönetimi'),
        backgroundColor: const Color(0xFF5E35B1),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.restaurant,
                            color: const Color(0xFF5E35B1),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Temel Bilgiler',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Restoran Adı',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.store),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Restoran adı gerekli';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Adres',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Adres gerekli';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Telefon',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Telefon gerekli';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'E-posta',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'E-posta gerekli';
                                }
                                if (!value.contains('@')) {
                                  return 'Geçerli e-posta girin';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            color: const Color(0xFF5E35B1),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Çalışma Saatleri',
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
                          Checkbox(
                            value: _isOpen24Hours,
                            onChanged: (value) {
                              setState(() {
                                _isOpen24Hours = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            '24 Saat Açık',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (!_isOpen24Hours) ...[
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _openingTimeController,
                                decoration: const InputDecoration(
                                  labelText: 'Açılış Saati',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _openingTimeController.text = 
                                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextFormField(
                                controller: _closingTimeController,
                                decoration: const InputDecoration(
                                  labelText: 'Kapanış Saati',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.access_time),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    setState(() {
                                      _closingTimeController.text = 
                                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: const Color(0xFF5E35B1),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Kategori ve Ayarlar',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Restoran Kategorisi',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: _categories.map((String category) {
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveRestaurantInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E35B1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Bilgileri Kaydet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveRestaurantInfo() {
    if (_formKey.currentState!.validate()) {
      // Burada restoran bilgileri kaydedilebilir
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Restoran bilgileri başarıyla kaydedildi!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    super.dispose();
  }
}
