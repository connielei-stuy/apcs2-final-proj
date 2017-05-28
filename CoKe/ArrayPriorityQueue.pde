import java.util.ArrayList;

public class ArrayPriorityQueue<T> implements Comparable<T> {

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

/*
  public T peekMin() {
    if (isEmpty()) //exception throwing according to the API
      throw new RuntimeException();
    else {
      T temp = _queue.get(0);
      for (int counter = 1; counter < _queue.size(); counter ++) {
        if ((_queue.get(counter).compareTo(temp)) < 0)
          temp = _queue.get(counter);
      }
      return temp;
    }
  }*/

  public T removeMin() {
    if (isEmpty())
      throw new RuntimeException();
    int position = 0;
    /*
    for (int counter = 1; counter < _queue.size(); counter ++) {
      if (_queue.get(counter).compareTo(_queue.get(position)) < 0) 
        position = counter;
    }*/
    return _queue.remove(position);
  }
  
  int compareTo(T other) {
    return 1;
  }

  public String toString() {
    String print = "[";
    for (T i : _queue) 
      print += " " + i;
    print += " ]";
    return print;
  }
  
}