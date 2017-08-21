import AID;

export BH_Add_AID(

	dataset(Layout_Business_Header_Temp)	pBH_Match_Init						= BH_Match_Init	()
	//,string																pPersistname							= persistnames().BHBasicMatchClean													
	//,boolean															pShouldRecalculatePersist	= true													

) :=
function
	dBH_Match_Init := pBH_Match_Init;

	//Propagate Business header addresses with AID and get the best address
	macGetCleanAddr(dBH_Match_Init, prim_range, predir, prim_name, 
									addr_suffix, postdir, unit_desig, 
									sec_range, city, state, zip, zip4, 
									RawAID, true, false, BH_Match_With_AID_results);
	
	BH_Match_With_AID := BH_Match_With_AID_results : independent;
	
	return(BH_Match_With_AID);
	
end;