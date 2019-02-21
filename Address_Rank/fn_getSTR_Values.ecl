IMPORT Address_Rank, BatchServices;
EXPORT  fn_getSTR_Values(DATASET(Address_Rank.Layouts.Bestrec) recs, 
												 Address_Rank.IParams.BatchParams in_mod) := FUNCTION
												 
	str_mod := MODULE (BatchServices.Interfaces.str_config)
		EXPORT STRING32   ApplicationType			:= in_mod.application_type;
    EXPORT BOOLEAN    IncludeMinors       := in_mod.show_minors;
		EXPORT UNSIGNED2 	PenaltThreshold 		:= BatchServices.STR_Constants.Defaults.PENALT_THRESHOLD;
		EXPORT UNSIGNED2 	ShortTermThreshold 	:= BatchServices.STR_Constants.Defaults.SHORT_TERM_THRESHOLD;//180 days
		EXPORT BOOLEAN 		ExcludeDropIndCheck := FALSE;
		EXPORT UNSIGNED1 	GLBPurpose 					:= in_mod.glb;
					 BOOLEAN 		SkipDeceased 				:= FALSE;
		EXPORT BOOLEAN 		ReturnDeceased 			:= ~SkipDeceased; // will return deceased subjects by default
		EXPORT UNSIGNED8  MaxResultsPerAcct   := in_mod.MaxResultsPerAcct;
	end;
	
	str_batch := PROJECT(recs, TRANSFORM(BatchServices.STR_Layouts.batch_in, SELF.addr_suffix := LEFT.suffix, SELF := LEFT, SELF:=[]));		
	strRecs := BatchServices.STR_Records(str_batch, str_mod);		

	Address_Rank.Layouts.Bestrec getSTRValues(recs l, strRecs r) := TRANSFORM
		SELF.rent_flag					:= IF(l.college_addr 			<> 'Y' AND l.business_addr 		<> 'Y' AND 
																	(r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.SHORT_TERM OR 
																	 r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.LONG_TERM), 'Y','N');
																	
		SELF.property_owner 		:= IF(r.did <> 0 AND(r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.OWNER OR 
																									r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.OWNER_OCCUPIED OR
																									r.did = r.owner1_did OR r.did = r.owner2_did), 'Y', 'N');
																	
		SELF.owner_occupied_hit := IF(r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.OWNER_OCCUPIED OR
																	r.file_split_flag  = BatchServices.STR_Constants.SplitFlags.OWNER_OCCUPIED, 'Y', 'N');
																		
		SELF.long_term_hit  		:= IF(l.college_addr 	   <> 'Y'  AND 
																	l.business_addr		 <> 'Y'  AND 
																	(r.overall_hit_flag  = BatchServices.STR_Constants.HitFlags.LONG_TERM OR
																	(in_mod.IncludeSTRSplitFlag AND r.file_split_flag  = BatchServices.STR_Constants.HitFlags.LONG_TERM)), 'Y', 'N');
																	
		SELF.short_term_hit 		:= IF(l.college_addr 		<> 'Y' 	 AND 
																	l.business_addr		<> 'Y' 	 AND 
																	((in_mod.IncludeSTRSplitFlag AND r.file_split_flag  = BatchServices.STR_Constants.HitFlags.SHORT_TERM) OR
																	l.prim_name = '' OR
																	r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.SHORT_TERM 	OR 
																	r.overall_hit_flag = BatchServices.STR_Constants.HitFlags.NO_HIT), 'Y', 'N');
		SELF := l;
		SELF := [];
	END;
	strData := JOIN(recs,strRecs,
									LEFT.acctno = RIGHT.acctno AND
									LEFT.did 		= RIGHT.did,
									getSTRValues(LEFT,RIGHT), LEFT OUTER, LIMIT(0), KEEP(1));

	RETURN strData;
END;	
