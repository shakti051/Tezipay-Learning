import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/blocs/bloc_exports.dart';
import '../../models/task.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(pendingTask: List.from(state.pendingTask)..add(event.task),
    removedTask: state.removedTask,
    completedTask: state.completedTask,
    favoriteTask: state.favoriteTask,
    ),
    );
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    //final int index = state.pendingTask.indexOf(task);
    List<Task> pendingTask = state.pendingTask;//
    List<Task> completedTask = state.completedTask;
    task.isDone == false
        ? {pendingTask = List.from(state.pendingTask)..remove(task),
           completedTask =  List.from(state.completedTask)..insert(0,task.copyWith(isDone: true))
        }
        : {completedTask = List.from(state.completedTask)..remove(task),
           pendingTask = List.from(state.pendingTask)..insert(0,task.copyWith(isDone: false)) 
        };
    emit(TasksState(
    pendingTask: pendingTask, 
    removedTask: state.removedTask,
    completedTask: completedTask,
    favoriteTask: state.favoriteTask
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTask: state.pendingTask,
        removedTask: List.from(state.removedTask)..remove(event.task),
        favoriteTask: state.favoriteTask,
        completedTask: state.completedTask
      ),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)..remove(event.task),
        completedTask: List.from(state.completedTask)..remove(event.task),
        favoriteTask: List.from(state.pendingTask)..remove(event.task),
        removedTask: List.from(state.removedTask)
          ..add(event.task.copyWith(isDeleted: true)),
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
