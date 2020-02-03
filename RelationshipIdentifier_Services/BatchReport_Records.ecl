import RelationshipIdentifier_Services,  doxie_crs, doxie_raw,
doxie, Batchshare, ut, iesp, bipv2, TopBusiness_Services, 
Relationship, header, BIPV2_Best, Suppress, STD;

EXPORT BatchReport_Records(  
	dataset( RelationshipIdentifier_Services.Layouts.Batch.intermediateLayoutExt) ds_batchReportInRecs,
	RelationshipIdentifier_Services.iParam.BatchParams inMod
	) := FUNCTION
	
	DRM := InMod.DataRestrictionMask;
	dppa_ok := inMod.isValidDppa();
  glb_ok := inMod.isValidGlb();
  
	integer CurDate := STD.Date.today();
	unsigned4 endDateTmp := (unsigned4) inMod.EndDate;	
	unsigned4 endDate := if (endDateTmp = 0, (unsigned4) curDate, endDateTmp);
		  	
	didsSequenced := PROJECT(ds_batchReportInRecs, TRANSFORM({ 
																											string20 acctno;
	                                                    unsigned2 seqnum;
	                                                    doxie.layout_references;},
	                                   
																			self.acctno := left.orig_acctno;
																			SELF.seqnum := LEFT.seqnum;
	                                    SELF.did := LEFT.DID,
																			));	  																		
  //		
  // DO NEIGHBOR SETUP AND RESULTS RETRIEVAL
	//
  neighborsbaseline := PROJECT(didsSequenced, TRANSFORM(doxie.layout_references, 
	     SELF.did := LEFT.DID));
	
	neighbor_results := doxie_crs.NeighBorRecords(neighborsbaseline,
	                                     inMod.dppa, 
																			 inMod.glb,
																			 inmod.DataRestrictionMask,
																			 inMod.ssn_mask);
		
	neighborsWithAcctno := JOIN(didsSequenced, Neighbor_results,
	                             LEFT.DID = RIGHT.base_did,
															 TRANSFORM({string20 acctno; 
															 unsigned2 seqnum; string20 orig_acctno;
															            Batchshare.Layouts.ShareErrors;
															               RECORDOF(RIGHT);},
															 SELF.acctno := LEFT.acctno;
															 // ^^^ this is orginal acctno;
															 self.orig_acctno := LEFT.acctno;															 
															 SELF.seqnum := LEFT.seqnum;																												 
															 SELF := RIGHT,
															 SELF := []));
															 	 
   NumMonthsBack := (unsigned4) (ut.getDateOffset(RelationshipIdentifier_Services.Constants.MonthsBack)[1..6]);
	 // use this later
	 //
   tmpds_neighborResultsSlim := 	Sort(neighborsWithAcctno(Mode = 'C' and dt_last_seen >= NumMonthsBack),SeqNum);
	                                                                       // ^^^^^^^^^^ this is in YYYYMM format
	 ds_neighborResultsSlimWithAcctno := if (inmod.IncludeNeighbor, tmpds_neighborResultsSlim);
	 // setup and retrieve Contact and Relationship INFORMATION
	 
	 ds_input_linkdsForBIPDataWOrigAcctno := PROJECT(ds_batchReportInRecs, TRANSFORM(
	 {string20 orig_acctno; unsigned2 seqNum; bipv2.IDlayouts.l_xlink_ids;},
	   self.orig_acctno := LEFT.orig_acctno;
		 self.seqNum := left.seqNum;
		 self.ultid := left.ultid;
		 self.orgid := left.orgid;
		 self.seleid := left.seleid;
		 ))(seleid <> 0);
												  
	 ds_input_linkidsForContactsBipKey := PROJECT(ds_batchReportInRecs,
	                                        TRANSFORM(bipv2.IDlayouts.l_xlink_ids,
																						SELF.ultid := LEFT.ultid;
																						SELF.orgid := LEFT.orgid;
																						SELF.seleid := LEFT.seleid;
																						SELF := []
																		))(seleid <> 0);																		
		
	 	 // ** seleid relative info get *
	 FETCH_LEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;
		ds_bipContacts := TopBusiness_Services.Key_Fetches(ds_input_linkidsForContactsBipKey,
                                    	FETCH_LEVEL,TopBusiness_Services.Constants.ContactsKfetchMaxLimit
																		).ds_contact_linkidskey_recs;
																			
		ds_contactsRaw := dedup(ds_bipContacts(source <> 'D' and source <> '')
				, all, except dt_vendor_last_reported, dt_vendor_first_reported)(contact_did <> 0);           																	 
		ds_contactsSlim := dedup(sort(ds_contactsRaw, ultid, orgid,seleid, contact_DID,if (current,0,1), -dt_last_seen_contact, -dt_first_seen_contact),
                              ultid, orgid, seleid, contact_did, dt_last_seen_contact, dt_first_seen_contact);			
		// this is filtered later by SELEID and by DID
														
		ds_Batchinput_didsForRelationshipKey := PROJECT(ds_batchReportInRecs,
									 TRANSFORM( Relationship.layout_GetRelationship.DIDs_Layout,
									 SELF.DID := LEFT.did))(did <> 0);

	RelativeFlag := TRUE;
	AssociateFlag := TRUE;
	AllFlag := TRUE; // getting all relationship types
									 
	DS_relationships_Neutral := Relationship.proc_GetRelationshipNeutral(ds_Batchinput_didsForRelationshipKey,
                                  RelativeFlag,
																	AssociateFlag,
																	AllFlag,
																	RelationshipIdentifier_Services.Constants.RELPROC_TRANSACTIONONLYFLAG,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_MAXCOUNT,
																	RelationshipIdentifier_Services.Constants.RELPROC_TOPNCOUNT,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOSKIP,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOFAIL,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOATMOST,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_SAMELNAME,
																	RelationshipIdentifier_Services.Constants.RELPROC_MINSCORE,
																	RelationshipIdentifier_Services.Constants.RELPROC_RECENTRELATIVE,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_PERSON2,
																	RelationshipIdentifier_Services.Constants.RELPROC_EXCLUDETRANSCLOSURE2,
																	RelationshipIdentifier_Services.Constants.RELPROC_EXCLUDEINACTIVES,	
                                  ,
																	,
																	,
																	,
																	//Relationship.Layout_GetRelationship.TransactionalFlags_layout txflag = notx
																	).Result;
	DS_relationships:= Relationship.functions_getRelationship.convertNeutralToFlat_new(DS_relationships_Neutral);

