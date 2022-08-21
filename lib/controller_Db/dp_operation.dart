abstract class DpOparetion<T>{
  Future<int> creat(T Object);
  Future<List<T>> read();
  Future<bool> updat(T Object);
  Future<bool> delet(int id);
  Future<T?> show(int id);
}