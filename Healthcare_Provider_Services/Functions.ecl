import iesp, AutoStandardI, Ingenix_NatlProf, doxie, doxie_files, ut,
			Business_Header,address, NPPES, Healthcare_Services;
export Functions := Module

	shared myLayouts := Healthcare_Provider_Services.layouts;
	shared myConst := Healthcare_Provider_Services.constants;
	shared gm:=AutoStandardI.GlobalModule();

	Export cleanWord (string inStr) := function
		return stringlib.stringfilter(inStr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	end;

	EXPORT removeLeadingZeros(String inputStr) := FUNCTION
		removeZero := stringlib.StringFilter(stringlib.StringToUpperCase(inputStr),'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		findStart := stringlib.StringFind(stringlib.StringToUpperCase(inputStr),removeZero[1],1);
		result := inputStr[findStart..];
		RETURN result;
	END;

	EXPORT getCleanHealthCareName(string inStr) := FUNCTION
		wordpart := RECORD
			string wordVal;
		END;
		words := RECORD
			string wordVal;
			boolean isInitial;
		END;
			
		HealthCareFilterWords := dataset([{'MEDICAL'},{'CORPORATION'},{'COUNTY'},{'HEALTHCARE'},{'HEALTH'},{'CLINIC'},{'HOSPITAL'},{'UNIVERSITY'},{'OF'},
																			{'AND'},{'THE'},{'SCHOOL'},{'COMMUNITY'},{'CENTER'},{'CENTERS'},{'GROUP'},{'GRP'},{'INC'},{'ASSOCIATES'},{'ASSOC'},
																			{'CORP'},{'LLC'},{'LTD'},{'LLP'},{'INCORPORATION'},{'INCORPORATED'},{'MED'},{'LABORATORY'},{'AUTHORITY'}],wordpart);
		splitStr := ut.StringSplit(inStr,' ');
		ds := dataset(splitStr,wordpart);
		dsClean := project(ds,transform(words,self.wordVal:=cleanWord(left.wordVal);self.isInitial:=length(left.wordVal)=1));
		cleanDS := join(dsClean,HealthCareFilterWords,left.wordVal=right.wordVal,left only);

		words recombine(words L, words R) := TRANSFORM
			SELF.wordVal := L.wordVal + if(L.isInitial and R.isInitial,'',' ')+ R.wordVal;
			self.isInitial := R.isInitial;
		END;

		mergeWords := ITERATE(cleanDS,recombine(LEFT,RIGHT));
		maxRow := count(mergeWords);
		returnVal := trim(mergeWords[maxRow].wordVal,left,right);
		return returnVal;
	END;
	
	EXPORT BOOLEAN allowGLB() := FUNCTION
		RETURN AutoStandardI.InterfaceTranslator.glb_ok.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.glb_ok.params));
	END;

	EXPORT BOOLEAN allowDPPA() := FUNCTION
		RETURN AutoStandardI.InterfaceTranslator.dppa_ok.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.dppa_ok.params)); 
	END;

	EXPORT getPayloadByIDS(Dataset(layouts.id) ids) := FUNCTION
		
		search_key := Ingenix_NatlProf.Key_Sanctions_Payload;
			
		ds_recs := join(ids,search_key,
										keyed(left.id=right.fakeid),
										transform(myLayouts.layout_sancid, self.sanc_id :=(integer)right.sanc_id),
										keep(myConst.MAX_RECS_ON_JOIN));			
		RETURN ds_recs;
		
	END;

	EXPORT getPayloadByPIDS(Dataset(myLayouts.id) ids) := FUNCTION
		
		prov_key := Ingenix_NatlProf.Key_Provider_Payload;
		
		ds_recs := join(ids,prov_key,
										keyed(left.id=right.fakeid),
										transform(myLayouts.layout_provid,self.prov_id:=(unsigned6)right.ProviderID),
										keep(myConst.MAX_RECS_ON_JOIN));		
		RETURN ds_recs;
		
	END;
	
	EXPORT getPayloadByNPPESIDS(Dataset(myLayouts.id) ids) := FUNCTION
		
		nppes_key := NPPES.Key_NPPES_Payload;
		
		ds_recs := join(ids,nppes_key,
										keyed(left.id=right.fakeid),
										transform(recordof(nppes_key), self := right),
										keep(myConst.MAX_RECS_ON_JOIN));		
		RETURN ds_recs;
		
	END;
	
	EXPORT getNPPESByAutokeys(IParams.searchParams aInputData) := FUNCTION
		
		validCriteria:=(trim(aInputData.LastName,all) <> '' or trim(aInputData.CompanyName,all) <> '') and 
										trim(aInputData.City,all) <> '' and trim(aInputData.Zip,all) <> '';
		nppes_ids_byak := if(validCriteria,AutoKey_Ids(aInputData).nppes);		
		nppes_payload := getPayloadByNPPESIDS(nppes_ids_byak);
		nppes_res := project(nppes_payload, recordof(myLayouts.NPPES_Layouts.temp_layout));

		RETURN nppes_res;
	END;
	
	EXPORT getNPPESByNPI(dataset(myLayouts.NPPES_Layouts.layout_npiid) NPIRec) := FUNCTION
		npi_key := NPPES.Key_NPPES_npi;
		nppes_ids_bynpi := join(NPIRec, npi_key, Keyed(left.npi_id = right.npi),
														transform(recordof(myLayouts.NPPES_Layouts.temp_layout), self := right));
		RETURN nppes_ids_bynpi;
	END;
	
	EXPORT getSIDSByDIDS(Dataset(myLayouts.deepDids) dids) := FUNCTION
		search_key_sid := doxie_files.key_sanctions_did;
		ds_recs_sids := join(dids,search_key_sid,
										keyed(left.did=right.l_did),
										transform(myLayouts.layout_sancid, self.sanc_id := (integer)right.sanc_id),
										keep(myConst.MAX_RECS_ON_JOIN));	
		RETURN ds_recs_sids;
	END;
	
	EXPORT getSIDSByBDIDS(Dataset(myLayouts.deepBDids) bdids) := FUNCTION
		search_key_sid := Ingenix_NatlProf.Key_sanctions_bdid;
		ds_recs_sids := join(bdids,search_key_sid,
										keyed(left.bdid=right.bdid),
										transform(myLayouts.layout_sancid, self.sanc_id := (integer)right.sanc_id),
										keep(myConst.MAX_RECS_ON_JOIN));	
		RETURN ds_recs_sids;
	END;
	
	EXPORT getPIDSByDIDS(Dataset(myLayouts.deepDids) dids) := FUNCTION
		search_key_pid := doxie_files.key_provider_did;
		ds_recs_pids := join(dids,search_key_pid,
										keyed(left.did=right.l_did),
										transform(myLayouts.layout_provid, self.prov_id := right.providerid),
										keep(myConst.MAX_RECS_ON_JOIN));
										
		RETURN ds_recs_pids;	
	END;
	
	SHARED pid_npi_rec := record
     unsigned6 providerid;
		doxie.ingenix_provider_module.ingenix_npi_rec;
	end;
	
