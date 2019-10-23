import Data_Services;

export constants  := module
// autokey
	export ak_dataset := Prof_License_Mari.file_mari_search;
	export ak_keyname := thor_cluster + 'key::proflic_mari::autokey::@version@::';
	export ak_logical(string filedate) := thor_cluster + 'key::proflic_mari::' + filedate + '::autokey::';
	export ak_qa_keyname := thor_cluster + 'key::proflic_mari::autokey::qa::';
	export set_skip := [];
						// P in this set to skip personal phones
						// Q in this set to skip business phones
						// S in this set to skip SSN
						// F in this set to skip FEIN
						// C in this set to skip ALL personal (Contact) data
						// B in this set to skip ALL Business data

	export TYPE_STR := 'ak';
	export USE_ALL_LOOKUPS := TRUE;
	
	// DF-21891 - define fields to be clear in thor_data400::key::proflic_mari::fcra::qa::did 
	EXPORT fields_to_clear :=  'active_flag,addl_license_spec,addr_addr1_1,addr_addr2_1,addr_bus_ind,addr_carrier_rte_1,addr_city_1,addr_cntry_1,addr_cnty_1,' +
																		'addr_delivery_pt_1,addr_id_1,addr_state_1,addr_zip4_1,addr_zip5_1,affil_key,affil_type_cd,agency_id,agency_status,append_busaceaid,' +
																		'append_busaddrfirst,append_busaddrlast,append_busrawaid,append_mailaddrfirst,append_mailaddrlast,birth_dte,bk_class,' +
																		'bk_class_desc,brkr_license_nbr,brkr_license_nbr_type,bus_ace_fips_st,bus_addr_suffix,bus_cart,bus_chk_digit,bus_county,' +
																		'bus_cr_sort_sz,bus_dpbc,bus_err_stat,bus_geo_blk,bus_geo_lat,bus_geo_long,bus_geo_match,bus_lot,bus_lot_order,bus_msa,' +
																		'bus_p_city_name,bus_postdir,bus_predir,bus_prim_name,bus_prim_range,bus_rec_type,bus_sec_range,bus_state,bus_unit_desig,' +
																		'bus_v_city_name,bus_zip4,bus_zip5,business_type,charter,cln_license_nbr,cmc_slpk,cont_education_ernd,cont_education_req,' +
																		'cont_education_term,credential,dba_flag,disp_type_cd,disp_type_desc,displinary_action,docket_id,domestic_off_nbr,' +
																		'email,fed_rssd,federal_regulator,foreign_nmls_id,foreign_off_nbr,gen_nbr,gender,genlink,hcr_location,hcr_rssd,' +
																		'hqtr_city,hqtr_name,inst_beg_dte,is_authorized_conduct,is_authorized_license,license_id,license_nbr_contact,location_type,' +
																		'match_id,mltreckey,name_company,name_company_dba,name_contact_first,name_contact_last,name_contact_mid,name_contact_nick,' +
																		'name_contact_prefx,name_contact_sufx,name_contact_ttl,name_dba,name_dba_orig,name_dba_prefx,name_dba_sufx,name_format,' +
																		'name_mari_dba,name_mari_org,name_nick,name_office,name_org,name_org_orig,name_org_prefx,name_org_sufx,name_type,' +
																		'off_license_nbr,off_license_nbr_type,office_parse,old_cmc_slpk,ooc_ind_1,ooc_ind_2,origin_cd,origin_cd_desc,pcmc_slpk,' +
																		'phn_contact,phn_contact_ext,phn_contact_fax,phn_fax_1,phn_fax_2,phn_mari_1,phn_mari_2,phn_mari_fax_1,phn_mari_fax_2,' +
																		'phn_phone_1,phn_phone_2,prev_cmc_slpk,prev_mltreckey,prev_pcmc_slpk,prev_primary_key,prov_stat,provnote_1,provnote_2,' +
																		'provnote_3,rec_key,reg_agent,regulator,research_ind,result_cd_1,result_cd_2,site_location,ssn_taxid_1,ssn_taxid_2,start_dte,' +
																		'std_prof_cd,store_nbr,store_nbr_dba,sud_key_1,sud_key_2,tax_type_1,tax_type_2,title,type_cd,url,violation_case_nbr,' +
																		'violation_desc,violation_dte';

end;


