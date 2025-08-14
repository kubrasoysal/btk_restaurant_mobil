import 'package:flutter/material.dart';

class ActivityLogsScreen extends StatefulWidget {
  const ActivityLogsScreen({super.key});

  @override
  State<ActivityLogsScreen> createState() => _ActivityLogsScreenState();
}

class _ActivityLogsScreenState extends State<ActivityLogsScreen> {
  String _selectedFilter = 'Tümü';
  String _selectedUser = 'Tüm Kullanıcılar';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  
  final List<String> _filterOptions = ['Tümü', 'Giriş', 'Çıkış', 'Rezervasyon', 'Sipariş', 'Sistem'];
  final List<String> _userOptions = ['Tüm Kullanıcılar', 'Admin', 'Garson', 'Kasiyer', 'Müşteri'];
  
  // Örnek aktivite log verileri
  final List<Map<String, dynamic>> _activityLogs = [
    {
      'id': 'LOG-001',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'user': 'Admin',
      'action': 'Giriş',
      'description': 'Sisteme giriş yapıldı',
      'ipAddress': '192.168.1.100',
      'status': 'Başarılı',
      'category': 'Giriş',
    },
    {
      'id': 'LOG-002',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
      'user': 'Garson',
      'action': 'Rezervasyon',
      'description': 'Masa 3 için yeni rezervasyon oluşturuldu',
      'ipAddress': '192.168.1.101',
      'status': 'Başarılı',
      'category': 'Rezervasyon',
    },
    {
      'id': 'LOG-003',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      'user': 'Kasiyer',
      'action': 'Sipariş',
      'description': 'Masa 1\'den yeni sipariş alındı - Toplam: ₺125.50',
      'ipAddress': '192.168.1.102',
      'status': 'Başarılı',
      'category': 'Sipariş',
    },
    {
      'id': 'LOG-004',
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'user': 'Admin',
      'action': 'Sistem',
      'description': 'Yeni masa eklendi: Masa 8 (4 kişilik)',
      'ipAddress': '192.168.1.100',
      'status': 'Başarılı',
      'category': 'Sistem',
    },
    {
      'id': 'LOG-005',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'user': 'Garson',
      'action': 'Giriş',
      'description': 'Sisteme giriş yapıldı',
      'ipAddress': '192.168.1.101',
      'status': 'Başarılı',
      'category': 'Giriş',
    },
    {
      'id': 'LOG-006',
      'timestamp': DateTime.now().subtract(const Duration(hours: 3)),
      'user': 'Müşteri',
      'action': 'Rezervasyon',
      'description': 'Online rezervasyon iptal edildi - Masa 2',
      'ipAddress': '185.123.45.67',
      'status': 'Başarılı',
      'category': 'Rezervasyon',
    },
    {
      'id': 'LOG-007',
      'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
      'user': 'Admin',
      'action': 'Sistem',
      'description': 'Sistem yedeklemesi tamamlandı',
      'ipAddress': '192.168.1.100',
      'status': 'Başarılı',
      'category': 'Sistem',
    },
    {
      'id': 'LOG-008',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'user': 'Kasiyer',
      'action': 'Çıkış',
      'description': 'Sistemden çıkış yapıldı',
      'ipAddress': '192.168.1.102',
      'status': 'Başarılı',
      'category': 'Çıkış',
    },
  ];

  List<Map<String, dynamic>> get _filteredLogs {
    return _activityLogs.where((log) {
      bool categoryMatch = _selectedFilter == 'Tümü' || log['category'] == _selectedFilter;
      bool userMatch = _selectedUser == 'Tüm Kullanıcılar' || log['user'] == _selectedUser;
      bool dateMatch = log['timestamp'].isAfter(_startDate) && 
                      log['timestamp'].isBefore(_endDate.add(const Duration(days: 1)));
      
      return categoryMatch && userMatch && dateMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivite Logları'),
        backgroundColor: const Color(0xFFFFD700),
        foregroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          // Filtreler
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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        decoration: const InputDecoration(
                          labelText: 'Kategori Filtresi',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _filterOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFilter = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedUser,
                        decoration: const InputDecoration(
                          labelText: 'Kullanıcı Filtresi',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _userOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedUser = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _selectDateRange,
                        icon: const Icon(Icons.date_range),
                        label: const Text('Tarih Seç'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD700),
                          foregroundColor: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _exportLogs,
                        icon: const Icon(Icons.download),
                        label: const Text('Dışa Aktar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Başlangıç: ${_startDate.day}/${_startDate.month}/${_startDate.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(' - '),
                    Expanded(
                      child: Text(
                        'Bitiş: ${_endDate.day}/${_endDate.month}/${_endDate.year}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // İstatistikler
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Toplam Log',
                    _filteredLogs.length.toString(),
                    Icons.list_alt,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Başarılı',
                    _filteredLogs.where((log) => log['status'] == 'Başarılı').length.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Aktif Kullanıcı',
                    _filteredLogs.map((log) => log['user']).toSet().length.toString(),
                    Icons.people,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          
          // Log listesi
          Expanded(
            child: _filteredLogs.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list_alt,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Seçilen kriterlere uygun log bulunamadı',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _filteredLogs.length,
                    itemBuilder: (context, index) {
                      final log = _filteredLogs[index];
                      return _buildLogCard(log);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogCard(Map<String, dynamic> log) {
    Color categoryColor;
    IconData categoryIcon;
    
    switch (log['category']) {
      case 'Giriş':
        categoryColor = Colors.green;
        categoryIcon = Icons.login;
        break;
      case 'Çıkış':
        categoryColor = Colors.red;
        categoryIcon = Icons.logout;
        break;
      case 'Rezervasyon':
        categoryColor = Colors.blue;
        categoryIcon = Icons.book_online;
        break;
      case 'Sipariş':
        categoryColor = Colors.orange;
        categoryIcon = Icons.receipt_long;
        break;
      case 'Sistem':
        categoryColor = Colors.purple;
        categoryIcon = Icons.settings;
        break;
      default:
        categoryColor = Colors.grey;
        categoryIcon = Icons.info;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(categoryIcon, color: categoryColor, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      log['id'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: categoryColor),
                  ),
                  child: Text(
                    log['category'],
                    style: TextStyle(
                      color: categoryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.person, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Text(log['user']),
                const SizedBox(width: 24),
                Icon(Icons.computer, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(log['ipAddress']),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${log['timestamp'].day}/${log['timestamp'].month}/${log['timestamp'].year} ${log['timestamp'].hour}:${log['timestamp'].minute.toString().padLeft(2, '0')}',
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: log['status'] == 'Başarılı' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: log['status'] == 'Başarılı' ? Colors.green : Colors.red,
                    ),
                  ),
                  child: Text(
                    log['status'],
                    style: TextStyle(
                      color: log['status'] == 'Başarılı' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Açıklama:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              log['description'],
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: _startDate,
        end: _endDate,
      ),
    );
    
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _exportLogs() {
    // Burada log verileri dışa aktarılabilir (CSV, Excel, PDF vb.)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Log verileri dışa aktarılıyor...'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}
