import 'dart:io';

import 'package:fake_chats/widgets/widgets.dart';
import 'package:fake_chats/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _activeTimeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Doe');
    _activeTimeController = TextEditingController(text: 'Active 2h Ago');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _activeTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Direct message with',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextField(
                    controller: _nameController,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Parts:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _storyStatus,
                              activeColor: Colors.black,
                              splashRadius: 15,
                              onChanged: (value) {
                                setState(() {
                                  _storyStatus = value ?? false;
                                });
                              },
                            ),
                            const Text('Story Status')
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _online,
                              activeColor: Colors.black,
                              splashRadius: 15,
                              onChanged: (value) {
                                setState(() {
                                  _online = value ?? false;
                                });
                              },
                            ),
                            const Text('Online')
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (!_online)
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Active Time :',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Hide',
                                activeColor: Colors.black,
                                groupValue: _showOnline,
                                onChanged: (value) {
                                  setState(() {
                                    _showOnline = value.toString();
                                  });
                                },
                              ),
                              const Text('Hide'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Show',
                                activeColor: Colors.black,
                                groupValue: _showOnline,
                                onChanged: (value) {
                                  setState(() {
                                    _showOnline = value.toString();
                                  });
                                },
                              ),
                              const Text('Show')
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (!_online)
                if (_showOnline != 'Hide')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Active Time Ago',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomTextField(
                        controller: _activeTimeController,
                      ),
                    ],
                  ),
              const SizedBox(
                height: 20,
              ),
              const TabBar(tabs: [
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Person 1',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Person 2',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ]),
              const Expanded(
                child: TabBarView(children: [
                  Person1(),
                  Person2(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Functions and Variables

  bool _storyStatus = false;
  bool _online = true;
  String _showOnline = 'Show';
}

class Person1 extends StatefulWidget {
  const Person1({super.key});

  @override
  State<Person1> createState() => _Person1State();
}

class _Person1State extends State<Person1> {
  File? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.height(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      height: 45,
                      width: 45,
                      color: Colors.black,
                    ),
                  )
                : Image.file(imagePath!),
            40.width(),
            Column(
              children: [
                const Text(
                  'Profile Photo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    onPressed: onTapSelectPhoto,
                    child: const Text('Select Photo')),
              ],
            )
          ],
        ),
      ],
    );
  }

  void onTapSelectPhoto() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
      });
    }
  }
}

class Person2 extends StatelessWidget {
  const Person2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
