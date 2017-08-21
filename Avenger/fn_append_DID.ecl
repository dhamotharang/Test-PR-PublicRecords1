import avenger, DID_add;

export fn_append_DID(dataset(avenger.layout_in.assertion_clean_rec) pInFile) := function
//append DID

	matchset_input := ['A','D','S','P','Z'];

	did_Add.MAC_Match_Flex(pInFile, matchset_input,
												 SSN, DOB, fName, mname, LName, name_suffix, 
												 prim_range, prim_name, sec_range, zip,
												 st, Phone,
												 did,
												 avenger.layout_in.assertion_clean_rec,
												 false, did_score_field,	//these should default to zero in definition
												 75,	  //dids with a score below here will be dropped 	
												 postDID);
																	 																					 
return postDID ;

end;


