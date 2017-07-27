IMPORT Address, AutoStandardI, doxie,
       doxie_files, ingenix_natlprof, NCPDP, CNLD_Facilities, dea, ut, iesp;
			 
export Outlet_Report_Records := 
MODULE
	  //*** Defining Interface parameters
		EXPORT Iparams := interface(
				AutoStandardI.InterfaceTranslator.application_type_val.params)
			
				//*** Fields passed in from ReportServices via in_mod and used throughout this attribute.
				EXPORT STRING  Gennum              := '';     // default to null 
		END;

		EXPORT resultRecs( Iparams in_mod) := 
			FUNCTION
				
				// ***** Main processing
				STRING  in_Gennum              := Stringlib.StringtoUpperCase(in_mod.Gennum); 
											
				//*** iesp out layout temp
				layout_iesp_outlet_Report_temp := record
						iesp.searchpoint.t_SearchPointOutlet;
						string8 dt_last_seen;
				end;
				
				//*** Header field declare.
				doxie.MAC_Header_Field_Declare()

				
				/* ****************************************

								Get	NCPDP data 
							
				**************************************** */	
				//*** NCPDP keys
				NCPDP_ProviderID	 					:= NCPDP.key_ProviderID;
				NCPDP_BDID_Key		 					:= NCPDP.key_BDID;
				
				
				//*** get NCPDP gennum searched records.
				get_NCPDP_recs := NCPDP_ProviderID(keyed(NCPDP_provider_id = trim(in_gennum,left,right)));
				
				//*** Transforming Child Outlet Address.
				NCPDP_Child_OutletAddress := project(get_NCPDP_recs, 
																						 transform(iesp.searchpoint.t_SearchPointAddress, 
																											 self.StreetAddress1 := StringLib.StringCleanSpaces(left.Phys_prim_range +' '+ 
																																																					left.Phys_predir +' '+ 
																																																					left.Phys_prim_name +' '+ 
																																																					left.Phys_addr_suffix +' '+ 
																																																					left.Phys_postdir);
																											 self.StreetAddress2 := StringLib.StringCleanSpaces(left.Phys_unit_desig +' '+ 
																																																					left.Phys_sec_range);
																											 self.City 					 := left.Phys_p_city_name;
																											 self.State 				 := left.Phys_state;
																											 self.Zip5					 := left.Phys_zip5;
																											 self.Phone					 := IF( LENGTH(TRIM(left.phys_loc_phone, LEFT, RIGHT)) = 10,
                                                                                  left.phys_loc_phone[1..3] + '-' + left.phys_loc_phone[4..6] + '-' + left.phys_loc_phone[7..10],
                                                                                  IF( LENGTH(TRIM(left.phys_loc_phone, LEFT, RIGHT)) = 7,
                                                                                      left.phys_loc_phone[1..3] + '-' + left.phys_loc_phone[4..7],
                                                                                      left.phys_loc_phone
                                                                                    )
                                                                                );
																											 self.Fax						 := IF( LENGTH(TRIM(left.phys_loc_fax_number, LEFT, RIGHT)) = 10,
                                                                                  left.phys_loc_fax_number[1..3] + '-' + left.phys_loc_fax_number[4..6] + '-' + left.phys_loc_fax_number[7..10],
                                                                                  IF( LENGTH(TRIM(left.phys_loc_fax_number, LEFT, RIGHT)) = 7,
                                                                                      left.phys_loc_fax_number[1..3] + '-' + left.phys_loc_fax_number[4..7],
                                                                                      left.phys_loc_fax_number
                                                                                    )
                                                                                );
																											 self.AddressType		 := 'PHYSICAL';
																											 self								 := [];																								 
																											)
																						);
																						
				NCPDP_Child_OutletAddress_dedp := dedup(NCPDP_Child_OutletAddress, all);
				
				//*** Transforming Child Outlet DEA number.
				NCPDP_Child_OutletDEANum := join( get_NCPDP_recs,
																					dea.Key_dea_reg_num,
																					keyed( left.DEA_registration_id = right.dea_registration_number ),
																					transform(iesp.searchpoint.t_SearchPointDEANumber,
																										self.DEAAddress.StreetAddress1 := Address.Addr1FromComponents( right.prim_range, right.predir, right.prim_name, right.addr_suffix, right.postdir, '' , '' ); 
																										self.DEAAddress.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', right.unit_desig, right.sec_range );  
																										self.DEAAddress.City           := right.p_city_name;
																										self.DEAAddress.State          := right.st;
																										self.DEAAddress.Zip5           := right.zip;
																										self.ExpirationDate            := iesp.ECL2ESP.toDate ((integer)right.expiration_date );
																										self.Number                    := if(right.dea_registration_number <> '', right.dea_registration_number, left.DEA_registration_id);
																										self.Schedule                  := SearchPoint_Services.Functions.convertDeaSched(right.drug_schedules);
																										self                           := [];
																									 ), left outer
																				);
																						

																						
				NCPDP_Child_OutletDEANum_dedp := dedup(sort(NCPDP_Child_OutletDEANum, DEAAddress.StreetAddress1, DEAAddress.StreetAddress2, DEAAddress.City, DEAAddress.State, Number, Schedule, -ExpirationDate),
																							 record, except ExpirationDate.Month, ExpirationDate.Day, ExpirationDate.Year );
				
																						
				//*** Transforming Child Outlet Federal Tax Id number.
				NCPDP_Child_OutletFedNum := project(get_NCPDP_recs, 
																						 transform(iesp.searchpoint.t_SearchPointFederalNumber, 
																											 self.Number		:= left.federal_tax_id;
																											 self._Type			:= '';
																											 self						:= [];																								 
																											)
																						);
				
				NCPDP_Child_OutletFedNum_dedp := dedup(NCPDP_Child_OutletFedNum, all);
				
				//*** Transforming Child Outlet State License number.
				NCPDP_Child_OutletStLicNum := project(get_NCPDP_recs, 
																							 transform(iesp.searchpoint.t_SearchPointStateLicense,
																												 self.ExpirationDate.Year 	:= 0;
																												 self.ExpirationDate.Month 	:= 0;
																												 self.ExpirationDate.Day 		:= 0;
																												 self.Number								:= left.state_license_number;
																												 self.State									:= '';
																												 self.Status								:= '';
																												 self._Type									:= '';
																												 self												:= [];																								 
																												)
																							);
																							
				
				NCPDP_Child_OutletStLicNum_dedp := dedup(NCPDP_Child_OutletStLicNum, all);
				
				//*** Transforming Child Outlet Sanctions.
				layout_NCPDP_sanctions := record
						unsigned6 SANC_ID;
						recordof(get_NCPDP_recs);
				end;
				
				//*** getting the Sanctions information from the Ingenix Sanctions file.
				Sanc_id_NCPDP_recs := join(get_NCPDP_recs, 
																	 Ingenix_NatlProf.Key_sanctions_bdid,
																	 keyed(left.bdid = right.bdid),
																	 transform(layout_NCPDP_sanctions,
																		 				 self.sanc_id := (unsigned6)right.sanc_id;
																						 self				 	:= left;												
																						)
																	 );
				
				NCPDP_Child_OutletSanction := join(Sanc_id_NCPDP_recs,
																					 doxie_files.key_sanctions_sancid,
																					 keyed(left.sanc_id = right.l_sancid),
																					 transform(iesp.searchpoint.t_SearchPointSanction,
																										 self.Amount							:= right.sanc_fines;
																										 self.SanctionDate			 	:= iesp.ECL2ESP.toDate ((integer)right.sanc_sancdte_form);
																										 self.SanctionSource			:= right.sanc_src_desc;
																										 self.SanctionType				:= right.sanc_type;
																										 self.State								:= right.sanc_sancst;
																										 self											:= [];																								 
																									 )
																					 );

				NCPDP_Child_OutletSanction_dedp := dedup(NCPDP_Child_OutletSanction, all);
				
				//*** Mapping NCPDP searched records to response layout.
				layout_iesp_outlet_Report_temp xfm_NCPDP_Report_info (get_NCPDP_recs l) :=	TRANSFORM

				 self.chain										:= map(trim(l.dispenser_class_code,left,right) = '01' => 'NO',
																						 trim(l.dispenser_class_code,left,right) = '02' => 'YES',
																						 'NO'
																						);
				 self.chainid									:= (string)(integer)l.store_number;
				 self.outletType							:= '';
				 self.hospitalLocation  			:= 'NO';
				 self.ownerName    						:= if (l.contact_title[1..5] = 'OWNER', 
																						 trim(l.contact_last_name,left,right) + ' ' +
																						 trim(l.contact_first_name,left,right) + ' ' +
																						 trim(l.contact_middle_initial,left,right), ''																	
																						);
				 self.ncpdpNumber							:= trim(l.NCPDP_provider_id,left,right);
				 self.npiNumber								:= trim(l.national_provider_id,left,right);
				 
				 self.organizationName  			:= Stringlib.StringFilterOut(trim(l.dba,left,right),'0123456789');
				 self.OutletAddressList				:= NCPDP_Child_OutletAddress_dedp;
				 self.OutletDEANumberList			:= NCPDP_Child_OutletDEANum_dedp;
				 self.FederalNumberList				:= NCPDP_Child_OutletFedNum_dedp;
				 self.StateLicenseList				:= NCPDP_Child_OutletStLicNum_dedp;
				 self.SanctionList						:= NCPDP_Child_OutletSanction_dedp;
				 self.dt_last_seen						:= intformat(l.Dt_last_seen,8,1);
				 self 												:= [];
				END;

				NCPDP_SearchResults  := PROJECT( get_NCPDP_recs, xfm_NCPDP_Report_info( LEFT ) );

				/* ****************************************

								Get CNLD Data
							
				**************************************** */
				CNLD_Gennum_Key		 		:= CNLD_Facilities.key_gennum;
				CNLD_NCPDP_Key 		 		:= CNLD_Facilities.key_ncpdp;
				CNLD_BDID_Key			 		:= CNLD_Facilities.key_BDID;

				factype_desc(string code) := function
						result :=  map (trim(code,left,right) = '0'  => '',
														trim(code,left,right) = '2'  => 'SNF/NF Dual Certification',
														trim(code,left,right) = '3'  => 'SNF/NF Distinct Part',
														trim(code,left,right) = '4'  => 'Skilled Nursing Facility',
														trim(code,left,right) = '10' => 'Nursing Facility',
														trim(code,left,right) = '20' => 'Other',
														trim(code,left,right) = '21' => 'Unknown',
														trim(code,left,right) = '22' => 'Clinic',
														trim(code,left,right) = '23' => 'DME Supplier', 
														trim(code,left,right) = '24' => 'Employer Clinic',
														trim(code,left,right) = '25' => 'HMO',
														trim(code,left,right) = '26' => 'Hospital Other',
														trim(code,left,right) = '27' => 'State Hospital',
														trim(code,left,right) = '28' => 'VA Hospital',
														trim(code,left,right) = '29' => 'Institution',
														trim(code,left,right) = '30' => 'Indian Health Services',
														trim(code,left,right) = '31' => 'Long Term Care',
														trim(code,left,right) = '32' => 'Mail Order',
														trim(code,left,right) = '33' => 'Retail',
														trim(code,left,right) = '34' => 'Wholesale/Mfg',
														trim(code,left,right) = '35' => 'IV Infusion',
														trim(code,left,right) = '36' => 'Department Store',
														trim(code,left,right) = '37' => 'Grocery Store',
														trim(code,left,right) = '38' => 'Dispensing Physician',
														trim(code,left,right) = '39' => 'Hospice',
														''
													 );
						return result;
				end;

				
				//*** DEA Search
				get_Cnld_Gennum_recs := CNLD_Gennum_Key(keyed(gennum = trim(in_gennum,left,right)));
				
				//*** Transforming Child Outlet Address.
				Cnld_Child_OutletAddress := project(get_Cnld_Gennum_recs, 
																						 transform(iesp.searchpoint.t_SearchPointAddress, 
																											 self.StreetAddress1 := StringLib.StringCleanSpaces(left.PRIM_RANGE + ' ' + 
																																																					left.PREDIR + ' ' + 
																																																					left.PRIM_NAME + ' ' + 
																																																					left.ADDR_SUFFIX + ' ' +
																																																					left.POSTDIR);
																											 self.StreetAddress2 := StringLib.StringCleanSpaces(left.UNIT_DESIG + ' ' + 
																																																					left.SEC_RANGE);
																											 self.City 					 := left.P_CITY_NAME;
																											 self.State 				 := left.ST;
																											 self.Zip5					 := left.zip5;
																											 self.Phone					 := IF( LENGTH(TRIM(left.addr_phone, LEFT, RIGHT)) = 10,
                                                                                  left.addr_phone[1..3] + '-' + left.addr_phone[4..6] + '-' + left.addr_phone[7..10],
                                                                                  IF( LENGTH(TRIM(left.addr_phone, LEFT, RIGHT)) = 7,
                                                                                      left.addr_phone[1..3] + '-' + left.addr_phone[4..7],
                                                                                      left.addr_phone
                                                                                    )
                                                                                );
																											 self.Fax						 := IF( LENGTH(TRIM(left.addr_fax, LEFT, RIGHT)) = 10,
                                                                                  left.addr_fax[1..3] + '-' + left.addr_fax[4..6] + '-' + left.addr_fax[7..10],
                                                                                  IF( LENGTH(TRIM(left.addr_fax, LEFT, RIGHT)) = 7,
                                                                                      left.addr_fax[1..3] + '-' + left.addr_fax[4..7],
                                                                                      left.addr_fax
                                                                                    )
                                                                                );
																											 self.Status				 := IF( LEFT.addr_status = 'A',
                                                                                  'ACTIVE',
                                                                                  IF(LEFT.addr_status = 'I',
                                                                                     'INACTIVE',
                                                                                     LEFT.addr_status
                                                                                    ));
																											 self.AddressRank		 := left.addr_rank;
																											 self.AddressType		 := 'PHYSICAL';
																											 self								 := [];																								 
																											)
																						);
				
				Cnld_Child_OutletAddress_dedp := dedup(sort(Cnld_Child_OutletAddress, record), record, except AddressRank);
				
				//*** Transforming Child Outlet DEA number.
				Cnld_Child_OutletDEANum := join( get_Cnld_Gennum_recs,
																				 dea.Key_dea_reg_num,
																				 keyed( left.DEAnbr = right.dea_registration_number ),
																				 transform( iesp.searchpoint.t_SearchPointDEANumber,
																										self.DEAAddress.StreetAddress1 := Address.Addr1FromComponents( right.prim_range, right.predir, right.prim_name, right.addr_suffix, right.postdir, '' , '' ); 
																										self.DEAAddress.StreetAddress2 := Address.Addr1FromComponents( '', '', '', '', '', right.unit_desig, right.sec_range );  
																										self.DEAAddress.City           := right.p_city_name;
																										self.DEAAddress.State          := right.st;
																										self.DEAAddress.Zip5           := right.zip;
																										self.ExpirationDate            := if(right.expiration_date <> '', iesp.ECL2ESP.toDate ((integer)right.expiration_date ), iesp.ECL2ESP.toDate ((integer)left.Deanbr_exp ));
																										self.Number                    := if(right.dea_registration_number <> '', right.dea_registration_number, left.DEAnbr);
																										self.Schedule                  := left.Deanbr_sch1 + left.Deanbr_sch2 + left.Deanbr_sch2n +
																																											left.Deanbr_sch3 + left.Deanbr_sch3n + left.Deanbr_sch4 + 
																																											left.Deanbr_sch5;  // cnld schedules are already in the F/T format
																										self                           := [];
																									), left outer
																			 );

				Cnld_Child_OutletDEANum_dedp := dedup(sort(Cnld_Child_OutletDEANum, DEAAddress.StreetAddress1, DEAAddress.StreetAddress2, DEAAddress.City, DEAAddress.State, DEAAddress.Zip5, Number, Schedule, -ExpirationDate),
																							record, except ExpirationDate.month, ExpirationDate.day, ExpirationDate.year);
				
				//*** Transforming Child Outlet Federal Tax Id number.
				Cnld_Child_OutletFedNum := project(get_Cnld_Gennum_recs, 
																					 transform(iesp.searchpoint.t_SearchPointFederalNumber, 
																										 self.Number		:= left.fednum;
																										 self._Type			:= left.fednum_type;
																										 self						:= [];																								 
																										)
																					);

				Cnld_Child_OutletFedNum_dedp := dedup(Cnld_Child_OutletFedNum, all);
				
				//*** Transforming Child Outlet State License number.
				Cnld_Child_OutletStLicNum := project(get_Cnld_Gennum_recs, 
																						 transform(iesp.searchpoint.t_SearchPointStateLicense,
																											 self.ExpirationDate			 	:= iesp.ECL2ESP.toDate ((integer)left.st_lic_num_exp);
																											 self.Number								:= left.st_lic_num;
																											 self.State									:= left.st_lic_in;
																											 self.Status								:= IF(LEFT.st_lic_stat = 'A',
                                                                                        'ACTIVE',
                                                                                        IF(LEFT.st_lic_stat = 'I',
                                                                                           'INACTIVE',
                                                                                           LEFT.st_lic_stat
                                                                                          ));
																											 self._Type									:= left.st_lic_type;
																											 self												:= [];																								 
																											)
																						);


				Cnld_Child_OutletStLicNum_dedp := dedup(Cnld_Child_OutletStLicNum, all);
			
				//*** Transforming Child Outlet Sanctions.
  			//*** layout for adding Sanction's data.
				layout_Cnld_sanctions := record
						unsigned6 SANC_ID;						
						recordof(get_Cnld_Gennum_recs);								
				end;
				
				//*** getting the Sanctions information from the Ingenix Sanctions file.
				Sanc_id_Cnld_recs := join(get_Cnld_Gennum_recs, 
																	Ingenix_NatlProf.Key_sanctions_bdid,
																	keyed(left.bdid = right.bdid),
																	transform(layout_Cnld_sanctions,
																						self				 := left;
																						self.sanc_id := (unsigned6)right.sanc_id;
																					 ), left outer
																 );
	
				Cnld_Child_OutletSanction := join(Sanc_id_Cnld_recs,
																					doxie_files.key_sanctions_sancid,
																					keyed(left.sanc_id = right.l_sancid),
																					transform(iesp.searchpoint.t_SearchPointSanction,
																										 self.Amount							:= if(right.sanc_fines <> '', right.sanc_fines, (string)left.sanction_amt);
																										 self.SanctionDate			 	:= if(right.sanc_sancdte_form <> '', 
																																										iesp.ECL2ESP.toDate ((integer)right.sanc_sancdte_form),
																																										iesp.ECL2ESP.toDate ((integer)left.sanction_date));
																										 self.SanctionSource			:= if(right.sanc_src_desc <> '', right.sanc_src_desc, left.sanction_case);
																										 self.SanctionType				:= if(right.sanc_type <> '', right.sanc_type, left.def_type);
																										 self.State								:= if(right.sanc_sancst <> '', right.sanc_sancst, left.sanction_state);
																										 self.SanctionCase				:= left.sanction_case;
																										 self											:= [];																								 
																									 ), left outer
																				 );

				Cnld_Child_OutletSanction_dedp := dedup(Cnld_Child_OutletSanction, all);

				//*** Transforming Child Outlet Survey.
				Cnld_Child_OutletSurvey := project(get_Cnld_Gennum_recs, 
																					 transform(iesp.searchpoint.t_SearchPointSurvey,
																										 self.code							:= left.def_code;
																										 self.SurveyDate			 	:= iesp.ECL2ESP.toDate ((integer)left.survey_date);
																										 self.Rate							:= left.def_rate;
																										 self.Status						:= IF( left.def_status = 'A',
                                                                                   'ACTIVE',
                                                                                   IF( left.def_status = 'I',
                                                                                       'INACTIVE',
                                                                                       ''
                                                                                      )
                                                                                 );
																										 self._Type							:= left.survey_type;																										 
																										 self										:= [];
																										)
																					);
																					
				Cnld_Child_OutletSurvey_dedp := dedup(Cnld_Child_OutletSurvey, all);
					 
				//*** Mapping CNLD searched records to response output layout.										 
				layout_iesp_outlet_report_temp xfm_Report_cnld_info (get_Cnld_Gennum_recs l) :=
				TRANSFORM
			
					 self.chain										:= IF( TRIM(l.inchain,LEFT,RIGHT) = 'T',  
                                               'YES',
                                               IF( TRIM(l.inchain,LEFT, RIGHT) = 'F',
                                                   'NO',
                                                   ''
                                                 )
                                             );
					 self.chainId									:= trim(l.storeno,left,right);
					 self.outletType							:= factype_desc(trim(l.factype,left,right));
					 self.hospitalLocation 				:= IF( trim(l.inhospital,left,right) = 'T',
                                               'YES',
                                               IF( trim(l.inhospital,left,right) = 'F',
                                                   'NO',
                                                   ''
                                                 )
                                             );
					 self.ownerName    						:= trim(l.ownername,left,right);
					 self.ncpdpNumber							:= trim(l.ncpdpNbr,left,right);
					 self.npiNumber								:= trim(l.npi,left,right);
					 self.organizationName  			:= trim(l.org_name,left,right);
					 self.OutletAddressList				:= Cnld_Child_OutletAddress_dedp;
					 self.OutletDEANumberList			:= Cnld_Child_OutletDEANum_dedp;
					 self.FederalNumberList				:= Cnld_Child_OutletFedNum_dedp;
					 self.StateLicenseList				:= Cnld_Child_OutletStLicNum_dedp;
					 self.SanctionList						:= Cnld_Child_OutletSanction_dedp;
					 self.SurveyList							:= Cnld_Child_OutletSurvey_dedp;
					 self.dt_last_seen						:= l.last_seen_date;
					 self 												:= [];
				END;


				CNLD_SearchResults  := project( get_Cnld_Gennum_recs, xfm_Report_cnld_info( LEFT ) );
				
				outlet_report_results := dedup(dedup(sort(CNLD_SearchResults, -dt_last_seen, record), record) + 
																			 dedup(sort(NCPDP_SearchResults, -dt_last_seen, record), record),
																			 record, except dt_last_seen, npiNumber, all);
				

				out_recs := project(outlet_report_results, transform(iesp.searchpoint.t_SearchPointOutlet, self := left, self :=[]));										 

				RETURN out_recs;

		END;
end; // end of Search_records module