/*	EXPORT getNPIthruNPPES_Prov(dataset(pid_npi_rec) pid_npi_in, 
															dataset(recordof(doxie_files.key_provider_id)) prov_id_in) := FUNCTION 
			
		int_rec := record
			unsigned seq;
			doxie_files.key_provider_id;
			pid_npi_rec - [providerid];
		end;
		
		pid_npi_seq := project(pid_npi_in, transform(int_rec, self.seq := counter, 
																													self.providerid := (string)left.providerid, 
																													self := left, 
																													self := []));
		
		int_rec xform_wnpi(prov_id_in L, int_rec R) := transform
			self := L;
			self := R;
		end;
		
		prov_npi := join(prov_id_in, pid_npi_seq, 
										left.providerid = (string)right.providerid, 
										xform_wnpi(left, right));
										
		Healthcare_Provider_Services.MAC_VerifyNPIthruNPPES(prov_npi, verified_prov_npi,
															prov_clean_lname,
															prov_clean_fname,
															prov_clean_mname,
															prov_clean_prim_range,
															prov_clean_prim_name,
															prov_clean_predir,
															prov_clean_postdir,
															prov_clean_addr_suffix,
															prov_clean_sec_range,
															prov_clean_p_city_name,
															prov_clean_st,
															prov_clean_zip,
															providerid,
															LastName);
															
		return verified_prov_npi;
	END;
	
	EXPORT getNPIthruNPPES_SearchProv(dataset(doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt) prov_searchid_in) := FUNCTION 
		
		seq_rec := record
			unsigned seq;
			// string did := '';
			doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt;
		end;
		
		seq_final := project(prov_searchid_in, transform(seq_rec, self.seq := counter, self := left, self := []));
		
		Healthcare_Provider_Services.MAC_VerifyNPIthruNPPES(seq_final,
																												verified_npi,
																												name[1].prov_clean_lname,
																												name[1].prov_clean_fname,
																												name[1].prov_clean_mname,
																												address[1].prov_clean_prim_range,
																												address[1].prov_clean_prim_name,
																												address[1].prov_clean_predir,
																												address[1].prov_clean_postdir,
																												address[1].prov_clean_addr_suffix,
																												address[1].prov_clean_sec_range,
																												address[1].prov_clean_p_city_name,
																												address[1].prov_clean_st,
																												address[1].prov_clean_zip,	
																												providerid,
																												Provider_Organization_Name);
		
		out_res := join(seq_final, verified_npi, left.seq = right.seq,
										transform(doxie.ingenix_provider_module.layout_ingenix_NPPES_provider_search_penalt,
															self.npi := right.npi,
															self.NPPESVerified := right.NPPESVerified,
															self := left));
		
		return out_res;
	END;
*/
	SHARED sid_npi_rec := doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
	
	EXPORT getNPIthruNPPES_Sanc(dataset(sid_npi_rec) sid_npi_in) := FUNCTION
		int_rec := record
			unsigned seq;
			sid_npi_rec;
		end;
		
		sanc_id_seq := project(sid_npi_in, transform(int_rec, 
																								self.seq := counter,
																								self := left));
		sanc_id_seq_filtered := sanc_id_seq;
		
		Healthcare_Provider_Services.MAC_VerifyNPIthruNPPES(sanc_id_seq_filtered, verified_sanc_npi,
																												Prov_Clean_lname,
																												Prov_Clean_fname,
																												Prov_Clean_mname,
																												ProvCo_Address_Clean_prim_range,
																												ProvCo_Address_Clean_prim_name,
																												ProvCo_Address_Clean_predir,
																												ProvCo_Address_Clean_postdir,
																												ProvCo_Address_Clean_addr_suffix,
																												ProvCo_Address_Clean_sec_range,
																												ProvCo_Address_Clean_p_city_name,
																												ProvCo_Address_Clean_st,
																												ProvCo_Address_Clean_zip,
																												sanc_id,
																												SANC_BUSNME);
		
		sanc_final := join(sanc_id_seq, verified_sanc_npi, 
											left.seq = right.seq,
											transform(sid_npi_rec, 
																self.npi := right.npi,
																self.nppesVerified := right.nppesVerified,
																self := left),
											left outer);
																
		RETURN sanc_final;
	end;

	EXPORT apply_penalty(dataset(myLayouts.sanc_penalty_recs) SanctionRec, 
												IParams.searchParams aInputData) := FUNCTION												
		
		myLayouts.sanc_penalty_recs setPenalty(myLayouts.sanc_penalty_recs SanctionRecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export city_field := SanctionRecs.provco_address_clean_p_city_name;
				export fname_field := SanctionRecs.prov_clean_fname;
				export lname_field := SanctionRecs.prov_clean_lname;
				export mname_field := SanctionRecs.prov_clean_mname;
				export pname_field := SanctionRecs.provco_address_clean_prim_name;
				export postdir_field := SanctionRecs.provco_address_clean_postdir;
				export prange_field := SanctionRecs.provco_address_clean_prim_range;
				export predir_field := SanctionRecs.provco_address_clean_predir;
				export ssn_field := '';  
				export state_field := SanctionRecs.provco_address_clean_st;
				export suffix_field := SanctionRecs.provco_address_clean_addr_suffix;
				export sec_range_field := SanctionRecs.provco_address_clean_sec_range;
				export zip_field := SanctionRecs.provco_address_clean_zip;
				// Empty non input.
				export did_field := SanctionRecs.did;
				export city2_field := '';
				export county_field := '';
				export dob_field := SanctionRecs.sanc_dob;
				export dod_field := '';
				export phone_field := '';
				export bdid_field := SanctionRecs.bdid;
				export cname_field := SanctionRecs.sanc_busnme;
				export fein_field := SanctionRecs.sanc_tin;
				export agehigh := 0;
				export agelow := 0;
			END;
						
			SELF.record_penalty:= AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod);
			SELF := SanctionRecs;
		END;
	
			penaltyRecs := project(SanctionRec, setPenalty(LEFT));					
		RETURN penaltyRecs;
	END;
	
	EXPORT apply_penalty_prov(dataset(myLayouts.prov_penalty_recs) ProviderRec, 
												IParams.searchParams aInputData) := FUNCTION												
		
		myLayouts.prov_penalty_recs setPenalty(myLayouts.prov_penalty_recs ProviderRecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export city_field := ProviderRecs.prov_clean_p_city_name;
				export fname_field := ProviderRecs.prov_clean_fname;
				export lname_field := ProviderRecs.prov_clean_lname;
				export mname_field := ProviderRecs.prov_clean_mname;
				export pname_field := ProviderRecs.prov_clean_prim_name;
				export postdir_field := ProviderRecs.prov_clean_postdir;
				export prange_field := ProviderRecs.prov_clean_prim_range;
				export predir_field := ProviderRecs.prov_clean_predir;
				export ssn_field := '';  
				export state_field := ProviderRecs.prov_clean_st;
				export suffix_field := ProviderRecs.prov_clean_addr_suffix;
				export sec_range_field := ProviderRecs.prov_clean_sec_range;
				export zip_field := ProviderRecs.prov_clean_zip;
				// Empty non input.
				export did_field := ProviderRecs.did;
				export city2_field := '';
				export county_field := '';
				export dob_field := ProviderRecs.birthdate;
				export dod_field := '';
				export phone_field := '';
				export bdid_field := '';
				export cname_field := aInputData.companyname;
				export fein_field := ProviderRecs.taxid;
				export agehigh := 0;
				export agelow := 0;
			END;
						
			SELF.record_penalty:= AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod);
			SELF := ProviderRecs;
		END;
	
			penaltyRecs := project(ProviderRec, setPenalty(LEFT));					
		RETURN penaltyRecs;
	END;
	
	EXPORT apply_penalty_nppes(dataset(myLayouts.NPPES_Layouts.temp_layout) NPPESRec, 
												IParams.searchParams aInputData) := FUNCTION												
		
		myLayouts.NPPES_Layouts.nppes_penalty_recs setPenalty(myLayouts.NPPES_Layouts.temp_layout NPPESRecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export fname_field := NPPESRecs.clean_name_provider.fname;
				export lname_field := NPPESRecs.clean_name_provider.lname;
				export mname_field := NPPESRecs.clean_name_provider.mname;
				export ssn_field := '';  
				export pname_field := NPPESRecs.clean_norm_address.prim_name;
				export postdir_field := NPPESRecs.clean_norm_address.postdir;
				export prange_field := NPPESRecs.clean_norm_address.prim_range;
				export predir_field := NPPESRecs.clean_norm_address.predir;
				export state_field := NPPESRecs.clean_norm_address.st;
				export suffix_field := NPPESRecs.clean_norm_address.addr_suffix;
				export sec_range_field := NPPESRecs.clean_norm_address.sec_range;
				export city_field := NPPESRecs.clean_norm_address.p_city_name;
				export zip_field := NPPESRecs.clean_norm_address.zip;
				// Empty non input.
				export did_field := (string)NPPESRecs.did;
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := '';
				export bdid_field := '';
				export cname_field := NPPESRecs.provider_organization_name;
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
				// Input fields
				export companyname := aInputData.companyname;
				export lastname   := aInputData.lastname;       
				export middlename := aInputData.middlename;     
				export firstname  := aInputData.firstname;            				
				export prim_range := aInputData.prim_range;
				export predir := aInputData.predir;
				export prim_name := aInputData.prim_name;
				export postdir := aInputData.postdir;
				export sec_range := aInputData.sec_range;
				export city := aInputData.city;
				export state := aInputData.state;
				export zip := aInputData.zip;
			END;
						
			SELF.record_penalty:= AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod);
			SELF := NPPESRecs;
		END;
	
			penaltyRecs := sort(project(NPPESRec, setPenalty(LEFT)), record_penalty);	
			
		RETURN penaltyRecs;
	END;

	EXPORT apply_penalty_nppes_batch (dataset(Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty) NPPESRec) := function 
		
		Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty setPenalty(Healthcare_Provider_Services.NPI_Layouts.batch_out_penalty rawNPPESRecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export fname_field := rawNPPESRecs.clean_name_provider.fname;
				export lname_field := rawNPPESRecs.clean_name_provider.lname;
				export mname_field := rawNPPESRecs.clean_name_provider.mname;
				export ssn_field := '';  
				export pname_field := rawNPPESRecs.clean_location_address.prim_name;
				export postdir_field := rawNPPESRecs.clean_location_address.postdir;
				export prange_field := rawNPPESRecs.clean_location_address.prim_range;
				export predir_field := rawNPPESRecs.clean_location_address.predir;
				export state_field := rawNPPESRecs.clean_location_address.st;
				export suffix_field := rawNPPESRecs.clean_location_address.addr_suffix;
				export sec_range_field := rawNPPESRecs.clean_location_address.sec_range;
				export city_field := rawNPPESRecs.clean_location_address.p_city_name;
				export zip_field := rawNPPESRecs.clean_location_address.zip;
				// Empty non input.
				export did_field := '';//(string)rawNPPESRecs.did;
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := '';
				export bdid_field := '';
				export cname_field := rawNPPESRecs.provider_organization_name;
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
				// Input fields
				export companyname := rawNPPESRecs.comp_name;
				export lastname   := rawNPPESRecs.Name_last;       
				export middlename := rawNPPESRecs.Name_middle;     
				export firstname  := rawNPPESRecs.Name_first;            				
				export prim_range := rawNPPESRecs.prim_range;
				export predir := rawNPPESRecs.predir;
				export prim_name := rawNPPESRecs.prim_name;
				export addr_suffix := rawNPPESRecs.addr_suffix;
				export postdir := rawNPPESRecs.postdir;
				export unit_desig := rawNPPESRecs.unit_desig;
				export sec_range := rawNPPESRecs.sec_range;
				export city := rawNPPESRecs.p_city_name;
				export state := rawNPPESRecs.st;
				export zip := rawNPPESRecs.z5;
				export bdid := '';//(string14)rawNPPESRecs.bdid;
			END;
			tempIndvMod2 := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export fname_field := rawNPPESRecs.clean_name_provider.fname;
				export lname_field := rawNPPESRecs.clean_name_provider.lname;
				export mname_field := rawNPPESRecs.clean_name_provider.mname;
				export ssn_field := '';  
				export pname_field := rawNPPESRecs.clean_mailing_address.prim_name;
				export postdir_field := rawNPPESRecs.clean_mailing_address.postdir;
				export prange_field := rawNPPESRecs.clean_mailing_address.prim_range;
				export predir_field := rawNPPESRecs.clean_mailing_address.predir;
				export state_field := rawNPPESRecs.clean_mailing_address.st;
				export suffix_field := rawNPPESRecs.clean_mailing_address.addr_suffix;
				export sec_range_field := rawNPPESRecs.clean_mailing_address.sec_range;
				export city_field := rawNPPESRecs.clean_mailing_address.p_city_name;
				export zip_field := rawNPPESRecs.clean_mailing_address.zip;
				// Empty non input.
				export did_field := '';//(string)rawNPPESRecs.did;
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := '';
				export bdid_field := '';
				export cname_field := rawNPPESRecs.provider_organization_name;
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
				// Input fields
				export companyname := rawNPPESRecs.comp_name;
				export lastname   := rawNPPESRecs.Name_last;       
				export middlename := rawNPPESRecs.Name_middle;     
				export firstname  := rawNPPESRecs.Name_first;            				
				export prim_range := rawNPPESRecs.prim_range;
				export predir := rawNPPESRecs.predir;
				export prim_name := rawNPPESRecs.prim_name;
				export addr_suffix := rawNPPESRecs.addr_suffix;
				export postdir := rawNPPESRecs.postdir;
				export unit_desig := rawNPPESRecs.unit_desig;
				export sec_range := rawNPPESRecs.sec_range;
				export city := rawNPPESRecs.p_city_name;
				export state := rawNPPESRecs.st;
				export zip := rawNPPESRecs.z5;
				export bdid := '';//(string14)rawNPPESRecs.bdid;
			END;
						
			pen_addr1 := AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod);
			pen_addr2 := AutoStandardI.LIBCALL_PenaltyI.val(tempIndvMod2);
			SELF.record_penalty:= pen_addr2;//if(pen_addr1>pen_addr2,pen_addr2,pen_addr1);
			SELF := rawNPPESRecs;
		END;
	
		penaltyRecs := sort(project(NPPESRec, setPenalty(LEFT)), record_penalty);	
		// penaltyRecs := project(NPPESRec, setPenalty(LEFT));				
		RETURN penaltyRecs;
	END;

	EXPORT apply_penalty_bdids(Dataset(myLayouts.deepBDids) bdids, 
												IParams.reportParams aInputData) := FUNCTION												

		busData := RECORD
		  unsigned2 penalt:=0;
			Business_Header.Layout_BH_Best;
		END;

		rawdata:=join(bdids,Business_Header.Key_BH_Best,keyed(left.bdid=right.bdid),transform(busData, self:=right),keep(100));

		busData setPenalty(busData RawRecs) := TRANSFORM		
			tempBusMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export city_field := RawRecs.city;
				export fname_field := '';
				export lname_field := '';
				export mname_field := '';
				export pname_field := RawRecs.prim_name;
				export postdir_field := RawRecs.postdir;
				export prange_field := RawRecs.prim_range;
				export predir_field := RawRecs.predir;
				export ssn_field := '';  
				export state_field := RawRecs.state;
				export suffix_field := RawRecs.addr_suffix;
				export sec_range_field := RawRecs.sec_range;
				export zip_field := (string)RawRecs.zip;
				export did_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := (string)RawRecs.phone;
				export bdid_field := (string)RawRecs.bdid;
				export cname_field := RawRecs.company_name;
				export fein_field := (string)RawRecs.fein;
				export agehigh := 0;
				export agelow := 0;
			END;
						
			SELF.penalt:= AutoStandardI.LIBCALL_PenaltyI.val(tempBusMod);
			SELF := RawRecs;
		END;
	
		//Penalize records and get lowest penalty record first
		penaltyRecs := sort(project(rawdata, setPenalty(LEFT)),penalt);
		//Filter results so that only records with the lowest penalty return
		resultsbdids := project(dedup(sort(penaltyRecs(penalt=penaltyRecs[1].penalt),bdid),bdid),transform(layouts.deepbdids,self:=left));
		RETURN resultsbdids;
	END;

	EXPORT apply_penalty_clia(dataset(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty) CLIARec) := FUNCTION												
		
		Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty setPenalty(Healthcare_Provider_Services.CLIA_Layouts.batch_out_penalty CLIARecs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(gm, AutoStandardI.LIBIN.PenaltyI.full,opt))
				export allow_wildcard := false;
				export pname_field := CLIARecs.clean_company_address_prim_name;
				export postdir_field := CLIARecs.clean_company_address_postdir;
				export prange_field := CLIARecs.clean_company_address_prim_range;
				export predir_field := CLIARecs.clean_company_address_predir;
				export state_field := CLIARecs.clean_company_address_st;
				export suffix_field := CLIARecs.clean_company_address_addr_suffix;
				export sec_range_field := CLIARecs.clean_company_address_sec_range;
				export city_field := CLIARecs.clean_company_address_p_city_name;
				export zip_field := CLIARecs.clean_company_address_zip;
				export bdid_field := (string)CLIARecs.bdid;
				export cname_field := CLIARecs.facility_name;
				// Empty non input.
				export fname_field := '';
				export lname_field := '';
				export mname_field := '';
				export ssn_field := '';  
				export did_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
				export phone_field := '';
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
				// Input fields
				export companyname := CLIARecs.comp_name;
				export prim_range := CLIARecs.prim_range;
				export predir := CLIARecs.predir;
				export prim_name := CLIARecs.prim_name;
				export addr_suffix := CLIARecs.addr_suffix;
				export postdir := CLIARecs.postdir;
				export unit_desig := CLIARecs.unit_desig;
				export sec_range := CLIARecs.sec_range;
				export city := CLIARecs.p_city_name;
				export state := CLIARecs.st;
				export zip := CLIARecs.z5;
				export bdid := (string14)CLIARecs._bdid;
			END;
			SELF.record_penalty:= AutoStandardI.LIBCALL_PenaltyI.val_biz(tempIndvMod);
			SELF := CLIARecs;
		END;
	
			penaltyRecs := sort(project(CLIARec, setPenalty(LEFT)), record_penalty);	
			
		RETURN penaltyRecs;
	END;

	EXPORT cleanValue(STRING inputValue) := 
	FUNCTION
		RETURN stringlib.StringFilter(stringlib.StringToUpperCase(inputValue),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	END;
	EXPORT cleanValueNumbers(STRING inputValue) := 
	FUNCTION
		RETURN stringlib.StringFilter(stringlib.StringToUpperCase(inputValue),'0123456789');
	END;
	EXPORT checkCurrentLicense(iesp.share.t_Date inputValue) := 
	FUNCTION
		licDate:= iesp.ECL2ESP.t_DateToString8(inputValue);
		currentDate:=(string)ut.GetDate;
		RETURN licDate>=currentDate;
	END;
	
		shared verification := record
				boolean MedicalSchoolNameVerified := false;
				boolean gradYearVerified := false;
				boolean upinVerified := false;
				boolean npiVerified := false;
				boolean npiExists := false;
				boolean NameVerified := false;
				boolean CompanyNameVerified := false;
				boolean AddressVerified := false;
				boolean PhoneVerified := false;
				boolean FEINVerified := false;
				boolean SSNVerified := false;
				boolean LicenseVerified := false;
				boolean CLIAVerified := false;
				boolean License2Verified := false;
				boolean License3Verified := false;
				boolean License4Verified := false;
				boolean License5Verified := false;
				boolean License6Verified := false;
				boolean License7Verified := false;
				boolean License8Verified := false;
				boolean License9Verified := false;
				boolean License10Verified := false;
				boolean DEAVerified := false;
				boolean TaxonomyVerified := false;
				boolean Taxonomy1Verified := false;
				boolean Taxonomy2Verified := false;
				boolean Taxonomy3Verified := false;
				boolean Taxonomy4Verified := false;
				boolean Taxonomy5Verified := false;
				boolean NPIValid := false;
				boolean CLIAValid := false;
				boolean DEAValid := false;
				boolean LicenseValid := false;
				boolean License2Valid := false;
				boolean License3Valid := false;
				boolean License4Valid := false;
				boolean License5Valid := false;
				boolean License6Valid := false;
				boolean License7Valid := false;
				boolean License8Valid := false;
				boolean License9Valid := false;
				boolean License10Valid := false;
			end;

		export medicalSchoolNameVerified(dataset(iesp.healthcare.t_MedicalSchool) mschools, IParams.searchParams aInputData) := Function 
			recs := project(mschools, transform(verification, self.MedicalSchoolNameVerified := if(BridgerScoreLib.companyScore(left.Name,aInputData.MedicalSchoolName)>.80,true,skip)));
			return exists(recs);
		end;

		export gradYearVerified(dataset(iesp.healthcare.t_MedicalSchool) mschools, IParams.searchParams aInputData) := Function 
			recs := project(mschools, transform(verification, self.gradYearVerified := if(aInputData.GraduationYear=(integer)left.graduationyear and (integer)left.graduationyear <> 0,true,skip)));
			return exists(recs);
		end;
		
		export upinVerified(dataset(iesp.share.t_StringArrayItem) upins, IParams.searchParams aInputData) := Function 
			hasUPIN := aInputData.UPIN <> '';
			recs := project(upins, transform(verification,self.upinVerified := if(cleanValue(left.value) = cleanValue(aInputData.UPIN) and cleanValue(left.value) <> '',true,skip)));
			return hasUPIN and exists(recs);
		end;
		
		export NpiExists(IParams.searchParams aInputData) := Function 
			hasNPI := aInputData.NPI <> '';
			tmp := dataset([{aInputData.NPI}],myLayouts.NPPES_Layouts.layout_npiid); 
			recs := getNPPESByNPI(tmp);
			return hasNPI and exists(recs);
		end;

		export NpiVerified(dataset(iesp.share.t_StringArrayItem) npis, IParams.searchParams aInputData) := Function 
			hasNPI := aInputData.NPI <> '';
			recs := project(npis, transform(verification, self.npiVerified := if(cleanValue(left.value) = cleanValue(aInputData.NPI) and cleanValue(left.value) <> '',true,skip)));
			return hasNPI and exists(recs);
		end;

		export NPIValid(dataset(iesp.npireport.t_NPIReport) npiRec, IParams.searchParams aInputData) := Function 
			hasNPI := aInputData.NPI <> '';
			recs := project(npiRec, transform(verification, self.NPIValid := if(cleanValue(left.NPIInformation.NPINumber) = cleanValue(aInputData.NPI) and 
																																					cleanValue(left.NPIInformation.NPINumber) <> '' and 
																																					(length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.DeactivationDate),all))=0 or length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.ReactivationDate),all))>0),
																																					true,skip)));
			return hasNPI and exists(recs);
		end;
		
		export NameVerified(dataset(iesp.share.t_Name) names, IParams.searchParams aInputData) := Function 
			hasFull := cleanValue(aInputData.unparsedfullname) <> '';
			hasLast := cleanValue(aInputData.lastname) <> '';
			hasInputtoVerify := hasFull or hasLast;
			recs := project(names, transform(verification, self.NameVerified := if(cleanValue(left.full) = cleanValue(aInputData.unparsedfullname) or (cleanValue(left.first) = cleanValue(aInputData.firstname) and cleanValue(left.last) = cleanValue(aInputData.lastname)),true,skip)));
			return hasInputtoVerify and exists(recs);
		end;

		export CompanyNamesVerified(dataset(iesp.share.t_Name) names, IParams.searchParams aInputData) := Function 
			hasFull := cleanValue(aInputData.companyname) <> '';
			hasInputtoVerify := hasFull;
			recs := project(names, transform(verification, self.CompanyNameVerified := IF (ut.CompanySimilar100 (cleanValue(left.full), cleanValue(aInputData.companyname),true) < 60,true,skip)));
			return hasInputtoVerify and exists(recs);
		end;
		
		export AddressVerified(dataset(iesp.healthcare.t_HealthCareBusinessAddress) addr, IParams.searchParams aInputData) := Function 
			hasPrimRange := cleanValue(aInputData.prim_range) <>'';
			hasPrimName := cleanValue(aInputData.prim_name) <>'';
			hasCity := cleanValue(aInputData.city) <>'';
			hasFullAddr := cleanValue(aInputData.addr) <>'';
			//Get Clean Address
			cln_PrimRange := trim(Address.CleanAddress182(aInputData.addr,aInputData.city+' '+aInputData.state+' '+aInputData.zip)[1..10],all);
			cln_PrimName := trim(Address.CleanAddress182(aInputData.addr,aInputData.city+' '+aInputData.state+' '+aInputData.zip)[13..40],all);
			hasInputAddrtoVerify := (hasPrimRange and hasPrimName) or hasFullAddr or (hasPrimName and hasCity);
			input_range := if(hasFullAddr,cleanValue(cln_PrimRange),cleanValue(aInputData.prim_range));
			input_name := if(hasFullAddr,cleanValue(cln_PrimName),cleanValue(aInputData.prim_name));
			recs := project(addr, transform(verification, self.AddressVerified := if((cleanValue(left.Address.StreetNumber) = input_range and 
																																									cleanValue(left.Address.StreetName) = input_name) or 														
																																									cleanValue(left.Address.StreetAddress1) = cleanValue(aInputData.addr) or  
																																									(cleanValue(left.Address.StreetName) = input_name and 
																																									cleanValue(left.Address.city) = cleanValue(aInputData.city)),true,skip)));
			return hasInputAddrtoVerify and exists(recs);
		end;
		
		export PhoneVerified(dataset(iesp.healthcare.t_HealthCareBusinessAddress) addressPhones, IParams.searchParams aInputData) := Function 
			hasPhone := aInputData.Phone <> '';
			recs := project(addressPhones.Phones, transform(verification, self.PhoneVerified := if(cleanValue(left.Phone10) = cleanValue(aInputData.Phone) and cleanValue(left.Phone10) <> '',true,skip)));
			return hasPhone and exists(recs);
		end;
		
		export FEINVerified(dataset(iesp.share.t_StringArrayItem) feins, dataset(iesp.share.t_StringArrayItem) taxids, IParams.searchParams aInputData) := Function 
			hasTIN := aInputData.taxid <> '';
			hasFEIN := aInputData.FEIN <> '';
			hasInputValuetoVerify := hasTIN or hasFEIN;
			recs := project(feins+taxids, transform(verification, self.FEINVerified := if((cleanValue(left.value) = cleanValue(aInputData.FEIN) or cleanValue(left.value) = cleanValue(aInputData.taxid)) and cleanValue(left.value) <> '',true,skip)));
			return hasInputValuetoVerify and exists(recs);
		end;
		
		export SSNVerified(dataset(iesp.share.t_StringArrayItem) ssns, IParams.searchParams aInputData) := Function 
			hasSSN := aInputData.SSN <> '';
			recs := project(ssns, transform(verification, self.SSNVerified := if(cleanValue(left.value) = cleanValue(aInputData.SSN) and cleanValue(left.value) <> '',true,skip)));
			return hasSSN and exists(recs);
		end;
		
		export LicenseVerified(dataset(iesp.healthcare.t_ProviderLicenseInfo) licenses, IParams.searchParams aInputData) := Function 
			hasLicense := aInputData.LicenseNumber <> '' or aInputData.StateLicenses[1].LicenseNumber <> '';
			hasLicenseState := aInputData.LicenseState <> '' or aInputData.StateLicenses[1].LicenseState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			recs := project(licenses, transform(verification, self.LicenseVerified := if((cleanValue(left.LicenseNumber) = cleanValue(aInputData.LicenseNumber) or cleanValueNumbers(left.LicenseNumber) = cleanValueNumbers(aInputData.LicenseNumber)) and cleanValue(left.LicenseState) = cleanValue(aInputData.LicenseState)  and cleanValue(left.LicenseNumber) <> '',true,skip)));
			return hasLicensetoVerify and exists(recs);
		end;

		export LicenseValid(dataset(iesp.healthcare.t_ProviderLicenseInfo) licenses, IParams.searchParams aInputData) := Function 
			hasLicense := aInputData.LicenseNumber <> '';
			hasLicenseState := aInputData.LicenseState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			recs := project(licenses, transform(verification, self.LicenseVerified := if((cleanValue(left.LicenseNumber) = cleanValue(aInputData.LicenseNumber) or cleanValueNumbers(left.LicenseNumber) = cleanValueNumbers(aInputData.LicenseNumber)) and cleanValue(left.LicenseState) = cleanValue(aInputData.LicenseState)  and cleanValue(left.LicenseNumber) <> ''  and checkCurrentLicense(left.ExpirationDate),true,skip)));
			return hasLicensetoVerify and exists(recs);
		end;

		export LicenseDSVerified(dataset(iesp.healthcare.t_ProviderLicenseInfo) licenses, IParams.searchParams aInputData, integer rownum, dataset(iesp.healthcare.t_StateLicenseRecord) customerLicense = dataset([],iesp.healthcare.t_StateLicenseRecord)) := Function 
			hasLicense := aInputData.StateLicenses[rownum].LicenseNumber <> '';
			hasLicenseState := aInputData.StateLicenses[rownum].LicenseState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			validCustomer := hasLicense and exists(customerLicense(LicenseNumber=aInputData.StateLicenses[rownum].LicenseNumber));
			recs := project(licenses, transform(verification, self.LicenseVerified := if(validCustomer or
																																										((cleanValue(left.LicenseNumber) = cleanValue(aInputData.StateLicenses[rownum].LicenseNumber) or 
																																										cleanValueNumbers(left.LicenseNumber) = cleanValueNumbers(aInputData.StateLicenses[rownum].LicenseNumber)) and 
																																										(cleanValue(left.LicenseState) = cleanValue(aInputData.StateLicenses[rownum].LicenseState) or aInputData.StateLicenses[rownum].LicenseState = '') and 
																																										cleanValue(left.LicenseNumber) <> ''),true,skip)));
			return validCustomer or (hasLicensetoVerify and exists(recs));
		end;
		
		export LicenseDSValid(dataset(iesp.healthcare.t_ProviderLicenseInfo) licenses, IParams.searchParams aInputData, integer rownum, dataset(iesp.healthcare.t_StateLicenseRecord) customerLicense = dataset([],iesp.healthcare.t_StateLicenseRecord)) := Function 
			hasLicense := aInputData.StateLicenses[rownum].LicenseNumber <> '';
			hasLicenseState := aInputData.StateLicenses[rownum].LicenseState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			validCustomer := hasLicense and exists(customerLicense(LicenseNumber=aInputData.StateLicenses[rownum].LicenseNumber)) and checkCurrentLicense(customerLicense(LicenseNumber=aInputData.StateLicenses[rownum].LicenseNumber)[1].ExpirationDate);
			recs := project(licenses, transform(verification, self.LicenseVerified := if(validCustomer or
																																									  ((cleanValue(left.LicenseNumber) = cleanValue(aInputData.StateLicenses[rownum].LicenseNumber) or 
																																										cleanValueNumbers(left.LicenseNumber) = cleanValueNumbers(aInputData.StateLicenses[rownum].LicenseNumber)) and 
																																										(cleanValue(left.LicenseState) = cleanValue(aInputData.StateLicenses[rownum].LicenseState) or aInputData.StateLicenses[rownum].LicenseState = '')  and 
																																										cleanValue(left.LicenseNumber) <> '' and 
																																										checkCurrentLicense(left.ExpirationDate)),true,skip)));
			return validCustomer or (hasLicensetoVerify and exists(recs));
		end;
		
		export CLIAVerified(dataset(iesp.cliasearch.t_CLIARecord) CliaRec, IParams.searchParams aInputData) := Function 
			hasClia := aInputData.CLIANumber <> '';
			recs := project(CliaRec, transform(verification, self.CLIAVerified := if(cleanValue(left.CLIANumber) = cleanValue(aInputData.CLIANumber) and cleanValue(left.CLIANumber) <> '',true,skip)));
			return hasClia and exists(recs);
		end;

		export CLIAValid(dataset(iesp.cliasearch.t_CLIARecord) CliaRec, IParams.searchParams aInputData) := Function 
			hasClia := aInputData.CLIANumber <> '';
			recs := project(CliaRec, transform(verification, self.CLIAVerified := if(cleanValue(left.CLIANumber) = cleanValue(aInputData.CLIANumber) and cleanValue(left.CLIANumber) <> '' and checkCurrentLicense(left.ExpirationDate),true,skip)));
			return hasClia and exists(recs);
		end;
		
		export DEAVerified(dataset(iesp.healthcare.t_DEAControlledSubstanceRecordEx) DEARec, IParams.searchParams aInputData) := Function 
			hasDea := aInputData.DEA <> '';
			recs := project(DEARec, transform(verification, self.DEAVerified := if((cleanValue(left.RegistrationNumber) = cleanValue(aInputData.DEA) or cleanValueNumbers(left.RegistrationNumber) = cleanValueNumbers(aInputData.DEA)) and cleanValue(left.RegistrationNumber) <> '',true,skip)));
			return hasDea and exists(recs);
		end;

		export DEAValid(dataset(iesp.healthcare.t_DEAControlledSubstanceRecordEx) DEARec, IParams.searchParams aInputData) := Function 
			hasDea := aInputData.DEA <> '';
			recs := project(DEARec, transform(verification, self.DEAVerified := if((cleanValue(left.RegistrationNumber) = cleanValue(aInputData.DEA) or cleanValueNumbers(left.RegistrationNumber) = cleanValueNumbers(aInputData.DEA)) and cleanValue(left.RegistrationNumber) <> '' and checkCurrentLicense(left.ExpirationDate),true,skip)));
			return hasDea and exists(recs);
		end;

		export TaxonomyVerified(dataset(iesp.proflicense.t_Taxonomy) TaxonomyRec, IParams.searchParams aInputData) := Function 
			hasTaxonomy := aInputData.Taxonomy <> '';
			recs := project(TaxonomyRec, transform(verification, self.TaxonomyVerified := if(cleanValue(left.TaxonomyCode) = cleanValue(aInputData.Taxonomy) and cleanValue(left.TaxonomyCode) <> '',true,skip)));
			return hasTaxonomy and exists(recs);
		end;
		SHARED taxonomyRecs := record
			 String15 taxonomy:='';
			 unsigned1 inputrow:=0;
		end;
		export TaxonomyVerifiedMultiple(dataset(iesp.proflicense.t_Taxonomy) TaxonomyRec, IParams.searchParams aInputData, dataset(iesp.npireport.t_NPIReport) NPIData = dataset([],iesp.npireport.t_NPIReport)) := Function 
			//Build hashtable of input Taxonomies
			dsInput := dataset([{cleanValue(aInputData.Taxonomy),1},
													{cleanValue(aInputData.Taxonomy2),2},
													{cleanValue(aInputData.Taxonomy3),3},
													{cleanValue(aInputData.Taxonomy4),4},
													{cleanValue(aInputData.Taxonomy5),5}],taxonomyRecs)(taxonomy <> '');//Filter out blank rows
			//Build hashtable of data Taxonomies
			dsData := dedup(project(npidata[1].ProviderTaxonomies,transform(taxonomyRecs,self.taxonomy := left.SelectedTaxonomyCode;)),all)(taxonomy <> '');//Filter out blank rows;
			dsJoin := join(dsInput,dsData,left.taxonomy=right.taxonomy,Transform(taxonomyRecs, self:=left));
			hasTaxonomy := aInputData.Taxonomy <> '' or aInputData.Taxonomy2 <> '' or aInputData.Taxonomy3 <> ''or aInputData.Taxonomy4 <> '' or aInputData.Taxonomy5 <> '';
			return dsJoin(hasTaxonomy);
		end;
		
		export CompanyNameVerified(string company_name, IParams.searchParams aInputData) := Function 
			hasCompanyNameToVerify := cleanValue(aInputData.companyName) <> '';
			isSameCompanyName := cleanValue(company_name) = cleanValue(aInputData.companyName);
			return hasCompanyNametoVerify and isSameCompanyName;
		end;
		
		export MatchingInputVerified(dataset(myLayouts.NPPES_Layouts.temp_layout) in_data, IParams.searchParams aInputData) := FUNCTION
			boolean hasNPI := aInputData.NPI <> '';
			npi_verif_rec := project(in_data, transform(iesp.share.t_StringArrayItem, self.value := left.npi));
			boolean hasMatchingNPI := NPIVerified(npi_verif_rec, aInputData);
			
			boolean hasName := aInputData.FirstName <> '' and aInputData.LastName <> '' or aInputData.CompanyName <> '';
			name_verif_rec := project(in_data, transform(iesp.share.t_Name, self.first := left.provider_first_name, 
																																			self.last := left.provider_last_name,
																																			self.full := '',
																																			self := []));
			boolean hasMatchingPersonName := NameVerified(name_verif_rec, aInputData);
			boolean hasMatchingCompanyName := CompanyNameVerified(in_data[1].provider_organization_name, aInputData);
			boolean hasMatchingName := hasMatchingPersonName or hasMatchingCompanyName;
			
			boolean hasAddress := aInputData.addr <> '' and (aInputData.Zip <> '' or (aInputData.City <> '' and aInputData.State <> ''));
			addr_verif_rec := project(in_data, transform(iesp.healthcare.t_HealthCareBusinessAddress, 
																				 self.Address.StreetNumber := left.clean_norm_address.prim_range,
																				 self.Address.StreetName := left.clean_norm_address.prim_name,
																				 self.Address.StreetAddress1 := address.Addr1FromComponents(left.clean_norm_address.prim_range,left.clean_norm_address.predir,
																																																		 left.clean_norm_address.prim_name, left.clean_norm_address.addr_suffix, 
																																																		 left.clean_norm_address.postdir, left.clean_norm_address.unit_desig, 
																																																		 left.clean_norm_address.sec_range),
																				 self.Address.City := left.clean_norm_address.p_city_name,
																				 self := []));
			boolean hasMatchingAddress := AddressVerified(addr_verif_rec, aInputData);																																																						
			
			boolean InputMatches := (hasMatchingNPI or ~hasNPI) and 
														 (hasMatchingName or ~hasName)  and 
														 (hasMatchingAddress or ~hasAddress);
			return InputMatches;
		end;

		export SanctionMatchesProvider(dataset(doxie.ingenix_provider_module.layout_ingenix_provider_report) providers, dataset(doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report) sanctions) := Function 
			sancRecIDs := project(sanctions,transform(myLayouts.layout_providerVerify,self.SANC_ID:=(integer)left.SANC_ID;self := left,self:=[]));
			normIDs := NORMALIZE(providers,left.sanction_id,transform(myLayouts.layout_providerVerify,self.ProviderID:=(unsigned6)left.ProviderID,self.SANC_ID:=(integer)right.SANC_ID,self:=[]));
			normdids := NORMALIZE(providers,left.providerdid,transform(myLayouts.layout_providerVerify,self.ProviderID:=(unsigned6)left.ProviderID,self.did:=right.did,self:=[]))(did<>'0');
			normUPINs := NORMALIZE(providers,left.upin,transform(myLayouts.layout_providerVerify,self.ProviderID:=(unsigned6)left.ProviderID,self.upin:=right.upin,self:=[]));
			// normLic :=  NORMALIZE(providers,left.license,transform(myLayouts.layout_providerVerify,self.ProviderID:=(unsigned6)left.ProviderID,self.LicenseState:=right.LicenseState,self.LicenseNumber:=right.LicenseNumber,self:=[]));
			normTaxIDs :=  NORMALIZE(providers,left.taxid,transform(myLayouts.layout_providerVerify,self.ProviderID:=(unsigned6)left.ProviderID,self.taxid:=right.taxid,self:=[]));
			filterProvidersSancID := join(normIDs,sancRecIDs,left.SANC_ID = right.SANC_ID,transform(myLayouts.layout_providerVerify, self.SANC_ID:=(integer)right.SANC_ID;self := right),keep(100));
			filterProvidersDid := join(normdids,sanctions,(integer)left.did = (integer)right.DID,transform(myLayouts.layout_providerVerify, self.SANC_ID:=(integer)right.SANC_ID;self := right),keep(100));
			filterProvidersUPIN := join(normUPINs,sanctions,left.UPIN = right.SANC_UPIN,transform(myLayouts.layout_providerVerify, self.SANC_ID:=(integer)right.SANC_ID;self := right),keep(100));
			// filterProvidersLic := join(normLic,sanctions,left.LicenseNumber = right.SANC_LICNBR and left.LicenseState = right.SANC_SANCST,transform(myLayouts.layout_providerVerify, self := right),keep(100));
			filterProvidersTaxID := join(normTaxIDs,sanctions,left.taxid = right.SANC_TIN and right.bdid = '',transform(myLayouts.layout_providerVerify, self.SANC_ID:=(integer)right.SANC_ID;self := right),keep(100));
			// return any records that match any of the criteria
			combinedFilters := dedup(sort(filterProvidersSancID+filterProvidersDid+filterProvidersUPIN+filterProvidersTaxID,record),record);
			retRecs := join(sanctions,combinedFilters,left.SANC_ID=(string)right.SANC_ID,transform(doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report,self.SANC_ID:=(string)right.SANC_ID;self:=left),keep(100));
			return if(exists(providers),retRecs,sanctions);
		end;

		Export VerifyNPI(dataset(myLayouts.layout_npi) npis, dataset(myLayouts.layout_nameinfo) inputNames, dataset(myLayouts.autokeyInput) inputCriteria) := function
			tmpNpiRec := record
				pid_npi_rec;
				STRING120 	CompanyName := '';
				string20		FirstName := '';
				string20		MiddleName := '';
				string20		LastName := '';
				unsigned1		ranking := 100;
			end;
			recsNpi := project(Npis, transform(tmpNpiRec,SELF.npi := left.npi;SELF.providerid := 0;self.NPITierTypeID :=0;self.NPPESVerified := 'No';));

			nppes_ids_bynpi := join(recsNpi(npi<>''),NPPES.Key_NPPES_npi, keyed(left.npi=right.npi), 
															transform(tmpNpiRec, self.CompanyName:=right.provider_organization_name;
																				self.FirstName := right.provider_first_name;
																				self.LastName := right.provider_last_name;
																				self.npi := left.npi;
																				self:=[]), left outer, keep(100));
			verifiedNpiLast := join(nppes_ids_bynpi, inputNames, left.LastName = right.LastName,
																transform(tmpNpiRec, 
																self.NPI:=left.npi;
																self.NPPESVerified:='YES';
																self.ranking:=1;
																self := left; self :=[]),
																left outer, keep(100));
			NpiFinal:=project(dedup(sort(verifiedNpiLast,npi,ranking),npi,ranking),transform(pid_npi_rec, self:= left;));
			
			tmpMod:= MODULE(PROJECT(gm, Healthcare_Provider_Services.IParams.searchParams,opt))		
				EXPORT LastName := inputCriteria[1].name_last;      			
				EXPORT FirstName := inputCriteria[1].name_first;      			
				EXPORT MiddleName := inputCriteria[1].name_middle;      			
				EXPORT CompanyName := inputCriteria[1].comp_name;
				export predir := inputCriteria[1].predir;
				export prim_range := inputCriteria[1].prim_range;
				export prim_name := inputCriteria[1].prim_name;
				export suffix := inputCriteria[1].addr_suffix;
				export postdir := inputCriteria[1].postdir;
				export sec_range := inputCriteria[1].sec_range;
				export City := inputCriteria[1].p_city_name;
				export state := inputCriteria[1].st;
				export zip := inputCriteria[1].z5;
			END;
			by_ak	:= getNPPESByAutokeys(tmpmod);
			nppes_ids_by_ak:= by_ak(provider_last_name = inputCriteria[1].name_last and
																(clean_norm_address.zip = inputCriteria[1].z5));
			nppes_by_ak_Valid := count(nppes_ids_by_ak)=1;
			getGoodData := if(nppes_by_ak_Valid and not exists(NpiFinal(NPPESVerified='YES')),project(nppes_ids_by_ak,transform(pid_npi_rec,
																		self.NPI := left.npi;
																		self.NPPESVerified := 'CORRECTED';
																		self := [])),dataset([],pid_npi_rec));
			final := dedup(sort((NpiFinal+getGoodData)(NPI<>''),npi,-nppesverified),npi);
			results := project(final,doxie.ingenix_provider_module.ingenix_npi_rec);
			return if(count(verifiedNpiLast(ranking=1))>0,project(NpiFinal,doxie.ingenix_provider_module.ingenix_npi_rec),results);
		End;