// KEEP This documentation notes
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// DS_relationships DOCS: DID1 is original did input and DID2 is the result did if a relationship exists. /
//															
// data returned from relationship key doesn't have person names in it just 'did' field.		
//////////////////////////////////////////////////////////////////////////////////////////////////////////

dsrelativesDids := 	PROJECT(DS_relationships(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL and 
                                             CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH) , 
																						 TRANSFORM(Relationship.layout_GetRelationship.DIDs_Layout,
                          SELF.DID := LEFT.DID2;
													));
// 2nd pass only get relatives

ds_2ndDegreeRelatives := Relationship.proc_GetRelationshipNeutral(dsrelativesDiDs,
                                  TRUE, // relative Flag
																	TRUE, // associate flag
																	FALSE, // all flag
																	RelationshipIdentifier_Services.Constants.RELPROC_TRANSACTIONONLYFLAG,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_MAXCOUNT,
																	RelationshipIdentifier_Services.Constants.RELPROC_TOPNCOUNT,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOSKIP,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOFAIL,
																	RelationshipIdentifier_Services.Constants.RELPROC_DOATMOST,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_SAMELNAME,
																	RelationshipIdentifier_Services.Constants.RELPROC_MINSCORE,
																	RelationshipIdentifier_Services.Constants.RELPROC_RECENTRELATIVE,																	
																	RelationshipIdentifier_Services.Constants.RELPROC_PERSON2,
																	RelationshipIdentifier_Services.Constants.RELPROC_EXCLUDETRANSCLOSURE2,
																	RelationshipIdentifier_Services.Constants.RELPROC_EXCLUDEINACTIVES,	
																	,
																	,
																	,
																	,														
																	//Relationship.Layout_GetRelationship.TransactionalFlags_layout txflag = notx
																	).Result(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL and 
                                             CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH);
																
  // add in names of the input did's into DS
	NamesAdded := PROJECT(DS_relationships,                 
									 transform(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec,									          
														 SELF.title_str := Header.relative_titles.fn_get_str_title(LEFT.title);
														 SELF := LEFT,
														 SELF := []));
														 															 
  relInfo := JOIN(ds_batchReportInRecs, NamesAdded,
	                    LEFT.DID = RIGHT.DID1,
											TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.BatchRelationshipFunctionRec,
											SELF.SeqNum := LEFT.seqNum;
											SELF.orig_acctno := LEFT.orig_acctno;											
											self.acctno := '';
											SELF := RIGHT), 
							LEFT OUTER);
											
  relInfoSortedTmp := SORT(relInfo,orig_acctno,SeqNum,Total_Score);		
	
  // works w 1 acctno as input
	// which is what this batch service is implemented as now
	// 1 acctno but 2 entities as input.
	//                                                        
  SecondDegreeRelativesTmp := JOIN(relInfoSortedTmp(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL
	                                 and CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH),
	                                          ds_2ndDegreeRelatives,                        																
	                      LEFT.DID2 = RIGHT.DID1,											
												TRANSFORM(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec,
														SELF.SeqNum := LEFT.SeqNum;
														SELF.DID2 := RIGHT.DID2;
														SELF.DID1 := LEFT.DID1;
														tempTitle1 := Std.Str.ToUpperCase(Header.relative_titles.fn_get_str_title(RIGHT.title));
														tempTitle := Doxie_Raw.Constants.GetSecondDegRelation(LEFT.title,RIGHT.title);
														SELF.rel_dt_first_seen :=  max(RIGHT.rel_dt_first_seen,LEFT.rel_dt_first_seen);
														SELF.rel_dt_last_seen :=  max(RIGHT.rel_dt_last_seen, LEFT.rel_dt_last_seen);
                            SELF.hdr_dt_First_seen := LEFT.hdr_dt_first_seen;
														SELF.hdr_dt_last_seen := LEFT.hdr_dt_last_seen;																											 
													
														SELF.Title_str := Header.relative_titles.fn_get_str_title(tempTitle);
														SELF.TYPE := RIGHT.TYPE;
														SELF.CONFIDENCE := RelationshipIdentifier_Services.Constants.HIGH; // this is always high
														                                                                   // since both sides are filtered on HIGH
														SELF.orig_acctno := LEFT.orig_acctno;
														SELF := []));
    // remove the 1st degree relationship that have 0 for rel_dt_first_seen	
   AllRelsTmp := RelInfoSortedTmp(rel_dt_first_seen <> 0) & SecondDegreeRelativesTmp;  													
  // separate out the personal related relationships and dedup out by did1/did2
	// NOTE 'cluster' (which is a field in the output of the Relationship.proc_GetRelationship call)
	//     being non null in sort ensures 1st degree relationships are kept before 2nd degree relationships.
	// and keep greatest dt_first_seen since currently relatives v3 key doesn't set rel_dt_*_seen for 2nd degree relationships
	allRelsPersonal := dedup(sort((AllRelsTmp)(type = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL), 
	                              orig_acctno, seqNum,did1, did2,   if (confidence = RelationshipIdentifier_Services.Constants.HIGH, 0,1),
																 if (title_str <> 'Relative',0,1), 
												         if (title_str <> 'Associate',0,1),if (lname2 = '', 0,1),if (cluster <> '',0,1), -rel_dt_first_seen),
	                          orig_acctno, seqNum,did1, did2);
	
	allRelsNonpersonal :=  dedup(sort((AllRelsTmp)(type <> RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL), 
	                                   orig_acctno, seqNum,did1, did2, title_str, if (type = '', 0, 1)),
	                             orig_acctno, seqNum,did1, did2, title_str);
  secondDegreeRelatives := 	allRelsPersonal & allRelsNonpersonal;
																									 			   											 
   secondDegreeRelativesFinal := sort(secondDegreeRelatives,seqNum, total_score)(rel_dt_first_seen <> 0); 
	                                                                                // ^^^ filter added cause
																																								// relatives key output 0 value sometimes
																																								// for this field
   relInfoSorted := secondDegreeRelativesFinal;							
	
	 // ** seleid relatives info get*
	 
	   //**************ds_input_linkidsForBip already is set of just BIP linkids inputs (i.e. businesses only)
		 // so setup project inside kfetch to get the particular set of seleid relatives back.
		   ds_seleidRelative_kfetch := BIPV2.Key_BH_Relationship_SELEID.kFetch(
			              project(ds_input_linkidsForContactsBipKey,
								       transform(BIPV2.Key_BH_Relationship_SELEID.l_kFetch_in, 
											     self.seleid := left.seleid))													 												 
											 ); 
   // now project into a DS that has primarySeleid and secSeleid so that we can determine if a relationship exists										 
   ds_seleidRelative_kfetchSlim := project(ds_seleidRelative_kfetch,transform({unsigned6 Primaryseleid; unsigned6 Secseleid;             
	                                                        unsigned4 dt_first_seen_track; unsigned4 dt_last_seen_track;},
																								self.PrimarySeleid := left.seleid1;
																								self.SecSeleid := LEFT.seleid2;
																								self := LEFT));																										
													
		 // *************
   
    // join this set of primarySELEID and secSeleid back to orig input to add acctno and segnum
		ds_seleidRelativeWithAcctno := JOIN(ds_input_linkdsForBIPDataWOrigAcctno, ds_seleidRelative_kfetchSlim,
		                                     LEFT.SELEID = RIGHT.PrimarySeleid,
										TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.BatchSELEIDRelationshipFunctionRec,
										   self.orig_acctno := LEFT.orig_acctno;
											 SELF.seqNum := LEFT.seqNum;
											 self.acctno := '';
											 SELF := RIGHT),
											 LEFT OUTER)(primaryseleid <> 0); // added filter cause had some primaryseleid = 0
	 
	ds_BatchReportInputWithOrigAcctno := ds_batchReportInRecs;
  
   // create structure and set neighbor information.
	 
	 
    ds_createStructureWNeighbors := PROJECT(ds_BatchReportInputWithOrigAcctno,  TRANSFORM(		
		    RelationshipIdentifier_Services.Layouts.Batch.BatchRelationshipIdentifierReportRecord,
							
				  CurrentAcctno := LEFT.orig_acctno;
					SeqNo := LEFT.SeqNum;				 
					SELF.acctno := LEFT.acctno;
					self.orig_acctno := LEFT.orig_acctno;
					SELF.SeqNum := Seqno;
					UltidValue := LEFT.ultid;
					OrgidValue := LEFT.orgid;
					SeleidValue := LEFT.SELEID;	
					role  := LEFT.role;
					RoleNum := LEFT.roleNum;
					inputDID := LEFT.DID;
					InputDID2 := LEFT.DID;
					slimInput := ds_batchReportInputWithOrigAcctno(orig_acctno = CurrentAcctno);
					doxie.mac_best_records(SlimInput,did,
	                      SlimInputOut,dppa_ok,glb_ok,,DRM);
					
					ds_InputDID := PROJECT(slimInputOut(did = INPUTDID), TRANSFORM(doxie.layout_references, SELF.DID := INPUTDID;));
					 ds_InputDIDOut := slimInputOut(did = INPUTDID);					  
												
					personInfo := Join(DS_inputDID, ds_InputDIDOut,  
		                     LEFT.DID = RIGHT.DID,TRANSFORM(RIGHT));
  	      
           bipv2.idlayouts.l_xlink_ids l_xlink_ids_xform() := TRANSFORM											
													 SELF.ultid := ultidValue;
														SELF.orgid := orgidValue;
														SELF.seleid := seleidValue;
														self := [];
												END;
											
          l_xlink_ids := DATASET([ l_xlink_ids_xform() ]);												
					BestInfo := BIPV2_Best.Key_LinkIds.KFetch(l_xlink_ids,FETCH_LEVEL,,,,
										TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit)(proxid = 0);
					
					
					NeighborSetByacctno := ds_neighborResultsSlimWithAcctno(orig_acctno = CurrentAcctno and SeqNum = SeqNo);
					seleidRelSetByAcctno := if (seleidvalue <> 0, ds_seleidRelativeWithAcctno(orig_acctno = CurrentAcctno and seqNum = seqNo)); // seqNum contains the 1-8 numeral value of each individual acctno value
					
					 RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportPrimaryEntity
					                PrimaryEntity_xform() := TRANSFORM															
					                  SELF.UniqueID := InputDID;
														SELF.businessIDs.ultid := UltidValue;
														SELF.businessIDS.orgid := orgidValue;
														SELF.businessIDs.seleid := seleidValue;
														SELF.Role := Role;
														SELF.RoleNum := RoleNum;
														SELF.companyName := IF (seleidValue <> 0, BestInfo.company_name[1].Company_name, '');
														SELF.tin := IF (seleidValue <> 0, BestInfo.company_fein[1].Company_fein, '');
														SELF.address := IF (InputDID <> 0,
														               IESP.ECL2ESP.setAddress(
																	personInfo[1].prim_name,personInfo[1].prim_range,personInfo[1].predir,personInfo[1].postdir,
																	personInfo[1].suffix,personInfo[1].unit_desig,personInfo[1].sec_range,personInfo[1].city_name,
																	personInfo[1].st,personInfo[1].zip,personInfo[1].zip4,'',
																	                              //countyName,
																																'','','','')
														                      ,
																						 iesp.ecl2esp.setAddress(
			                                  BestInfo.company_address[1].company_prim_range,
																				BestInfo.company_address[1].company_prim_name,
																				BestInfo.company_address[1].company_predir,
																				BestInfo.company_address[1].company_postdir,
																				BestInfo.company_address[1].company_addr_suffix,
																				BestInfo.company_address[1].company_unit_desig,
																				BestInfo.company_address[1].company_sec_range,
																				BestInfo.company_address[1].address_v_city_name,
																				BestInfo.company_address[1].company_st,
																				BestInfo.company_address[1].company_zip5,
																				BestInfo.company_address[1].company_zip4,
																				//BestInfo.company_address[1].county_name;
																				'', // county
																				'',
																				'',
																				'',
																				''));
                            
														IESP.share.t_identity identity_xform() := TRANSFORM
														                         SELF.uniqueID := (STRING12) InputDID;
																										  SELF.Name := iesp.ecl2esp.setName(personInfo[1].fname,
																										           personINfo[1].mname,
																															 personInfo[1].lname,
																															 personInfo[1].name_suffix,
																															 personINfo[1].Title);	
                                                     SELF.SSNInfo.SSN := personInfo[1].SSN;				
																										 SELF.DOB := IESP.ecl2esp.toDate(personInfo[1].dob);
																										 SELF.DOD := iesp.ECL2ESP.ToDate((UNSIGNED4)personInfo[1].dod);	
																										 SELF := [];
																										 END;
                             SELF.Identity := DATASET([ Identity_xform() ])[1];																		 
														
														iesp.share.t_PhoneInfoEx phoneInfoEx_xform() := TRANSFORM
														                     SELF.phone10 := IF (InputDID <> 0, personInfo[1].phone, 
																								                     // ^^^^^^ tmp field from above
																								                    IF (SeleidValue <> 0, BestInfo.company_phone[1].company_phone, ''));
																																		  //^^^^^^^ tmp field from above												
														                     SELF := [];
																								 END;
																								 
                            SELF.PhoneInfoEx := DATASET([ phoneInfoEx_xform() ])[1];																								
														SELF := []; 
														END;
           SELF.PrimaryEntity := DATASET([ PrimaryEntity_xform() ])[1];												
          															
          SecondaryEntitysTmp := 
						JOIN(slimInput, SlimInputOut,
		           LEFT.DID = RIGHT.DID,		          							 
					    TRANSFORM(RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportSecondaryEntity,														    
							           SELF.UniqueID := LEFT.DID,		
												 SELF.businessIDs.ultid := LEFT.ultid;
												 SELF.businessIDS.orgid := LEFT.orgid;
												 SELF.businessIDs.seleid := LEFT.seleid;
												 SELF.ROLE := LEFT.ROLE;
												 SELF.RoleNum := LEFT.RoleNum; // always stays the same
												 SELF.identity.SSNInfo.ssn := RIGHT.SSN;
												 SELF.Identity.name := iesp.ecl2esp.setName(right.fname,
																										           right.mname,
																															 right.lname,
																															 right.name_suffix,
																															 right.Title);		
																															 
                         SELF.SecAddress := IF (LEFT.DID <> 0,
														               IESP.ECL2ESP.setAddress(
																	right.prim_name,right.prim_range,right.predir,right.postdir,
																	right.suffix,right.unit_desig,right.sec_range,right.city_name,
																	right.st,right.zip,right.zip4,'',
																	         //countyName,
																						'','','',''),
                                        IESP.ECL2ESP.setAddress(
																					'','','','',
																					'','','','',
																					'','','','',
																	         //countyName,
																					  '','','','')
																					);
																																
                         SELF.SecPhone := IF (LEFT.DID <> 0,RIGHT.phone,'');
												 SELF.SecDob :=   IF (LEFT.DID <> 0, (STRING8) RIGHT.DOB,'');
                         SELF.relationshipTYpes := [];																															 
												 SELF := LEFT;
												 SELF := []),
												 LEFT OUTER);												 
           // this project just fills in the business info if the entity is a business.												 
           SecondaryEntitysWithBusinfo := PROJECT(SecondaryEntitysTmp, 
					  TRANSFORM( RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportSecondaryEntity,						
					         ultidSecondaryEntity   := LEFT.businessIDs.ultid;
									 orgidSecondaryEntity   := LEFT.businessIDs.orgid;
									 SELEIDSecondaryEntity  := LEFT.businessIDs.SELEID;
									 
											bipv2.idlayouts.l_xlink_ids l_xlink_idsSecondaryEntitys_xform() := TRANSFORM
												  SELF.ultid := ultidSecondaryEntity; 
												  SELF.orgid := orgidSecondaryEntity; 
												  SELF.seleid := seleidSecondaryEntity;
											  SELF := [];											
												END;
												l_xlink_idsSecondaryEntitys := DATASET([ l_xlink_idsSecondaryEntitys_xform() ]);
											 BestInfoSecEnt := BIPV2_Best.Key_LinkIds.KFetch(l_xlink_idsSecondaryEntitys,FETCH_LEVEL,,,,
																			TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit)(proxid = 0);
                    SELF.companyName := IF (SELEIDSecondaryEntity <> 0, BestInfoSecEnt.company_name[1].Company_name,'');
										SELF.tin         := IF (seleidSecondaryentity <> 0, BestinfosecEnt.company_fein[1].company_fein,'');
										SELF.SecAddress := IF (SELEIDSecondaryEntity  <> 0, iesp.ecl2esp.setAddress(
														               BestInfoSecEnt.company_address[1].company_prim_range,
																				BestInfoSecEnt.company_address[1].company_prim_name,
																				BestInfoSecEnt.company_address[1].company_predir,
																				BestInfoSecEnt.company_address[1].company_postdir,
																				BestInfoSecEnt.company_address[1].company_addr_suffix,
																				BestInfoSecEnt.company_address[1].company_unit_desig,
																				BestInfoSecEnt.company_address[1].company_sec_range,
																				BestInfoSecEnt.company_address[1].address_v_city_name,
																				BestInfoSecEnt.company_address[1].company_st,
																				BestInfoSecEnt.company_address[1].company_zip5,
																				BestInfoSecEnt.company_address[1].company_zip4,
																				//BestInfo.company_address[1].county_name;
																				'', // county
																				'',
																				'',
																				'',
																				''),
																				// if not a business just use the person address that is already set.
																				left.SecAddress);
																				
										SELF.SecPhone := IF (SELEIDSecondaryEntity  <> 0, BestInfoSecEnt.company_phone[1].company_phone,left.secphone);
										SELF.businessIds.ultid := ultidSecondaryEntity; 
										SELF.businessIDs.orgid := orgidSecondaryEntity; 
										SELF.businessIds.seleid := seleidSecondaryEntity; 
										SELF.relationshipTYpes := [];
										SELF := LEFT;
									));
					 					 
          SELF.SecondaryEntitys := PROJECT(SecondaryEntitysWithBusinfo, TRANSFORM(
					                     RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportSecondaryEntity,					                   
															 
															  Neighbordata := NeighborSetByAcctno(DID = LEFT.uniqueID);	
																// has to be did value from neighborset and not base_did as this is using primaryEntity DID as base_did
															  //                                                                        ^^^^^^^^^^^^
															  //                                                                segno = seqNum from above filter
																secEntityDID := LEFT.UniqueID;
																secondarySeleid := LEFT.businessIds.seleid;
																SELF.isNeighbor := exists(Neighbordata);
																// filter out the neighbor relationship from using secondaryDID as base_did and primary DID as the 'neighbor'
																ds_neighborsCurAcctnoSecEntity := ds_neighborResultsSlimWithAcctno(orig_acctno = CurrentAcctno and base_did = secEntityDID
																                                    and did = InputDID2 );
																dt_first_seenSecNeighbor := PROJECT(ds_neighborsCurAcctnoSecEntity,TRANSFORM({unsigned4 dt_first_seen;}, 
																                                self := left))[1].dt_first_seen;																												
																																		
																self.neighbor_dt_last_seen := PROJECT(Neighbordata, TRANSFORM({unsigned4 neighbor_dt_last_seen;},
																                      self.neighbor_dt_last_seen := LEFT.dt_last_seen;))[1].neighbor_dt_last_seen;
                                neighbor_dt_first_seenTmp := PROJECT(Neighbordata, TRANSFORM({unsigned4 neighbor_dt_first_seen;},
																                      self.neighbor_dt_first_seen := LEFT.dt_first_seen;))[1].neighbor_dt_first_seen;																									
                                // now if neighbor relationship exists use the max of dt_first_seen from the neighbor file
																// from either person's neighbor data because start of neighbor relationship starts at a particular point in time
																// and can't have 2 different dt_first_seen values for the start date -- same logic is in RelationshipIdentifier_Services.Report_Records
																//
                                self.neighbor_dt_first_seen := if (exists(NeighborData),
																                                MAX(dt_first_seenSecNeighbor,  neighbor_dt_first_seenTmp),
																											             neighbor_dt_first_seenTmp);					   
																											
																seleidRelData := if ( secondarySeleid <> 0, seleidRelSetByAcctno(SecSeleid = SecondarySeleid));
																isSeleIdRel := exists(seleidRelData);
																															
																	 RelationshipIdentifier_Services.Layouts.bat_RelationshipIdentifierReportRelationshipTypeIESPDATE
																	        RelationshipTypes_xform() := TRANSFORM
																	              SELF.RelationshipType := if (isSELEIDrel,'SELEIDREL','');
																								SELF.relationshipfirstseenDate := if (isSeleidRel,
																								                 project(seleidRelData,
																																      transform({iesp.share.t_date d;},
																																         self.d := 
																																				 iesp.ecl2esp.toDate(left.dt_first_seen_track)))[1].d,
																																				 iesp.ecl2esp.toDate(0)
																																				 );
																								SELF.relationshiplastseenDate := if (isSeleidRel,
																								                 project(seleidRelData,
																																      transform({iesp.share.t_date d;},
																																         self.d := 
																																				 iesp.ecl2esp.toDate(left.dt_last_seen_track)))[1].d,
																																				 iesp.ecl2esp.toDate(0)
																																				 );                                                                      
                                          END;																																			
              									self.relationshipTYpes := DATASET([ RelationshipTypes_xform() ]);
																																                              			                 				               
												       SELF := LEFT;											
													     ));					 
           SELF := LEFT;													 
           SELF := [];
					 ));					           														 	 		                         	                      		 																				     															 
  // now go through and hit relationship key and add in the particular string messages for the batch
		 
	 ds_structureWRelatives := PROJECT(ds_createStructureWNeighbors, 
			TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.BatchRelationshipIdentifierReportRecord,
														
         PrimaryEnt_UniqueId := LEFT.primaryEntity.Uniqueid;
				 PrimaryEnt_Seleid := LEFT.primaryEntity.BusinessIds.Seleid;
				 PrimaryEnt_orgid := LEFT.PrimaryEntity.BusinessIDs.Orgid;
				 PrimaryEnt_ultid := LEFT.PrimaryEntity.BusinessIds.Ultid;
																			 							
					seqno := LEFT.seqNum;
					ORIGAcctNumber := LEFT.orig_acctno;
					// important to trim here by seqNum...and only get the did's pertaining to
			   // that particular relationship with DID1 being base did in relationship key results
		      RelationShipRecstrimmed := relInfoSorted(DID1 = PrimaryEnt_UniqueID and SeqNum = SeqNo and orig_acctno = ORIGAcctNumber);
					
					BipContactSlim := IF (primaryEnt_seleid <> 0, ds_contactsSlim(ultid = PrimaryEnt_ultid AND orgid = PrimaryEnt_orgid AND
					                                     seleid = PrimaryEnt_seleid), ds_contactsSlim);
         																				 																							 
					// store up secondary relationships which already have neighbor boolean set																		 
					SecEntitysWNeighborRelationship := PROJECT(LEFT.SecondaryEntitys, TRANSFORM(RECORDOF(LEFT),
														                                SELF := LEFT));																							 																							 																															               																														 
           self.SecondaryEntitys := PROJECT(SecEntitysWNeighborRelationship,					                                                    												
						  TRANSFORM(RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportSecondaryEntity,
							  SecondaryEnt_UniqueID := LEFT.UniqueID;
								secondaryEnt_seleid := LEFT.businessIDs.seleid;
								
								isNeighbor := LEFT.IsNeighbor;			
								neighbor_dt_first_seen := if (length((string) LEFT.neighbor_dt_first_seen) = 6, LEFT.neighbor_dt_first_seen * 100,
								                              LEFT.neighbor_dt_first_seen);
								neighbor_dt_last_seen := if (length((string) LEFT.neighbor_dt_last_seen) = 6, LEFT.neighbor_dt_last_seen * 100,
								                              LEFT.neighbor_dt_last_seen);
								SELF.IsNeighbor := isNeighbor;
								
								isSELEidRel := exists(LEFT.relationshipTypes(relationshipType = RelationshipIdentifier_Services.Constants.SELEIDREL));
								seleidRel_dt_first_seen := if (isSELEidRel, (unsigned4) iesp.ecl2esp.t_DateToString8(LEFT.RelationshipTypes[1].relationshipfirstseenDate),
								                              0
																							);
                seleidRel_dt_last_seen := if (isSELEidRel, (unsigned4) iesp.ecl2esp.t_DateToString8(LEFT.RelationshipTypes[1].relationshiplastseenDate),
								                              0
																							);
						   // function call will return a set of defined relationship types based
							// on logic.
							  RelationshipTypes := 
								  RelationshipIdentifier_Services.Functions.setRelationshipType(
									isSeleidRel,
									SeleidRel_dt_first_seen,
									seleidRel_dt_last_seen,
									isNeighbor,
									neighbor_dt_first_seen,
									neighbor_dt_last_seen,
									PrimaryEnt_uniqueID,
									PrimaryEnt_Seleid,
									SecondaryEnt_uniqueID,
									SecondaryEnt_seleid,
									SeqNo,
									RelationshipRecsTrimmed,
									 // ^^^^^^^^^^^^^^^^^^^^^^^^
									 // already trimmed by acctno and segnum
								  BipContactSlim,
									endDate								 
									);									 
									 SELF.NumberOfSources := if (exists(relationshipTypes(Strength = RelationshipIdentifier_Services.Constants.LOW)),
								                           0,
								                           count(relationshipTypes)
																					 );															
									self.RelationshipTypes := CHOOSEN(DEDUP(PROJECT(relationshipTypes, TRANSFORM(
									
									RelationshipIdentifier_Services.Layouts.bat_RelationshipIdentifierReportRelationshipTypeIESPDATE,
									   SELF.relationshipfirstseenDate := iesp.ecl2esp.toDate(left.rel_dt_first_seen);
										 self.relationshiplastseenDate := iesp.ecl2esp.toDate(left.rel_dt_last_seen);
										 self.relationshipType := if (left.RelationshipType = RelationshipIdentifier_Services.Constants.NODISPLAYFLAG,
										                                    '', left.RelationshipType); // catch all
									   SELF := LEFT)),ALL), RelationshipIdentifier_Services.Constants.MAX_COUNT_RELATIONSHIP_TYPES);
							
									     
								  SELF.UniqueID := LEFT.UNIQUEID;,								
                  // all values of strength except top dataset are irrelevant in this DS so just take the top
									// one which is the only one that is set.
								  SELF.relationshipStrength := PROJECT(relationshipTypes, TRANSFORM({string20 s;},
																				        self.s := left.strength;))[1].s;
                 					
								  SELF := LEFT;
								  SELF := [])); 																																															
					 SELF := LEFT;
					 SELF := [];
		       ));		
					 
