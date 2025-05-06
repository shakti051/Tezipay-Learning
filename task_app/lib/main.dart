import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import 'package:task_app/blocs/my_bloc_observer.dart';
import 'package:task_app/blocs/switch/switch_bloc.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/screens/tabs_screen.dart';
import 'package:task_app/screens/pending_screen.dart';
import 'package:task_app/services/app_theme.dart';
import 'services/app_router.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  //Bloc.observer = MyBlocObserver();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            debugShowCheckedModeBanner: false,
            theme:state.switchValue 
                    ? AppThemes.appThemeData[AppTheme.darkTheme]
                    : AppThemes.appThemeData[AppTheme.lightTheme],
            home: TabsScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
