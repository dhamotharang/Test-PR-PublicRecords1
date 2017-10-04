IMPORT AutoStandardI, BIPV2, Business_Credit, iesp, ut, MDR, BusinessCredit_Services;

EXPORT fn_getPrimaryIndustry(DATASET(BIPV2.IDlayouts.l_xlink_ids2) Linkids, 
																	String DatapermissionMask, 
																	Boolean IncludeBusinessCredit = FALSE //data team always pass in IncludeBusinessCredit = TRUE for this.
																	) := MODULE
																	
	// we need to select primary industry code from BIP unless Business is an SBFE Singleton, In which case use SBFE.
	BOOLEAN buzCreditAccess	:= BusinessCredit_Services.Functions.fn_useBusinessCredit(DatapermissionMask ,IncludeBusinessCredit);	

	slim_layout := RECORD
		iesp.share.t_BusinessIdentity;
		STRING2 SOURCE;
		STRING8 Sic_Code;
		STRING8 Naics_Code;
		STRING8 Best_Code;
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED2 RecordCount := 1;
	END;
	
	//Fetching Business Header Records.
	ds_busHeaderRecs 		:= BIPV2.Key_BH_Linking_Ids.kfetch2(Linkids,BIPV2.IDconstants.Fetch_Level_SELEID,,,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT,TRUE); //We wanted to fetch all the records for Se level. 
	ds_busHeaderRecsSlim := ds_busHeaderRecs(source not in BusinessCredit_Services.Constants.EXCLUDED_EXPERIAN_SRC);	
	ds_sbfeLinkRecs 		:= Business_Credit.Key_LinkIds().kfetch2(Linkids , BIPV2.IDconstants.Fetch_Level_SELEID,,DatapermissionMask);

	ds_sbfeSICNAICSRecs	:= JOIN(ds_sbfeLinkRecs , Business_Credit.Key_BusinessClassification(), 
																			BusinessCredit_Services.Macros.mac_JoinBusAccounts(),  
																			TRANSFORM(slim_layout, 
																					SELF.UltID 			:= LEFT.UltID;
																					SELF.OrgID 			:= LEFT.OrgID;
																					SELF.Seleid 		:= LEFT.Seleid;
																					SELF.SOURCE 		:= MDR.sourceTools.src_Business_Credit;
																					Sic_Code 				:= IF(RIGHT.Classification_Code_Type = '001' , RIGHT.Classification_Code , '');
																					Naics_Code 			:= IF(RIGHT.Classification_Code_Type = '002' , RIGHT.Classification_Code , '');
																					SELF.Sic_Code 	:= Sic_Code;
																					SELF.Naics_Code := Naics_Code;
																					SELF.Best_Code 	:= MAP ((INTEGER)Sic_Code > 0 => Sic_Code,
																																	(INTEGER)Sic_Code = 0 AND (INTEGER)Naics_Code > 0 => Naics_Code,
																																	'');
																					SELF.dt_first_seen 	:= RIGHT.dt_first_seen;
																					SELF.dt_last_seen 	:= RIGHT.dt_last_seen;
																					SELF 								:= []) , LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));


	ds_SicNaicsRecsToUse :=	IF( NOT EXISTS(ds_busHeaderRecsSlim) ,ds_sbfeSICNAICSRecs);

	slim_layout trans(RECORDOF(ds_busHeaderRecsSlim) L, INTEGER C) := TRANSFORM
		Sic_Code				:= CHOOSE(C,L.company_sic_code1,L.company_sic_code2,L.company_sic_code3,L.company_sic_code4,L.company_sic_code5)[1..4];
		Naics_Code 			:= CHOOSE(C,L.company_naics_code1,L.company_naics_code2,L.company_naics_code3,L.company_naics_code4,L.company_naics_code5)[1..6];
		SELF.Sic_Code 	:= Sic_Code;
		SELF.Naics_Code := Naics_Code;
		SELF.Best_Code	:=  MAP ((INTEGER)Sic_Code > 0 => Sic_Code,
															(INTEGER)Sic_Code = 0 AND (INTEGER)Naics_Code >0 => Naics_Code,
															'');
		SELF 						:= L;
	END;
	
	ds_BIPSICNAICSRecs := NORMALIZE(ds_busHeaderRecsSlim,5,trans(LEFT,COUNTER));
	
	Recs := IF(buzCreditAccess ,ds_BIPSICNAICSRecs + ds_SicNaicsRecsToUse, ds_BIPSICNAICSRecs);
	
	slim_layout rollSICNAICSource(slim_layout L, slim_layout R) := TRANSFORM
		SELF.dt_first_seen	:=	ut.min2((INTEGER)L.dt_first_seen ,(INTEGER)R.dt_first_seen);
		SELF.dt_last_seen		:=	ut.max2((INTEGER)L.dt_last_seen, (INTEGER)R.dt_last_seen);
		SELF.RecordCount		:=	L.RecordCount + 1;
		SELF								:=	L;
	END;

	recs_rollup := ROLLUP(SORT(Recs((INTEGER)Best_Code > 0 AND Source <> ''), #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), Source, best_code),
												BIPV2.IDmacros.mac_JoinTop3Linkids() AND LEFT.Best_Code = RIGHT.Best_Code, rollSICNAICSource(LEFT, RIGHT));
	
	EXPORT recs_rollup_sort := SORT(recs_rollup, 
																		#expand(BIPV2.IDmacros.mac_ListTop3Linkids()), 
																		-(Source = MDR.sourceTools.str_convert_DL), 
																		-(Source = MDR.sourceTools.src_EBR), 
																		-(Source = MDR.sourceTools.src_Yellow_Pages), 
																		-(Source = MDR.sourceTools.src_OSHAIR), 
																		-(Source = MDR.sourceTools.src_Business_Registration), 
																		-(Source = MDR.sourceTools.src_FBNV2_BusReg), 
																		-(Source = MDR.sourceTools.src_Calbus), 
																		-(Source = MDR.sourceTools.src_Dunn_Bradstreet_Fein), 
																		-dt_last_seen, 
																		-dt_first_seen, 
																		RecordCount,
																		RECORD);
	
	EXPORT bestIndustryCode := DEDUP(recs_rollup_sort,#expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
	// output(ds_SicNaicsRecsToUse, named('ds_SicNaicsRecsToUse'));
	// output(ds_busHeaderRecsSlim, named('ds_busHeaderRecsSlim'));
	// output(ds_BIPSICNAICSRecs, named('ds_BIPSICNAICSRecs'));
	
  //return (recs_rollup_sort);
END;