tmpoutrecSub := record
	unsigned2 NumberOfSources;
	string20 relationshipStrength;
  Batchshare.Layouts.ShareErrors;
END;
     
	tmpoutRec := RECORD
	string20 orig_acctno;
	string20 acctno;	
	unsigned6  PrimaryEntity;
  string50   Role;			
	string9   PriSsn;
  string15 PriDid;
	string20  PriLastname;
	string20  PriFirstname;
	string20  PriMiddlename;
	unsigned6  Pri_ultid;
	unsigned6  Pri_orgid;
	unsigned6  Pri_seleid;
	unsigned6  Pri_proxid;
	string9   PriTin;		
	string120  PriCompanyName;

	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   addr_suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25  city;
	STRING2   state;
	STRING5   zip;
		  
	string10  PriPhone;	
	string8   priDob;
	
	integer   SecondaryEntity;
	string50  secRole;	
  string16  secdid; 
  string9   secSsn; 
	string20  secLastName;
  string20  secFirstName;
	string20  secMIddleName; 
	unsigned6 secUltid; 
	unsigned6 secOrgid; 
	unsigned6 secSeleid;
	unsigned6 secProxid;
	string9   secTin;
	string120 secCompanyName; 		
	
	STRING10  Secprim_range;
	STRING2   SEcpredir;
	STRING28  SEcprim_name;
	STRING4   Secaddr_suffix;
	STRING2   Secpostdir;
	STRING10  Secunit_desig;
	STRING8   Secsec_range;
	STRING25  Seccity;
	STRING2   Secstate;
	STRING5   Seczip;
	string10  SecPhone;	
	string8   SecDob;
	
	dataset(RelationshipIdentifier_Services.Layouts.bat_RelationshipIdentifierReportRelationshipTypeIESPDATE)
	     relationshipTypes				
			{MAXCOUNT(RelationshipIdentifier_Services.Constants.MAX_COUNT_RELATIONSHIP_TYPES)};		
