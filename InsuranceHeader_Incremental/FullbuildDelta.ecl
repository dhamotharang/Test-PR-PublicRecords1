IMPORT InsuranceHeader_xLink,SALT37; 

EXPORT FullbuildDelta (DATASET(Layout_Header_Incremental) dsCorrections, DATASET(Layout_Header_Incremental) dsNew , STRING versionIn ) := MODULE

   NewOnlyAndCorrections      := dsNew + dsCorrections ; 
   NewOnlyAndCorrectionsDedup := DEDUP(SORT(NewOnlyAndCorrections, RID, -buildDateTimeStamp),RID);
	 
	 Key := InsuranceHeader_xLink.Process_xIDL_Layouts().key; 
 
  // New Full Super Key 
   KeyPayloadNewFull := INDEX(Key,InsuranceHeader_xLink.KeyNames('FULL').header_super);
   JNew := JOIN ( KeyPayloadNewFull , NewOnlyAndCorrections , LEFT.RID = RIGHT.RID AND LEFT.DID <> RIGHT.DID , TRANSFORM (LEFT), HASH); 
 
 // Existing payload QA Key 
 
   JExisting := JOIN ( Key , JNew , LEFT.rid = RIGHT.rid , TRANSFORM (LEFT), LOOKUP); 														
   SHARED differences := InsuranceHeader_xLink.Process_xIDL_Layouts().FullBuildDelta( JExisting , JNew ); 
	 
	 // patch ssn from full base because UT/ZT ssn's are blanked out in payload key W20171120-012832
	 SHARED differences_ut := JOIN( InsuranceHeader_Incremental.Files.dsBase , differences(src in ['ADLUT','ADLZT']), 
	                          LEFT.RID = RIGHT.RID , 
	                          TRANSFORM ( RECORDOF (differences), SELF.ssn := LEFT.ssn,SELF:= RIGHT), RIGHT OUTER,HASH) + differences(src not in ['ADLUT','ADLZT']);
														
  // New delta File should be added to as header all 
EXPORT Asheader  := PROJECT ( differences_ut , TRANSFORM ( {Layout_Header_Plus}, 
                                    SELF := LEFT , 
																		SELF.RecChangeType := 5 ,
                                     )); 
	
	DateTimeStamp := CurrentDateTimeStamp : INDEPENDENT;
	
  // New Inc Base - use this base create a fullbuilddelta keys 
EXPORT Incbase := PROJECT ( differences_ut , TRANSFORM ( {InsuranceHeader_Incremental.Layout_Header_Incremental}, 
                                    SELF := LEFT ,
																		SELF.RecChangeType := 5 ,
																		SELF.buildDateTimeStamp := DateTimeStamp )); 
																		
END; 