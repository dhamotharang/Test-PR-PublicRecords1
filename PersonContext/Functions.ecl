IMPORT _Control, ut, iesp, Insurance_iesp, InsuranceContext_iesp, 
			InsuranceLog_iesp,iesp.Constants, PersonContext, FCRA;
onThor := _Control.Environment.OnThor;

EXPORT FUNCTIONS := MODULE

  EXPORT CM := PersonContext.Constants.Messages;
  EXPORT CS := PersonContext.Constants.StatusCodes;  
	EXPORT CN := PersonContext.Constants;
  EXPORT RT := CN.RecordTypes;
  EXPORT ET := CN.EventTypes;
	EXPORT PCL := PersonContext.Layouts;

  EXPORT ValidateSearchKeys(PCL.Layout_PCRequest rowPCReq) := MODULE
    
		//spin through the search key records and mark a search status error on those which fail scrutiny.
		//Also, get them out of the insurance_iesp child dataset structure and make it a simpler dataset structure that we can use outside.
		PCL.Layout_PCRequestStatus ValidateKeys(PCL.Layout_PCSearchKey L) := TRANSFORM			
      SELF.SearchStatus			:= MAP(L.LexID != '' AND (L.RecID1 != '' OR L.RecID2 != '' OR L.RecID3 != '' OR L.RecID4 != '')
			                                                                                                  => CS.LexidRecidCombinationError,
			                             L.LexID = '' AND L.RecId1 = '' AND L.RecId2 = '' AND L.RecId3 = '' AND L.RecId4 = '' 
																																																				=> CS.NoSearchRecords,
			                             L.RecId2 != '' AND L.RecId1 = '' 																			=> CS.RecIDOutOfSequence,
																	 L.RecId3 != '' AND (L.RecId2 = '' OR L.RecId1 = '') 									=> CS.RecIDOutOfSequence,
																	 L.RecID4 != '' AND (L.RecId3 = '' OR L.RecId2 = '' OR L.RecId3 = '') 	=> CS.RecIDOutOfSequence,
																	 '');
			SELF := L;
		END;
		
		 // now we have a dataset of search keys that have been validated.
		//EXPORT dsPCReqValidated := PROJECT(dsPCReq[1].SearchBy.Keys, ValidateKeys(LEFT));
		EXPORT dsPCReqValidated := PROJECT(rowPCReq.Searchby.Keys, ValidateKeys(LEFT));

    // if we can't find any search records with at least a LexID or RecID1 populated then we have an empty search dataset. 
    EXPORT isEmptySearchds := ~EXISTS(rowPCReq.SearchBy.Keys(LexID > '' OR RecID1 > ''));	

    // After passing validation transform, do we have any valid search keys? Valid ones are the ones that weren't assigned a SearchStatus error.
		EXPORT isNoValidSearchKeys := ~EXISTS(dsPCReqValidated(SearchStatus = ''));

    //now, export a dataset of only the search keys that didn't generate an error status. These will be the ones we will send through the
		//soap service to the deltabase and to the roxie keys for the joins.
		EXPORT dsPCValidSearchRecs := dsPCReqValidated(SearchStatus = '');
	END; // ValidateSearchKeys

  EXPORT ValidateSearchKeys_Thor(DATASET(PersonContext.Layouts.Layout_PCSearchKey) ThorInputs) := MODULE
    
		//spin through the search key records and mark a search status error on those which fail scrutiny.
		//Also, get them out of the insurance_iesp child dataset structure and make it a simpler dataset structure that we can use outside.
		PCL.Layout_PCRequestStatus ValidateKeys(PersonContext.Layouts.Layout_PCSearchKey L) := TRANSFORM			
      SELF.SearchStatus			:= MAP(L.LexID != '' AND (L.RecID1 != '' OR L.RecID2 != '' OR L.RecID3 != '' OR L.RecID4 != '')
			                                                                                                  => CS.LexidRecidCombinationError,
			                             L.LexID = '' AND L.RecId1 = '' AND L.RecId2 = '' AND L.RecId3 = '' AND L.RecId4 = '' 
																																																				=> CS.NoSearchRecords,
			                             L.RecId2 != '' AND L.RecId1 = '' 																			=> CS.RecIDOutOfSequence,
																	 L.RecId3 != '' AND (L.RecId2 = '' OR L.RecId1 = '') 									=> CS.RecIDOutOfSequence,
																	 L.RecID4 != '' AND (L.RecId3 = '' OR L.RecId2 = '' OR L.RecId3 = '') 	=> CS.RecIDOutOfSequence,
																	 '');
			SELF := L;
		END;
		
		 // now we have a dataset of search keys that have been validated.
		//EXPORT dsPCReqValidated := PROJECT(dsPCReq[1].SearchBy.Keys, ValidateKeys(LEFT));
		EXPORT dsPCReqValidated := PROJECT(ThorInputs, ValidateKeys(LEFT));

    // if we can't find any search records with at least a LexID or RecID1 populated then we have an empty search dataset. 
    EXPORT isEmptySearchds := ~EXISTS(ThorInputs(LexID > '' OR RecID1 > ''));	

    // After passing validation transform, do we have any valid search keys? Valid ones are the ones that weren't assigned a SearchStatus error.
		EXPORT isNoValidSearchKeys := ~EXISTS(dsPCReqValidated(SearchStatus = ''));

    //now, export a dataset of only the search keys that didn't generate an error status. These will be the ones we will send through the
		//soap service to the deltabase and to the roxie keys for the joins.
		EXPORT dsPCValidSearchRecs := dsPCReqValidated(SearchStatus = '');
	END; // ValidateSearchKeys
	
	EXPORT PerformDeltabaseCall(DATASET(PCL.Layout_PCRequestStatus) dsPCValidSearchRecs,
	                            BOOLEAN isEmptySearchDs = FALSE,
															STRING URL) := FUNCTION

    // the following transforms puts the valid search records back into the ESP interface necessary to perform soapcall to deltabase
    PCL.Layout_PCRequest LoadRequest() := TRANSFORM
			PCL.Layout_PCSearchKey LoadSoapKeys(dsPCValidSearchRecs dsIn) := TRANSFORM
				SELF.LexID 	:= dsIn.LexID;
				SELF.RecID1 := dsIn.RecId1;
				SELF.RecID2 := dsIn.RecId2;
				SELF.RecID3 := dsIn.RecId3;
				SELF.RecID4 := dsIn.RecID4;
			end;
			SELF.SearchBy.Keys := PROJECT(dsPCValidSearchRecs, LoadSoapKeys(LEFT));
			SELF.DeltabaseURL := '';
		END;
		dsPCReq := DATASET([loadRequest()]);

    //map out the failcode and message to the response if we have a failure in the soapcall. As of now, we aren't expecting the 
		//products to do anything with a soapcall failure because we don't want the products to fail their transactions if PersonContext
		//deltabase is unavailable for a short period of time. However, I will trap the error in the case that we do want to use it for
		//some purpose in the future. Keep in mind, even though the deltabase may not be available the keys still contain data that PersonContext
		//can return regardless.
		PCL.Layout_Soapcall_Response failx(dsPCReq L) := TRANSFORM
			SELF.response._Header.Status  := FAILCODE;
			SELF.response._Header.Message := FAILMESSAGE('soapresponse');
			SELF := L;
			SELF := [];
		END;

		dsSoapOut := SOAPCALL(dsPCReq,
													URL,
													CM.ESP_Method, 
													PCL.Layout_PCRequest,
													TRANSFORM(PCL.Layout_PCRequest, SELF := LEFT),
													DATASET(PCL.Layout_Soapcall_Response),
													xpath(CM.ResultStructure),
													onfail(failx(left)), 
													RETRY(0), 
													TIMELIMIT(4),
													trim);

     dsPCDB := IF(URL<>'', dsSoapOut[1].response.Records);
		
		RETURN dsPCDB;
    
  END;//PerformDeltabaseCall
  
	EXPORT PerformGetRoxieKeyData(DATASET(PCL.Layout_PCRequestStatus) dsPCValidSearchRecs) := FUNCTION
		
		dsSearchLexID := dsPCValidSearchRecs(LexID > ''); //filter out from the search dataset all search records that do not have LexID.
		dsSearchRecID := dsPCValidSearchRecs(RecID1 > ''); //filter out all from the search dataset all search records that don't have at least RecID1
		
		//perform a join only on LexID key to get all matches that match the search LexID. This join will grab all Consumer Level and Record level records.
		dsResultLexID_roxie := JOIN(dsSearchLexID, PersonContext.Keys.KEY_LexID,
		                      KEYED(LEFT.LexID = RIGHT.LexID),
										      TRANSFORM(PersonContext.Layouts.layout_deltakey_personcontext,SELF:=RIGHT,SELF:=[]),
                          KEEP(iesp.Constants.PersonContext.MAX_RECORDS),LIMIT(0));

		dsResultLexID_thor := JOIN(DISTRIBUTE(dsSearchLexID, HASH64(LexID)), 
													DISTRIBUTE(PULL(PersonContext.Keys.KEY_LexID), HASH64(LexID)),
		                      (LEFT.LexID = RIGHT.LexID),
										      TRANSFORM(PersonContext.Layouts.layout_deltakey_personcontext,SELF:=RIGHT,SELF:=[]),
                          KEEP(iesp.Constants.PersonContext.MAX_RECORDS),LIMIT(0), LOCAL);
			
		#IF(onThor)
      dsResultLexID := dsResultLexID_thor;
    #ELSE
      dsResultLexID := dsResultLexID_roxie;
    #END
    
    //perform a join on RecID1 - RecID4 to get all matches that match on the search key RecID1 - 4.
		//This key is needed to find all record level matching on RecID1 - 4 searches when we don't know the LexID
		//they belong too.
		dsResultRecID_roxie := JOIN(dsSearchRecID, PersonContext.Keys.KEY_RecID,
													KEYED(LEFT.RecID1 = RIGHT.RecID1 AND
																LEFT.RecID2 = RIGHT.RecID2 AND
																LEFT.RecID3 = RIGHT.RecID3 AND
																LEFT.RecID4 = RIGHT.RecID4),
													TRANSFORM(PersonContext.Layouts.layout_deltakey_personcontext,SELF:=RIGHT,SELF:=[]),
													KEEP(iesp.Constants.PersonContext.MAX_RECORDS),LIMIT(0));
													
		dsResultRecID_thor := JOIN(DISTRIBUTE(dsSearchRecID, HASH64(RecID1, RecID2, RecID3, RecID4)), 
													DISTRIBUTE(PULL(PersonContext.Keys.KEY_RecID), HASH64(RecID1, RecID2, RecID3, RecID4)),
																LEFT.RecID1 = RIGHT.RecID1 AND
																LEFT.RecID2 = RIGHT.RecID2 AND
																LEFT.RecID3 = RIGHT.RecID3 AND
																LEFT.RecID4 = RIGHT.RecID4,
													TRANSFORM(PersonContext.Layouts.layout_deltakey_personcontext,SELF:=RIGHT,SELF:=[]),
													KEEP(iesp.Constants.PersonContext.MAX_RECORDS),LIMIT(0), LOCAL);
		
		#IF(onThor)
      dsResultRecID := dsResultRecID_thor;
    #ELSE
      dsResultRecID := dsResultRecID_roxie;
    #END

    //combine the results from the two joins and then sort and dedup on the key fields. 
		//We will have duplicates in the two joins we need to get rid of.
    dsSrtRoxieKeyRecs := SORT(dsResultLexID + dsResultRecID,LexID,RecID1,RecID2,RecID3,RecID4,StatementId);
    dsDDRoxieKeyRecs  := DEDUP(dsSrtRoxieKeyRecs,LexID,RecID1,RecID2,RecID3,RecID4,StatementId);

    //put the results in the response rec layout to make it a common structure with the other searches.
    PCL.Layout_PCResponseRec ReFormat(dsDDRoxieKeyRecs RK) := TRANSFORM
			SELF.LexID        := TRIM(RK.LexID,LEFT,RIGHT);
			SELF.RecID1       := TRIM(RK.RecID1,LEFT,RIGHT);
			SELF.RecID2       := TRIM(RK.RecID2,LEFT,RIGHT);
			SELF.RecID3       := TRIM(RK.RecID3,LEFT,RIGHT);
			SELF.RecID4       := TRIM(RK.RecID4,LEFT,RIGHT);
			SELF.Content			:= TRIM(RK.Content,LEFT,RIGHT);
			SELF.SearchStatus := '';
 			SELF 							:= RK;
		END;
    dsRoxieKeyFinal := PROJECT(dsDDRoxieKeyRecs, ReFormat(LEFT)); 
		RETURN dsRoxieKeyFinal;
	END;// PerformGetRoxieKeyData

  EXPORT PerformGetPCR( DATASET(PCL.Layout_PCRequestStatus) dsPCValidSearchRecs) := FUNCTION
     
    dsSearchLexID := dsPCValidSearchRecs((unsigned)LexID > 0); //filter out from the search dataset all search records that do not have LexID.

    PCL.Layout_PCResponseRec map_pcr_fields(PCL.Layout_PCRequestStatus le, FCRA.Key_Override_PCR_DID rt, string recordType) := transform
      self.LexID := (string)rt.s_did;
      self.RecID1 := '';
      self.DataGroup := PersonContext.Constants.DataGroups.PERSON;
      self.RecordType := recordType;
			self.Content := if(recordtype=PersonContext.Constants.RecordTypes.SF, PersonContext.Constants.security_freeze_codes, '');  
      date_created := rt.date_created;
      self.DateAdded := date_created[1..4] + '-' + date_created[5..6] + '-' + date_created[7..8] + ' 00:00:00';
      self.SourceSystem := 'PCR';  // I'd rather have this say PCR instead of DOST for these initial records since DOST system is going away
      self.EventType := 'ADD';
      SELF  := rt,
      SELF  := [];
    end;
    
    // first search the PCR key to get all records for a DID, transforming into the layout of the key
		pcr_results_roxie := JOIN(dsSearchLexID, FCRA.Key_Override_PCR_DID,
		                      KEYED((unsigned)LEFT.LexID = RIGHT.s_did) and
                          (unsigned)right.date_created<>0 and  // don't allow records that don't have date created populated
                            ((unsigned)right.security_freeze=1 or (unsigned)right.security_alert=1 or (unsigned)right.id_theft_flag=1),  // we only care about the records for these 3 types
										      transform(recordof(FCRA.Key_Override_PCR_DID), self := right),
                          KEEP(iesp.Constants.PersonContext.MAX_RECORDS),atmost(iesp.Constants.PersonContext.MAX_RECORDS));

		pcr_results_thor := JOIN(DISTRIBUTE(dsSearchLexID, HASH64((unsigned)LexID)), 
													DISTRIBUTE(PULL(FCRA.Key_Override_PCR_DID), HASH64(s_did)),
		                      ((unsigned)LEFT.LexID = RIGHT.s_did) and
                          (unsigned)right.date_created<>0 and  // don't allow records that don't have date created populated
                            ((unsigned)right.security_freeze=1 or (unsigned)right.security_alert=1 or (unsigned)right.id_theft_flag=1),  // we only care about the records for these 3 types
										      transform(recordof(FCRA.Key_Override_PCR_DID), self := right),
                          KEEP(iesp.Constants.PersonContext.MAX_RECORDS),atmost(iesp.Constants.PersonContext.MAX_RECORDS), LOCAL);
    
    #IF(onThor)
      pcr_results := pcr_results_thor;
    #ELSE
      pcr_results := pcr_results_roxie;
    #END
    
    // after we have all of those records in memory, join dsSearchLexID to those results...
    // ... once for each different record type so that if a person has security freeze and id theft alert, they will get 2 records instead of just 1                     
		security_freezes := JOIN(dsSearchLexID, pcr_results,
		                      (unsigned)LEFT.LexID = RIGHT.s_did and (unsigned)right.security_freeze=1,  // we only care about security freezes on this join
										      map_pcr_fields(left, right, PersonContext.Constants.RecordTypes.SF));
		
    security_alerts := JOIN(dsSearchLexID, pcr_results,
		                      (unsigned)LEFT.LexID = RIGHT.s_did and (unsigned)right.security_alert=1,  // we only care about the security alerts on this join
										      map_pcr_fields(left, right, PersonContext.Constants.RecordTypes.FA));
                          
    id_thefts := JOIN(dsSearchLexID, pcr_results,
		                      (unsigned)LEFT.LexID = RIGHT.s_did and (unsigned)right.id_theft_flag=1,  // we only care about the id_thefts on this join
										      map_pcr_fields(left, right, PersonContext.Constants.RecordTypes.IT));
                          
		dsResultLexID := security_freezes + security_alerts + id_thefts;
    
    RETURN dsResultLexID;
  END;
  
	EXPORT PerformCombineDatasets(DATASET(PCL.Layout_PCRequestStatus) SK,  					//SK = Search Keys
	                              DATASET(PCL.Layout_PCResponseRec) DB, 						//DB = Deltabase Results
	                              DATASET(PCL.Layout_PCResponseRec) RK) := MODULE  	// RK= Roxie Keys Results

    //Get the search key records that had some issue and put search keys records in the common internal layout. These "bad" search records
		//will be returned in the result set with their SearchStatus code.
		EXPORT SKErrors := PROJECT(SK(SearchStatus > ''), TRANSFORM(RECORDOF(DB),SELF:=LEFT,SELF:=[]));

    //perform a whole record dedup after combining the Deltabase (DB) results and the Roxie Key (RK) results. We may have picked up duplicates.
    dsDedupAll := DEDUP(DB + RK,RECORD,ALL);
		
		//throw out all records which are forward dated. Forward dated records can come from deltabase in realtime so we have to deal with them at runtime.
		//future dated records don't exist in the Roxie Keys but do in the base file they are built from. Those future dated records are not built into the keys.
		SHARED dsRemoveFutureRecs := dsDedupAll(DateAdded < CN.GetDateTimeGMT);
 
    //delete all Consumer level records Marked for logical Deletion which match the key fields, datagroup and statementID. For other non statement
		//consumer level records, like flags attached to the consumer, the statementid should be zero
    SHARED dsCLOnlyProcessDeletes := JOIN(dsRemoveFutureRecs(RecordType IN RT.ConsumerLevel AND EventType = ET.DEL), dsRemoveFutureRecs(RecordType IN RT.ConsumerLevel AND EventType <> ET.DEL),  
																				LEFT.LexID = RIGHT.LexID AND
																				LEFT.RecID1 = RIGHT.RecID1 AND
																				LEFT.RecID2 = RIGHT.RecID2 AND
																				LEFT.RecID3 = RIGHT.RecID3 AND
																				LEFT.RecID4 = RIGHT.RecID4 AND
																				LEFT.DataGroup = RIGHT.DataGroup AND
																				LEFT.RecordType = RIGHT.RecordType AND
																				LEFT.StatementID = RIGHT.StatementID AND
																				LEFT.DateAdded > RIGHT.DateAdded,
																				TRANSFORM(RIGHT), RIGHT ONLY);
    
		SHARED dsRLOnlyProcessDeletes := JOIN(dsRemoveFutureRecs(RecordType IN RT.RecordLevel AND EventType = ET.DEL), dsRemoveFutureRecs(RecordType IN RT.RecordLevel AND EventType <> ET.DEL),  
																				LEFT.LexID = RIGHT.LexID AND
																				LEFT.RecID1 = RIGHT.RecID1 AND
																				LEFT.RecID2 = RIGHT.RecID2 AND
																				LEFT.RecID3 = RIGHT.RecID3 AND
																				LEFT.RecID4 = RIGHT.RecID4 AND
																				LEFT.DataGroup = RIGHT.DataGroup AND
																				LEFT.RecordType = RIGHT.RecordType AND
																				LEFT.DateAdded > RIGHT.DateAdded,
																				TRANSFORM(RIGHT), RIGHT ONLY);
		 
    //filter for Consumer Level (CL) records, sort them by index fields with the highest CD_ID field at the top.
		//Group them by the key fields so we can pick off the one record in the group we want using the TOPN function.
		dsCLSrt := SORT(dsCLOnlyProcessDeletes(RecordType IN RT.ConsumerLevel),LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType,StatementID,-DateAdded);
    dsCLGrp := GROUP(dsCLSrt,LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType,StatementID);
    SHARED dsCLPick := TOPN(dsCLGrp,1,LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType,StatementID);

    //filter for Record Level (RL) records, sort them by index fields with the highest CD_ID field at the top.
		//Group them by the key fields so we can pick off the one record in the group we want using the TOPN function.
		dsRLSrt := SORT(dsRLOnlyProcessDeletes(RecordType IN RT.RecordLevel),LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType,-DateAdded);
		dsRLGrp := GROUP(dsRLSrt,LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType);
		SHARED dsRLPick := TOPN(dsRLGrp,1,LexID,RecID1,RecID2,RecID3,RecID4,DataGroup,RecordType);

    //combine results, transform and put a results found SearchStatus on these records.
		SHARED dsCombine :=PROJECT(dsCLPick + dsRLPick,TRANSFORM(PCL.Layout_PCResponseRec,SELF.SearchStatus := CS.ResultsFound,SELF:=LEFT,SELF:=[]));

