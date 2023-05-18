import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.summaryData});
  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((data) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsetsDirectional.only(end: 16),
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(
                        eccentricity: 0,
                      ),
                      color: data['answer'] != data['user_answer']
                          ? Colors.pink
                          : Colors.lightGreen,
                    ),
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['question'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['user_answer'] as String,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 145, 234, 148)),
                      ),
                      Text(
                        data['answer'] as String,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 99, 185, 197),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
