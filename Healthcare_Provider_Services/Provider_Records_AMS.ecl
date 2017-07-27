import doxie,doxie_files,AutoStandardI,Ingenix_NatlProf,ams,AMS_Services,Prof_LicenseV2_Services,iesp,address,ut;
EXPORT Provider_Records_AMS := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myFnAMS := Healthcare_Provider_Services.Provider_Records_Functions_AMS;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	//The following is to allow for a small amount of history to be held and otherwise get rid of the rest of the Ingenix data.
	monthsBack := myConst.MAX_AMS_HISTORY;
	theDate:=ut.GetDate;
	theYear := (integer)theDate[1..4];
	theMonth := (integer)theDate[5..6];
	theDay := theDate[7..8];
	theNewYear := (string)if(theMonth>monthsBack,theYear,theYear-1);
	theNewMonth := (string)intFormat(if(theMonth>monthsBack,theMonth-monthsBack,theMonth+12-monthsBack),2,1);
	Shared thresholdLoadDate := theNewYear+theNewMonth+theDay;
	Export get_ams_providers_base (dataset(myLayouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			ams_data:= join(dedup(sort(input,record),record), ams.keys().main.amsid.qa,
											keyed((string)left.prov_id = right.ams_id) and right.dt_vendor_last_reported>=(integer)thresholdLoadDate,
											transform(myLayouts.ams_base_with_input, self:=left,self:=right),
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			nohits := join(input,ams_data,left.acctno=right.acctno,transform(myLayouts.searchKeyResults_plus_input, self:=left),left only);
			noHit_historical:= join(dedup(sort(nohits,record),record), ams.keys().main.amsid.qa,
											keyed((string)left.prov_id = right.ams_id),
											transform(myLayouts.ams_base_with_input,self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			onlymostcurrent := dedup(sort(project(noHit_historical,transform(myLayouts.layout_historical_record,self.acctno := left.acctno; self.processdate := (string)left.dt_vendor_last_reported; self:=left)),acctno,-processdate),acctno); 
			noHit_historical_Filter := join(noHit_historical,onlymostcurrent, left.acctno=right.acctno and left.dt_vendor_last_reported=(integer)right.processdate,
											transform(myLayouts.ams_base_with_input,self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			ams_data_Final:=ams_data+noHit_historical_Filter;
			cln_ams_sort_data := sort(ams_data_Final,clean_name.fname,clean_name.mname,clean_name.lname,clean_name.name_suffix,clean_company_address.prim_range,
															clean_company_address.predir,clean_company_address.prim_name,clean_company_address.addr_suffix,clean_company_address.postdir,
															clean_company_address.unit_desig,clean_company_address.sec_range,clean_company_address.p_city_name,clean_company_address.v_city_name,
															clean_company_address.st,clean_company_address.zip,clean_company_address.zip4,clean_phones.phone,clean_phones.fax,did,
															-rawaddressfields.gold_record_flag,(integer)myFn.cleanOnlyNumbers(rawaddressfields.bob_rank),-(integer)myFn.cleanOnlyNumbers(rawaddressfields.bob_value));
			cln_ams_dedup_data := dedup(cln_ams_sort_data,clean_name.fname,clean_name.mname,clean_name.lname,clean_name.name_suffix,clean_company_address.prim_range,
															clean_company_address.predir,clean_company_address.prim_name,clean_company_address.addr_suffix,clean_company_address.postdir,
															clean_company_address.unit_desig,clean_company_address.sec_range,clean_company_address.p_city_name,clean_company_address.v_city_name,
															clean_company_address.st,clean_company_address.zip,clean_company_address.zip4,clean_phones.phone,clean_phones.fax,did);
			// ========================================================================================
			// Penalize unique clean names. Dedup on only those fields necessary for penalization.
			cln_ams_dedup_data_ddpd_by_name :=
				DEDUP(
					SORT(
						cln_ams_dedup_data,
						prov_id, clean_name.lname, clean_name.fname, clean_name.mname
					),
					prov_id, clean_name.lname, clean_name.fname, clean_name.mname
				);

			myLayouts.ams_base_with_input_plus_penalties xfm_penalize_clean_name(myLayouts.ams_base_with_input le) :=
					TRANSFORM
						// Perform Provider name penalization.
						tempindvmod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
							EXPORT lastname       := le.name_last;       // the 'input' last name
							EXPORT middlename     := le.name_middle;     // the 'input' middle name
							EXPORT firstname      := le.name_first;      // the 'input' first name
							EXPORT allow_wildcard := FALSE;
							EXPORT useGlobalScope := FALSE;									
							EXPORT lname_field    := le.clean_name.lname;			// matching record name information			                          
							EXPORT mname_field    := le.clean_name.mname; 
							EXPORT fname_field    := le.clean_name.fname;	
						END;	
						namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);	
						
						SELF.namePenalty := if( le.isHeaderResult, 0, if( le.comp_name <> '' and namePenalty_indv = 0, 11 /* Why eleven? */, namePenalty_indv ) );
						SELF.addrPenalty := 0;
						SELF := le;
					END;
			
			cln_ams_data_penalized_clean_name := PROJECT( cln_ams_dedup_data_ddpd_by_name, xfm_penalize_clean_name(LEFT) );

			// Join back to base_data and assign the namePenalty.			
			cln_ams_data_with_namePenalty :=
				JOIN(
					cln_ams_dedup_data, cln_ams_data_penalized_clean_name, 
					LEFT.prov_id = RIGHT.prov_id AND
					LEFT.clean_name.lname = RIGHT.clean_name.lname AND
					LEFT.clean_name.fname = RIGHT.clean_name.fname AND
					LEFT.clean_name.mname = RIGHT.clean_name.mname,
					TRANSFORM( myLayouts.ams_base_with_input_plus_penalties,
						SELF.namePenalty := RIGHT.namePenalty,
						SELF.addrPenalty := 0,
						SELF := LEFT
					), 
					KEEP(myConst.MAX_RECS_ON_JOIN), 
					LIMIT(0)
				);

			// Now penalize unique clean addresses, again deduping on only those fields 
			// necessary for penalization:		
			cln_ams_dedup_data_ddpd_by_addr :=
				DEDUP(
					SORT(
						cln_ams_dedup_data,
						prov_id, 
						clean_company_address.prim_range, clean_company_address.predir, clean_company_address.prim_name, 
						clean_company_address.addr_suffix, clean_company_address.postdir, clean_company_address.sec_range, 
						clean_company_address.p_city_name, clean_company_address.st, clean_company_address.zip
					),
					prov_id, 
					clean_company_address.prim_range, clean_company_address.predir, clean_company_address.prim_name, 
					clean_company_address.addr_suffix, clean_company_address.postdir, clean_company_address.sec_range, 
					clean_company_address.p_city_name, clean_company_address.st, clean_company_address.zip
				);			
				
			myLayouts.ams_base_with_input_plus_penalties xfm_penalize_clean_addr(myLayouts.ams_base_with_input le) :=
				TRANSFORM
					// Perform Provider address penalization.
					tempaddrmod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
						EXPORT predir         := le.predir;
						EXPORT prim_name      := le.prim_name;
						EXPORT prim_range     := le.prim_range;
						EXPORT postdir        := le.postdir;
						EXPORT addr_suffix    := le.addr_suffix;
						EXPORT sec_range      := le.sec_range;
						EXPORT p_city_name    := le.p_city_name;
						EXPORT st             := le.st;
						EXPORT z5             := le.z5;											
						//	The address in the matching record:						
						EXPORT allow_wildcard  := FALSE;															
						EXPORT city_field      := le.clean_company_address.p_city_name;
						EXPORT city2_field     := '';										
						EXPORT pname_field     := le.clean_company_address.prim_name;									
						EXPORT prange_field    := le.clean_company_address.prim_range;										
						EXPORT postdir_field   := le.clean_company_address.postdir;																				
						EXPORT predir_field    := le.clean_company_address.predir;									
						EXPORT state_field     := le.clean_company_address.st;										
						EXPORT suffix_field    := le.clean_company_address.addr_suffix;										
						EXPORT zip_field       := le.clean_company_address.zip;											
						EXPORT sec_range_field := le.clean_company_address.sec_range;
						EXPORT useGlobalScope  := FALSE;
					end;							
					addrPenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);	
					
					SELF.namePenalty := 0;
					SELF.addrPenalty := addrPenalty_indv;
					SELF := le;
				END;
			
			cln_ams_data_penalized_clean_addr := PROJECT( cln_ams_dedup_data_ddpd_by_addr, xfm_penalize_clean_addr(LEFT) );

			// 5. Join back to base_data_with_namePenalty and assign the addrPenalty.
			cln_ams_data_with_bothPenalty :=
				JOIN(
					cln_ams_data_with_namePenalty, cln_ams_data_penalized_clean_addr, 
					LEFT.prov_id = RIGHT.prov_id AND
					LEFT.clean_company_address.prim_range = RIGHT.clean_company_address.prim_range AND
					LEFT.clean_company_address.predir = RIGHT.clean_company_address.predir AND
					LEFT.clean_company_address.prim_name = RIGHT.clean_company_address.prim_name AND
					LEFT.clean_company_address.addr_suffix = RIGHT.clean_company_address.addr_suffix AND
					LEFT.clean_company_address.postdir = RIGHT.clean_company_address.postdir AND
					LEFT.clean_company_address.sec_range = RIGHT.clean_company_address.sec_range AND
					LEFT.clean_company_address.p_city_name = RIGHT.clean_company_address.p_city_name AND
					LEFT.clean_company_address.st = RIGHT.clean_company_address.st AND
					LEFT.clean_company_address.zip = RIGHT.clean_company_address.zip,
					TRANSFORM( myLayouts.ams_base_with_input_plus_penalties,
						SELF.namePenalty := LEFT.namePenalty,
						SELF.addrPenalty := RIGHT.addrPenalty,
						SELF := LEFT
					), 
					KEEP(myConst.MAX_RECS_ON_JOIN), 
					LIMIT(0)
				);			
// ========================================================================================			
			baseRecs := project(cln_ams_data_with_bothPenalty,myTransforms.build_ams_base(left,maxPenalty));
			ams_providers_final_sorted := sort(baseRecs, acctno, SrcId, Src);
			ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, SrcId, Src);
			ams_providers_rolled := rollup(ams_providers_final_grouped, group, myTransforms.doAMSBaseRecordSrcIdRollup(left,rows(left)));			
		return ams_providers_rolled;
	end;

	Export get_ams_slim_data (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.searchKeyResults_plus_input) inputPids):= function
			ams_providers_Slim := dedup(sort(project(inputData, transform(myLayouts.slimforLookup, 
																	self.acctno := left.acctno;
																	self.prov_id:=left.srcID;
																	self.prim_name := '';
																	self.p_city_name := '';
																	self.st := '';
																	self.z5 := '';)),record),record);
			ams_providers_Slim_final := join(ams_providers_Slim,inputPids, left.acctno=right.acctno and left.prov_id=right.prov_id, transform(myLayouts.slimforLookup, 
																	self.acctno := left.acctno;
																	self.prov_id:=left.prov_id;
																	self.prim_name := right.prim_name;
																	self.p_city_name := right.p_city_name;
																	self.st := right.st;
																	self.z5 := right.z5;));
			return ams_providers_Slim_final;
	end;
	shared append_affiliates (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			ams_provider_affiliates := myFnAMS.getAmsGroupAffiliations(inputSlim);
			results := join(inputData,ams_provider_affiliates, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(myLayouts.CombinedHeaderResults,
																							self.affiliates := right.childinfo;
																							self := left),left outer);
			return results;
	end;
	shared append_hospitals (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			ams_provider_hospitals := myFnAMS.getAmsHospitalInfo(inputSlim);
			results := join(inputData,ams_provider_hospitals, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.hospitals := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_npis (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			ams_provider_npis := myFnAMS.getAmsNpis(inputSlim);
			results := join(inputData,ams_provider_npis, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.npis := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_deas (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			ams_provider_deas := myFnAMS.getAmsDeas(inputSlim);
			results := join(inputData,ams_provider_deas, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.deas := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	// shared append_degrees (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			// ams_provider_degrees := myFnAMS.getAmsDegrees(inputSlim);
			// results := join(inputData,ams_provider_degrees, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			// transform(myLayouts.CombinedHeaderResults,
																								// self.Degrees := right.childinfo;
																								// self := left),left outer);
			// return results;
	// end;
	// shared append_specialty (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			// ams_provider_specialty := myFnAMS.getAmsSpecialty(inputSlim);
			// results := join(inputData,ams_provider_specialty, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			// transform(myLayouts.CombinedHeaderResults,
																								// self.Specialties := right.childinfo;
																								// self := left),left outer);
			// return results;
	// end;
	shared append_StateLicenses (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.slimforLookup) inputSlim):= function
			ams_provider_StateLicenses := myFnAMS.getAmsLicenses(inputSlim);
			results := join(inputData,ams_provider_StateLicenses, left.acctno=right.Acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.StateLicenses := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export get_ams_entity (dataset(myLayouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			ams_providers_base := get_ams_providers_base(input,maxPenalty);
			ams_providers_Slim_final := get_ams_slim_data(ams_providers_base, input);
			ams_provider_w_affiliates := append_affiliates(ams_providers_base,ams_providers_Slim_final);
			ams_provider_w_hospitals := append_hospitals(ams_provider_w_affiliates,ams_providers_Slim_final);
			ams_provider_w_npis := append_npis(ams_provider_w_hospitals,ams_providers_Slim_final);
			ams_provider_w_deas := append_deas(ams_provider_w_npis,ams_providers_Slim_final);
			// ams_provider_w_degrees := append_degrees(ams_provider_w_deas,ams_providers_Slim_final);
			// ams_provider_w_specialty := append_specialty(ams_provider_w_degrees,ams_providers_Slim_final);
			// results := append_StateLicenses(ams_provider_w_specialty,ams_providers_Slim_final);
			results := append_StateLicenses(ams_provider_w_deas,ams_providers_Slim_final);
			return results;
	end;
end;