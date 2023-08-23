part of 'initial_page_cubit.dart';

abstract class InitialPageState extends Equatable {
  const InitialPageState();
}

class InitialPageInitial extends InitialPageState {
  @override
  List<Object> get props => [];
}

class InitialPageShowLoading extends InitialPageState {
  @override
  List<Object> get props => [];
}

class InitialPageErrorHideLoading extends InitialPageState {
  final String error;

  const InitialPageErrorHideLoading(this.error);

  @override
  List<Object> get props => [error];
}

class InitialPageSuccessWithHideLoading extends InitialPageState {
  final List<Videos> videos;

  const InitialPageSuccessWithHideLoading(this.videos);

  @override
  List<Object> get props => [videos];
}
