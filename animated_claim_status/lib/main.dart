import 'dart:math';
import 'package:animated_claim_status/custom_stepper.dart';
import 'package:animated_claim_status/custom_stepper_demo.dart';
import 'package:animated_claim_status/example_eight.dart';
import 'package:animated_claim_status/example_eighteen.dart';
import 'package:animated_claim_status/example_eleven.dart';
import 'package:animated_claim_status/example_fifteen.dart';
import 'package:animated_claim_status/example_five.dart';
import 'package:animated_claim_status/example_four.dart';
import 'package:animated_claim_status/example_fourteen.dart';
import 'package:animated_claim_status/example_nine.dart';
import 'package:animated_claim_status/example_nineteen.dart';
import 'package:animated_claim_status/example_one.dart';
import 'package:animated_claim_status/example_reproduce_issues.dart';
import 'package:animated_claim_status/example_seven.dart';
import 'package:animated_claim_status/example_seventeen.dart';
import 'package:animated_claim_status/example_six.dart';
import 'package:animated_claim_status/example_sixteen.dart';
import 'package:animated_claim_status/example_ten.dart';
import 'package:animated_claim_status/example_thirteen.dart';
import 'package:animated_claim_status/example_three.dart';
import 'package:animated_claim_status/example_twelve.dart';
import 'package:animated_claim_status/example_twenty.dart';
import 'package:animated_claim_status/example_twenty_one.dart';
import 'package:animated_claim_status/example_two.dart';
import 'package:animated_claim_status/linear_animation_demo.dart';
import 'package:animated_claim_status/loading_animation.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterStepProgressDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home:  CustomStepperDemo(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 18,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleOne(),
                    ),
                  );
                },
                child: const Text('Example One (Vertical)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleFive(),
                    ),
                  );
                },
                child: const Text('Example Five (Border)'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleSix(),
                    ),
                  );
                },
                child: const Text('Example Six (Positioned Labels)'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleSixteen(),
                    ),
                  );
                },
                child: const Text('Example Sixteen (CustomVerticalTimeLine)'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleNineteen(),
                    ),
                  );
                },
                child: const Text('Example Nineteen (RippleEffect node)'),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleTwentyOne(),
                    ),
                  );
                },
                child: const Text(
                  'Example Twenty One (CustomStepperWithoutLines)',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExampleReproduceIssues(),
                    ),
                  );
                },
                child: const Text('Reproduce Issue'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
//   int activeStep = 0;
//   int activeStep2 = 0;
//   int reachedStep = 0;
//   int upperBound = 5;
//   double progress = 0.2;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   int lastAnimatedLineIndex = -1; // Track the last animated line

//   Set<int> reachedSteps = <int>{0, 2, 4, 5};
//   final dashImages = [
//     'assets/1.png',
//     'assets/2.png',
//     'assets/3.png',
//     'assets/4.png',
//     'assets/5.png',
//   ];

//   void increaseProgress() {
//     if (progress < 1) {
//       setState(() => progress += 0.2);
//     } else {
//       setState(() => progress = 0);
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1), // Animation duration
//     );
//     _animation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
//           ..addListener(() {
//             setState(() {});
//           });
//     //     // Initial animation for the first completed line (e.g., Submitted to Initiated)
//     //     _animateLine(0);
//     incrementActiveStep();

//     super.initState();
//   }