END;
		
outrec := RECORD
	tmpoutRec;
	tmpoutrecSub;
END;

outrec
            secTR( RelationshipIdentifier_Services.Layouts.batch.BatchRelationshipIdentifierReportRecord l,
						       RelationshipIdentifier_Services.Layouts.batch.bat_relationshipIdentifierReportSecondaryEntity r) := TRANSFORM
					  self.orig_acctno := l.orig_acctno;
						self.acctno := l.acctno;
						self.Role := l.primaryEntity.role;
					  self.PrimaryEntity := l.primaryentity.rolenum;
					  self.PriDid := (STRING16) l.Primaryentity.UniqueID;
						self.PriSsn := l.PrimaryEntity.identity.ssnInfo.ssn;				
					  self.PriFirstName := l.PrimaryEntity.Identity.name.first;
						self.PriMiddleName := l.PrimaryEntity.Identity.name.middle;
						self.priLastname := l.PrimaryEntity.Identity.name.last;
						SELF.pri_ultid := l.PrimaryEntity.businessIds.ultid;
	          SELF.pri_orgid := l.PrimaryEntity.businessIds.orgid;
	          SELF.pri_seleid := l.PrimaryEntity.businessIds.seleid;	
						SELF.pri_proxid := l.PrimaryEntity.businessIds.proxid;
            self.PriCompanyName := l.PrimaryEntity.companyName;
						self.priTin       := l.PrimaryEntity.tin;
						SELF.prim_range  := l.PrimaryEntity.address.StreetNumber;
						SELF.predir      := l.PrimaryEntity.address.StreetPreDirection;
						SELF.prim_name   := l.PrimaryEntity.address.StreetName;
						SELF.addr_suffix := l.PrimaryEntity.address.StreetSuffix;
						SELF.postdir     := l.PrimaryEntity.address.StreetPostDirection;
						SELF.unit_desig  := l.PrimaryEntity.address.UnitDesignation;
						SELF.sec_range   := l.PrimaryEntity.address.UnitNumber;
						SELF.city        := l.PrimaryEntity.address.City;
						SELF.state       := l.PrimaryEntity.address.State;
						SELF.zip         := l.PrimaryEntity.address.zip5;				
						self.PriPhone    := l.PrimaryEntity.PhoneInfoEx.phone10;
						self.priDob      := iesp.ecl2esp.t_DateToString8(l.PrimaryEntity.Identity.dob);
					
						self.secondaryEntity := r.rolenum;
						SELF.secRole := r.role;
						self.secdid := (STRING16) r.UniqueID;
						self.secSsn := r.identity.ssnInfo.ssn;
						SELF.secultid := r.businessIds.ultid;
	          SELF.secorgid := r.businessIds.orgid;
	          SELF.secseleid := r.businessIds.seleid;	
						SELF.secproxid := r.businessIds.proxid;					
						SELF.secTin := r.Tin;
						self.secFirstName   := r.Identity.name.first;
						self.secMIddleName  := r.Identity.name.middle;
						SELF.secLastName    := r.Identity.name.last;
						self.SecCompanyName := r.companyName;
						 
            SELF.Secprim_range  := r.Secaddress.StreetNumber;
						SELF.Secpredir      := r.Secaddress.StreetPreDirection;
						SELF.Secprim_name   := r.SEcaddress.StreetName;
						SELF.Secaddr_suffix := r.Secaddress.StreetSuffix;
						SELF.Secpostdir     := r.SEcaddress.StreetPostDirection;
						SELF.Secunit_desig  := r.SEcaddress.UnitDesignation;
						SELF.Secsec_range   := r.SEcaddress.UnitNumber;
						SELF.Seccity        := r.SEcaddress.City;
						SELF.Secstate       := r.SEcaddress.State;
						SELF.Seczip         := r.SEcaddress.zip5;				
						self.SecPhone       := r.Secphone;
						self.SEcDob         := r.secDob;
											
											
										
						SELF.relationshipTypes := r.relationshipTypes;
						SELF.NumberOfSources := r.NumberOfSources;		
						SELF.RelationshipStrength := r.RelationshipStrength;
          end;

