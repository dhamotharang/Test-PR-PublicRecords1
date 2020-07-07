// Report Records attribute for the Relationship Identifier Report Service.

// It takes input of DID or linkids set (bipdata) and then
// returns a list of up to 8 entity's with each different relationship type between each of the entities
// and it calculates a strength field as well based on relationship key results and some addtional
// business rules.
//
//
import relationship, header, doxie, doxie_crs, Doxie_Raw,
ut,iesp, BIPv2, topbusiness_services, relationshipIdentifier_services, BIPV2_Best,
SmartRollup, Location_Services, suppress, std;

EXPORT Report_Records := MODULE
EXPORT  GetReport(
                dataset(iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportBy) DS_dataInReportBy,
								boolean inc_neighbor,
								unsigned4 EndDate,
                doxie.IDataAccess mod_access
							) :=
FUNCTION

boolean do_mask_dob := mod_access.DOB_Mask != suppress.Constants.DateMask.NONE;

ds_input_withSeqNum := PROJECT(DS_dataInReportBy,
                             TRANSFORM( {unsigned2 seqNum; string50 role; Relationship.layout_GetRelationship.DIDs_Layout;
														             iesp.share.t_businessIdentity businessIDs;},
																	 SELF.seqNum := counter;
																	 //             ^^^^^^ this is not set by the
																	 //                    Search service but set here.
																	 //
																	 SELF.DID := (UNSIGNED6) LEFT.UNIQUEID;
																	 SELF.Role := LEFT.Role;
																	 SELF.BusinessIDs.Ultid := LEFT.BusinessIds.ULTID;
																	 SELF.BusinessIDs.orgid := LEFT.BusinessIDs.ORGID;
																	 SELF.BusinessIDs.SELEID := LEFT.BusinessIDs.SELEID;
																	 SELF := []
																	 ));

ds_input_linkidsForBipKey := PROJECT(DS_dataInReportBy,
																	TRANSFORM(bipv2.IDlayouts.l_xlink_ids,
                                    self.ultid := LEFT.businessIDs.ultid;
																		SELF.orgid := LEFT.BusinessIds.orgid;
																		SELF.seleid := LEFT.BusinessIDs.seleid;
																		SELF := []
																		))(seleid <> 0);
FETCH_LEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;
ds_bipContacts := TopBusiness_Services.Key_Fetches(ds_input_linkidsForBipKey,
                                    	FETCH_LEVEL,TopBusiness_Services.Constants.ContactsKfetchMaxLimit
																		).ds_contact_linkidskey_recs(contact_did <> 0);

ds_contactsRaw := dedup(ds_bipContacts(source <> 'D' and source <> '')
				, all, except dt_vendor_last_reported, dt_vendor_first_reported);
ds_contactsSlim := dedup(sort(ds_contactsRaw, ultid, orgid,seleid, contact_DID,-dt_last_seen_contact, -dt_first_seen_contact),
                              ultid, orgid, seleid, contact_did, dt_last_seen_contact, dt_first_seen_contact);


ds_input_didsForRelationshipKey := PROJECT(DS_dataInreportBy,
									 TRANSFORM( Relationship.layout_GetRelationship.DIDs_Layout,
									 SELF.DID := (UNSIGNED6) LEFT.UNIQUEID));

	RelativeFlag := TRUE;
	AssociateFlag := TRUE;
	AllFlag := TRUE; // getting all relationship types
 RelKeyFlag := IF(mod_access.isConsumer(), 'D2C', '');

// KEEP This documentation notes
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// DS_relationships DOCS: DID1 is original did input and DID2 is the result did if a relationship exists. /
//
// data returned from relationship key doesn't have person names in it just 'did' field.
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// just call this function with the did in this DS:  DS_input_didsForRelationshipKey
DS_relationships_Neutral := Relationship.proc_GetRelationshipNeutral(ds_input_didsForRelationshipKey,
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
																	,//Relationship.Layout_GetRelationship.TransactionalFlags_layout txflag = notx
                 RelKeyFLag
																	).Result;

DS_relationships:= Relationship.functions_getRelationship.convertNeutralToFlat_new(DS_relationships_Neutral);

dsrelativesDids := 	PROJECT(DS_relationships(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL and
                                             CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH) ,
                    TRANSFORM(Relationship.layout_GetRelationship.DIDs_Layout,
										  SELF.DID := LEFT.DID2;
											));
// 2nd pass only get relatives
ds_2ndDegreeRelatives := Relationship.proc_GetRelationshipNeutral(dsrelativesDiDs,
                                  TRUE, // relative Flag
																	TRUE, // associate flag // may switch this back.
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
																	,//Relationship.Layout_GetRelationship.TransactionalFlags_layout txflag = notx
                 RelKeyFlag
																	).Result(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL and
                                             CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH);

