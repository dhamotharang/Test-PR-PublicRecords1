import doxie, business_header, prof_LicenseV2_Services, AutoStandardI,Healthcare_Header_Services,Address,Codes,ut,STD;

// similar to searchservice_records..

export ProflicSearch := module
	export params := interface(prof_LicenseV2_Services.ProfLicSearch_Ids.params,
		AutoStandardI.InterfaceTranslator.comp_name_value.params,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
		AutoStandardI.InterfaceTranslator.Filingjurisdiction_val.params,
		AutoStandardI.InterfaceTranslator.maxResults_val.params,
		AutoStandardI.InterfaceTranslator.maxResultsthisTime_val.params,
		AutoStandardI.InterfaceTranslator.skiprecords_val.params
		)
		export string20 license_number;
		
  end;

export val(params in_params) := FUNCTION

	 gm := AutoStandardI.GlobalModule();
   tmp_comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.comp_name_value.params)); 
   tmp_penalt_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
   tmp_filingjurisdiction := AutoStandardI.InterfaceTranslator.filingjurisdiction_val.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.filingjurisdiction_val.params));
   tmp_maxResults          := AutoStandardI.InterfaceTranslator.maxResults_val.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.maxResults_val.params));
   tmp_maxResultsThisTime  := AutoStandardI.InterfaceTranslator.maxResultsThisTime_val.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.maxResultsThisTime_val.params));
   tmp_skiprecords         := AutoStandardI.InterfaceTranslator.skipRecords_val.val(project(in_params,
				                                     AutoStandardI.InterfaceTranslator.skipRecords_val.params));																						 			

 	 ids_Prolic := prof_LicenseV2_Services.ProfLicSearch_Ids.val_prolic(in_params);
	 ids_Sanc_blank := dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Sanc);
	 ids_Prov_blank := dataset([],prof_LicenseV2_Services.Layout_Search_Ids_Prov);
	//Submit blanks we don't really want to submit these any more  We should just submit the full in_params criteria