ds_batch_secondarys := normalize(ds_structureWRelatives, LEFT.secondaryEntitys, secTR(LEFT,RIGHT));

outrecFinal := RECORD
	tmpoutRec - [relationshipTypes];
	string50 relationshipType;
	unsigned4 rel_dt_first_seen;
  unsigned4 rel_dt_last_seen;
	tmpoutrecSub;
END;	

Final := RECORD
	outRecFinal - [orig_acctno];
END;	

outrecFinal  relTypeTR( outrec l,
	  RelationshipIdentifier_Services.Layouts.bat_RelationshipIdentifierReportRelationshipTypeIESPDATE r) := TRANSFORM					
					  SELF := l;
						self.relationshipType := R.relationshipType;
						self.rel_dt_first_seen := (unsigned4) iesp.ecl2esp.DateToInteger(r.relationshipfirstseenDate);
						self.rel_dt_last_seen := (unsigned4) iesp.ecl2esp.DateToInteger(r.relationshiplastseenDate);			                    										
					END;

tmpds_norm_final := normalize(ds_batch_secondarys, left.relationshipTypes, relTypeTR(LEFT,RIGHT));

// take out the reverse relationships from the output results so that if 2 enties A and B are entered
// as input only the output will show A -> B relationship and not the B -> A relationship
// entities are sequentially numbered thus the filter.
ds_norm_final := tmpds_norm_final(PrimaryEntity < SecondaryEntity);		

