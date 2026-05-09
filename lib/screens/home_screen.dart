
import 'package:flutter/material.dart';
import '../services/db_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DBService dbService = DBService();
  List<Map<String, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    final data = await dbService.getOrders();
    setState(() {
      orders = data;
    });
  }

  Future<void> addDemoOrder() async {
    await dbService.insertOrder({
      'food': 'Chicken Burger',
      'price': 350,
      'queue': orders.length + 1
    });
    loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Restaurant Ordering"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDemoOrder,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AI Recommendation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "You usually order burgers at night under ৳500.",
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final item = orders[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['food']),
                      subtitle: Text("Queue Position: #${item['queue']}"),
                      trailing: Text("৳${item['price']}"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
