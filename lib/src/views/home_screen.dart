import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../viewmodels/user_view_models.dart';

class HomeScreen extends StatelessWidget {
  final UserViewModel _userViewModel = Get.find();
  final _addUserForm = GlobalKey<FormState>();
  final _changeUserInfoForm = GlobalKey<FormState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restful Example'),
        centerTitle: true,
        actions: [addUser()],
      ),
      body: StreamBuilder(
        stream: _userViewModel.userStream(),
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.hasData) {
            List<UserModelData?>? data = snapshot.data?.data;

            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (BuildContext context, int index) {
                String name =
                    '${data?[index]?.firstName} ${data?[index]?.lastName}';
                String email = '${data?[index]?.email}';
                String avatarUrl = '${data?[index]?.avatar}';
                String? id = data?[index]?.id.toString();

                return userCard(avatarUrl, name, email, id!);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListTile userCard(String avatarUrl, String name, String email, String id) {
    String? changedName, changedEmail;
    return ListTile(
      leading: CircleAvatar(
        radius: Get.height * .04,
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          imageBuilder: (context, imageProvider) => Container(
            width: Get.width * .2,
            height: Get.height * .2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(name),
      subtitle: Text(email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              await _userViewModel.deleteUser(id);
            },
            child: const Icon(
              Icons.delete,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              Get.defaultDialog(
                title: 'Change User Info',
                content: SizedBox(
                  height: Get.height * .2,
                  child: Center(
                    child: Form(
                      key: _changeUserInfoForm,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(hintText: name),
                              onSaved: (String? saved) {
                                changedName = saved!;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: email),
                              onSaved: (String? saved) {
                                changedEmail = saved!;
                              },
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (_changeUserInfoForm.currentState!
                                    .validate()) {
                                  _changeUserInfoForm.currentState!.save();

                                  var res = await _userViewModel
                                      .changeUserInformation(
                                    id: id,
                                    changedUserModel: UserModelData(
                                      email: changedEmail,
                                      firstName: changedName?.split(' ')[0],
                                      lastName: changedName?.split(' ')[1],
                                      id: int.parse(id),
                                      avatar: avatarUrl,
                                    ),
                                    oldUserModel: UserModelData(
                                      email: email,
                                      firstName: name.split(' ')[0],
                                      lastName: name.split(' ')[1],
                                      id: int.parse(id),
                                      avatar: avatarUrl,
                                    ),
                                  );

                                  if (res == true) {
                                    Get.back();
                                    Get.defaultDialog(
                                      title: '',
                                      titleStyle: const TextStyle(fontSize: 0),
                                      content: const Text('Success'),
                                    );
                                  } else {
                                    Get.defaultDialog(
                                      title: '',
                                      titleStyle: const TextStyle(fontSize: 0),
                                      content: const Text('Failed'),
                                    );
                                  }
                                }
                              },
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Icon(
              Icons.more_horiz,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector addUser() {
    String? firstName, lastName, email;

    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
          title: 'Add User',
          content: SizedBox(
            height: Get.height * .3,
            child: Center(
              child: Form(
                key: _addUserForm,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your first name'),
                        onSaved: (String? saved) {
                          firstName = saved!;
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Enter your last name'),
                        onSaved: (String? saved) {
                          lastName = saved!;
                        },
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || value == '') {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(hintText: 'Enter your email'),
                        onSaved: (String? saved) {
                          email = saved!;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_addUserForm.currentState!.validate()) {
                            _addUserForm.currentState!.save();

                            var res = await _userViewModel.addUser(
                              UserModelData(
                                email: email,
                                firstName: firstName,
                                lastName: lastName,
                              ),
                            );

                            if (res == true) {
                              Get.back();
                              Get.defaultDialog(
                                title: '',
                                titleStyle: const TextStyle(fontSize: 0),
                                content: const Text('Success'),
                              );
                            } else {
                              Get.defaultDialog(
                                title: '',
                                titleStyle: const TextStyle(fontSize: 0),
                                content: const Text('Failed'),
                              );
                            }
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
