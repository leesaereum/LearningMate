import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learning_mate_app/diamond/diamondResult.dart';

class DiamondPredict extends StatefulWidget {
  const DiamondPredict({Key? key}) : super(key: key);

  @override
  State<DiamondPredict> createState() => _DiamondPredictState();
}

class _DiamondPredictState extends State<DiamondPredict> {
  TextEditingController carat = TextEditingController();
  TextEditingController depth = TextEditingController();
  TextEditingController table = TextEditingController();
  TextEditingController x = TextEditingController();
  TextEditingController y = TextEditingController();
  TextEditingController z = TextEditingController();
  int cut = 0;
  int color = 0;
  int clarity = 0;
  List cutlist = ["Fair", "Good", "Very Good", "Premium", "Ideal"];
  List colorlist = ["J", "I", "H", "G", "F", "E", "D"];
  List claritylist = ["I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/MainLogo2.png", width: 200),
        backgroundColor: const Color.fromRGBO(250, 250, 250, 2),
        elevation: 0.8,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: carat,
                  decoration: InputDecoration(
                    labelText: 'carat',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: depth,
                  decoration: InputDecoration(
                    labelText: 'depth',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: table,
                  decoration: InputDecoration(
                    labelText: 'table',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: x,
                  decoration: InputDecoration(
                    labelText: 'x',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: y,
                  decoration: InputDecoration(
                    labelText: 'y',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: z,
                  decoration: InputDecoration(
                    labelText: 'z',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromARGB(255, 4, 31, 56)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Cut",
                  style: TextStyle(fontSize: 24),
                ),
                // cut 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (cut == 0) {
                            cut = cutlist.length - 1;
                          } else {
                            cut = cut - 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_left),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 100,
                      child: Center(
                          child: Text(
                        cutlist[cut],
                        style: const TextStyle(fontSize: 20),
                      )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (cut == cutlist.length - 1) {
                            cut = 0;
                          } else {
                            cut = cut + 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_right),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Color",
                  style: TextStyle(fontSize: 24),
                ),
                // Color 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (color == 0) {
                            color = colorlist.length - 1;
                          } else {
                            color = color - 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_left),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 100,
                      child: Center(
                          child: Text(
                        colorlist[color],
                        style: const TextStyle(fontSize: 20),
                      )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (color == colorlist.length - 1) {
                            color = 0;
                          } else {
                            color = color + 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_right),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Clarity",
                  style: TextStyle(fontSize: 24),
                ),
                // Clarity 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (clarity == 0) {
                            clarity = claritylist.length - 1;
                          } else {
                            clarity = clarity - 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_left),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 100,
                      child: Center(
                          child: Text(
                        claritylist[clarity],
                        style: const TextStyle(fontSize: 20),
                      )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (clarity == claritylist.length - 1) {
                            clarity = 0;
                          } else {
                            clarity = clarity + 1;
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_right),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 128, 0, 10),
                        minimumSize: Size(150, 40)),
                    onPressed: () {
                      if (carat.text.trim().isEmpty ||
                          depth.text.trim().isEmpty ||
                          table.text.trim().isEmpty ||
                          x.text.trim().isEmpty ||
                          y.text.trim().isEmpty ||
                          z.text.trim().isEmpty) {
                        nullSnackBar(context);
                      } else if (carat.text.split('.').length - 1 > 1 ||
                          depth.text.split('.').length - 1 > 1 ||
                          table.text.split('.').length - 1 > 1 ||
                          x.text.split('.').length - 1 > 1 ||
                          y.text.split('.').length - 1 > 1 ||
                          z.text.split('.').length - 1 > 1) {
                        pointSnackBar(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiamondResult(
                                carat: double.parse(carat.text),
                                cut: cut.toDouble(),
                                color: color.toDouble(),
                                clarity: clarity.toDouble(),
                                depth: double.parse(depth.text),
                                table: double.parse(table.text),
                                x: double.parse(x.text),
                                y: double.parse(y.text),
                                z: double.parse(z.text),
                              ),
                            ));
                      }
                    },
                    child: const Text("예측하기")),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  nullSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('빈칸을 전부 입력해 주세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  pointSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('숫자를 제대로 입력해 주세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }
}
