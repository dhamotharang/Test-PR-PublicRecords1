import STRATA;

EXPORT Strata(string pVersion) := function

pNAC_BAse_base:=NAC_V2.Files().Base2;

rPopulationStats_NAC_Base_base
 :=
  record
	pNAC_Base_base.ProgramState;
	CountGroup									:= count(group);
//	filename_CountNonBlank := sum(group,if(pNAC_Base_base.filename<>'',1,0));
	//case_id_CountNonBlank := sum(group,if(pNAC_Base_base.CaseID>0,1,0));
	case_benefit_type_CountNonBlank := sum(group,if(pNAC_Base_base.ProgramCode<>'',1,0));
	case_benefit_month_CountNonBlank := sum(group,if(pNAC_Base_base.StartDate_Raw<>'',1,0));
	case_identifier_CountNonBlank := sum(group,if(pNAC_Base_base.CaseID<>'',1,0));
	case_last_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_last_name<>'',1,0));
	case_first_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_first_name<>'',1,0));
	case_middle_name_CountNonBlank := sum(group,if(pNAC_Base_base.case_middle_name<>'',1,0));
	case_phone_1_CountNonBlank := sum(group,if(pNAC_Base_base.case_Phone1<>'',1,0));
	case_phone_2_CountNonBlank := sum(group,if(pNAC_Base_base.case_Phone2<>'',1,0));
	case_email_CountNonBlank := sum(group,if(pNAC_Base_base.case_email<>'',1,0));
	case_physical_address_street_1_CountNonBlank := sum(group,if(pNAC_Base_base.Physical_Street1<>'',1,0));
	case_physical_address_street_2_CountNonBlank := sum(group,if(pNAC_Base_base.Physical_Street2<>'',1,0));
	case_physical_address_city_CountNonBlank := sum(group,if(pNAC_Base_base.Physical_City<>'',1,0));
	case_physical_address_state_CountNonBlank := sum(group,if(pNAC_Base_base.Physical_State<>'',1,0));
	case_physical_address_zip_CountNonBlank := sum(group,if(pNAC_Base_base.Physical_zip<>'',1,0));
	case_mailing_address_street_1_CountNonBlank := sum(group,if(pNAC_Base_base.Mailing_Street1<>'',1,0));
	case_mailing_address_street_2_CountNonBlank := sum(group,if(pNAC_Base_base.Mailing_Street2<>'',1,0));
	case_mailing_address_city_CountNonBlank := sum(group,if(pNAC_Base_base.Mailing_City<>'',1,0));
	case_mailing_address_state_CountNonBlank := sum(group,if(pNAC_Base_base.Mailing_State<>'',1,0));
	case_mailing_address_zip_CountNonBlank := sum(group,if(pNAC_Base_base.Mailing_Zip<>'',1,0));
	case_county_parish_code_CountNonBlank := sum(group,if(pNAC_Base_base.CountyCode<>'',1,0));
	case_county_parish_name_CountNonBlank := sum(group,if(pNAC_Base_base.CountyName<>'',1,0));
	client_identifier_CountNonBlank := sum(group,if(pNAC_Base_base.ClientId<>'',1,0));
	client_last_name_CountNonBlank := sum(group,if(pNAC_Base_base.LastName<>'',1,0));
	client_first_name_CountNonBlank := sum(group,if(pNAC_Base_base.FirstName<>'',1,0));
	client_middle_name_CountNonBlank := sum(group,if(pNAC_Base_base.MiddleName<>'',1,0));
	client_name_suffix_CountNonBlank := sum(group,if(pNAC_Base_base.NameSuffix<>'',1,0));
	client_gender_CountNonBlank := sum(group,if(pNAC_Base_base.gender<>'',1,0));
	client_race_CountNonBlank := sum(group,if(pNAC_Base_base.race<>'',1,0));
	client_ethnicity_CountNonBlank := sum(group,if(pNAC_Base_base.ethnicity<>'',1,0));
	client_ssn_CountNonBlank := sum(group,if(pNAC_Base_base.ssn<>'',1,0));
	client_ssn_type_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.ssn_type_indicator<>'',1,0));
	client_dob_CountNonBlank := sum(group,if(pNAC_Base_base.dob<>'',1,0));
	client_dob_type_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.dob_type_indicator<>'',1,0));
	client_eligible_status_indicator_CountNonBlank := sum(group,if(pNAC_Base_base.eligibility_status_indicator<>'',1,0));
	client_eligible_status_date_CountNonBlank := sum(group,if(pNAC_Base_base.eligibility_status_date<>'',1,0));
	client_phone_CountNonBlank := sum(group,if(pNAC_Base_base.client_phone<>'',1,0));
	client_email_CountNonBlank := sum(group,if(pNAC_Base_base.client_email<>'',1,0));
/*	state_contact_name_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_name<>'',1,0));
	state_contact_phone_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_phone<>'',1,0));
	state_contact_phone_extension_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_phone_extension<>'',1,0));
	state_contact_email_CountNonBlank := sum(group,if(pNAC_Base_base.state_contact_email<>'',1,0));
	prepped_name_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_name<>'',1,0));
	prepped_addr1_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_addr1<>'',1,0));
	prepped_addr2_CountNonBlank := sum(group,if(pNAC_Base_base.prepped_addr2<>'',1,0));
*/	did_CountNonBlank := sum(group,if(pNAC_Base_base.did>0,1,0));
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
	fips_state_CountNonBlank := sum(group,if(pNAC_Base_base.fips_state<>'',1,0));
	fips_county_CountNonBlank := sum(group,if(pNAC_Base_base.fips_county<>'',1,0));
	geo_lat_CountNonBlank := sum(group,if(pNAC_Base_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank := sum(group,if(pNAC_Base_base.geo_long<>'',1,0));
	msa_CountNonBlank := sum(group,if(pNAC_Base_base.msa<>'',1,0));
	geo_blk_CountNonBlank := sum(group,if(pNAC_Base_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank := sum(group,if(pNAC_Base_base.geo_match<>'',1,0));
	err_stat_CountNonBlank := sum(group,if(pNAC_Base_base.err_stat<>'',1,0));
	//zero_CountNonBlank := sum(group,if(pNAC_Base_base.zero>0,1,0));
	//blank_CountNonBlank := sum(group,if(pNAC_Base_base.blank<>'',1,0));
 end;

dPopulationStats_NAC_BAse_base := table(pNAC_Base_base, rPopulationStats_NAC_Base_base, ProgramState, few);
return dPopulationStats_NAC_BAse_base;
/*
STRATA.createXMLStats(dPopulationStats_NAC_Base_base
					 ,'NAC'
					 ,'NAC_Base'
					 ,pVersion
					 ,'jose.bello@lexisnexis.com'
					 ,zNAC_Base_base);

return zNAC_Base_base;
*/
end;