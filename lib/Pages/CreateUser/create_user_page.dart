import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Pages/CreateUser/widgets/custom_buton_widget.dart';
import 'package:socketfront/Providers/theme_provider.dart';
import '../../Config/config.dart';
import '../../Widgets/input_widget.dart';
import 'widgets/foto_user_widget.dart';
import 'widgets/head_widget.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  TextEditingController controllerHost = TextEditingController();
  TextEditingController controllerPort = TextEditingController();

  int indexSelected = 0;
  bool isSelected = false;
  List<String> listImages = [
    "https://cdn-icons-png.flaticon.com/512/3940/3940417.png",
    "https://cdn-icons-png.flaticon.com/512/4139/4139981.png",
    "https://cdn-icons-png.flaticon.com/512/6997/6997662.png"
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
      builder: ((context, value, child) => SafeArea(
            child: Scaffold(
              backgroundColor:
                  value.isdark ? const Color(0xff333333) : Colors.white,
              body: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Head(
                        value: value,
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listImages.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 100,
                              width: 90,
                              child: Image.network(
                                listImages[index],
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CustomInput(
                              controller: controllerUser,
                              hintText: 'Usuario',
                              icon: Icons.people,
                              value: value.isdark,
                            ),
                            CustomInput(
                              controller: controllerDescription,
                              hintText: 'Descricao',
                              icon: Icons.description,
                              value: value.isdark,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: size.height * 0.05,
                                child: ListView.separated(
                                  separatorBuilder: ((context, index) =>
                                      const SizedBox(
                                        width: 20,
                                      )),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: listColors.length,
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          indexSelected = index;
                                        });
                                      }),
                                      child: Container(
                                        height: size.height * 0.02,
                                        width: size.width * 0.07,
                                        decoration: BoxDecoration(
                                          color: Color(listColors[index]),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(
                                            width: 2,
                                            color: index == indexSelected
                                                ? Colors.black
                                                : Colors.black26,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isSelected,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: Column(
                                  children: [
                                    CustomInput(
                                      hintText: 'Host:',
                                      icon: null,
                                      value: value.isdark,
                                      controller: controllerHost,
                                    ),
                                    CustomInput(
                                      hintText: 'Porta:',
                                      icon: null,
                                      value: value.isdark,
                                      controller: controllerPort,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelected = !isSelected;
                                    });
                                  },
                                ),
                                Text(
                                  'Server',
                                  style: TextStyle(
                                    color: value.isdark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ButtonNext(
                              controllerUser: controllerUser,
                              controllerDescription: controllerDescription,
                              controllerHost: controllerHost,
                              controllerPort: controllerPort,
                              listColors: listColors,
                              indexSelected: indexSelected,
                              isSelected: isSelected,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
