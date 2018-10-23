
IMPORT AutoKeyI, AutoStandardI, census_data, iesp, lib_stringlib, SANCTN, Suppress, ut,BIPV2,MIDEX_Services;

// ==============================================================================================================	
//  MARI MIDEX "PUBLIC" DATA (SANCTN) related functions
// ==============================================================================================================

EXPORT Raw_Public := 
  MODULE
  
			//===========================================
			//   Functions
			//===========================================
			EXPORT fn_get_PublicSanctnAutokeyData ():=
				FUNCTION
		 
					tempmod_PublicSanctn := 
						MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT))
							EXPORT STRING autokey_keyname_root := SANCTN.Constants.AK_QA_KEYNAME;
							EXPORT STRING typestr              := SANCTN.Constants.TYPE_STR;
							EXPORT SET OF STRING1 get_skip_set := SANCTN.Constants.SKIPSET;
							EXPORT BOOLEAN useAllLookups       := SANCTN.Constants.USE_ALL_LOOKUPS;
						END;

					ds_PublicSanctnAutokeyIds := AutoKeyI.AutoKeyStandardFetch(tempmod_PublicSanctn).ids;
					ds_pubSanctnAutokeyIdsSorted := DEDUP( SORT( ds_PublicSanctnAutokeyIds, id), id);            
					RETURN ds_PubSanctnAutokeyIdsSorted;
				END; // get_PublicSanctnAutokeyData
			
			// -----------[ Get MIDEX payload key fields by Public SANTCN Keys ]-----------------------------------------

				EXPORT fn_get_PublicSanctnBdidData ( UNSIGNED6 in_bdid ):=
					FUNCTION
						ds_SANCTN_bdid_recs := CHOOSEN(SANCTN.Key_SANCTN_BDID( KEYED( BDID = in_bdid ) AND in_bdid != 0),MIDEX_Services.Constants.JOIN_LIMIT);
						
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_bdid_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );
						
						RETURN ds_outDataSet;
					END; // get_PublicBdidData
				
				EXPORT fn_get_PublicSanctnLinkIdData ( dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkid, STRING1 FetchLevel ):=
					FUNCTION
						ds_SANCTN_linkid_recs := CHOOSEN(SANCTN.Key_SANCTN_LinkIds.kFetch(in_linkid, FetchLevel),MIDEX_Services.Constants.JOIN_LIMIT);
						
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_linkid_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );
						
						RETURN ds_outDataSet;
					END; // get_PublicLinkIdData
					
				EXPORT fn_get_PublicSanctnDidData ( UNSIGNED6 in_did ):=
					FUNCTION
						ds_SANCTN_did_recs := CHOOSEN(SANCTN.Key_SANCTN_DID( KEYED( DID = in_did ) AND in_did != 0),MIDEX_Services.Constants.JOIN_LIMIT);
						
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_did_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );
						
						RETURN ds_outDataSet;
					END; // get_PublicDidData
				
			 
				EXPORT fn_get_PublicSanctnSsn4Data ( STRING4 in_ssn4 ) :=
					FUNCTION
						ds_SANCTN_ssn4_recs := CHOOSEN(SANCTN.Key_SSN4( KEYED( SSN4 = in_ssn4 ) AND in_ssn4 != ''),MIDEX_Services.Constants.JOIN_LIMIT);
						
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_ssn4_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );
						
						RETURN ds_outDataSet;
					END; // get_PublicSsn4Data

												
				EXPORT fn_get_PublicLicNbrData( STRING50 in_licNbr, STRING30 in_licState) :=
					FUNCTION
          
           upperCaseLicense  := TRIM(StringLib.StringToUpperCase(in_licNbr));
           upperCaseLicState := TRIM(StringLib.StringToUpperCase(in_licState));
        
            ds_SANCTN_lic_recs := CHOOSEN(SANCTN.Key_License_NBR( KEYED( cln_license_number = upperCaseLicense AND
																																				 (upperCaseLicState = '' OR license_state = upperCaseLicState) ) AND 
																																	upperCaseLicense != ''),iesp.Constants.MIDEX.MAX_COUNT_SEARCH_LICENSES);
                                                                  
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_lic_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );

						RETURN ds_outDataSet;
				END; // get_PublicLicData


				EXPORT fn_get_PublicNMLSIdData( STRING50 in_nmlsId) :=
					FUNCTION
						ds_SANCTN_lic_recs := CHOOSEN(SANCTN.Key_NMLS_ID( KEYED( nmls_id = in_NMLSId )  AND
																															in_NMLSId != ''), MIDEX_Services.Constants.JOIN_LIMIT);
						MIDEX_Services.Macros.MAC_midexPayloadKeyField(ds_SANCTN_lic_recs, ds_outDataSet, BATCH_NUMBER, INCIDENT_NUMBER, PARTY_NUMBER, MIDEX_PRT_NBR );

						RETURN ds_outDataSet;
				END; // get_PublicNMLSData
				
				EXPORT fn_get_PublicSanctnPayload ( DATASET( MIDEX_Services.Layouts.rec_midex_payloadKeyField ) ds_mari ) :=
					FUNCTION
						ds_payload_sorted := DEDUP( SORT( ds_mari, midex_rpt_nbr ), midex_rpt_nbr );
						ds_mari_recs :=
							JOIN( ds_payload_sorted,
										SANCTN.key_MIDEX_RPT_NBR,
										KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
										TRANSFORM(RIGHT),
										LIMIT(MIDEX_Services.Constants.JOIN_LIMIT,SKIP));
						RETURN ds_mari_recs;
				 END;

			//==============================================
			// MODULE: Public License Search and report view 
			//==============================================
			EXPORT LICENSE := MODULE
			
				 EXPORT REPORT_VIEW := MODULE
							EXPORT by_midex_rpt_num(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_ids,
                                      UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                      STRING in_search_type = 'I', STRING in_ssn_mask_type = '', STRING32 in_app_type = '') := FUNCTION

									sanct_recsRaw := JOIN( in_ids,SANCTN.key_MIDEX_RPT_NBR,
																			KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
																			TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
																								SELF.data_source := MIDEX_Services.Constants.DATASOURCE_PUBLIC,
																								SELF.last_upd_date := '',
																								SELF.TitleName := RIGHT.title,
																								SELF.FirstName := RIGHT.fname,
																								SELF.MiddleName := RIGHT.mname,
																								SELF.LastName := RIGHT.lname,
																								SELF.SuffixName := RIGHT.name_suffix,
																								SELF.companyName := RIGHT.cname,
																								SELF.ssn := lib_stringlib.stringlib.StringFilterOut( RIGHT.ssnumber, '-');,
																								SELF.did := (UNSIGNED6)RIGHT.did,
																								SELF.bdid := (UNSIGNED6)RIGHT.bdid,
																								SELF.phone := '';
																								SELF.report_number := RIGHT.midex_rpt_nbr,
																								SELF.city := RIGHT.v_city_name,
																								SELF := RIGHT,
																								SELF := []),
																				KEEP(1),
																				LIMIT(0));
                
                census_data.MAC_Fips2County_Keyed(sanct_recsRaw,st,fips_county,county,sanct_recs);								

								// Get license info via midex rpt number									
								sanct_recs_wlicInfo := JOIN(sanct_recs,SANCTN.key_license_midex,
                                            KEYED(LEFT.report_number = RIGHT.midex_rpt_nbr),
                                            TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
                                                      SELF.Licenses := IF(RIGHT.cln_license_number != '' OR 
                                                                          RIGHT.std_type_desc != '' OR 
                                                                          RIGHT.license_state != '',
                                                                          DATASET ([{RIGHT.cln_license_number,RIGHT.std_type_desc,'',RIGHT.license_state,'','',TRUE}], MIDEX_Services.Layouts.LicenseInfo_Layout),
                                                                          DATASET ([], MIDEX_Services.Layouts.LicenseInfo_Layout)),
                                                      SELF := LEFT),
                                            LEFT OUTER,
                                            LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES,SKIP));
								
								// Add nmls info
								//If the user performed a indivdual search use the nmls_id with the type of individual,
								//if it is a company use the nmls with a type of company.
								nmls_type := Functions.set_nmlsLicenseType(in_search_type);
								
								// Add the nmlsID to recordset if one exists.
								sanct_recs_nmlsID := JOIN (sanct_recs_wlicInfo,SANCTN.key_nmls_midex,
																					 KEYED(LEFT.report_number = RIGHT.midex_rpt_nbr) AND
																					 nmls_type = Stringlib.StringToUpperCase(RIGHT.license_type),
																					 TRANSFORM(MIDEX_Services.Layouts.LicenseReport_Layout,
																											SELF.nmls_id :=(INTEGER) RIGHT.nmls_id,
																											SELF := LEFT),
																					 LEFT OUTER,
																					 KEEP(1),
																					 LIMIT(0));
																								
								sanct_nmls_recs := MIDEX_Services.Functions.add_nmls_info(sanct_recs_nmlsID);
								sanct_group := GROUP(SORT(DEDUP(sanct_nmls_recs,ALL),report_number),report_number);
								MIDEX_Services.Layouts.LicenseReport_Layout licenseRollup(Layouts.LicenseReport_Layout l, DATASET(MIDEX_Services.Layouts.LicenseReport_Layout) allRows) := TRANSFORM
										SELF.Licenses := NORMALIZE (allRows, LEFT.Licenses, TRANSFORM (RIGHT));
										SELF := l;
								END;
								
								sanct_rolled := ROLLUP(sanct_group,GROUP,licenseRollup(LEFT,ROWS(LEFT)));
								sanct_recsHash := PROJECT(sanct_rolled,MIDEX_Services.alert_calcs.calcLicenseReptHashes(LEFT,alertVersion));
								RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,sanct_recsHash,sanct_rolled));
							END; // end by midex report number funtion
				 END; // license report view module
								 
				 EXPORT SEARCH_VIEW := MODULE
												
							EXPORT by_midex_rpt_num(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_ids,
                                      UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                      STRING in_ssn_mask_type = '', string32 in_app_type = '') := FUNCTION
															
									sanct_recsRaw := JOIN(in_ids,SANCTN.key_MIDEX_RPT_NBR,
																			KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
																			TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
																								SELF.licensee_FirstName := RIGHT.fname,
																								SELF.licensee_MidName := RIGHT.mname,
																								SELF.licensee_LastName := RIGHT.lname,
																								SELF.licensee_companyName := RIGHT.cname,
																								SELF.ssn := lib_stringlib.stringlib.StringFilterOut( RIGHT.ssnumber, '-');,
																								SELF.data_source := MIDEX_Services.Constants.DATASOURCE_PUBLIC,
																								SELF.city := RIGHT.v_city_name,
																								SELF := RIGHT,
																								SELF := []),
																				LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS,SKIP));
									
                  census_data.MAC_Fips2County_Keyed(sanct_recsRaw,st,fips_county,county,sanct_recs);								

									// Get license info via midex rpt number									
									sanct_recs_wlicInfo := JOIN(sanct_recs,SANCTN.key_license_midex,
																								KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
																								TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
																													SELF.lic_number := RIGHT.cln_license_number,
																													SELF.lic_type := RIGHT.std_type_desc,
																													SELF.lic_state := RIGHT.license_state,
                                                          SELF.isCurrent := TRUE, //Public sanctions data is daily full file replace
																													SELF := LEFT,
																													SELF := []),
																								LEFT OUTER,
																								LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_RESPONSE_RECORDS,SKIP));
																								
									sanct_recs_wlicInfo_Dedup := DEDUP(sanct_recs_wlicInfo,ALL);
									
									// Attach nmls info
									sanct_recs_wNmlsID := JOIN(sanct_recs_wlicInfo_Dedup,SANCTN.key_nmls_midex,
																								KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
																								TRANSFORM(MIDEX_Services.Layouts.license_srch_layout,
																													SELF.nmls_info := ROW ({RIGHT.license_type,RIGHT.nmls_id}, Layouts.rec_nmlsInfo),
																													SELF := LEFT,
																													SELF := []),
																								LEFT OUTER,
																								LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS,SKIP));
																								
									sanct_recs_wNmlsID_group := GROUP(SORT(sanct_recs_wNmlsID,midex_rpt_nbr),midex_rpt_nbr);
										
									MIDEX_Services.Layouts.license_srch_layout Roll_NMLSInfo(MIDEX_Services.Layouts.license_srch_layout l, DATASET(MIDEX_Services.Layouts.license_srch_layout) allRows) := TRANSFORM
												SELF.nmls_info := allRows.nmls_info;
												SELF := l;
									END;
									sanct_recs_wNmlsID_rolled := ROLLUP(sanct_recs_wNmlsID_group,GROUP,Roll_NMLSInfo(LEFT,ROWS(LEFT)));
									
									sanct_recsHash := PROJECT(sanct_recs_wNmlsID_rolled,MIDEX_Services.alert_calcs.calcLicenseSrchHashes(LEFT));
									
									RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,sanct_recsHash,sanct_recs_wNmlsID_rolled));
							END; // end function
				END;  // Midex License module     
			END;     // License module
			

			//===========================================================
			// MODULE: Public Midex Comprehensive Report and Search view 
			//===========================================================
			EXPORT MIDEX := MODULE
				EXPORT REPORT_VIEW := MODULE
        
					// as with the nonpublic attribute, I was asked during a code review to comment what was 
          // being joined in each join for the comprehensive report. 
          // There are two basic parts to the midex report. The subject and the associated parties.  
          // The associated parties is a child dataset of the subject report, but contains many of the 
          // same parts (ie: name, license number, nmls ID, etc.  Therefore, the code joins many  
          // of the same keys and it does appear that there is duplication. Hence the request for 
          // comments for each section/join.
					EXPORT fn_pub_RptView_by_midex_rpt_num(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_midex_rpt_nbrs, BOOLEAN alert = FALSE, STRING ssnMask, STRING dobMask, STRING8 StartLoadDate = '') := 

						FUNCTION
								 
							in_midexRptNbrsSorted := DEDUP( SORT( in_midex_rpt_nbrs, MIDEX_RPT_NBR), MIDEX_RPT_NBR);
                      
							// the public record keys prepends leading zeros for the incident & party numbers
							// because the search can be a midex report number where the user does not
							// add the (STRING8) zeros and the public 
							// incident and party numbers are padded, the following transform
							// ensures the incident and party fields are correctly populated
							in_midexRptNbrsPub := 
								PROJECT( in_midexRptNbrsSorted, 
												 TRANSFORM( MIDEX_Services.layouts.rec_midex_payloadKeyField,
																		SELF.Incident_num := IF( LEFT.PublicIncidentNum = '', 
																														 LEFT.incident_num,
																														 LEFT.PublicIncidentNum
																													 );
																		SELF.Party_num    := IF( LEFT.publicPartyNum = '', 
																														 LEFT.party_num,
																														 LEFT.publicPartyNum
																													 );
																		SELF              := LEFT;
																 ));
        
              in_PubMidexRptNbrsFiltered := 
                JOIN( in_midexRptNbrsPub,
                      SANCTN.key_incident_midex,
                      KEYED(LEFT.batch = RIGHT.batch_number AND
                            LEFT.incident_num = RIGHT.incident_number) AND
                      RIGHT.cln_load_date >= StartLoadDate,
                      TRANSFORM(LEFT), 
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT),
                      KEEP(1));
              
							// find associated parties. This joins gets the list of associated parties for the 
              // midex report numbers.  The professions are listed in separtate rows and will be 
              // rolled up into a child dataset.
              // LEFT.party_num != RIGHT.party_number => removes the subject from the parties list
              ds_partiesRaw :=
								JOIN( in_PubMidexRptNbrsFiltered,
											SANCTN.Key_SANCTN_party, 
											KEYED( LEFT.batch = RIGHT.batch_number AND
														 LEFT.Incident_num = RIGHT.incident_number) AND
                      LEFT.party_num != RIGHT.party_number,
											TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
																 incidentNum             := (UNSIGNED)RIGHT.incident_number;
																 partyNum                := (UNSIGNED)RIGHT.party_number;
																 SELF.batchNumber        := RIGHT.batch_number,
																 SELF.incidentNumber     := RIGHT.incident_number,
																 SELF.partyNumber        := RIGHT.party_number,     
																 SELF.Name               := iesp.ECL2ESP.setName( RIGHT.fname, RIGHT.mname, RIGHT.lname, RIGHT.name_suffix, RIGHT.title),
																 SELF.ssn                := MIDEX_Services.Functions.fn_pubSanctSsnMask(RIGHT.ssNumber, '', ssnMask),
																 SELF.Professions        := DATASET([{RIGHT.party_vocation}], iesp.share.t_StringArrayItem),  /* vocation is string45 */
																 SELF.partyPosition      := RIGHT.party_position,
																 SELF.partyFirm          := RIGHT.party_firm,
																 SELF.midex_rpt_nbr      := TRIM(RIGHT.batch_number, RIGHT, LEFT) + '-' + (STRING)incidentNum + '-' + (STRING)partyNum,
																 SELF                    := RIGHT;
                                 SELF                    := [];
															 ),
											INNER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
							
							census_data.MAC_Fips2County_Keyed(ds_partiesRaw,st,fips_county,county,ds_parties); 
              
              ds_partiesSorted := SORT( ds_parties, midex_rpt_nbr);
							
              // rollup professions in associated parties
							ds_partiesProfessionsRolled :=
								ROLLUP( ds_partiesSorted, 
												LEFT.batchNumber = RIGHT.batchNumber AND
												LEFT.incidentNumber = RIGHT.incidentNumber AND
												LEFT.partyNumber = RIGHT.partyNumber,
												TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
																	 SELF.Professions := LEFT.Professions + RIGHT.Professions,
																	 SELF             := LEFT,
																	 SELF             := [],
																 ));
              
              // the following always returns available parties in the order they were entered into the system and up to the max count
              ds_associatedParties := CHOOSEN( SORT( ds_partiesProfessionsRolled, midex_rpt_nbr), iesp.Constants.Midex.MAX_COUNT_REPORT_PARTY_COUNT);                 

							// Collect AKAs and DBAs, overloaded in the same key
              ds_akasDbasAll := 
                JOIN( ds_associatedParties,
                      SANCTN.key_party_aka_dba,
                      KEYED( LEFT.batchNumber = RIGHT.batch_Number AND
                             LEFT.incidentNumber = RIGHT.incident_Number AND
                             LEFT.partyNumber = RIGHT.party_Number ),
                      TRANSFORM( MIDEX_Services.Layouts.compReport_AkaDbaLayout,
                                 SELF.AKANames := IF( RIGHT.name_type = MIDEX_Services.Constants.AKA_NAME_TYPE,
                                                      DATASET( [{RIGHT.aka_dba_text,'','','','',''}],iesp.Share.t_name ),
                                                      DATASET( [],iesp.Share.t_name )
                                                    ),
                                 SELF.DBANames := IF( RIGHT.name_type = MIDEX_Services.Constants.DBA_NAME_TYPE,
                                                      DATASET( [{RIGHT.aka_dba_text}],iesp.midexcompreport.t_MIDEXDBAName ),
                                                      DATASET( [],iesp.midexcompreport.t_MIDEXDBAName )
                                                    ),
                                 SELF          := RIGHT,  // name_type
                                 SELF          := LEFT,   // batch, incident & party numbers, midex rpt nbr, subject rpt & party numbers
                               ),
                      LEFT OUTER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
              
              ds_akasDbasAllSorted := SORT( ds_akasDbasAll, batchNumber, incidentNumber, partyNumber, name_type );

              // rollup akas and dbas into two records for each midex report number, keeping only the max for each dataset
              ds_akasDbasRolled := 
                ROLLUP( ds_akasDbasAllSorted,
                        LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM(  MIDEX_Services.Layouts.compReport_AkaDbaLayout,
																	 SELF.AKANames := LEFT.AKANames + RIGHT.AKANames,
																	 SELF.DBANames := LEFT.DBANames + RIGHT.DBANames,
                                   SELF          := LEFT,
																	 SELF          := [],
																 ));
              
              // Add licenses	to the parties payload with professions and then rollup the licenses.							 
							ds_partiesLicense :=
								JOIN( ds_associatedParties,
											SANCTN.key_license_midex,
											KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
											TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
																 SELF.LicensesSlimmed := DATASET([{RIGHT.STD_TYPE_DESC, RIGHT.CLN_LICENSE_NUMBER,  
																																	 '', RIGHT.LICENSE_STATE,ROW([],iesp.share.t_Date),TRUE}], iesp.midex_share.t_MIDEXLicenseInfo);
																 SELF                 := LEFT,
																 SELF                 := [],
															 ),
											LEFT OUTER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
																													 
							ds_partiesLicenseSorted := SORT(ds_partiesLicense, midex_rpt_nbr);
							
							ds_partiesLicenseRolled :=
								ROLLUP( ds_partiesLicenseSorted,
												LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
																	 SELF.LicensesSlimmed := LEFT.LicensesSlimmed + RIGHT.LicensesSlimmed;
																	 SELF                 := LEFT;
																 ));
							
							// Per Rodney, there will never be more than one NMLS ID associated with a public midex report number
							// so there is no need to rollup/select the appropriate nmls ID as with the nonpublic data.
							// parties, professions, licenses & nmls 									 
							ds_partiesWithNmls :=
								JOIN( ds_partiesLicenseRolled, 
											SANCTN.key_nmls_midex,
											KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
											TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
																 SELF.nmlsType        := RIGHT.license_type,
																 SELF.nmlsId          := RIGHT.nmls_id,
                                 SELF.LicensesSlimmed := CHOOSEN( LEFT.LicensesSlimmed, iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES );
																 SELF                 := LEFT
															 ),
											LEFT OUTER,
                      LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_NMLS, SKIP));

              ds_partiesWithAkaDba :=
                JOIN( ds_partiesWithNmls,
                      ds_akasDbasRolled,
                      LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr AND
                      LEFT.DBCODE = RIGHT.DBCODE,
                      TRANSFORM( MIDEX_Services.Layouts.compReport_PartyTempLayout,
															   SELF.AKANames := CHOOSEN( SORT( RIGHT.AKANames, Full ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
																 SELF.DBANames := CHOOSEN( SORT( RIGHT.DBANames, name ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
                                 SELF          := LEFT
                               ),
                      LEFT OUTER,
                      KEEP(1),
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));          

							ds_partiesProfessionsDedup := 
								PROJECT( ds_partiesWithAkaDba, 
												 TRANSFORM( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields,
																		SELF.Professions                := CHOOSEN( DEDUP( SORT( LEFT.Professions, value), value), iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS);
																		SELF.Licenses                   := LEFT.LicensesSlimmed;
																		SELF.NMLSInfo                   := ROW({LEFT.nmlsId, LEFT.nmlsType}, iesp.midex_share.t_NMLSInfo);
																		SELF.OtherIdentifyingReferences := []; 
																		SELF.batch                      := LEFT.batchNumber;
																		SELF.incident_num               := LEFT.incidentNumber;
																		SELF.party_num                  := LEFT.partyNumber;
																		SELF.address                    := iesp.ECL2ESP.SetAddress( LEFT.prim_name, LEFT.prim_range, LEFT.predir, 
                                                                                                LEFT.postdir, LEFT.addr_suffix, LEFT.unit_desig, 
                                                                                                LEFT.sec_range, LEFT.v_city_name,LEFT.st, 
                                                                                                LEFT.zip5, LEFT.zip4, LEFT.county, '', '', '', ''),
																   SELF                            := LEFT;
																 ));


							// group all party info and roll up for assignment as a child dataset 									 
							ds_partiesGrouped :=
								GROUP( SORT( ds_partiesProfessionsDedup, batch, incident_num ), batch, incident_num );
					 
							MIDEX_Services.Layouts.compReport_iespPartyPlusJoinFields xfm_party( MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields le,  DATASET(MIDEX_Services.Layouts.compReport_iespPartyFlatPlusJoinFields) allRows) :=
								TRANSFORM
									SELF.batch        := le.batch;
									SELF.incident_num := le.incident_num;
									SELF.dbcode       := [];
									SELF.partyRecs    := PROJECT(allRows, iesp.midexcompreport.t_MIDEXCompParty);  
								END;
							 
							ds_partiesRolled :=
								ROLLUP( ds_partiesGrouped, GROUP, xfm_party( LEFT, ROWS(LEFT)) );
                
              ds_partiesRolledSorted := SORT(ds_partiesRolled, batch, incident_num);
  
								
							// ---- End public parties ---------------------------------------------------------------------------
							// ---------------------------------------------------------------------------------------------------
							//
              //  Next get the incident & rebuttal/response child datasets and data that have their own key
              //----------------------------------------------------------------------------------------------------
              
              // collect records for the response/rebuttal text child dataset
							ds_responseRecords :=
								JOIN(in_PubMidexRptNbrsFiltered, 
										 SANCTN.key_rebuttal_text, 
										 KEYED(LEFT.batch = RIGHT.batch_number AND
													 LEFT.Incident_num = RIGHT.incident_number AND
													 LEFT.party_num = RIGHT.party_number), 
										 TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
																SELF.Text            := MIDEX_Services.Functions.fn_setStringArray(RIGHT.party_text);
																SELF.OrderNumber     := RIGHT.order_number;
																SELF                 := LEFT;
																SELF                 := [];
															),
											 INNER,
                       LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
							
							ds_responseListSorted := CHOOSEN( SORT( ds_responseRecords, midex_rpt_nbr, (UNSIGNED)OrderNumber), iesp.constants.MIDEX.MAX_COUNT_REPORT_TEXT);
							
							ds_responseRecsRolled := 
								ROLLUP( ds_responseListSorted,
												LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM( MIDEX_Services.Layouts.compReport_nonpublicTextRawLayout,
																	 SELF.Text := IF( (UNSIGNED)RIGHT.OrderNumber <= iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT, 
																										LEFT.Text + RIGHT.Text,
																										LEFT.Text );
																	 SELF      := LEFT;
																 ));
							// collect records for the incident text and roll for child dataset 
							ds_incidentRecsAll := 
								JOIN( in_PubMidexRptNbrsFiltered,
											SANCTN.key_incident_midex,
											KEYED(LEFT.batch = RIGHT.batch_number AND
														LEFT.Incident_num = RIGHT.incident_number),
											TRANSFORM(MIDEX_Services.Layouts.compReport_publicTextRawLayout,
																SELF.Batch           := RIGHT.BATCH_NUMBER,
																SELF.Incident_num    := RIGHT.INCIDENT_NUMBER,
																SELF.Party_num       := RIGHT.PARTY_NUMBER, 
																SELF.OrderNumber     := RIGHT.order_number,
																SELF.Text            := MIDEX_Services.Functions.fn_setStringArray( RIGHT.incident_text ),
																SELF.midex_rpt_nbr   := LEFT.midex_rpt_nbr, 
																SELF.DataSource      := RIGHT.agency,
																SELF.SourceDocument  := RIGHT.source_document,
																SELF.CaseNumber      := RIGHT.case_number,
																SELF.IncidentDate    := RIGHT.incident_date_clean,
																SELF.DateOfInclusion := RIGHT.cln_load_date,
																SELF.ModifiedDate    := RIGHT.cln_modified_date,
                                SELF.LoadDate        := RIGHT.cln_load_date,
																SELF.Jurisdiction    := RIGHT.jurisdiction,
																SELF.AdditionalInfo  := RIGHT.additional_info,
																SELF                 := []; // date is not provided in this key file
															 ),
											INNER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
                      // The limit statement was changed because of bug: 159622. For Timothy Lester Kyle, there are 349 incident records. The max in the iesp is 50, so these 
                      // records were being skipped. The Source Doc, incident info, date, ect were not picked up in the output for this reason.
                      // because the layout is so wide, we are collecting 1000 records, sorting and keeping the max count along with the other
                      // fields that were not populated if the number of records for the join was too large. 
 
 
                      
							ds_incidentRecsSorted := CHOOSEN(SORT(ds_incidentRecsAll, midex_rpt_nbr, (UNSIGNED)orderNumber),iesp.Constants.MIDEX.MAX_COUNT_REPORT_INCIDENT_INFO);
							
							ds_incidentRecsRolled := 
								ROLLUP( ds_incidentRecsSorted,
												LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM( MIDEX_Services.Layouts.compReport_publicTextRawLayout,
																	 SELF.Text := IF( (UNSIGNED)RIGHT.OrderNumber <= iesp.Constants.MIDEX.MAX_COUNT_REPORT_TEXT, 
																										LEFT.Text + RIGHT.Text,
																										LEFT.Text );
																	 SELF      := LEFT;
																 ));


              // Collect subject AKAs/DBAs
              ds_akasDbasSubjAll := 
                JOIN( in_PubMidexRptNbrsFiltered,
                      SANCTN.key_party_aka_dba,
                      KEYED( LEFT.batch = RIGHT.batch_Number AND
                             LEFT.incident_num = RIGHT.incident_Number AND
                             LEFT.party_num = RIGHT.party_Number ),
                      TRANSFORM( MIDEX_Services.Layouts.compReport_AkaDbaLayout,
                                 SELF.AKANames       := IF( RIGHT.name_type = MIDEX_Services.Constants.AKA_NAME_TYPE,
                                                            DATASET( [{RIGHT.aka_dba_text,'','','','',''}],iesp.Share.t_name ),
                                                            DATASET( [],iesp.Share.t_name )
                                                          ),
                                 SELF.DBANames       := IF( RIGHT.name_type = MIDEX_Services.Constants.DBA_NAME_TYPE,
                                                            DATASET( [{RIGHT.aka_dba_text}],iesp.midexcompreport.t_MIDEXDBAName ),
                                                            DATASET( [],iesp.midexcompreport.t_MIDEXDBAName )
                                                          ),
                                 SELF                := RIGHT,  // order_number, name_type
                                 SELF.batchNumber    := LEFT.batch,   
                                 SELF.incidentNumber := LEFT.incident_num,
                                 SELF.partyNumber    := LEFT.party_num,
                                 SELF                := LEFT, // midex rpt nbr, subject rpt & party numbers
                               ),
                      LEFT OUTER,
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));
              
              ds_akasDbasSubjAllSorted := SORT( ds_akasDbasSubjAll, midex_rpt_nbr, name_type );
              
              // rollup akas and dbas into two records for each midex report number, keeping only the max for each dataset
              ds_akasDbasSubjRolled := 
                ROLLUP( ds_akasDbasSubjAllSorted,
                        LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM(  MIDEX_Services.Layouts.compReport_AkaDbaLayout,
																	 SELF.AKANames := LEFT.AKANames + RIGHT.AKANames,
																	 SELF.DBANames := LEFT.DBANames + RIGHT.DBANames,
                                   SELF          := LEFT,
																	 SELF          := [],
																 ));


							//----------------------------------------------------------------------------------------------------------
              //    start building the main record  - There are several keys that need to be hit.  
              //----------------------------------------------------------------------------------------------------------
              // Get payload data for midex report numbers and roll public actions and professions
              // into child datasets
              ds_payloadRecsRaw := 
								 JOIN( in_PubMidexRptNbrsFiltered,
											 SANCTN.key_MIDEX_RPT_NBR,
											 KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
											 TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	SELF.firstname         := RIGHT.fname;
																	SELF.middlename        := RIGHT.mname;
																	SELF.lastname          := RIGHT.lname;
																	SELF.suffixname        := RIGHT.name_suffix;
																	SELF.Prefixname        := RIGHT.title;
																	SELF.ssn               := MIDEX_Services.Functions.fn_pubSanctSsnMask(RIGHT.ssNumber, RIGHT.ssn_appended, ssnMask),
																	SELF.CompanyName       := RIGHT.cname;
																	SELF.companyAka        := RIGHT.dba_name;
																	SELF.UniqueId          := (STRING)RIGHT.DID;
																	SELF.BusinessId        := (STRING)RIGHT.BDID;
																	SELF.BusinessIds			 := RIGHT;
																	SELF.city				       := RIGHT.v_city_name;
																	SELF.BATCH             := RIGHT.BATCH_NUMBER;
																	SELF.incident_num      := RIGHT.INCIDENT_NUMBER;
																	SELF.party_num         := RIGHT.PARTY_NUMBER;
																	SELF.JobTitle          := RIGHT.party_position;
																	SELF.Professions       := DATASET([{RIGHT.party_vocation}],iesp.share.t_StringArrayItem);
																	SELF.PublicActions     := DATASET([{RIGHT.party_text}], iesp.share.t_StringArrayItem);
																	SELF.MIDEXFileNumber   := RIGHT.midex_rpt_nbr;
																	SELF.midex_rpt_nbr     := LEFT.midex_rpt_nbr;
																	SELF                   := RIGHT; 
																	SELF                   := [];
																),
											 INNER,
                       LIMIT(MIDEX_Services.Constants.JOIN_LIMIT_FOR_CHOOSEN, SKIP));  
							
              census_data.MAC_Fips2County_Keyed(ds_payloadRecsRaw,st,fips_county,county,ds_payloadRecs); 
                
              ds_payloadRecsSorted := SORT(ds_payloadRecs, midex_rpt_nbr, order_number);
							
							ds_payloadRecsRolledRaw :=
								ROLLUP( ds_payloadRecsSorted, 
												LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr, 
												TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	 SELF.PublicActions := IF( COUNT(LEFT.publicActions) < iesp.Constants.MIDEX.MAX_COUNT_REPORT_ACTIONS,
																														 LEFT.publicActions + RIGHT.publicActions,
																														 LEFT.publicActions);
																	 SELF.Professions   := LEFT.professions + RIGHT.professions; /* saw duplication in the keys for this field */
																	 SELF               := LEFT;
																 ));
						 // public actions is a text field that needs to be concatenated (the strings can be too
             // long for the field to handle to they are split across fields).
						 ds_payloadRecsRolledAll :=
							 PROJECT( ds_payloadRecsRolledRaw, 
												TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout, 
																	 SELF.Professions   := CHOOSEN( DEDUP( SORT( LEFT.Professions, value), value), iesp.Constants.MIDEX.MAX_COUNT_REPORT_PROFESSIONS);
																	 SELF               := LEFT;
																 ));
						 
             ds_payloadRecsRolled := CHOOSEN( SORT( ds_payloadRecsRolledAll, midex_rpt_nbr), iesp.Constants.MIDEX.MAX_COUNT_REPORT_INCIDENTS );
             
             // add rolled incident data to the payload, public actions and professions dataset 
						 ds_payloadWithIncidentData := 
								 JOIN( ds_payloadRecsRolled,
											 ds_incidentRecsRolled,
											 LEFT.batch = RIGHT.batch AND
											 LEFT.Incident_num = RIGHT.incident_num,
											 TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	SELF.incidentText     := PROJECT(RIGHT, 
																																	 TRANSFORM(iesp.midexcompreport.t_MIDEXCompComment,
																																						 SELF.Date := RIGHT.Date,
																																						 SELF.Text := RIGHT.Text)); 
																	SELF                  := RIGHT,
																	SELF                  := LEFT,
																	SELF                  := [],
																),
											 LEFT OUTER,
                       KEEP(1),
											 LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));
											 
						 // add rolled response data to the payload, incident text, public actions and professions dataset 
						 ds_payloadWithResponseText :=
							 JOIN( ds_payloadWithIncidentData,
										 ds_responseRecsRolled,
										 LEFT.batch = RIGHT.batch AND
										 LEFT.incident_num = RIGHT.incident_num,
										 TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																SELF.responseText := PROJECT(RIGHT, 
																														 TRANSFORM(iesp.midexcompreport.t_MIDEXCompComment,
																																			 SELF.Date := RIGHT.Date;
																																			 SELF.Text := RIGHT.Text));
																SELF              := LEFT;
															),
											 LEFT OUTER,
                       KEEP(1),
											 LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));
											 
						 ds_payloadWithAkaDba :=
                JOIN( ds_payloadWithResponseText,
                      ds_akasDbasSubjRolled,
                      LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
                      TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	 SELF.AKANames := CHOOSEN( SORT( RIGHT.AKANames, Full ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
																	 SELF.DBANames := CHOOSEN( SORT( RIGHT.DBANames, name ), iesp.Constants.MIDEX.MAX_COUNT_REPORT_AKA_DBA),
                                   SELF             := LEFT
                                ),
                      LEFT OUTER,
                      KEEP(1),
                      LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));  
             
             // add rolled party child dataset to the payload, incident text, response text, 
             // public actions and professions dataset 
						 ds_payloadWithPartyRecs :=
							 JOIN( ds_payloadWithAkaDba,
										 ds_partiesRolledSorted,
										 LEFT.batch = RIGHT.batch AND
										 LEFT.incident_num = RIGHT.incident_num,
										 TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																SELF.IncidentParties := RIGHT.partyRecs;
																SELF                 := LEFT;
															),
											 LEFT OUTER,
                       KEEP(1),
											 LIMIT(MIDEX_Services.Constants.JOIN_LIMIT));
	 
						 // add license data to the payload, incident text, response text, 
             // party, public actions and professions dataset and then rollup licenses
						 ds_payloadWithLicenseRecs :=
								JOIN( ds_payloadWithPartyRecs,
											SANCTN.key_license_midex,
											KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
											TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																 SELF.Licenses := DATASET([{RIGHT.STD_TYPE_DESC, RIGHT.CLN_LICENSE_NUMBER,  
																														'', RIGHT.LICENSE_STATE,ROW([],iesp.share.t_Date),TRUE}], iesp.midex_share.t_MIDEXLicenseInfo);
																 SELF          := LEFT;
																 SELF          := [];
															 ),
											LEFT OUTER,
                      LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_RESPONSE_LICENSES, SKIP));
																													 
							ds_payloadWithLicenseRecsSorted := SORT(ds_payloadWithLicenseRecs, midex_rpt_nbr);
							
							ds_payloadWithLicRecsRolled :=
								ROLLUP( ds_payloadWithLicenseRecsSorted,
												LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
												TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																	 SELF.Licenses := IF( COUNT(LEFT.Licenses) < iesp.Constants.MIDEX.MAX_COUNT_REPORT_LICENSES,
																												LEFT.Licenses + RIGHT.Licenses,
																												LEFT.Licenses );
																	 SELF          := LEFT;
																 ));

						 // add NMLS data to the payload, incident text, response text, 
             // party, license, public actions and professions dataset and then rollup licenses
						 ds_reportRecs :=
							 JOIN( ds_payloadWithLicRecsRolled,
										 SANCTN.key_nmls_midex,
										 KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
										 TRANSFORM( MIDEX_Services.Layouts.CompReport_TempLayout,
																SELF.nmlsId   := RIGHT.nmls_id;
																SELF.nmlsType := RIGHT.license_type;
																SELF          := LEFT;
															),
											LEFT OUTER,
											LIMIT(iesp.Constants.MIDEX.MAX_COUNT_REPORT_NMLS, SKIP));
							 
						 ds_reportRecs_recsHash := 
								PROJECT(ds_reportRecs, MIDEX_Services.alert_calcs.xfm_calcMidexIncidentHashes(LEFT));
   
						RETURN (IF(alert,ds_reportRecs_recsHash,ds_reportRecs));
					END;
			 
				 EXPORT fn_PublicLayoutRecords(DATASET (MIDEX_Services.Layouts.CompReport_TempLayout) ds_payloadRecs, STRING dobMask) := 
					FUNCTION
						ds_publicRecsRaw := 
							 PROJECT( ds_payloadRecs, 
												TRANSFORM( iesp.midexcompreport.t_MIDEXCompPublicRecord,
																	 SELF.MIDEXFileNumber         := LEFT.MIDEXFileNumber;
																	 SELF.SubjectReported         := MIDEX_Services.Functions.fn_SubjectReported(LEFT, dobMask);
																	 SELF.SourceInfo              := MIDEX_Services.Functions.fn_SourceInfo(LEFT);
																	 SELF.IncidentInfo            := LEFT.incidentText;
																	 SELF.RebuttalInfo            := LEFT.responseText;
																	 SELF.AdditionalParties       := PROJECT( LEFT.IncidentParties, 
																																						TRANSFORM( iesp.midexcompreport.t_MIDEXCompParty, 
																																											 SELF.OtherIdentifyingReferences := [];  // this data is only in nonpublic keys
																																											 SELF             := LEFT ));
																	 SELF.ModifiedDate            := iesp.ECL2ESP.toDatestring8(LEFT.modifiedDate);
																	 SELF.LoadDate                := iesp.ECL2ESP.toDatestring8(LEFT.loadDate);
																	 SELF.FineLevied              := LEFT.FINES_LEVIED;
																	 SELF.AllegedAmount           := LEFT.Alleged_amount;
																	 SELF.EstimatedLoss           := LEFT.Estimated_loss;
																	 SELF                         := LEFT;
																 ));

                
								ds_publicRecsSorted := SORT(ds_publicRecsRaw, MIDEXFileNumber);
						 RETURN ds_publicRecsSorted;
					 END; 
				 END;  // END REPORT_VIEW MODULE

				 
				 EXPORT SEARCH_VIEW := MODULE
												
							EXPORT fn_by_midex_rpt_nums(DATASET (MIDEX_Services.layouts.rec_midex_payloadKeyField) in_midex_rpt_nbrs,
                                          STRING ssnMask, UNSIGNED1 alertVersion = Midex_Services.Constants.AlertVersion.None,
                                          STRING8 StartLoadDate = '' ) := 
								FUNCTION
									in_midexRptNbrsPub := 
										PROJECT( in_midex_rpt_nbrs, 
														 TRANSFORM( MIDEX_Services.layouts.rec_midex_payloadKeyField,
																				SELF.Incident_num := IF( LEFT.PublicIncidentNum = '', 
																																 LEFT.incident_num,
																																 LEFT.PublicIncidentNum
																															 );
																				SELF.Party_num    := IF( LEFT.publicPartyNum = '', 
																																 LEFT.party_num,
																																 LEFT.publicPartyNum
																															 );
																				SELF := LEFT;
																		 ));

                in_PubMidexRptNbrsFiltered := 
                  JOIN( in_midexRptNbrsPub,
                        SANCTN.key_incident_midex,
                        KEYED(LEFT.batch = RIGHT.batch_number AND
                              LEFT.incident_num = RIGHT.incident_number)  AND
                        RIGHT.cln_load_date >= StartLoadDate,
                        TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                   SELF.loadDate := RIGHT.cln_load_date,
                                   SELF          := LEFT,
                                   SELF          := []
                                 ), 
                        KEEP(1));


									// for this join, there can be multiple rows, but everything is duplicated except for the 
                  // party text field and that is not used. We only need to keep one record per midex
                  // report number.
									ds_payloadRecsRaw := 
										 JOIN( in_PubMidexRptNbrsFiltered,
													 SANCTN.key_MIDEX_RPT_NBR,
													 KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
													 TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
                                      SELF.RecordType        := MIDEX_Services.Constants.DATASOURCE_PUBLIC,
																			SELF.firstname         := RIGHT.fname,
																			SELF.middlename        := RIGHT.mname,
																			SELF.lastname          := RIGHT.lname;
																			SELF.suffixname        := RIGHT.name_suffix,
																			SELF.Prefixname        := RIGHT.title,
																			SELF.ssn               := MIDEX_Services.Functions.fn_pubSanctSsnMask(RIGHT.ssNumber, RIGHT.ssn_appended, ssnMask),
																			SELF.CompanyName       := RIGHT.cname,
																			SELF.UniqueId          := IF( RIGHT.DID = 0,
                                                                    (STRING)RIGHT.DID,
                                                                    INTFORMAT(RIGHT.DID,12,1)),
																			SELF.BusinessId        := IF( RIGHT.BDID = 0,
                                                                    (STRING)RIGHT.BDID,
                                                                    INTFORMAT(RIGHT.BDID,12,1)),
																			SELF.BusinessIds			 := RIGHT,
																			SELF.city              := RIGHT.v_city_name,
																			SELF.fips_county       := RIGHT.fips_county,
																			SELF.BATCH             := LEFT.BATCH,
																			SELF.incident_num      := LEFT.incident_num,
																			SELF.party_num         := LEFT.party_num,
																			SELF                   := RIGHT,
																			SELF                   := LEFT, 
																			SELF                   := [],
																		),
													 INNER,
													 KEEP(1),
													 LIMIT(0));  
									
                  census_data.MAC_Fips2County_Keyed(ds_payloadRecsRaw,st,fips_county,county,ds_payloadRecs); 
                
									ds_payloadWithLic := 
										 JOIN( ds_payloadRecs,
													 SANCTN.key_license_midex,
													 KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
													 TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
																			SELF.LicenseType       := RIGHT.std_type_desc;
																			SELF.LicenseNumber     := RIGHT.CLN_LICENSE_NUMBER;
																			SELF.licenseIssueState := RIGHT.LICENSE_STATE;
                                      SELF.isLicenseCurrent  := TRUE; // Public sanctions data is full file replacement and hence, always current
																			SELF                   := LEFT;
																			SELF                   := [];
																		),
													 LEFT OUTER,
                           LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_LICENSES, SKIP));
									
									ds_payloadLicNmls := 
										JOIN( ds_payloadWithLic,
													SANCTN.key_nmls_midex,
													KEYED(LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr),
													TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
																		 SELF.nmlsInfo := DATASET([{RIGHT.license_type, RIGHT.nmls_id}],MIDEX_Services.Layouts.rec_nmlsInfo);
																		 SELF          := LEFT;
																	 ),
													LEFT OUTER,
                          LIMIT(iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS, SKIP));
									
									ds_payloadLicNmlsSorted := SORT(ds_payloadLicNmls, midex_rpt_nbr);
									
									ds_SearchRecs := 
										ROLLUP( ds_payloadLicNmlsSorted, 
														LEFT.midex_rpt_nbr = RIGHT.midex_rpt_nbr,
														TRANSFORM( MIDEX_Services.Layouts.rec_temp_layout,
																			 SELF.nmlsInfo     := IF( COUNT( LEFT.nmlsInfo ) < iesp.Constants.MIDEX.MAX_COUNT_SEARCH_NMLS,
																															 LEFT.nmlsInfo + RIGHT.nmlsInfo,
																															 LEFT.nmlsInfo
																														 ); 
																			 SELF             := LEFT;
																		 ) ); 
									
									recsHash := PROJECT(ds_SearchRecs,MIDEX_Services.alert_calcs.calcMidexSrchHashes(LEFT));
			
									RETURN(IF(alertVersion != Midex_Services.Constants.AlertVersion.None,recsHash,ds_SearchRecs));
									
							END; // function fn_by_midex_rpt_num
				END; // End Search View
			END; // Midex Comprehensive module
 END;