export MAC_Header_Field_Declare(IsFCRA = false) := MACRO
	import AutoStandardI;
	#uniquename(inputmod);
	
	%inputmod% := AutoStandardI.GlobalModule(isFCRA);
	// parsed address inputs for moxie_server services
	isCRS := AutoStandardI.InterfaceTranslator.isCRS.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.isCRS.params));
	party_type := AutoStandardI.InterfaceTranslator.party_type.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.party_type.params));
  // in compound queries this is a party type specifically for bankruptcy
	party_type_bk := AutoStandardI.InterfaceTranslator.party_type_bk.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.party_type_bk.params));
	noDeepDive := AutoStandardI.InterfaceTranslator.noDeepDive.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.noDeepDive.params));
	BankruptcyVersion := AutoStandardI.InterfaceTranslator.BankruptcyVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.BankruptcyVersion.params));
	UccVersion := AutoStandardI.InterfaceTranslator.UccVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.UccVersion.params));
	JudgmentLienVersion := AutoStandardI.InterfaceTranslator.JudgmentLienVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.JudgmentLienVersion.params));
	VehicleVersion := AutoStandardI.InterfaceTranslator.VehicleVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.VehicleVersion.params));
	VoterVersion := AutoStandardI.InterfaceTranslator.VoterVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.VoterVersion.params));
	DlVersion := AutoStandardI.InterfaceTranslator.DlVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.DlVersion.params));
	DeaVersion := AutoStandardI.InterfaceTranslator.DeaVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.DeaVersion.params));
	PropertyVersion := AutoStandardI.InterfaceTranslator.PropertyVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.PropertyVersion.params));
	CriminalRecordVersion := AutoStandardI.InterfaceTranslator.CriminalRecordVersion.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.CriminalRecordVersion.params));
	unparsed_fullname_value := AutoStandardI.InterfaceTranslator.unparsed_fullname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.unparsed_fullname_value.params));
	cleaned_name := AutoStandardI.InterfaceTranslator.cleaned_name.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.cleaned_name.params));
	did_value := AutoStandardI.InterfaceTranslator.did_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.did_value.params));
	rid_value := AutoStandardI.InterfaceTranslator.rid_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rid_value.params));
	fname_val := AutoStandardI.InterfaceTranslator.fname_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_val.params));
	rel_fname_val1 := AutoStandardI.InterfaceTranslator.rel_fname_val1.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rel_fname_val1.params));
	rel_fname_val2 := AutoStandardI.InterfaceTranslator.rel_fname_val2.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rel_fname_val2.params));
	lname_val := AutoStandardI.InterfaceTranslator.lname_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_val.params));
	olname1_val := AutoStandardI.InterfaceTranslator.olname1_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.olname1_val.params));
	lname4_val := AutoStandardI.InterfaceTranslator.lname4_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname4_val.params));
	fname3_val := AutoStandardI.InterfaceTranslator.fname3_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname3_val.params));
	mname_val := AutoStandardI.InterfaceTranslator.mname_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.mname_val.params));
	company_name := AutoStandardI.InterfaceTranslator.company_name.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.company_name.params));
	state_val := AutoStandardI.InterfaceTranslator.state_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.state_val.params));
	prev_state_val1l := AutoStandardI.InterfaceTranslator.prev_state_val1l.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prev_state_val1l.params));
	prev_state_val2l := AutoStandardI.InterfaceTranslator.prev_state_val2l.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prev_state_val2l.params));
	city_val := AutoStandardI.InterfaceTranslator.city_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.city_val.params));
	other_city_val := AutoStandardI.InterfaceTranslator.other_city_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.other_city_val.params));
	zip_val0 := AutoStandardI.InterfaceTranslator.zip_val0.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zip_val0.params));
	zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zipradius_value.params));
	statecityzip_val := AutoStandardI.InterfaceTranslator.statecityzip_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.statecityzip_val.params));
	currentresidentsonly := AutoStandardI.InterfaceTranslator.currentresidentsonly.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.currentresidentsonly.params));
	phone_val := AutoStandardI.InterfaceTranslator.phone_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.phone_val.params));
	fuzzy_ssn := AutoStandardI.InterfaceTranslator.fuzzy_ssn.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fuzzy_ssn.params));
	whole_house := AutoStandardI.InterfaceTranslator.whole_house.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.whole_house.params));
	all_dids := AutoStandardI.InterfaceTranslator.all_dids.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.all_dids.params));
	did_only := AutoStandardI.InterfaceTranslator.did_only.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.did_only.params));
	phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.phonetics.params));
	nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.nicknames.params));
	raw_records := AutoStandardI.InterfaceTranslator.raw_records.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.raw_records.params));
	agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.agelow_val.params));
	agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.agehigh_val.params));
	dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dob_val.params));
	dod_value := AutoStandardI.InterfaceTranslator.dod_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dod_value.params));
	maxresults_val := AutoStandardI.InterfaceTranslator.maxresults_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.maxresults_val.params));
	maxresultsthistime_val := AutoStandardI.InterfaceTranslator.maxresultsthistime_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.maxresultsthistime_val.params));
	skiprecords_val := AutoStandardI.InterfaceTranslator.skiprecords_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.skiprecords_val.params));
	do_not_fill_blanks := AutoStandardI.InterfaceTranslator.do_not_fill_blanks.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.do_not_fill_blanks.params)); 
	adl_service_ip := AutoStandardI.InterfaceTranslator.adl_service_ip.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.adl_service_ip.params)); 
	is_a_neighbor := AutoStandardI.InterfaceTranslator.is_a_neighbor.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.is_a_neighbor.params)); 
	neighbor_service := AutoStandardI.InterfaceTranslator.neighbor_service.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.neighbor_service.params)); 
	report_records := AutoStandardI.InterfaceTranslator.report_records.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.report_records.params)); 
	Exclude_Lessors := AutoStandardI.InterfaceTranslator.Exclude_Lessors.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.Exclude_Lessors.params)); 
	score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.score_threshold_value.params)); 
	ssn_mask_val := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
	dl_mask_val := AutoStandardI.InterfaceTranslator.dl_mask_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dl_mask_val.params)); 
	dob_mask_val := AutoStandardI.InterfaceTranslator.dob_mask_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dob_mask_val.params)); 
	industry_class_val := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.industry_class_val.params)); 
	probation_override_value := AutoStandardI.InterfaceTranslator.probation_override_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.probation_override_value.params)); 
	ln_branded_value := AutoStandardI.InterfaceTranslator.ln_branded_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ln_branded_value.params)); 
	non_exclusion_value := AutoStandardI.InterfaceTranslator.non_exclusion_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.non_exclusion_value.params)); 
	race_value := AutoStandardI.InterfaceTranslator.race_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.race_value.params)); 
	gender_value := AutoStandardI.InterfaceTranslator.gender_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.gender_value.params)); 
	is_ProfileSearch := AutoStandardI.InterfaceTranslator.is_ProfileSearch.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.is_ProfileSearch.params)); 
	dial_recordmatch_value := AutoStandardI.InterfaceTranslator.dial_recordmatch_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dial_recordmatch_value.params)); 
	dial_contactprecision_value := AutoStandardI.InterfaceTranslator.dial_contactprecision_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dial_contactprecision_value.params)); 
	dial_bouncedistance_value := AutoStandardI.InterfaceTranslator.dial_bouncedistance_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dial_bouncedistance_value.params)); 
	includeZeroDids_value := AutoStandardI.InterfaceTranslator.includeZeroDids_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.includeZeroDids_value.params)); 
	tmsid_value := AutoStandardI.InterfaceTranslator.tmsid_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.tmsid_value.params)); 
	rmsid_value := AutoStandardI.InterfaceTranslator.rmsid_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rmsid_value.params)); 
	LienCaseNumber_value := AutoStandardI.InterfaceTranslator.LienCaseNumber_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.LienCaseNumber_value.params)); 		
	IRSSerialNumber_value := AutoStandardI.InterfaceTranslator.IRSSerialNumber_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.IRSSerialNumber_value.params));		
