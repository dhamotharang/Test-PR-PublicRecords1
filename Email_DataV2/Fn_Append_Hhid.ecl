
//****************Function to append HHID*************************************

import ut,didville;
export Fn_Append_HHId(dataset(recordof(Layouts.Base_BIP)) email_in) := function

//----Append HHID for recs with and without did
with_did 		:= email_in(did > 0);
without_did	:= email_in(did = 0);


didville.MAC_HHID_Append(     		with_did, 
									'HHID_NAMES', 
									Append_HHID1);

didville.MAC_HHID_Append_By_Address(
									without_did, 
									Append_HHID2, 
									hhid, 
									clean_name.lname,
									clean_address.prim_range, 
									clean_address.prim_name, 
									clean_address.sec_range, 
									clean_address.st, 
									clean_address.zip);
	
						
email_all := Append_HHID1 + Append_HHID2;

return email_all;
end;

