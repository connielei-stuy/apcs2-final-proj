import java.util.ArrayList;

class ALHeap 
{
  //instance vars
  private ArrayList<Structure> _heap; //underlying container is array of Integers

  ALHeap() 
  { 
    _heap = new ArrayList<Structure>();
  }

  boolean isEmpty() 
  { 
    return _heap.isEmpty();
  } //O(1)

  Structure peekMin() 
  { 
    if ( _heap.size() < 1 )
      return null;
    else
      return _heap.get(0);
  }

  void add( Structure addVal ) 
  { 
    _heap.add( addVal );

    int addValPos = _heap.size() - 1;
    int parentPos;

    while ( addValPos > 0 ) { //potentially swap until reach root

      //pinpoint parent
      parentPos = (addValPos-1) / 2;

      if ( addVal.compareTo(_heap.get(parentPos)) < 0 ) {//addVal < parent
        swap( addValPos, parentPos );
        addValPos = parentPos;
      } else 
      break;
    }
  } //O(logn)

  public Structure removeMin() 
  {
    if ( _heap.size() == 0 ) 
      return null;

    //store root value for return at end of fxn
    Integer retVal = peekMin();

    //store val about to be swapped into root
    Integer foo = _heap.get( _heap.size() - 1);

    //swap last (rightmost, deepest) leaf with root
    swap( 0, _heap.size() - 1 );

    //lop off last leaf
    _heap.remove( _heap.size() - 1);

    // walk the now-out-of-place root node down the tree...
    int pos = 0;
    int minChildPos;

    while ( pos < _heap.size() ) {

      //choose child w/ min value, or check for child
      minChildPos = minChildPos(pos);

      //if no children, then i've walked far enough
      if ( minChildPos == -1 ) 
        break;
      //if i am less than my least child, then i've walked far enough
      else if ( foo.compareTo( _heap.get(minChildPos) ) <= 0 ) 
        break;
      //if i am > least child, swap with that child
      else {
        swap( pos, minChildPos );
        pos = minChildPos;
      }
    }
    //return removed value
    return retVal;
  }//O(logn)

  int minChildPos( int pos ) 
  {
    int retVal;
    int lc = 2*pos + 1; //index of left child
    int rc = 2*pos + 2; //index of right child

    //pos is not in the heap or pos is a leaf position
    if ( pos < 0 || pos >= _heap.size() || lc >= _heap.size() )
      retVal = -1;
    //if no right child, then left child is only option for min
    else if ( rc >= _heap.size() )
      retVal = lc;
    //have 2 children, so compare to find least 
    else if ( _heap.get(lc).compareTo(_heap.get(rc)) < 0 )
      retVal = lc;
    else
      retVal = rc;
    return retVal;
  }


  Structure minOf( Structure a, Structure b ) 
  {
    if ( a.compareTo(b) < 0 )
      return a;
    else
      return b;
  }

  void swap( int pos1, int pos2 ) 
  {
    _heap.set( pos1, _heap.set( pos2, _heap.get(pos1) ) );
  }
  
  

}