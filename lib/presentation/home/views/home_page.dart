import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Obx(
        () => controller.isLoading
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  //opening bottom modal sheet
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const Text(
                              'Add Employee',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: controller.employeeNameController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Employee Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: controller.employeeSalaryController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Employee Salary',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: controller.employeeAgeController,
                              decoration: const InputDecoration(
                                hintText: 'Enter Employee Age',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade100,
                              ),
                              onPressed: () async {
                                controller.addEmployeeDataProcess();
                                await controller.getAllEmployeeDataProcess();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('Add'),
              ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff00A877),
        title: const Text(
          'Remote Kitchen',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 15.0,
                color: Colors.black38,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.employeeModel.data.isNotEmpty
                ? RefreshIndicator(
                    color: const Color(0xFF5E3ACC),
                    onRefresh: () async {
                      controller.getAllEmployeeDataProcess();
                    },
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: const Center(
                            child: Text(
                              'Employee List With Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.employeeModel.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 3,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        flex: 2,
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Name: ${controller.employeeModel.data[index].employeeName}'),
                                            Text(
                                                'salary: ${controller.employeeModel.data[index].employeeSalary}'),
                                            Text(
                                                'Age: ${controller.employeeModel.data[index].employeeAge}'),
                                            Text(
                                                'ID: ${controller.employeeModel.data[index].id}'),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 4),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .orangeAccent.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: const Text('Update')),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 6, bottom: 6),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: Colors
                                                        .indigoAccent.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: const Text('Delete')),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Card(
                      elevation: 3,
                      child: Center(
                        child: Text(
                          'No data found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
