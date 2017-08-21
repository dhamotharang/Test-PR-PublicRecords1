import Bipv2,mdr;

EXPORT BH_Source_Ingest_Field_Pop_stats := function

	BH_sources := dataset('~thor_data400::base::BIPV2::built::source_ingest::data',Bipv2.Layout_Business_Linking_Full,thor);
	//BH_sources := BIPV2.File_Business_Sources;

	layout_stats := record
			BH_sources.source;
			source_Desc := mdr.sourceTools.TranslateSource(BH_sources.source);
			cnt := count(group);		
			dt_first_seen_CountNonZero  := sum(group,if(BH_sources.dt_first_seen <> 0, 1, 0));
			dt_last_seen_CountNonZero  := sum(group,if(BH_sources.dt_last_seen <> 0, 1, 0));
			dt_vendor_first_reported_CountNonZero  := sum(group,if(BH_sources.dt_vendor_first_reported <> 0, 1, 0));
			dt_vendor_last_reported_CountNonZero  := sum(group,if(BH_sources.dt_vendor_last_reported <> 0, 1, 0));
			rcid_CountNonZero  := sum(group,if(BH_sources.rcid <> 0, 1, 0));
			company_bdid_CountNonZero := sum(group,if(BH_sources.company_bdid <> 0, 1, 0));		
			company_name_CountNonBlank := sum(group,if(BH_sources.company_name <> '', 1, 0));
			company_name_type_raw_CountNonBlank := sum(group,if(BH_sources.company_name_type_raw <> '', 1, 0));
			company_name_type_derived_CountNonBlank := sum(group,if(BH_sources.company_name_type_derived <> '', 1, 0));
			raw_aid_CountNonZero  := sum(group,if(BH_sources.company_rawaid <> 0, 1, 0));
			ace_aid_CountNonZero  := sum(group,if(BH_sources.company_Aceaid <> 0, 1, 0));
			company_address_prim_range_CountNonBlank := sum(group,if(BH_sources.company_address.prim_range <> '', 1, 0));
			company_address_predir_CountNonBlank := sum(group,if(BH_sources.company_address.predir <> '', 1, 0));
			company_address_prim_name_CountNonBlank := sum(group,if(BH_sources.company_address.prim_name <> '', 1, 0));
			company_address_addr_suffix_CountNonBlank := sum(group,if(BH_sources.company_address.addr_suffix <> '', 1, 0));
			company_address_postdir_CountNonBlank := sum(group,if(BH_sources.company_address.postdir <> '', 1, 0));
			company_address_unit_desig_CountNonBlank := sum(group,if(BH_sources.company_address.unit_desig <> '', 1, 0));
			company_address_sec_range_CountNonBlank := sum(group,if(BH_sources.company_address.sec_range <> '', 1, 0));
			company_address_p_city_name_CountNonBlank := sum(group,if(BH_sources.company_address.p_city_name <> '', 1, 0));
			company_address_v_city_name_CountNonBlank := sum(group,if(BH_sources.company_address.v_city_name <> '', 1, 0));
			company_address_st_CountNonBlank := sum(group,if(BH_sources.company_address.st <> '', 1, 0));
			company_address_zip_CountNonBlank := sum(group,if(BH_sources.company_address.zip <> '', 1, 0));
			company_address_zip4_CountNonBlank := sum(group,if(BH_sources.company_address.zip4 <> '', 1, 0));
			company_address_cart_CountNonBlank := sum(group,if(BH_sources.company_address.cart <> '', 1, 0));
			company_address_cr_sort_sz_CountNonBlank := sum(group,if(BH_sources.company_address.cr_sort_sz <> '', 1, 0));
			company_address_lot_CountNonBlank := sum(group,if(BH_sources.company_address.lot <> '', 1, 0));
			company_address_lot_order_CountNonBlank := sum(group,if(BH_sources.company_address.lot_order <> '', 1, 0));
			company_address_dbpc_CountNonBlank := sum(group,if(BH_sources.company_address.dbpc <> '', 1, 0));
			company_address_chk_digit_CountNonBlank := sum(group,if(BH_sources.company_address.chk_digit <> '', 1, 0));
			company_address_rec_type_CountNonBlank := sum(group,if(BH_sources.company_address.rec_type <> '', 1, 0));
			company_address_fips_state_CountNonBlank := sum(group,if(BH_sources.company_address.fips_state <> '', 1, 0));
			company_address_fips_county_CountNonBlank := sum(group,if(BH_sources.company_address.fips_county <> '', 1, 0));
			company_address_geo_lat_CountNonBlank := sum(group,if(BH_sources.company_address.geo_lat <> '', 1, 0));
			company_address_geo_long_CountNonBlank := sum(group,if(BH_sources.company_address.geo_long <> '', 1, 0));
			company_address_msa_CountNonBlank := sum(group,if(BH_sources.company_address.msa <> '', 1, 0));
			company_address_geo_blk_CountNonBlank := sum(group,if(BH_sources.company_address.geo_blk <> '', 1, 0));
			company_address_geo_match_CountNonBlank := sum(group,if(BH_sources.company_address.geo_match <> '', 1, 0));
			company_address_err_stat_CountNonBlank := sum(group,if(BH_sources.company_address.err_stat <> '', 1, 0));
			company_address_type_raw_CountNonBlank := sum(group,if(BH_sources.company_address_type_raw <> '', 1, 0));
			company_address_type_derived_CountNonBlank := sum(group,if(BH_sources.company_address_type_derived <> '', 1, 0));
			company_address_country_code_CountNonBlank := sum(group,if(BH_sources.company_address_country_code <> '', 1, 0));
			company_fein_CountNonBlank := sum(group,if(BH_sources.company_fein <> '', 1, 0));
			best_fein_Indicator_CountNonBlank := sum(group,if(BH_sources.best_fein_Indicator <> '', 1, 0));
			company_phone_CountNonBlank := sum(group,if(BH_sources.company_phone <> '', 1, 0));
			phone_type_CountNonBlank := sum(group,if(BH_sources.phone_type <> '', 1, 0));
			company_org_structure_raw_CountNonBlank := sum(group,if(BH_sources.company_org_structure_raw <> '', 1, 0));
			company_org_structure_derived_CountNonBlank := sum(group,if(BH_sources.company_org_structure_derived <> '', 1, 0));
			company_incorporation_date_CountNonZero := sum(group,if(BH_sources.company_incorporation_date <> 0, 1, 0));
			company_sic_code1_CountNonBlank := sum(group,if(BH_sources.company_sic_code1 <> '', 1, 0));
			company_sic_code2_CountNonBlank := sum(group,if(BH_sources.company_sic_code2 <> '', 1, 0));
			company_sic_code3_CountNonBlank := sum(group,if(BH_sources.company_sic_code3 <> '', 1, 0));
			company_sic_code4_CountNonBlank := sum(group,if(BH_sources.company_sic_code4 <> '', 1, 0));
			company_sic_code5_CountNonBlank := sum(group,if(BH_sources.company_sic_code5 <> '', 1, 0));
			company_naics_code1_CountNonBlank := sum(group,if(BH_sources.company_naics_code1 <> '', 1, 0));
			company_naics_code2_CountNonBlank := sum(group,if(BH_sources.company_naics_code2 <> '', 1, 0));
			company_naics_code3_CountNonBlank := sum(group,if(BH_sources.company_naics_code3 <> '', 1, 0));
			company_naics_code4_CountNonBlank := sum(group,if(BH_sources.company_naics_code4 <> '', 1, 0));		
			company_naics_code5_CountNonBlank := sum(group,if(BH_sources.company_naics_code5 <> '', 1, 0));
			company_ticker_CountNonBlank := sum(group,if(BH_sources.company_ticker <> '', 1, 0));
			company_ticker_exchange_CountNonBlank := sum(group,if(BH_sources.company_ticker_exchange <> '', 1, 0));
			company_foreign_domestic_CountNonBlank := sum(group,if(BH_sources.company_foreign_domestic <> '', 1, 0));
			company_url_CountNonBlank := sum(group,if(BH_sources.company_url <> '', 1, 0));
			company_inc_state_CountNonBlank := sum(group,if(BH_sources.company_inc_state <> '', 1, 0));
			company_charter_number_CountNonBlank := sum(group,if(BH_sources.company_charter_number <> '', 1, 0));
			company_filing_date_CountNonZero := sum(group,if(BH_sources.company_filing_date <> 0, 1, 0));
			company_status_date_CountNoZero := sum(group,if(BH_sources.company_status_date <> 0, 1, 0));
			company_foreign_date_CountNonZero := sum(group,if(BH_sources.company_foreign_date <> 0, 1, 0));		
			event_filing_date_CountNonZero := sum(group,if(BH_sources.event_filing_date <> 0, 1, 0));
			company_name_status_raw_CountNonBlank := sum(group,if(BH_sources.company_name_status_raw <> '', 1, 0));
			company_name_status_derived_CountNonBlank := sum(group,if(BH_sources.company_name_status_derived <> '', 1, 0));
			company_status_raw_CountNonBlank := sum(group,if(BH_sources.company_status_raw <> '', 1, 0));
			company_status_derived_CountNonBlank := sum(group,if(BH_sources.company_status_derived <> '', 1, 0));
			dt_first_seen_company_name_CountNonZero := sum(group,if(BH_sources.dt_first_seen_company_name <> 0, 1, 0));
			dt_last_seen_company_name_CountNonZero := sum(group,if(BH_sources.dt_last_seen_company_name <> 0, 1, 0));
			dt_first_seen_company_address_CountNonZero := sum(group,if(BH_sources.dt_first_seen_company_address <> 0, 1, 0));
			dt_last_seen_company_address_CountNonZero := sum(group,if(BH_sources.dt_last_seen_company_address <> 0, 1, 0));
			vl_id_CountNonBlank := sum(group,if(BH_sources.vl_id <> '', 1, 0));
			current_CountTrue := sum(group,if(BH_sources.current, 1, 0));
			source_record_id_CountNonZero := sum(group,if(BH_sources.source_record_id <> 0, 1, 0));
			glb_CountTrue := sum(group,if(BH_sources.glb, 1, 0));
			dppa_CountTrue := sum(group,if(BH_sources.dppa, 1, 0));
			phone_score_CountNonZero := sum(group,if(BH_sources.phone_score <> 0, 1, 0));
			match_company_name_CountNonBlank := sum(group,if(BH_sources.match_company_name <> '', 1, 0));
			match_branch_city_CountNonBlank := sum(group,if(BH_sources.match_branch_city <> '', 1, 0));
			match_geo_city_CountNonBlank := sum(group,if(BH_sources.match_geo_city <> '', 1, 0));
			duns_number_CountNonBlank := sum(group,if(BH_sources.duns_number <> '', 1, 0));		
			source_docid_CountNonBlank := sum(group,if(BH_sources.source_docid <> '', 1, 0));
			//**** Contact fields
			is_contact_CountTrue := sum(group,if(BH_sources.is_contact, 1, 0));
			dt_first_seen_contact_CountNonZero := sum(group,if(BH_sources.dt_first_seen_contact <> 0, 1, 0));
			dt_last_seen_contact_CountNonZero := sum(group,if(BH_sources.dt_last_seen_contact <> 0, 1, 0));
			contact_did_CountNonZero := sum(group,if(BH_sources.contact_did <> 0, 1, 0));
			contact_name_title_CountNonBlank := sum(group,if(BH_sources.contact_name.title <> '', 1, 0));		
			contact_name_fname_CountNonBlank := sum(group,if(BH_sources.contact_name.fname <> '', 1, 0));
			contact_name_lname_CountNonBlank := sum(group,if(BH_sources.contact_name.lname <> '', 1, 0));
			contact_name_mname_CountNonBlank := sum(group,if(BH_sources.contact_name.mname <> '', 1, 0));
			contact_name_name_suffix_CountNonBlank := sum(group,if(BH_sources.contact_name.name_suffix <> '', 1, 0));
			contact_type_raw_CountNonBlank := sum(group,if(BH_sources.contact_type_raw <> '', 1, 0));
			contact_type_derived_CountNonBlank := sum(group,if(BH_sources.contact_type_derived <> '', 1, 0));
			contact_job_title_raw_CountNonBlank := sum(group,if(BH_sources.contact_job_title_raw <> '', 1, 0));
			contact_job_title_derived_CountNonBlank := sum(group,if(BH_sources.contact_job_title_derived <> '', 1, 0));
			contact_ssn_CountNonBlank := sum(group,if(BH_sources.contact_ssn <> '', 1, 0));
			contact_dob_CountNonZero := sum(group,if(BH_sources.contact_dob <> 0, 1, 0));
			contact_status_raw_CountNonBlank := sum(group,if(BH_sources.contact_status_raw <> '', 1, 0));
			contact_status_derived_CountNonBlank := sum(group,if(BH_sources.contact_status_derived <> '', 1, 0));
			contact_email_CountNonBlank := sum(group,if(BH_sources.contact_email <> '', 1, 0));
			contact_email_username_CountNonBlank := sum(group,if(BH_sources.contact_email_username <> '', 1, 0));
			contact_email_domain_CountNonBlank := sum(group,if(BH_sources.contact_email_domain <> '', 1, 0));
			contact_phone_CountNonBlank := sum(group,if(BH_sources.contact_phone <> '', 1, 0));
			cid_CountNonZero := sum(group,if(BH_sources.cid <> 0, 1, 0));
			contact_score_CountNonZero := sum(group,if(BH_sources.contact_score <> 0, 1, 0));
			from_hdr_CountNonBlank := sum(group,if(BH_sources.from_hdr <> '', 1, 0));		
			company_department_CountNonBlank := sum(group,if(BH_sources.company_department <> '', 1, 0));
	end;

	out_status := sort(table(BH_sources, layout_stats, source, few),source);

	out_status2 := sort(project(out_status,{string2 source, string source_Desc, unsigned6 cnt, unsigned6 source_record_id_CountNonZero}), source_record_id_CountNonZero, source);

	out_all_stats := sequential(output(out_status, named('Bipv2_BizHdr_SourceIngest_Field_Population_stats'),all),
															output(out_status2, named('Bipv2_BizHdr_SourceIngest_Field_Population_stats2'),all)
														 );

	return out_all_stats;
end;
//output(out_status, named('Bipv2_BizHdr_SourceIngest_Field_Population_stats'),all);
//output(out_status2, named('Bipv2_BizHdr_SourceIngest_Field_Population_stats2'),all);

