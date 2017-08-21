import ut, LiensV2,  govdata,mdr;

export BH_Relative_Match_L2(

	 DATASET(Layout_Business_Header_Temp		) pBH												= BH_Basic_Match_ForRels()
	,DATASET(liensv2.Layout_liens_party_ssn_BIPV2	) pLV2								= LiensV2.file_Liens_party_BIPV2
	,string																		pPersistname							= persistnames().BHRelativeMatchL2													
	,boolean																	pShouldRecalculatePersist	= true													

) := FUNCTION

Layout_L2_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring34 vendor_id;
end;


Layout_L2_Match InitL2Match(Business_Header.Layout_Business_Header_Temp L) := transform
self := L;
end;


BHL2_Init := project(pBH(MDR.sourceTools.SourceIsLiens(source)), InitL2Match(left));
BHL2_Init_Dedup := dedup(BHL2_Init, all);


//Create a "virtual" vendor_id in order to join L2_party recordset
//with Business Header Recordset
tLV2 := table(pLV2,{ qstring34 vendor_id := if(tax_id <> '',(trim(tmsid[1..2]) + 
                                            trim(cname,left,right) + 
                                            st + tax_id)
                                          ,(trim(tmsid[1..2]) + 
                                            trim(cname,left,right) +
                                            st + prim_name + p_city_name)),
                tmsid,name_type});


tlv2_dedup := dedup(tlv2, all);

//Make Business Header records
//"aware" of case number and name type
//of related LiensV2 records
Layout_BH_Temp := RECORD
  Layout_L2_Match;
  liensv2.Layout_liens_party_SSN.tmsid;
  liensv2.Layout_liens_party_SSN.name_type;
END;
			
	
r := JOIN(DISTRIBUTE(BHL2_Init_Dedup,random()),
          tlv2_dedup,
          trim(LEFT.vendor_id) = trim(RIGHT.vendor_id),
		  TRANSFORM(Layout_BH_Temp,SELF.tmsid  := RIGHT.tmsid;
		                           SELF.name_type := RIGHT.name_type;
							       SELF := LEFT;),atmost(trim(LEFT.vendor_id) = trim(RIGHT.vendor_id),500),HASH);



//Get business relatives by reviewing vendor ids and name_types
L2_Matches := JOIN( DISTRIBUTE(r,HASH32(tmsid)),
                    DISTRIBUTE(r,HASH32(tmsid)),
		            TRIM(LEFT.tmsid) = TRIM(RIGHT.tmsid) AND
		            TRIM(LEFT.name_type) = TRIM(RIGHT.name_type) AND
		            LEFT.bdid > RIGHT.bdid
		           ,TRANSFORM(Business_Header.Layout_Relative_Match,
		                      self.bdid1 := LEFT.bdid;
                              self.bdid2 := RIGHT.bdid;
                              self.match_type := 'L2';),LOCAL);



L2_Matches_Dedup :=  DEDUP(L2_Matches, bdid1, bdid2, all) : persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, L2_Matches_Dedup
																										, persists().BHRelativeMatchL2
									);
return returndataset;
 
END; 
	
	