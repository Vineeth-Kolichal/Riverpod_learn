import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/providers/todo_provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('making conflict');
    final todoList = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Todo add git testing'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () {
                  TextEditingController controller =
                      TextEditingController(text: todoList[index]);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('update todo'),
                      content: TextField(
                        controller: controller,
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(todoProvider.notifier)
                                  .update(controller.text, todoList[index]);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Add'))
                      ],
                    ),
                  );
                },
                title: Text('${todoList[index]}'),
                trailing: IconButton(
                    onPressed: () {
                      ref.read(todoProvider.notifier).remove(todoList[index]);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: todoList.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController controller = TextEditingController();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add todo'),
              content: TextField(
                controller: controller,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(todoProvider.notifier).add(controller.text);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'))
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
