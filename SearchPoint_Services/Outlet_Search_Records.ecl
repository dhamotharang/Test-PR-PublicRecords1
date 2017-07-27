IMPORT AutoHeaderI, autokeyb2, AutokeyI, AutoStandardI, doxie,
       NCPDP, CNLD_Facilities, ut, iesp;
			 
export Outlet_Search_Records := 
MODULE
	  //*** Defining Interface parameters
		EXPORT Iparams := 
			 INTERFACE(
						AutoStandardI.InterfaceTranslator.state_value.params
					 ,AutoStandardI.InterfaceTranslator.zip_value_cleaned.params
					 ,AutoStandardI.InterfaceTranslator.city_value.params
					 ,AutoStandardI.InterfaceTranslator.phone_value.params
					 ,AutoStandardI.InterfaceTranslator.company_name.params
					 ,AutoStandardI.InterfaceTranslator.application_type_val.params				 
					)
				//*** Fields passed in from SearchServices via in_mod and used throughout this attribute.
				EXPORT STRING  deaNum              := '';     // default to null 
				EXPORT STRING  federalTaxId        := '';     // default to null    
				EXPORT STRING  stateLicenseNumber  := '';     // default to null    
				EXPORT STRING  npiNumber           := '';     // default to null    
				EXPORT STRING  ncpdpNumber			   := '';     // default to null				
		END;

		EXPORT resultRecs( Iparams in_mod) := 
				FUNCTION
				
				// ***** Main processing
				// 1. Store passed in fields & options.
				// Store input soap/xml fields into internal shortened attribute names to be used later
				in_phone10     := AutoStandardI.InterfaceTranslator.phone_value.val(in_mod);
				in_state	  	 := AutoStandardI.InterfaceTranslator.state_value.val(in_mod);
				in_zip     		 := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(in_mod);
				in_city    		 := AutoStandardI.InterfaceTranslator.city_value.val(in_mod);
				in_company 		 := AutoStandardI.InterfaceTranslator.company_name.val(in_mod);
				in_appType     := AutoStandardI.InterfaceTranslator.application_type_val.val(in_mod);
				
				STRING  deaNum              := Stringlib.StringtoUpperCase(in_mod.deaNum);           // can't rename to deaNumber or you'll get a name collision with the key file
				STRING  federalTaxId        := Stringlib.StringtoUpperCase(in_mod.federalTaxId);
				STRING  stateLicenseNumber  := Stringlib.StringtoUpperCase(in_mod.stateLicenseNumber);
				STRING  npiNumber           := Stringlib.StringtoUpperCase(in_mod.npiNumber);
				STRING  ncpdpNumber				  := Stringlib.StringtoUpperCase(in_mod.ncpdpNumber);
												
												
				//*** iesp out layout temp
				layout_iesp_outletSummary_temp := record
						iesp.searchpoint.t_SearchPointOutletSummary;
						string8 dt_last_seen;
				end;
				
				//*** Local functions.
				//*** Company penalty function
				get_companyname_penalty(string in_company_name, string matched_company_name) :=
					FUNCTION
						RETURN ut.mod_penalize.company_name(in_company_name, matched_company_name);
				END;
				
				//*** Address penalty function
				get_address_penalty(layout_iesp_outletSummary_temp le) :=
					FUNCTION

						mod_input_address := MODULE(ut.mod_penalize.IGenericAddress)
							EXPORT p_city_name := in_city; 
							EXPORT st          := in_state;
						END;

						mod_matched_address := MODULE(ut.mod_penalize.IGenericAddress)
							EXPORT p_city_name := le.address.city;
							EXPORT st          := le.address.state;
						END;
						
						RETURN ut.mod_penalize.address(mod_input_address, mod_matched_address);
				END;
				
				//*** Phone penalty function
				get_phone_penalty(string10 in_phone_num, string10 matched_phone_num) := function
						return ut.mod_penalize.phone(in_phone_num, matched_phone_num);
				end;

				//*** Header field declare.
				doxie.MAC_Header_Field_Declare()

				
				/* ****************************************

								Get Biz header data 
							
				**************************************** */			
				//*** Doing a header search with the given Phone# or name or city, state and zip for bdids.
				tempmod := 
					 MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoHeaderI.LIBIN.FetchI_Hdr_Biz.FULL, OPT ) )
					 EXPORT forceLocal := TRUE;
					 EXPORT noFail     := FALSE;
				 END;
			
				 //*** Header bdids
				ds_Header_bdids := AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do( tempmod );
				
			
				/* ****************************************

								Get	NCPDP data 
							
				**************************************** */	
				//*** NCPDP keys
				NCPDP_Dea_Key			 					:= NCPDP.key_DEA;
				NCPDP_ProviderID	 					:= NCPDP.key_ProviderID;
				NCPDP_FEIN_key		 					:= NCPDP.key_FEIN;
				NCPDP_NPI_Key			 					:= NCPDP.key_NPI;
				NCPDP_SLN_Key								:= NCPDP.key_SLN_State;
				NCPDP_BDID_Key		 					:= NCPDP.key_BDID;		
				NCPDP_DBA_Mail_payload_Key	:= NCPDP.key_AutokeyPayload_DBAMail;
				NCPDP_DBA_Phys_payload_Key	:= NCPDP.key_AutokeyPayload_DBAPhys;
				
				
				//*** NCPDP Dea search
				get_NCPDP_DeaSearch_recs := NCPDP_Dea_Key(keyed(dea_registration_id =  trim(deaNum)));
				
				Layout_NCPDP_ProviderId := RECORD
					 STRING7 NCPDP_provider_id;
				END;
				
				NCPDP_pids_by_Dea := PROJECT( get_NCPDP_DeaSearch_recs, Layout_NCPDP_ProviderId );
				
				//*** Fereral Tax id search
				get_NCPDP_FEIN_Search_recs := NCPDP_FEIN_key(keyed(federal_tax_id = Stringlib.StringFilterOut(federalTaxId, '-')));
				
				//*** Search NCPDP file for given taxid.
				NCPDP_pids_by_taxid := PROJECT(get_NCPDP_FEIN_Search_recs, Layout_NCPDP_ProviderId);

				//*** NPI number search
				get_NCPDP_NPI_Search_recs := NCPDP_NPI_key(keyed(national_provider_id = trim(npiNumber)));
				
				//*** Search NCPDP file for given NPI number.
				NCPDP_pids_by_NPI := PROJECT(get_NCPDP_NPI_Search_recs, Layout_NCPDP_ProviderId);


				//*** State License number search
				get_NCPDP_SLN_Search_recs := IF (in_state = '',
																				 NCPDP_SLN_key(keyed(state_license_number = trim(stateLicenseNumber))),
																				 NCPDP_SLN_key(keyed(state_license_number = trim(stateLicenseNumber) and Phys_state = trim(in_state)))
																				);
				
				//*** Search NCPDP file for a given License number.
				NCPDP_pids_by_SLN := PROJECT(get_NCPDP_SLN_Search_recs, Layout_NCPDP_ProviderId );

				
				//*** Using updated autokey calls for NCPDP fids
				NCPDP_DBA_Phys_tempmod := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
					EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Mail_AUTOKEY_NAME;
					EXPORT STRING typestr              := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Mail_TYPE_STR;
					EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Mail_AUTOKEY_SKIP_SET;
					EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.NCPDP_AutoKey.WORK_HARD;
					EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.NCPDP_AutoKey.NO_FAIL;
					EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.NCPDP_AutoKey.USE_ALL_LOOKUPS;
				END;
				
				//*** Getting fids from the DBA physical address autokey search.
				ds_NCPDP_Phys_fdids := AutoKeyI.AutoKeyStandardFetch(NCPDP_DBA_Phys_tempmod).ids;
				
				// Using updated autokey calls for NCPDP fids
				NCPDP_DBA_Mail_tempmod := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
					EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Phys_AUTOKEY_NAME;
					EXPORT STRING typestr              := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Phys_TYPE_STR;
					EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Phys_AUTOKEY_SKIP_SET;
					EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.NCPDP_AutoKey.WORK_HARD;
					EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.NCPDP_AutoKey.NO_FAIL;
					EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.NCPDP_AutoKey.USE_ALL_LOOKUPS;
				END;
				
				//*** Getting fids from the DBA mailing address autokey search.
				ds_NCPDP_Mail_fdids := AutoKeyI.AutoKeyStandardFetch(NCPDP_DBA_Mail_tempmod).ids;
								
				ds_NCPDP_fdids := ds_NCPDP_Phys_fdids + ds_NCPDP_Mail_fdids;
				
				//*** Temp layout for phone penalty calculation
				Layout_autokey_phone_penalty := record
						Layout_NCPDP_ProviderId;
						string10 business_phone;
						unsigned2 phone_penality := 0;
				end;
				
				Layout_autokey_phone_penalty get_NCPDP_DBA_Phys_Autokey_pids(NCPDP_DBA_Phys_payload_Key r) := TRANSFORM
						SELF.phone_penality := if( trim(r.business_phone) != '' and 
																			 trim(in_phone10)				!= '', get_phone_penalty(in_phone10, r.business_phone), 0 );						
						SELF 								:= r;
				END;
				

				//*** DBA Physical addresses
				NCPDP_DBA_Phys_pids_by_Autokey := JOIN(ds_NCPDP_Phys_fdids, NCPDP_DBA_Phys_payload_Key,
																							 keyed(LEFT.id = RIGHT.fakeid),
																							 get_NCPDP_DBA_Phys_Autokey_pids(right)
																							);
				
				Layout_autokey_phone_penalty get_NCPDP_DBA_Mail_Autokey_pids(NCPDP_DBA_Mail_payload_Key r) := TRANSFORM
						 SELF.phone_penality := if( trim(r.business_phone) != '' and 
																				trim(in_phone10) 			 != '', get_phone_penalty(in_phone10, r.business_phone), 0 );
						 SELF 							 := r;
				END;

				//*** DBA Mail addresses
				NCPDP_DBA_Mail_pids_by_Autokey := JOIN(ds_NCPDP_Mail_fdids, NCPDP_DBA_Mail_payload_Key,
																								keyed(LEFT.id = RIGHT.fakeid),
																								get_NCPDP_DBA_Mail_Autokey_pids(right)
																							);
																							
				//*** Filtering the autokey phone search records based on the penality.
				NCPDP_DBA_pids_by_Autokey := project(NCPDP_DBA_Phys_pids_by_Autokey(phone_penality < AutoStandardI.GlobalModule().penalty_threshold) + 
																						 NCPDP_DBA_Mail_pids_by_Autokey(phone_penality < AutoStandardI.GlobalModule().penalty_threshold),
																						 transform(Layout_NCPDP_ProviderId, self := left)
																						);
				
								
				//*** Zipcode only search
				autokey_zip := autokeyb2.key_zip(SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Mail_AUTOKEY_NAME) +
											 autokeyb2.key_zip(SearchPoint_Services.Constants.NCPDP_AutoKey.DBA_Phys_AUTOKEY_NAME);
											 
				get_NCPDP_ZipSearch_recs := autokey_zip( KEYED(zip = (integer)in_zip) );
				

				//*** Zip addresses
				NCPDP_pids_by_Zipcode    := JOIN(get_NCPDP_ZipSearch_recs, NCPDP_DBA_Phys_payload_Key,
																				 keyed(LEFT.bdid = RIGHT.fakeid),
																				 transform(Layout_NCPDP_ProviderId, self := right)
																				);
				
				
				//*** Business header search to get the NCPDP records by BDID.
				//*** Joining Business Header searched records to get the providerid's
				NCPDP_pids_by_BH_BDID := JOIN(ds_Header_bdids, NCPDP_BDID_Key,
																			keyed(LEFT.bdid = RIGHT.bdid),
																			transform(Layout_NCPDP_ProviderId, self := right)
																		 );	
				
				NCPDP_out_rec := NCPDP.Layouts.Keybuild;
				
				//*** NCPDP number search
				get_NCPDP_NCPDP_Search_recs := project(NCPDP_ProviderID(keyed(NCPDP_provider_id = trim(ncpdpNumber))),
																							 transform(NCPDP_out_rec, self := left)
																							);

				//*** get all provider ids
				NCPDP_pids_raw := MAP( deaNum 	 		 			!= '' => IF(COUNT( NCPDP_pids_by_Dea ) > 0,	
																															NCPDP_pids_by_Dea, dataset([],Layout_NCPDP_ProviderId)),
															 federalTaxId  			!= '' => IF(COUNT( NCPDP_pids_by_taxid ) > 0,
																															NCPDP_pids_by_taxid, dataset([],Layout_NCPDP_ProviderId)),
															 npiNumber 	 	 			!= '' => IF(COUNT( NCPDP_pids_by_NPI ) > 0,	
																															NCPDP_pids_by_NPI, dataset([],Layout_NCPDP_ProviderId)),
															 stateLicenseNumber != '' => IF(COUNT( NCPDP_pids_by_SLN ) > 0,
																															NCPDP_pids_by_SLN, dataset([],Layout_NCPDP_ProviderId)),
															 in_zip				 			!= '' and 
															 in_company					 = '' => IF(COUNT( NCPDP_pids_by_Zipcode ) > 0,	
																															NCPDP_pids_by_Zipcode, dataset([],Layout_NCPDP_ProviderId)),
															 IF( COUNT( NCPDP_DBA_pids_by_Autokey ) > 0, NCPDP_DBA_pids_by_Autokey, NCPDP_pids_by_BH_BDID)
															 //**** default record set
														 );

				
				NCPDP_uniq_pids := DEDUP( SORT( NCPDP_pids_raw, NCPDP_provider_id ), NCPDP_provider_id);
				
				
				//*** NCPDP Search
				NCPDP_Search_recs := if(trim(ncpdpNumber) != '', 
																	get_NCPDP_NCPDP_Search_recs,
																	JOIN(NCPDP_uniq_pids, NCPDP_ProviderID, 
																		KEYED( LEFT.NCPDP_provider_id = RIGHT.NCPDP_provider_id),
																		transform(NCPDP_out_rec, self :=  right)
																	)														 
																);
				
				//*** Mapping NCPDP searched records to response layout.
				layout_iesp_outletSummary_temp xfm_summary_NCPDP_info (NCPDP_Search_recs l) :=
				TRANSFORM
						 
				 self.OutletID								:= trim(l.NCPDP_provider_id);
				 self.organizationName  			:= Stringlib.StringFilterOut(trim(l.dba),'0123456789');
				 self.address.StreetAddress1	:= l.Phys_prim_range +' '+ l.Phys_predir +' '+ l.Phys_prim_name +' '+ l.Phys_addr_suffix +' '+ l.Phys_postdir;
				 self.address.StreetAddress2	:= l.Phys_unit_desig +' '+ l.Phys_sec_range;
				 self.address.city						:= l.Phys_p_city_name;
				 self.address.state						:= l.Phys_state;
				 self.dt_last_seen						:= intformat(l.Dt_last_seen,8,1);
				 self 												:= [];
				END;

				
				NCPDP_SearchResults  := PROJECT( NCPDP_Search_recs, xfm_summary_NCPDP_info( LEFT ) );

				/* ****************************************

								Get CNLD Data
							
				**************************************** */
				CNLD_fein_key 		 		:= CNLD_Facilities.key_fein;
				CNLD_Dea_Key			 		:= CNLD_Facilities.key_dea;
				CNLD_NPI_Key			 		:= CNLD_Facilities.key_npi;
				CNLD_Gennum_Key		 		:= CNLD_Facilities.key_gennum;
				CNLD_NCPDP_Key 		 		:= CNLD_Facilities.key_ncpdp;
				CNLD_LicenseNbr_Key		:= CNLD_Facilities.key_license_nbr;
				CNLD_Auto_Payload_Key := CNLD_Facilities.key_autokey_payload;
				CNLD_BDID_Key			 		:= CNLD_Facilities.key_BDID;

				//*** CNLD Gennum layout
				Layout_CNLD_Gennum := RECORD
					 string10 gennum;
				END;
				
				//*** DEA Search
				get_Cnld_DeaSearch_recs := CNLD_Dea_Key(keyed(deanbr = trim(deaNum)));

				//*** get gennums by dea number
				CNLD_Gennum_by_Dea := PROJECT( get_Cnld_DeaSearch_recs, Layout_CNLD_Gennum );

					
				//*** get gennums by taxid
				Layout_CNLD_Gennum get_CNLD_fein_gennum(CNLD_fein_key l) := TRANSFORM
						 SELF.gennum := l.gennum;
				END;

				CLND_gennum_by_taxid := PROJECT(CNLD_fein_key(keyed(cln_ssn_taxid=federalTaxId)),
																				get_CNLD_fein_gennum( LEFT )
																			 );
				
				//*** NPI Number Search
				get_Cnld_NPI_Search_recs := CNLD_NPI_Key(keyed(npi = trim(npiNumber)));

				//*** get gennums by NPI number
				CNLD_Gennum_by_NPI := PROJECT( get_Cnld_NPI_Search_recs, Layout_CNLD_Gennum );
				
				//*** NCPDP Number Search
				get_Cnld_NCPDP_Search_recs := CNLD_NCPDP_Key(keyed(ncpdpnbr = trim(ncpdpNumber)));

				//*** get gennums by NCPDP number
				CNLD_Gennum_by_NCPDP := PROJECT( get_Cnld_NCPDP_Search_recs, Layout_CNLD_Gennum );
				
				
				//*** State License Number Search
				get_Cnld_LicNum_Search_recs := if (trim(in_state) = '',
																					 CNLD_LicenseNbr_Key(keyed(st_lic_num = trim(stateLicenseNumber))),
																					 CNLD_LicenseNbr_Key(keyed(st_lic_num = trim(stateLicenseNumber) and st_lic_in = trim(in_state)))
																					);

				//*** get gennums by License number	
				CNLD_Gennum_by_SLN := PROJECT( get_Cnld_LicNum_Search_recs, Layout_CNLD_Gennum );


				//*** Using updated autokey calls for CNLD fids and dids/bdids
				CNLD_tempmod := 
					MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoKeyI.AutoKeyStandardFetchArgumentInterface,OPT ) ) 
					EXPORT STRING autokey_keyname_root := SearchPoint_Services.Constants.CnldAutoKey.AUTOKEY_NAME;
					EXPORT STRING typestr              := SearchPoint_Services.Constants.CnldAutoKey.TYPE_STR;
					EXPORT SET OF STRING1 get_skip_set := SearchPoint_Services.Constants.CnldAutoKey.AUTOKEY_SKIP_SET;
					EXPORT BOOLEAN workHard            := SearchPoint_Services.Constants.CnldAutoKey.WORK_HARD;
					EXPORT BOOLEAN noFail              := SearchPoint_Services.Constants.CnldAutoKey.NO_FAIL;
					EXPORT BOOLEAN useAllLookups       := SearchPoint_Services.Constants.CnldAutoKey.USE_ALL_LOOKUPS;
				END;
				
				//*** Getting fids from the autokey search.
				ds_CNLD_fdids := AutoKeyI.AutoKeyStandardFetch(CNLD_tempmod).ids;
				
				//*** Temp layout for penalty calculation
				Layout_CNLD_phone_penalty := record
						Layout_CNLD_Gennum;
						string10 	addr_phone;
						unsigned2 phone_penality := 0;
				end;
				
				Layout_CNLD_phone_penalty get_CNLD_Autokey_gennums(CNLD_Auto_Payload_Key r) := TRANSFORM
						 SELF.phone_penality := if( trim(r.addr_phone)!= '' and 
																				trim(in_phone10) 	!= '', get_phone_penalty(in_phone10, r.addr_phone), 0 );
						 SELF := r;
				END;

				//*** Apply Phone penalty calualtions for phone autokey searched records
				CNLD_Gennum_by_Autokey_w_penality := JOIN(ds_CNLD_fdids, CNLD_Auto_Payload_Key,
																									keyed(LEFT.id = RIGHT.fakeid),
																									get_CNLD_Autokey_gennums(right)
																								 );
																									
				//*** Filtering the autokey phone search records based on the penality.
				CNLD_Gennum_by_Autokey := project(CNLD_Gennum_by_Autokey_w_penality(phone_penality < AutoStandardI.GlobalModule().penalty_threshold),
																					transform(Layout_CNLD_Gennum, self := left)
																				 );

				//*** Zipcode only search
				CNLD_autokey_zip := autokeyb2.key_zip(SearchPoint_Services.Constants.CnldAutoKey.AUTOKEY_NAME);
											 
				get_CNLD_ZipSearch_recs := CNLD_autokey_zip( KEYED(zip = (integer)in_zip) );

				//*** Zip addresses
				CNLD_Gennums_by_Zipcode    := JOIN(get_CNLD_ZipSearch_recs, CNLD_Auto_Payload_Key,
																					 keyed(LEFT.bdid = RIGHT.fakeid),
																					 transform(Layout_CNLD_Gennum, self := right)
																					);
				
				
				//*** Business Header Search by BDID
				CNLD_Gennum_by_BH_BDID := JOIN(ds_Header_bdids, CNLD_BDID_Key,
																			 keyed(LEFT.bdid = RIGHT.bdid),
																			 transform(Layout_CNLD_Gennum, self := right)																				
																			);	
				
																
				//*** Get all gennum's
				gennum_raw := MAP( deaNum    		 			 != '' => IF( COUNT( CNLD_Gennum_by_Dea ) > 0,
																													CNLD_Gennum_by_Dea, dataset([],Layout_CNLD_Gennum)),								
													 federalTaxId  			 != '' => IF( COUNT( CLND_gennum_by_taxid ) > 0,
																													CLND_gennum_by_taxid, dataset([],Layout_CNLD_Gennum)),
													 npiNumber		 			 != '' => IF( COUNT( CNLD_Gennum_by_NPI ) > 0,
																													CNLD_Gennum_by_NPI, dataset([],Layout_CNLD_Gennum)),
													 ncpdpNumber	 			 != '' => IF( COUNT( CNLD_Gennum_by_NCPDP ) > 0,
																													CNLD_Gennum_by_NCPDP, dataset([],Layout_CNLD_Gennum)),
													 stateLicenseNumber	 != '' => IF( COUNT( CNLD_Gennum_by_SLN ) > 0,
																													CNLD_Gennum_by_SLN, dataset([],Layout_CNLD_Gennum)),
													 in_zip			   			 != '' and 
													 in_company						= '' => IF( COUNT( CNLD_Gennums_by_Zipcode ) > 0,	
																													CNLD_Gennums_by_Zipcode, dataset([],Layout_CNLD_Gennum)),
													 IF( COUNT( CNLD_Gennum_by_Autokey ) > 0, CNLD_Gennum_by_Autokey, CNLD_Gennum_by_BH_BDID) 
													 //**** default record set
												 );
				
				CNLD_Gennums := DEDUP( SORT( gennum_raw, gennum ), gennum);	
				
				CNLD_out_rec := CNLD_Facilities.layout_Facilities_AID_schd;

				CNLD_Search_recs := JOIN(CNLD_Gennums, CNLD_Gennum_Key, 
																 KEYED( LEFT.gennum = RIGHT.gennum),
																 transform(CNLD_out_rec, self := right)
																);
																	 
				//*** Mapping CNLD searched records to response output layout.										 
				layout_iesp_outletSummary_temp xfm_summary_cnld_info (CNLD_Search_recs l) :=
				TRANSFORM
			
					 self.outletID								:= trim(l.gennum);
					 SELF.organizationName  			:= trim(l.org_name);
					 self.address.StreetAddress1	:= l.PRIM_RANGE + ' ' + l.PREDIR + ' ' + l.PRIM_NAME + ' ' + l.ADDR_SUFFIX + ' ' + l.POSTDIR;
					 self.address.StreetAddress2	:= l.UNIT_DESIG + ' ' + l.SEC_RANGE;
					 self.address.city						:= l.P_CITY_NAME;
					 self.address.state						:= l.ST;
					 self.dt_last_seen						:= l.last_seen_date;
					 SELF 												:= [];
				END;

				CNLD_SearchResults  := PROJECT( CNLD_Search_recs, xfm_summary_cnld_info( LEFT ) );
				
				outlet_search_results := dedup(dedup(sort(CNLD_SearchResults, outletId, organizationName, address.StreetAddress1, address.StreetAddress2, address.city, address.state, -dt_last_seen), record) + 
																			 dedup(sort(NCPDP_SearchResults, outletId, organizationName, address.StreetAddress1, address.StreetAddress2, address.city, address.state, -dt_last_seen), record),
																			 record, except outletid, dt_last_seen, all);
				
				//*** Temp layout for penality calculation
				layout_penality := record
						layout_iesp_outletSummary_temp;
						unsigned2 comp_name_penalty;
						unsigned2 address_penalty;
						string  	in_address;
						string  	match_address;
				end;
				
				//*** project all the records and calculate the company name and address penality.
				by_all_penalized := 
				project(
					outlet_search_results,
					TRANSFORM( layout_penality,
						SELF.comp_name_penalty     := IF( TRIM(LEFT.organizationName) != '', get_companyname_penalty(in_company,left.organizationName), 0 ),
						SELF.address_penalty       := IF( TRIM(LEFT.address.city) != '', get_address_penalty(left)    , 0 ),
						SELF.in_address						 := trim(in_city) + ' ' + trim(in_state); 
						SELF.match_address				 := trim(left.address.city) + ' ' + trim(left.address.state);
						SELF                       := left;
					)					
				);

				//*** Sort the penalized records by company name pernalty and adress penalty
				by_all_penalized_srt := sort(by_all_penalized, comp_name_penalty, address_penalty, record);
				
				//*** Filter the records that are less than the default penalty value.
				recs := project(by_all_penalized_srt( (comp_name_penalty + address_penalty) < AutoStandardI.GlobalModule().penalty_threshold ),
												transform(iesp.searchpoint.t_SearchPointOutletSummary, self := left)
											 );
															
				RETURN recs;

		END;
end; // end of Search_records module