import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog.dart';

class SelectedDogsNotifier extends StateNotifier<List<Dog>> {
  SelectedDogsNotifier() : super([]);

  void setDogs(List<Dog> dogs) {
    state = dogs;
  }

  void addDog(Dog dog) {
    if (!state.contains(dog)) {
      state = [...state, dog];
    }
  }

  void removeDog(Dog dog) {
    state = state.where((d) => d.id != dog.id).toList();
  }

  void clearDogs() {
    state = [];
  }
}

final selectedDogsProvider = StateNotifierProvider<SelectedDogsNotifier, List<Dog>>((ref) {
  return SelectedDogsNotifier();
}); 