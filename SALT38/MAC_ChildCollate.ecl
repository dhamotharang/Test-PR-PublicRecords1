// Clunkly way to define an equivalence for ONE field of a child field. Allows for different sort-orders in child field
// Will have some level of false positive
EXPORT MAC_ChildCollate(infile,field) := FUNCTIONMACRO
  RETURN SUM(infile,HASH(field));
  ENDMACRO;
