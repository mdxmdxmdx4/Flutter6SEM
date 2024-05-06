import 'package:bloc/bloc.dart';

abstract class PageEvent {}
class NextPageEvent extends PageEvent {}
class PreviousPageEvent extends PageEvent {}

class PageState {
  final int currentPage;
  PageState(this.currentPage);
}

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageState(0));

  @override
  Stream<PageState> mapEventToState(PageEvent event) async* {
    if (event is NextPageEvent) {
      yield PageState(state.currentPage + 1);
    } else if (event is PreviousPageEvent) {
      yield PageState(state.currentPage - 1);
    }
  }
}