NamesAdded := PROJECT(DS_relationships,
									 TRANSFORM(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec,
														 SELF.title_str := Header.relative_titles.fn_get_str_title(LEFT.title);
														 SELF := LEFT,
														 SELF := []));

  relInfo := JOIN(ds_input_withSeqNum, NamesAdded,
	                    LEFT.DID = RIGHT.DID1,
											TRANSFORM(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec,
											SELF.SeqNum := LEFT.seqNum;
											SELF := RIGHT), LEFT OUTER);
  relInfoSortedTmp := 	SORT(relInfo,SeqNum,Total_Score);

	SecondDegreeRelativesTmp := JOIN(relInfoSortedTmp(TYPE = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL
	                               AND CONFIDENCE = RelationshipIdentifier_Services.Constants.HIGH),
	                                          ds_2ndDegreeRelatives,
	                      LEFT.DID2 = RIGHT.DID1,

												TRANSFORM(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec,
														SELF.SeqNum := LEFT.SeqNum;
														SELF.DID2 := RIGHT.DID2;
														SELF.DID1 := LEFT.DID1;
														tempTitle1 := Std.Str.ToUpperCase(Header.relative_titles.fn_get_str_title(RIGHT.title));
														tempTitle := Doxie_Raw.Constants.GetSecondDegRelation(LEFT.title,RIGHT.title);
														SELF.Title_str := Header.relative_titles.fn_get_str_title(tempTitle);
														SELF.TYPE := RIGHT.TYPE;
                            SELF.rel_dt_first_seen := Max(RIGHT.rel_dt_first_seen,LEFT.rel_dt_first_seen);
														SELF.rel_dt_last_seen :=  Max(RIGHT.rel_dt_last_seen, LEFT.rel_dt_last_seen);
														SELF.CONFIDENCE := RelationshipIdentifier_Services.Constants.HIGH;
														SELF := []));
                // remove the 1st degree relationship that have 0 for rel_dt_first_seen
	AllRelsTmp := RelInfoSortedTmp(rel_dt_first_seen <> 0) & SecondDegreeRelativesTmp;
  // separate out the personal related relationships and dedup out by did1/did2
	// NOTE 'cluster' (which is a field in the output of the Relationship.proc_GetRelationship call)
	//     being non null in sort ensures 1st degree relationships are kept before 2nd degree relationships.
	// and keep greatest dt_first_seen since currently relatives v3 key doesn't set rel_dt_*_seen for 2nd degree relationships
	allRelsPersonal := dedup(sort((AllRelsTmp)(type = RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL),
	                               seqNum,did1, did2,  if (confidence = RelationshipIdentifier_Services.Constants.HIGH, 0,1),
																 if (title_str <> 'Relative',0,1), if (title_str <> 'Associate',0,1),
							                   if (lname2 = '', 0,1), if (cluster <> '',0,1), -rel_dt_first_seen),
	                         seqNum,did1, did2);

	allRelsNonpersonal :=  dedup(sort((AllRelsTmp)(type <> RelationshipIdentifier_Services.Constants.RELTYPE_PERSONAL),
	                                 seqNum,did1, did2, title_str, if (type = '', 0, 1)),
	                        seqNum,did1, did2, title_str);
  secondDegreeRelatives := 	allRelsPersonal & allRelsNonpersonal;

  secondDegreeRelativeFinal := sort(secondDegreeRelatives, seqNum, total_score)(rel_dt_first_seen <> 0);
	                                                                            // ^^^ filter added cause
																																							// relatives key outputs 0 value sometimes
																																							// for this field.
   relInfoSorted := secondDegreeRelativeFinal;

