import 'package:flutter/material.dart';
import 'package:step_progress/step_progress.dart';

class ExampleSix extends StatefulWidget {
  const ExampleSix({super.key});

  @override
  State<ExampleSix> createState() => _ExampleSixState();
}

class _ExampleSixState extends State<ExampleSix> {
  final stepProgressController = StepProgressController(totalSteps: 5);
  int myCompletedIndex = 0;
  int myIndex = 0;
  
  @override
  void initState() {
    super.initState();
    completeProcessAutomatic();
  }

  completeProcessAutomatic() {
    Future.delayed(Duration(seconds: 3), () {
      if (stepProgressController.currentStep < 5) {
        stepProgressController.nextStep();
        completeProcessAutomatic();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StepProgress -  position label')),
      body: Column(
        spacing: 48,
        children: [
          StepProgress(
            totalSteps: 5,
            padding: const EdgeInsets.all(28),
            controller: stepProgressController,

            nodeTitles: const [
              'Submit',
              'Initiated',
              'Review',
              'Approve',
              'Extra',
            ],
            nodeSubTitles: [
              '10:20 PM',
              '11:30 AM',
              '09:20 PM',
              '08:20 PM',
              '07:10 AM',
            ],
            lineSubTitles: [
              'Dec 20, 2025',
              'Dec 21, 2025',
              'Dec 22, 2025',
              'Dec 23, 2025',
            ],
            // lineSubTitles: ['Step 11',
            //   'Step 22',
            //   'Step 33',
            //   'Step 44'],
            onStepChanged: (currentIndex) {},
            nodeIconBuilder: (index, completedStepIndex) {
              final isCurrent = index == stepProgressController.currentStep;
              final isCompleted = completedStepIndex > index;
              myIndex = index;
              myCompletedIndex = completedStepIndex;
              return completedStepIndex <= index
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCurrent
                            ? Colors.orange
                            : (isCompleted ? Colors.green : Colors.grey),
                        //color: isCurrent ? Colors.white : Colors.grey,
                        border: isCurrent
                            ? Border.all(color: Colors.orange, width: 3)
                            : Border.all(color: Colors.grey, width: 3),
                        boxShadow: isCurrent
                            ? [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.5),
                                  blurRadius: 12,
                                  spreadRadius: 4,
                                ),
                              ]
                            : [],
                      ),
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: isCurrent
                                ? TextStyle(color: Colors.grey, fontSize: 12)
                                : TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ),
                    )
                  : Icon(Icons.check, color: Colors.white);
            },
            theme: StepProgressThemeData(
              nodeLabelAlignment: StepLabelAlignment.bottom,
              activeForegroundColor: myCompletedIndex <= myIndex
                  ? Colors.green
                  : Colors.orange,
              defaultForegroundColor: Colors.grey,
              shape: StepNodeShape.circle,
              stepAnimationDuration: Duration(seconds: 0),
              stepLineSpacing: 2,
              stepLineStyle: StepLineStyle(
              
                lineThickness: 2,
                activeColor: myCompletedIndex <= myIndex
                    ? Colors.green
                    : Colors.grey,
                animationDuration: Duration(seconds: 2),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 38,
            children: [
              ElevatedButton(
                onPressed: stepProgressController.previousStep,
                child: const Text('Prev'),
              ),
              ElevatedButton(
                onPressed: stepProgressController.nextStep,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