//   incrementActiveStep() {
//     if (activeStep < 7) {
//       Future.delayed(Duration(seconds: 3), () {
//         setState(() {
//           activeStep++;
//           incrementActiveStep();
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Colors.white,
//         primarySwatch: Colors.purple,
//         colorScheme: ColorScheme.fromSwatch(
//           primarySwatch: Colors.purple,
//           accentColor: Colors.deepOrange,
//           backgroundColor: Colors.white,
//         ),
//       ),
//       home: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 EasyStepper(
//                   activeStep: activeStep,
//                   lineStyle: const LineStyle(
//                     lineLength: 50,
//                     lineType: LineType.normal,
//                     lineThickness: 3,
//                     lineSpace: 1,
//                     lineWidth: 10,
//                     unreachedLineType: LineType.dashed,
//                   ),
//                   stepShape: StepShape.circle,
//                   stepBorderRadius: 15,
//                   borderThickness: 2,
//                   internalPadding: 10,
//                   padding: const EdgeInsetsDirectional.symmetric(
//                     horizontal: 30,
//                     vertical: 20,
//                   ),
//                   stepRadius: 28,
//                   finishedStepBorderColor: Colors.deepOrange,
//                   finishedStepTextColor: Colors.deepOrange,
//                   finishedStepBackgroundColor: Colors.deepOrange,
//                   activeStepIconColor: Colors.deepOrange,
//                   showLoadingAnimation: false,
//                   steps: [
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 0 ? 1 : 0.3,
//                           child: Image.asset('assets/1.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Submitted',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 1 ? 1 : 0.3,
//                           child: Image.asset('assets/2.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 2',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 2 ? 1 : 0.3,
//                           child: Image.asset('assets/3.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 3',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 3 ? 1 : 0.3,
//                           child: Image.asset('assets/4.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 4',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     EasyStep(
//                       customStep: ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Opacity(
//                           opacity: activeStep >= 4 ? 1 : 0.3,
//                           child: Image.asset('assets/5.png'),
//                         ),
//                       ),
//                       customTitle: const Text(
//                         'Dash 5',
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                   onStepReached: (index) => setState(() => activeStep = index),
//                 ),
//                 //**Next stepper */
//                 EasyStepper(
//                   activeStep: activeStep,
//                   lineStyle: LineStyle(
//                     lineLength: 70,
//                     lineType: LineType.normal,
//                     lineThickness: 2,
//                     lineSpace: 0,
//                     lineWidth: 5,
//                     unreachedLineColor: Colors.grey,
//                     unreachedLineType: LineType.dashed,

//                     defaultLineColor: Colors.grey,
//                     finishedLineColor: Colors.green,
//                   ),
//                   unreachedStepBorderType: BorderType.normal,
//                   unreachedStepBorderColor: Colors.grey,
//                   finishedStepBorderType: BorderType.normal,
//                   stepShape: StepShape.circle,
//                   stepBorderRadius: 15,
//                   activeStepBackgroundColor: Colors.orangeAccent,
//                   borderThickness: 2,
//                   internalPadding: 10,
//                   // padding: const EdgeInsetsDirectional.symmetric(
//                   //   horizontal: 30,
//                   //   vertical: 20
//                   // ),
//                   stepRadius: 28,
//                   unreachedStepBackgroundColor: const Color.fromARGB(
//                     59,
//                     236,
//                     234,
//                     234,
//                   ),
//                   finishedStepBorderColor: Colors.green,
//                   finishedStepBackgroundColor: Colors.white,
//                   activeStepTextColor: Colors.black87,
//                   stepAnimationDuration: Duration(seconds: 10),
//                   finishedStepTextColor: Colors.green,
//                   showTitle: true,
//                   //titlesAreLargerThanSteps: true,
//                   showLoadingAnimation: false,
//                   showStepBorder: true,
//                   stepAnimationCurve: Curves.ease,
//                   steps: [
//                     EasyStep(

