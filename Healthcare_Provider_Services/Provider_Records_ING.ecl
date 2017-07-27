import doxie_files,AutoStandardI,Ingenix_NatlProf,ams,iesp,address,ut;
EXPORT Provider_Records_ING := module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myFnIng := Healthcare_Provider_Services.Provider_Records_Functions_ING;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	//The following is to allow for a small amount of history to be held and otherwise get rid of the rest of the Ingenix data.
	monthsBack := myConst.MAX_INGENIX_HISTORY;
	theDate:=ut.GetDate;
	theYear := (integer)theDate[1..4];
	theMonth := (integer)theDate[5..6];
	theDay := theDate[7..8];
	theNewYear := (string)if(theMonth>monthsBack,theYear,theYear-1);
	theNewMonth := (string)intFormat(if(theMonth>monthsBack,theMonth-monthsBack,theMonth+12-monthsBack),2,1);
	Shared thresholdLoadDate := theNewYear+theNewMonth+theDay;
	Export get_ing_providers_base (dataset(myLayouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function

			// 1. Join to key to obtain initial, current, matching records.
			base_data:= join(dedup(sort(input,record),record), doxie_files.key_provider_id,
											keyed(left.prov_id = right.l_providerid) and right.processdate>=thresholdLoadDate,
											transform(myLayouts.ing_base_with_input,self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			
			// 2. Penalize records obtained from doxie_files.key_provider_id.
			fn_penalize_records( DATASET(myLayouts.ing_base_with_input) recs ) :=
				FUNCTION
					// Since a single input record can generate, on average, 300 matching records from the
					// Provider key above, and since penalization is fairly costly, we will penalize instead
					// each unique Provider Name and unique Provider ID. Then we'll rejoin the results of
					// these penalization operations back to base_data to transfer the penalty scores to the
					// rest of the records. Should save some time.
					
					// 2. Penalize unique Provider names. Dedup on only those fields necessary for penalization.
					recs_ddpd_by_name :=
						DEDUP(
							SORT(
								recs,
								l_providerid, prov_clean_lname, prov_clean_fname, prov_clean_mname
							),
							l_providerid, prov_clean_lname, prov_clean_fname, prov_clean_mname
						);

					myLayouts.ing_base_with_input_plus_penalties xfm_penalize_prov_name(myLayouts.ing_base_with_input le) :=
							TRANSFORM
								// Perform Provider name penalization.
								tempindvmod := MODULE(PROJECT(AutoStandardI.GlobalModule(), AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
									EXPORT lastname       := le.Name_last;       // the 'input' last name
									EXPORT middlename     := le.Name_middle;     // the 'input' middle name
									EXPORT firstname      := le.Name_first;      // the 'input' first name
									EXPORT allow_wildcard := FALSE;
									EXPORT useGlobalScope := FALSE;									
									EXPORT lname_field    := le.prov_clean_lname;			// matching record name information			                          
									EXPORT mname_field    := le.prov_clean_mname; 
									EXPORT fname_field    := le.prov_clean_fname;	
								END;	
								namePenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);	
								
								SELF.namePenalty := if( le.isHeaderResult, 0, if( le.comp_name <> '' and namePenalty_indv = 0, 11 /* Why eleven? */, namePenalty_indv ) );
								SELF.addrPenalty := 0;
								SELF := le;
							END;
					
					recs_penalized_prov_name := PROJECT( recs_ddpd_by_name, xfm_penalize_prov_name(LEFT) );

					// 3. Join back to recs and assign the namePenalty.			
					recs_with_namePenalty :=
						JOIN(
							recs, recs_penalized_prov_name, 
							LEFT.l_providerid = RIGHT.l_providerid AND
							LEFT.prov_clean_lname = RIGHT.prov_clean_lname AND
							LEFT.prov_clean_fname = RIGHT.prov_clean_fname AND
							LEFT.prov_clean_mname = RIGHT.prov_clean_mname,
							TRANSFORM( myLayouts.ing_base_with_input_plus_penalties,
								SELF.namePenalty := RIGHT.namePenalty,
								SELF.addrPenalty := 0,
								SELF := LEFT
							), 
							KEEP(myConst.MAX_RECS_ON_JOIN), 
							LIMIT(0)
						);

					// 4. Now penalize unique Provider addresses, again deduping on only those fields 
					// necessary for penalization:		
					recs_ddpd_by_addr :=
						DEDUP(
							SORT(
								recs,
								l_providerid, 
								prov_clean_prim_range, prov_clean_predir, prov_clean_prim_name, 
								prov_clean_addr_suffix, prov_clean_postdir, prov_clean_sec_range, 
								prov_clean_p_city_name, prov_clean_st, prov_clean_zip
							),
							l_providerid, 
							prov_clean_prim_range, prov_clean_predir, prov_clean_prim_name, 
							prov_clean_addr_suffix, prov_clean_postdir, prov_clean_sec_range, 
							prov_clean_p_city_name, prov_clean_st, prov_clean_zip
						);			
						
					myLayouts.ing_base_with_input_plus_penalties xfm_penalize_prov_addr(myLayouts.ing_base_with_input le) :=
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
								EXPORT city_field      := le.prov_clean_p_city_name;
								EXPORT city2_field     := '';										
								EXPORT pname_field     := le.prov_clean_prim_name;									
								EXPORT prange_field    := le.prov_clean_prim_range;										
								EXPORT postdir_field   := le.prov_clean_postdir;																				
								EXPORT predir_field    := le.prov_clean_predir;									
								EXPORT state_field     := le.prov_clean_st;										
								EXPORT suffix_field    := le.prov_clean_addr_suffix;										
								EXPORT zip_field       := le.prov_clean_zip;											
								EXPORT sec_range_field := le.prov_clean_sec_range;
								EXPORT useGlobalScope  := FALSE;
							end;							
							addrPenalty_indv := AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);	
							
							SELF.namePenalty := 0;
							SELF.addrPenalty := addrPenalty_indv;
							SELF := le;
						END;
					
					recs_penalized_prov_addr := PROJECT( recs_ddpd_by_addr, xfm_penalize_prov_addr(LEFT) );

					// 5. Join back to recs_with_namePenalty and assign the addrPenalty.
					recs_with_bothPenalty :=
						JOIN(
							recs_with_namePenalty, recs_penalized_prov_addr, 
							LEFT.l_providerid = RIGHT.l_providerid AND
							LEFT.prov_clean_prim_range = RIGHT.prov_clean_prim_range AND
							LEFT.prov_clean_predir = RIGHT.prov_clean_predir AND
							LEFT.prov_clean_prim_name = RIGHT.prov_clean_prim_name AND
							LEFT.prov_clean_addr_suffix = RIGHT.prov_clean_addr_suffix AND
							LEFT.prov_clean_postdir = RIGHT.prov_clean_postdir AND
							LEFT.prov_clean_sec_range = RIGHT.prov_clean_sec_range AND
							LEFT.prov_clean_p_city_name = RIGHT.prov_clean_p_city_name AND
							LEFT.prov_clean_st = RIGHT.prov_clean_st AND
							LEFT.prov_clean_zip = RIGHT.prov_clean_zip,
							TRANSFORM( myLayouts.ing_base_with_input_plus_penalties,
								SELF.namePenalty := LEFT.namePenalty,
								SELF.addrPenalty := RIGHT.addrPenalty,
								SELF := LEFT
							), 
							KEEP(myConst.MAX_RECS_ON_JOIN), 
							LIMIT(0)
						);			
						
					RETURN recs_with_bothPenalty;
				END;
				
			base_data_with_penalty := fn_penalize_records(base_data);
			baseRecs := project(base_data_with_penalty, myTransforms.build_ing_base(left,maxPenalty)); 
			
			// Deal with noHits--i.e. non-matches to doxie_files.key_provider_id: penalize and build base.
			nohits := join(input,baseRecs,left.acctno=right.acctno,transform(myLayouts.searchKeyResults_plus_input, self:=left),left only);
			noHit_historical:= join(dedup(sort(nohits,record),record), doxie_files.key_provider_id,
											keyed(left.prov_id = right.l_providerid),
											transform(myLayouts.ing_base_with_input,self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			onlymostcurrent := dedup(sort(project(noHit_historical,myLayouts.layout_historical_record),acctno,-processdate),acctno); 
			noHit_historical_Filter := join(noHit_historical,onlymostcurrent, left.acctno=right.acctno and left.processdate=right.processdate,
											transform(myLayouts.ing_base_with_input,self:=left;self:=right), 
											keep(myConst.MAX_RECS_ON_JOIN), limit(0)); 
			
			nohits_with_penalty := fn_penalize_records(noHit_historical_Filter);
			nohitsBaseRecs:= project(nohits_with_penalty,myTransforms.build_ing_base(left,maxPenalty));
			
			baseRecsFinal:=baseRecs+nohitsBaseRecs;
			ing_providers_final_sorted := sort(baseRecsFinal, acctno, SrcId, Src);
			ing_providers_final_grouped := group(ing_providers_final_sorted, acctno, SrcId, Src);
			ing_providers_rolled := rollup(ing_providers_final_grouped, group, myTransforms.doINGBaseRecordSrcIdRollup(left,rows(left)));			
		return ing_providers_rolled;
	end;
	
	Export get_ing_slim_data (dataset(myLayouts.CombinedHeaderResults) inputData, dataset(myLayouts.searchKeyResults_plus_input) inputPids):= function
			ing_providers_Slim := dedup(sort(project(inputData, transform(myLayouts.slimforLookup, 
																	self.acctno := left.acctno;
																	self.prov_id:=left.srcID;
																	self.prim_name := '';
																	self.p_city_name := '';
																	self.st := '';
																	self.z5 := '';)),record),record);
			ing_providers_Slim_final := join(ing_providers_Slim,inputPids, left.acctno=right.acctno and left.prov_id=right.prov_id, transform(myLayouts.slimforLookup, 
																	self.acctno := left.acctno;
																	self.prov_id:=left.prov_id;
																	self.prim_name := right.prim_name;
																	self.p_city_name := right.p_city_name;
																	self.st := right.st;
																	self.z5 := right.z5;));
			return ing_providers_Slim_final;
	end;
	shared append_affiliates (dataset(myLayouts.CombinedHeaderResults) inputData, 
											dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_affiliates := myFnING.getIngGroupAffiliations(inputSlim);
			results := join(inputData,ing_provider_affiliates, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.affiliates := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_hospitals (dataset(myLayouts.CombinedHeaderResults) inputData, 
										dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_hospitals := myFnING.getIngHospitalInfo(inputSlim);
			results := join(inputData,ing_provider_hospitals, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.hospitals := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_upins (dataset(myLayouts.CombinedHeaderResults) inputData, 
								dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_upins := myFnING.getIngUPINs(inputSlim);
			results := join(inputData,ing_provider_upins, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.upins := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_npis (dataset(myLayouts.CombinedHeaderResults) inputData, 
							 dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_npis := myFnING.getIngNpis(inputSlim);
			results := join(inputData,ing_provider_npis, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.npis := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_deas (dataset(myLayouts.CombinedHeaderResults) inputData, 
							 dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_deas := myFnING.getIngDeas(inputSlim);
			results := join(inputData,ing_provider_deas, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.deas := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	shared append_StateLicenses (dataset(myLayouts.CombinedHeaderResults) inputData, 
												dataset(myLayouts.slimforLookup) inputSlim):= function
			ing_provider_StateLicenses := myFnING.getIngLicenses(inputSlim);
			results := join(inputData,ing_provider_StateLicenses, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																			transform(myLayouts.CombinedHeaderResults,
																								self.StateLicenses := right.childinfo;
																								self := left),left outer);
			return results;
	end;
	Export get_ing_entity (dataset(myLayouts.searchKeyResults_plus_input) input, UNSIGNED1 maxPenalty):= function
			ing_providers_base := get_ing_providers_base(input,maxPenalty);
			ing_providers_Slim_final := get_ing_slim_data(ing_providers_base, input);
			ing_provider_w_affiliates := append_affiliates(ing_providers_base,ing_providers_Slim_final);
			ing_provider_w_hospitals := append_hospitals(ing_provider_w_affiliates,ing_providers_Slim_final);
			ing_provider_w_upins := append_upins(ing_provider_w_hospitals,ing_providers_Slim_final);
			ing_provider_w_npis := append_npis(ing_provider_w_upins,ing_providers_Slim_final);
			ing_provider_w_deas := append_deas(ing_provider_w_npis,ing_providers_Slim_final);
			results := append_StateLicenses(ing_provider_w_deas,ing_providers_Slim_final);
			return results;
	end;
	
end;