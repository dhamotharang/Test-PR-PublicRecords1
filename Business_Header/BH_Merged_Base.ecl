IMPORT ut,mdr;

EXPORT BH_Merged_Base(

	 dataset(Layout_Business_Header_Base) pBusinessHeaders					= Files().Base.Business_Headers.QA
	,dataset(Layout_Business_Header_New	) pBH_Matches								= BH_Matches				()
	,dataset(Layout_PairMatch						) pBH_Initial_Rollup				= BH_Initial_Rollup	()
	,string																pPersistname							= persistnames().BHMergedBase													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

file_bh_previous := pBusinessHeaders;

// Clear out Group IDs for existing business header file
// Clear vendor_id for Gong records
Business_Header.Layout_Business_Header_New ClearGroupID(file_bh_previous L) :=
TRANSFORM
	
	isdb := MDR.sourceTools.SourceIsDunn_Bradstreet(l.source);

	SELF.group1_id 								:= 0;
	SELF.vendor_id 								:= IF(L.source not in Set_Source_Vendor_Id_Unique, '', L.vendor_id);
	SELF.fein 										:= if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
	SELF.phone                    := if(l.phone >= 10000000000, 0, l.phone);  // Zero the phone if more than 10-digits
	self.dt_first_seen 						:= if(isdb and (integer)l.dt_first_seen 						< 10000000 and (integer)l.dt_first_seen 						!= 0, 0, l.dt_first_seen						);
	self.dt_last_seen 						:= if(isdb and (integer)l.dt_last_seen 							< 10000000 and (integer)l.dt_last_seen 							!= 0, 0, l.dt_last_seen							);
	self.dt_vendor_first_reported := if(isdb and (integer)l.dt_vendor_first_reported 	< 10000000 and (integer)l.dt_vendor_first_reported 	!= 0, 0, l.dt_vendor_first_reported	);
	self.dt_vendor_last_reported 	:= if(isdb and (integer)l.dt_vendor_last_reported 	< 10000000 and (integer)l.dt_vendor_last_reported 	!= 0, 0, l.dt_vendor_last_reported	);
	SELF := L;
END;

BH_Current := PROJECT(filters.bases.business_headers(file_bh_previous), ClearGroupID(LEFT));

// Combine Business Header Matches with current Business Headers
BH_Add := if(Flags.Building.NoUpdates,
                      BH_Current,
					  BH_Current + pBH_Matches);
					  
// Rollup the current Headers
BH_Rollup := pBH_Initial_Rollup;

ut.MAC_Patch_Id(BH_Add, rcid, BH_Rollup, old_rid, new_rid, BH_Patched)

Business_Header.MAC_Merge_ByRid(BH_Patched, BH_Merged)

 BH_Merged_persist := BH_Merged
	: PERSIST(pPersistname);
	
returndataset := if(pShouldRecalculatePersist = true, BH_Merged_persist
																										, persists().BHMergedBase
									);
									
return returndataset;
	
end;