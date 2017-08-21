import ut;
//****************Function to propagate include/exclude flag to records with the same HHID********************

export Fn_Propagate_Rules(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_rules := dedup(sort(distribute(phplus_in(in_flag ), hash(npa+phone7)), npa+phone7, if(pdid = 0,1,2), -confidencescore,local),npa+phone7,local) ;
recordof(phplus_in) t_propagate(phplus_in le, phplus_in_rules ri) := transform 
	
	related_below := if(le.in_flag =  false and
											 le.npa+le.phone7 = ri.npa+ri.phone7 and
											 (le.did = ri.did or
											  le.hhid = ri.hhid or
												ut.StringSimilar(le.lname ,ri.lname) < 3 or
												(le.prim_range = ri.prim_range and
												 le.prim_name = ri.prim_name and
												 le.sec_range = ri.sec_range and
												 le.zip5 = ri.zip5)),
												 true,
												 false);
	
	self.in_flag 	:= if(related_below,
												 true,
												 le.in_flag);
	self.rules 	:= if(related_below,
										le.rules | ri.rules,
										le.rules);;
	
	self.src_rule := le.rules;
							
  self := le;
end;


propagate_f := join(distribute(phplus_in, hash(npa+phone7)), 
							 distribute(phplus_in_rules, hash(npa+phone7)), 
							 left.npa+left.phone7 = right.npa+right.phone7,
							 t_propagate(left, right), 
							  left outer,
							 local);	
	

return propagate_f;

end;