//                       enabled: 0 <= activeStep + 1,
//                       customStep: activeStep > 0
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("1"),
//                       //topTitle: 0 % 2 == 1,
//                       title: "Submitted",
//                       //  customTitle: const SizedBox(
//                       //  width: double.infinity,
//                       //    child: Text(
//                       //      "Success",
//                       //      textAlign: TextAlign.center,
//                       //    ),
//                       //  ),
//                     ),
//                     EasyStep(
//                       enabled: 1 <= activeStep + 1,
//                       customStep: activeStep > 1
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("2", style: TextStyle(color: Colors.grey)),
//                       //topTitle: 1 % 2 == 1,
//                       title: "Initiated",
//                       // customTitle: const SizedBox(
//                       //   width: double.infinity,
//                       //   child: Text(
//                       //     "Authorized",
//                       //     textAlign: TextAlign.center,
//                       //   ),
//                       // ),
//                     ),
//                     EasyStep(
//                       enabled: 2 <= activeStep + 1,
//                       customStep: activeStep > 2
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("3", style: TextStyle(color: Colors.grey)),
//                       //topTitle: 2 % 2 == 1,
//                       title: "Review",
//                     ),
//                     EasyStep(
//                       enabled: 3 <= activeStep + 1,
//                       customStep: activeStep > 3
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("4", style: TextStyle(color: Colors.grey)),
//                       //topTitle: 3 % 2 == 1,
//                       title: "Approve",
//                     ),
//                     EasyStep(
//                       enabled: 4 <= activeStep + 1,
//                       customStep: activeStep > 4
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("5", style: TextStyle(color: Colors.grey)),
//                       //topTitle: 4 % 2 == 1,
//                       title: "Extra",
//                     ),
//                     EasyStep(
//                       enabled: 5 <= activeStep + 1,
//                       customStep: activeStep >= 5
//                           ? Icon(Icons.check, color: Colors.green)
//                           : Text("6", style: TextStyle(color: Colors.grey)),
//                       //topTitle: 5 % 2 == 1,
//                       title: "Finish",
//                       // customTitle: const SizedBox(
//                       //   width: double.infinity,
//                       //   child: Text(
//                       //     "Customer personally",
//                       //     textAlign: TextAlign.center,
//                       //   ),
//                       // ),
//                     ),
//                   ],
//                   onStepReached: (index) => setState(() => activeStep = index),
//                 ),
//                 // const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: increaseProgress),
//       ),
//     );
//   }

//   bool _allowTabStepping(int index, StepEnabling enabling) {
//     return enabling == StepEnabling.sequential
//         ? index <= reachedStep
//         : reachedSteps.contains(index);
//   }

//   /// Returns the next button.
//   Widget _nextStep(StepEnabling enabling) {
//     return IconButton(
//       onPressed: () {
//         if (activeStep2 < upperBound) {
//           setState(() {
//             if (enabling == StepEnabling.sequential) {
//               ++activeStep2;
//               if (reachedStep < activeStep2) {
//                 reachedStep = activeStep2;
//               }
//             } else {
//               activeStep2 = reachedSteps.firstWhere(
//                 (element) => element > activeStep2,
//               );
//             }
//           });
//         }
//       },
//       icon: const Icon(Icons.arrow_forward_ios),
//     );
//   }

//   /// Returns the previous button.
//   Widget _previousStep(StepEnabling enabling) {
//     return IconButton(
//       onPressed: () {
//         if (activeStep2 > 0) {
//           setState(
//             () => enabling == StepEnabling.sequential
//                 ? --activeStep2
//                 : activeStep2 = reachedSteps.lastWhere(
//                     (element) => element < activeStep2,
//                   ),
//           );
//         }
//       },
//       icon: const Icon(Icons.arrow_back_ios),
//     );
//   }
// }

// enum StepEnabling { sequential, individual }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Initiator IT Equipment Claim')),
//         body: ClaimTracker(),
//       ),
//     );
//   }
// }

// class ClaimTracker extends StatefulWidget {
//   const ClaimTracker({super.key});

//   @override
//   _ClaimTrackerState createState() => _ClaimTrackerState();
// }

// class _ClaimTrackerState extends State<ClaimTracker>
//     with SingleTickerProviderStateMixin {
//   int currentStep = 2; // Current step is "Approve" (step 4)
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   int lastAnimatedLineIndex = -1; // Track the last animated line