/*		Export getCLIA(dataset(myLayouts.layout_slim_sanction) input) := Function
			byClia := normalize(input,left.clianumbers,transform(Layouts.layout_slim_clia,self.acctno := left.acctno;self.ProviderID:=left.ProviderID;self.clianumber:=right.clianumber;self:=[]));
			cliaRaw := join(byClia,clia.keys().CLIA_Number.qa,keyed(left.clianumber=right.clia_number),
													Healthcare_Provider_Services.CLIA_Transforms.acctPlusESDLRecords(left,right), 
													keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			//Does this CLIA record really belong to what the user supplied as input?
			//Join results back to input and compare business name found with business name user supplied
			cliaRawVerified := join(input,cliaRaw,left.acctno=right.acctno and left.ProviderID=right.ProviderID,
															transform(Healthcare_Provider_Services.Layouts.layout_clia,
																				closematch1 := if(right.CompanyName<>'',ut.CompanySimilar100(getCleanHealthCareName(left.CompanyName),getCleanHealthCareName(right.CompanyName)),1000);
																				closematch2 := if(right.CompanyName2<>'',ut.CompanySimilar100(getCleanHealthCareName(left.CompanyName),getCleanHealthCareName(right.CompanyName2)),1000);
																				bestmatch := if(closematch1<closematch2,closematch1,closematch2);
																				self.acctno := if(bestmatch<=Constants.BUS_NAME_MATCH_THRESHOLD,right.acctno,skip);
																				self := right));
			myLayouts.layout_child_clia doRollup(myLayouts.layout_clia l, dataset(myLayouts.layout_clia) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := project(r,iesp.cliasearch.t_CLIARecord);
			END;
			results_rolled := rollup(group(sort(cliaRawVerified,acctno,ProviderID),acctno,ProviderID),group,doRollup(left,rows(left)));
			// output(input,named('GetCLIA_Input'));
			// output(byClia,named('GetCLIA_byClia'));
			// output(cliaRaw,named('GetCLIA_cliaRaw'));
			// output(cliaRawVerified,named('GetCLIA_cliaRawVerified'));
			// output(results_rolled,named('GetCLIA_results_rolled'));
			return results_rolled; 
		end;*/
		Export getCustomerLicenseData(dataset(myLayouts.autokeyInput) input) := function
			myCustomerRecords := Healthcare_Services.Customer_License_Search_Records;
			myCustomerLayout := Healthcare_Services.Customer_License_Search_Layouts;
			covertedInput1 := project(input,transform(myCustomerLayout.autokeyInput,self:=left));
			covertedInput2 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense2verification;self.license_state:=left.statelicense2stateverification;self:=left));
			covertedInput3 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense3verification;self.license_state:=left.statelicense3stateverification;self:=left));
			covertedInput4 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense4verification;self.license_state:=left.statelicense4stateverification;self:=left));
			covertedInput5 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense5verification;self.license_state:=left.statelicense5stateverification;self:=left));
			covertedInput6 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense6verification;self.license_state:=left.statelicense6stateverification;self:=left));
			covertedInput7 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense7verification;self.license_state:=left.statelicense7stateverification;self:=left));
			covertedInput8 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense8verification;self.license_state:=left.statelicense8stateverification;self:=left));
			covertedInput9 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense9verification;self.license_state:=left.statelicense9stateverification;self:=left));
			covertedInput10 := project(input,transform(myCustomerLayout.autokeyInput,self.license_number:=left.statelicense10verification;self.license_state:=left.statelicense10stateverification;self:=left));
			covertedInput := covertedInput1+covertedInput2+covertedInput3+covertedInput4+covertedInput5+covertedInput6+covertedInput7+covertedInput8+covertedInput9+covertedInput10;
			mylayouts.layout_customerLicense get_CustomerLicenseData(myCustomerLayout.LayoutOutput l) := transform
				self.acctno := l.acctno;
				self.ProviderID := 0;
				self.CustomerDataSrc := (string)l.customer_id;
				self.Name := iesp.ECL2ESP.SetName (l.clean_name.fname, l.clean_name.mname, l.clean_name.lname,
																					 l.clean_name.name_suffix, l.clean_name.title, l.name_first_middle+ ' '+l.name_last+' '+l.name_suffix);
				self.LicenseNumber := l.license_number;
				self.LicenseType := l.bull_license_type;
				self.LicenseTypeDesc := l.bull_lic_type_desc;
				self.LicenseBoardCd := l.license_number[1..2];
				self.LicenseBoardDesc := l.license_board_code_desc;
				self.LicenseStatusCd := l.sec_license_status;
				self.LicenseStatusDesc := l.license_status_desc;
				self.LastChangeDate := iesp.ECL2ESP.toDate((integer)l.license_status_date);
				self.ExpirationDate := iesp.ECL2ESP.toDate((integer)l.expiration_date);
				self := [];
			end;
			CustomerLicenseData := project(myCustomerRecords.records(covertedInput(license_number<>''),10),
																			get_CustomerLicenseData(left));

			myLayouts.layout_fullchild_customerLicense doRollup(myLayouts.layout_customerLicense l, dataset(mylayouts.layout_customerLicense) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := project(r,iesp.healthcare.t_StateLicenseRecord);
			END;
			results_rolled := rollup(group(CustomerLicenseData,acctno),group,doRollup(left,rows(left)));
			return results_rolled;
		end;
		Export appendCustomerLicenseData (dataset(myLayouts.autokeyInput) input, 
														dataset(myLayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
			fmtRec_CustomerLicenseData := getCustomerLicenseData(input);
			results := join(inputRecs,fmtRec_CustomerLicenseData, left.acctno=right.acctno,
																			transform(myLayouts.CombinedHeaderResultsDoxieLayout,
																								self.customerLicense := right.childinfo;
																								self := left),left outer);
			return results;
		end;
		Export getCustomerDeathData(dataset(myLayouts.autokeyInput) input) := function
			mylayouts.layout_customerDeath get_CustomerDeathData(Healthcare_Services.Customer_Death_Search_Layouts.LayoutOutput l) := transform
				self.acctno := l.acctno;
				self.ProviderID := 0;
				self.CustomerDataSrc := (string)l.customer_id;
				self.Name := iesp.ECL2ESP.SetName (l.clean_name.fname, l.clean_name.mname, l.clean_name.lname,
																					 l.clean_name.name_suffix, l.clean_name.title, l.fname+' '+l.mname+ ' '+l.lname);
				self.DOD := iesp.ECL2ESP.toDate((integer)l.dod);
				self.SSN := l.ssn;
				self.LicenseNumber := '';//l.license_number;
				self.MatchPercent := l.MatchPercent;
				self.IsMatchFirst := l.isFirstNameMatch;
				self.IsMatchLast := l.isLastNameMatch;
				self.IsMatchDOB := l.isDOBMatch;
			end;
			DeathInputRecords := project(input,Healthcare_Services.Customer_Death_Search_Layouts.autokeyInput);
			CustomerDeathData := project(Healthcare_Services.Customer_Death_Search_Records.records(DeathInputRecords),
																			get_CustomerDeathData(left));

			myLayouts.layout_fullchild_customerDeath doRollup(myLayouts.layout_customerDeath l, dataset(mylayouts.layout_customerDeath) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.ProviderID := l.ProviderID;
				self.childinfo := project(r,iesp.healthcare.t_StateVitalRecord);
			END;
			// output(DeathInputRecords,named('DeathInputRecords'));
			results_rolled := rollup(group(CustomerDeathData,acctno),group,doRollup(left,rows(left)));
			return results_rolled;
		end;
		Export appendCustomerDeathData (dataset(myLayouts.autokeyInput) input, 
																		dataset(myLayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
			fmtRec_CustomerDeathData := getCustomerDeathData(input);
			results := join(inputRecs,fmtRec_CustomerDeathData, left.acctno=right.acctno,
																			transform(myLayouts.CombinedHeaderResultsDoxieLayout,
																								self.customerDeath := right.childinfo;
																								self := left),left outer);
			return results;
			// return inputRecs;
		end;
		Export getABMSData(dataset(myLayouts.autokeyInput) input, dataset(mylayouts.layout_slim_sanction) inputSlim) := function
			convertedInputRecordsUserData := project(input,transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput,
																															hasAddr := left.prim_name <> '' and ((left.p_city_name <>'' and left.st <> '') or left.z5 <> '');
																															hasDid := left.did > 0;
																															hasBdid := left.bdid > 0;
																															hasNPI := left.npi <> '';
																															hasSpecialty := left.BoardCertifiedSpecialtyVerification <> '' or left.BoardCertifiedSubSpecialtyVerification <> '';
																															hasValidCriteria := hasAddr or hasDid or hasbdid or hasNPI;//or (hasName and hasSpecialty);//Name and Specialty is too loose
																															self.acctno := if(hasValidCriteria,left.acctno,skip);
																															self := left;));
			// we need to build input records for each DID/NPI already collected use the providerid as the account
			getDerivedDids := normalize(inputSlim,left.dids,transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput,self.seq:=(integer)left.acctno;self.acctno := (String)left.ProviderID;self.did:=right.did;self:=[]))(did>0);
			getDerivedNPIs := normalize(inputSlim,left.npis,transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput,self.seq:=(integer)left.acctno;self.acctno := (String)left.ProviderID;self.npi:=right.npi;self:=[]))(NPI<>'');
			convertedInputRecordsDerivedDid := join(input,getDerivedDids,left.acctno = (string)right.seq, transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput, self.acctno := right.acctno; self.seq := right.seq; self.did:=right.did;self := left));
			convertedInputRecordsDerivedNPI := join(input,getDerivedNPIs,left.acctno = (string)right.seq, transform(Healthcare_Provider_Services.ABMS_Layouts.autokeyInput, self.acctno := right.acctno; self.seq := right.seq; self.npi:=right.npi;self := left));
			convertedInputRecords := convertedInputRecordsUserData+convertedInputRecordsDerivedDid+convertedInputRecordsDerivedNPI;
			abmsRecsRaw := Healthcare_Provider_Services.ABMS_Records().getRecords(convertedInputRecords);	
			abmsRecs := project(abmsRecsRaw,iesp.abms.t_ABMSResults);	
			//Now that we have records back we need to rejoin them back to the correct acctno
			relink2InputAcctno := join(convertedInputRecordsUserData,abmsRecs, left.acctno = right.AccountNumber, transform(mylayouts.layout_abms, self.acctno := right.AccountNumber; self := right));
			relink2DerivedData := join(convertedInputRecordsDerivedDid+convertedInputRecordsDerivedNPI,abmsRecs, left.acctno = right.AccountNumber, transform(mylayouts.layout_abms, self.acctno := (string)left.seq; self.AccountNumber:=(string)left.seq;self := right));
			//hopefully, the relinked data will be linked to the original acct number and have a penalty that should put the best record on top
			finalABMSData := sort(relink2InputAcctno+relink2DerivedData,acctno,if(isInputNPIMatched or isDerivedNPIMatched,1,2),_Penalty);
			finalABMSDataDedup := dedup(finalABMSData,acctno,abmsbiogid);
			reformatDedup := project(finalABMSDataDedup,iesp.abms.t_ABMSResults);
			
			myLayouts.layout_fullchild_abms doRollup(iesp.abms.t_ABMSResults l, dataset(iesp.abms.t_ABMSResults) r) := TRANSFORM
				SELF.acctno := l.AccountNumber;
				self.ProviderID := (unsigned6)l.ABMSBiogID;
				self.childinfo := project(r,iesp.abms.t_ABMSResults);
			END;
			results_rolled := rollup(group(sort(reformatDedup,AccountNumber,ABMSBiogID),AccountNumber,ABMSBiogID),group,doRollup(left,rows(left)));
			// output(input,named('inputABMSCall'));
			// output(inputSlim,named('inputSlim'));
			// output(convertedInputRecordsUserData,named('convertedInputRecordsUserData'));
			// output(getDerivedDids,named('getDerivedDids'));
			// output(getDerivedNPIs,named('getDerivedNPIs'));
			// output(convertedInputRecordsDerivedDid,named('convertedInputRecordsDerivedDid'));
			// output(convertedInputRecordsDerivedNPI,named('convertedInputRecordsDerivedNPI'));
			// output(convertedInputRecords,named('convertedInputRecords'));
			// output(abmsRecsRaw,named('abmsRecsRaw'));
			// output(abmsRecs,named('abmsRecs4Abms'));
			// output(relink2InputAcctno,named('relink2InputAcctno'));
			// output(relink2DerivedData,named('relink2DerivedData'));
			// output(finalABMSData,named('finalABMSData'));
			// output(reformatDedup,named('reformatDedup'));
			// output(results_rolled,named('results_rolled4Abms'));
			return results_rolled;
		end;
		Export appendABMSData (dataset(myLayouts.autokeyInput) input,
													 dataset(mylayouts.layout_slim_sanction) inputSlim,
													 dataset(myLayouts.CombinedHeaderResultsDoxieLayout) inputRecs) := function
			fmtRec_ABMSData := getABMSData(input(name_last <> '' and IncludeABMSSpecialty=true),inputSlim);//Remove business only search records
			results := join(inputRecs,fmtRec_ABMSData, left.acctno=right.acctno,
																			transform(myLayouts.CombinedHeaderResultsDoxieLayout,
																								self.abmsRaw := right.childinfo;
																								self := left),left outer);
			return results;
			// return inputRecs;
		end;
End;