//can be moved to Business_Header.doxie_MAC_Field_Declare
	CaseNumber_value := AutoStandardI.InterfaceTranslator.CaseNumber_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.CaseNumber_value.params));
	FilingDateBegin_value := AutoStandardI.InterfaceTranslator.FilingDateBegin_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.FilingDateBegin_value.params));		
	FilingDateEnd_value := AutoStandardI.InterfaceTranslator.FilingDateEnd_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.FilingDateEnd_value.params));			
	duns_value := AutoStandardI.InterfaceTranslator.duns_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.duns_value.params));								
	StateDeathID_value := AutoStandardI.InterfaceTranslator.StateDeathID_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.StateDeathID_value.params)); 			
	FilingNumber_value := AutoStandardI.InterfaceTranslator.FilingNumber_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.FilingNumber_value.params));				
	FilingJurisdiction_value := AutoStandardI.InterfaceTranslator.FilingJurisdiction_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.FilingJurisdiction_value.params));	
	addr_value := AutoStandardI.InterfaceTranslator.addr_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_value.params)); 
	zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zip_val.params)); 
	isAdvanced := AutoStandardI.InterfaceTranslator.isAdvanced.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.isAdvanced.params)); 
	ssn_filtered_value := AutoStandardI.InterfaceTranslator.ssn_filtered_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ssn_filtered_value.params)); 
	ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ssn_value.params)); 
	phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.phone_value.params)); 
	dateVal := AutoStandardI.InterfaceTranslator.dateVal.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dateVal.params)); 
	ssn_set := AutoStandardI.InterfaceTranslator.ssn_set.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ssn_set.params)); 
	ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.ssn_mask_value.params)); 
	dl_mask_value := AutoStandardI.InterfaceTranslator.dl_mask_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dl_mask_value.params)); 
	dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dob_mask_value.params)); 
	industry_class_value := AutoStandardI.InterfaceTranslator.industry_class_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.industry_class_value.params)); 
	no_scrub := AutoStandardI.InterfaceTranslator.no_scrub.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.no_scrub.params)); 
	GLB_Purpose := AutoStandardI.InterfaceTranslator.GLB_Purpose.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.GLB_Purpose.params));		
	DPPA_Purpose := AutoStandardI.InterfaceTranslator.DPPA_Purpose.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.DPPA_Purpose.params));	
	glb_ok := AutoStandardI.InterfaceTranslator.glb_ok.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.glb_ok.params));  
	dppa_ok := AutoStandardI.InterfaceTranslator.dppa_ok.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dppa_ok.params)); 
	loose_name := AutoStandardI.InterfaceTranslator.loose_name.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.loose_name.params)); 
	find_year_low := AutoStandardI.InterfaceTranslator.find_year_low.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.find_year_low.params)); 
	find_year_high := AutoStandardI.InterfaceTranslator.find_year_high.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.find_year_high.params)); 
	find_month := AutoStandardI.InterfaceTranslator.find_month.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.find_month.params)); 
	find_day := AutoStandardI.InterfaceTranslator.find_day.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.find_day.params)); 
	dl_value := AutoStandardI.InterfaceTranslator.dl_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.dl_value.params)); 
	vin_value := AutoStandardI.InterfaceTranslator.vin_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.vin_value.params)); 
	tag_value := AutoStandardI.InterfaceTranslator.tag_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.tag_value.params)); 
	fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_value.params)); 
	fname_set_value := AutoStandardI.InterfaceTranslator.fname_set_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_set_value.params)); 
	fname3_value := AutoStandardI.InterfaceTranslator.fname3_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname3_value.params)); 
	lname4_value := AutoStandardI.InterfaceTranslator.lname4_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname4_value.params)); 
	rel_fname_value1 := AutoStandardI.InterfaceTranslator.rel_fname_value1.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rel_fname_value1.params)); 
	rel_fname_value2 := AutoStandardI.InterfaceTranslator.rel_fname_value2.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.rel_fname_value2.params)); 
	lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_value.params)); 
	cleaned_input_lname := AutoStandardI.InterfaceTranslator.cleaned_input_lname.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.cleaned_input_lname.params)); 
	lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_set_value.params)); 
	lname_set_value_20 := AutoStandardI.InterfaceTranslator.lname_set_value_20.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_set_value_20.params)); 
	UsePhoneticDistance := AutoStandardI.InterfaceTranslator.UsePhoneticDistance.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.UsePhoneticDistance.params)); 
	LNamePhoneticSet := AutoStandardI.InterfaceTranslator.LNamePhoneticSet.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.LNamePhoneticSet.params)); 
	other_lname_value1 := AutoStandardI.InterfaceTranslator.other_lname_value1.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.other_lname_value1.params)); 
	mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.mname_value.params)); 
	prev_state_val1 := AutoStandardI.InterfaceTranslator.prev_state_val1.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prev_state_val1.params)); 
	prev_state_val2 := AutoStandardI.InterfaceTranslator.prev_state_val2.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prev_state_val2.params)); 
	county_value := AutoStandardI.InterfaceTranslator.county_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.county_value.params)); 
	other_city_value := AutoStandardI.InterfaceTranslator.other_city_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.other_city_value.params)); 
	comp_name_value := AutoStandardI.InterfaceTranslator.comp_name_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.comp_name_value.params)); 
	comp_name_indic_value := AutoStandardI.InterfaceTranslator.comp_name_indic_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.comp_name_indic_value.params)); 
	comp_name_sec_value := AutoStandardI.InterfaceTranslator.comp_name_sec_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.comp_name_sec_value.params)); 
	date_first_seen_value := AutoStandardI.InterfaceTranslator.date_first_seen_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.date_first_seen_value.params)); 
	date_last_seen_value := AutoStandardI.InterfaceTranslator.date_last_seen_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.date_last_seen_value.params)); 
	allow_date_seen_value := AutoStandardI.InterfaceTranslator.allow_date_seen_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.allow_date_seen_value.params)); 
	lname_wild := AutoStandardI.InterfaceTranslator.lname_wild.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_wild.params)); 
	lname_wild_val := AutoStandardI.InterfaceTranslator.lname_wild_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_wild_val.params)); 
	fname_wild := AutoStandardI.InterfaceTranslator.fname_wild.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_wild.params)); 
	fname_wild_val := AutoStandardI.InterfaceTranslator.fname_wild_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_wild_val.params)); 
	addr_wild := AutoStandardI.InterfaceTranslator.addr_wild.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_wild.params)); 
	addr_range := AutoStandardI.InterfaceTranslator.addr_range.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_range.params)); 
	addr_loose := AutoStandardI.InterfaceTranslator.addr_loose.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_loose.params)); 
	prim_range_set_value := AutoStandardI.InterfaceTranslator.prim_range_set_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prim_range_set_value.params)); 
	prange_wild_value := AutoStandardI.InterfaceTranslator.prange_wild_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prange_wild_value.params)); 
	prange_beg_value := AutoStandardI.InterfaceTranslator.prange_beg_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prange_beg_value.params)); 
	prange_end_value := AutoStandardI.InterfaceTranslator.prange_end_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prange_end_value.params)); 
	addr_line_first := AutoStandardI.InterfaceTranslator.addr_line_first.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_line_first.params)); 
	addr_line_second := AutoStandardI.InterfaceTranslator.addr_line_second.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_line_second.params)); 
	clean_address := AutoStandardI.InterfaceTranslator.clean_address.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.clean_address.params)); 
	state_value := AutoStandardI.InterfaceTranslator.state_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.state_value.params)); 
	input_city_value := AutoStandardI.InterfaceTranslator.input_city_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.input_city_value.params)); 
	city_value := AutoStandardI.InterfaceTranslator.city_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.city_value.params)); 
	city_zip_value := AutoStandardI.InterfaceTranslator.city_zip_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.city_zip_value.params)); 
	zip_value_cleaned := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zip_value_cleaned.params)); 
	zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zip_value.params)); 
	zip_value_ds := AutoStandardI.InterfaceTranslator.zip_value_ds.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.zip_value_ds.params)); 
	city_codes_set := AutoStandardI.InterfaceTranslator.city_codes_set.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.city_codes_set.params)); 
	predir_value := AutoStandardI.InterfaceTranslator.predir_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.predir_value.params)); 
	prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.prange_value.params)); 
	location_value := AutoStandardI.InterfaceTranslator.location_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.location_value.params));
	pname_val := AutoStandardI.InterfaceTranslator.pname_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.pname_val.params)); 
	pname_wild := AutoStandardI.InterfaceTranslator.pname_wild.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.pname_wild.params)); 
	pname_wild_val := AutoStandardI.InterfaceTranslator.pname_wild_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.pname_wild_val.params)); 
	is_wildcard_search := AutoStandardI.InterfaceTranslator.is_wildcard_search.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.is_wildcard_search.params)); 
	pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.pname_value.params)); 
