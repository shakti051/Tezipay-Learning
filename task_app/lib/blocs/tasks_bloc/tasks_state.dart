part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  const TasksState({
    this.pendingTask = const [],
    this.removedTask = const [],
    this.completedTask = const [],
    this.favoriteTask = const [],
  });

  final List<Task> pendingTask;
  final List<Task> removedTask;
  final List<Task> completedTask;
  final List<Task> favoriteTask;

  @override
  List<Object> get props => [
    pendingTask,
    removedTask,
    completedTask,
    favoriteTask,
  ];

  Map<String, dynamic> toMap() {
    return {
      'pendingTasks': pendingTask.map((x) => x.toMap()).toList(),
      'removedTask': removedTask.map((x) => x.toMap()).toList(),
      'completedTask': completedTask.map((x) => x.toMap()).toList(),
      'favoriteTask': favoriteTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTask: List<Task>.from(
        map['pendingTasks']?.map((x) => Task.fromMap(x)),
      ),
      removedTask: List<Task>.from(
        map['removedTask']?.map((x) => Task.fromMap(x)),
      ),
      completedTask: List<Task>.from(
        map['completedTask']?.map((x) => Task.fromMap(x)),
      ),
      favoriteTask: List<Task>.from(
        map['favoriteTask']?.map((x) => Task.fromMap(x)),
      ),
    );
  }
}
