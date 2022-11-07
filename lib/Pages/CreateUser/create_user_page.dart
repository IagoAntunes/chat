import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socketfront/Pages/CreateUser/widgets/custom_buton_next.dart';
import 'package:socketfront/Providers/theme_provider.dart';
import '../../Config/config.dart';
import '../../Widgets/input_widget.dart';
import 'widgets/head_widget.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  int indexSelected = 0;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: ((context, value, child) => SafeArea(
            child: Scaffold(
              backgroundColor:
                  value.isdark ? const Color(0xff333333) : Colors.white,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Head(
                    isDark: value.isdark,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.camera_enhance_sharp,
                        color: Colors.grey,
                        size: 70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomInput(
                          controllerDescription: controllerUser,
                          hintText: 'Usuario',
                          icon: Icons.people,
                          value: value.isdark,
                        ),
                        CustomInput(
                          controllerDescription: controllerDescription,
                          hintText: 'Descricao',
                          icon: Icons.description,
                          value: value.isdark,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 30,
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
                                    height: 20,
                                    width: 30,
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
                                color:
                                    value.isdark ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        ButtonNext(
                          controllerUser: controllerUser,
                          controllerDescription: controllerDescription,
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
          )),
    );
  }
}
