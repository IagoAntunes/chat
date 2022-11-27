import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  int indexImage = 0;

  Color pickerColor = Color(0xFF02F322);
  Color currentColor = const Color(0xff443a49);
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

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
                        width: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexImage = index;
                                });
                              },
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    width: 120,
                                    child: Image.network(
                                      listImages[index],
                                    ),
                                  ),
                                  indexImage == index
                                      ? Positioned(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomInput(
                              controller: controllerUser,
                              hintText: 'User',
                              icon: Icons.people,
                              value: value.isdark,
                            ),
                            CustomInput(
                              controller: controllerDescription,
                              hintText: 'Description',
                              icon: Icons.description,
                              value: value.isdark,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Stack(
                                              children: [
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minWidth: 90,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                      color: currentTheme.isdark
                                                          ? const Color(
                                                              0xff1C2D35)
                                                          : Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'Joao',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      pickerColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 15),
                                                            child: Text(
                                                              'Ola Luiz, Tudo bem ?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: currentTheme
                                                                        .isdark
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Positioned(
                                                  right: 5,
                                                  bottom: 2,
                                                  child: Text(
                                                    '14:30',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          MaterialPicker(
                                            pickerColor: pickerColor,
                                            onColorChanged: (value) {
                                              setState(() {
                                                pickerColor = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      // Use Material color picker:
                                      //
                                      // child: MaterialPicker(
                                      //   pickerColor: pickerColor,
                                      //   onColorChanged: changeColor,
                                      //   showLabel: true, // only on portrait mode
                                      // ),
                                      //
                                      // Use Block color picker:
                                      //
                                      // child: BlockPicker(
                                      //   pickerColor: currentColor,
                                      //   onColorChanged: changeColor,
                                      // ),
                                      //
                                      // child: MultipleChoiceBlockPicker(
                                      //   pickerColors: currentColors,
                                      //   onColorsChanged: changeColors,
                                      // ),
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Got it'),
                                        onPressed: () {
                                          setState(
                                              () => currentColor = pickerColor);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.color_lens,
                                color: pickerColor,
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
                                      hintText: 'Port:',
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
                            Center(
                              child: ButtonNext(
                                controllerUser: controllerUser,
                                controllerDescription: controllerDescription,
                                controllerHost: controllerHost,
                                controllerPort: controllerPort,
                                isSelected: isSelected,
                                selectedColor: pickerColor,
                                indexImage: indexImage,
                              ),
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