//   final List<Map<String, dynamic>> steps = [
//     {'label': 'Submitted', 'date': '08 Jun 2025, 10:22', 'status': 'completed'},
//     {'label': 'Initiated', 'date': '09 Jun 2025, 10:22', 'status': 'active'},
//     {'label': 'Review', 'date': '18 Jun 2025, 10:13', 'status': 'pending'},
//     {
//       'label': 'Approve',
//       'date': '',
//       'status': 'pending',
//     }, // No date for current step
//     {'label': 'Extra', 'date': '18 Jun 2025, 10:25', 'status': 'pending'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1), // Animation duration
//     );
//     _animation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
//           ..addListener(() {
//             setState(() {});
//           });
//     // Initial animation for the first completed line (e.g., Submitted to Initiated)
//     _animateLine(0);
//     nextStep();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void nextStep() {
//     if (currentStep < steps.length) {
//       Future.delayed(Duration(seconds: 2), () {
//         nextStep();
//         setState(() {
//           steps[currentStep - 1]['status'] = 'completed';
//           currentStep++;
//           if (currentStep <= steps.length) {
//             steps[currentStep - 1]['status'] = 'active';
//             _animateLine(
//               currentStep - 2,
//             ); // Animate the new line (e.g., 2 for Approve to Extra)
//           }
//         });
//       });
//     }
//   }

//   void _animateLine(int index) {
//     lastAnimatedLineIndex = index;
//     _animationController.reset();
//     _animationController.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Initiator IT Equipment Claim',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Row(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       //               primary: Colors.white,
//                       side: BorderSide(color: Colors.green),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.history, color: Colors.green, size: 16),
//                         SizedBox(width: 4),
//                         Text(
//                           'View Status History',
//                           style: TextStyle(color: Colors.green),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       //                 primary: Colors.white,
//                       side: BorderSide(color: Colors.green),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.refresh, color: Colors.green, size: 16),
//                         SizedBox(width: 4),
//                         Text('Refresh', style: TextStyle(color: Colors.green)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Center(
//             child: Column(
//               //crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(steps.length, (index) {
//                     return Row(
//                       children: [
//                         _buildStep(index + 1, steps[index], true, true),
//                         if (index < steps.length - 1)
//                           index == lastAnimatedLineIndex
//                               ? AnimatedLine(index: index, opacity: 1)
//                               : _buildLine(index + 1, 1),
//                       ],
//                     );
//                   }),
//                 ),

