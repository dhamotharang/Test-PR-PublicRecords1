// ================================================================================
// ======   RETURNS ATF DATA FOR A GIVEN LICENSE_NUMBER IN ESP-COMPLIANT WAY  =====
// ================================================================================
IMPORT ATF, ATF_Services, BIPV2, iesp, codes, suppress;

EXPORT ATFSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 
	SHARED atf_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		ATF_Services.Layouts.rawrec;
	END;

	// For in_docids records that don't have IdValues (license_number) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get prolic data
  ds_atfkeys := PROJECT(ATF.Key_LinkIds.kFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.license_number,
																					SELF := LEFT,
																					SELF := []));

	atf_keys_comb := in_docids+ds_atfkeys;

	atf_keys := PROJECT(atf_keys_comb(IdValue != ''),TRANSFORM(ATF_Services.layouts.atfNumberPlus,SELF.license_number := LEFT.IdValue,SELF := []));
	
	atf_keys_dedup := DEDUP(atf_keys,ALL);
	
  // Get raw data
  atf_sourceview := ATF_Services.Raw.search_view.bylicensenbr(atf_keys_dedup);

	SHARED atf_sourceview_wLinkIds := JOIN(atf_sourceview,atf_keys_comb,
																					LEFT.license_number = RIGHT.IdValue,
																					TRANSFORM(atf_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids
	
  iesp.share.t_Name xform_name(atf_layout_wLinkIds L, integer C) := transform
		self.Full   := '';
		self.First  := choose(C,L.license1_fname,L.license2_fname); 
		self.Middle := choose(C,L.license1_mname,L.license2_mname); 
		self.Last   := choose(C,L.license1_lname,L.license2_lname); 
		self.Suffix := choose(C,L.license1_name_suffix,L.license2_name_suffix); 
		self.Prefix := choose(C,L.license1_title,L.license2_title); 
	end;

  iesp.firearm.t_FirearmRecord toOut (atf_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
	  self._Penalty          := 0;
	  self.AlsoFound         := false;
	  self.LicenseIssueState := L.Lic_Dist; 
	  self.LicenseNumber     := L.license_number;
		
		// Lookup License type
		temp_lictype1        := if(L.record_type = 'F','Federal Firearms','Federal Explosives');
    // Convert some raw fields like done in TopBusiness_Services.ATFSource_Records and 
		// ATF_Services.Functions.
    // First if lic_type is missing the leading zero (all atf lic_type "code"s in codesv3 
		// are 2 digits), add it so the key lookup works.
		string15 temp_lic_type := if(L.lic_type[1] != '' and L.lic_type[2] = '','0' + L.lic_type,L.lic_type);
		v3codes_Lic_Type := codes.key_codes_v3(keyed(file_name='ATF_FIREARMS_EXPLOSIVES'),
		                                              keyed(field_name='LIC_TYPE'), 
					    															      keyed(field_name2=''),
																								  keyed(code=temp_lic_type));
	  temp_lictype2 := trim(SET (LIMIT (v3codes_Lic_Type, 1, KEYED), long_desc)[1]);
		self.LicenseType := trim(temp_lictype1) + if(L.lic_type != '','-' + temp_lictype2,'');
		// v3codes_Lic_Type := codes.key_codes_v3(keyed(file_name='ATF_FIREARMS_EXPLOSIVES'),keyed(field_name='LIC_TYPE'), 
																						// keyed(field_name2=''),keyed(code=L.Lic_Type));
	  // self.LicenseType       :=  trim(SET (LIMIT (v3codes_Lic_Type, 1, KEYED), long_desc)[1]);
		// Calculate Lic expire date
		string8 temp_expire_date := ATF_Services.Functions.code_to_year(L.lic_xprdte, L.date_first_seen)+ 
																ATF_Services.Functions.code_to_month(L.lic_xprdte) + '00';
		self.LicenseExpireDate :=  iesp.ECL2ESP.toDatestring8(temp_expire_date);
		
		lic1info_isaperson      := if(L.license1_lname !='',true,false);
	  self.LicenseName.Full   := ''; 
		self.LicenseName.First  := if(lic1info_isaperson,L.license1_fname,L.license2_fname); 
		self.LicenseName.Middle := if(lic1info_isaperson,L.license1_mname,L.license2_mname);
		self.LicenseName.Last   := if(lic1info_isaperson,L.license1_lname,L.license2_lname);
		self.LicenseName.Suffix := if(lic1info_isaperson,L.license1_name_suffix,L.license2_name_suffix);
		self.LicenseName.Prefix := if(lic1info_isaperson,L.license1_title,L.license2_title);
	  self.RawLicenseName    := L.License_Name;
	  self.LicenseCompany    := L.license1_cname;
	  self.TradeName         := L.Business_name;
	  self.SSN               := L.best_ssn;
		self.MailingAddress :=  iesp.ECL2ESP.SetAddress (L.mail_prim_name, L.mail_prim_range, L.mail_predir, L.mail_postdir, L.mail_suffix,
			                              L.mail_unit_desig,L.mail_sec_range,L.mail_v_city_name,L.mail_st,L.mail_zip,L.mail_zip4,L.mail_fips_county,'',
																		L.mail_street,L.mail_city + ',' + L.mail_state + ' ' + L.mail_zip_code);
	 	self.PremiseAddress := iesp.ECL2ESP.SetAddress (L.premise_prim_name, L.premise_prim_range, L.premise_predir, L.premise_postdir, 
																		L.premise_suffix,L.premise_unit_desig,L.premise_sec_range,L.premise_v_city_name,L.premise_st,
																		L.premise_zip,L.premise_zip4,L.premise_fips_County_name,'',
																		L.premise_street,L.premise_city + ',' + L.premise_state + ' ' + L.premise_orig_zip);
	  self.BusinessPhone := L.Voice_Phone;
		
		// Lookup IRSregion code
		v3codes_IRS_Reg := codes.key_codes_v3(keyed(file_name='ATF_FIREARMS_EXPLOSIVES'),keyed(field_name='IRS_REGION'), 
																					keyed(field_name2=''),keyed(code=L.irs_region));
	  self.IRSRegion     := trim(SET (LIMIT (v3codes_IRS_Reg, 1, KEYED), long_desc)[1]);
	  self.LicenseRegion := L.Lic_Regn;
	  self.CountyName    := L.premise_fips_County_name;
	  self.UniqueId      := L.did_out;
		// Create a dataset from the 2 sets of L.license* name fields.
		temp_Names := NORMALIZE(dataset(L),2,xform_name(left, counter));
		dedup_Names := DEDUP(SORT(temp_Names,Last,First,Middle,Suffix),Last,First,Middle,Suffix);	
		self.LicenseNames  := dedup_Names;
		self := [];
  end;
 
	iesp_SourceView_Recs := project(atf_sourceview_wLinkIds, toOut(left));
	
  Suppress.MAC_Mask(iesp_SourceView_Recs, iesp_SourceView_Recs_mask, ssn, null, true, false, maskVal := inoptions.ssn_mask)

	EXPORT SourceView_Recs := iesp_SourceView_Recs_mask;
  EXPORT SourceView_RecCount := COUNT(atf_sourceview_wLinkIds);

END;
