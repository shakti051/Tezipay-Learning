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
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
   // on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
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

  void _onMarkFavoriteOrUnfavoriteTask(
      MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
        final state = this.state;
        List<Task> pendingTask = state.pendingTask;
        List<Task> completedTask = state.completedTask;
        List<Task> favoriteTask = state.favoriteTask;
        if(event.task.isDone == false){
          if(event.task.isFavorite == false){
          var taskIndex = pendingTask.indexOf(event.task);
          pendingTask = List.from(pendingTask)..remove(event.task)..insert(taskIndex,event.task.copyWith(isFavorite: true));
          favoriteTask.insert(0, event.task.copyWith(isFavorite: true));                
          }else{
            var taskIndex = pendingTask.indexOf(event.task);
            pendingTask = List.from(pendingTask)..remove(event.task)..insert(taskIndex, event.task.copyWith(isFavorite: true));
            favoriteTask.remove(event.task);
          }
        }else{
          if(event.task.isFavorite == false){
              var taskIndex = completedTask.indexOf(event.task);
              completedTask = List.from(completedTask)..remove(event.task)..insert(taskIndex,event.task.copyWith(isFavorite: true));
              favoriteTask.insert(0,event.task.copyWith(isFavorite: true));
          } else {
            var taskIndex = completedTask.indexOf(event.task);
            completedTask = List.from(completedTask)..remove(event.task)..insert(taskIndex,event.task.copyWith(isFavorite: false));
            favoriteTask.remove(event.task);
          }
        }
        emit((TasksState(
          pendingTask: pendingTask,
          completedTask: completedTask,
          favoriteTask: favoriteTask,
          removedTask: state.removedTask
        )));
      }

  // void _onMarkFavoriteOrUnfavoriteTask(
  //     MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {
  //   final state = this.state;
  //   List<Task> pendingTasks = state.pendingTask;
  //   List<Task> completedTasks = state.completedTask;
  //   List<Task> favoriteTasks = state.favoriteTask;
  //   if (event.task.isDone == false) {
  //     if (event.task.isFavorite == false) {
  //       var taskIndex = pendingTasks.indexOf(event.task);
  //       pendingTasks = List.from(pendingTasks)
  //         ..remove(event.task)
  //         ..insert(taskIndex, event.task.copyWith(isFavorite: true));
  //       favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
  //     } else {
  //       var taskIndex = pendingTasks.indexOf(event.task);
  //       pendingTasks = List.from(pendingTasks)
  //         ..remove(event.task)
  //         ..insert(taskIndex, event.task.copyWith(isFavorite: false));
  //       favoriteTasks.remove(event.task);
  //     }
  //   } else {
  //     if (event.task.isFavorite == false) {
  //       var taskIndex = completedTasks.indexOf(event.task);
  //       completedTasks = List.from(completedTasks)
  //         ..remove(event.task)
  //         ..insert(taskIndex, event.task.copyWith(isFavorite: true));
  //       favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
  //     } else {
  //       var taskIndex = completedTasks.indexOf(event.task);
  //       completedTasks = List.from(completedTasks)
  //         ..remove(event.task)
  //         ..insert(taskIndex, event.task.copyWith(isFavorite: false));
  //       favoriteTasks.remove(event.task);
  //     }
  //   }
  //   emit(TasksState(
  //     pendingTask: pendingTasks,
  //     completedTask: completedTasks,
  //     favoriteTask: favoriteTasks,
  //     removedTask: state.removedTask,
  //   ));
  // }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTasks = state.favoriteTask;
    if (event.oldTask.isFavorite == true) {
      favouriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(
      TasksState(
        pendingTask: List.from(state.pendingTask)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTask: state.completedTask..remove(event.oldTask),
        favoriteTask: favouriteTasks,
        removedTask: state.removedTask,
      ),
    );
  }

  //void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {}

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {}

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
