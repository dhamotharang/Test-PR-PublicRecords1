import LN_PropertyV2;

export getPropertyIDsByBDID(dataset(doxie_cbrs.layout_references) infile) := function

outf := record
	unsigned6 bdid;
	string12 fid;
	string2  source_code;
end;

kaf := LN_PropertyV2.key_search_bdid;

outf intof(infile le, kaf ri) := transform
	self.bdid := le.bdid;
  self.fid := ri.ln_fares_id;
  self.source_code := ri.source_code;
end;  
  
jr := join(infile,kaf,left.bdid = right.s_bid,
					 intof(left, right), atmost(1000));

return jr;

END;