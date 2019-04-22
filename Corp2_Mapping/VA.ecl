IMPORT corp2, corp2_mapping, corp2_raw_va, scrubs, scrubs_corp2_mapping_va_event,
			 scrubs_corp2_mapping_va_main, scrubs_corp2_mapping_va_stock, std,
			 tools, ut, versioncontrol;

EXPORT VA := MODULE; 

	EXPORT Update(STRING fileDate, STRING version, BOOLEAN pShouldSpray = Corp2_Mapping._Dataset().bShouldSpray, BOOLEAN pOverwrite = FALSE, pUseProd = Tools._Constants.IsDataland) := FUNCTION

		state_origin				:= 'VA';
		state_fips	 				:= '51';	
		state_desc	 				:= 'VIRGINIA';

		TablesFile					:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Tables.logical,HASH(table_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		CorpsFile		 				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Corps.logical,HASH(corps_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		LPFile 							:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.LP.logical,HASH(lp_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		AmendmtFile 				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Amendment.logical,HASH(amend_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		OfficersFile 				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Officer.logical,HASH(offc_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		NamesHistFile    		:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.NamesHist.logical,HASH(nmhist_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		MergersFile  				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.Merger.logical,HASH(merg_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		ReservedFile 				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.ResrvdName.logical,HASH(res_number)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		LLCFile      				:= DEDUP(SORT(DISTRIBUTE(Corp2_Raw_VA.Files(filedate,puseprod).input.LLC.logical,HASH(llc_entity_id)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		
		//********************************************************************
		//Join the CORPORATION file with the TABLES file
		//******************************************************************** 	
			
		//NORMALIZE the CORPORATION stock information
		Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn normCorpStk(CorpsFile l, unsigned1 cnt) := TRANSFORM,	
		SKIP(cnt = 2 AND corp2.t2u(l.corps_stock2) = '' OR
				 cnt = 3 AND corp2.t2u(l.corps_stock3) = '' OR
				 cnt = 4 AND corp2.t2u(l.corps_stock4) = '' OR
				 cnt = 5 AND corp2.t2u(l.corps_stock5) = '' OR
				 cnt = 6 AND corp2.t2u(l.corps_stock6) = '' OR
				 cnt = 7 AND corp2.t2u(l.corps_stock7) = '' OR
				 cnt = 8 AND corp2.t2u(l.corps_stock8) = ''
				)
			SELF.corps_entity_id    := corp2.t2u(l.corps_entity_id);
			SELF.corps_name         := corp2.t2u(l.corps_name);
			SELF.corps_stock_ind    := corp2.t2u(l.corps_stock_ind);
			SELF.corps_total_shares := (STRING)ut.IntWithCommas((INTEGER)l.corps_total_shares);
			SELF.corps_stock_class  := CHOOSE(cnt,corp2.t2u(l.corps_stock1),corp2.t2u(l.corps_stock2),corp2.t2u(l.corps_stock3),corp2.t2u(l.corps_stock4),corp2.t2u(l.corps_stock5),corp2.t2u(l.corps_stock6),corp2.t2u(l.corps_stock7),corp2.t2u(l.corps_stock8));	
			SELF.corps_stock_abbrv  := REGEXREPLACE('\\(.{1,}\\)',SELF.corps_stock_class,'');
			SELF.corps_stock_shares := REGEXFIND('\\(\\d{1,}\\)',SELF.corps_stock_class,0); //Keeps amount of shares i.e. (2000)
			SELF                    := [];	
		END;
		
		CorpStkNormal	:= NORMALIZE(CorpsFile, 8, normCorpStk(LEFT, COUNTER)) : INDEPENDENT;
		
		//JOIN Table 12 - Stock Table to add Stock Description to CORPORATION File						
		joinCorpsStkT12	:= JOIN(CorpStkNormal, TablesFile,
													corp2.t2u(RIGHT.table_id)         = '12' AND							
													corp2.t2u(LEFT.corps_stock_abbrv) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn,
																		SELF.t12_stock_desc  := IF(TRIM(RIGHT.table_description) <> '',TRIM(RIGHT.table_description),TRIM(LEFT.corps_stock_abbrv));
																		SELF						 	   := LEFT;
																		SELF						 		 := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;		
		
	  Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn concatCorpsStk(Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn l, Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn r, INTEGER C) := TRANSFORM
			SELF.corps_entity_id    := corp2.t2u(l.corps_entity_id);
			SELF.corps_name         := corp2.t2u(l.corps_name);
		  SELF.corps_stock_ind    := corp2.t2u(l.corps_stock_ind);
		  SELF.corps_total_shares := corp2.t2u(l.corps_total_shares);
			//OVERLOADED - The stock information is placed here in order to capture both the stock type and the amounts.  
			SELF.stock_addl_info    := IF(C=1,Corp2_Raw_VA.Functions.Stock_Class_Translation(r.corps_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.corps_stock_shares),
                                        corp2.t2u(l.stock_addl_Info) + '; ' + Corp2_Raw_VA.Functions.Stock_Class_Translation(r.corps_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.corps_stock_shares));
      SELF                    := [];	
	  END;

		dNormedCorpsStk     := DENORMALIZE(joinCorpsStkT12, joinCorpsStkT12,
										                   LEFT.corps_entity_id = RIGHT.corps_entity_id, 
											                 concatCorpsStk(LEFT,RIGHT,COUNTER));
    dist_dNormCorpsStk  := DISTRIBUTE(dNormedCorpsStk,HASH(corps_entity_id));
		srt_dNormedCorpsStk := DEDUP(SORT(dist_dNormCorpsStk,RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
												 
		//JOIN Table 01 - Corporate Status to add Status Description to CORPORATION File
		joinCorpsT01 	:= JOIN(CorpsFile, TablesFile,
													corp2.t2u(RIGHT.table_id)    = '01' AND							
													corp2.t2u(LEFT.corps_status) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t1_statusdesc  := TRIM(RIGHT.table_description);
																		SELF						 		:= LEFT;
																		SELF						 		:= [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;
													
		//JOIN Table 02 - State Descriptions to results of previous join
		joinCorpsT02 	:= JOIN(joinCorpsT01, TablesFile,
													corp2.t2u(RIGHT.table_id) 	       = '02' AND							
													corp2.t2u(LEFT.corps_incorp_state) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t2_for_stdesc  := TRIM(RIGHT.table_description);
																		SELF						 		:= LEFT;
																		SELF						 		:= [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
													 
		//JOIN Table 03 - Industry Code to results of previous join
		joinCorpsT03 	:= JOIN(joinCorpsT02, TablesFile,
													corp2.t2u(RIGHT.table_id) 	        = '03' AND							
													corp2.t2u(LEFT.corps_industry_code) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t3_busdesc  := TRIM(RIGHT.table_description);
																		SELF						 := LEFT;
																		SELF					   := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
		
		//JOIN Table 04 - Registered Agent Status to results of previous join
		joinCorpsT04 	:= JOIN(joinCorpsT03, TablesFile,
													corp2.t2u(RIGHT.table_id)       = '04' AND							
													corp2.t2u(LEFT.corps_ra_status) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t4_ra_statusdesc := TRIM(RIGHT.table_description);
																		SELF						 		  := LEFT;
																		SELF						 			:= [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;		
														 
		//JOIN Table 05 - Court Locality to results of previous join											 
		joinCorpsT05 	:= JOIN(joinCorpsT04, TablesFile,
													corp2.t2u(RIGHT.table_id)    = '05' AND							
													corp2.t2u(LEFT.corps_ra_loc) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t5_ra_location := TRIM(RIGHT.table_description);
																		SELF						 		:= LEFT;
																		SELF						 		:= [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
			
		//JOIN Table 07 - Assessment Indicator to results of previous join						
		joinCorpsT07 	:= JOIN(joinCorpsT05, TablesFile,
													corp2.t2u(RIGHT.table_id)        = '07' AND							
													corp2.t2u(LEFT.corps_assess_ind) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.t7_assessmt_desc  := TRIM(RIGHT.table_description);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
												 
												 
		CorpT07Dist			:= DISTRIBUTE(joinCorpsT07,HASH(corps_entity_id)) : INDEPENDENT;	
		
		// JOIN MERGERS File to results of previous join						
		joinCorpsMrge	:= JOIN(CorpT07Dist, MergersFile,
													corp2.t2u(LEFT.corps_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF.merg_foreign_name := corp2.t2u(RIGHT.merg_foreign_name);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
		//********************************************************************
		//JOIN the LP file with the TABLES file
		//******************************************************************** 	
		
		//NORMALIZE the LP stock information
		Corp2_Raw_VA.Layouts.TempNormLPLayoutIn normLPStk(LPFile l, unsigned1 cnt) := TRANSFORM,	
		SKIP(cnt = 2 AND corp2.t2u(l.lp_stock2) = '' OR
				 cnt = 3 AND corp2.t2u(l.lp_stock3) = '' OR
				 cnt = 4 AND corp2.t2u(l.lp_stock4) = '' OR
				 cnt = 5 AND corp2.t2u(l.lp_stock5) = '' OR
				 cnt = 6 AND corp2.t2u(l.lp_stock6) = '' OR
				 cnt = 7 AND corp2.t2u(l.lp_stock7) = '' OR
				 cnt = 8 AND corp2.t2u(l.lp_stock8) = ''
				)
			SELF.lp_entity_id    :=  corp2.t2u(l.lp_entity_id);
			SELF.lp_name         :=  corp2.t2u(l.lp_name);
			SELF.lp_stock_ind    :=  corp2.t2u(l.lp_stock_ind);
			SELF.lp_total_shares :=  (STRING)ut.IntWithCommas((INTEGER)l.lp_total_shares);
			SELF.lp_stock_class  :=  CHOOSE(cnt,corp2.t2u(l.lp_stock1),corp2.t2u(l.lp_stock2),corp2.t2u(l.lp_stock3),corp2.t2u(l.lp_stock4),corp2.t2u(l.lp_stock5),corp2.t2u(l.lp_stock6),corp2.t2u(l.lp_stock7),corp2.t2u(l.lp_stock8));	
			SELF.lp_stock_abbrv  :=  REGEXREPLACE('\\(.{1,}\\)',SELF.lp_stock_class,'');
			SELF.lp_stock_shares :=  REGEXFIND('\\(\\d{1,}\\)',SELF.lp_stock_class,0);
			SELF.t12_stock_desc  := '';
			SELF.stock_addl_info := '';
		END;
		
		LPStkNormal	:= NORMALIZE(LPFile, 8, normLPStk(LEFT, COUNTER)) : INDEPENDENT;
		
		//JOIN Table 12 - Stock Table to add Stock Description to LP File 						
		joinLPStkT12	:= JOIN(LPStkNormal, TablesFile,
													corp2.t2u(RIGHT.table_id)      = '12' AND							
													corp2.t2u(LEFT.lp_stock_abbrv) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempNormLPLayoutIn,
																		SELF.t12_stock_desc  := IF(TRIM(RIGHT.table_description) <> '',TRIM(RIGHT.table_description),TRIM(LEFT.lp_stock_abbrv));
																		SELF						 	   := LEFT;
																		SELF						 		 := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
													
		Corp2_Raw_VA.Layouts.TempNormLPLayoutIn concatLPStk(Corp2_Raw_VA.Layouts.TempNormLPLayoutIn l, Corp2_Raw_VA.Layouts.TempNormLPLayoutIn r, INTEGER C) := TRANSFORM
			SELF.lp_entity_id    := corp2.t2u(l.lp_entity_id);
			SELF.lp_name         := corp2.t2u(l.lp_name);
		  SELF.lp_stock_ind    := corp2.t2u(l.lp_stock_ind);
		  SELF.lp_total_shares := corp2.t2u(l.lp_total_shares);
			//OVERLOADED - The stock information is placed here in order to capture both the stock type and the amounts.  
			SELF.stock_addl_info := IF(C=1,Corp2_Raw_VA.Functions.Stock_Class_Translation(r.lp_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.lp_stock_shares),
                                     corp2.t2u(l.stock_addl_Info) + '; ' + Corp2_Raw_VA.Functions.Stock_Class_Translation(r.lp_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.lp_stock_shares));
      SELF                 := [];	
	  END;

		dNormedLPStk     := DENORMALIZE(joinLPStkT12, joinLPStkT12,
										                LEFT.lp_entity_id = RIGHT.lp_entity_id, 
											              concatLPStk(LEFT,RIGHT,COUNTER));
    dist_dNormLPStk  := DISTRIBUTE(dNormedLPStk,HASH(lp_entity_id));
		srt_dNormedLPStk := DEDUP(SORT(dist_dNormLPStk,RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
												 
		
		//JOIN Table 01 - Corporate Status to add Status Description to LP File 
		joinLPT01 	:= JOIN(LPFile, TablesFile,
												corp2.t2u(RIGHT.table_id)  = '01' AND							
												corp2.t2u(LEFT.lp_status)  = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																	SELF.t1_statusdesc  := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;
		
		//JOIN Table 02 - State Descriptions to results of previous join
		joinLPT02 	:= JOIN(joinLPT01, TablesFile,
												corp2.t2u(RIGHT.table_id) 	    = '02' AND							
												corp2.t2u(LEFT.lp_incorp_state) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																	SELF.t2_for_stdesc  := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;		
											 

    //JOIN Table 03 - Industry Code to results of previous join
		joinLPT03 	:= JOIN(joinLPT02, TablesFile,
												corp2.t2u(RIGHT.table_id) 	     = '03' AND							
												corp2.t2u(LEFT.lp_industry_code) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																	SELF.t3_busdesc  := TRIM(RIGHT.table_description);
																	SELF						 := LEFT;
																	SELF					   := [];
																 ),
												LEFT OUTER,
												LOOKUP
												) : INDEPENDENT;	
												
		//JOIN Table 05 - Court Locality to results of previous join											 
		joinLPT05 	:= JOIN(joinLPT03, TablesFile,
												corp2.t2u(RIGHT.table_id) = '05' AND							
												corp2.t2u(LEFT.lp_ra_loc) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																	SELF.t5_ra_location := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
			
		//JOIN Table 07 - Assessment Indicator to results of previous join						
		joinLPT07 	:= JOIN(joinLPT05, TablesFile,
												corp2.t2u(RIGHT.table_id)     = '07' AND							
												corp2.t2u(LEFT.lp_assess_ind) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																	SELF.t7_assessmt_desc  := TRIM(RIGHT.table_description);
																	SELF						 	     := LEFT;
																	SELF						 		   := [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
												 
		//JOIN Table 28 - RA Status to results of previous join						
		joinLPT28 	:= JOIN(joinLPT07, TablesFile,
													corp2.t2u(RIGHT.table_id)    = '28' AND							
													corp2.t2u(LEFT.lp_ra_status) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																		SELF.t28_ra_statusdesc  := TRIM(RIGHT.table_description);
																		SELF						 	      := LEFT;
																		SELF						 		    := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;			
												 
		
		LPT07Dist			:= DISTRIBUTE(joinLPT28,HASH(lp_entity_id)) : INDEPENDENT;
		
		//JOIN Mergers to results of previous join						
		joinLPMrge	:= JOIN(LPT07Dist, MergersFile,
													corp2.t2u(LEFT.lp_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLPLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF.merg_foreign_name := corp2.t2u(RIGHT.merg_foreign_name);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
		//********************************************************************
		//Join the LLC file with the TABLES file
		//*******************************************************************
		
		//NORMALIZE the LLC stock information
		Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn normLLCStk(LLCFile l, unsigned1 cnt) := TRANSFORM,	
		SKIP(cnt = 2 AND corp2.t2u(l.llc_stock2) = '' OR
				 cnt = 3 AND corp2.t2u(l.llc_stock3) = '' OR
				 cnt = 4 AND corp2.t2u(l.llc_stock4) = '' OR
				 cnt = 5 AND corp2.t2u(l.llc_stock5) = '' OR
				 cnt = 6 AND corp2.t2u(l.llc_stock6) = '' OR
				 cnt = 7 AND corp2.t2u(l.llc_stock7) = '' OR
				 cnt = 8 AND corp2.t2u(l.llc_stock8) = ''
				)
			SELF.llc_entity_id    := corp2.t2u(l.llc_entity_id);
			SELF.llc_name         := corp2.t2u(l.llc_name);
			SELF.llc_stock_ind    := corp2.t2u(l.llc_stock_ind);
			SELF.llc_total_shares := (STRING)ut.IntWithCommas((INTEGER)l.llc_total_shares);
			SELF.llc_stock_class  := CHOOSE(cnt,corp2.t2u(l.llc_stock1),corp2.t2u(l.llc_stock2),corp2.t2u(l.llc_stock3),corp2.t2u(l.llc_stock4),corp2.t2u(l.llc_stock5),corp2.t2u(l.llc_stock6),corp2.t2u(l.llc_stock7),corp2.t2u(l.llc_stock8));	
			SELF.llc_stock_abbrv  := REGEXREPLACE('\\(.{1,}\\)',SELF.llc_stock_class,'');
			SELF.llc_stock_shares := REGEXFIND('\\(\\d{1,}\\)',SELF.llc_stock_class,0);
			SELF.t12_stock_desc   := '';
			SELF.stock_addl_info  := '';
		END;
		
		LLCStkNormal	:= NORMALIZE(LLCFile, 8, normLLCStk(LEFT, COUNTER)) : INDEPENDENT;
		
		//JOIN Table 12 - Stock Table to add Stock Description to LLC File 						
		joinLLCStkT12	:= JOIN(LLCStkNormal, TablesFile,
													corp2.t2u(RIGHT.table_id)       = '12' AND							
													corp2.t2u(LEFT.llc_stock_abbrv) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn,
																		SELF.t12_stock_desc  := IF(TRIM(RIGHT.table_description) <> '',TRIM(RIGHT.table_description),TRIM(LEFT.llc_stock_abbrv));
																		SELF						 	   := LEFT;
																		SELF						 		 := [];
																	 ),
													LEFT OUTER,
													LOOKUP
													) : INDEPENDENT;	
													
		Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn concatLLCStk(Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn l, Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn r, INTEGER C) := TRANSFORM
			SELF.llc_entity_id    := corp2.t2u(l.llc_entity_id);
			SELF.llc_name         := corp2.t2u(l.llc_name);
		  SELF.llc_stock_ind    := corp2.t2u(l.llc_stock_ind);
		  SELF.llc_total_shares := corp2.t2u(l.llc_total_shares);
			//OVERLOADED - The stock information is placed here in order to capture both the stock type and the amounts.  
			SELF.stock_addl_info  := IF(C=1,Corp2_Raw_VA.Functions.Stock_Class_Translation(r.llc_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.llc_stock_shares),
                                      corp2.t2u(l.stock_addl_Info) + '; ' + Corp2_Raw_VA.Functions.Stock_Class_Translation(r.llc_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.llc_stock_shares));
      SELF                  := [];	
	  END;

		dNormedLLCStk     := DENORMALIZE(joinLLCStkT12, joinLLCStkT12,
										                LEFT.llc_entity_id = RIGHT.llc_entity_id, 
											              concatLLCStk(LEFT,RIGHT,COUNTER));
    dist_dNormLLCStk  := DISTRIBUTE(dNormedLLCStk,HASH(llc_entity_id));
		srt_dNormedLLCStk := DEDUP(SORT(dist_dNormLLCStk,RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		
		//JOIN Table 01 - Corporate Status to results of previous join
		joinLLCT01 	:= JOIN(LLCFile, TablesFile,
												corp2.t2u(RIGHT.table_id)  = '01' AND							
												corp2.t2u(LEFT.llc_status) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																	SELF.t1_statusdesc  := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;
		
		//JOIN Table 02 - State Descriptions to results of previous join
		joinLLCT02 	:= JOIN(joinLLCT01, TablesFile,
												corp2.t2u(RIGHT.table_id) 	     = '02' AND							
												corp2.t2u(LEFT.llc_incorp_state) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																	SELF.t2_for_stdesc  := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;		
											 
		//JOIN Table 03 - Industry Code to results of previous join
		joinLLCT03 	:= JOIN(joinLLCT02, TablesFile,
													corp2.t2u(RIGHT.table_id) 	      = '03' AND							
													corp2.t2u(LEFT.llc_industry_code) = corp2.t2u(RIGHT.table_column_value),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																		SELF.t3_busdesc  := TRIM(RIGHT.table_description);
																		SELF						 := LEFT;
																		SELF					   := [];
																	 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
												 
		//JOIN Table 05 - Court Locality to results of previous join											 
		joinLLCT05 	:= JOIN(joinLLCT03, TablesFile,
												corp2.t2u(RIGHT.table_id)  = '05' AND							
												corp2.t2u(LEFT.llc_ra_loc) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																	SELF.t5_ra_location := TRIM(RIGHT.table_description);
																	SELF						 		:= LEFT;
																	SELF						 		:= [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
			
		//JOIN Table 07 - Assessment Indicator to results of previous join						
		joinLLCT07 	:= JOIN(joinLLCT05, TablesFile,
												corp2.t2u(RIGHT.table_id)      = '07' AND							
												corp2.t2u(LEFT.llc_assess_ind) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																	SELF.t7_assessmt_desc  := TRIM(RIGHT.table_description);
																	SELF						 	     := LEFT;
																	SELF						 		   := [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
												 
		//JOIN Table 40 - RA Status to results of previous join						
		joinLLCT40 	:= JOIN(joinLLCT07, TablesFile,
												corp2.t2u(RIGHT.table_id)     = '40' and							
												corp2.t2u(LEFT.llc_ra_status) = corp2.t2u(RIGHT.table_column_value),
												TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																	SELF.t40_ra_statusdesc  := trim(RIGHT.table_description);
																	SELF						 	      := LEFT;
																	SELF						 		    := [];
																 ),
												LEFT OUTER,
												LOOKUP
											 ) : INDEPENDENT;			
											 
		LLCT07Dist	:= DISTRIBUTE(joinLLCT40,HASH(llc_entity_id)) : INDEPENDENT;
		
		//JOIN Mergers to results of previous join						
		joinLLCMrge	:= JOIN(LLCT07Dist, MergersFile,
													corp2.t2u(LEFT.llc_entity_id) = corp2.t2u(RIGHT.merg_entity_id),
													TRANSFORM(Corp2_Raw_VA.Layouts.TempLLCLayoutIn,
																		SELF.merg_type         := corp2.t2u(RIGHT.merg_type);
																		SELF.merg_eff_date     := corp2.t2u(RIGHT.merg_eff_date);
																		SELF.merg_surv_id      := corp2.t2u(RIGHT.merg_surv_id);
																		SELF.merg_foreign_name := corp2.t2u(RIGHT.merg_foreign_name);
																		SELF						 	     := LEFT;
																		SELF						 		   := [];
																	 ),
													LEFT OUTER
												 ) : INDEPENDENT;			
												 
													 
		//********************************************************************
		//NORMALIZE the AMENDMENT records for use in creating Event and
		//Stock records.	
		//******************************************************************** 
		Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn normAmendment(Corp2_Raw_VA.Layouts.AmendmentLayoutIn l, UNSIGNED1 cnt) := TRANSFORM,
		SKIP(cnt = 2 AND corp2.t2u(l.amend_type2+l.amend_stock2) = '' OR
				 cnt = 3 AND corp2.t2u(l.amend_type3+l.amend_stock3) = '' OR
				 cnt = 4 AND corp2.t2u(l.amend_type4+l.amend_stock4) = '' OR
				 cnt = 5 AND corp2.t2u(l.amend_type5+l.amend_stock5) = '' OR
				 cnt = 6 AND corp2.t2u(l.amend_type6+l.amend_stock6) = '' OR
				 cnt = 7 AND corp2.t2u(l.amend_type7+l.amend_stock7) = '' OR
				 cnt = 8 AND corp2.t2u(l.amend_type8+l.amend_stock8) = ''
				)
			SELF.amend_type         := CHOOSE(cnt,corp2.t2u(l.amend_type1),corp2.t2u(l.amend_type2),corp2.t2u(l.amend_type3),corp2.t2u(l.amend_type4),corp2.t2u(l.amend_type5),corp2.t2u(l.amend_type6),corp2.t2u(l.amend_type7),corp2.t2u(l.amend_type8));
			SELF.amend_stock_class  := CHOOSE(cnt,corp2.t2u(l.amend_stock1),corp2.t2u(l.amend_stock2),corp2.t2u(l.amend_stock3),corp2.t2u(l.amend_stock4),corp2.t2u(l.amend_stock5),corp2.t2u(l.amend_stock6),corp2.t2u(l.amend_stock7),corp2.t2u(l.amend_stock8));
			SELF.amend_stock_abbrv  := REGEXREPLACE('\\(.{1,}\\)',SELF.amend_stock_class,'');
			SELF.amend_stock_shares := REGEXFIND('\\(\\d{1,}\\)',SELF.amend_stock_class,0);
			SELF 							      := l;
			SELF							      := [];
		END;
		 
		AmendNormal 		:= NORMALIZE(AmendmtFile, 8, normAmendment(LEFT, COUNTER)) : INDEPENDENT;
			 
		AmendEvents 		:= AmendNormal(TRIM(amend_type,LEFT,RIGHT) <> '');
			 
		AmendStocks 		:= AmendNormal(TRIM(amend_stock_class,LEFT,RIGHT) <> '');							
				
		//********************************************************************
		//Take the AmendEvents file and create the joinAmendEvts to include
		//lookup information.
		//
		//Note: The Amendment file contains all three (3) types of corporation
		//			data: Corporation, Limited Parnership, and Limited Liability
		//			Company.
		//
		//Note: 19 - Amendment Type & 23 - LP Amendment Type
		//********************************************************************
		joinAmendEvts	 	:= JOIN(AmendEvents, TablesFile,
														IF(LEFT.amend_entity_id[1] IN ['L','M'], RIGHT.table_id = '23', RIGHT.table_id = '19') AND							
															 LEFT.amend_type = RIGHT.table_column_value,
														TRANSFORM(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn,
																			SELF.amend_type_desc		:= TRIM(RIGHT.table_description);
																			SELF						 				:= LEFT;
																			SELF										:= [];
																		 ),
														LEFT OUTER,
														LOOKUP
													 ) : INDEPENDENT;
		//********************************************************************
		//Take the AmendStocks file and create the joinAmendStock to include
		//lookup information.
		//********************************************************************
		joinAmendStock	:= JOIN(AmendStocks, TablesFile,                            
														RIGHT.table_id 				 = '12' AND							   							
														LEFT.amend_stock_abbrv = RIGHT.table_column_value,
														TRANSFORM(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn,
																			SELF.t12_stock_desc	:= IF(TRIM(RIGHT.table_description) <> '',TRIM(RIGHT.table_description),TRIM(LEFT.amend_stock_abbrv));
																			SELF						 			:= LEFT;
																		 ),
														LEFT OUTER,
														LOOKUP
													 ) : INDEPENDENT;
													 
			Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn concatAmendStk(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn l, Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn r, INTEGER C) := TRANSFORM
			SELF.amend_entity_id    := corp2.t2u(l.amend_entity_id);
			//OVERLOADED - The stock information is placed here in order to capture both the stock type and the amounts.  
			SELF.stock_addl_info    := IF(C=1,Corp2_Raw_VA.Functions.Stock_Class_Translation(r.amend_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.amend_stock_shares),
                                        corp2.t2u(l.stock_addl_Info) + '; ' + Corp2_Raw_VA.Functions.Stock_Class_Translation(r.amend_stock_abbrv,r.t12_stock_desc) + ' ' + corp2.t2u(r.amend_stock_shares));
      SELF                    := [];	
	  END;

		dNormedAmendStk     := DENORMALIZE(joinAmendStock, joinAmendStock,
										                   LEFT.amend_entity_id = RIGHT.amend_entity_id, 
											                 concatAmendStk(LEFT,RIGHT,COUNTER));
    dist_dNormAmendStk  := DISTRIBUTE(dNormedAmendStk,HASH(amend_entity_id));
		srt_dNormedAmendStk := DEDUP(SORT(dist_dNormAmendStk,RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;
		
													 
		//********************************************************************
		//JOIN the CORPORATION & OFFICERS file 
		//******************************************************************** 	
		joinOffcrCorps	:= JOIN(OfficersFile, CorpsFile, 
														corp2.t2u(LEFT.offc_entity_id) = corp2.t2u(RIGHT.corps_entity_id) ,
														TRANSFORM(Corp2_Raw_VA.Layouts.TempOfficersCorpsLayoutIn,
																			SELF.corp_legal_name  := corp2.t2u(RIGHT.corps_name);
																			SELF						 	    := LEFT;
																			SELF						 		  := [];
																		 ),
														LEFT OUTER
													 ) : INDEPENDENT;			
										 
		//**************************************************************
		// MAIN MAPPING - CORPORATION File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main CorpsFileTrans(Corp2_Raw_VA.Layouts.TempCorpsLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.corps_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.corps_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corps_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).AddressLine2;
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.corps_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_cd				    			:= corp2.t2u(l.corps_status);	
			SELF.corp_status_desc								:= Corp2_Raw_VA.Functions.CorpStatusDesc(l.corps_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.corps_status_date,'CCYY-MM-DD').PastDate;			
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.corps_entity_id)[1] IN ['0','1','2','3','4','5','6','7','8','9'],Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.corps_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	                                        => 'D',
																								 corp2.t2u(l.corps_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	                                        => 'EXPIRATION DATE',
																								 corp2.t2u(l.corps_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= IF(corp2.t2u(l.corps_entity_id)[1]='F','F','D');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.corps_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.corps_incorp_state) IN ['US','FN','TT']					      => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Codes(l.corps_incorp_state)	=> corp2.t2u(l.corps_incorp_state),
																										'**'
																									 ),
																								''
																							 );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.corps_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.corps_incorp_state) IN ['US','FN','TT']								 => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Description(l.t2_for_stdesc) => corp2.t2u(l.t2_for_stdesc),
																										Corp2_Raw_VA.Functions.State_Code_Translation(l.corps_incorp_state)
																									 ),
																								''
																							 );																					 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.corps_entity_id)[1]  = 'F',Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= MAP(corp2.t2u(l.corps_entity_id)[1] = 	'F' => 'FOREIGN CORPORATION',
																								 corp2.t2u(l.corps_entity_id)[1] <> 'F' => 'CORPORATION',																								 
																								 ''
																								);
			SELF.corp_orig_bus_type_cd					:= corp2.t2u(l.corps_industry_code);			
			SELF.corp_orig_bus_type_desc   	   	:= corp2.t2u(l.t3_busdesc);
			//OVERLOADED - The assessment information is placed here since there is no specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.t7_assessmt_desc) <> '','ASSESSMENT: '+ corp2.t2u(l.t7_assessmt_desc),'');
			SELF.corp_ra_full_name							:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corps_ra_name).BusinessName;
			SELF.corp_ra_title_desc             := IF(corp2.t2u(l.corps_ra_status) IN ['1','2','4'],corp2.t2u(l.t4_ra_statusdesc),'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.corps_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).AddressLine2;
      //OVERLOADED - The ra status information is placed here since it is a status and not a title.			
			SELF.corp_ra_addl_info              := IF(corp2.t2u(l.corps_ra_status) IN ['5','6','9'],corp2.t2u(l.t4_ra_statusdesc),'');
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_street1,l.corps_street2,l.corps_city,l.corps_state,l.corps_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.corps_ra_street1,l.corps_ra_street2,l.corps_ra_city,l.corps_ra_state,l.corps_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_county							:= IF(corp2.t2u(l.corps_ra_loc) <> '',corp2.t2u(l.t5_ra_location),'');			
			SELF.corp_agent_status_cd						:= IF(corp2.t2u(l.corps_ra_status) IN ['5','6','9'],corp2.t2u(l.corps_ra_status),'');
			SELF.corp_agent_status_desc					:= IF(corp2.t2u(l.corps_ra_status) IN ['5','6','9'],corp2.t2u(l.t4_ra_statusdesc),'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.corp_merger_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.merg_foreign_name).BusinessName;
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_CorpsFile := PROJECT(joinCorpsMrge,CorpsFileTrans(LEFT)) : INDEPENDENT;
		
		
		//**************************************************************
		// MAIN MAPPING - LP File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main LPFileTrans(Corp2_Raw_VA.Layouts.TempLPLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.lp_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.lp_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).AddressLine2;
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.lp_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_cd				    			:= IF(corp2.t2u(l.lp_status) <> '',corp2.t2u(l.lp_status),'');	
			SELF.corp_status_desc								:= Corp2_Raw_VA.Functions.CorpStatusDesc(l.lp_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.lp_status_date,'CCYY-MM-DD').PastDate;			
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.lp_entity_id)[1] = 'L' ,Corp2_Mapping.fValidateDate(l.lp_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.lp_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp <> ''	                                     => 'D',
																								 corp2.t2u(l.lp_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp <> ''	                                     => 'EXPIRATION DATE',
																								 corp2.t2u(l.lp_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= MAP(corp2.t2u(l.lp_entity_id)[1]='M'  => 'F',
																								 corp2.t2u(l.lp_entity_id)[1]='L'  => 'D',
																								 '');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.lp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.lp_incorp_state) IN ['US','FN','TT']					      => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Codes(l.lp_incorp_state)	=> corp2.t2u(l.lp_incorp_state),
																										'**'
																									 ),
																								''
																							 );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.lp_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.lp_incorp_state) IN ['US','FN','TT']								   => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Description(l.t2_for_stdesc) => corp2.t2u(l.t2_for_stdesc),
																										Corp2_Raw_VA.Functions.State_Code_Translation(l.lp_incorp_state)
																									 ),
																								''
																							 );																					 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.lp_entity_id)[1]  = 'M',Corp2_Mapping.fValidateDate(l.lp_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= MAP(corp2.t2u(l.lp_entity_id)[1] =  'M' => 'FOREIGN LIMITED PARTNERSHIP',
																								 corp2.t2u(l.lp_entity_id)[1] <> 'L' => 'LIMITED PARTNERSHIP',																								 
																								 ''
																								);
			SELF.corp_orig_bus_type_cd					:= corp2.t2u(l.lp_industry_code);			
			SELF.corp_orig_bus_type_desc   	   	:= corp2.t2u(l.t3_busdesc);
			//OVERLOADED - The assessment information is placed here since there is not  a specific field for it.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.t7_assessmt_desc) <> '','ASSESSMENT: '+ corp2.t2u(l.t7_assessmt_desc),'');
			SELF.corp_ra_full_name							:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.lp_ra_name).BusinessName;
      //OVERLOADED - The ra status description is placed here since it is not a ra title.			
			SELF.corp_ra_addl_info              := IF(corp2.t2u(l.lp_ra_status) IN ['1','2','3','4','5','6','7','8'],corp2.t2u(l.t28_ra_statusdesc),'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.lp_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).AddressLine2;
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_street1,l.lp_street2,l.lp_city,l.lp_state,l.lp_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.lp_ra_street1,l.lp_ra_street2,l.lp_ra_city,l.lp_ra_state,l.lp_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_county							:= IF(corp2.t2u(l.lp_ra_loc) <> '',corp2.t2u(l.t5_ra_location),'');			
			SELF.corp_agent_status_cd						:= IF(corp2.t2u(l.lp_ra_status) = '6',corp2.t2u(l.lp_ra_status),'');
			SELF.corp_agent_status_desc					:= IF(corp2.t2u(l.lp_ra_status) = '6',corp2.t2u(l.t28_ra_statusdesc),'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.corp_merger_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.merg_foreign_name).BusinessName;
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_LPFile := PROJECT(joinLPMrge,LPFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING - LLC File
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main LLCFileTrans(Corp2_Raw_VA.Layouts.TempLLCLayoutIn l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.llc_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.llc_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.llc_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= '01';                                                                                                                                                    
			SELF.corp_ln_name_type_desc     		:= 'LEGAL'; 
			SELF.corp_address1_type_cd					:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).ifAddressExists,'B','');
			SELF.corp_address1_type_desc				:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).ifAddressExists,'BUSINESS','');
			SELF.corp_address1_line1						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).AddressLine1;
			SELF.corp_address1_line2						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).AddressLine2;
			SELF.corp_address1_effective_date		:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).ifAddressExists,Corp2_Mapping.fValidateDate(l.llc_po_eff_date,'CCYY-MM-DD').GeneralDate,'');
			SELF.corp_status_cd				    			:= IF(corp2.t2u(l.llc_status) <> '',corp2.t2u(l.llc_status),'');	
			SELF.corp_status_desc								:= Corp2_Raw_VA.Functions.CorpStatusDesc(l.llc_status);			
			SELF.corp_status_date								:= Corp2_Mapping.fValidateDate(l.llc_status_date,'CCYY-MM-DD').PastDate;			
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_inc_date									:= IF(corp2.t2u(l.llc_entity_id)[1] = 'S' ,Corp2_Mapping.fValidateDate(l.llc_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_term_exist_exp						:= Corp2_Mapping.fValidateDate(l.llc_duration,'CCYY-MM-DD').GeneralDate;
			SELF.corp_term_exist_cd							:= MAP(SELF.corp_term_exist_exp  <> ''	                                    => 'D',
																								 corp2.t2u(l.llc_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'P',
																								 ''
																								 );
			SELF.corp_term_exist_desc						:= MAP(SELF.corp_term_exist_exp  <> ''	                                    => 'EXPIRATION DATE',
																								 corp2.t2u(l.llc_duration) IN ['9999-99-99','999-99-99','9999-00-99'] => 'PERPETUAL',
																								 ''
																								 );
			SELF.corp_foreign_domestic_ind			:= MAP(corp2.t2u(l.llc_entity_id)[1]='T'  => 'F',
																								 corp2.t2u(l.llc_entity_id)[1]='S'  => 'D',
																								 '');
			SELF.corp_forgn_state_cd						:= IF(corp2.t2u(l.llc_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.llc_incorp_state) IN ['US','FN','TT']					      => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Codes(l.llc_incorp_state)	=> corp2.t2u(l.llc_incorp_state),
																										'**'
																									 ),
																								''
																							 );
			SELF.corp_forgn_state_desc          := IF(corp2.t2u(l.llc_incorp_state) NOT IN [state_origin,''],
																								MAP(corp2.t2u(l.llc_incorp_state) IN ['US','FN','TT']								   => '',
																										Corp2_Raw_VA.Functions.Valid_US_State_Description(l.t2_for_stdesc) => corp2.t2u(l.t2_for_stdesc),
																										Corp2_Raw_VA.Functions.State_Code_Translation(l.llc_incorp_state)
																									 ),
																								''
																							 );																					 
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.llc_entity_id)[1]  = 'T',Corp2_Mapping.fValidateDate(l.llc_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.corp_orig_org_structure_desc 	:= MAP(corp2.t2u(l.llc_entity_id)[1] =  'T' => 'FOREIGN LIMITED LIABILITY COMPANY',
																								 corp2.t2u(l.llc_entity_id)[1] <> 'S' => 'LIMITED LIABILITY COMPANY',																								 
																								 ''
																								);
			SELF.corp_orig_bus_type_cd					:= corp2.t2u(l.llc_industry_code);			
			SELF.corp_orig_bus_type_desc   	   	:= corp2.t2u(l.t3_busdesc);
			//OVERLOADED - The assessment information is placed here since there is no specific field for this information.
			SELF.corp_addl_info									:= IF(corp2.t2u(l.t7_assessmt_desc) <> '','ASSESSMENT: '+ corp2.t2u(l.t7_assessmt_desc),'');
			SELF.corp_ra_full_name							:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.llc_ra_name).BusinessName;
      //OVERLOADED - The ra status is placed here since it is no a ra title.			
			SELF.corp_ra_addl_info              := IF(corp2.t2u(l.llc_ra_status) IN ['1','2','3','4','5','6','7','8'],corp2.t2u(l.t40_ra_statusdesc),'');
			SELF.corp_ra_effective_date					:= Corp2_Mapping.fValidateDate(l.llc_ra_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_ra_address_type_desc			:= IF(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).ifAddressExists,'REGISTERED OFFICE','');
			SELF.corp_ra_address_line1					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).AddressLine1;	
			SELF.corp_ra_address_line2					:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).AddressLine2;
			SELF.corp_prep_addr1_line1      		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).PrepAddrLine1;																																		
			SELF.corp_prep_addr1_last_line 			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_street1,l.llc_street2,l.llc_city,l.llc_state,l.llc_zip).PrepAddrLastLine;
			SELF.ra_prep_addr_line1         		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).PrepAddrLine1;
			SELF.ra_prep_addr_last_line     		:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.llc_ra_street1,l.llc_ra_street2,l.llc_ra_city,l.llc_ra_state,l.llc_ra_zip).PrepAddrLastLine;
			SELF.corp_agent_county							:= IF(corp2.t2u(l.llc_ra_loc) <> '',corp2.t2u(l.t5_ra_location),'');			
			SELF.corp_agent_status_cd						:= IF(corp2.t2u(l.llc_ra_status) = '6',corp2.t2u(l.llc_ra_status),'');
			SELF.corp_agent_status_desc					:= IF(corp2.t2u(l.llc_ra_status) = '6',corp2.t2u(l.t40_ra_statusdesc),'');
			SELF.corp_merger_effective_date			:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_merged_corporation_id			:= corp2.t2u(l.merg_surv_id);
			SELF.corp_merger_indicator					:= MAP(corp2.t2u(l.merg_type) = 'N'  => 'N',
																								 corp2.t2u(l.merg_type) = 'S'  => 'S',
																								 ''
																								 );
			SELF.corp_merger_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.merg_foreign_name).BusinessName;
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		

		mapped_Main_LLCFile := PROJECT(joinLLCMrge,LLCFileTrans(LEFT)) : INDEPENDENT;
		
		
		//**************************************************************
		// MAIN MAPPING - NAMES File
		//**************************************************************
		jNamesHistFile	:= join(NamesHistFile, joinCorpsMrge, 
											corp2.t2u(left.nmhist_entity_id) = corp2.t2u(right.corps_entity_id),
											transform(Corp2_Raw_VA.Layouts.NamesHist_TempLay, 
																 self.corps_entity_id   := right.corps_entity_id;
																 self.corps_incorp_date := right.corps_incorp_date;
																 self := left; self := right; self := [];),
											left outer,local) : independent;
											
		Corp2_Mapping.LayoutsCommon.Main NamesHistFileTrans(Corp2_Raw_VA.Layouts.NamesHist_TempLay l) := TRANSFORM
			SELF.dt_vendor_first_reported				:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				:= (INTEGER)fileDate;
			SELF.dt_first_seen									:= (INTEGER)fileDate;
			SELF.dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						:= (INTEGER)fileDate;			
			SELF.corp_key												:= state_fips + '-' + corp2.t2u(l.nmhist_entity_id);
			SELF.corp_vendor										:= state_fips;
			SELF.corp_state_origin							:= state_origin;			
			SELF.corp_process_date							:= fileDate;
			SELF.corp_orig_sos_charter_nbr			:= corp2.t2u(l.nmhist_entity_id);
			SELF.corp_legal_name								:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.nmhist_entity_name).BusinessName;
			SELF.corp_ln_name_type_cd       		:= MAP(corp2.t2u(l.nmhist_name_status) = '50' => 'F',
																								 corp2.t2u(l.nmhist_name_status) = '70' => 'P',                                                    
																								 ''
																								);		                                                                                                                                              
			SELF.corp_ln_name_type_desc     		:= MAP(corp2.t2u(l.nmhist_name_status) = '50' => 'FBN',
																								 corp2.t2u(l.nmhist_name_status) = '70' => 'PRIOR',                                                    
																								 ''
																								);		
			SELF.corp_inc_state									:= state_origin;		
			SELF.corp_name_effective_date    		:= Corp2_Mapping.fValidateDate(l.nmhist_name_eff_date,'CCYY-MM-DD').GeneralDate;
			SELF.corp_inc_date									:= IF(corp2.t2u(l.corps_entity_id)[1] IN ['0','1','2','3','4','5','6','7','8','9'],Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_forgn_date								:= IF(corp2.t2u(l.corps_entity_id)[1]  = 'F',Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.recordorigin										:= 'C';
			SELF 																:= [];
		END;		
		
		mapped_Main_NamesHistFile := PROJECT(jNamesHistFile,NamesHistFileTrans(LEFT)) : INDEPENDENT;


		//**************************************************************
		// MAIN MAPPING - RESERVED File
		//**************************************************************
		jReservedFile	:= join(ReservedFile, joinCorpsMrge, 
													corp2.t2u(left.res_number) = corp2.t2u(right.corps_entity_id),
													transform(Corp2_Raw_VA.Layouts.Reserved_TempLay, 
																		 self.corps_entity_id   := right.corps_entity_id;
																		 self.corps_incorp_date := right.corps_incorp_date;
																		 self := left; self := right; self := [];),
													left outer,local) : independent;
													
		Corp2_Mapping.LayoutsCommon.Main ResrvdFileTrans(Corp2_Raw_VA.Layouts.Reserved_TempLay l) := TRANSFORM
			SELF.dt_vendor_first_reported				      := (INTEGER)fileDate;
			SELF.dt_vendor_last_reported				      := (INTEGER)fileDate;
			SELF.dt_first_seen									      := (INTEGER)fileDate;
			SELF.dt_last_seen										      := (INTEGER)fileDate;
			SELF.corp_ra_dt_first_seen					      := (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen						      := (INTEGER)fileDate;			
			SELF.corp_key												      := state_fips + '-' + corp2.t2u(l.res_number);
			SELF.corp_vendor										      := state_fips;
			SELF.corp_state_origin							      := state_origin;			
			SELF.corp_process_date							      := fileDate;
			SELF.corp_orig_sos_charter_nbr			      := corp2.t2u(l.res_number);
			SELF.corp_legal_name								      := Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_name).BusinessName;
			SELF.corp_ln_name_type_cd       	      	:= MAP(corp2.t2u(l.res_status) = '60' => '09',
																											 corp2.t2u(l.res_status) = '61' => '07',                                                    
																											 ''
																											);		                                                                                                                                              
			SELF.corp_ln_name_type_desc            		:= MAP(corp2.t2u(l.res_status) = '60' => 'REGISTRATION',
																											 corp2.t2u(l.res_status) = '61' => 'RESERVED',                                                    
																											 ''
																											);		
			SELF.corp_inc_state									       := state_origin;		
			SELF.Corp_Name_Reservation_Expiration_Date := Corp2_Mapping.fValidateDate(l.res_exp_date,'CCYY-MM-DD').GeneralDate;
			SELF.Corp_Name_Reservation_Type            := MAP(corp2.t2u(l.res_type) = 'C' => 'CORPORATION',
																												corp2.t2u(l.res_type) = 'L' => 'LIMITED PARTNERSHIP', 
																												corp2.t2u(l.res_type) = 'X' => 'LIMITED LIABILITY COMPANY',
																											 ''
																											);
			SELF.corp_inc_date									       := IF(corp2.t2u(l.corps_entity_id)[1] IN ['0','1','2','3','4','5','6','7','8','9'],Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');										   																							
			SELF.corp_forgn_date								       := IF(corp2.t2u(l.corps_entity_id)[1]  = 'F',Corp2_Mapping.fValidateDate(l.corps_incorp_date,'CCYY-MM-DD').PastDate,'');
			SELF.recordorigin										       := 'C';
			SELF 																       := [];
		END;		
		
		mapped_Main_ResvdFile := PROJECT(jReservedFile,ResrvdFileTrans(LEFT)) : INDEPENDENT;
			
		//**************************************************************
		// MAIN MAPPING for CONTACTS - CORPORATION & OFFICERS Files
		//**************************************************************
    Corp2_Mapping.LayoutsCommon.Main  Main_OfficersFileTrans(Corp2_Raw_VA.Layouts.TempOfficersCorpsLayoutIn l) := transform
			SELF.dt_vendor_first_reported								:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported								:= (INTEGER)fileDate;
			SELF.dt_first_seen													:= (INTEGER)fileDate;
			SELF.dt_last_seen														:= (INTEGER)fileDate;		
			SELF.corp_ra_dt_first_seen									:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen										:= (INTEGER)fileDate;		
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.offc_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;											
			SELF.corp_process_date											:= fileDate;
			SELF.corp_orig_sos_charter_nbr							:= corp2.t2u(l.offc_entity_id);
			SELF.corp_legal_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.corp_legal_name).BusinessName;
			SELF.corp_inc_state													:= state_origin;
			SELF.cont_full_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.offc_first_name+' '+l.offc_middle_name+' '+l.offc_last_name).BusinessName;
			SELF.cont_title1_desc												:= corp2.t2u(l.offc_title);
			SELF.recordorigin														:= 'T';																										
			SELF 																				:= [];						
		END;	

		mapped_Main_OfficersCont 	:= PROJECT(joinOffcrCorps,Main_OfficersFileTrans(LEFT)) : INDEPENDENT;
		
		//**************************************************************
		// MAIN MAPPING for CONTACTS - RESERVED NAMES Files
		//**************************************************************
		Corp2_Mapping.LayoutsCommon.Main Main_ReservedContTransform(Corp2_Raw_VA.Layouts.ReservedLayoutIn l) := transform
			SELF.dt_vendor_first_reported								:= (INTEGER)fileDate;
			SELF.dt_vendor_last_reported								:= (INTEGER)fileDate;
			SELF.dt_first_seen													:= (INTEGER)fileDate;
			SELF.dt_last_seen														:= (INTEGER)fileDate;		
			SELF.corp_ra_dt_first_seen									:= (INTEGER)fileDate;
			SELF.corp_ra_dt_last_seen										:= (INTEGER)fileDate;
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.res_number);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;						
			SELF.corp_process_date											:= fileDate;
			SELF.corp_orig_sos_charter_nbr							:= corp2.t2u(l.res_number);
			SELF.corp_legal_name												:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_name).BusinessName;
			SELF.corp_inc_state													:= state_origin;																												
			SELF.cont_type_cd														:= MAP(corp2.t2u(l.res_status) = '60' => '02',
																												 corp2.t2u(l.res_status) = '61' => '01',                                                    
																												 ''
																												);				
			SELF.cont_type_desc													:= MAP(corp2.t2u(l.res_status) = '60' => 'REGISTRANT',
																												 corp2.t2u(l.res_status) = '61' => 'RESERVER',                                                    
																												 ''
																												 );																				 
			SELF.cont_full_name													:= Corp2_mapping.fCleanBusinessName(state_origin,state_desc,l.res_requestor).BusinessName;
			SELF.cont_address_type_cd										:= MAP(corp2.t2u(l.res_status) = '60' => '02',
																												 corp2.t2u(l.res_status) = '61' => '01',                                                    
																												 ''
																												);				
			SELF.cont_address_type_desc									:= MAP(corp2.t2u(l.res_status) = '60' => 'REGISTRANT',
																												 corp2.t2u(l.res_status) = '61' => 'RESERVER',                                                    
																												 ''
																												);
			SELF.cont_address_line1											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).AddressLine1;										 
      SELF.cont_address_line2											:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).AddressLine2;
			SELF.cont_prep_addr_line1      							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).PrepAddrLine1;																																		
			SELF.cont_prep_addr_last_line 							:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.res_street1,l.res_street2,l.res_city,l.res_state,l.res_zip).PrepAddrLastLine;
			SELF.recordorigin														:= 'T';																										
			SELF 																				:= [];						
		END;
		
		mapped_Main_ReservedCont := PROJECT(ReservedFile,Main_ReservedContTransform(LEFT)) : INDEPENDENT;	
		

		mapped_All_Main					 := mapped_Main_CorpsFile + mapped_Main_LPFile + mapped_Main_LLCFile + mapped_Main_NamesHistFile + mapped_Main_ResvdFile + mapped_Main_OfficersCont + mapped_Main_ReservedCont;

		AllMain        					 := DEDUP(SORT(DISTRIBUTE(mapped_All_Main,HASH(corp_key)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;		
		
		//**************************************************************
		// MAIN MAPPING for EVENTS 
		//**************************************************************
		
		//Filter out "known" bad records that that are not to be rejected by scrubs per the data insight team.
		mapMain									 := Corp2_Raw_VA.Filter.Main(AllMain);
		Corporations						 := mapMain(recordorigin = 'C');
		
		//To eliminate orphan "events" that do not have an associated corporation record,
		//joining with Corporations (the corporation records within mapMain). 
		AmendNormEvents					 := JOIN(Corporations,joinAmendEvts,
															  		 corp2.t2u(LEFT.corp_key[4..]) = corp2.t2u(RIGHT.amend_entity_id),
																		 TRANSFORM(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn,
																							 SELF := RIGHT;
																							 ),
																		 LEFT ONLY,
																		 LOCAL
																			);

		//********************************************************************
		//EVENT File Mapping from the AmendFile that has been normalized
		//
		//Note: The Amend file contains all three (3) types of corporation
		//			data: Corporation, Limited Parnership, and Limited Liability
		//			Company.
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Events Event_AmendNormTrans(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn l) := TRANSFORM							
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.amend_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;								
			SELF.corp_process_date											:= fileDate;
			SELF.corp_sos_charter_nbr										:= corp2.t2u(l.amend_entity_id);
			SELF.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.amend_date,'CCYY-MM-DD').PastDate;
			SELF.event_date_type_cd           					:= IF(SELF.event_filing_date <> '','FIL','');
			SELF.event_date_type_desc         					:= IF(SELF.event_filing_date <> '','FILING','');
			SELF.event_filing_cd              					:= corp2.t2u(l.amend_type);
			SELF.event_filing_desc            					:= corp2.t2u(l.amend_type_desc);			
			SELF 																				:= [];						
		END;

	
		mapped_Event_AmendFile		 := PROJECT(AmendNormEvents,Event_AmendNormTrans(LEFT));
		
			//********************************************************************
		//Event File Mapping from the mergersFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Events Event_MergersFileTrans(Corp2_Raw_VA.Layouts.MergersLayoutIn l) := TRANSFORM,
		SKIP(corp2.t2u(l.merg_entity_id)	    = '' OR 
		     (Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').PastDate = '' AND
				  corp2.t2u(l.merg_foreign_name)  = '' AND
				  corp2.t2u(l.merg_type) 				  = '' AND
				  corp2.t2u(l.merg_surv_id) 			= '')
				)
			SELF.corp_key																:= state_fips + '-' + corp2.t2u(l.merg_entity_id);
			SELF.corp_vendor														:= state_fips;
			SELF.corp_state_origin											:= state_origin;
			SELF.corp_process_date											:= fileDate;
			SELF.corp_sos_charter_nbr										:= corp2.t2u(l.merg_entity_id);
			SELF.event_filing_date            					:= Corp2_Mapping.fValidateDate(l.merg_eff_date,'CCYY-MM-DD').PastDate;
			SELF.event_date_type_cd           					:= 'MER';
			SELF.event_date_type_desc         					:= 'MERGER';
			merge_corp_name          										:= IF(corp2.t2u(l.merg_foreign_name) <> '',
																												'FOREIGN CORP NAME: ' + corp2.t2u(l.merg_foreign_name),
																												''
																											 );
			SELF.event_desc                   					:= MAP(corp2.t2u(l.merg_type) = 'N' => 'MERGED TO: ' 			+ corp2.t2u(l.merg_surv_id) + IF(merge_corp_name <> '','; ' + merge_corp_name,''),
																												 corp2.t2u(l.merg_type) = 'S' => 'SURVIVING CORP: ' + corp2.t2u(l.merg_surv_id) + IF(merge_corp_name <> '','; ' + merge_corp_name,''),
																												 merge_corp_name
																											  );
			SELF 																				:= [];						
		END;		

		mapped_Event_MergersFile := PROJECT(MergersFile,Event_MergersFileTrans(LEFT));
    mapped_All_Events        := mapped_Event_AmendFile + mapped_Event_MergersFile;
		
		mapEvents      					 := DEDUP(SORT(DISTRIBUTE(mapped_All_Events,HASH(corp_key)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;

    //********************************************************************
		//STOCK File Mapping from the corpsFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_CorpsStockTrans(Corp2_Raw_VA.Layouts.TempNormCorpsLayoutIn l) := TRANSFORM		
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.corps_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.corps_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.corps_total_shares);	
			SELF.stock_addl_info              := corp2.t2u(l.stock_addl_info);
			SELF.stock_stock_description			:= MAP(corp2.t2u(l.corps_stock_ind) = 'N' => 'NON-STOCK',
																							 corp2.t2u(l.corps_stock_ind) = 'S' => 'STOCK',
																							 ''
																							);
			SELF 															:= [];
		END;

		mapped_Stock_Corps 				:= PROJECT(srt_dNormedCorpsStk,Stock_CorpsStockTrans(LEFT));
		mapped_Stock_CorpsFile		:= mapped_Stock_Corps(stock_addl_info <> '' OR stock_shares_issued NOT IN ['','0']);

    //********************************************************************
		//STOCK File Mapping from the LPFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_LPStockTrans(Corp2_Raw_VA.Layouts.TempNormLPLayoutIn l) := TRANSFORM		
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.lp_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.lp_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.lp_total_shares);
			SELF.stock_addl_info              := corp2.t2u(l.stock_addl_info);
			SELF.stock_stock_description			:= MAP(corp2.t2u(l.lp_stock_ind) = 'N' => 'NON-STOCK',
																							 corp2.t2u(l.lp_stock_ind) = 'S' => 'STOCK',
																							 ''
																							);
			SELF 															:= [];
		END;

		mapped_Stock_LP 			:= PROJECT(srt_dNormedLPStk,Stock_LPStockTrans(LEFT));
		mapped_Stock_LPFile		:= mapped_Stock_LP(stock_addl_info <> '' OR stock_shares_issued NOT IN ['','0']);
		
		//********************************************************************
		//STOCK File Mapping from the LLCFile
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock  Stock_LLCStockTrans(Corp2_Raw_VA.Layouts.TempNormLLCLayoutIn l) := TRANSFORM		
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.llc_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.llc_entity_id);
			SELF.stock_shares_issued          := corp2.t2u(l.llc_total_shares);	
			SELF.stock_addl_info              := corp2.t2u(l.stock_addl_info);
			SELF.stock_stock_description			:= MAP(corp2.t2u(l.llc_stock_ind) = 'N' => 'NON-STOCK',
																							 corp2.t2u(l.llc_stock_ind) = 'S' => 'STOCK',
																							 ''
																							);
			SELF 															:= [];
		END;

		mapped_Stock_LLC 			:= PROJECT(srt_dNormedLLCStk,Stock_LLCStockTrans(LEFT));
		mapped_Stock_LLCFile	:= mapped_Stock_LLC(stock_addl_info <> '' OR stock_shares_issued NOT IN ['','0']);
		
		//********************************************************************
		//STOCK File Mapping from the AmendFile that has been normalized
		//********************************************************************
		Corp2_Mapping.LayoutsCommon.Stock Stock_AmendStockNormTrans(Corp2_Raw_VA.Layouts.TempNormAmendLayoutIn l) := TRANSFORM
			SELF.corp_key											:= state_fips + '-' + corp2.t2u(l.amend_entity_id);
			SELF.corp_vendor									:= state_fips;
			SELF.corp_state_origin						:= state_origin;
			SELF.corp_process_date						:= fileDate;
			SELF.corp_sos_charter_nbr					:= corp2.t2u(l.amend_entity_id);
			SELF.stock_addl_info              := corp2.t2u(l.stock_addl_info);
			SELF.stock_change_date          	:= IF(l.amend_type = '4',Corp2_Mapping.fValidateDate(l.amend_date,'CCYY-MM-DD').PastDate,'');
			SELF 															:= [];
		END;

		mapped_Stock_Amend		 	:= PROJECT(srt_dNormedAmendStk,	Stock_AmendStockNormTrans(LEFT));
		mapped_Stock_AmendFile 	:= mapped_Stock_Amend(stock_addl_info <> '');
		
		mapped_All_Stock				:= mapped_Stock_CorpsFile + mapped_Stock_LPFile + mapped_Stock_LLCFile + mapped_Stock_AmendFile;
		mapStocks      					:= DEDUP(SORT(DISTRIBUTE(mapped_All_Stock,HASH(corp_key)),RECORD,LOCAL),RECORD,LOCAL) : INDEPENDENT;

	//********************************************************************
  // SCRUB EVENT
  //********************************************************************	
		Event_F := mapEvents;
		Event_S := Scrubs_Corp2_Mapping_VA_Event.Scrubs;						// Scrubs module
		Event_N := Event_S.FromNone(Event_F); 											// Generate the error flags
		Event_T := Event_S.FromBits(Event_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Event_U := Event_S.FromExpanded(Event_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module
		
		//Outputs reports
		Event_ErrorSummary				:= OUTPUT(Event_U.SummaryStats, NAMED('Event_ErrorSummary_VA'+filedate));
		Event_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Event_U.AllErrors, 1000), NAMED('Event_ScrubErrorReport_VA'+filedate));
		Event_SomeErrorValues			:= OUTPUT(CHOOSEN(Event_U.BadValues, 1000), NAMED('Event_SomeErrorValues_VA'+filedate));
		Event_IsScrubErrors		 		:= IF(COUNT(Event_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Event_OrbitStats					:= Event_U.OrbitStats();
		
		//Outputs files
		Event_CreateBitMaps				:= OUTPUT(Event_N.BitmapInfile,,'~thor_data::corp_va_event_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Event_TranslateBitMap			:= OUTPUT(Event_T);

		//Submits Profile's stats to Orbit
		Event_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_VA_Event').SubmitStats;
		Event_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Event','ScrubsAlerts', Event_OrbitStats, version,'Corp_VA_Event').CompareToProfile_with_Examples;

		Event_ScrubsAlert					:= Event_ScrubsWithExamples(RejectWarning = 'Y');
		Event_ScrubsAttachment		:= Scrubs.fn_email_attachment(Event_ScrubsAlert);
		Event_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpEvent_VA Report' //subject
																																 ,'Scrubs CorpEvent_VA Report' //body
																																 ,(DATA)Event_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAEventScrubsReport.csv'
																																 );

		Event_BadRecords				 	:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 OR
																												corp_vendor_Invalid 									<> 0 OR																						
																												corp_state_origin_Invalid 					 	<> 0 OR
																												corp_process_date_Invalid							<> 0 OR
																												corp_sos_charter_nbr_Invalid 					<> 0 OR
																												event_filing_date_Invalid 						<> 0 OR
																												event_filing_cd_Invalid 							<> 0
																												
																											 );																									 

		Event_GoodRecords					:= Event_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 AND
																												corp_vendor_Invalid 									= 0 AND																				
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid 					= 0 AND
																												event_filing_date_Invalid							= 0 AND
																												event_filing_cd_Invalid 							= 0
																												
																											);

		Event_FailBuild						:= IF(COUNT(Event_GoodRecords) = 0,TRUE,FALSE);

		Event_ApprovedRecords			:= PROJECT(Event_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Events,SELF := LEFT));
		

		Event_ALL									:= SEQUENTIAL(IF(COUNT(Event_BadRecords) <> 0
																											,IF (poverwrite
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,OVERWRITE,__COMPRESSED__)
																													,OUTPUT(Event_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::event_'+state_origin,__COMPRESSED__)
																													)
																											)
																									 ,OUTPUT(Event_ScrubsWithExamples, ALL, NAMED('CorpEventVAScrubsReportWithExamples'+filedate))
																									 //Send Alerts if Scrubs exceeds thresholds
																									 ,IF(COUNT(Event_ScrubsAlert) > 0, Event_MailFile, OUTPUT('CORP2_MAPPING.VA - No "EVENT" Corp Scrubs Alerts'))
																									 ,Event_ErrorSummary
																									 ,Event_ScrubErrorReport
																									 ,Event_SomeErrorValues			
																									 ,Event_SubmitStats
																								);

	//********************************************************************
  // SCRUB MAIN
  //********************************************************************	
		Main_F := mapMain;
		Main_S := Scrubs_Corp2_Mapping_VA_Main.Scrubs;					// Scrubs module
		Main_N := Main_S.FromNone(Main_F); 											// Generate the error flags
		Main_T := Main_S.FromBits(Main_N.BitmapInfile);     		// Use the FromBits module; makes my bitmap datafile easier to get to
		Main_U := Main_S.FromExpanded(Main_N.ExpandedInFile); 	// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Main_ErrorSummary					:= OUTPUT(Main_U.SummaryStats, NAMED('Main_ErrorSummary_VA'+filedate));
		Main_ScrubErrorReport 		:= OUTPUT(CHOOSEN(Main_U.AllErrors, 1000), NAMED('Main_ScrubErrorReport_VA'+filedate));
		Main_SomeErrorValues			:= OUTPUT(CHOOSEN(Main_U.BadValues, 1000), NAMED('Main_SomeErrorValues_VA'+filedate));
		Main_IsScrubErrors		 		:= IF(COUNT(Main_U.AllErrors) <> 0,TRUE,FALSE);

		// Orbit Stats
		Main_OrbitStats						:= Main_U.OrbitStats();

		//Outputs files
		Main_CreateBitMaps				:= OUTPUT(Main_N.BitmapInfile,,'~thor_data::corp_va_main_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Main_TranslateBitMap			:= OUTPUT(Main_T);

		//Submits Profile's stats to Orbit
		Main_SubmitStats 			  := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_VA_Main').SubmitStats;
		Main_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Main','ScrubsAlerts', Main_OrbitStats, version,'Corp_VA_Main').CompareToProfile_with_Examples;

		Main_ScrubsAlert					:= Main_ScrubsWithExamples(RejectWarning = 'Y');
		Main_ScrubsAttachment			:= Scrubs.fn_email_attachment(Main_ScrubsAlert);
		Main_MailFile							:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpMain_VA Report' //subject
																																 ,'Scrubs CorpMain_VA Report' //body
																																 ,(DATA)Main_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAMainScrubsReport.csv'
																															);

		Main_BadRecords						:= Main_N.ExpandedInFile(	
																											 dt_vendor_first_reported_Invalid					 			<> 0 OR
																											 dt_vendor_last_reported_Invalid 								<> 0 OR
																											 dt_first_seen_Invalid 													<> 0 OR
																											 dt_last_seen_Invalid 													<> 0 OR
																											 corp_ra_dt_first_seen_Invalid 									<> 0 OR
																											 corp_ra_dt_last_seen_Invalid 									<> 0 OR
																											 corp_key_Invalid 															<> 0 OR
																											 corp_vendor_Invalid 														<> 0 OR
																											 corp_state_origin_Invalid 									 		<> 0 OR
																											 corp_process_date_Invalid										  <> 0 OR
																											 corp_orig_sos_charter_nbr_Invalid 							<> 0 OR
																											 corp_legal_name_Invalid 												<> 0 OR	
																											 corp_ln_name_type_cd_Invalid 									<> 0 OR
																											 corp_address1_type_cd_Invalid 									<> 0 OR
																											 corp_address1_type_desc_Invalid 								<> 0 OR
																											 corp_address1_effective_date_Invalid 					<> 0 OR
																											 corp_status_cd_Invalid 												<> 0 OR
																											 corp_status_date_Invalid 											<> 0 OR
																											 corp_inc_state_Invalid 												<> 0 OR
																											 corp_inc_date_Invalid 													<> 0 OR
																											 corp_term_exist_cd_Invalid 										<> 0 OR
																											 corp_term_exist_exp_Invalid 										<> 0 OR
																											 corp_term_exist_desc_Invalid 									<> 0 OR
																											 corp_foreign_domestic_ind_Invalid 							<> 0 OR
																											 corp_forgn_state_cd_Invalid 										<> 0 OR
																											 corp_forgn_state_desc_Invalid									<> 0 OR
																											 corp_forgn_date_Invalid 												<> 0 OR
																											 corp_orig_bus_type_cd_Invalid 									<> 0 OR
																											 corp_ra_effective_date_Invalid 							 	<> 0 OR
																											 corp_name_effective_date_Invalid 							<> 0 OR
																											 corp_name_reservation_expiration_date_Invalid 	<> 0
																										);
																										 																	
		Main_GoodRecords				:= Main_N.ExpandedInFile(
																											 dt_vendor_first_reported_Invalid					 			= 0 AND
																											 dt_vendor_last_reported_Invalid 								= 0 AND
																											 dt_first_seen_Invalid 													= 0 AND
																											 dt_last_seen_Invalid 													= 0 AND
																											 corp_ra_dt_first_seen_Invalid 									= 0 AND
																											 corp_ra_dt_last_seen_Invalid 									= 0 AND
																											 corp_key_Invalid 															= 0 AND
																											 corp_vendor_Invalid 														= 0 AND
																											 corp_state_origin_Invalid 									 		= 0 AND
																											 corp_process_date_Invalid										  = 0 AND
																											 corp_orig_sos_charter_nbr_Invalid 							= 0 AND
																											 corp_legal_name_Invalid 												= 0 AND	
																											 corp_ln_name_type_cd_Invalid 									= 0 AND
																											 corp_address1_type_cd_Invalid 									= 0 AND
																											 corp_address1_type_desc_Invalid 								= 0 AND
																											 corp_address1_effective_date_Invalid 					= 0 AND
																											 corp_status_cd_Invalid 												= 0 AND
																											 corp_status_date_Invalid 											= 0 AND
																											 corp_inc_state_Invalid 												= 0 AND
																											 corp_inc_date_Invalid 													= 0 AND
																											 corp_term_exist_cd_Invalid 										= 0 AND
																											 corp_term_exist_exp_Invalid 										= 0 AND
																											 corp_term_exist_desc_Invalid 									= 0 AND
																											 corp_foreign_domestic_ind_Invalid 							= 0 AND
																											 corp_forgn_state_cd_Invalid 										= 0 AND
																											 corp_forgn_state_desc_Invalid									= 0 AND
																											 corp_forgn_date_Invalid 												= 0 AND
																											 corp_orig_bus_type_cd_Invalid 									= 0 AND
																											 corp_ra_effective_date_Invalid 							 	= 0 AND
																											 corp_name_effective_date_Invalid 							= 0 AND
																											 corp_name_reservation_expiration_date_Invalid 	= 0																										 
																								  );

		Main_FailBuild					:= MAP( Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_key_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 										> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_KEY										 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_orig_sos_charter_nbr_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 	> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_ORIG_SOS_CHARTER_NBR 	 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_ln_name_type_cd_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 				> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_LN_NAME_TYPE_CD		  	 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_legal_name_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 						> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_LEGAL_NAME 						 => TRUE,
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_status_cd_Invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 						  > Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_STATUS_CD 						 => TRUE,																	
																		Corp2_Mapping.fCalcPercent(COUNT(Main_N.ExpandedInFile(corp_inc_date_invalid<>0)),COUNT(Main_N.ExpandedInFile),FALSE) 							> Scrubs_Corp2_Mapping_VA_Main.Threshold_Percent.CORP_INC_DATE 						 	 => TRUE,
																	  COUNT(Main_GoodRecords) = 0																																																																																											 => TRUE,																		
																		FALSE
																	);

		Main_ApprovedRecords		:= PROJECT(Main_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Main,SELF := LEFT));


		Main_ALL		 			:= SEQUENTIAL( IF(COUNT(Main_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,OVERWRITE,__COMPRESSED__)
																									,OUTPUT(Main_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::main_'+state_origin,__COMPRESSED__)
																									)
																							)
																					,OUTPUT(Main_ScrubsWithExamples, all, named('CorpMainVAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Main_ScrubsAlert) > 0, Main_MailFile, OUTPUT('CORP2_MAPPING.VA - No "MAIN" Corp Scrubs Alerts'))
																					,Main_ErrorSummary
																					,Main_ScrubErrorReport
																					,Main_SomeErrorValues	
																					,Main_SubmitStats
																			);

	//********************************************************************
  // SCRUB STOCK
  //********************************************************************	
		Stock_F := mapStocks;
		Stock_S := Scrubs_Corp2_Mapping_VA_Stock.Scrubs;						// Scrubs module
		Stock_N := Stock_S.FromNone(Stock_F); 											// Generate the error flags
		Stock_T := Stock_S.FromBits(Stock_N.BitmapInfile);     			// Use the FromBits module; makes my bitmap datafile easier to get to
		Stock_U := Stock_S.FromExpanded(Stock_N.ExpandedInFile); 		// Pass the expanded error flags into the Expanded module

		//Outputs reports
		Stock_ErrorSummary			 	:= OUTPUT(Stock_U.SummaryStats, NAMED('Stock_ErrorSummary_VA'+filedate));
		Stock_ScrubErrorReport 	 	:= OUTPUT(CHOOSEN(Stock_U.AllErrors, 1000), NAMED('Stock_ScrubErrorReport_VA'+filedate));
		Stock_SomeErrorValues		 	:= OUTPUT(CHOOSEN(Stock_U.BadValues, 1000), NAMED('Stock_SomeErrorValues_VA'+filedate));
		Stock_IsScrubErrors		 	 	:= IF(COUNT(Stock_U.AllErrors)<> 0,TRUE,FALSE);

		// Orbit Stats
		Stock_OrbitStats				 	:= Stock_U.OrbitStats();

		//Outputs files
		Stock_CreateBitMaps				:= OUTPUT(Stock_N.BitmapInfile,,'~thor_data::corp_va_scrubs_bits',OVERWRITE,COMPRESSED);	//long term storage
		Stock_TranslateBitMap			:= OUTPUT(Stock_T);

		//Submits Profile's stats to Orbit
		Stock_SubmitStats 			 := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_VA_Stock').SubmitStats;
		Stock_ScrubsWithExamples := Scrubs.OrbitProfileStats('Scrubs_Corp2_Mapping_VA_Stock','ScrubsAlerts', Stock_OrbitStats, version,'Corp_VA_Stock').CompareToProfile_with_Examples;

		Stock_ScrubsAlert					:= Stock_ScrubsWithExamples(RejectWarning = 'Y');
		Stock_ScrubsAttachment		:= Scrubs.fn_email_attachment(Stock_ScrubsAlert);
		Stock_MailFile						:= FileServices.SendEmailAttachData(corp2.Email_Notification_Lists.AttachedList
																																 ,'Scrubs CorpStock_VA Report' //subject
																																 ,'Scrubs CorpStock_VA Report' //body
																																 ,(DATA)Stock_ScrubsAttachment
																																 ,'text/csv'
																																 ,'CorpVAEventScrubsReport.csv'
																																);

		Stock_BadRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			<> 0 OR
																												corp_vendor_Invalid 									<> 0 OR
																												corp_state_origin_Invalid 					 	<> 0 OR
																												corp_process_date_Invalid						  <> 0 OR
																												corp_sos_charter_nbr_Invalid					<> 0 OR
																											  stock_shares_issued_Invalid						<> 0 OR
																												stock_addl_info_Invalid				      	<> 0 OR
																											  stock_change_date_Invalid							<> 0 OR
																											  stock_stock_description_Invalid				<> 0
																											 );
																												
		Stock_GoodRecords					:= Stock_N.ExpandedInFile(	
																												corp_key_Invalid							  			= 0 AND
																												corp_vendor_Invalid 									= 0 AND
																												corp_state_origin_Invalid 					 	= 0 AND
																												corp_process_date_Invalid						  = 0 AND
																												corp_sos_charter_nbr_Invalid					= 0 AND
																											  stock_shares_issued_Invalid						= 0 AND
																											  stock_addl_info_Invalid					      = 0 AND
 																										    stock_change_date_Invalid							= 0 AND
																											  stock_stock_description_Invalid				= 0
																											 );
																														
		Stock_FailBuild						:= IF(COUNT(Stock_GoodRecords) = 0,TRUE,FALSE);

		Stock_ApprovedRecords			:= PROJECT(Stock_GoodRecords,TRANSFORM(Corp2_Mapping.LayoutsCommon.Stock,SELF := LEFT));

		Stock_ALL									:= SEQUENTIAL( IF(COUNT(Stock_BadRecords) <> 0
																							,IF (poverwrite
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,overwrite,__compressed__)
																									,OUTPUT(Stock_BadRecords,,Corp2_Mapping._Dataset().thor_cluster_Files + 'out::corp2::'+version+'::rejected::stock_'+state_origin,__compressed__)
																									)
																							)
																					,output(Stock_ScrubsWithExamples, all, named('CorpStockVAScrubsReportWithExamples'+filedate))
																					//Send Alerts if Scrubs exceeds thresholds
																					,IF(COUNT(Stock_ScrubsAlert) > 0, Stock_MailFile, OUTPUT('CORP2_MAPPING.VA - No "Stock" Corp Scrubs Alerts'))
																					,Stock_ErrorSummary
																					,Stock_ScrubErrorReport
																					,Stock_SomeErrorValues	
																					,Stock_SubmitStats
																					);	

	//********************************************************************
  // UPDATE
  //********************************************************************

	Fail_Build						:= IF(Event_FailBuild = TRUE OR Main_FailBuild = TRUE OR Stock_FailBuild = TRUE,TRUE,FALSE);
	IsScrubErrors					:= IF(Event_IsScrubErrors = TRUE OR Main_IsScrubErrors = TRUE OR Stock_IsScrubErrors = TRUE,TRUE,FALSE);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Event_' 	+ state_origin, Event_ApprovedRecords, write_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Main_' 	+ state_origin, Main_ApprovedRecords , write_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'in::corp2::' 	+ version + '::Stock_' 	+ state_origin, Stock_ApprovedRecords, write_stock,,,pOverwrite);

	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Event_' 	+ state_origin, Event_F	, write_fail_event,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Main_' 	+ state_origin, Main_F	, write_fail_main,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Corp2_Mapping._dataset().thor_cluster_Files + 'fail::corp2::' + version + '::Stock_' 	+ state_origin, Stock_F	, write_fail_stock,,,pOverwrite);

	mapVA:= sequential ( IF(pshouldspray = TRUE,Corp2_mapping.fSprayFiles(state_origin,version,pOverwrite := pOverwrite))
											// ,Corp2_Raw_VA.Build_Bases(filedate,version,puseprod).ALL // Determined building of bases is not needed
											,Event_All
											,Main_All
											,Stock_All									
											,IF(Fail_Build <> TRUE	 
												 ,SEQUENTIAL (write_event
																		 ,write_main
																		 ,write_stock	
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::event'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::event_'	+state_origin)
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::main'		,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::main_'	+state_origin)																		 
																		 ,fileservices.addsuperfile(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::'+Corp2_Mapping._Dataset().NameMapped +'::sprayed::stock'	,Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::'+version+'::stock_'	+state_origin)
																		 ,IF(COUNT(Main_BadRecords) <> 0 OR COUNT(Event_BadRecords) <> 0 OR COUNT(Stock_BadRecords)<>0
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords)<>0,,COUNT(Event_BadRecords)<>0,COUNT(Stock_BadRecords)<>0,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),COUNT(Stock_BadRecords),COUNT(Main_ApprovedRecords),,COUNT(Event_ApprovedRecords),COUNT(Stock_ApprovedRecords)).RecordsRejected																				 
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,COUNT(Main_BadRecords)<>0,,COUNT(Event_BadRecords)<>0,COUNT(Stock_BadRecords)<>0,COUNT(Main_BadRecords),,COUNT(Event_BadRecords),COUNT(Stock_BadRecords),COUNT(Main_ApprovedRecords),,COUNT(Event_ApprovedRecords),COUNT(Stock_ApprovedRecords)).MappingSuccess																				 
																		 	 )
																		 ,IF(IsScrubErrors
																		 	 ,Corp2_Mapping.Send_Email(state_origin,version,Main_IsScrubErrors,FALSE,Event_IsScrubErrors,Stock_IsScrubErrors).FieldsInvalidPerScrubs
																			 )
																		 ) //if Fail_Build <> true																			
												 ,SEQUENTIAL (write_fail_event
																		 ,write_fail_main
																		 ,write_fail_stock												 
																		 ,Corp2_Mapping.Send_Email(state_origin,version).MappingFailed
																		 ) //if Fail_Build = true
												 )
										);
										
	//isFileDateValid := IF((STRING)std.date.today() BETWEEN ut.date_math(filedate,-30) AND ut.date_math(filedate,30),TRUE,FALSE);
	isFileDateValid := IF((STRING)std.date.today() BETWEEN ut.date_math(filedate,-90) AND ut.date_math(filedate,90),TRUE,FALSE);
	RETURN SEQUENTIAL (	 IF(isFileDateValid
													,mapVA
													,SEQUENTIAL (Corp2_Mapping.Send_Email(state_origin,filedate).InvalidFileDateParm
																			,FAIL('Corp2_Mapping.'+state_origin+' failed.  An invalid filedate was passed in as a parameter.')
																			)
													)
										);

	END;	// end of Update function

END;  // end of Module