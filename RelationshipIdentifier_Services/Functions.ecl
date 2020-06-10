import bipv2, didville, doxie, dx_Gong, iesp, MIDEX_Services, relationshipIdentifier_services, STD, Suppress;
EXPORT Functions := MODULE

  // this function calls the person search to find possible DID's.
	EXPORT PersonSearch( dataset(DidVille.Layout_Did_OutBatch) ds_personSearchInput) := FUNCTION
										dedup_results_batch := FALSE;
										// fuzzymatch is deprecated so just setting to null here
										fuzzymatch := '';
										didville.MAC_DidAppend(ds_personSearchInput,ds_PersonSearchResults,dedup_results_Batch,fuzzymatch);

	RETURN(ds_PersonSearchResults(score >= RelationshipIdentifier_Services.Constants.LOWERLIMIT));
	END;

	// function just returns Phone number HRI indicators.
	EXPORT getPhoneHRI(dataset(relationshipIdentifier_services.layouts.Phone_layout) in_phone) := FUNCTION
			maxHriPer_value	:= iesp.Constants.MaxCountHRI;
			doxie.mac_addHRIPhone(in_phone,TmpPhoneHRI);
			return(tmpPhoneHRI);
	END;

  EXPORT ResolveResults(dataset(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord) in_recs) :=
						FUNCTION
						  // this function sets the errorMessage and the two boolean fields: NeedsResolution and ReturnRecsExceeded
							// this is used by the NON batch search (GUI) only
							// functionality that it provides is as follows:
						  // 1.figures out which recs out of each acctno have more than 1 sequenceNumber meaning that particular
							// input has more than 1 return result and filter out the accountNumber (i.e. entity #) for that gruop.
							// and sets the boolean accordingly.
							//
							// 2. also figures out if there are too many recs returned (thus the 6 value filter as five is limit).
							//
							// 3.  Also figures out if 0 results returned for a particular row that has just 1 sequenceNumber # and
							//     sets an error message for that row accordingly.
							//
							// sequenceNumber = 2 means there are more than 1 result returned for a particular input criteria.
							// 6 = iesp.Constants.RELATIONSHIPIDENTIFIER.MAX_COUNT_MATCH_RECORDS +1;

						  unresolvedAcctnos :=  PROJECT(In_recs(sequenceNumber = 2),
																								TRANSFORM({STRING20 acctno;},
																																SELF.acctno := LEFT.accountNumber));

              tooManyRecsAcctno := 	PROJECT(In_recs(sequenceNumber = 6),
							                                       TRANSFORM({STRING20 Acctno;},
																																SELF.acctno := LEFT.accountNumber));

               recsWithBoolean  := PROJECT(in_recs, TRANSFORM(RECORDOF(LEFT),
																			  NeedsResolution := exists(unresolvedAcctnos(ACCTNO = LEFT.accountNumber));
                                       ReturnRecsLimitExceeded :=  exists(TooManyRecsAcctno(acctno = LEFT.accountNumber));


                                       ErrorMessage := IF ( (~(NeedsResolution)) AND (~(ReturnRecsLimitExceeded)) AND
																			                              (
																																	   // no businesses found
																			                              (LEFT.individualOrBusiness = RelationshipIdentifier_Services.Constants.BUSINESS

																																		AND LEFT.companyname = '' AND LEFT.address.state = '' AND LEFT.sequenceNumber = 0)
																																	   OR  // no person entries found
																																		 (LEFT.individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL

																																		 AND LEFT.ContactInfo.Name.Last = '' AND LEFT.address.state = '' AND LEFT.sequenceNumber = 0)

																																	 ),
																																		RelationshipIdentifier_Services.Constants.NOENTITIESFOUND,
																																	 if (ReturnRecsLimitExceeded, RelationshipIdentifier_Services.Constants.MOREINFOREQUIRED,'')
																																	);
                                       SELF.ErrorMessage := ErrorMessage;
																			 SELF.ReturnRecordsLimitExceeded := ReturnRecsLimitExceeded;
																			 // need to set these two fields in structure if the boolean
																			 // is set.
																			 SELF.accountNumber := LEFT.accountNumber;
																			 SELF.Role := LEFT.role;
																			 SElF.IndividualOrBusiness := LEFT.individualOrBusiness;
																			 SELF.needsResolution := length(errorMessage) > 0 OR NeedsResolution;
																			 SELF := IF (~(ReturnRecsLimitExceeded), LEFT);
                                       ));


						   RecsWithBooleanDedup := DEDUP(recsWithBoolean,All);
							 // now go through and remove "empty" rows that don't have an error message in them

							 RecsWithBooleanFinal := RecsWithBooleanDedup(
							                              (individualOrBusiness = RelationshipIdentifier_Services.Constants.INDIVIDUAL and uniqueid <> '')
																						OR
																						// assuming good rows for business entities have at least cname/city/state
							                              (IndividualOrBusiness = RelationshipIdentifier_Services.Constants.BUSINESS AND trim(companyname,left,right) <> '' AND
																						       trim(address.city,left,right) <> ''  AND trim(address.state,left,right) <> '' )
																									 OR
																						 (trim(ErrorMessage,left,right) <> '') OR

																									 // these 3 conditionals take care of empty business rows of data based in that we want to
																									 // remove rows with null values in cname/city/state
																									 // the needsResolution boolean ensures that we don't remove a single row if its the ONLY result
																									 // for a particular input search terms.
																									 (needsResolution AND uniqueid <> '') OR
																									 (needsResolution AND CompanyName <> '' AND
																									            address.city <> '' and address.state <> '') OR
																									 (needsResolution AND ErrorMessage <> '')
																						);


					// output(in_recs, named('in_recs'));
						// output(tooManyRecsAcctno, named('tooManyRecsAcctno'));
					  //output(unresolvedAcctnos, named('unresolvedAcctnos'));

						 // output(recsWithBoolean, named('recsWithBoolean'));
						// output(RecsWithBooleanDedup , named('RecsWithBooleanDedup'));
					//output(RecsWithBooleanFinal, named('RecsWithBooleanFinal'));
						RETURN(recsWithBooleanFinal);
	 END;

	 EXPORT getMidexLicenseType(unsigned6 midexDID,
	                          dataset(BIPV2.IDlayouts.l_xlink_ids) midexlinkids,
	                          doxie.IDataAccess mod_access ) := FUNCTION
    // this function just inputs a DID or BIP linkids and looks for existence of a midex license type
		// that is classified as a 'real estate' license.  If a did is associated with a person that has a real
		// estate license or linkid for a business then that licese type(s) (1 or more) are returned and on the GUI side a link
		// is put into GUI screen for user to access the "midex" login screen.

		// need to check 3 different areas.  1) Professional licenses in mari and  2) public sanctn data and
		// 3) nonpub sanctn data as well.

		// Combine all results into common layout : MIDEX_Services.Layouts.LicenseReport_Layout
		// and then filter on the different license types that are all associated with
		// a 'real estate' license based on info obtained from data team.
		// showing particular did's here as wel

		// MIDEX_Services.Raw_Nonpublic.fn_get_nonPublicDidData(356828734)
		// MIDEX_Services.Raw_Public.fn_get_PublicSanctnDidData
		 // sample did = 969216909 showing realestate as a lic_type
		 FETCHLEVEL := BIPV2.IDconstants.Fetch_Level_SELEID;
	   mari_rid_did := MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_DidData(Midexdid);
		 mari_rid_bus := MIDEX_Services.Raw_ProfessionalLicenses.fn_get_ProfLicMari_LinkIdData(midexLinkids, mod_access, FETCHLEVEL);
		 mari_rid := if (midexDID <> 0, mari_rid_did,
		                   mari_rid_bus);
     // MIDEX_Services.Raw_ProfessionalLicenses.license.report_view.by_mari_num
     // filters depending on the search type (individual or company).
     // if no search type is passed, the function will not return any
     // records because the join condition will never be met.
     MidexSearchType := if (midexDID <> 0,
                            MIDEX_Services.Constants.INDIV_SEARCH,
                            MIDEX_Services.Constants.COMP_SEARCH);

		 MidexReportDataByMariNum :=
		           MIDEX_Services.Raw_ProfessionalLicenses.license.report_view.by_mari_num(mari_rid,mod_access,,MidexSearchType);

		 licenseListMari := Project(MidexReportDataBymariNum,TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                              self.licenses := left.licenses;
															self := []));

    //sancData := MIDEX_Services.Raw_Public.fn_get_PublicSanctnDidData(963597298);
		sancData_did := MIDEX_Services.Raw_Public.fn_get_PublicSanctnDidData(midexDID);
		sancData_bus := MIDEX_Services.Raw_Public.fn_get_PublicSanctnLinkIdData(midexlinkids, mod_access, FETCHLEVEL);
		sancdata := if (midexDID <> 0, sancData_did, sancData_bus);
		SancDataPayload := MIDEX_Services.Raw_Public.license.report_view.by_midex_rpt_num(sancData,mod_access);

		licenseListSanc := Project(SancDataPayload,TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                              self.licenses := left.licenses;
															self := []));

   // ** nonpublic:  did = 969216909 this one has PL as well.
	 // dataPermissionMask is needed for getting particular non pub licenses.
	  setNonpubAccess := MIDEX_Services.Functions.fn_GetNonPubDataSources(mod_access.dataPermissionMask);
	 	nonPubData_did := MIDEX_Services.Raw_NonPublic.fn_get_nonPublicDidData(midexDID);
		nonPubData_bus := MIDEX_Services.Raw_NonPublic.fn_get_nonPublicLinkIdData(midexlinkids, FETCHLEVEL);
		nonPubData := if (midexDID <> 0, nonPubData_did, nonPubData_bus);
		nonPubPayload := MIDEX_Services.Raw_NonPublic.license.report_view.by_midex_rpt_num(nonPubData,,,,,setNonPubAccess);

		licenseListNonPub := Project(NonPubPayload,TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                              self.licenses := left.licenses;
															self := []));

		licenseListPossible := PROJECT(licenseListMari + licenseListSanc  + licenseListNonPub,
		                        TRANSFORM({RECORDOF(LEFT); boolean KeepIt;},
		                        self.KeepIt :=
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'APPRAISAL',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'APPRAISER',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'BROKER',1) > 0)) OR
														 exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'CERTIFIED RESIDENTIAL',1) > 0)) OR
													exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'ESCROW',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'FINANCE LENDER',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'HOME INSPECTOR',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'INDIVIDUAL LOAN ORIGINATOR',1) > 0)) OR
														(exists(LEFT.licenses(STD.Str.Find(lic_type,
										'LENDER',1) > 0)) AND
														(~(exists(LEFT.licenses(STD.Str.Find(lic_type,
														        'CALIFORNIA FINANCE LENDER',1) > 0))))
																		)
																		OR
													exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'LICENSED LENDER',1) > 0)) OR
													exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'LICENSED REAL SALES',1) > 0)) OR
													(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'LIMITED',1) > 0)) AND		(~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'DOMESTIC LIMITED LIABILITY COMPANY',1) > 0))))
												               AND    (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'LIMITED LIABILITY COMPANY',1) > 0))))
												     ) OR

													(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'LOAN',1) > 0)) AND     (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'CONSUMER LOAN COMPANY',1) > 0))))
												      ) OR
													(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'MORTGAGE',1) > 0)) AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'MORTGAGE CLAUSE',1) > 0)))) AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'MORTGAGE LISTING SERVICE ID',1) > 0))))
																										AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
												'GEORGIA RESIDENTIAL MORTGAGE ACT',1) > 0))))
										        ) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'PRINCIPAL LENDING MANAGER',1) > 0)) OR
														exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'PROVISIONAL LOAN ORIGINATOR',1) > 0)) OR
														(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'REAL ESTATE',1) > 0)) AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
																							'DEPT OF REAL ESTATE',1) > 0))))
										        )
																						OR
										        exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'SALES ASSOCIATE',1) > 0)) OR
										(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'SALESPERSON',1) > 0)) AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'VEHICLE SALESPERSON',1) > 0))))
																						AND (~(exists(LEFT.licenses(STD.Str.Find(lic_type,
                    'INSURANCE-SALESPERSON',1) > 0))))
										 );
	                   // end of logic of OR and std.str.find on various license types
										        self.licenses := LEFT.licenses;
														self := []))(keepit);
														//         ^^^^^^^^^^
														//         Filter on the boolean to keep the particular license
														//         types.
		 licenseListFinal := PROJECT(licenseListPossible.licenses,
														  TRANSFORM(iesp.share.t_stringArrayItem,
														  self.value := left.lic_type;
															 self := []));
     // return either the list if it exists or an empty dataset
     res := if (exists(licenseListFinal),licenseListFinal,dataset([],iesp.share.t_stringArrayItem)
								);
		 RETURN(res);
	 END;

	 // this function sets the relationship types.
	 // it will also contain the business rules for determining the "strength" field (high, medium, low)
	 // this is used by both Relationship identifier batch service and the Relationship identifier
	 // report service.
	 //
   EXPORT setRelationshipType(
	       boolean isSeleidRel,
				 unsigned4 seleidRel_dt_first_seen,
				 unsigned4 SeleidRel_dt_last_seen,
				 Boolean isNeighbor,
	       unsigned4 neighbor_dt_first_seen,
				 unsigned4 neighbor_dt_last_seen,
	       unsigned6 didPrimaryValue,
				 unsigned6 seleidPrimaryValue,
				 unsigned6 SecondaryEntity_UniqueID,
				 unsigned6 SecondaryEntity_seleid,
				 unsigned2 seqNo,
	       dataset(RelationshipIdentifier_Services.Layouts.RelationshipFunctionRec) relRec,
				 dataset(RelationshipIdentifier_Services.Layouts.contactBIPLinkidsRec) contactBIPLinkidsRec,
				 unsigned4 endDate
				 ) := FUNCTION

         PrimaryisPerson := didPrimaryValue <> 0;
				 PrimaryisBusiness := seleidPrimaryValue <> 0;

				 // this assumes that contactBIPLInkidsRec contains BIP linkids rows where primary was a business
				 // so looking for
				 contacts_dsPrimaryBus := contactBIPLinkidsRec(contact_DID <> 0 AND  contact_did = SecondaryEntity_UniqueID);
				 contacts_dsPrimaryPerson := contactBIPLInkidsRec(contact_Did <> 0 and contact_did = didPrimaryValue
				                                and secondaryEntity_seleid = seleid);
				 isBusinessRelationshipBIPLinkidtoDID := if (PrimaryIsBusiness and SecondaryEntity_seleid =0,
				                                          exists(contacts_dsPrimaryBus), false);
				 isBusinessRelationshipDIDTOBipLInkID := if (PrimaryIsPerson and SecondaryEntity_seleid <> 0,
				                                          exists(contacts_dsPrimaryPerson), false);

			   isBusinessRelationship := isBusinessRelationshipBipLInkidToDid OR
				                           isBusinessRelationshipDidtoBipLInkid;

         emptyDS := dataset([], RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength);

         RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength
				         lowDS_xform() := TRANSFORM
									SELF.RelationshipType := RelationshipIdentifier_Services.Constants.NORELATIONSHIPFOUND;
									SELF.strength := RelationshipIdentifier_Services.Constants.LOW;
									SELF := [];
								 END;

         lowDS := DATASET([ lowDS_xform() ]);

         RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength
									 neighborXFORM() := TRANSFORM
											SELF.RelationshipType := 'Possible Neighbor';
											SELF.rel_dt_first_seen := neighbor_dt_first_seen;
										  SELF.rel_dt_last_seen := neighbor_dt_last_seen;
										  SELF.strength := RelationshipIdentifier_Services.Constants.MEDIUM;
										  SELF := [];
										END;

			   neighborRelDS := DATASET([ neighborXFORM() ]);

				 NeighborRecs := if (isNeighbor,  neighborRelDS, EmptyDS);

          RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength
					            SeleIDRelDS_XFORM() := TRANSFORM
											     	 SELF.RelationshipType := 'Connected Business';
														 SELF.rel_dt_first_seen := seleidRel_dt_first_seen;
														 SELF.rel_dt_last_seen := seleidRel_dt_last_seen;
														 SELF.strength := RelationshipIdentifier_Services.Constants.MEDIUM;
														 SELF := [];
                      END;

          SeleIDRelDS := DATASET([ SeleIDRelDS_XFORM() ]);
					seleidRelRecs := if (isSeleidRel, SeleIDRelDS, emptyDS);

		     BusRelationShipRecstmp := if (isBusinessRelationship and isBusinessRelationshipBIPLinkidtoDID,
																	PROJECT(
																					contacts_dsPrimaryBus,
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
				                                           SELF.RelationshipType := 'Business Associate';
																									 SELF.rel_dt_first_Seen := LEFT.dt_first_seen;
																									 SELF.rel_dt_last_seen  := LEFT.dt_last_seen;
																									 SELF.strength := RelationshipIdentifier_Services.Constants.HIGH;
																									 SELF := [])),
																	if (isBusinessRelationship and isBusinessRelationshipDIDTOBipLInkID,
																	   PROJECT(contacts_dsPrimaryPerson,
																	   TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
				                                           SELF.RelationshipType := 'Business Associate';
																									 SELF.rel_dt_first_Seen := LEFT.dt_first_seen;
																									 SELF.rel_dt_last_seen  := LEFT.dt_last_seen;
																									 SELF.strength := RelationshipIdentifier_Services.Constants.HIGH;
																									 SELF := [])),
																	emptyDS));
        					// product wants just 1 entry to show relationship
									// if there is not a businessrelationship then it will this will be an empty rec
         BusRelationShipRecs := if (isBusinessrelationship, choosen(sort(BusRelationShipRecstmp, -rel_dt_last_seen,record),1),
				   BusRelationShipRecstmp);

				 AircraftRelRecs := PROJECT(relRec(coaircraft_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-registered for aircraft';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         coAptRelRecs := PROJECT(relRec(coapt_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Roommate';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 BankRuptRelRecs := PROJECT(relRec(coBankruptcy_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a bankruptcy';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
        bBankRuptRelRecs := PROJECT(relRec(bcoBankruptcy_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Coappeared on a bankruptcy';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         // IMPORTANT LEGAL INFO
				 // *******************************
				 // NOTE the clClain_cnt and the two *ecrash_cnt* fields and copolicy_cnt are not
				 // LEGAL to use here in this program/project for counting or identifying relationships
				 // that status may change at a later date but including this note here
         coEnclarityRelRecs := PROJECT(relRec(coEnclarity_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possibly share office space';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

				 CoexperianRelRecs := PROJECT(relRec(coexperian_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a consumer inquiry';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

          CoForeclosureRelRecs := PROJECT(relRec(coForeclosure_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a foreclosure record';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         bCoForeclosureRelRecs := PROJECT(relRec(bcoForeclosure_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Coappeared on a public records filing';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          CoHabitRelRecs := PROJECT(relRec(coHabit_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Roommate';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          CoLienRelRecs := PROJECT(relRec(colien_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a lien filing';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          bCoLienRelRecs := PROJECT(relRec(bcolien_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Coappeared on a public records filing';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

         coMarriagedivoceRelRecs := 	 PROJECT(relRec(comarriagedivorce_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a marriage/divorce record';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          coPOBoxRelRecs := 	 PROJECT(relRec(copobox_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Roommate';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

          PropRelRecs := PROJECT(relRec(coproperty_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a property record';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				bPropRelRecs := PROJECT(relRec(bcoproperty_cnt > 0  and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Coappeared On Property Transaction';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         SSNRelRecs := PROJECT(relRec(cossn_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possibly associated to same SSN';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          TransunionRelRecs := PROJECT(relRec(coTransunion_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a consumer inquiry';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          VehicRelRecs := PROJECT(relRec(covehicle_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				 TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-registered for vehicle';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 uccRelRecs := PROJECT(relRec(coucc_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				    TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-named on a UCC filing';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          watercraftRelRecs := PROJECT(relRec(cowatercraft_cnt > 0 and did2 = SecondaryEntity_UniqueID),
				    TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Co-registered for watercraft';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         GrandParentRelRecs := PROJECT(relRec(title_str = 'Grandparent' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Grandparent';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          GrandFatherRelRecs := PROJECT(relRec(title_str = 'Grandfather' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Grandfather';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
           GrandMotherRelRecs := PROJECT(relRec(title_str = 'Grandmother' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Grandmother';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         GrandSonRelRecs := PROJECT(relRec(title_str = 'Grandson' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Grandson';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         GrandDaughterRelRecs := PROJECT(relRec(title_str = 'Granddaughter' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Granddaughter';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         GrandchildRelRecs := PROJECT(relRec(title_str = 'Grandchild' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Grandchild';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 FatherRelRecs :=  PROJECT(relRec(title_str = 'Father' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Father';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 MotherRelRecs := PROJECT(relRec(title_str = 'Mother' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Mother';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         ParentRelRecs := PROJECT(relRec(title_str = 'Parent' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Parent';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 WifeRelRecs := PROJECT(relRec(title_str = 'Wife' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Wife';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 HusbandRelRecs := PROJECT(relRec(title_str = 'Husband' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Husband';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         SpouseRelRecs := PROJECT(relRec(title_str = 'Spouse' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Spouse';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 DaughterRelRecs := PROJECT(relRec(title_str = 'Daughter' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Daughter';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												 SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
				 SonRelRecs := PROJECT(relRec(title_str = 'Son' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Son';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         BrotherRelRecs := PROJECT(relRec(title_str = 'Brother' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Brother';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          SisterRelRecs := PROJECT(relRec(title_str = 'Sister' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Sister';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          SiblingRelRecs := PROJECT(relRec(title_str = 'Sibling' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Sibling';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          ChildRelRecs := PROJECT(relRec(title_str = 'Child' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Child';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
           BrotherinLawRelRecs := PROJECT(relRec(title_str = 'Brother-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Brother-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

           SisterinLawRelRecs := PROJECT(relRec(title_str = 'Sister-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Sister-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

           MotherinLawRelRecs := PROJECT(relRec(title_str = 'Mother-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Mother-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

           FatherinLawRelRecs := PROJECT(relRec(title_str = 'Father-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Father-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         ParentinLawRelRecs := PROJECT(relRec(title_str = 'Parent-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Parent-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
          SiblinginLawRelRecs := PROJECT(relRec(title_str = 'Sibling-in-law' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Sibling-in-law';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

				 NephewRelRecs := PROJECT(relRec(title_str = 'Nephew' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Relative';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));
         NieceRelRecs := PROJECT(relRec(title_str = 'Niece' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Relative';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));


         RelativeRelRecs := PROJECT(relRec(title_str = 'Relative' and did2 = SecondaryEntity_UniqueID),
				                                      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
																							           SELF.RelationshipType := 'Possible Relative';
																												 SELF.rel_dt_first_seen := LEFT.rel_dt_first_seen;
																												 SELF.rel_dt_last_seen := LEFT.rel_dt_last_seen;
																												  SELF.strength := LEFT.confidence;
																												 SELF := LEFT));

				 isRelative     := exists(RelativeRelRecs);
				 ds_relResult1 :=  if (exists(NeighborRecs),NeighborRecs,emptyDS); // from neighborhood results.
         ds_relResult2 :=  if (exists(BusRelationShipRecs),BusRelationShipRecs ,emptyDS); // from bip contact linkids key
				 ds_relResult3 := if (exists(seleidRelRecs),seleidRelRecs, emptyDS);
				 // all these from relationship key
				 ds_relResult4 := if (exists(aircraftRelRecs),aircraftRelRecs, emptyDS);
				 ds_relResult5 := if (exists(coAptRelRecs),coAptRelRecs, emptyDS);
				 ds_relResult6 := if (exists(BankruptRelRecs),BankruptRelRecs, emptyDS);
				 ds_relResult7 := if (exists(bBankruptRelRecs),bBankruptRelRecs, emptyDS);

				 ds_relResult11 := if (exists(coEnclarityRelRecs), coEnclarityRelRecs, EmptyDS);
				 ds_relResult12 := if (exists(CoexperianRelRecs), CoexperianRelRecs, EmptyDS);
				 ds_relResult13 := if (exists(CoForeclosureRelRecs), CoForeclosureRelRecs, EmptyDS);
				 ds_relResult14 := if (exists(bCoForeclosureRelRecs), bCoForeclosureRelRecs, EmptyDS);
				 ds_relResult15 := if (exists(CoHabitRelRecs), CoHabitRelRecs, EmptyDS);
				 ds_relResult16 := if (exists(CoLienRelRecs), CoLienRelRecs, EmptyDS);
				 ds_relResult17 := if (exists(bCoLienRelRecs), bCoLienRelRecs, EmptyDS);
				 ds_relResult18 := if (exists(coMarriagedivoceRelRecs), coMarriagedivoceRelRecs, EmptyDS);
				 ds_relResult19 := if (exists(coPOBoxRelRecs),coPOBoxRelRecs, EmptyDS);

				 ds_relResult21 := if (exists(PropRelRecs),PropRelRecs, EmptyDS);
				 ds_relResult22 := if (exists(bPropRelRecs),bPropRelRecs, EmptyDS);
				 ds_relResult23 := if (exists(SSNRelRecs), SSNRelRecs, EmptyDS);
				 ds_relResult24 := if (exists(TransunionRelRecs),TransunionRelRecs, EmptyDS);
				 ds_relResult25 := if (exists(uccRelRecs),uccRelRecs, EmptyDS);
				 ds_relResult26 := if (exists(vehicRelRecs),vehicRelRecs, EmptyDS);
				 ds_relResult27 := if (exists(watercraftRelRecs),watercraftRelRecs, EmptyDS);

				 ds_relResult30 := if (exists(FatherinLawRelRecs), FatherinLawRelRecs, EmptyDS);
				 ds_relResult31 := if (exists(MotherinLawRelRecs), MotherinLawRelRecs, EmptyDS);
				 ds_relResult32 := if (exists(BrotherinLawRelRecs), BrotherinLawRelRecs, EmptyDS);
				 ds_relResult33 := if (exists(SisterinLawRelRecs), SisterinLawRelRecs, EmptyDS);
				 ds_relResult34 := if (exists(ParentinLawRelRecs), ParentinLawRelRecs, EmptyDS);
				 ds_relResult35 := if (exists(SiblinginLawRelRecs), SiblingInLawRelRecs, EmptyDS);

				 ds_relResult40 :=  if (exists(GrandParentRelRecs),GrandParentRelRecs,emptyDS);
				 ds_relResult41 :=  if (exists(GrandMotherRelRecs),GrandMotherRelRecs,emptyDS);
				 ds_relResult42 :=  if (exists(GrandFatherRelRecs),GrandFatherRelRecs,emptyDS);
				 ds_relResult43 :=  if (exists(GrandSonRelRecs), GrandSonRelRecs, emptyDS);
				 ds_relResult44 :=  if (exists(GrandDaughterRelRecs), GranddaughterRelRecs, emptyDS);
				 ds_relResult45 :=  if (exists(GrandChildRelRecs), GrandChildRelRecs, emptyDS);

				 ds_relResult46 :=  if (exists(FatherRelRecs),FatherRelRecs,emptyDS);
				 ds_relResult47 :=  if (exists(MotherRelRecs),MotherRelRecs,emptyDS);
				 ds_relResult48 :=  if (exists(ParentRelRecs),ParentRelRecs,emptyDS);
				 ds_relResult49 :=  if (exists(WifeRelRecs),WifeRelRecs,emptyDS);
				 ds_relResult50 :=  if (exists(HusbandRelRecs),HusbandRelRecs,emptyDS);
				 ds_relResult51 :=  if (exists(SpouseRelRecs), SpouseRelRecs, emptyDS);
				 ds_relResult52 :=  if (exists(DaughterRelRecs),DaughterRelRecs,emptyDS);
				 ds_relResult53 :=  if (exists(SonRelRecs),SonRelRecs,emptyDS);
				 ds_relResult54 :=  if (exists(BrotherRelRecs),BrotherRelRecs,emptyDS);
				 ds_relResult55 :=  if (exists(SisterRelRecs),SisterRelRecs,emptyDS);
				 ds_relResult56 :=  if (exists(SiblingRelRecs),SiblingRelRecs,emptyDS);
				 ds_relResult57 :=  If (exists(childRelRecs), childRelRecs, emptyDS);
				 ds_relResult59 :=  If (exists(NieceRelRecs), NieceRelRecs, emptyDS);
				 ds_relResult60 :=  if (exists(NephewRelRecs), NephewRelRecs, emptyDS);
				 //
				 ds_relResult58 :=  if (isRelative,RelativeRelRecs,emptyDS);
				 // some counts removed here till we figure out possible legal issue with using those counts.
         ds_relResultTotal := ds_relResult1 + ds_relResult2
				                   + ds_relResult3
				                    + ds_relResult4
				                     + ds_relResult5 + ds_relResult6 + ds_relResult7

														 + ds_relResult11 + ds_relResult12
														 + ds_relResult13 + ds_relResult14 + ds_relResult15 + ds_relResult16
														 + ds_relResult17 + ds_relResult18 + ds_relResult19

														+ ds_relResult21 + ds_relResult22 + ds_relResult23
															+ ds_relResult24 + ds_relResult25 + ds_relResult26 + ds_relResult27

															+ ds_relResult30 + ds_relResult31 + ds_relResult32 + ds_relResult33 + ds_relResult34 + ds_relResult35
															+ ds_relResult40 + ds_relResult41 + ds_relResult42 + ds_relResult43
															+ ds_relResult44 + ds_relResult45 + ds_relResult46 + ds_relResult47
															+ ds_relResult48 + ds_relResult49 + ds_relResult50 + ds_relResult51
															+ ds_relResult52 + ds_relResult53 + ds_relResult54 + ds_relResult55
															+ ds_relResult56 + ds_relResult57 + ds_relResult58 + ds_relResult59 + ds_relResult60;

         // this filters out any relationship types that are blank
				 ds_reltmpResultPre := ds_relResultTotal(relationshipType <> '');

				  ds_reltmpResultFilter := ds_relTmpResultPre(rel_dt_first_seen <= enddate);
					ds_reltmpResult :=   ds_relTmpResultFilter;
				 // BUSINESS RULE #1 IF entities are neighbors default strength to medium unless its
				 // already "HIGH" category then leave at HIGH.
				 // so implementing this here.

				 isHigh := exists(ds_reltmpResult(strength = RelationshipIdentifier_Services.Constants.HIGH));
         tmpIsMedium := exists(ds_reltmpResult(strength = RelationshipIdentifier_Services.Constants.MEDIUM));
         IsMedium :=  (~(isHigh)) and tmpIsMedium;

				 NoOtherRelationshipBetweenEntities := (~(isHigh)) and (~(isMedium)) and
				                                       (~(isBusinessRelationship)) and (~(isNeighbor)) and (~(isSeleidRel));

				 ds_relTmpResultOverrideNeighbor :=
				         if (isNeighbor and isHigh,
								    PROJECT(ds_reltmpResult,
								      TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
									      SELF.strength := RelationshipIdentifier_Services.Constants.HIGH;
										    SELF := LEFT)),
										if (isNeighbor,
												PROJECT(ds_reltmpResult,
													TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
														SELF.strength := RelationshipIdentifier_Services.Constants.MEDIUM;
														SELF := LEFT)),
												PROJECT(ds_reltmpResult,
													TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
														SELF.strength := if (isMedium, RelationshipIdentifier_Services.Constants.MEDIUM, left.strength);
														SELF := LEFT))
												)
										);
         tmpRel := exists(relRec(did2 = SecondaryEntity_UniqueID and (~(isRelative)) and (~(isAssociate))))
											and
											(~(isNeighbor));

				 //////////
         // Business Rule #2 if data shows that entities are found to be part of a transaction
				 // (which means  flags in the relative payload isRelative and isAssociate are false)
				 // and no other relationship
				 // is found (i.e. no neighbor and additionally no biplinkd to did relationship
				 // the relationship should be set to 'transactional'
				 //
         ds_relTmpResultOverrideTransaction :=
				            IF ( (~(NoOtherRelationshipBetweenEntities)),
				                  ds_relTmpResultOverrideNeighbor,
											     if (tmpRel,
													  PROJECT(ds_reltmpResult,
   														TRANSFORM(RelationshipIdentifier_Services.Layouts.bat_relationshipIdentiferReportRelTypeWithStrength,
															  // strength set same for all recs in this DS
															  SELF.strength := RelationshipIdentifier_Services.Constants.TRANSACTIONAL;
															  SELF := LEFT;
															  )),
																lowDS) // default it to be a low score if no relationship exists.
										     );
												 // catch all
         ds_reltmpResultOveride := if (count(ds_relTmpResultOverrideTransaction) = 0, lowDS,
				                           ds_relTmpResultOverrideTransaction);
         // requirements are to not show any relationship type's of 'RELATIONSHIP TYPE' STRING
				 // AKA RelationshipIdentifier_Services.Constants.NODISPLAYFLAG; as set from above
				 // but keep the particular strength field value that relatives key returns for those 'RELATIONSHIP TYPE'
				 // relationships. so filter out just the relationship type field here. but keep the strength field
				 // for display downstream.
				 //
         ds_reltmpResultOverrideSomeTypesRemoved := PROJECT(ds_reltmpResultOveride, TRANSFORM(RECORDOF(LEFT),
				                                   SELF.RelationshipType := IF (
																					                             ((left.RelationshipType = RelationshipIdentifier_Services.Constants.NODISPLAYFLAG)
																					                              AND (~(left.strength = RelationshipIdentifier_Services.Constants.TRANSACTIONAL))
																																			  ),
																																				'',
																					                              left.RelationshipType
																																				);
                                           SELF := LEFT));
        //
        // now remove relationships that are blank but not if they are the only relationship that exists
				// this this does that.
				ds_relThatCanNotDisplay := COUNT(ds_reltmpResultOveride(relationshipType =
				               RelationshipIdentifier_Services.Constants.NODISPLAYFLAG and
											    (~(strength = RelationshipIdentifier_Services.Constants.TRANSACTIONAL))
													));
         ds_relThatCanDisplay := COUNT(ds_reltmpResultOverrideSomeTypesRemoved(RelationshipType <> ''));

				 ds_relResultFinal := IF ( (ds_relThatCanNotDisplay > 0) AND (ds_relThatCanDisplay > 0),
																		// 1st condition.
																		ds_reltmpResultOverrideSomeTypesRemoved(relationshipType <> ''),
																		// 2nd condition
																		IF ( (ds_relThatCanNotDisplay = 0 AND count(ds_relThatCanDisplay) > 0),
																					ds_reltmpResultOverrideSomeTypesRemoved(relationshipType <> ''),
																					ds_reltmpResultOverrideSomeTypesRemoved
																				)
																	);

   return(ds_relResultFinal);
	 END;

  EXPORT AddPhoneMetaData(
    Dataset(iesp.RelationshipIdentifierSearch.t_RelationshipIdentifierSearchMatchRecord) InRecs,
    Doxie.IDataAccess mod_access
  ) := FUNCTION

    slim_inrecs_layout := RECORD
      string20 AccountNumber;
      Unsigned2 sequenceNumber;
      string10 phone;
    END;

    key_with_inrec_layout := RECORD
      slim_inrecs_layout;
      dx_Gong.layouts.i_history_phone;
    END;

    Slim_recs := PROJECT(inRecs, TRANSFORM(slim_inrecs_layout,
      SELF.phone := LEFT.PhoneInfo.Phone10;
      SELF := LEFT));

    key_history_phone := dx_Gong.key_history_phone();
    pre_base_recs := JOIN(inRecs, key_history_phone,
      KEYED(LEFT.PhoneInfo.phone10[4..10] = RIGHT.p7) AND
      KEYED(LEFT.PhoneInfo.phone10[1..3]  = RIGHT.p3),
      TRANSFORM(key_with_inrec_layout,
        SELF.accountNumber :=  LEFT.AccountNumber;
        SELF.sequenceNumber := LEFT.SequenceNUmber;
        SELF.Phone := LEFT.PhoneInfo.Phone10;
        SELF.record_sid := RIGHT.record_sid;
        SELF.global_sid := RIGHT.global_sid;
        SELF.did := RIGHT.did;
        SELF := RIGHT;),
      LEFT OUTER, LIMIT(RelationshipIdentifier_Services.Constants.limitvalue,skip));

    base_recs_optout := Suppress.MAC_FlagSuppressedSource(pre_base_recs, mod_access);
    base_recs := PROJECT(base_recs_optout, TRANSFORM(key_with_inrec_layout,
        SELF.accountNumber :=  LEFT.AccountNumber;
        SELF.sequenceNumber := LEFT.SequenceNUmber;
        SELF.Phone := LEFT.Phone;
        SELF := IF(NOT LEFT.is_suppressed, LEFT);
    ));

     unique_phones_wgongdata := ROLLUP(
      SORT(base_recs ,accountNumber, sequenceNumber,phone,IF (current_flag, 0, 1),IF(current_flag,listed_name,'')),
        TRANSFORM(RECORDOF(LEFT),
          SELF.listing_type_gov := MAX(left.listing_type_gov,right.listing_type_gov),
          SELF.listing_type_bus := MAX(left.listing_type_bus,right.listing_type_bus),
          SELF.listing_type_res := MAX(left.listing_type_res,right.listing_type_res),
          SELF.listed_name := LEFT.listed_name,
          SELF.dt_first_seen := MIN(left.dt_first_seen,right.dt_first_seen),
          SELF.dt_last_seen := MAX(left.dt_last_seen,right.dt_last_seen),
          SELF := LEFT),
    accountNumber, sequenceNumber,
    phone,IF (current_flag, 0, 1),
    IF(current_flag,listed_name,''));

		 unique_phones_against_names := DENORMALIZE(unique_phones_wgongdata,	inRecs,
		                                          LEFT.accountNumber = RIGHT.accountNumber AND
																							LEFT.sequenceNumber = RIGHT.sequenceNumber AND
																							LEFT.phone = RIGHT.phoneInfo.Phone10,
          GROUP,
		TRANSFORM(RECORDOF(LEFT),
			SELF := LEFT),
			LIMIT(RelationshipIdentifier_Services.Constants.limitvalue),
			KEEP(RelationshipIdentifier_Services.Constants.limitvalue));

		unique_phones_gong_rolled := ROLLUP(
				GROUP(SORT(unique_phones_against_names,AccountNumber, SequenceNumber,phone, IF (current_flag, 0, 1)),
									AccountNUmber, SequenceNumber,phone),
		GROUP,
		TRANSFORM({
			Slim_recs;
			STRING1 listing_type;
			STRING1 active_EDA;
			STRING1 disconnected;
			STRING8 from_date;
			STRING8 to_date;
			STRING120 listed_name;},
			SELF.disconnected := IF(NOT EXISTS(ROWS(LEFT)(current_flag)),'Y','N'),

			SELF.active_EDA := IF(EXISTS(ROWS(LEFT)(current_flag
			                                            )),'Y','N'),
			SELF.from_date := MIN(ROWS(LEFT)(current_flag
																	  ),dt_first_seen),
			SELF.to_date := MAX(ROWS(LEFT)(current_flag
			                              ),dt_last_seen),
			SELF.listing_type := MAP(
				EXISTS(ROWS(LEFT)(current_flag AND listing_type_gov != '')) => MAX(ROWS(LEFT)(current_flag AND listing_type_gov != ''),listing_type_gov),
				EXISTS(ROWS(LEFT)(current_flag AND listing_type_bus != '')) => MAX(ROWS(LEFT)(current_flag AND listing_type_bus != ''),listing_type_bus),
				EXISTS(ROWS(LEFT)(current_flag AND listing_type_res != '')) => MAX(ROWS(LEFT)(current_flag AND listing_type_res != ''),listing_type_res),
				''),
			SELF.listed_name := MAX(ROWS(LEFT)(current_flag),listed_name),
			SELF := LEFT,
			SELF := []));

		// now join this output back to the inrecs and populate the phone metadata in phoneInfo fields

		InRecsWithGongMetaData := JOIN(InRecs, unique_phones_gong_rolled,
		                                LEFT.accountNUmber = RIGHT.accountNumber AND
																		LEFT.sequenceNumber = RIGHT.sequenceNumber,

																		TRANSFORM(RECORDOF(LEFT),
																		SELF.listingType := RIGHT.listing_type;
																		SELF.activeEDA := RIGHT.Active_EDA = 'Y';
																		SELF.disconnected := if (left.phoneInfo.Phone10 = '', false, RIGHT.disconnected = 'Y');
																		// in case phone field is empty then default disconnected to false
																		// can add other field names if necessary here
																		SELF := LEFT,
																		SELF := []), KEEP(RelationshipIdentifier_Services.Constants.KEEPLIMIT),ALL);
																		// added 'ALL' at end of join to remove the compiler WARNING message
    // output(inRecs, named('InRecs'));
    // output(base_Recs, named('base_Recs'));
		// output(unique_phones_wgongdata, named('unique_phones_wgongdata'));
		// output(unique_phones_against_names, named('unique_phones_against_names'));
		 // output(unique_phones_gong_rolled, named('unique_phones_gong_rolled'));

	 outRecs := InRecsWithGongMetaData;
	 RETURN(outRecs);
	 END;
	 // for batch query
	 EXPORT setBatchInput(dataset(RelationshipIdentifier_Services.Layouts.Batch.OrigInput) InbatchRecs  ) := FUNCTION

	 outBatchRecsEntity1 := PROJECT(inBatchRecs,
	      TRANSFORM( {RelationshipIdentifier_Services.Layouts.Batch.Input; unsigned2 seq;},
			SELF.seq := 1;
	    self.acctno := LEFT.acctno;
			SELF.Role := LEFT.Role_1;
			SELF.IndividualOrBusiness := LEFT.individualOrBusiness_1;
			//person Info
			SELF.did := LEFT.did_1;
			SELF.DOB := LEFT.DOB_1;
			SELF.name_first := LEFT.name_first_1;
			SELF.name_middle := LEFT.name_middle_1;
			SELF.name_last := LEFT.name_last_1;
			SELF.name_suffix := LEFT.name_suffix_1;
		  SELF.ssn := LEFT.SSN_1;
			SELF.homephone := LEFT.homephone_1;
			//business info
			SELF.comp_name := LEFT.comp_name_1;
			SELF.tin := LEFT.tin_1;
			SELF.InSELEID := LEFT.Inseleid_1;
			//address
			SELF.prim_range := LEFT.prim_range_1;
			SELF.predir := LEFT.predir_1;
			SELF.prim_name := LEFT.prim_name_1;
			SELF.addr_suffix := LEFT.addr_suffix_1;
			SELF.postdir := LEFT.postdir_1;
			SELF.unit_desig := LEFT.unit_desig_1;
			SELF.sec_range := LEFT.sec_range_1;
			SELF.p_city_name := LEFT.city_name_1;
			SELF.st := LEFT.st_1;
			SELF.z5 := LEFT.z5_1;
			SELF.zip4 := LEFT.zip4_1;
			SELF.workphone := LEFT.workphone_1;
			));
	 outBatchRecsEntity2 := PROJECT(inBatchRecs, TRANSFORM( {RelationshipIdentifier_Services.Layouts.Batch.Input,
	                                                        unsigned2 seq;},
      SELF.seq := 2;
	    SELF.acctno := LEFT.acctno;
			SELF.Role := LEFT.Role_2;
			SELF.IndividualOrBusiness := LEFT.individualOrBusiness_2;
			//person Info
			SELF.did := LEFT.did_2;
			SELF.DOB := LEFT.DOB_2;
			SELF.name_first := LEFT.name_first_2;
			SELF.name_middle := LEFT.name_middle_2;
			SELF.name_last := LEFT.name_last_2;
			SELF.name_suffix := LEFT.name_suffix_2;
		  SELF.ssn := LEFT.SSN_2;
			SELF.homephone := LEFT.homephone_2;
			//business info
			SELF.comp_name := LEFT.comp_name_2;
			SELF.tin := LEFT.tin_2;
			SELF.InSELEID := LEFT.Inseleid_2;
			//address
			SELF.prim_range := LEFT.prim_range_2;
			SELF.predir := LEFT.predir_2;
			SELF.prim_name := LEFT.prim_name_2;
			SELF.addr_suffix := LEFT.addr_suffix_2;
			SELF.postdir := LEFT.postdir_2;
			SELF.unit_desig := LEFT.unit_desig_2;
			SELF.sec_range := LEFT.sec_range_2;
			SELF.p_city_name := LEFT.city_name_2;
			SELF.st := LEFT.st_2;
			SELF.z5 := LEFT.z5_2;
			SELF.zip4 := LEFT.zip4_2;
			SELF.workphone := LEFT.workphone_2;
			));

   OutBatchRecs :=  PROJECT(sort(outBatchRecsEntity1 && outBatchRecsEntity2,acctno, seq, record),
	                       TRANSFORM(RelationshipIdentifier_Services.Layouts.Batch.Input,
												 SELF := LEFT));

	 Return(outBatchRecs);
END;
END;
