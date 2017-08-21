import STRATA;

EXPORT Strata(string pVersion) := function

pNAC_BAse_base:=NAC.Files().Base;

rPopulationStats_NAC_Base_base
 :=
  record
	pNAC_Base_base.case_state_abbreviation;
	CountGroup									:= count(group);
	filename_CountNonBlank := sum(group,if(pNAC_Base_base.filename<>'',1,0));
	case_id_CountNonBlank := sum(group,if(pNAC_Base_base.case_id>0,1,0));
	case_benefit_type_CountNonBlank := sum(group,if(pNAC_Base_base.case_benefit_type<>'',1,0));
	case_benefit_month_CountNonBlank := sum(group,if(pNAC_Base_base.case_benefit_month<>'',1,0));
	case_identifier_CountNonBlank := sum(group,if(pNAC_Base_base.case_identifier<>'',1,0));
	case_last_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_last_name<>'',1,0));
	case_first_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_first_name<>'',1,0));
	case_middle_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_middle_name<>'',1,0));
	case_phone_1_CountNonBlank := sum(group,if(pNAC_Base_base.case_phone_1<>'',1,0));
	case_phone_2_CountNonBlank := sum(group,if(pNAC_Base_base.case_phone_2<>'',1,0));
	case_email_CountNonBlank := sum(group,if(pNAC_Base_base.case_email<>'',1,0));
	case_physical_address_street_1_CountNonBlank := sum(group,if(pNAC_Base_base.case_physical_address_street_1<>'',1,0));
	case_physical_address_street_2_CountNonBlank := sum(group,if(pNAC_Base_base.case_physical_address_street_2<>'',1,0));
	case_physical_address_city_CountNonBlank := sum(group,if(pNAC_Base_base.case_physical_address_city<>'',1,0));
	case_physical_address_state_CountNonBlank := sum(group,if(pNAC_Base_base.case_physical_address_state<>'',1,0));
	case_physical_address_zip_CountNonBlank := sum(group,if(pNAC_Base_base.case_physical_address_zip<>'',1,0));
	case_mailing_address_street_1_CountNonBlank := sum(group,if(pNAC_Base_base.case_mailing_address_street_1<>'',1,0));
	case_mailing_address_street_2_CountNonBlank := sum(group,if(pNAC_Base_base.case_mailing_address_street_2<>'',1,0));
	case_mailing_address_city_CountNonBlank := sum(group,if(pNAC_Base_base.case_mailing_address_city<>'',1,0));
	case_mailing_address_state_CountNonBlank := sum(group,if(pNAC_Base_base.case_mailing_address_state<>'',1,0));
	case_mailing_address_zip_CountNonBlank := sum(group,if(pNAC_Base_base.case_mailing_address_zip<>'',1,0));
	case_county_parish_code_CountNonBlank := sum(group,if(pNAC_Base_base.case_county_parish_code<>'',1,0));
	case_county_parish_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_county_parish_name<>'',1,0));
	client_identifier_CountNonBlank := sum(group,if(pNAC_Base_base.client_identifier<>'',1,0));
	client_last_name_CountNonBlank := sum(group,if(pNAC_Base_base.client_last_name<>'',1,0));
	client_first_name_CountNonBlank := sum(group,if(pNAC_Base_base.client_first_name<>'',1,0));
	client_middle_name_CountNonBlank := sum(group,if(pNAC_Base_base.client_middle_name<>'',1,0));
	client_gender_CountNonBlank := sum(group,if(pNAC_Base_base.client_gender<>'',1,0));
	client_race_CountNonBlank := sum(group,if(pNAC_Base_base.client_race<>'',1,0));
	client_ethnicity_CountNonBlank := sum(group,if(pNAC_Base_base.client_ethnicity<>'',1,0));
	client_ssn_CountNonBlank := sum(group,if(pNAC_Base_base.client_ssn<>'',1,0));
	client_ssn_type_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.client_ssn_type_indicator<>'',1,0));
	client_dob_CountNonBlank := sum(group,if(pNAC_Base_base.client_dob<>'',1,0));
	client_dob_type_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.client_dob_type_indicator<>'',1,0));
	client_eligible_status_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.client_eligible_status_indicator<>'',1,0));
	client_eligible_status_date_CountNonBlank := sum(group,if(pNAC_Base_base.client_eligible_status_date<>'',1,0));
	client_phone_CountNonBlank := sum(group,if(pNAC_Base_base.client_phone<>'',1,0));
	client_email_CountNonBlank := sum(group,if(pNAC_Base_base.client_email<>'',1,0));
	state_contact_name_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_name<>'',1,0));
	state_contact_phone_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_phone<>'',1,0));
	state_contact_phone_extension_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_phone_extension<>'',1,0));
	state_contact_email_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_email<>'',1,0));
	prepped_name_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_name<>'',1,0));
	prepped_addr1_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_addr1<>'',1,0));
	prepped_addr2_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_addr2<>'',1,0));
	did_CountNonBlank := sum(group,if(pNAC_Base_base.did>0,1,0));
	did_score_CountNonBlank := sum(group,if(pNAC_Base_base.did_score>0,1,0));
	processdate_CountNonBlank := sum(group,if(pNAC_Base_base.processdate>0,1,0));
	ncf_filedate_CountNonBlank := sum(group,if(pNAC_Base_base.ncf_filedate>0,1,0));
	preprecseq_CountNonBlank := sum(group,if(pNAC_Base_base.preprecseq>0,1,0));
	clean_ssn_CountNonBlank := sum(group,if(pNAC_Base_base.clean_ssn<>'',1,0));
	best_ssn_CountNonBlank := sum(group,if(pNAC_Base_base.best_ssn<>'',1,0));
	clean_dob_CountNonBlank := sum(group,if(pNAC_Base_base.clean_dob>0,1,0));
	age_CountNonBlank := sum(group,if(pNAC_Base_base.age>0,1,0));
	best_dob_CountNonBlank := sum(group,if(pNAC_Base_base.best_dob>0,1,0));
	title_CountNonBlank := sum(group,if(pNAC_Base_base.title<>'',1,0));
	fname_CountNonBlank := sum(group,if(pNAC_Base_base.fname<>'',1,0));
	mname_CountNonBlank := sum(group,if(pNAC_Base_base.mname<>'',1,0));
	lname_CountNonBlank := sum(group,if(pNAC_Base_base.lname<>'',1,0));
	name_suffix_CountNonBlank := sum(group,if(pNAC_Base_base.name_suffix<>'',1,0));
	prim_range_CountNonBlank := sum(group,if(pNAC_Base_base.prim_range<>'',1,0));
	predir_CountNonBlank := sum(group,if(pNAC_Base_base.predir<>'',1,0));
	prim_name_CountNonBlank := sum(group,if(pNAC_Base_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank := sum(group,if(pNAC_Base_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank := sum(group,if(pNAC_Base_base.postdir<>'',1,0));
	unit_desig_CountNonBlank := sum(group,if(pNAC_Base_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank := sum(group,if(pNAC_Base_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank := sum(group,if(pNAC_Base_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank := sum(group,if(pNAC_Base_base.v_city_name<>'',1,0));
	st_CountNonBlank := sum(group,if(pNAC_Base_base.st<>'',1,0));
	zip_CountNonBlank := sum(group,if(pNAC_Base_base.zip<>'',1,0));
	zip4_CountNonBlank := sum(group,if(pNAC_Base_base.zip4<>'',1,0));
	cart_CountNonBlank := sum(group,if(pNAC_Base_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank := sum(group,if(pNAC_Base_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank := sum(group,if(pNAC_Base_base.lot<>'',1,0));
	lot_order_CountNonBlank := sum(group,if(pNAC_Base_base.lot_order<>'',1,0));
	dbpc_CountNonBlank := sum(group,if(pNAC_Base_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank := sum(group,if(pNAC_Base_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank := sum(group,if(pNAC_Base_base.rec_type<>'',1,0));
	fips_county_CountNonBlank := sum(group,if(pNAC_Base_base.fips_county<>'',1,0));
	county_CountNonBlank := sum(group,if(pNAC_Base_base.county<>'',1,0));
	geo_lat_CountNonBlank := sum(group,if(pNAC_Base_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank := sum(group,if(pNAC_Base_base.geo_long<>'',1,0));
	msa_CountNonBlank := sum(group,if(pNAC_Base_base.msa<>'',1,0));
	geo_blk_CountNonBlank := sum(group,if(pNAC_Base_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank := sum(group,if(pNAC_Base_base.geo_match<>'',1,0));
	err_stat_CountNonBlank := sum(group,if(pNAC_Base_base.err_stat<>'',1,0));
	zero_CountNonBlank := sum(group,if(pNAC_Base_base.zero>0,1,0));
	blank_CountNonBlank := sum(group,if(pNAC_Base_base.blank<>'',1,0));
 end;

dPopulationStats_NAC_BAse_base := table(pNAC_Base_base, rPopulationStats_NAC_Base_base, case_state_abbreviation, few);

STRATA.createXMLStats(dPopulationStats_NAC_Base_base
					 ,'NAC'
					 ,'NAC_Base'
					 ,pVersion
					 ,'jose.bello@lexisnexis.com'
					 ,zNAC_Base_base);

return zNAC_Base_base;

end;