// project out the field orig_acctno
ds_Results := PROJECT(ds_norm_final, TRANSFORM(Final, SELF := LEFT));

ssnMaskVal := inmod.ssn_mask;
application_type_value := inmod.application_type;

// DO suppression here
 // ********** do suppression of SSN. 
		  Suppress.MAC_Suppress(ds_results,ds_results_pulled,application_type_value,Suppress.Constants.LinkTypes.SSN,priSSN);
			Suppress.MAC_Suppress(ds_results_pulled,ds_results_pulled2,application_type_value,Suppress.Constants.LinkTypes.SSN,secSSN);
		// suppress by DID 
		
		Suppress.MAC_Suppress(ds_results_pulled2,ds_results_pulled3,application_type_value,Suppress.Constants.LinkTypes.DID,priDid);
		Suppress.MAC_Suppress(ds_results_pulled3,ds_results_pulled4,application_type_value,Suppress.Constants.LinkTypes.DID,SecDid);
	// SSN suppression
	  Suppress.MAC_Mask(ds_results_pulled4, ds_results_masked, priSSN, null, true, false, maskVal:=ssnMaskVal);		
		Suppress.MAC_Mask(ds_results_masked, ds_results_masked2, secSSN, null, true, false, maskVal:=ssnMaskVal);
	
	/////////////////
	// **********************	 
	//output(DRM, named('DRM'));
	// output(ds_batchReportInRecs, named('ds_batchReportInRecs'));
  // output(didsSequenced, named('didsSequenced'));	
	//output(neighborsWithAcctno, named('neighborsWithAcctno'));
	
	//output(ds_NeighborResultsbyOrigAcctno, named('ds_NeighborResultsbyOrigAcctno'));
	// output(ds_NeighborResultsbyOrigAcctno, named('ds_NeighborResultsbyOrigAcctno'));
	//output(ds_BatchReportInputWithOrigAcctno, named('ds_BatchReportInputWithOrigAcctno'));
	//output(ds_neighborResultsSlim, named('ds_neighborResultsSlim'));
	//output(tmpds_neighborResultsSlim, named('tmpds_neighborResultsSlim'));
	//output(ds_neighborResultsSlimWithAcctno, named('ds_neighborResultsSlimWithAcctno'));
	//ds_neighborResultsSlimWithAcctno
	// output(DS_relationships,named('DS_relationships'));
	// output(ds_contactsRaw, named('ds_contactsRaw'));
	//output(ds_contactsSlim, named('ds_contactsSlim'));
	// output(ds_contactsbyDate, named('ds_contactsSlim_byDate'));
	 // output(namesAdded2, named('namesAdded2'));
	
	//output(relInfoSorted, named('relInfoSorted'));
	 // output(relInfoSortedTmp, named('relInfoSortedTmp'));
	
	 // output(SecondDegreeRelatives, named('SecondDegreeRelatives'));
	//output(ds_createStructureWNeighbors, named('ds_createStructureWNeighbors'));
   // output(ds_contactsByDate, named('ds_contactsByDate'));
	 // output(ds_structureWRelatives, named('ds_structureWRelatives'));
	// output(tmpds_norm_final, named('tmpds_norm_final'));
	//output(ds_norm_final, named('ds_norm_final'));
	// output(ds_initialStructure, named('ds_initialStructure'));
	// output(createFlatStructure, named('CreateFlatStructure'));
	//output(ds_structurewRelativeGrouped, named('ds_structurewRelativeGrouped'));
	//return(CreateFlatStructure);
	//return(ds_norm_final_filteredByDate);
	//output(ds_seleidRelativeWithAcctno, named('ds_seleidRelativeWithAcctno'));
	//output(ds_results, named('ds_results'));
	ds_resultsFinal := ds_results_masked2;
	return(ds_ResultsFinal);
	
	END;
  