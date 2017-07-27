import doxie,doxie_files,AutoStandardI,Ingenix_NatlProf,ams,AMS_Services,Prof_LicenseV2_Services,iesp,address;
EXPORT Provider_Records_Sanc := Module
	Export get_sanc_providers_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, UNSIGNED1 penalt):= function
			gm:=AutoStandardI.GlobalModule();
			return join(dedup(sort(input,record),record), doxie_files.key_sanctions_sancid,
											keyed(left.prov_id = right.l_sancid), 
											transform(Healthcare_Provider_Services.Layouts.CombinedHeaderResults, 
															//Calc Penalty
																tempindvmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, opt))						
																	EXPORT lastname       := left.Name_last;       // the 'input' last name
																	EXPORT middlename     := left.Name_middle;     // the 'input' middle name
																	EXPORT firstname      := left.Name_first;      // the 'input' first name
																	EXPORT allow_wildcard := FALSE;
																	EXPORT useGlobalScope := FALSE;									
																	EXPORT lname_field    := right.prov_clean_lname;			// matching record name information			                          
																	EXPORT mname_field    := right.prov_clean_mname; 
																	EXPORT fname_field    := right.prov_clean_fname;	
																END;	
															
																namePenalty := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempindvmod);							 					 					 

																tempaddrmod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI_Addr.full, opt))					
																		EXPORT predir         := left.predir;
																		EXPORT prim_name      := left.prim_name;
																		EXPORT prim_range     := left.prim_range;
																		EXPORT postdir        := left.postdir;
																		EXPORT addr_suffix    := left.addr_suffix;
																		EXPORT sec_range      := left.sec_range;
																		EXPORT p_city_name    := left.p_city_name;
																		EXPORT st             := left.st;
																		EXPORT z5             := left.z5;											
																		//	The address in the matching record:						
																		EXPORT allow_wildcard  := FALSE;															
																		EXPORT city_field      := right.provco_address_clean_p_city_name;
																		EXPORT city2_field     := '';										
																		EXPORT pname_field     := right.provco_address_clean_prim_name;									
																		EXPORT prange_field    := right.provco_address_clean_prim_range;										
																		EXPORT postdir_field   := right.provco_address_clean_postdir;																				
																		EXPORT predir_field    := right.provco_address_clean_predir;									
																		EXPORT state_field     := right.provco_address_clean_st;										
																		EXPORT suffix_field    := right.provco_address_clean_addr_suffix;										
																		EXPORT zip_field       := right.provco_address_clean_zip;											
																		EXPORT sec_range_field := right.provco_address_clean_sec_range;
																		EXPORT useGlobalScope  := FALSE;
																end;
																
																addrPenalty:=AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempaddrmod);
																
																self.acctno := if(namePenalty>penalt or (left.isExactAddressMatch and addrPenalty>penalt),skip,left.acctno);
																self.record_penalty := namePenalty+addrPenalty;
																self.record_penalty_name := namePenalty;
																self.sources := dataset([{right.l_sancid,Healthcare_Provider_Services.Constants.SRC_SANC}],Healthcare_Provider_Services.Layouts.layout_SrcID);
																self.HCID := if(left.hid <> 0, left.hid,right.l_sancid);
																self.srcID := right.l_sancid;
																self.src := Healthcare_Provider_Services.Constants.SRC_SANC;
																self.isDerivedSource := left.derivedInputRecord;
																self.names := dataset([{1,namePenalty,right.sanc_busnme,
																											right.prov_clean_fname,
																											right.prov_clean_mname,
																											right.prov_clean_lname,
																											right.prov_clean_name_suffix,
																											right.prov_clean_title,
																											''}],Healthcare_Provider_Services.Layouts.layout_nameinfo);
																self.Addresses := dataset([{1,0,
																											'',
																											'',
																											'',
																											'',
																											'',
																											addrPenalty,
																											right.sanc_street,
																											'',
																											right.provco_address_clean_prim_range,
																											right.provco_address_clean_predir,
																											right.provco_address_clean_prim_name,
																											right.provco_address_clean_addr_suffix,
																											right.provco_address_clean_postdir,
																											right.provco_address_clean_unit_desig,
																											right.provco_address_clean_sec_range,
																											right.provco_address_clean_p_city_name,
																											right.provco_address_clean_v_city_name,
																											right.provco_address_clean_st,
																											right.provco_address_clean_zip,
																											right.provco_address_clean_zip4,
																											right.date_last_seen,
																											right.date_first_seen,
																											right.date_last_reported,
																											right.date_first_reported,
																											right.provco_address_clean_geo_lat,
																											right.provco_address_clean_geo_long,
																											'',
																											''}],Healthcare_Provider_Services.Layouts.layout_addressinfo);
																self.dobs := dataset([{right.sanc_dob}],Healthcare_Provider_Services.Layouts.layout_dob)(dob<>'');
																self.dids := dataset([{(integer)right.did}],Healthcare_Provider_Services.Layouts.layout_did)(did>0);
																self.taxids := dataset([{right.sanc_tin}],Healthcare_Provider_Services.Layouts.layout_taxid)(taxid<>'');
																self.upins := dataset([{left.acctno,right.l_sancid,right.sanc_upin}],Healthcare_Provider_Services.Layouts.layout_upin)(upin<>'');
																self.StateLicenses := dataset([{left.acctno,right.l_sancid,0,right.sanc_sancst,right.sanc_licnbr,'',''}],Healthcare_Provider_Services.Layouts.layout_licenseinfo)(LicenseNumber<>'');
																self:=left; self:=right; self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0));
	end;
end;