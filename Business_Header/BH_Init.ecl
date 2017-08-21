IMPORT
	 Business_Header_SS
	,did_add
	,ut
	;

EXPORT BH_Init(

	 dataset(Layout_Business_Header_New)	pAll_Business_Header_Sources	= Business_Sources.business_headers
	,string														pPersistname									= persistnames().BHInit													
	,boolean													pShouldRecalculatePersist			= true													

) :=
function

Layout_Business_Header_New ClearBadFEINs(Layout_Business_Header_New l) := TRANSFORM
SELF.fein := if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
SELF.phone := (unsigned6)ut.CleanPhone((string)l.phone);  // Zero the phone if more than 10-digits
SELF := L;
END;

BH_Init_persist := PROJECT(Filters.Input.Business_headers(pAll_Business_Header_Sources),
                          ClearBadFEINs(LEFT)) 
	: PERSIST(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Init_persist
																										, persists().BHInit
									);
									
return returndataset;

end;