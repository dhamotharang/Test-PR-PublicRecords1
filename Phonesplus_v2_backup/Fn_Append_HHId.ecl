//****************Function to append HHID*************************************

import ut,didville;
export Fn_Append_HHId(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//----Append HHID for recs with and without did
pplus_sources_with_did 		:= phplus_in(pdid = 0);
pplus_sources_without_did	:= phplus_in(pdid > 0);


didville.MAC_HHID_Append(     		pplus_sources_with_did, 
									'HHID_NAMES', 
									Append_HHID2);

didville.MAC_HHID_Append_By_Address(
									pplus_sources_without_did, 
									Append_HHID1, 
									hhid, 
									lname,
									prim_range, 
									prim_name, 
									sec_range, 
									state, 
									zip5);
//----Generate key for phone7-hhid fields								
recordof(phplus_in) t_create_hhid_key(recordof(phplus_in) le) := transform
	self.phone7_hhid_key := hashmd5((data)le.phone7 + le.hhid);
	self := le;
end;	
						
pplus_all := project(Append_HHID1 + Append_HHID2, t_create_hhid_key(left));

return pplus_all;
end;

