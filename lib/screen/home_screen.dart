import 'package:employee_book/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppDb _db;
  @override
  void initState() {
    super.initState();
    _db = AppDb();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<EmployeeData>>(
          future: _db.getEmployees(),
          builder: (context, snapshot) {
            final List<EmployeeData>? employees = snapshot.data;

            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (employees != null) {
              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return Card(
                    child: Column(children: [
                      Text(employee.id.toString()),
                      Text(employee.userName.toString()),
                      Text(employee.firstName.toString()),
                      Text(employee.lastName.toString()),
                      Text(employee.id.toString())
                    ]),
                  );
                },
              );
            }
            return const Text('No data found');
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add_employee');
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Employee')),
    );
  }
}