// return neighbor information
// check option first and then only do this function
   ds_did_in := PROJECT(ds_input_didsForRelationshipKey, TRANSFORM(doxie.layout_references,
	                            SELF.did := (UNSIGNED6) LEFT.DID;
											 ));
	// neighbor functionality
	// use defined constant of Num of months back and trim to just YYYYMM format.
	NumMonthsBack := (UNSIGNED4) (ut.getDateOffset(RelationshipIdentifier_Services.Constants.MonthsBack)[1..6]);

	// new code add
	layout_neighbor := record
			dataset(doxie.layout_nbr_records) neighborRecs;
	end;
  // have to call function individually for each input DID.  Since neighbor call knocks out like addresses
	// so accumulate results in this project via the child ds
	nbr_res := project(ds_did_in, TRANSFORM(layout_neighbor,
		self.neighborRecs := doxie_crs.NeighborRecords(dataset([left.did],doxie.layout_references),
	                                             mod_access.dppa,
								                               mod_access.glb,
																							 mod_access.DataRestrictionMask,
								                               mod_access.ssn_mask)(mode = 'C' and dt_last_seen >= NumMonthsBack);
																						//	 ^^^ only use current neighbors
																			 )
	);
  // now rollup results and sum as we go into a single child DS and then project child DS into the neighbor layout
	ds_neighbor_set := PROJECT(ROLLUP(nbr_res,TRUE,TRANSFORM(layout_neighbor,
                        SELF.neighborRecs := LEFT.neighborRecs + RIGHT.neighborRecs;
												)).neighborRecs,
										TRANSFORM(doxie.layout_nbr_records,
										SELF := LEFT));

	ds_neighbor_set_final := if (inc_neighbor, ds_neighbor_set);
	ds_neighborsBaseLine := SORT(JOIN(ds_input_withSeqNum , ds_neighbor_set_final,
															LEFT.DID = RIGHT.base_DID,
															TRANSFORM({UNSIGNED2 seqNum; UNSIGNED6 InputDID;
															              STRING50 Role; RECORDOF(RIGHT);},
															SELF.seqNum := LEFT.seqNum;
															SELF.InputDID := LEFT.DID;
															SELF.Role := LEFT.ROLE;
															SELF := RIGHT;
															)),SeqNum);

     //**************ds_input_linkidsForBip already is set of just BIP linkids inputs (i.e. businesses only)
		   ds_seleidRelative_kfetch := BIPV2.Key_BH_Relationship_SELEID.kFetch(project(ds_input_linkidsForBipKey,
								       transform(BIPV2.Key_BH_Relationship_SELEID.l_kFetch_in,
											     self.seleid := left.seleid))
											 );

   ds_seleidRelative_kfetchSlim := project(ds_seleidRelative_kfetch,transform({unsigned6 Primaryseleid; unsigned6 Secseleid;
	                                                        unsigned4 dt_first_seen_track; unsigned4 dt_last_seen_track;},
																								self.PrimarySeleid := left.seleid1;
																								self.SecSeleid := LEFT.seleid2;
																								self := LEFT));

		 // *************

	 // the max size of ds_inputWithSeqNum is 8
	 //
  ds_neighbor_finalTmp := PROJECT(ds_input_withSeqNum, TRANSFORM(
		 RelationshipIdentifier_Services.Layouts.ReportRecordWithSeqNum,
		 SeqNo := LEFT.SeqNum;
		 Role := LEFT.Role;
		 SELF.SeqNum := Seqno;
		 InputDID := LEFT.DID;	 // used below several times within this project.
		 InputDID2 := LEFT.DID;

		       doxie.layout_references DIDXform() := TRANSFORM
					   SELF.DID := INPUTDID;
					 END;
		  DS_InputDID := dataset([DIDXform()]);
			doxie.mac_best_records(ds_input_withSeqNum, did,
												  ds_input_withSeqNumOut,mod_access.isValidDppa(),mod_access.isValidGlb(),,mod_access.DataRestrictionMask);

		 personInfo := JOIN(DS_inputDID,ds_input_withSeqNumOut,
		                    LEFT.DID = RIGHT.DID,TRANSFORM(RIGHT));

		 Ultid := LEFT.businessIds.ultid;
		 Orgid := LEFT.businessIds.orgid;
		 Seleid := LEFT.businessIDs.SELEID;
		 //^^^^^^^^^^^^^^^^^^^^^^ this field is used later to exclude the particular primary entity
		 // from the secondaryEntitySet.

		 bipv2.idlayouts.l_xlink_ids BIPLXlink () := TRANSFORM
					SELF.ultid := ultid;
					SELF.orgid := orgid;
					SELF.seleid := seleid;
					self := [];
		 END;
		 l_Xlink_ids := dataset([BIPLxlink()]);
		 BestInfo := BIPV2_Best.Key_LinkIds.KFetch(l_xlink_ids,FETCH_LEVEL,,,,
										TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit)(proxid = 0);

		 iesp.RelationshipIdentifierReport.t_RelationshipIdentifierReportRecord PrimaryEntity_XFORM() := TRANSFORM
													  SELF.PrimaryEntity.UniqueID := (STRING16) InputDID;
														SELF.primaryEntity.businessIDs.ultid := ultid;
														SELF.primaryEntity.businessIDS.orgid := orgid;
														SELF.primaryEntity.businessIDs.seleid := seleid;
														SELF.PrimaryEntity.tin := if (seleid <> 0, bestInfo.company_fein[1].company_fein, '');
														SELF.PrimaryEntity.Role := Role;
														SELF.PrimaryEntity.companyName := if (seleid <> 0, BestInfo.company_name[1].Company_name, '');

							              // set HRI's here.

														 Location_Services.Layouts.PropCleanNameAddr xformHRIAddress_XFORM() := TRANSFORM
														    SELF.prim_range := if (inputDID <> 0, personInfo[1].prim_range,BestInfo.company_address[1].company_prim_range);
															  SELF.predir := if (inputDID <> 0, personInfo[1].predir, BestInfo.company_address[1].company_predir);
															  SELF.prim_name := if (inputDID <> 0, personInfo[1].prim_name, BestInfo.company_address[1].company_prim_name);
																SELF.suffix := if (inputDID <> 0, personInfo[1].suffix, BestInfo.company_address[1].company_addr_suffix);
																SELF.postdir := if (inputDID <> 0, personInfo[1].postdir, BestInfo.company_address[1].company_postdir);
																SELF.unit_desig := if (inputDID <> 0, personInfo[1].unit_desig, BestInfo.company_address[1].company_unit_desig);
																SELF.sec_range := if (inputDID <> 0, personInfo[1].sec_range,	BestInfo.company_address[1].company_sec_range);
																SELF.p_city_name := IF (inputDID <> 0, personInfo[1].city_name, BestInfo.company_address[1].company_p_city_name);
																SELF.v_city_name := IF (inputDID <> 0, personInfo[1].city_name, BestInfo.company_address[1].address_v_city_name);
																SELF.st := if (inputDID <> 0, personInfo[1].st, BestInfo.company_address[1].company_st);
																SELF.zip := if (inputDID <> 0, personInfo[1].zip,  BestInfo.company_address[1].company_zip5);
																SELF.zip4 := if (inputDID <> 0, personInfo[1].zip4, BestInfo.company_address[1].company_zip4);
														    SELF := [];
																END;
                            tmpgetAddressHRIParam := DATASET([ xformHRIAddress_XFORM() ]);
														AddressInfoHRI := Location_Services.Functions.GetAddressHRI(tmpgetAddressHRIParam);
                            tmpHRIs := PROJECT(AddressinfoHRI[1].HRI_Address,
														      TRANSFORM(iesp.share.t_riskindicator,
																	          SELF.riskCode := left.HRI;
																						SELF.Description := left.desc;
														                ));
														tmpAddressInfo := IESP.ECL2ESP.setAddressEx(
																	AddressInfoHRI[1].prim_name,AddressInfoHRI[1].prim_range,AddressInfoHRI[1].predir,AddressInfoHRI[1].postdir,
																	AddressInfoHRI[1].suffix,AddressInfoHRI[1].unit_desig,AddressInfoHRI[1].sec_range,AddressInfoHRI[1].v_city_name,
																	AddressInfoHRI[1].st,AddressInfoHRI[1].zip,AddressInfoHRI[1].zip4,'',
																	                              //countyName,
																																'','','','',tmpHRIs);
                             SELF.Primaryentity.address  :=	tmpAddressInfo;

														         IESP.share.t_identity PrimEntIdent_xform() := TRANSFORM
														                         SELF.uniqueID := (STRING12) InputDID;
																										 SELF.Name := iesp.ecl2esp.setName(personInfo[1].fname,
																										           personINfo[1].mname,
																															 personInfo[1].lname,
																															 personInfo[1].name_suffix,
																															 personINfo[1].Title);
                                                     tmpSSN := personInfo[1].SSN;;
                                                     SELF.SSNInfo.SSN := tmpSSN;
																										 // function signature(UNSIGNED6 did,STRING9 ssn,STRING1 valid,BOOLEAN includeHRI)
																										 tmpSSNInfoEx := SmartRollup.fn_smart_getSsnMetadata(inputDID, tmpSSN,'Y',TRUE);
																										 SELF.SSNInfoEx := PROJECT(tmpSSNInfoEx,
																										 TRANSFORM(iesp.share.t_SSNInfoEx,  SELF := LEFT))[1];

																										   Self.DOB  := if (do_mask_dob,
																							iesp.ECL2ESP.ApplyDateMask (IESP.ecl2esp.toDate(personInfo[1].dob),
																				                           mod_access.DOB_Mask),
																													IESP.ecl2esp.toDate(personInfo[1].dob));

																										 SELF.DOD := iesp.ECL2ESP.ToDate((UNSIGNED4)personInfo[1].dod);
																										 SELF := []
																										 END;

                            SELF.PrimaryEntity.Identity := DATASET([ PrimEntIdent_xform() ])[1];


                              relationshipIdentifier_services.layouts.Phone_layout xformPhone () := TRANSFORM
														                     SELF.phone := IF (InputDID <> 0, personInfo[1].phone,
																								                     // ^^^^^^ tmp field from above
																								                    IF (seleid <> 0, BestInfo.company_phone[1].company_phone, ''));
																																		  //^^^^^^^ tmp field from above
                                                 self.zip := AddressInfoHRI[1].zip;
																								 self.lname := personInfo[1].lname;
																								 self.prim_range := AddressInfoHRI[1].prim_range;
																								 self.Prim_name := AddressInfoHRI[1].prim_name;
																								 self.sec_range := AddressInfoHRI[1].sec_range;
																								 self.st := addressInfoHRI[1].st;
																								 self.predir := addressInfoHRI[1].predir;
																								 self.postdir := addressInfoHRI[1].postdir;
																								 SELF.HRI_phone := [];
														                     SELF := [];
																								 END;
																								 tmpPhone := dataset([ XFormPhone() ]);
                           tmpPhoneHRI := relationShipIdentifier_services.functions.GetPhoneHRI(tmpphone);
                           tmpPhoneMetadata := relationShipIdentifier_services.functions.AddPhoneMetaData(
													                   PROJECT(tmpphone,
																						 TRANSFORM(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord,
																						              SELF.accountNumber := '1'; // fill in values for function
																													SELF.sequenceNumber := 1; // fill in values for function
																													SELF.phoneInfo.Phone10 := tmpphone[1].Phone;
																													SELf := [];
																													)), mod_access);
                              SELF.Primaryentity.ListingType := tmpPhoneMetadata[1].listingType;
                              SELF.PrimaryEntity.ActiveEDA := tmpPhoneMetadata[1].ActiveEDA;
															SELF.primaryEntity.Disconnected := tmpPhoneMetadata[1].disconnected;
                            	tmpPhoneAddMetadataWireless := project(tmpPhoneMetadata,transform({recordof(left);
		                                                                        string3 timeZone;
		                                                                        },
		                                          self.wirelessIndicator := '';
																							self.TimeZone := '';
		                                          self := left));

															TopBusiness_Services.Macro_AppendWirelessIndicator(tmpPhoneAddMetadataWireless,
		                                                   tmpPhoneAddMetadataWirelessOut,phoneInfo.phone10);
                               SELF.primaryEntity.wirelessIndicator := tmpPhoneAddMetaDataWIrelessOut[1].WirelessIndicator;


                            SELF.primaryEntity.Phone := PROJECT(tmpphoneHRI,
														                             TRANSFORM(iesp.share.t_phoneInfoEx,
																																			self.Phone10						:=LEFT.phone;
																																			self.PubNonpub					:='';
																													            self.ListingPhone10			:='';
																														          //self.ListingName				:= LEFT.Listed_Name;
																														// self.TimeZone						:=r.timezone;
																														// self.ListingTimeZone		:='';
																															hri_phones 							:= project(LEFT.hri_phone,
																												transform(iesp.share.t_RiskIndicator,
																														self.RiskCode := left.hri,
																														self.Description := left.desc));
																	self.HighRiskIndicators := choosen(hri_phones, iesp.Constants.MaxCountHRI);
																	self := []))[1];

														// call function to return midex licensees.
														// if did passed in has a real estate license then the lienseType is returned
														// which is a flag for GUI side to insert link to midex login screen.
														PossibleMidexreportStructures :=
														    RelationshipIdentifier_Services.Functions.getMidexLicenseType(
														                   inputDID,l_xlink_ids, mod_access);

														SELF.Primaryentity.MidexlicenseTypes := choosen(Dedup(PROJECT(PossibleMidexreportStructures,
																									 TRANSFORM(IESP.share.t_stringarrayItem,
																									    SELF := LEFT)),all),
																											iesp.constants.RelationshipIdentifier.MAX_COUNT_RELATIONSHIP_MIDEX_LICENSES);
                          SELF := [];
											END;
					self.PrimaryEntity := DATASET([ PrimaryEntity_XFORM() ])[1].PrimaryEntity;


		 secondaryEntitys := JOIN(ds_input_WithSeqNum, ds_input_WithSeqNumOut,
		                           LEFT.DID = RIGHT.DID,
		                       TRANSFORM(RelationshipIdentifier_Services.Layouts.SecondaryEntity_withDID,

																	 SELF.DID := LEFT.DID;
																	 SELF.UNIQUEID := (STRING15)LEFT.DID;
																	 SELF.Role := LEFT.ROLE;
																	 SELF.identity.SSNInfo.ssn := RIGHT.SSN;
																	 SELF.Identity.SSNInfoEX.ssn := RIGHT.SSN;

																	 SELF.Identity.name := iesp.ecl2esp.setName(right.fname,
																										           right.mname,
																															 right.lname,
																															 right.name_suffix,
																															 right.Title);

                                   self.relationshipTypes := [];
                                   SELF := LEFT;
																	 SELF := [];
																	 ), LEFT OUTER); // LEFT OUTER NEEDED HERE TO KEEP BUSINESS ENTITIES
       SecondaryEntitysWithBusinfo := PROJECT(secondaryEntitys,
			          TRANSFORM(RelationshipIdentifier_Services.Layouts.SecondaryEntity_withDID,

			                     ultidSecondaryEntity  := LEFT.businessIDs.ultid;
													 orgidSecondaryEntity := LEFT.businessIDs.orgid;
													 SELEIDSecondaryEntity  := LEFT.businessIDs.SELEID;

													           bipv2.idlayouts.l_xlink_ids  l_xlink_ids_SecondaryEntitys_XFORM() := TRANSFORM
																						SELF.ultid := ultidSecondaryEntity;
																						SELF.orgid := orgidSecondaryEntity;
																						SELF.seleid := seleidSecondaryEntity;
																						self := [];
																						END;

																		l_xlink_idsSecondaryEntitys := dataset([ l_xlink_ids_SecondaryEntitys_XFORM() ]);
																			BestInfoSecEnt := BIPV2_Best.Key_LinkIds.KFetch(l_xlink_idsSEcondaryEntitys,FETCH_LEVEL,,,,
																			TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit)(proxid = 0);
                            self.companyName := if (SELEIDSecondaryEntity <> 0, BestInfoSecEnt.company_name[1].Company_name,'');
														SELF.tin := if (SELEIDSecondaryEntity <> 0, bestInfoSecEnt.company_fein[1].company_fein,'');
														SELF.businessIds.ultid := ultidSecondaryEntity;
														SELF.businessIDs.orgid := orgidSecondaryEntity;
														SELF.businessIds.seleid := seleidSecondaryEntity;
														self.relationshipTypes := [];
														SELF := LEFT));

				SecondaryEntitysFinal := SecondaryEntitysWithBusinfo(InputDID <> DID OR SELEID <> businessIDS.seleid);
     // first get possible neighbors for this particular sequence #.
		    // then use that as its passed through the project.
		 neighborInd := ds_neighborsBaseline(seqNum = seqNo);
     seleidRelInd := ds_seleidRelative_kfetchSlim(PrimarySELEID = Seleid);	// primaryseleid is field within DS seleid varies as we go thru project
     self.secondaryEntities := Choosen(PROJECT(secondaryEntitysFinal,
						TRANSFORM(RelationshipIdentifier_Services.Layouts.SecondaryEntityWithNeighbor,
																	secEntityDID := LEFT.DID;

																	 neighborhoodData := NeighborInd(DID = LEFT.DID);
																	  // this filter                ^^^^^^ has to be did value from neighborInd and not base_did
																	 isNeighbor := exists(neighborhoodData);
																	 seleidRelData := seleidRelIND(secSeleid = LEFT.businessIds.SELEID);
																	 isSeleIdRel := exists(seleidRelData);

																	 //// this block is used to ensure that filter by AsOfDate later in functions attr
																	 // does not leave 1 entity as being a neighbor in 1 direction but not in the other
																	 // in a person and person neighbor relationship
																	 // this logic identifies date in time when people existed
																	 // at this address i.e. when neighbor relationship started
																	 // neighborHoodData and ds_neighborBaseLine have 1st dt_first_seen in the column so no need to sort
																	 // since its just 1 line from which to grab dt_last_seen value from

																	 dt_first_seenPrimNeighbor := PROJECT( neighborhoodData,
                                                                    TRANSFORM({unsigned4 dt_first_seen;}, self := LEFT))[1].dt_first_seen;
																	 dt_first_seenSecNeighbor := PROJECT(ds_neighborsBaseLine(base_did = secENtityDID and did = InputDID2),
																	                                  TRANSFORM({unsigned4 dt_first_seen;}, self := left))[1].dt_first_seen;

																	  // now get max of 2 dt_first_seen so as to ensure that dt_first_seen is of this neighbor relationship
																		// so that of AsOfDate filter is used in functions to trim all relationshipTypes
																		// it will not trim just 1 person entity in a neighbor relationship but do both at the same time
																		//
																	 dt_first_seen_at_addr := MAX(dt_first_seenPrimNeighbor,dt_first_seenSecNeighbor);

																	  dt_first_seen_at_addrIESPDATE := iesp.ecl2esp.toDate(dt_first_seen_at_addr * 100);

																	 // This block exists cause neighbor data is YYYYMM

																    neighbor_dt_last_seen := PROJECT(Neighborhooddata, TRANSFORM({string date_last_seen;},
																               self.date_last_seen := (string) LEFT.dt_last_seen;))[1].date_last_seen;
                                   neighbor_dt_last_seenNum := (unsigned4) neighbor_dt_last_seen;
                                   neighbor_dt_last_seen_final := if (length(neighbor_dt_last_seen) = 6,
																	                        neighbor_dt_last_seenNum * 100,
																															neighbor_dt_last_seenNum);
                                   neighbor_dt_first_seen := PROJECT(Neighborhooddata, TRANSFORM({string dt_first_seen;},
																                      self.dt_first_seen := (string) LEFT.dt_first_seen;))[1].dt_first_seen;
                                   neighbor_dt_first_seenNum := (unsigned4) neighbor_dt_first_seen;
                                   neighbor_dt_first_seen_final := if (length((string) neighbor_dt_first_seen) = 6,
																	                        neighbor_dt_first_seenNum * 100,
								                                               neighbor_dt_first_seenNum);

																	 neighbor_dt_first_seenTmp := iesp.ecl2esp.toDate(neighbor_dt_first_seen_final);
																	 // set special case here so as later triming doesn't just take out 1 person
																	 // since neighbor relationship needs to have both person's at any given timestamp.
																	 self.neighbor_dt_first_seen := if (isNeighbor,dt_first_seen_at_addrIESPDATE,neighbor_dt_first_seenTmp );
																	                               //              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
																																                 // this value set from above.
																	 self.neighbor_dt_last_seen := iesp.ecl2esp.toDate(neighbor_dt_last_seen_final);

																   SELF.IsNeighbor := isNeighbor;

                                     iesp.relationshipidentifierreport.t_relationshipIdentifierReportRelationshipType
																		          relationshipTypes_XFORM() := TRANSFORM
																	              SELF.RelationshipType := if (isSELEIDrel,RelationshipIdentifier_Services.Constants.SELEIDREL,'');
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
                                      SELF.RelationshipTypes := DATASET([ relationshipTypes_XFORM()] );

																			SELF := LEFT;
																			self := [];
																								)),
																								iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS -1 );
   ));




		 // now take DS and project in the relationship possiblities from relationship key
		 // triming the possibilities from the join to relationship key in each progression
		 // of the project.  All the while hitting the function to set the relationships
		 //

		 Ds_relationship_tmp :=
		   PROJECT(ds_neighbor_finalTmp,
			   TRANSFORM(RelationshipIdentifier_Services.Layouts.ReportRecordWithSeqNumIESP,
					PrimaryEnt_UniqueId := (UNSIGNED6) LEFT.primaryEntity.Uniqueid;
				  PrimaryEnt_Seleid := LEFT.primaryEntity.BusinessIds.Seleid;
					PrimaryEnt_orgid := LEFT.PrimaryEntity.BusinessIDs.Orgid;
					PrimaryEnt_ultid := LEFT.PrimaryEntity.BusinessIds.Ultid;
					seqno := LEFT.seqNum;
					// important to trim here by seqNum...and only get the did's pertaining to
			   // that particular relationship with DID2 being base did in relationship key results
		      RelationShipRecstrimmed := relInfoSorted(DID1 = PrimaryEnt_UniqueID and SeqNum = SeqNo);
					BipContactSlim := if (primaryEnt_seleid <> 0, ds_contactsSlim(ultid = PrimaryEnt_ultid AND orgid = PrimaryEnt_orgid AND
					                                     seleid = PrimaryEnt_seleid), ds_contactsSlim);

					NeighborRelationship := PROJECT(LEFT.SecondaryEntities, TRANSFORM(RECORDOF(LEFT),

														                                SELF := LEFT,
																														));
					self.SecondaryEntities :=  Choosen(PROJECT(NeighborRelationship,
						  TRANSFORM(iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportSecondaryEntity,
							  SecondaryEnt_UniqueID := (UNSIGNED6) LEFT.UniqueID;
								secondaryEnt_seleid := LEFT.businessIDs.seleid;
								isNeighbor := LEFT.IsNeighbor;
								isSELEidRel := exists(LEFT.relationshipTypes(relationshipType = RelationshipIdentifier_Services.Constants.SELEIDREL));
								seleidRel_dt_first_seen := if (isSELEidRel, (unsigned4) iesp.ecl2esp.t_DateToString8(LEFT.RelationshipTypes[1].relationshipfirstseenDate),
								                              0
																							);
                seleidRel_dt_last_seen := if (isSELEidRel, (unsigned4) iesp.ecl2esp.t_DateToString8(LEFT.RelationshipTypes[1].relationshiplastseenDate),
								                              0
																							);

								neighbor_dt_first_seen := (unsigned4) iesp.ecl2esp.t_DateToString8(left.neighbor_dt_first_seen);
								neighbor_dt_last_seen := (unsigned4) iesp.ecl2esp.t_DateToString8(left.neighbor_dt_last_seen);
						   // function call will return a set of defined relationship types based
							// on logic.
							  relationshipTypes :=
								  RelationshipIdentifier_Services.Functions.setRelationshipType(
									isSeleidRel,
									seleidRel_dt_first_seen,
									seleidRel_dt_last_seen,
									isNeighbor,
									neighbor_dt_first_seen,
									neighbor_dt_last_seen,
									PrimaryEnt_uniqueID,
									PrimaryEnt_Seleid,
									SecondaryEnt_uniqueID,
									SecondaryEnt_seleid,
									seqno,
									RelationshipRecsTrimmed,
								  BipContactSlim,
									EndDate
									);
									// transform to project  out the 'strenth' field
									// since all fields defined in
									// RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength
									// are same as
									// iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportRelationshipType
									// just self := left is necessary.
                  //
							  self.countRelTypes := count(relationshipTypes(relationshipType <> RelationshipIdentifier_Services.Constants.NORELATIONSHIPFOUND));
								SELF.RelationshipTypes := choosen(dedup(
								             PROJECT(relationshipTypes,
								 TRANSFORM( iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportRelationshipType,
								     SELF.relationshipfirstseenDate := iesp.ecl2esp.toDate(left.rel_dt_first_seen);
										 self.relationshiplastseenDate := iesp.ecl2esp.toDate(left.rel_dt_last_seen);
										 self.relationshipType := if (left.RelationshipType = RelationshipIdentifier_Services.Constants.NODISPLAYFLAG,
										                                    '', left.RelationshipType); // catch all
								   SELF := LEFT)),all) , iesp.constants.RelationshipIdentifier.MAX_COUNT_RELATIONSHIP_TYPES);
								SELF.UniqueID := LEFT.UNIQUEID;
								SELF.Identity.UniqueID := (STRING12) LEFT.UNIQUEID;
								// relationship types contains same confidence (aka. field name strength) value
								// in each row as already set previously
								// so just grab value of the 1st row of DS
								SELF.relationshipStrength := PROJECT(relationshipTypes,TRANSFORM({string20 s;},
																					 self.s := left.strength))[1].s;

                SELF.NumberOfSources := if (exists(relationshipTypes(Strength = RelationshipIdentifier_Services.Constants.LOW)),
								                           0,
								                           count(relationshipTypes)
																					 );

								SELF := LEFT;
								SELF := [])
								), iesp.constants.RelationshipIdentifier.MAX_COUNT_SEARCH_MATCH_RECORDS -1 );
           SELF.PrimaryEntity.totalRelationshipCount := SUM(SELF.SecondaryEntities, countRelTypes);
					 SELF := LEFT;
					 SELF := [];
		       ));

