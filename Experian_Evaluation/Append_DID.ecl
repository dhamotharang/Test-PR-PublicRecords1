IMPORT  address, ut, header_slimsort, did_add, didville,watchdog;

normalized_clean := Experian_Evaluation.Clean_Name_Address;
	
//-----------------------------------------------------------------
//APPEND DID
//-----------------------------------------------------------------
								   
matchset := ['A','Z','D','S'];

did_add.MAC_Match_Flex
	(normalized_clean , matchset,					
	 Social_Security_Number, Date_of_Birth , fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st,'', 
	 DID, Layout_Experian_CP_Out .Layout_Experian_All_Out, true, DID_Score_field,
	 75, d_did)

//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(d_did, '~thor400::base::Experian_CP', build_experian_base, 2,,TRUE);

EXPORT Append_DID := build_experian_base;