//only in LN_PropertyV2_Services.input  
	lookup_val := AutoStandardI.InterfaceTranslator.lookup_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lookup_val.params)); 
	lookup_value := AutoStandardI.InterfaceTranslator.lookup_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lookup_value.params)); 
	lookup_value2 := AutoStandardI.InterfaceTranslator.lookup_value2.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lookup_value2.params)); 
	addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_suffix_value.params)); 
	postdir_value := AutoStandardI.InterfaceTranslator.postdir_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.postdir_value.params)); 
	sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.sec_range_value.params)); 
	err_stat := AutoStandardI.InterfaceTranslator.err_stat.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.err_stat.params)); 
	addr_error_value := AutoStandardI.InterfaceTranslator.addr_error_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_error_value.params)); 
	any_addr_error_value := AutoStandardI.InterfaceTranslator.any_addr_error_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.any_addr_error_value.params)); 
//only in Doxie.HeaderFileRollupService, Doxie.HeaderFileSearchService:
	allow_wildcard_val := AutoStandardI.InterfaceTranslator.allow_wildcard_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.allow_wildcard_val.params)); 
//move to Business_Header.doxie_MAC_Field_Declare (and make a change in CaseConnect_Services.FetchBizNameWords)
	company_name_val_filt := AutoStandardI.InterfaceTranslator.company_name_val_filt.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.company_name_val_filt.params)); 
	company_name_val_filt2 := AutoStandardI.InterfaceTranslator.company_name_val_filt2.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.company_name_val_filt2.params)); 
	reduced_data_value := AutoStandardI.InterfaceTranslator.reduced_data_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.reduced_data_value.params)); 
