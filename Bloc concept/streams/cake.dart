import 'dart:async';

class Cake {
  String yourCake = "eat your cake";
  Cake(this.yourCake);
}

class Order {
  String type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();

  final order = new Order('chocolate');

  final baker =
      new StreamTransformer.fromHandlers(handleData: (cakeType, sink) {
    if (cakeType == 'chocolate') {
      sink.add(new Cake("eat it"));
    } else {
      sink.addError('I cant bake that type!!!');
    }
  });

  controller.sink.add(order);

  controller.stream.map((order) => order.type).transform(baker).listen(
      (cake) => print('Heres your cake ${cake}'),
      onError: (err) => print(err));
}