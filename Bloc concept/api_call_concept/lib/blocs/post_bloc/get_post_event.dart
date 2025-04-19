import 'package:equatable/equatable.dart';

abstract class GetPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPostsEvent extends GetPostEvent {}
