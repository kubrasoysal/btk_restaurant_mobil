import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'Tümü';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  
  final List<String> _filterOptions = ['Tümü', 'Tamamlanan', 'İptal Edilen', 'Bekleyen'];
  
  // Örnek sipariş verileri
  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-001',
      'tableNumber': 'Masa 1',
      'customerName': 'Ahmet Yılmaz',
      'orderTime': DateTime.now().subtract(const Duration(hours: 2)),
      'totalAmount': 125.50,
      'status': 'Tamamlandı',
      'items': ['Karışık Pizza', 'Cola', 'Tiramisu'],
    },
    {
      'id': 'ORD-002',
      'tableNumber': 'Masa 3',
      'customerName': 'Fatma Demir',
      'orderTime': DateTime.now().subtract(const Duration(hours: 4)),
      'totalAmount': 89.75,
      'status': 'Tamamlandı',
      'items': ['Mantı', 'Ayran', 'Künefe'],
    },
    {
      'id': 'ORD-003',
      'tableNumber': 'Masa 2',
      'customerName': 'Mehmet Kaya',
      'orderTime': DateTime.now().subtract(const Duration(hours: 6)),
      'totalAmount': 156.00,
      'status': 'İptal Edildi',
      'items': ['Döner', 'Pilav', 'Baklava'],
    },
    {
      'id': 'ORD-004',
      'tableNumber': 'Masa 5',
      'customerName': 'Ayşe Özkan',
      'orderTime': DateTime.now().subtract(const Duration(hours: 8)),
      'totalAmount': 67.25,
      'status': 'Tamamlandı',
      'items': ['Çorba', 'Salata', 'Su'],
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 'Tümü') {
      return _orders.where((order) {
        return order['orderTime'].isAfter(_startDate) && 
               order['orderTime'].isBefore(_endDate.add(const Duration(days: 1)));
      }).toList();
    } else {
      return _orders.where((order) {
        return order['status'] == _selectedFilter &&
               order['orderTime'].isAfter(_startDate) && 
               order['orderTime'].isBefore(_endDate.add(const Duration(days: 1)));
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sipariş Geçmişi'),
        backgroundColor: const Color(0xFFFF9800),
        foregroundColor: Colors.white,
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
                          labelText: 'Durum Filtresi',
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _selectDateRange,
                        icon: const Icon(Icons.date_range),
                        label: const Text('Tarih Seç'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
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
                    'Toplam Sipariş',
                    _filteredOrders.length.toString(),
                    Icons.receipt_long,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Toplam Tutar',
                    '₺${_filteredOrders.fold(0.0, (sum, order) => sum + order['totalAmount']).toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Ortalama Tutar',
                    _filteredOrders.isEmpty ? '₺0.00' : '₺${(_filteredOrders.fold(0.0, (sum, order) => sum + order['totalAmount']) / _filteredOrders.length).toStringAsFixed(2)}',
                    Icons.analytics,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          
          // Sipariş listesi
          Expanded(
            child: _filteredOrders.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Seçilen kriterlere uygun sipariş bulunamadı',
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
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return _buildOrderCard(order);
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

  Widget _buildOrderCard(Map<String, dynamic> order) {
    Color statusColor;
    switch (order['status']) {
      case 'Tamamlandı':
        statusColor = Colors.green;
        break;
      case 'İptal Edildi':
        statusColor = Colors.red;
        break;
      case 'Bekleyen':
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['id'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
                    order['status'],
                    style: TextStyle(
                      color: statusColor,
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
                Icon(Icons.table_restaurant, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Text('${order['tableNumber']}'),
                const SizedBox(width: 24),
                Icon(Icons.person, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(order['customerName']),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.orange, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${order['orderTime'].day}/${order['orderTime'].month}/${order['orderTime'].year} ${order['orderTime'].hour}:${order['orderTime'].minute.toString().padLeft(2, '0')}',
                ),
                const Spacer(),
                Text(
                  '₺${order['totalAmount'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Sipariş Edilen Ürünler:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: order['items'].map<Widget>((item) {
                return Chip(
                  label: Text(item),
                  backgroundColor: Colors.grey[100],
                  labelStyle: const TextStyle(fontSize: 12),
                );
              }).toList(),
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
}
