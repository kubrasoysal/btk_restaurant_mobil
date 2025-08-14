import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _selectedReportType = 'Günlük Satış';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();
  
  final List<String> _reportTypes = [
    'Günlük Satış',
    'Haftalık Satış',
    'Aylık Satış',
    'Personel Performansı',
    'Masa Doluluk Oranı',
    'En Çok Satan Ürünler',
    'Müşteri Memnuniyeti',
  ];
  
  // Örnek rapor verileri
  final List<Map<String, dynamic>> _dailySales = [
    {'date': '01/12/2024', 'orders': 45, 'revenue': 3250.75, 'customers': 38},
    {'date': '02/12/2024', 'orders': 52, 'revenue': 3890.50, 'customers': 45},
    {'date': '03/12/2024', 'orders': 38, 'revenue': 2845.25, 'customers': 32},
    {'date': '04/12/2024', 'orders': 61, 'revenue': 4567.80, 'customers': 54},
    {'date': '05/12/2024', 'orders': 47, 'revenue': 3520.40, 'customers': 41},
    {'date': '06/12/2024', 'orders': 55, 'revenue': 4120.60, 'customers': 48},
    {'date': '07/12/2024', 'orders': 43, 'revenue': 3180.90, 'customers': 37},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raporlar'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Rapor seçimi ve tarih filtreleri
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
                        value: _selectedReportType,
                        decoration: const InputDecoration(
                          labelText: 'Rapor Türü',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _reportTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedReportType = newValue!;
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
          
          // Özet istatistikler
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Toplam Sipariş',
                    _dailySales.fold<int>(0, (sum, day) => sum + (day['orders'] as int)).toString(),
                    Icons.receipt_long,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Toplam Gelir',
                    '₺${_dailySales.fold(0.0, (sum, day) => sum + day['revenue']).toStringAsFixed(2)}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Toplam Müşteri',
                    _dailySales.fold<int>(0, (sum, day) => sum + (day['customers'] as int)).toString(),
                    Icons.people,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Ortalama Sipariş',
                    '₺${(_dailySales.fold(0.0, (sum, day) => sum + day['revenue']) / _dailySales.fold<int>(0, (sum, day) => sum + (day['orders'] as int))).toStringAsFixed(2)}',
                    Icons.analytics,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          
          // Grafik alanı
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bar_chart,
                      color: const Color(0xFF4CAF50),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Günlük Satış Grafiği',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: _buildBarChart(),
                ),
              ],
            ),
          ),
          
          // Detaylı tablo
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
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
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.table_chart, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Detaylı Rapor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Tarih')),
                          DataColumn(label: Text('Sipariş Sayısı')),
                          DataColumn(label: Text('Gelir (₺)')),
                          DataColumn(label: Text('Müşteri Sayısı')),
                          DataColumn(label: Text('Ortalama Sipariş (₺)')),
                        ],
                        rows: _dailySales.map((day) {
                          return DataRow(
                            cells: [
                              DataCell(Text(day['date'])),
                              DataCell(Text(day['orders'].toString())),
                              DataCell(Text('₺${day['revenue'].toStringAsFixed(2)}')),
                              DataCell(Text(day['customers'].toString())),
                              DataCell(Text('₺${(day['revenue'] / day['orders']).toStringAsFixed(2)}')),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _exportReport,
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.download),
        label: const Text('Raporu İndir'),
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

  Widget _buildBarChart() {
    double maxRevenue = _dailySales.fold(0.0, (max, day) => 
        day['revenue'] > max ? day['revenue'] : max);
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _dailySales.map((day) {
        double height = (day['revenue'] / maxRevenue) * 150;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 30,
              height: height,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              day['date'].split('/')[0],
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              '₺${day['revenue'].toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        );
      }).toList(),
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

  void _exportReport() {
    // Burada rapor PDF, Excel veya CSV olarak dışa aktarılabilir
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rapor dışa aktarılıyor...'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }
}
