import java.util.ArrayList;

public class ArrayPriorityQueue<T extends Comparable<T>>
{

  private ArrayList<T> _queue;

  public ArrayPriorityQueue() {
    _queue = new ArrayList<T>();
  }

  public void add(T x) {
    _queue.add(x);
  }

  public boolean isEmpty() {
    return _queue.isEmpty();
  }

  public T peekMin() {
    if (isEmpty()) //exception throwing according to the API
      throw new RuntimeException();
    return _queue.get(0);
  }


  public T removeMin() {
    if (isEmpty())
      throw new RuntimeException();
    T temp = peekMin();
    _queue.remove(0);
    return temp;
  }

  public String toString() {
    String print = "[";
    for (T i : _queue) 
      print += " " + i;
    print += " ]";
    return print;
  }
}