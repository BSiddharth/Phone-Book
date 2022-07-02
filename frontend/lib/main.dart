import 'package:flutter/material.dart';
import 'package:phone_book/fakeRepo.dart';

void main() {
  runApp(const MyApp());
}

enum LoadingState { loading, failed, completed }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Book App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List contactList = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  LoadingState currentState = LoadingState.loading;
  deleteContact({required int index}) {
    contactList.removeAt(index);
    setState(() {});
  }

  editContact(
      {required int index, required String name, required String number}) {
    contactList[index] = {'name': name, 'phoneNumber': number};
    setState(() {});
  }

  loadRepo() async {
    try {
      contactList = await fakeRepo();
      currentState = LoadingState.completed;
    } catch (e) {
      currentState = LoadingState.failed;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadRepo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.perm_contact_cal_rounded,
                  color: Colors.black,
                  size: 37,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Phone Book App',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                clipBehavior: Clip.none,
                                children: <Widget>[
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(Icons.close),
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Name',
                                              icon: Icon(Icons.account_box),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: numberController,
                                            decoration: const InputDecoration(
                                              labelText: 'Contact Number',
                                              icon: Icon(Icons.call),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: const Text("Save"),
                                            onPressed: () {
                                              contactList.add({
                                                'name': nameController.text,
                                                'phoneNumber':
                                                    numberController.text
                                              });
                                              // contactList.sort();
                                              contactList.sort((a, b) =>
                                                  a['name']
                                                      .compareTo(b['name']));

                                              setState(() {});
                                              _formKey.currentState!.reset();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Row(children: const [
                      Icon(Icons.add),
                      Text(
                        'Add Contact',
                      ),
                    ]))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(),
                  hintText: 'Search for a contact...',
                  hintStyle: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 30,
            ),
            currentState == LoadingState.completed
                ? Expanded(
                    child: ContactBox(
                    contactList: contactList,
                    deleteContact: deleteContact,
                    editContact: editContact,
                  ))
                : currentState == LoadingState.loading
                    ? const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.error, color: Colors.redAccent),
                            Text('Data could not be loaded!')
                          ],
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class ContactBox extends StatefulWidget {
  final List contactList;
  final Function deleteContact;
  final Function editContact;
  const ContactBox({
    Key? key,
    required this.contactList,
    required this.deleteContact,
    required this.editContact,
  }) : super(key: key);

  @override
  State<ContactBox> createState() => _ContactBoxState();
}

class _ContactBoxState extends State<ContactBox> {
  @override
  Widget build(BuildContext context) {
    return widget.contactList.isEmpty
        ? const Center(child: Text('No contacts to show. Add some.'))
        : Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black38,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: ListView.builder(
                itemCount: widget.contactList.length,
                itemBuilder: (context, index) {
                  final data = widget.contactList[index];
                  return ContactCard(
                    name: data['name'],
                    phoneNumber: data['phoneNumber'],
                    isFirst: index == 0,
                    isLast: index == widget.contactList.length - 1,
                    index: index,
                    deleteContact: widget.deleteContact,
                    editContact: widget.editContact,
                  );
                }),
            //  Column(
            //   children: const [
            //     ContactCard(),
            //   ],
            // ),
          );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final bool isFirst;
  final bool isLast;
  final Function deleteContact;
  final Function editContact;
  final int index;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  ContactCard({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.isFirst,
    required this.isLast,
    required this.index,
    required this.deleteContact,
    required this.editContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black38,
          ),
          borderRadius: BorderRadius.only(
            topLeft:
                isFirst ? const Radius.circular(5) : const Radius.circular(0),
            topRight:
                isFirst ? const Radius.circular(5) : const Radius.circular(0),
            bottomLeft:
                isLast ? const Radius.circular(5) : const Radius.circular(0),
            bottomRight:
                isLast ? const Radius.circular(5) : const Radius.circular(0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                nameController.text = name;
                numberController.text = phoneNumber;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40.0,
                              top: -40.0,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        labelText: 'Name',
                                        icon: Icon(Icons.account_box),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: numberController,
                                      decoration: const InputDecoration(
                                        labelText: 'Contact Number',
                                        icon: Icon(Icons.call),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Text("Save"),
                                      onPressed: () {
                                        editContact(
                                            index: index,
                                            name: nameController.text,
                                            number: numberController.text);

                                        _formKey.currentState!.reset();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                deleteContact(index: index);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
