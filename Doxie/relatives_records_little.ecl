// Filters input DIDs (i.e. subjects) by relatives' first names:
// only candidates having relatives with provided names are returned.

import doxie, ut, NID;

export relatives_records_little(
							dataset(doxie.layout_references) dids,
							string30 rel_fn_val1 = '',
						  string30 rel_fn_val2 = '',
						  unsigned3 max_relatives_lt = 0
							) 
                                := function

hdr_key := doxie.key_header;

//get relatives (up to max_relatives_lt *per* candidate DID)					 
rel_little_ready := group(sort(doxie.relative_dids(dids),person1,-number_cohabits,-recent_cohabit,-isRelative),person1);
rel_little_trimmed := dedup(rel_little_ready, true, KEEP(max_relatives_lt));
				    
rel_little := ungroup(if(max_relatives_lt=0, rel_little_ready, rel_little_trimmed));

//get header records
doxie.layout_references keep_rel_did(rel_little le) := transform
	self.did := le.person1;
end;

// enable 'starts with' matching on the input fname *and* safeguard against invalid subrange exception
castFname1 := trim(ut.cast2keyfield(hdr_key.fname,rel_fn_val1));
castFname2 := trim(ut.cast2keyfield(hdr_key.fname,rel_fn_val2));

// now filter candidates by relatives' first names found in the header file:
subj_dids1 := join(rel_little, hdr_key, 
                  keyed(left.person2 = right.s_did) and
                  (right.fname[1..LENGTH(castFname1)]=castFname1 OR
                   NID.mod_PFirstTools.PFLeqPFR(right.fname,rel_fn_val1)),
                  keep_rel_did(left), KEEP (1), LIMIT (ut.limits.HEADER_PER_DID, SKIP));

				 
subj_dids2 := join(rel_little, hdr_key, 
                  keyed(left.person2 = right.s_did) and
                  (right.fname[1..LENGTH(castFname2)]=castFname2 OR
                   NID.mod_PFirstTools.PFLeqPFR(right.fname,rel_fn_val2)),
                  keep_rel_did(left), KEEP (1), LIMIT (ut.limits.HEADER_PER_DID, SKIP));

// keep subjects for whom both relatives' names match (or just one, if only one was specified)
subj_dids := DEDUP(IF(rel_fn_val2='',
					 				 subj_dids1,
					 				 JOIN(subj_dids1, subj_dids2, LEFT.did = RIGHT.did, keep(1), limit(0))), did, all);
				  
return subj_dids;		    
end;