import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  const CustomStepper({super.key});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  List title = ['test', 'test2', 'test3', 'test4'];
  int step = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                for (int i = 0; i < title.length - 1; i++)
                  Expanded(
                      child: Row(
                    children: [
                      circleStepper(i),
                      Expanded(child: lineStepper(i))
                    ],
                  )),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: circleStepper(title.length),
                )
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              for (int i = 0; i < title.length - 1; i++)
                Expanded(child: stepperTitle(i)),
              stepperTitle(title.length - 1)
            ],
          ))
        ],
      ),
    );
  }

  Widget stepperTitle(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'STEP ${index + 1}',
            style: TextStyle(
                color: Colors.black.withOpacity(.3),
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title.elementAt(index),
            style: TextStyle(
                color:
                    index <= step ? Colors.black : Colors.black.withOpacity(.5),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          stepperStatus(index)
        ],
      ),
    );
  }

  Widget stepperStatus(int index) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: index == step
              ? Colors.blueAccent.withOpacity(.4)
              : index < step
                  ? Colors.green.withOpacity(.3)
                  : Colors.black.withOpacity(.1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              index == step
                  ? 'In Progress'
                  : index < step
                      ? 'Completed'
                      : 'Pending',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: index == step
                      ? Colors.blueAccent
                      : index < step
                          ? Colors.green
                          : Colors.black.withOpacity(.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Widget lineStepper(int index) {
    return Container(
      width: double.infinity,
      height: 5,
      color: index < step ? Colors.black : Colors.black.withOpacity(.2),
    );
  }

  Widget circleStepper(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.5),
          border: Border.all(
              color: index > step ? Colors.black.withOpacity(.1) : Colors.black,
              width: 2,
              style: BorderStyle.solid)),
      child: Container(
        margin: EdgeInsets.all(index == step ? 2 : 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index > step ? Colors.black.withOpacity(.1) : Colors.black),
        child: step > index
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 20,
              )
            : step < index
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black, width: 1)),
                  )
                : Text('${index + 1}',
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