//does it make sense to have both fein val and value?
	fein_val := AutoStandardI.InterfaceTranslator.fein_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fein_val.params));
	fein_value := AutoStandardI.InterfaceTranslator.fein_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fein_value.params));
	can_poscode_value := AutoStandardI.InterfaceTranslator.can_poscode_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.can_poscode_value.params));
	addr_origin_country_value := AutoStandardI.InterfaceTranslator.addr_origin_country.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.addr_origin_country.params));
	AllowLeadingLname_value := AutoStandardI.InterfaceTranslator.AllowLeadingLname_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.AllowLeadingLname_value.params));
	BpsLeadingNameMatch_value := AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.BpsLeadingNameMatch_value.params));
	lname_trailing_value := AutoStandardI.InterfaceTranslator.lname_trailing_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.lname_trailing_value.params));
	fname_trailing_value := AutoStandardI.InterfaceTranslator.fname_trailing_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.fname_trailing_value.params));
	StrictMatch_value := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.StrictMatch_value.params));
	DisplayMatchedParty_value := AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.DisplayMatchedParty_value.params));
	penalt_threshold_value := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
	FuzzySecRange_value := AutoStandardI.InterfaceTranslator.FuzzySecRange_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.FuzzySecRange_value.params));
	Include_SourceDocCounts := %inputmod%.IncludeSourceDocCounts; //only in doxie.HeaderFileSearchService
	SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params));
	do_primname_word_match := AutoStandardI.InterfaceTranslator.do_primname_word_match.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.do_primname_word_match.params)); 
//only in DriversV2_Services.DLSearchService_ids  
	allow_uber_keys_value := AutoStandardI.InterfaceTranslator.allow_uber_keys_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.allow_uber_keys_value.params)); 
//only in Business_Header.BH_GID_RollupSearchService, Business_Header.fn_RSS_get_bdids_by_sic_zip
	SIC_value := AutoStandardI.InterfaceTranslator.SIC_value.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.SIC_value.params));
	application_type_value := AutoStandardI.InterfaceTranslator.application_type_val.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.application_type_val.params));
	isPeopleWise := AutoStandardI.InterfaceTranslator.isPeopleWise.val(project(%inputmod%,AutoStandardI.InterfaceTranslator.isPeopleWise.params));
	suppressDMVInfo_value	:= %inputmod%.SuppressDMVInfo;
//only in LN_PropertyV2_Services.fn_get_report 
	xadl2_weight_threshold_value	:= %inputmod%.xadl2_weight_threshold;
endmacro;
