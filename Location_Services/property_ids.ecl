import LN_PropertyV2, doxie_raw;

export property_ids(DATASET(Doxie_Raw.Layout_address_input) addrs) := FUNCTION

kaf := LN_PropertyV2.key_addr_fid();

layout_fid intof(kaf le) := transform
  self.fid := le.ln_fares_id;
  self.source_code := le.source_code_1 + le.source_code_2;
end;  

pids := join(addrs,kaf,keyed(left.prim_name = right.prim_name) and
									 keyed(left.prim_range = right.prim_range) and
									 keyed(left.zip = right.zip) and									 
									 keyed(left.predir = right.predir) and 
									 keyed(left.postdir = right.postdir) and 
									 keyed(left.suffix = right.suffix) and
									 keyed(left.sec_range = right.sec_range) and
									 keyed(right.source_code_2 = 'P'),
					 intof(right),KEEP(200), LIMIT(10000,SKIP,COUNT)); 
					 
RETURN dedup(sort(pids, fid),fid);

END;