// debug
		// output(ds_relationships, named('ds_relationships'));
		// output(ds_2ndDegreeRelatives, named('ds_2ndDegreeRelatives'));
		// output(NamesAdded, named('NamesAdded'));
		// output(relInfo, named('relInfo'));
		// output(relInfoSortedTmp, named('relInfoSortedTmp'));
		// output(SecondDegreeRelativesTmp,named('SecondDegreeRelativesTmp'));
		// output(AllRelsTmp, named('AllRelsTmp'));
		// output(allRelsPersonal, named('allRelsPersonal'));
		// output(allRelsNonPersonal, named('allRelsNonPersonalPersonal'));
		// output(SecondDegreeRelatives, named('SecondDegreeRelatives'));
		// output(secondDegreeRelativeFinal, named('secondDegreeRelativeFinal'));
		// output(ds_relationship_tmp, named('ds_relationship_tmp'));

    // output(relInfoSorted, named('relInfoSorted'));
	  // output(ds_neighbor_set, named('ds_neighbor_set'));
	  // output(ds_neighborsBaseLine, named('ds_neighborsBaseLine'));
		//output(ds_neighborsBaselineSlimByDate, named('ds_neighborsBaselineSlimByDate'));
    //output(ds_neighbor_finalTmp, named('ds_neighbor_finalTmp'));

