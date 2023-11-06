import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends StateNotifier<List<String>> {
  TodoNotifier() : super([]);

  void add(String todo) {
    state = [...state, todo];
  }

  void remove(String todo) {
    state = [...state.where((element) => element != todo)];
  }

  void update(String newTodo, String old) {
    List<String> updatedList = [];
    for (var i = 0; i < state.length; i++) {
      if (state[i] == old) {
        updatedList.add(newTodo);
      } else {
        updatedList.add(state[i]);
      }
    }
    state = updatedList;
  }
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<String>>((ref) => TodoNotifier());
