export Mac_Select_Best_Matches(ifile,rid1,rid2,ofile) := macro
// In 1.6 Forward we have a very different specification
// We now need to keep the best of EVERY RID and we want it distributed by RID
// Worse, we need the best for every RID by both Conf and Conf-Conf_Prop
// Have also simplified parameter count - Rule, Conf and Conf_Prop assumed
	// The above is such a painful idea - I am going to start by only deduping RID1/RID2 pairs ...
	
	#uniquename(one_only_a)
	%one_only_a% := dedup( sort( distribute(ifile,hash(rid1)), rid1, rid2, -Conf,Rule, local ), left.rid1=right.rid1 and left.rid2=right.rid2, local );
	
	ofile := %one_only_a%;
  
  endmacro;
