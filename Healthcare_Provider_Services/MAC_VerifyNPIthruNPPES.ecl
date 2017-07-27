IMPORT AutoStandardI;

EXPORT MAC_VerifyNPIthruNPPES(infile,  
															outfile,
															clean_lname_field,
															clean_fname_field,
															clean_mname_field,
															clean_prim_range_field,
															clean_prim_name_field,
															clean_predir_field,
															clean_postdir_field,
															clean_addr_suffix_field,
															clean_sec_range_field,
															clean_p_city_name_field,
															clean_st_field,
															clean_zip_field,	
															id_field,
															SANC_BUSNME,
															npi_field = 'npi',
															nppesverified_field = 'NPPESVerified',
															seq = 'seq') := MACRO
															
	#uniquename(nppes_npi_key)
	%nppes_npi_key% := NPPES.Key_NPPES_npi;

	#uniquename(out_rec)
	%out_rec% := RECORD
		UNSIGNED seq;
		UNSIGNED6 id_field;
		doxie.ingenix_provider_module.ingenix_npi_rec;
	END;
	
	#uniquename(check_npi)
	infile %check_npi%(infile L, %nppes_npi_key% R) := transform
		STRING npi_key_last_name := stringlib.StringToUpperCase(R.provider_last_name);
		STRING rec_last_name := stringlib.StringToUpperCase(L.clean_lname_field);
		BOOLEAN isNPIMatch := npi_key_last_name = rec_last_name;
		SELF.nppesverified_field := IF(isNPIMatch, 'YES', 'NO');
		SELF := L;
	END;
	
	#uniquename(join_w_npi)
	#uniquename(join_w_npi_dup)
  // first join the incoming dataset to the nppes npi key file to verify any existing NPIs
	%join_w_npi% := join(infile, %nppes_npi_key%, left.npi_field = right.npi, %check_npi%(left, right), left outer);
	
	%join_w_npi_dup% := dedup(sort(%join_w_npi%, seq, if(nppesverified_field = 'YES', 1, 2)), seq);
	
	//Get NPI from NPPPES for records with NPPESVerified = NO
	#uniquename(global_module)
	#uniquename(tempmod)
	#uniquename(get_npi)
	#uniquename(ids_found)
	#uniquename(dup_ids)
	#uniquename(ids_rec)
	#uniquename(npi_final)
	%global_module% := AutoStandardI.GlobalModule();

	infile %get_npi%(infile L) := TRANSFORM
		%tempmod% := MODULE(project(%global_module%,IParams.searchParams,opt))
				EXPORT LastName     := l.clean_lname_field;  
				EXPORT FirstName    := L.clean_fname_field; 
				export MiddleName		:= L.clean_mname_field;
				export primrange		:= L.clean_prim_range_field;
				export primname			:= L.clean_prim_name_field;
				export predir				:= L.clean_predir_field;
				export postdir			:= L.clean_postdir_field;
				export suffix				:= L.clean_addr_suffix_field;
				export secrange			:= L.clean_sec_range_field;
				EXPORT City         := L.clean_p_city_name_field;
				EXPORT State        := L.clean_st_field;
				EXPORT Zip          := L.clean_zip_field;	
				EXPORT CompanyName	:= L.SANC_BUSNME;
				EXPORT DID					:= L.did;
		END;
    
    // the following function (getNPPESByAutokeys) is in: Healthcare_Provider_Services.Functions
    // if you fully qualify the function call, it generates a recursive call error.
		%ids_found% := getNPPESByAutokeys(%tempmod%);
		%dup_ids% 	:= DEDUP(SORT(%ids_found%, npi), npi);
		%ids_rec% := %dup_ids%(stringlib.StringToUpperCase(clean_name_provider.lname) = stringlib.StringToUpperCase(L.clean_lname_field));
		// If there is more than one matching record returned, then we don't know which NPI to use, so 
    // we aren't taking any. (We are only correcting/updating those records with a single NPI returned)
    %npi_final% := IF( COUNT(%ids_rec%) = 1, %ids_rec%[1].npi, L.npi);
		SELF.npi_field := %npi_final%;
		SELF.nppesverified_field := IF(COUNT(%ids_rec%) = 1, 'CORRECTED', 'NO');
		SELF := L;
	END;
	
	#uniquename(notverified)
	#uniquename(bad_npi_ds)
	#uniquename(get_npi_autokey_batch)
	#uniquename(get_npi_filter_batch)
	#uniquename(bad_npi)
	#uniquename(final_npi)
	%notverified% := %join_w_npi_dup%(nppesverified_field = 'NO' and (trim(clean_lname_field,all) <> '' or trim(SANC_BUSNME,all) <> '') and trim(clean_p_city_name_field,all) <> '' and trim(clean_zip_field,all) <> '');
	%bad_npi_ds% := PROJECT(%notverified%, transform(Healthcare_Provider_Services.Layouts.autokeyInput,
																																								  self.acctno:= (string)left.seq;
																																									self.name_first:= left.clean_fname_field;
																																									self.name_middle := left.clean_mname_field;
																																									self.name_last := left.clean_lname_field;
																																									self.prim_range := left.clean_prim_range_field;
																																									self.predir := left.clean_predir_field;
																																									self.prim_name := left.clean_prim_name_field;
																																									self.addr_suffix := left.clean_addr_suffix_field;
																																									self.postdir := left.clean_postdir_field;
																																									self.sec_range := left.clean_sec_range_field;
																																									self.p_city_name := left.clean_p_city_name_field;
																																									self.st := left.clean_st_field;
																																									self.z5 := left.clean_zip_field;
																																									self.comp_name := left.SANC_BUSNME;
																																									self.did := (integer)left.did;
																																									self :=[];));
	%get_npi_autokey_batch% := DEDUP(SORT(Healthcare_Provider_Services.AutoKey_for_Batch(%bad_npi_ds%).npi_autokeys,acctno,npi),acctno,npi);
	//If there are more than 1 match skip the record we are only going to correct exact matches.
	%get_npi_filter_batch% := join(%notverified%,%get_npi_autokey_batch%,
																	left.seq=(integer)right.acctno and left.clean_lname_field <> '' and
																	stringlib.StringToUpperCase(left.clean_lname_field) = stringlib.StringToUpperCase(right.clean_name_provider.lname),
																	transform(recordof(%get_npi_autokey_batch%),self:=right;),limit(1,skip));
	%bad_npi% := join(%notverified%, %get_npi_filter_batch%(npi<>''),
																	left.seq=(integer)right.acctno, transform(recordof(infile),SELF.npi_field:=if(right.npi<>'',right.npi,left.npi);SELF.nppesverified_field := if(right.npi<>'','CORRECTED',left.nppesverified_field);self:=left;),left outer);
	
	%final_npi% := PROJECT(DEDUP(SORT(%join_w_npi_dup%(nppesverified_field = 'YES') + if (count(%bad_npi_ds%) < 25, %bad_npi%, %join_w_npi_dup%(nppesverified_field = 'NO')), 
																		seq, npi_field, IF(NPPESVerified_field = 'YES', 1, 2)), 
															seq, npi_field), 
												TRANSFORM(RECORDOF(%out_rec%),
												SELF.id_field := (UNSIGNED6)LEFT.id_field,
												SELF.npi := LEFT.npi_field,
												SELF.nppesverified := LEFT.nppesverified_field,
												SELF := LEFT,
												SELF := []));
	
	outfile := %final_npi%;
	
ENDMACRO;