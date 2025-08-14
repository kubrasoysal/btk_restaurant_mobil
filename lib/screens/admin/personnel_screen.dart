import 'package:flutter/material.dart';

class PersonnelScreen extends StatefulWidget {
  const PersonnelScreen({super.key});

  @override
  State<PersonnelScreen> createState() => _PersonnelScreenState();
}

class _PersonnelScreenState extends State<PersonnelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();
  
  String _selectedPosition = 'Garson';
  String _selectedStatus = 'Aktif';
  DateTime _hireDate = DateTime.now();
  
  final List<String> _positionOptions = [
    'Garson',
    'Kasiyer',
    'Aşçı',
    'Temizlik Görevlisi',
    'Müdür',
    'Yardımcı',
  ];
  
  final List<String> _statusOptions = ['Aktif', 'Pasif', 'İzinli', 'İşten Ayrıldı'];
  
  // Örnek personel verileri
  final List<Map<String, dynamic>> _personnel = [
    {
      'id': 'P001',
      'name': 'Ahmet Yılmaz',
      'email': 'ahmet@restoran.com',
      'phone': '0532 123 45 67',
      'position': 'Garson',
      'salary': 8500.0,
      'status': 'Aktif',
      'hireDate': DateTime.now().subtract(const Duration(days: 180)),
      'avatar': 'AY',
    },
    {
      'id': 'P002',
      'name': 'Fatma Demir',
      'email': 'fatma@restoran.com',
      'phone': '0533 234 56 78',
      'position': 'Kasiyer',
      'salary': 9000.0,
      'status': 'Aktif',
      'hireDate': DateTime.now().subtract(const Duration(days: 365)),
      'avatar': 'FD',
    },
    {
      'id': 'P003',
      'name': 'Mehmet Kaya',
      'email': 'mehmet@restoran.com',
      'phone': '0534 345 67 89',
      'position': 'Aşçı',
      'salary': 12000.0,
      'status': 'Aktif',
      'hireDate': DateTime.now().subtract(const Duration(days: 730)),
      'avatar': 'MK',
    },
    {
      'id': 'P004',
      'name': 'Ayşe Özkan',
      'email': 'ayse@restoran.com',
      'phone': '0535 456 78 90',
      'position': 'Garson',
      'salary': 8000.0,
      'status': 'İzinli',
      'hireDate': DateTime.now().subtract(const Duration(days: 90)),
      'avatar': 'AÖ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personel Yönetimi'),
        backgroundColor: const Color(0xFF5E35B1),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Personel ekleme formu
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
                        Icons.person_add,
                        color: const Color(0xFF5E35B1),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Yeni Personel Ekle',
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
                            labelText: 'Ad Soyad',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ad soyad gerekli';
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
                        child: DropdownButtonFormField<String>(
                          value: _selectedPosition,
                          decoration: const InputDecoration(
                            labelText: 'Pozisyon',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.work),
                          ),
                          items: _positionOptions.map((String position) {
                            return DropdownMenuItem<String>(
                              value: position,
                              child: Text(position),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedPosition = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _salaryController,
                          decoration: const InputDecoration(
                            labelText: 'Maaş (₺)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Maaş gerekli';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Geçerli sayı girin';
                            }
                            return null;
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
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _selectHireDate,
                          icon: const Icon(Icons.calendar_today),
                          label: Text('İşe Başlama: ${_hireDate.day}/${_hireDate.month}/${_hireDate.year}'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _addPersonnel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5E35B1),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Personel Ekle',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Personel listesi
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _personnel.length,
              itemBuilder: (context, index) {
                final person = _personnel[index];
                return _buildPersonnelCard(person);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonnelCard(Map<String, dynamic> person) {
    Color statusColor;
    switch (person['status']) {
      case 'Aktif':
        statusColor = Colors.green;
        break;
      case 'Pasif':
        statusColor = Colors.red;
        break;
      case 'İzinli':
        statusColor = Colors.orange;
        break;
      case 'İşten Ayrıldı':
        statusColor = Colors.grey;
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
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF5E35B1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  person['avatar'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Personel bilgileri
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        person['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                          person['status'],
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
                  Row(
                    children: [
                      Icon(Icons.work, color: Colors.blue, size: 16),
                      const SizedBox(width: 8),
                      Text(person['position']),
                      const SizedBox(width: 24),
                      Icon(Icons.attach_money, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Text('₺${person['salary'].toStringAsFixed(2)}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.orange, size: 16),
                      const SizedBox(width: 8),
                      Text(person['email']),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.purple, size: 16),
                      const SizedBox(width: 8),
                      Text(person['phone']),
                      const Spacer(),
                      Text(
                        'İşe Başlama: ${person['hireDate'].day}/${person['hireDate'].month}/${person['hireDate'].year}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
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
                  onPressed: () => _editPersonnel(person),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  tooltip: 'Düzenle',
                ),
                IconButton(
                  onPressed: () => _deletePersonnel(person['id']),
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

  Future<void> _selectHireDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _hireDate,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)), // 10 yıl öncesi
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        _hireDate = picked;
      });
    }
  }

  void _addPersonnel() {
    if (_formKey.currentState!.validate()) {
      final newPerson = {
        'id': 'P${(_personnel.length + 1).toString().padLeft(3, '0')}',
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'position': _selectedPosition,
        'salary': double.parse(_salaryController.text),
        'status': _selectedStatus,
        'hireDate': _hireDate,
        'avatar': _nameController.text.split(' ').map((e) => e[0]).join('').toUpperCase(),
      };
      
      setState(() {
        _personnel.add(newPerson);
      });
      
      // Formu temizle
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _salaryController.clear();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Personel başarıyla eklendi!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _editPersonnel(Map<String, dynamic> person) {
    // Burada personel düzenleme modalı açılabilir
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${person['name']} düzenleniyor...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deletePersonnel(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Personel Sil'),
          content: const Text('Bu personeli silmek istediğinizden emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _personnel.removeWhere((person) => person['id'] == id);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Personel silindi!'),
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
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _salaryController.dispose();
    super.dispose();
  }
}
