// get best indicators for new rids related to existing lexid's
		IncBase    := DISTRIBUTE(InsuranceHeader_Incremental.Files.IncBase_Current_DS(dt_effective_last=0),HASH(RID)) ;
		FullBest   := DISTRIBUTE(InsuranceHeader_Incremental.Files.Best_Current_DS, HASH(RID));
	
		GetBestInd := JOIN (FullBest , IncBase , LEFT.rid = RIGHT.rid AND 
		                                         LEFT.src = RIGHT.src ,											 
											         TRANSFORM (InsuranceHeader_Incremental.Layout_Header_Incremental,															 
																				SELF.ssn_ind       := LEFT.ssn_ind , 
													       SELF.dob_ind       := LEFT.dob_ind, 
													       SELF.dlno_ind      := LEFT.dlno_ind , 
													       SELF.addr_ind      := LEFT.addr_ind, 
													       SELF.best_addr_ind := LEFT.best_addr_ind,
													       SELF               := RIGHT ), 
											         RIGHT OUTER,LOCAL);
											 
	EXPORT IncrementalKeyBase := GetBestInd	+ InsuranceHeader_Incremental.Files.IncBase_Current_DS(dt_effective_last<>0);				 