// debug end

result := PROJECT(Ds_relationship_tmp,
        TRANSFORM(iesp.RelationshipIdentifierReport.t_relationshipIdentifierReportRecord,
				  tmpSecondaryEntitys := project(LEFT.secondaryEntities,
					                     TRANSFORM(iesp.relationshipidentifierreport.t_relationshipIdentifierReportSecondaryEntity,
															 SELF := LEFT));
						Suppress.MAC_Mask(tmpSecondaryEntitys, tmpSecondaryEntitysMasked, identity.ssnInfo.SSN, null, true, false, maskVal:=mod_access.ssn_mask);
						Suppress.MAC_Mask(tmpSecondaryEntitysMasked, tmpSecondaryEntitysMasked2, identity.ssnInfoEx.SSN, null, true, false, maskVal:=mod_access.ssn_mask);
						self.SecondaryEntities := PROJECT(tmpSecondaryEntitysMasked2, TRANSFORM(LEFT));
				  SELF := LEFT));
  Suppress.MAC_Mask(result, resultMasked, PrimaryEntity.identity.ssnInfo.SSN, null, true, false, maskVal:=mod_access.ssn_mask);
	Suppress.Mac_mask(resultMasked, resultMasked2, primaryEntity.Identity.ssnInfoEx.SSN, null, True, false, maskVal:=mod_access.ssn_mask);

 return(resultMasked2);
END; // function
END; // module