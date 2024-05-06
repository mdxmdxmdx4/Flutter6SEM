
import 'package:bloc/bloc.dart';

abstract class CarouselEvent {}
class CarouselNextEvent extends CarouselEvent {}
class CarouselPrevEvent extends CarouselEvent {}

class CarouselState {
  final int currentIndex;
  CarouselState(this.currentIndex);
}

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselState(0));

  @override
  Stream<CarouselState> mapEventToState(CarouselEvent event) async* {
    if (event is CarouselNextEvent) {
      yield CarouselState(state.currentIndex + 1);
    } else if (event is CarouselPrevEvent) {
      yield CarouselState(state.currentIndex - 1);
    }
  }
}
