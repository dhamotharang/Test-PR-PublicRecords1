/*2015-10-23T17:59:26Z (Srilatha Katukuri)
#181860
*/
/*2015-10-16T01:25:06Z (Sudhir Kasavajjala)

*/
/*2015-02-11T00:48:53Z (Ayeesha Kayttala)
bug# 173256 - code review 
*/
import ut, RoxieKeyBuild,flaccidents;

export proc_build_EcrashV2_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_Did
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::did'
					  			       ,'~thor_data400::key::ecrashv2_did',bk_did,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_AccNbr
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::accnbr'
					                   ,'~thor_data400::key::ecrashv2_accnbr',bk_accnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_AccNbrV1
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::accnbrv1'
					                   ,'~thor_data400::key::ecrashv2_accnbrv1',bk_accnbrv1,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_Bdid
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::bdid'
					                   ,'~thor_data400::key::ecrashv2_bdid',bk_bdid,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_DLNbr
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::dlnbr'
					  			       ,'~thor_data400::key::ecrashv2_dlnbr',bk_dlnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_TagNbr
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::tagnbr'
					      			   ,'~thor_data400::key::ecrashv2_tagnbr',bk_tagnbr,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_VIN
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::vin'
					  			       ,'~thor_data400::key::ecrashv2_vin',bk_vin,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_vin7
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::vin7'
					  			       ,'~thor_data400::key::ecrashv2_vin7',bk_vin7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrashv2_dol
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::dol'
					  			       ,'~thor_data400::key::ecrashv2_dol',bk_dol,2);	
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_EcrashV2_Partial_Report_Nbr
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::partialaccnbr'
					  			       ,'~thor_data400::key::ecrashv2_partialaccnbr',bk_partialaccnbr,2);	
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_EcrashV2_LinkIds.Key
									   ,'~thor_data400::key::ecrashv2::' + filedate + '::linkids'
					                   ,'~thor_data400::key::ecrashv2_linkids',bk_linkids,2);

												 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash0
                     ,'~thor_data400::key::ecrash::' +filedate+'::ecrash0'
    									   ,'~thor_data400::key::ecrash0',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash1
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash1'
					  			       ,'~thor_data400::key::ecrash1',bk1,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash2v
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash2v'
					  			       ,'~thor_data400::key::ecrash2v',bk2,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash3v
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash3v'
					  			       ,'~thor_data400::key::ecrash3v',bk3,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash4
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash4'
	 				  			       ,'~thor_data400::key::ecrash4',bk4,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash5
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash5'
					  			       ,'~thor_data400::key::ecrash5',bk5,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash6
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash6'
					  			       ,'~thor_data400::key::ecrash6',bk6,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash7
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash7'
					  			       ,'~thor_data400::key::ecrash7',bk7,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(flaccidents_ecrash.Key_ecrash8
									   ,'~thor_data400::key::ecrash::' +filedate+'::ecrash8'
					  			       ,'~thor_data400::key::ecrash8',bk8,2);	

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrashv2_Supplemental
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::Supplemental'
					  			       ,'~thor_data400::key::ecrashv2_Supplemental',bk_Supplemental,2);
												 

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrashV2_ReportId
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::ReportId'
					  			       ,'~thor_data400::key::ecrashv2_ReportId',bk_ReportId,2);
												 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrashV2_DeltaDate
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::deltadate'
					  			       ,'~thor_data400::key::ecrashv2_deltadate',bk_deltadate,,true);	
// Analytics keys 

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_ByAgencyID
									   ,'~thor_data400::key::ecrashV2::' +filedate+'::analytics_byAgencyID'
					  			       ,'~thor_data400::key::ecrashv2::analytics_byAgencyID',bk_agencyid,2);	
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_ByDOW
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::analytics_byDOW'
					  			       ,'~thor_data400::key::ecrashV2::analytics_byDOW',bk_DOW,2);	
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_byMOY
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::analytics_byMOY'
					  			       ,'~thor_data400::key::ecrashV2::analytics_byMOY',bkMOY,2);	

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_ByHOD
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::analytics_byHOD'
					  			       ,'~thor_data400::key::ecrashV2::analytics_byHOD',bkHOD,2);	

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_ByCollisionType
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::analytics_byCollisionType'
					  			       ,'~thor_data400::key::ecrashV2::analytics_byCollisionType',bkCol,2);	
												 
 RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrash_ByInter
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::analytics_byInter'
					  			       ,'~thor_data400::key::ecrashV2::analytics_byInter',bkInter,2);	

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_ECrash.Key_eCrashv2_PrefName_State
																				,'~thor_data400::key::eCrashv2::' +filedate+'::PrefName_State'
																				,'~thor_data400::key::eCrashv2_PrefName_State',bk_PrefName_State,2); 		
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_Ecrash.Key_eCrashv2_agencyId_sentdate
									   ,'~thor_data400::key::ecrashv2::' +filedate+'::agencyId_sentdate'
					                   ,'~thor_data400::key::ecrashv2_agencyId_sentdate',bk_agencyId_sentdate,2)		
														 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_ECrash.Key_eCrashv2_StAndLocation
																				,'~thor_data400::key::eCrashv2::' +filedate+'::StAndLocation'
																				,'~thor_data400::key::eCrashv2_StAndLocation',bk_StAndLocation,2);

RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_ECrash.Key_eCrashv2_ReportLinkId
																				,'~thor_data400::key::eCrashv2::' +filedate+'::ReportLinkId'
																				,'~thor_data400::key::eCrashv2_ReportLinkId',bk_ReportLinkId,2);		
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_ECrash.Key_eCrashv2_LastName
																				,'~thor_data400::key::eCrashv2::' +filedate+'::LastName_state'
																				,'~thor_data400::key::eCrashv2_LastName_state',bk_LastName,2); 		
RoxieKeyBuild.Mac_SK_BuildProcess_Local(FLAccidents_ECrash.Key_eCrashv2_PhotoId
																				,'~thor_data400::key::eCrashv2::' +filedate+'::PhotoId'
																				,'~thor_data400::key::eCrashv2_PhotoId',bk_PhotoId,2);				
		
build_keys := parallel(bk_did,bk_accnbr,bk_accnbrv1,bk_bdid,bk_dlnbr,bk_tagnbr,bk_vin,bk_dol,bk_linkids,bk0,bk1,bk3,bk5,bk6,bk7,bk8,bk_agencyid,bk_DOW,bkMOY,bkHOD,bkCol,bkInter,bk_Supplemental,bk_ReportId,bk_PrefName_State,bk_agencyId_sentdate,bk_StAndLocation,bk_ReportLinkId,bk_LastName, bk_photoId);

// move keys to built

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::did'
                                  ,'~thor_data400::key::ecrashv2_did'
								  ,move10);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::accnbr'
                                  ,'~thor_data400::key::ecrashv2_accnbr'
								  ,move11);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::accnbrv1'
                                  ,'~thor_data400::key::ecrashv2_accnbrv1'
								  ,move11V1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::bdid'
                                  ,'~thor_data400::key::ecrashv2_bdid'
								  ,move12);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::dlnbr'
                                  ,'~thor_data400::key::ecrashv2_dlnbr'
								  ,move13);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::tagnbr'
                                  ,'~thor_data400::key::ecrashv2_tagnbr'
								  ,move14);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::vin'
                                  ,'~thor_data400::key::ecrashv2_vin'
								  ,move15);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::vin7'
                                  ,'~thor_data400::key::ecrashv2_vin7'
								  ,move17);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::dol'
                                  ,'~thor_data400::key::ecrashv2_dol'
								  ,move18);
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::partialaccnbr'
                                  ,'~thor_data400::key::ecrashv2_partialaccnbr'
								  ,move19);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+ '::linkids'
                                  ,'~thor_data400::key::ecrashv2_linkids'
								  ,move20);									
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash0'
                                  ,'~thor_data400::key::ecrash0'
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash1'
                                  ,'~thor_data400::key::ecrash1'
								  ,move2);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash2v'
                                  ,'~thor_data400::key::ecrash2v'
								  ,move3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash3v'
                                  ,'~thor_data400::key::ecrash3v'
								  ,move4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash4'
                                  ,'~thor_data400::key::ecrash4'
								  ,move5);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash5'
                                  ,'~thor_data400::key::ecrash5'
								  ,move6);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash6'
                                  ,'~thor_data400::key::ecrash6'
								  ,move7);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash7'
                                  ,'~thor_data400::key::ecrash7'
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrash::' +filedate+'::ecrash8'
                                  ,'~thor_data400::key::ecrash8'
								  ,move9);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::Supplemental'
                                  ,'~thor_data400::key::ecrashv2_Supplemental'
								  ,moveSupplemental);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::ReportId'
                                  ,'~thor_data400::key::ecrashv2_ReportId'
								  ,moveReportId);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::deltadate'
                                  ,'~thor_data400::key::ecrashv2_deltadate'
								  ,movedeltadate);									
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::eCrashv2::' +filedate+'::PrefName_State'
																		,'~thor_data400::key::eCrashv2_PrefName_State'
																		,movePrefName_State);									
