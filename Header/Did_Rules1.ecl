import ut;

final_rec := header.Layout_PairMatch;


Layout_Pairmatch intoglb(Did_Rules0 le) := transform
  self := le;
  end;

glb_cand := project(Did_Rules0(old_rid>new_rid,new_rid<>0),intoglb(left));

tot := glb_cand;// + relativedidmatches;

dglb := dedup(sort(distribute(tot,old_rid),old_rid,new_rid,local),old_rid,local);

//ut.MAC_Reduce_Pairs(dglb,new_rid,old_rid,pflag,final_rec,outfile)


typeof(dglb) take_left(dglb le) := transform
  self := le;
  end;

outfile := join(dglb,dglb,left.new_rid=right.old_rid,take_left(left),hash,left only);

export Did_Rules1 := outfile : persist('Did_Rules1');