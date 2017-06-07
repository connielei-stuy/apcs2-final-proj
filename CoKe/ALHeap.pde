//used for pathfinding for enemies

import java.util.ArrayList;

class ALHeap<T extends Location<T>> {
  ArrayList<T> _heap;
  float x, y;

  ALHeap(float Ux, float Uy) { 
    _heap = new ArrayList<T>();
    x = Ux;
    y = Uy;
  }

  /*=========================================
  precond: _heap exists
  postcond: returns true if heap is empty, false otherwise
  =========================================*/
  boolean isEmpty() { 
    return _heap.isEmpty();
  }

  /*=========================================
  precond: _heap exists
  postcond: returns smallest element in _heap
  =========================================*/
  T peekMin(){ 
    if (_heap.size() < 1 )
      return null;
    else
      return _heap.get(0);
  }

  /*=========================================
  precond: _heap exists
  postcond: inserts a value in the heap where appropriate
  =========================================*/
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

  /*=========================================
  precond: _heap exists
  postcond: removes and returns the smallest value in the heap
  returns null if nothing to remove
  =========================================*/
  T removeMin() {
    if ( _heap.size() == 0 ) 
      return null;
      
    T retVal = peekMin();

    T foo = _heap.get( _heap.size() - 1);

    swap( 0, _heap.size() - 1 );

    _heap.remove( _heap.size() - 1);
    
    int pos = 0;
    int minChildPos;

    while ( pos < _heap.size() ){

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

  /*=========================================
  precond: _heap exists
  postcond: returns smaller child of a parent in position pos
  =========================================*/
  int minChildPos( int pos ) {
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

  /*=========================================
  precond: 
  postcond: returns smaller of two elements
  =========================================*/
  T minOf( T a, T b ){
    if ( compareTo(a, b) < 0 )
      return a;
    else
      return b;
  }

  /*=========================================
  precond: 
  postcond: returns positive number if a is farther than b from a point
  returns negative number if a is closer than b to a point 
  returns zero if a and b are equidistant to a point
  =========================================*/
  float compareTo(T a, T b) {
    float distA = dist(a.getX(), a.getY(), x, y);
    float distB = dist(b.getX(), b.getY(), x, y);
    return distA - distB;
  }

  /*=========================================
  precond: _heap exists and size >= 2
  postcond: swap elements in two positions
  =========================================*/
  void swap( int pos1, int pos2 ){
    _heap.set( pos1, _heap.set( pos2, _heap.get(pos1) ) );
  }
  
  String toString(){
    String retStr = "";
    for(T t : _heap){
      retStr += t + " ";
    }
    return retStr;
  }
  
}