IMPORT iesp, CNLD_Facilities, BIPV2;

EXPORT CNLDFacilitySource_Records ( 
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
  boolean IsFCRA = false,
	unsigned max_penalty = 10) 
	:= MODULE
	
	SHARED cnld_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		CNLD_Facilities.layout_Facilities_AID_schd;
	END;
	
	SHARED cnld_key_layout := RECORD
			STRING10	Gennum;
			STRING2		st_lic_in;          
			STRING15	st_lic_num; 
	END;
	
	// For in_docids records that don't have SourceDocIds (gennum's) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get all gennum's for the input linkids
  shared ds_cnldkeys := PROJECT(CNLD_Facilities.key_LinkIDs.keyfetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := TRIM(LEFT.st_lic_in) + '|' + TRIM(LEFT.st_lic_num) + '|' + TRIM(LEFT.gennum), // Add trailing delimiter,
																					SELF := LEFT,
																					SELF := []));

	shared cnld_keys_comb := in_docids+ds_cnldkeys;
		
	shared cnld_keys := PROJECT(cnld_keys_comb(IdValue != ''),
								TRANSFORM(cnld_key_layout,
										// idValue is assumed in lic_state|lic_num|gennum format.
										delim1 := StringLib.StringFind(LEFT.IdValue,'|',1);
										delim2 := StringLib.StringFind(LEFT.IdValue,'|',2);
										SELF.st_lic_in := TRIM(LEFT.IdValue[..delim1-1]),
										SELF.st_lic_num := TRIM(LEFT.IdValue[delim1+1..delim2-1]),
										SELF.gennum := TRIM(LEFT.IdValue[delim2+1..]),
										SELF := []));
	
	shared cnld_keys_dedup := DEDUP(cnld_keys,ALL);
	
  // fetch main records via cnld gennum key
	shared cnld_sourceview := JOIN(cnld_keys_dedup,CNLD_Facilities.key_gennum,
																KEYED(LEFT.Gennum = RIGHT.Gennum), 
																TRANSFORM(CNLD_Facilities.layout_Facilities_AID_schd,
																SELF := RIGHT), LIMIT(TopBusiness_Services.Constants.defaultJoinLimit,SKIP));


	SHARED cnld_sourceview_wLinkIds := JOIN(cnld_sourceview,cnld_keys_comb,
																			TRIM(LEFT.st_lic_in) + '|' + TRIM(LEFT.st_lic_num) + '|' + TRIM(LEFT.Gennum) = RIGHT.IdValue,
																			TRANSFORM(cnld_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																			KEEP(1),
																			LEFT OUTER); 
	
 SHARED iesp.proflicense.t_ProfessionalLicenseRecord toOut(cnld_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
		self.LicenseType           := L.st_lic_type;
    self.LicenseNumber         := L.st_lic_num;
		self.SourceState					 := L.st_lic_in;
    self.DateLastSeen          := iesp.ECL2ESP.toDate ((integer4) L.last_seen_date);
    self.ProfessionOrBoard     := L.std_prof_desc;
    self.Status                := CASE(L.st_lic_stat,
																						'I' => 'Inactive',
																						'A' => 'Active',
																						'');
		self.Name                  := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title);
    self.CompanyName           := L.org_name;
		self.Taxid								 := L.CLN_SSN_TAXID;
    self.Address               := iesp.ECL2ESP.SetAddress (L.prim_name, L.prim_range, L.predir, 
																		L.postdir, L.addr_suffix, L.unit_desig, L.sec_range,
																		L.v_city_name, L.st, l.zip5, l.zip4, l.county);
    self.OriginalAddress       := iesp.ECL2ESP.SetAddress ('','','','','','','',L.addr_city,
																	L.addr_st,L.addr_zip,'','','',L.addr_addr1,L.addr_addr2);
		self.Phone                 := L.addr_phone;
		self.ExpirationDate        := iesp.ECL2ESP.toDate ((integer4) L.st_lic_num_exp);
		self.Fax                   := L.addr_fax;
		self := [];
  end;

	SourceView_RecsIesp := PROJECT(cnld_sourceview_wLinkIds, toOut(left));
	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
	EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
