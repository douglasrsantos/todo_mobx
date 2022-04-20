import 'package:mobx/mobx.dart';
import 'package:todo_mobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {

  @observable
  String newTodoTitle = '';

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;

  //observable de List tem que ser declarado como ObservableList, senão não atualiza o estado
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo(){
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = '';
  }

}