//	 ids_Sanc :=  prof_LicenseV2_Services.ProfLicSearch_Ids.val_sanc(in_params);
	 ids_Prov := prof_LicenseV2_Services.ProfLicSearch_Ids.val_prov(in_params);
							
	Prolic_r   := prof_LicenseV2_Services.Prof_Lic_raw.search_view.
											by_ids(ids_prolic,ids_Sanc_blank,ids_Prov_blank, in_params.license_number);

	f_srt_proflic := Prolic_r(penalt <= tmp_penalt_threshold,
	                 tmp_filingjurisdiction = ''
									 or source_st = tmp_filingjurisdiction);								 

	//Submit full criteria to Header service
	newlayout  := Healthcare_Header_Services.Layouts.autokeyInput;
	cleanAddr := in_params.addr <> '';
	testInput:=stringlib.StringFind(in_params.addr,',',1);
	splitRaw1 := if(testInput>0,in_params.addr[1..testInput-1],in_params.addr);
	splitRaw2 := if(testInput>0,in_params.addr[testInput+1..],'');
	tmpCity := If(in_params.city ='' and in_params.zip ='', 'ANYTOWN',in_params.city);
	line2:=if(in_params.City <>'' or in_params.State <>'' or in_params.Zip <>'',tmpCity+' '+in_params.state+' '+in_params.zip,splitRaw2);
	clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);
	
	// newlayout setinput():=transform
		// self.acctno := '1';
		// self.comp_name := stringlib.StringToUpperCase(in_params.CompanyName);
		// self.name_first := stringlib.StringToUpperCase(in_params.FirstName);
		// self.name_middle := stringlib.StringToUpperCase(in_params.MiddleName);
		// self.name_last := stringlib.StringToUpperCase(in_params.LastName);
		// self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(gm.predir));
		// self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(in_params.prim_range));
		// self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(in_params.prim_name));
		// self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(gm.suffix));
		// self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(gm.postdir));
		// self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(gm.sec_range));
		// self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(in_params.City));
		// self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(in_params.State));
		// self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,in_params.Zip);
		// self.dob := (String)in_params.dob;
		// self.SSN := in_params.SSN;
		// self.license_number:= in_params.License_Number;
		// self.license_state := tmp_state_value(in_params);
		// self.TAXID := in_params.tax_id;
		// self.did := (integer)in_params.did;
		// self.bdid := (integer)in_params.bdid;
		// self.ProviderID := (integer)in_params.ProviderId;	
		// self.ProviderSrc := 'H';
		// self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
		// self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		// self.DRM := gm.DataRestrictionMask;
		// self.IncludeSanctions := in_params.IncludeSanctions;
		// dataRestrictEnclarity := gm.DataRestrictionMask[19] not in ['0',''];//if there is a value other than blank or Zero Restrict
		// self.ExcludeSourceSelectFile := if(dataRestrictEnclarity,dataRestrictEnclarity,false);
		// self:=[];
		// end;
	// ds:=dataset([setinput()]);
	ds_prov := project(ids_Prov,transform(newlayout,
																			self.acctno := '1';
																			self.comp_name := stringlib.StringToUpperCase(in_params.CompanyName);
																			self.name_first := stringlib.StringToUpperCase(in_params.FirstName);
																			self.name_middle := stringlib.StringToUpperCase(in_params.MiddleName);
																			self.name_last := stringlib.StringToUpperCase(in_params.LastName);
																			self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(gm.predir));
																			self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(in_params.prim_range));
																			self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(in_params.prim_name));
																			self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(gm.suffix));
																			self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(gm.postdir));
																			self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(gm.sec_range));
																			self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(in_params.City));
																			self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(in_params.State));
																			self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,in_params.Zip);
																			self.license_number:= in_params.License_Number;
																			self.license_state := stringlib.StringToUpperCase(in_params.State);
																			self.ProviderID := (integer)left.ProviderId;	
																			self.ProviderSrc := '';
																			self := []));
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
		self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		self.DRM := gm.DataRestrictionMask;
		self.IncludeSanctions := true;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	headerRawData := dedup(Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(ds_prov,cfg),all)(in_params.Include_Prov or in_params.Include_Sanc);
  search_layout := RECORD (prof_LicenseV2_Services.Assorted_Layouts.Layout_Search_w_pen)
                     unsigned4 global_sid := 0; //default is defined temporarily
                     unsigned8 record_sid := 0;
                   END;

	normProviderAddr := normalize(headerRawData,choosen(left.Addresses,5),transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,self.Addresses := right;self:=left;self:=[]));
	normProviders := normalize(normProviderAddr,left.StateLicenses,transform(Healthcare_Header_Services.Layouts.CombinedHeaderResults,self.StateLicenses := right;self:=left;self:=[]));
	headerFmtProvData := project(normProviders, transform(Search_layout,
																self.providerid := left.LNPID;
																self.uniqueid := ('PR' + trim((string20)left.LNPID) );
																self.sanc_id := left.LegacySanctions[1].SANC_ID;
																self.npi := (integer)left.npis[1].npi;
																self.orig_license_number := left.StateLicenses[1].LicenseNumber;
																self.Status := left.StateLicenses[1].LicenseStatus;
																self.orig_name :=left.names[1].FirstName	+ left.names[1].MiddleName + left.names[1].LastName + left.names[1].Suffix; 
																self.orig_addr_1 :=left.Addresses[1].prim_range	+ left.Addresses[1].predir	+ left.Addresses[1].prim_name +left.Addresses[1].addr_suffix
																	+left.Addresses[1].postdir;
																self.orig_addr_2 := left.Addresses[1].unit_desig + left.Addresses[1].sec_range;
																self.orig_city := left.Addresses[1].p_city_name;
																self.orig_st := left.Addresses[1].st;
																self.orig_zip := left.Addresses[1].z5 + left.Addresses[1].zip4;
																self.did := (String)left.dids[1].did;
																self.phone := left.Phones[1].phone;
																self.phonetype := left.Phones[1].phonetype;
																self.sex := left.names[1].Gender;
																self.taxid := left.taxids[1].taxid;
																self.dob := left.dobs[1].dob;
																self.best_ssn := '';
																self.issue_date := left.StateLicenses[1].Effective_Date;
																self.expiration_date := left.StateLicenses[1].Termination_Date;
																self.action_status := '';
																self.date_last_seen := left.Addresses[1].last_seen;
																self.last_renewal_date :='';
																self.profession_or_board :='';
																self.license_type := left.StateLicenses[1].LicenseType;
																self.license_obtained_by :='';
																self.source_st := left.StateLicenses[1].LicenseState;
																self.penalt := left.record_penalty_name;
																self.fname := left.names[1].FirstName;
																self.mname :=left.names[1].MiddleName;
																self.lname := left.names[1].LastName;
																self.name_suffix := left.names[1].Suffix;
																self.title := left.names[1].Title;
																self.prim_range := left.Addresses[1].prim_range;
																self.predir := left.Addresses[1].predir;
																self.prim_name := left.Addresses[1].prim_name;
																self.suffix := left.Addresses[1].addr_suffix;
																self.postdir := left.Addresses[1].postdir;
																self.unit_desig := left.Addresses[1].unit_desig;
																self.sec_range :=left.Addresses[1].sec_range;
																self.p_city_name := left.Addresses[1].p_city_name;
																self.v_city_name := left.Addresses[1].v_city_name;
																self.st := left.Addresses[1].st;
																self.zip := left.Addresses[1].z5;
																self.zip4 := left.Addresses[1].zip4;
																self.ace_fips_st := left.Addresses[1].fips_state;
																self.county := left.Addresses[1].fips_county;
																self.geo_lat := left.Addresses[1].geo_lat;
																self.geo_long := left.Addresses[1].geo_long;
																self.Source_st_decoded := codes.GENERAL.state_long(left.StateLicenses[1].LicenseState);
                                self := LEFT;
																self :=[];)) (in_params.Include_Prov);
	
	headerFmtSancRaw := project(headerRawData, transform(Search_layout,
																sancID := left.LegacySanctions[1].SANC_ID;
																sancmatchesID := Std.Str.Find(trim((string)sancID,right),trim((string)left.LNPID,right),1)>0;
																self.providerid := left.LNPID;
																self.uniqueid := ('PS' + trim((string20)left.LNPID) );
																self.sanc_id := if((integer)sancID<10000000 or sancmatchesID,sancID,skip);
																self.npi := (integer)left.npis[1].npi;
																self.orig_license_number := left.StateLicenses[1].LicenseNumber;
																self.Status := left.StateLicenses[1].LicenseStatus;
																self.orig_name :=left.names[1].FirstName	+ left.names[1].MiddleName + left.names[1].LastName + left.names[1].Suffix; 
																self.orig_addr_1 :=left.Addresses[1].prim_range	+ left.Addresses[1].predir	+ left.Addresses[1].prim_name +left.Addresses[1].addr_suffix
																	+left.Addresses[1].postdir;
																self.orig_addr_2 := left.Addresses[1].unit_desig + left.Addresses[1].sec_range;
																self.orig_city := left.Addresses[1].p_city_name;
																self.orig_st := left.Addresses[1].st;
																self.orig_zip := left.Addresses[1].z5 + left.Addresses[1].zip4;
																self.did := (string)left.dids[1].did;
																self.phone := left.Phones[1].phone;
																self.phonetype := left.Phones[1].phonetype;
																self.sex := left.names[1].Gender;
																self.taxid := left.taxids[1].taxid;
																self.dob := left.dobs[1].dob;
																self.best_ssn := '';
																self.issue_date := left.StateLicenses[1].Effective_Date;
																self.expiration_date := left.StateLicenses[1].Termination_Date;
																self.action_status := left.LegacySanctions[1].SANC_REAS;
																self.date_last_seen := left.Addresses[1].last_seen;
																self.last_renewal_date :='';
																self.profession_or_board :='';
																self.license_type := left.StateLicenses[1].LicenseType;
																self.license_obtained_by :='';
																self.source_st := left.StateLicenses[1].LicenseState;
																self.penalt := left.record_penalty_name;
																self.fname := left.names[1].FirstName;
																self.mname :=left.names[1].MiddleName;
																self.lname := left.names[1].LastName;
																self.name_suffix := left.names[1].Suffix;
																self.title := left.names[1].Title;
																self.prim_range := left.Addresses[1].prim_range;
																self.predir := left.Addresses[1].predir;
																self.prim_name := left.Addresses[1].prim_name;
																self.suffix := left.Addresses[1].addr_suffix;
																self.postdir := left.Addresses[1].postdir;
																self.unit_desig := left.Addresses[1].unit_desig;
																self.sec_range :=left.Addresses[1].sec_range;
																self.p_city_name := left.Addresses[1].p_city_name;
																self.v_city_name := left.Addresses[1].v_city_name;
																self.st := left.Addresses[1].st;
																self.zip := left.Addresses[1].z5;
																self.zip4 := left.Addresses[1].zip4;
																self.ace_fips_st := left.Addresses[1].fips_state;
																self.county := left.Addresses[1].fips_county;
																self.geo_lat := left.Addresses[1].geo_lat;
																self.geo_long := left.Addresses[1].geo_long;
																self.Source_st_decoded := codes.GENERAL.state_long(left.StateLicenses[1].LicenseState);
                                self := LEFT;
																self :=[];)) (in_params.Include_Sanc);

	normSanctions := sort(dedup(normalize(headerRawData,left.LegacySanctions,transform(Healthcare_Header_Services.Layouts.layout_LegacySanctions,self.ProviderID := left.LNPID;self:=right;self:=[])),all),if(GroupSortOrder<>0,GroupSortOrder,99));

	headerFmtSancData := Join(normSanctions,headerFmtSancRaw, left.providerid=right.providerid, transform(Search_layout,
																self.prolic_seq_id := left.groupsortorder;
																self.sanc_id := left.SANC_ID;
																self.action_status := left.SANC_REAS;
																self:=right;),keep(50), limit(0));

	f_srt := f_srt_proflic + headerFmtProvData + headerFmtSancData;

	rsrt := if(tmp_comp_name_value = '', sort(f_srt,if(isDeepDive,1,0), penalt,
			lname,fname,mname,company_name, providerid,prolic_seq_id,sanc_id, status, orig_license_number, -date_last_seen,record),
			sort(f_srt,if(isDeepDive,1,0), penalt,
			company_name,lname,fname,mname, providerid,prolic_seq_id,sanc_id, status, orig_license_number, -date_last_seen,record));

	// output(ids_prolic, named('ids_prolic'));
	// output(ds_prov, named('ds_prov'));
	// output(headerRawData, named('headerRawData'));
	// output(normProviderAddr, named('normProviderAddr'));
	// output(normProviders, named('normProviders'));
	// output(headerFmtProvData, named('headerFmtProvData'));
	// output(normSanctions, named('normSanctions'));
	// output(headerFmtSancData, named('headerFmtSancData'));
	// output(ids_sanc, named('ids_Sanc'));
	// output(ids_prov, named('ids_prov'));
	// output(in_params.ssn, named('in_params_ssn'));
	// output(in_params.Include_Prof_Lic, named('Include_Prof_Lic'));

	//OUTPUT (headerRawData, NAMED('headerRawData'));



	RETURN rsrt;

END; // function

end;
