import gong, Business_Header_Bdid_lift;
// Initialize match file

EXPORT BH_Basic_Match_SALT(

	 dataset(Layout_Business_Header_Temp)	pBH_Basic_Match_FEIN			= BH_Basic_Match_FEIN	()
	,string																pPersistname							= persistnames().BHBasicMatchSALT													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

	//Do SALT matching
	bh_salt := Business_Header_Bdid_lift.Proc_Iterate('1',pBH_Basic_Match_FEIN).OutputDataset;

	BH_salt_persisted := bh_salt : PERSIST(pPersistname);

	returndataset := if(pShouldRecalculatePersist = true, BH_salt_persisted
																											, persists().BHBasicMatchSALT
										);
										
	return returndataset;

end;