//Analytics
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashV2::' +filedate+'::analytics_byAgencyID'
                                  ,'~thor_data400::key::ecrashv2::analytics_byAgencyID'
								  ,moveAgencyID);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::analytics_byDOW'
                                  ,'~thor_data400::key::ecrashV2::analytics_byDOW'
								  ,moveDOW);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::analytics_byMOY'
                                  ,'~thor_data400::key::ecrashV2::analytics_byMOY'
								  ,moveMOY);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::analytics_byHOD'
                                  ,'~thor_data400::key::ecrashV2::analytics_byHOD'
								  ,moveHOD);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::analytics_byCollisionType'
                                  ,'~thor_data400::key::ecrashV2::analytics_byCollisionType'
								  ,moveCol);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::analytics_byInter'
                                  ,'~thor_data400::key::ecrashV2::analytics_byInter'
								  ,moveinter);

RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::ecrashv2::' +filedate+'::agencyId_sentdate'
                                  ,'~thor_data400::key::ecrashv2_agencyId_sentdate'
								  ,moveagencyId_sentdate);
									
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::eCrashv2::' +filedate+'::StAndLocation'
																		,'~thor_data400::key::eCrashv2_StAndLocation'
																		,moveStAndLocation);	
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::eCrashv2::' +filedate+'::ReportLinkId'
																		,'~thor_data400::key::eCrashv2_ReportLinkId'
																		,moveReportLinkId);		
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::eCrashv2::' +filedate+'::LastName_state'
																		,'~thor_data400::key::eCrashv2_LastName_state'
																		,moveLastName);																			
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::eCrashv2::' +filedate+'::PhotoId'
																		,'~thor_data400::key::eCrashv2_PhotoId'
																		,movePhotoId);								
move_build_keys := parallel(move10,move11,move11V1,move12,move13,move14,move15,move18,move1,move2,move4,move6,move7,move8,move9,moveAgencyID,moveDOW,moveMOY,moveHOD,moveCol,moveinter,moveSupplemental,moveReportId, movePrefName_State,moveagencyId_sentdate,moveStAndLocation,moveReportLinkId,moveLastName, movePhotoId);

// Move keys to QA
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_did', 'Q', moveq10);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_accnbr','Q', moveq11);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_accnbrv1','Q', moveq11v1);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_bdid',  'Q', moveq12);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_dlnbr', 'Q', moveq13);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_tagnbr','Q', moveq14);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_vin',   'Q', moveq15);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_vin7',   'Q', moveq17);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_dol',   'Q', moveq18);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_partialaccnbr',   'Q', moveq19);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_linkids',   'Q', moveq20);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash0',    'Q', moveq1);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash1',    'Q', moveq2);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash2v',   'Q', moveq3);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash3v',   'Q', moveq4);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash4',    'Q', moveq5);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash5',    'Q', moveq6);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash6',    'Q', moveq7);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash7',    'Q', moveq8);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrash8',    'Q', moveq9);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2::analytics_byAgencyID',    'Q', moveqAgencyID);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashV2::analytics_byDOW',    'Q', moveqDOW);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashV2::analytics_byMOY',    'Q', moveqMOY);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashV2::analytics_byHOD',    'Q', moveqHOD);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashV2::analytics_byCollisionType',    'Q', moveqCollision);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashV2::analytics_byInter',    'Q', moveqInter);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_Supplemental',    'Q', moveqSupplemental);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_ReportId',    'Q', moveqReportId);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_deltadate',    'Q', moveqdeltadate);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::eCrashv2_PrefName_State',	'Q', moveqPrefName_State);									
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::ecrashv2_agencyId_sentdate','Q', moveqagencyId_sentdate);		
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::eCrashv2_StAndLocation',	'Q', moveqStAndLocation);	
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::eCrashv2_ReportLinkId',	'Q', moveqReportLinkId);													
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::eCrashv2_LastName_state',	'Q', moveqLastName);
RoxieKeyBuild.Mac_SK_Move_V3('~thor_data400::key::eCrashv2_PhotoId',	'Q', moveqPhoto);
move_qa_keys := parallel(moveq10
							,moveq11,moveq11v1,moveq12,moveq13,moveq14,moveq15,moveq18,moveq1,moveq2,moveq4,moveq6,moveq7,moveq8,moveq9,moveqAgencyID,moveqDOW,moveqMOY,moveqHOD,moveqCollision,moveqInter,moveqSupplemental,moveqReportId, moveqPrefName_State,moveqagencyId_sentdate,moveqStAndLocation,moveqReportLinkId,moveqLastName,moveqPhoto);


do_all:= sequential(	
					build_keys
					,move_build_keys
					,move_qa_keys
					,bk_partialaccnbr
					,move19,moveq19
					,move20,moveq20
					,bk_vin7
					,move17
					,moveq17
					,bk2
					,move3
					,moveq3
					,bk4
					,move5
					,moveq5
					,bk_deltadate
					,movedeltadate
					,moveqdeltadate
					,FLAccidents_Ecrash.proc_build_ecrashV2_autokey(filedate)
					); 
return do_all;
												   
end;