import ut, LN_PropertyV2,  govdata, mdr;

export BH_Relative_Match_LP(

	 DATASET(Layout_Business_Header_Temp				) pBH												= BH_Basic_Match_ForRels()
	,DATASET(LN_PropertyV2.Layout_DID_Out		    ) pLP												= LN_PropertyV2.File_Search_DID
	,string																				pPersistname							= persistnames().BHRelativeMatchLP													
	,boolean																			pShouldRecalculatePersist	= true													

) :=
FUNCTION

Layout_LP_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring34 vendor_id;
end;


Layout_LP_Match InitLPMatch(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;


BHLP_Init := project(pBH(MDR.sourceTools.SourceIsLnPropertyV2(source)), InitLPMatch(left));
BHLP_Init_Dedup := dedup(BHLP_Init, all);


//Create a "virtual" vendor_id in order to join LP_party recordset
//with Business Header Recordset

tLP := table(pLP,{ qstring34 vendor_id := source_code[1..2] +  
                                          vendor_source_flag +
										  ln_fares_id[1..12],
				   ln_fares_id,
				   src_cd := source_code[1..1]});

tlp_dedup := dedup(tlp, all);

//Make Business Header records
//"aware" of case number and name type
//of related Ln PropertyV2 records
Layout_BH_Temp := RECORD
  Layout_LP_Match;
  LN_PropertyV2.Layout_DID_Out.ln_fares_id;
  LN_PropertyV2.Layout_DID_Out.source_code;
END;
			
	
r := JOIN(DISTRIBUTE(BHLP_Init_Dedup,RANDOM()),
          tlp_dedup,
          trim(LEFT.vendor_id) = trim(RIGHT.vendor_id),
		  TRANSFORM(Layout_BH_Temp,SELF.ln_fares_id  := RIGHT.ln_fares_id;
		                           SELF.source_code := RIGHT.src_cd;
							       SELF := LEFT;),HASH);



//Get business relatives by reviewing vendor ids and source_codes
LP_Matches := JOIN( DISTRIBUTE(r,HASH32(ln_fares_id)),
                    DISTRIBUTE(r,HASH32(ln_fares_id)),
		            TRIM(LEFT.ln_fares_id) = TRIM(RIGHT.ln_fares_id) AND
		            TRIM(LEFT.source_code) = TRIM(RIGHT.source_code) AND
		            LEFT.bdid > RIGHT.bdid
		           ,TRANSFORM(Business_Header.Layout_Relative_Match,
		                      self.bdid1 := LEFT.bdid;
                              self.bdid2 := RIGHT.bdid;
                              self.match_type := 'LP';),LOCAL);



LP_Matches_Dedup :=  SORT(DEDUP(LP_Matches, bdid1, bdid2, all),bdid1) : persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, LP_Matches_Dedup
																										, persists().BHRelativeMatchLP
									);
return returndataset;
 
END; 
