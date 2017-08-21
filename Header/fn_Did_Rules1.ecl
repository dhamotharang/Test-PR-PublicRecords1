export fn_Did_Rules1(dataset(header.Layout_PairMatch) dr0) :=
FUNCTION 

//***** MAKE SURE WE ARE MERGING A BIGGER (NUMERICALLY) DID INTO A SMALLER ONE
tot := dr0(old_rid>new_rid,new_rid<>0);

//***** DEDUP
dglb := dedup(sort(distribute(tot,old_rid),old_rid,new_rid,local),old_rid,local);

/* IF YOU HAVE:
NEW		OLD
1			2
2			3
THEN THROW OUT THE SECOND
*/
typeof(dglb) take_left(dglb le) := transform
  self := le;
  end;

outfile := join(dglb,dglb,left.new_rid=right.old_rid,take_left(left),hash,left only);

return outfile;
END;