//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: List.generate(steps.length, (index) {
//                 //     return Row(
//                 //       children: [
//                 //         _buildStep(index + 1, steps[index], false, true),
//                 //         index == lastAnimatedLineIndex
//                 //               ? AnimatedLine(index: index,opacity: 0)
//                 //               : _buildLine(index + 1,0),
//                 //       ],
//                 //     );
//                 //   }),
//                 // ),
//               ],
//             ),
//           ),
//           SizedBox(height: 20),
//           Center(
//             child: ElevatedButton(
//               onPressed: nextStep,
//               style: ElevatedButton.styleFrom(
//                 //             primary: Colors.green,
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               ),
//               child: Text('Next Step', style: TextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStep(
//     int stepNumber,
//     Map<String, dynamic> step,
//     bool iconVisibility,
//     bool statusVisibility,
//   ) {
//     bool isCompleted = step['status'] == 'completed';
//     bool isActive = step['status'] == 'active';
//     bool isPending = step['status'] == 'pending';
//     // Determine glow color and properties based on status
//     Color glowColor = isCompleted
//         ? Colors.green.withOpacity(0.5)
//         : isActive
//         ? Colors.orange.withOpacity(0.5)
//         : Colors.grey.withOpacity(0.3);
//     List<BoxShadow> glow = [
//       BoxShadow(
//         color: glowColor,
//         spreadRadius: 8,
//         blurRadius: 15,
//         offset: Offset(0, 0), // No offset for a centered glow
//       ),
//     ];
//     return Container(
//       color: Colors.amber,
//       // margin: EdgeInsets.symmetric(horizontal: -16),
//       // width: 100,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Visibility(
//             visible: iconVisibility,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 if (isActive)
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.orange, width: 2),
//                       boxShadow: glow, // Add glow effect
//                     ),
//                   ),
//                 SizedBox(
//                   width: 40,
//                   height: 40,
//                   // decoration: BoxDecoration(
//                   //   shape: BoxShape.circle,
//                   //   boxShadow: glow, // Add glow effect
//                   // ),
//                   child: CircleAvatar(
//                     radius: 18,
//                     backgroundColor: isCompleted
//                         ? Colors.green
//                         : isActive
//                         ? Colors.white
//                         : Colors.grey,
//                     child: isCompleted
//                         ? Icon(Icons.check, color: Colors.white, size: 20)
//                         : isActive
//                         ? Text(
//                             '$stepNumber',
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )
//                         : Text(
//                             '$stepNumber',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // SizedBox(height: 8),
//           Visibility(
//             visible: statusVisibility,
//             child: Text(
//               step['label'],
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isCompleted || isActive ? Colors.black : Colors.grey,
//               ),
//             ),
//           ),
//           //SizedBox(height: 4),
//           Visibility(
//             visible: statusVisibility,
//             child: Text(
//               step['date'],
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 10, color: Colors.grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepStatus(int stepNumber, Map<String, dynamic> step) {
//     bool isCompleted = step['status'] == 'completed';
//     bool isActive = step['status'] == 'active';
//     bool isPending = step['status'] == 'pending';
//     // Determine glow color and properties based on status
//     Color glowColor = isCompleted
//         ? Colors.green.withOpacity(0.5)
//         : isActive
//         ? Colors.orange.withOpacity(0.5)
//         : Colors.grey.withOpacity(0.3);
//     List<BoxShadow> glow = [
//       BoxShadow(
//         color: glowColor,
//         spreadRadius: 8,
//         blurRadius: 15,
//         offset: Offset(0, 0), // No offset for a centered glow
//       ),
//     ];
//     return Container(
//       //color: Colors.amber,
//       // margin: EdgeInsets.symmetric(horizontal: -16),
//       // width: 100,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             // margin: EdgeInsets.only(right: 24),
//             child: Text(
//               step['label'],
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isCompleted || isActive ? Colors.black : Colors.grey,
//               ),
//             ),
//           ),
//           // SizedBox(height: 4),
//           // Text(
//           //   step['date'],
//           //   textAlign: TextAlign.center,
//           //   style: TextStyle(fontSize: 10, color: Colors.grey),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLine(int stepNumber, double opacity) {
//     bool isCompleted = stepNumber < currentStep;
//     return Opacity(
//       opacity: opacity,
//       child: Container(
//         height: 4,
//         width: 60,
//         margin: EdgeInsets.only(bottom: 4),
//         // margin: EdgeInsets.symmetric(horizontal: 8),
//         child: CustomPaint(painter: LinePainter(isCompleted: isCompleted)),
//       ),
//     );
//   }

//   Widget AnimatedLine({required int index, required double opacity}) {
//     return Opacity(
//       opacity: opacity,
//       child: Container(
//         height: 4,
//         width: 60 * _animation.value, // Animate width from 0 to 60
//         margin: EdgeInsets.only(bottom: 4),
//         child: CustomPaint(
//           painter: LinePainter(
//             isCompleted: index + 1 < currentStep,
//           ), // Use currentStep to determine color
//         ),
//       ),
//     );
//   }
// }

// class LinePainter extends CustomPainter {
//   final bool isCompleted;

//   LinePainter({required this.isCompleted});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = isCompleted ? Colors.green : Colors.grey
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     if (!isCompleted) {
//       //     paint.pathEffect = PathEffect.dashPath([8.0, 4.0], 0.0); // Dashed line for pending
//     }

//     canvas.drawLine(
//       Offset(0, size.height / 2),
//       Offset(size.width, size.height / 2),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
