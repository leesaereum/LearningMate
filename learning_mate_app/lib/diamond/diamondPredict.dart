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
  TextEditingController y = TextEditingController();
  int clarity = 0;
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "다이아몬드 정보 입력하기",
                  style: TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 77, 3, 10),
                  ),
                  
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Carat",
                  style: TextStyle(fontSize: 24,
                  color: Color.fromRGBO(0, 77, 3, 10),),
                ),
                const SizedBox(
                  height: 10,
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
                          width: 2, color: Color.fromRGBO(0, 77, 3, 10)),
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
                  "Width",
                  style: TextStyle(fontSize: 24,
                  color: Color.fromRGBO(0, 77, 3, 10),),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: y,
                  decoration: InputDecoration(
                    labelText: 'width',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Color.fromRGBO(0, 77, 3, 10)),
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
                  "Clarity",
                  style: TextStyle(fontSize: 24,
                  color: Color.fromRGBO(0, 77, 3, 10),),
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
                  height: 70,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(255, 128, 0, 10),
                      minimumSize: const Size(150, 40),
                      maximumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (carat.text.trim().isEmpty || y.text.trim().isEmpty) {
                        nullSnackBar(context);
                      } else if (carat.text.split('.').length - 1 > 1 ||
                          y.text.split('.').length - 1 > 1) {
                        pointSnackBar(context);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiamondResult(
                                carat: double.parse(carat.text),
                                clarity: clarity.toDouble(),
                                y: double.parse(y.text),
                              ),
                            ));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "예측하기",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )),
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
