//******************* Function to flag records non-pub for someone else
export Fn_Apply_NonPub_Exclusion_Rule (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//-----------exclude records associated to someone else with the same phone already flaged as Non-pub
non_pub_flagged := dedup(sort(distribute(phplus_in(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Non-pub'))), 
                              hash(npa+phone7)), 
						 npa+phone7, -DateLastSeen, -DateFirstSeen, -DateVendorLastReported, -DateVendorFirstReported, local), 
				   npa+phone7, local);

recordof(phplus_in) t_no_nonpub_exclude(phplus_in le, non_pub_flagged  ri) := transform
	self.in_flag 	   := if(ri.npa <> '' and 
						     Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Non-pub')) = false AND 
							 le.lname <> ri.lname and 
							 le.hhid <> ri.hhid,
							 false, le.in_flag) ;
	self.rules 	   		:= if(ri.npa <> '' and 
							 Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Non-pub')) = false AND 
							 le.lname <> ri.lname and 
							 le.hhid <> ri.hhid,  
							 le.rules | Translation_Codes.rules_bitmap_code('Non-pub-for-someone-else'), 
							 le.rules) ;
	self := le;
end;

no_nonpub_exclude := join(distribute(phplus_in, hash(npa+phone7)),
				    non_pub_flagged,
					left.npa+left.phone7 = right.npa+right.phone7,
					t_no_nonpub_exclude(left, right),
					local,
					left outer);
					
return no_nonpub_exclude;
end;