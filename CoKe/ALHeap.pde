import java.util.ArrayList;

class ALHeap<T extends Location<T>>
{
  ArrayList<T> _heap;
  float x, y;

  ALHeap(float Ex, float Ey) { 
    _heap = new ArrayList<T>();
    x = Ex;
    y = Ey;
  }

  boolean isEmpty() { 
    return _heap.isEmpty();
  }

  T peekMin() { 
    if (_heap.size() < 1 )
      return null;
    else
      return _heap.get(0);
  }

  void add( T addVal ) { 
    _heap.add( addVal );

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) {
      parentPos = (addValPos-1) / 2;

      if ( compareTo(addVal, _heap.get(parentPos)) < 0 ) {
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } 
      else 
        break;
    }
  }

  float compareTo(T a, T b) {
    float distA = dist(a.getX(), a.getY(), x, y);
    float distB = dist(b.getX(), b.getY(), x, y);
    return distA - distB;
  }

  T removeMin() 
  {
    if ( _heap.size() == 0 ) 
      return null;

    //store root value for return at end of fxn
    T retVal = peekMin();

    //store val about to be swapped into root
    T foo = _heap.get( _heap.size() - 1);

    //swap last (rightmost, deepest) leaf with root
    swap( 0, _heap.size() - 1 );

    //lop off last leaf
    _heap.remove( _heap.size() - 1);

    // walk the now-out-of-place root node down the tree...
    int pos = 0;
    int minChildPos;

    while ( pos < _heap.size() ) {

      minChildPos = minChildPos(pos);

      if ( minChildPos == -1 ) 
        break;
      else if ( compareTo(foo, _heap.get(minChildPos)) <= 0 ) 
        break;
      else {
        swap( pos, minChildPos );
        pos = minChildPos;
      }
    }
    return retVal;
  }

  int minChildPos( int pos ) 
  {
    int retVal;
    int lc = 2*pos + 1; 
    int rc = 2*pos + 2; 

    if ( pos < 0 || pos >= _heap.size() || lc >= _heap.size() )
      retVal = -1;
    else if ( rc >= _heap.size() )
      retVal = lc;
    else if ( compareTo(_heap.get(lc),_heap.get(rc)) < 0 )
      retVal = lc;
    else
      retVal = rc;
    return retVal;
  }

  T minOf( T a, T b ) 
  {
    if ( compareTo(a, b) < 0 )
      return a;
    else
      return b;
  }

  void swap( int pos1, int pos2 ) 
  {
    _heap.set( pos1, _heap.set( pos2, _heap.get(pos1) ) );
  }
}