//  records in SK were assigned a status code if they had an error. So I only want those that didn't have errors go through the following code.
//  these records would have been eligible for a search. Now, I have to look at all those that were eligible, and are consumer level (had a
//  lexid populated) and those that were record level searches (didn't have lexid populated but did have Rec1,2,3 or 4 populated). The records
//  in the search keys (SK) matching the conditions in the join would have no retults found so I want to mark their record level status as such.											
		SKCLNotFounds := JOIN(SK(SearchStatus = '' AND Lexid > ''),dsCombine,
		                    LEFT.LexID = RIGHT.LexID,
												TRANSFORM(RECORDOF(DB),SELF.SearchStatus := CS.NoResultsFound,SELF:=LEFT,SELF:=[]),
												LEFT ONLY, ALL);
												
		SKRLNotFounds := JOIN(SK(SearchStatus = '' AND RecID1 > ''),dsRLPick,
												LEFT.RecID1 = RIGHT.RecID1 AND
												LEFT.RecID2 = RIGHT.RecID2 AND
												LEFT.RecID3 = RIGHT.RecID3 AND
												LEFT.RecID4 = RIGHT.RecID4,
												TRANSFORM(RECORDOF(DB),SELF.SearchStatus := CS.NoResultsFound,SELF:=LEFT,SELF:=[]),
												LEFT ONLY, ALL);
		
		//combine the results of the previous two joins.
		SKNotFounds := SKCLNotFounds + SKRLNotFounds;                    

    //Combine the SKErrors, SKNotFounds and the dsCombined results and sort the file into the proper sequence. This basically combines everything back together.												
    EXPORT dsResults := SORT(SKErrors + SKNotFounds + dsCombine,LexID,RecID1,RecID2,RecID3,RecID4,StatementID,-StatementSequence);

    //set a boolean that we actually had returned results from the searches.
    EXPORT isWeFoundResults := EXISTS(dsCombine);

	END;//PerformCombineDatasets

  EXPORT PerformCreateFinalOutput(DATASET(PCL.Layout_PCResponseRec) Results,
	                                BOOLEAN isEmptySearchDS = FALSE,
																	BOOLEAN isNoValidSearchKeys = FALSE,
																	BOOLEAN isWeFoundResults = FALSE
																	) := FUNCTION
																	
    //This is the General Header search statuses that are available.
    QueryStatus := MAP(isNoValidSearchKeys => (INTEGER) CS.NoSearchRecords,  
		                   isEmptySearchDS => (INTEGER) CS.NoSearchRecords,
											 isWeFoundResults => (INTEGER) CS.ResultsFound,
											 (INTEGER) CS.NoResultsFound);
		
		//This is the General Header search status messages that are available.
		QueryMessage := MAP(isNoValidSearchKeys OR isEmptySearchDS => CM.NoSearchRecordsMsg,  
												isWeFoundResults => CM.ResultsFoundMsg,
												CM.NoResultsFoundMsg);

    //now, lets take our results and put them back into the overall final response structure that gets returned from the function or Roxie Service.
    PCL.Layout_PCResponse LoadFinalResponse() := TRANSFORM
       SELF._Header.Status := QueryStatus;
       SELF._Header.Message := QueryMessage;
       PCL.Layout_PCResponseRec LoadChildRecs(Results R) := TRANSFORM
         SELF.Content := TRIM(R.Content,LEFT,RIGHT);         
				 SELF := R;
			 END;
			 SELF.records := PROJECT(Results, LoadChildRecs(LEFT));
			 SELF := [];		
		END;
		dsFinalResponse := DATASET([LoadFinalResponse()]);
		RETURN dsFinalResponse;
		
	END;   //PerformCreateFinalOutput

  EXPORT PerformCreateFinalOutput_thor(DATASET(PCL.Layout_PCResponseRec) Results) := FUNCTION
																	
    //now, lets take our results and put them back into the overall final response structure that gets returned from the function or Roxie Service.
       PCL.Layout_PCResponseRec LoadFinalResponse(Results R) := TRANSFORM
         SELF.Content := TRIM(R.Content,LEFT,RIGHT);         
				 SELF := R;
				END; 
				 
		dsFinalResponse := PROJECT(Results, LoadFinalResponse(LEFT));
		RETURN dsFinalResponse;
		
	END;   //PerformCreateFinalOutput_thor
	
END; // FUNCTIONS  