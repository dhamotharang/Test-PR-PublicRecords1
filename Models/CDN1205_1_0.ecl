IMPORT ut, RiskWise, Risk_Indicators, business_risk, easi, std;

export CDN1205_1_0(grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
									dataset(RiskWise.Layout_CD2I) indata,
									boolean isBusiness, 
									dataset(business_risk.layout_biid_btst_output) biid) := 


FUNCTION


 /************************************************************************************
 * Build Easi census data                                                            *
 ************************************************************************************/
	used_census_fields := record
		string12 geolink;
		string6 bel_edu;
		string6 fammar_p;
		string6 famotf18_p;
		string6 hhsize;
		string6 high_ed;
		string6 med_inc;
		string6 span_lang;
	end;
			
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;  	// billto shipto bocashell
		RiskWise.Layout_CD2I cd2i;  										// original customer input fields
		used_census_fields easi;  											// easi census on the billto address
		used_census_fields easi2;  											// easi census on the shipto address
	END;
	
	
	// join ineasi to clam so that we can pass a single dataset into the model.
	layout_model_in getModelInput(clam le, indata ri) := TRANSFORM
		SELF.bs := le;
		self.cd2i := ri;
		self := [];
	END;
	
	clam_with_indata := join(clam, indata, left.bill_to_out.seq=(right.seq*2), getModelInput(left,right), left outer);

	layout_model_in join2recs(clam_with_indata le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi := ri;
		self := le;
	END;				 
	easi1_results := join(clam_with_indata, Easi.Key_Easi_Census,
				left.bs.Bill_To_Out.shell_input.st<>'' and 
				left.bs.Bill_To_Out.shell_input.county<>'' and
				left.bs.Bill_To_Out.shell_input.geo_blk<>'' and
				 keyed(right.geolink=left.bs.Bill_To_Out.shell_input.st+left.bs.Bill_To_Out.shell_input.county+left.bs.Bill_To_Out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bs.Bill_To_Out.shell_input.st+left.bs.Bill_To_Out.shell_input.county+left.bs.Bill_To_Out.shell_input.geo_blk),
					RiskWise.max_atmost),keep(1));
				
	layout_model_in joinEm(easi1_results le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi2 := ri;
		self := le;
	END;
	with_census := join(easi1_results, Easi.Key_Easi_Census,
				left.bs.Ship_To_Out.shell_input.st <>'' and
				left.bs.Ship_To_Out.shell_input.county <>'' and
				left.bs.Ship_To_Out.shell_input.geo_blk<>'' and
				keyed(right.geolink=left.bs.Ship_To_Out.shell_input.st+left.bs.Ship_To_Out.shell_input.county+left.bs.Ship_To_Out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,ATMOST(keyed(right.geolink=left.bs.Ship_To_Out.shell_input.st+left.bs.Ship_To_Out.shell_input.county+left.bs.Ship_To_Out.shell_input.geo_blk),RiskWise.max_atmost),keep(1));


	// MODEL_DEBUG := TRUE;
	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD, maxlength(50000)
			Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
			UNSIGNED SEQ;
			
			/* Model Input Variables */
			STRING inp_customer_create_date;
			STRING inp_pay_code_1;
			STRING inp_avs_response_code;
			STRING inp_cid_response_code;
			STRING inp_local_ship_code;
			STRING inp_order_amt;
			STRING inp_us_business_consumer_flag;
			STRING inp_product_desc;
			STRING _state;
			STRING efirstscore;
			STRING elastscore;
			STRING continent;
			STRING ipaddr;
			STRING topleveldomain;
			STRING iproutingmethod;
			STRING areacode;
			STRING ipdma;
			STRING distaddraddr2;
			STRING btst_are_relatives;
			STRING btst_relatives_in_common;
			STRING latitude;
			STRING longitude;
			STRING distphoneaddr;
			STRING distphone2addr2;
			STRING distaddrphone2;
			STRING addrscore;
			STRING firstscore;
			STRING lastscore;
			STRING did;
			BOOLEAN truedid;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_st;
			STRING out_z5;
			STRING out_lat;
			STRING out_long;
			STRING out_addr_type;
			STRING in_email_address;
			STRING in_ip_address;
			STRING in_phone10;
			INTEGER nap_summary;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_phonezipflag;
			STRING rc_pwphonezipflag;
			STRING rc_hriskaddrflag;
			STRING rc_dwelltype;
			INTEGER rc_addrcount;
			STRING rc_phoneaddrcount;
			STRING rc_phoneaddr_addrcount;
			BOOLEAN rc_hphonemiskeyflag;
			STRING bus_phone_match;
			STRING lnamepop;
			STRING addrpop;
			STRING hphnpop;
			STRING lname_eda_sourced_type;
			// STRING util_add1_type_list;
			STRING add1_lres;
			STRING add1_advo_res_or_business;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_occupant_owned;
			BOOLEAN add1_family_owned;
			STRING add1_date_first_seen;
			STRING add1_pop;
			STRING adls_per_addr;
			INTEGER ssns_per_addr;
			STRING inq_highriskcredit_count;
			STRING inq_highriskcredit_count01;
			STRING inq_highriskcredit_count03;
			STRING inq_highriskcredit_count06;
			STRING inq_highriskcredit_count12;
			STRING inq_highriskcredit_count24;
			STRING inq_retail_count;
			STRING inq_retail_count01;
			STRING inq_retail_count03;
			STRING inq_retail_count06;
			STRING inq_retail_count12;
			STRING inq_retail_count24;
			STRING inq_adlsperaddr;
			STRING paw_first_seen;
			STRING paw_source_count;
			STRING infutor_nap;
			STRING wealth_index;
			INTEGER archive_date;
			STRING did_s;
			STRING truedid_s;
			STRING out_unit_desig_s;
			STRING out_sec_range_s;
			STRING out_z5_s;
			STRING out_addr_type_s;
			STRING nap_summary_s;
			STRING cvi_s;
			STRING rc_hriskphoneflag_s;
			STRING rc_hphonetypeflag_s;
			STRING rc_phonevalflag_s;
			STRING rc_hphonevalflag_s;
			STRING rc_phonezipflag_s;
			STRING rc_pwphonezipflag_s;
			STRING rc_dwelltype_s;
			STRING rc_addrcount_s;
			STRING rc_phoneaddrcount_s;
			STRING rc_phoneaddr_addrcount_s;
			STRING ver_sources_s;
			STRING ver_sources_first_seen_s;
			STRING bus_name_match_s;
			STRING bus_phone_match_s;
			STRING fnamepop_s;
			STRING lnamepop_s;
			STRING addrpop_s;
			STRING ssnlength_s;
			STRING hphnpop_s;
			STRING source_count_s;
			STRING fname_eda_sourced_type_s;
			STRING lname_eda_sourced_type_s;
			// STRING util_add1_type_list_s;
			STRING add1_advo_res_or_business_s;
			STRING add1_eda_sourced_s;
			STRING add1_applicant_owned_s;
			STRING add1_occupant_owned_s;
			STRING add1_family_owned_s;
			STRING add1_naprop_s;
			STRING add1_pop_s;
			STRING adls_per_addr_s;
			STRING ssns_per_addr_s;
			STRING phones_per_addr_s;
			STRING adls_per_addr_c6_s;
			STRING ssns_per_addr_c6_s;
			STRING inq_collection_count_s;
			STRING inq_collection_count01_s;
			STRING inq_collection_count03_s;
			STRING inq_collection_count06_s;
			STRING inq_collection_count12_s;
			STRING inq_collection_count24_s;
			STRING inq_highriskcredit_count_s;
			STRING inq_highriskcredit_count01_s;
			STRING inq_highriskcredit_count03_s;
			STRING inq_highriskcredit_count06_s;
			STRING inq_highriskcredit_count12_s;
			STRING inq_highriskcredit_count24_s;
			STRING inq_adlsperaddr_s;
			STRING inq_ssnsperaddr_s;
			STRING paw_source_count_s;
			STRING infutor_nap_s;
			STRING impulse_first_seen_s;
			STRING email_domain_free_count_s;
			STRING attr_total_number_derogs_s;
			STRING attr_num_nonderogs_s;
			STRING liens_recent_unreleased_count_s;
			STRING liens_historical_unreleased_ct_s;
			STRING rel_count_s;
			STRING rel_bankrupt_count_s;
			STRING rel_criminal_count_s;
			STRING rel_felony_count_s;
			STRING rel_within25miles_count_s;
			STRING rel_within100miles_count_s;
			STRING rel_within500miles_count_s;
			STRING rel_withinother_count_s;
			STRING rel_incomeunder25_count_s;
			STRING rel_incomeunder50_count_s;
			STRING rel_incomeunder75_count_s;
			STRING rel_incomeunder100_count_s;
			STRING rel_incomeover100_count_s;
			STRING rel_educationunder8_count_s;
			STRING rel_educationunder12_count_s;
			STRING rel_educationover12_count_s;
			STRING wealth_index_s;
			STRING c_BEL_EDU;
			STRING c_FAMMAR_P;
			STRING c_FAMMAR_P_s;
			STRING c_FAMOTF18_P;
			STRING c_HHSIZE;
			STRING c_HHSIZE_s;
			STRING c_HIGH_ED_s;
			STRING c_MED_INC_s;
			STRING c_SPAN_LANG;
			STRING c_SPAN_LANG_s;

			/* Model Intermediate Variables */
			STRING NULL;
			STRING sysdate_1;
			INTEGER sysdate;
			STRING state;
			STRING pf_wks_since_create_date;
			STRING pf_pmt_type;
			STRING pf_avs_addr;
			STRING pf_avs_zip;
			STRING pf_avs_name;
			STRING pf_avs_error;
			STRING pf_avs_invalid;
			STRING pf_avs_unavail;
			STRING pf_avs_no_match;
			STRING pf_avs_intl;
			STRING pf_avs_result;
			STRING pf_pmt_x_avs_lvl;
			STRING pf_cid_result;
			STRING pf_ship_method;
			STRING pf_order_amt_c;
			STRING bt_add_apt;
			STRING st_add_apt;
			STRING bt_bus_phone_match;
			STRING bt_phn_miskey;
			STRING bt_valid_phone;
			STRING bt_phone_zip_match;
			STRING bt_hriskaddrflag;
			// STRING bt_add1_util_pots;
			STRING bt_inp_addr_res_or_business;
			STRING bt_max_ids_per_addr;
			STRING _paw_first_seen;
			STRING bt_mos_since_paw_first_seen;
			STRING bt_inq_retail_recency;
			STRING bt_paw_source_count;
			STRING st_bus_phone_match;
			STRING st_phone_zip_match;
			STRING st_inp_addr_res_or_business;
			STRING st_paw_source_count;
			STRING st_bus_name_match;
			STRING st_valid_phone;
			STRING st_inq_highriskcredit_recency;
			STRING bt_cen_hhsize;
			STRING bt_cen_famotf18_p;
			STRING bt_inp_addr_ownership_lvl;
			STRING bt_inq_adls_per_addr;
			STRING ver_phn_inf;
			STRING ver_phn_nap;
			STRING inf_phn_ver_lvl;
			STRING nap_phn_ver_lvl;
			STRING bt_nap_phn_ver_x_inf_phn_ver;
			STRING bt_cen_bel_edu;
			STRING bt_lname_eda_sourced_type;
			STRING inp_addr_date_first_seen;
			STRING bt_mos_since_inp_addr_fseen;
			STRING bt_infutor_nap;
			STRING bt_cen_fammar_p;
			STRING bt_cen_span_lang;
			STRING bt_inp_addr_lres;
			STRING bt_adls_per_sfd_addr;
			STRING st_cen_high_ed;
			STRING st_inq_collection_recency;
			STRING _impulse_first_seen_s;
			STRING st_mos_since_impulse_first_seen;
			STRING st_email_domain_free_count;
			STRING st_derog_ratio;
			STRING st_average_rel_income;
			STRING bt_inq_retail_count12;
			STRING st_max_ids_per_addr;
			STRING st_inq_ssns_per_addr;
			STRING st_unreleased_liens_ct;
			STRING st_average_rel_education;
			STRING st_rel_derog_summary;
			STRING st_wealth_index;
			STRING bt_addr_ver_sources;
			STRING bt_inq_highriskcredit_recency;
			STRING bt_wealth_index;
			STRING st_cvi;
			STRING src_white_pages_adl_fseen_s;
			STRING _src_white_pages_adl_fseen_s;
			STRING st_mos_src_white_pages_adl_fseen;
			STRING st_inp_addr_naprop;
			STRING st_max_ids_per_addr_c6;
			STRING src_bureau_adl_fseen_tn;
			STRING src_bureau_adl_fseen_ts;
			STRING src_bureau_adl_fseen_tu;
			STRING src_bureau_adl_fseen_en;
			STRING src_bureau_adl_fseen_eq;
			STRING src_bureau_adl_fseen_s;
			STRING _src_bureau_adl_fseen_s;
			STRING st_mos_src_bureau_adl_fseen;
			STRING st_inp_addr_eda_sourced;
			STRING st_inp_addr_ownership_lvl;
			STRING st_phones_per_sfd_addr;
			STRING st_closest_rel_distance;
			STRING st_cen_fammar_p;
			STRING st_cen_med_inc;
			STRING st_full_name_ver_sources;
			STRING st_addr_ver_sources;
			// STRING st_add1_util_sum;
			STRING st_max_ids_per_sfd_addr_c6;
			STRING st_inq_adls_per_addr;
			STRING ver_phn_inf_s;
			STRING ver_phn_nap_s;
			STRING inf_phn_ver_lvl_s;
			STRING nap_phn_ver_lvl_s;
			STRING st_nap_phn_ver_x_inf_phn_ver;
			STRING st_cen_hhsize;
			STRING st_high_risk_phone;
			STRING st_cen_span_lang;
			STRING btst_email_first_x_last_score;
			STRING ip_continent;
			STRING ip_state_match;
			STRING ip_topleveldomain_lvl;
			STRING ip_routingmethod;
			STRING ip_area_code_match;
			STRING ip_dma_lvl;
			STRING email_secondleveldomain;
			STRING btst_email_domain_risk_level;
			STRING btst_distaddraddr2;
			STRING btst_relatives_lvl;
			STRING num_inp_lat;
			STRING num_inp_long;
			STRING num_ip_lat;
			STRING num_ip_long;
			STRING d_lat;
			STRING d_long;
			STRING a;
			STRING c;
			STRING dist;
			STRING ip_dist_inp_addr_to_ip_addr;
			STRING btst_distphoneaddr;
			STRING btst_distphone2addr2;
			STRING btst_distaddrphone2;
			STRING addr_match;
			STRING fname_match;
			STRING lname_match;
			STRING did_match;
			STRING btst_segment2;
			STRING dell_segmentation2;
			STRING dell_segmentation3;
			STRING final_model_segment;
			STRING bs_p_subscore0;
			STRING bs_p_subscore1;
			STRING bs_p_subscore2;
			STRING bs_p_subscore3;
			STRING bs_p_subscore4;
			STRING bs_p_subscore6;
			STRING bs_p_subscore7;
			STRING bs_p_subscore8;
			STRING bs_p_subscore9;
			STRING bs_p_subscore10;
			STRING bs_p_subscore11;
			STRING bs_p_subscore12;
			STRING bs_p_rawscore;
			STRING bs_p_lnoddsscore;
			STRING bs_w_subscore0;
			STRING bs_w_subscore1;
			STRING bs_w_subscore2;
			STRING bs_w_subscore3;
			STRING bs_w_subscore4;
			STRING bs_w_subscore5;
			STRING bs_w_subscore6;
			STRING bs_w_subscore7;
			STRING bs_w_subscore8;
			STRING bs_w_subscore9;
			STRING bs_w_subscore10;
			STRING bs_w_subscore11;
			STRING bs_w_subscore12;
			STRING bs_w_subscore13;
			STRING bs_w_subscore14;
			STRING bs_w_subscore15;
			STRING bs_w_rawscore;
			STRING bs_w_lnoddsscore;
			STRING bd_p_subscore0;
			STRING bd_p_subscore1;
			STRING bd_p_subscore2;
			STRING bd_p_subscore3;
			STRING bd_p_subscore4;
			STRING bd_p_subscore5;
			STRING bd_p_subscore6;
			STRING bd_p_subscore7;
			STRING bd_p_subscore8;
			STRING bd_p_subscore9;
			STRING bd_p_subscore10;
			STRING bd_p_subscore11;
			STRING bd_p_subscore12;
			STRING bd_p_rawscore;
			STRING bd_p_lnoddsscore;
			STRING bd_w_subscore0;
			STRING bd_w_subscore1;
			STRING bd_w_subscore2;
			STRING bd_w_subscore3;
			STRING bd_w_subscore4;
			STRING bd_w_subscore5;
			STRING bd_w_subscore6;
			STRING bd_w_subscore7;
			STRING bd_w_subscore8;
			STRING bd_w_subscore9;
			STRING bd_w_subscore10;
			STRING bd_w_subscore11;
			STRING bd_w_subscore12;
			STRING bd_w_subscore13;
			STRING bd_w_subscore14;
			STRING bd_w_subscore15;
			STRING bd_w_subscore16;
			STRING bd_w_subscore17;
			STRING bd_w_subscore18;
			STRING bd_w_rawscore;
			STRING bd_w_lnoddsscore;
			STRING csdp_subscore0;
			STRING csdp_subscore1;
			STRING csdp_subscore2;
			STRING csdp_subscore3;
			STRING csdp_subscore4;
			STRING csdp_subscore5;
			STRING csdp_subscore6;
			STRING csdp_subscore7;
			STRING csdp_subscore8;
			STRING csdp_subscore9;
			STRING csdp_subscore10;
			STRING csdp_subscore11;
			STRING csdp_rawscore;
			STRING csdp_lnoddsscore;
			STRING csdw_subscore0;
			STRING csdw_subscore1;
			STRING csdw_subscore2;
			STRING csdw_subscore3;
			STRING csdw_subscore4;
			STRING csdw_subscore5;
			STRING csdw_subscore6;
			STRING csdw_subscore7;
			STRING csdw_subscore8;
			STRING csdw_subscore9;
			STRING csdw_subscore10;
			STRING csdw_subscore11;
			STRING csdw_subscore12;
			STRING csdw_subscore13;
			STRING csdw_rawscore;
			STRING csdw_lnoddsscore;
			STRING cssp_subscore0;
			STRING cssp_subscore1;
			STRING cssp_subscore2;
			STRING cssp_subscore3;
			STRING cssp_subscore4;
			STRING cssp_subscore5;
			STRING cssp_subscore6;
			STRING cssp_subscore7;
			STRING cssp_subscore8;
			STRING cssp_subscore9;
			STRING cssp_subscore10;
			STRING cssp_subscore11;
			STRING cssp_rawscore;
			STRING cssp_lnoddsscore;
			STRING cssw_subscore0;
			STRING cssw_subscore1;
			STRING cssw_subscore2;
			STRING cssw_subscore3;
			STRING cssw_subscore4;
			STRING cssw_subscore5;
			STRING cssw_subscore6;
			STRING cssw_subscore7;
			STRING cssw_subscore8;
			STRING cssw_subscore9;
			STRING cssw_subscore10;
			STRING cssw_subscore11;
			STRING cssw_subscore12;
			STRING cssw_subscore13;
			STRING cssw_subscore14;
			STRING cssw_subscore15;
			STRING cssw_subscore16;
			STRING cssw_subscore17;
			STRING cssw_rawscore;
			STRING cssw_lnoddsscore;
			STRING cddp_subscore0;
			STRING cddp_subscore1;
			STRING cddp_subscore2;
			STRING cddp_subscore3;
			STRING cddp_subscore4;
			STRING cddp_subscore5;
			STRING cddp_subscore6;
			STRING cddp_subscore7;
			STRING cddp_subscore8;
			STRING cddp_subscore9;
			STRING cddp_subscore10;
			STRING cddp_subscore11;
			STRING cddp_subscore12;
			STRING cddp_subscore13;
			STRING cddp_subscore14;
			STRING cddp_rawscore;
			STRING cddp_lnoddsscore;
			STRING cddw_subscore0;
			STRING cddw_subscore1;
			STRING cddw_subscore2;
			STRING cddw_subscore3;
			STRING cddw_subscore4;
			STRING cddw_subscore5;
			STRING cddw_subscore6;
			STRING cddw_subscore7;
			STRING cddw_subscore8;
			STRING cddw_subscore9;
			STRING cddw_subscore10;
			STRING cddw_subscore11;
			STRING cddw_subscore12;
			STRING cddw_subscore13;
			STRING cddw_subscore14;
			STRING cddw_subscore15;
			STRING cddw_subscore16;
			STRING cddw_subscore17;
			STRING cddw_subscore18;
			STRING cddw_subscore19;
			STRING cddw_subscore20;
			STRING cddw_subscore21;
			STRING cddw_subscore22;
			STRING cddw_subscore23;
			STRING cddw_subscore24;
			STRING cddw_rawscore;
			STRING cddw_lnoddsscore;
			STRING cdsp_subscore0;
			STRING cdsp_subscore1;
			STRING cdsp_subscore2;
			STRING cdsp_subscore3;
			STRING cdsp_subscore4;
			STRING cdsp_subscore5;
			STRING cdsp_subscore6;
			STRING cdsp_subscore7;
			STRING cdsp_subscore8;
			STRING cdsp_subscore9;
			STRING cdsp_subscore10;
			STRING cdsp_subscore11;
			STRING cdsp_subscore12;
			STRING cdsp_subscore13;
			STRING cdsp_subscore14;
			STRING cdsp_rawscore;
			STRING cdsp_lnoddsscore;
			STRING cdsw_subscore0;
			STRING cdsw_subscore1;
			STRING cdsw_subscore2;
			STRING cdsw_subscore3;
			STRING cdsw_subscore4;
			STRING cdsw_subscore5;
			STRING cdsw_subscore6;
			STRING cdsw_subscore7;
			STRING cdsw_subscore8;
			STRING cdsw_subscore9;
			STRING cdsw_subscore10;
			STRING cdsw_subscore11;
			STRING cdsw_subscore12;
			STRING cdsw_subscore13;
			STRING cdsw_subscore14;
			STRING cdsw_subscore15;
			STRING cdsw_subscore16;
			STRING cdsw_subscore17;
			STRING cdsw_subscore18;
			STRING cdsw_rawscore;
			STRING cdsw_lnoddsscore;
			STRING cdop_subscore0;
			STRING cdop_subscore1;
			STRING cdop_subscore2;
			STRING cdop_subscore3;
			STRING cdop_subscore4;
			STRING cdop_subscore5;
			STRING cdop_subscore6;
			STRING cdop_subscore8;
			STRING cdop_subscore9;
			STRING cdop_subscore10;
			STRING cdop_subscore11;
			STRING cdop_subscore12;
			STRING cdop_subscore13;
			STRING cdop_subscore14;
			STRING cdop_subscore15;
			STRING cdop_subscore16;
			STRING cdop_rawscore;
			STRING cdop_lnoddsscore;
			STRING cdow_subscore0;
			STRING cdow_subscore1;
			STRING cdow_subscore2;
			STRING cdow_subscore3;
			STRING cdow_subscore4;
			STRING cdow_subscore5;
			STRING cdow_subscore6;
			STRING cdow_subscore7;
			STRING cdow_subscore8;
			STRING cdow_subscore9;
			STRING cdow_subscore10;
			STRING cdow_subscore11;
			STRING cdow_subscore12;
			STRING cdow_subscore13;
			STRING cdow_subscore14;
			STRING cdow_subscore15;
			STRING cdow_subscore16;
			STRING cdow_subscore17;
			STRING cdow_subscore18;
			STRING cdow_subscore19;
			STRING cdow_subscore20;
			STRING cdow_rawscore;
			STRING cdow_lnoddsscore;
			STRING final_model_lnodds;
			STRING base;
			STRING points;
			STRING odds;
			STRING dell_custom_model;
			STRING cdn1205_1_0;
			STRING attr_segment;
			STRING attr_relation;
			STRING cdn1205_1_0_custom_attribute;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
		END;
		Layout_Debug doModel(with_census le, biid rt) := TRANSFORM
		
	#else
		Layout_ModelOut doModel( with_census le, biid rt ) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	inp_customer_create_date         := le.cd2i.orderdate;
	inp_pay_code_1                   := le.cd2i.pymtmethod;
	inp_avs_response_code            := le.cd2i.avscode;
	inp_cid_response_code            := le.cd2i.cidcode;
	inp_local_ship_code              := le.cd2i.shipmode;
	inp_order_amt                    := trim(le.cd2i.orderamt);
	inp_us_business_consumer_flag    := le.cd2i.ordertype;
	inp_product_desc                 := le.cd2i.prodcode;
			
	_state                           := le.bs.ip2o.state;
	efirstscore                      := le.bs.eddo.efirstscore;
	elastscore                       := le.bs.eddo.elastscore;
	continent                        := le.bs.ip2o.continent;
	ipaddr                           := le.bs.ip2o.ipaddr;
	topleveldomain                   := le.bs.ip2o.topleveldomain;
	iproutingmethod                  := le.bs.ip2o.iproutingmethod;
	areacode                         := le.bs.ip2o.areacode;
	ipdma                            := trim(le.bs.ip2o.ipdma);
	distaddraddr2                    := le.bs.eddo.distaddraddr2;
	btst_are_relatives               := le.bs.eddo.btst_are_relatives;
	btst_relatives_in_common         := le.bs.eddo.btst_relatives_in_common;
	latitude                         := le.bs.ip2o.latitude;
	longitude                        := le.bs.ip2o.longitude;
	distphoneaddr                    := le.bs.eddo.distphoneaddr;
	distphone2addr2                  := le.bs.eddo.distphone2addr2;
	distaddrphone2                   := le.bs.eddo.distaddrphone2;
	addrscore                        := le.bs.eddo.addrscore;
	firstscore                       := le.bs.eddo.firstscore;
	lastscore                        := le.bs.eddo.lastscore;
	did                              := le.bs.Bill_To_Out.did;
	truedid                          := le.bs.Bill_To_Out.truedid;
	out_unit_desig                   := le.bs.Bill_To_Out.shell_input.unit_desig;
	out_sec_range                    := le.bs.Bill_To_Out.shell_input.sec_range;
	out_st                           := le.bs.Bill_To_Out.shell_input.st;
	out_z5                           := le.bs.Bill_To_Out.shell_input.z5;
	out_lat                          := le.bs.Bill_To_Out.shell_input.lat;
	out_long                         := le.bs.Bill_To_Out.shell_input.long;
	out_addr_type                    := le.bs.Bill_To_Out.shell_input.addr_type;
	in_email_address                 := le.bs.Bill_To_Out.shell_input.email_address;
	in_ip_address                    := le.bs.Bill_To_Out.shell_input.ip_address;
	in_phone10                       := le.bs.Bill_To_Out.shell_input.phone10;
	nap_summary                      := le.bs.Bill_To_Out.iid.nap_summary;
	rc_phonevalflag                  := le.bs.Bill_To_Out.iid.phonevalflag;
	rc_hphonevalflag                 := le.bs.Bill_To_Out.iid.hphonevalflag;
	rc_phonezipflag                  := le.bs.Bill_To_Out.iid.phonezipflag;
	rc_pwphonezipflag                := le.bs.Bill_To_Out.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.bs.Bill_To_Out.iid.hriskaddrflag;
	rc_dwelltype                     := le.bs.Bill_To_Out.iid.dwelltype;
	rc_addrcount                     := le.bs.Bill_To_Out.iid.addrcount;
	rc_phoneaddrcount                := le.bs.Bill_To_Out.iid.phoneaddrcount;
	rc_phoneaddr_addrcount           := le.bs.Bill_To_Out.iid.phoneaddr_addrcount;
	rc_hphonemiskeyflag              := le.bs.Bill_To_Out.iid.hphonemiskeyflag;
	bus_phone_match                  := le.bs.Bill_To_Out.business_header_address_summary.bus_phone_match;
	lnamepop                         := le.bs.Bill_To_Out.input_validation.lastname;
	addrpop                          := le.bs.Bill_To_Out.input_validation.address;
	hphnpop                          := le.bs.Bill_To_Out.input_validation.homephone;
	lname_eda_sourced_type           := le.bs.Bill_To_Out.name_verification.lname_eda_sourced_type;
	// util_add1_type_list              := le.bs.Bill_To_Out.utility.utili_addr1_type;
	add1_lres                        := le.bs.Bill_To_Out.lres;
	add1_advo_res_or_business        := le.bs.Bill_To_Out.advo_input_addr.residential_or_business_ind;
	add1_applicant_owned             := le.bs.Bill_To_Out.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.bs.Bill_To_Out.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.bs.Bill_To_Out.address_verification.input_address_information.family_owned;
	add1_date_first_seen             := le.bs.Bill_To_Out.address_verification.input_address_information.date_first_seen;
	add1_pop                         := le.bs.Bill_To_Out.addrpop;
	adls_per_addr                    := le.bs.Bill_To_Out.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.bs.Bill_To_Out.velocity_counters.ssns_per_addr;
	inq_highriskcredit_count         := le.bs.Bill_To_Out.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.bs.Bill_To_Out.acc_logs.highriskcredit.count24;
	inq_retail_count                 := le.bs.Bill_To_Out.acc_logs.retail.counttotal;
	inq_retail_count01               := le.bs.Bill_To_Out.acc_logs.retail.count01;
	inq_retail_count03               := le.bs.Bill_To_Out.acc_logs.retail.count03;
	inq_retail_count06               := le.bs.Bill_To_Out.acc_logs.retail.count06;
	inq_retail_count12               := le.bs.Bill_To_Out.acc_logs.retail.count12;
	inq_retail_count24               := le.bs.Bill_To_Out.acc_logs.retail.count24;
	inq_adlsperaddr                  := le.bs.Bill_To_Out.acc_logs.inquiryadlsperaddr;
	paw_first_seen                   := le.bs.Bill_To_Out.employment.first_seen_date;
	paw_source_count                 := le.bs.Bill_To_Out.employment.source_ct;
	infutor_nap                      := le.bs.Bill_To_Out.infutor_phone.infutor_nap;
	wealth_index                     := le.bs.Bill_To_Out.wealth_indicator;
	archive_date                     := IF(le.bs.Bill_To_Out.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.bs.Bill_To_Out.historydate)[1..6]);
	did_s                            := le.bs.Ship_To_Out.did;
	truedid_s                        := le.bs.Ship_To_Out.truedid;
	out_unit_desig_s                 := le.bs.Ship_To_Out.shell_input.unit_desig;
	out_sec_range_s                  := le.bs.Ship_To_Out.shell_input.sec_range;
	out_z5_s                         := le.bs.Ship_To_Out.shell_input.z5;
	out_addr_type_s                  := le.bs.Ship_To_Out.shell_input.addr_type;
	nap_summary_s                    := le.bs.Ship_To_Out.iid.nap_summary;
	cvi_s                            := le.bs.Ship_To_Out.iid.cvi;
	rc_hriskphoneflag_s              := le.bs.Ship_To_Out.iid.hriskphoneflag;
	rc_hphonetypeflag_s              := le.bs.Ship_To_Out.iid.hphonetypeflag;
	rc_phonevalflag_s                := le.bs.Ship_To_Out.iid.phonevalflag;
	rc_hphonevalflag_s               := le.bs.Ship_To_Out.iid.hphonevalflag;
	rc_phonezipflag_s                := le.bs.Ship_To_Out.iid.phonezipflag;
	rc_pwphonezipflag_s              := le.bs.Ship_To_Out.iid.pwphonezipflag;
	rc_dwelltype_s                   := le.bs.Ship_To_Out.iid.dwelltype;
	rc_addrcount_s                   := le.bs.Ship_To_Out.iid.addrcount;
	rc_phoneaddrcount_s              := le.bs.Ship_To_Out.iid.phoneaddrcount;
	rc_phoneaddr_addrcount_s         := le.bs.Ship_To_Out.iid.phoneaddr_addrcount;
	ver_sources_s                    := le.bs.Ship_To_Out.header_summary.ver_sources;
	ver_sources_first_seen_s         := le.bs.Ship_To_Out.header_summary.ver_sources_first_seen_date;
	bus_name_match_s                 := le.bs.Ship_To_Out.business_header_address_summary.bus_name_match;
	bus_phone_match_s                := le.bs.Ship_To_Out.business_header_address_summary.bus_phone_match;
	fnamepop_s                       := le.bs.Ship_To_Out.input_validation.firstname;
	lnamepop_s                       := le.bs.Ship_To_Out.input_validation.lastname;
	addrpop_s                        := le.bs.Ship_To_Out.input_validation.address;
	ssnlength_s                      := le.bs.Ship_To_Out.input_validation.ssn_length;
	hphnpop_s                        := le.bs.Ship_To_Out.input_validation.homephone;
	source_count_s                   := le.bs.Ship_To_Out.name_verification.source_count;
	fname_eda_sourced_type_s         := le.bs.Ship_To_Out.name_verification.fname_eda_sourced_type;
	lname_eda_sourced_type_s         := le.bs.Ship_To_Out.name_verification.lname_eda_sourced_type;
	// util_add1_type_list_s            := le.bs.Ship_To_Out.utility.utili_addr1_type;
	add1_advo_res_or_business_s      := le.bs.Ship_To_Out.advo_input_addr.residential_or_business_ind;
	add1_eda_sourced_s               := le.bs.Ship_To_Out.address_verification.input_address_information.eda_sourced;
	add1_applicant_owned_s           := le.bs.Ship_To_Out.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned_s            := le.bs.Ship_To_Out.address_verification.input_address_information.occupant_owned;
	add1_family_owned_s              := le.bs.Ship_To_Out.address_verification.input_address_information.family_owned;
	add1_naprop_s                    := le.bs.Ship_To_Out.address_verification.input_address_information.naprop;
	add1_pop_s                       := le.bs.Ship_To_Out.addrpop;
	adls_per_addr_s                  := le.bs.Ship_To_Out.velocity_counters.adls_per_addr;
	ssns_per_addr_s                  := le.bs.Ship_To_Out.velocity_counters.ssns_per_addr;
	phones_per_addr_s                := le.bs.Ship_To_Out.velocity_counters.phones_per_addr;
	adls_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6_s               := le.bs.Ship_To_Out.velocity_counters.ssns_per_addr_created_6months;
	inq_collection_count_s           := le.bs.Ship_To_Out.acc_logs.collection.counttotal;
	inq_collection_count01_s         := le.bs.Ship_To_Out.acc_logs.collection.count01;
	inq_collection_count03_s         := le.bs.Ship_To_Out.acc_logs.collection.count03;
	inq_collection_count06_s         := le.bs.Ship_To_Out.acc_logs.collection.count06;
	inq_collection_count12_s         := le.bs.Ship_To_Out.acc_logs.collection.count12;
	inq_collection_count24_s         := le.bs.Ship_To_Out.acc_logs.collection.count24;
	inq_highriskcredit_count_s       := le.bs.Ship_To_Out.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24_s     := le.bs.Ship_To_Out.acc_logs.highriskcredit.count24;
	inq_adlsperaddr_s                := le.bs.Ship_To_Out.acc_logs.inquiryadlsperaddr;
	inq_ssnsperaddr_s                := le.bs.Ship_To_Out.acc_logs.inquiryssnsperaddr;
	paw_source_count_s               := le.bs.Ship_To_Out.employment.source_ct;
	infutor_nap_s                    := le.bs.Ship_To_Out.infutor_phone.infutor_nap;
	impulse_first_seen_s             := le.bs.Ship_To_Out.impulse.first_seen_date;
	email_domain_free_count_s        := le.bs.Ship_To_Out.email_summary.email_domain_free_ct;
	attr_total_number_derogs_s       := le.bs.Ship_To_Out.total_number_derogs;
	attr_num_nonderogs_s             := le.bs.Ship_To_Out.source_verification.num_nonderogs;
	liens_recent_unreleased_count_s  := le.bs.Ship_To_Out.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct_s := le.bs.Ship_To_Out.bjl.liens_historical_unreleased_count;
	rel_count_s                      := le.bs.Ship_To_Out.relatives.relative_count;
	rel_bankrupt_count_s             := le.bs.Ship_To_Out.relatives.relative_bankrupt_count;
	rel_criminal_count_s             := le.bs.Ship_To_Out.relatives.relative_criminal_count;
	rel_felony_count_s               := le.bs.Ship_To_Out.relatives.relative_felony_count;
	rel_within25miles_count_s        := le.bs.Ship_To_Out.relatives.relative_within25miles_count;
	rel_within100miles_count_s       := le.bs.Ship_To_Out.relatives.relative_within100miles_count;
	rel_within500miles_count_s       := le.bs.Ship_To_Out.relatives.relative_within500miles_count;
	rel_withinother_count_s          := le.bs.Ship_To_Out.relatives.relative_withinother_count;
	rel_incomeunder25_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeunder25_count;
	rel_incomeunder50_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count_s       := le.bs.Ship_To_Out.relatives.relative_incomeunder100_count;
	rel_incomeover100_count_s        := le.bs.Ship_To_Out.relatives.relative_incomeover100_count;
	rel_educationunder8_count_s      := le.bs.Ship_To_Out.relatives.relative_educationunder8_count;
	rel_educationunder12_count_s     := le.bs.Ship_To_Out.relatives.relative_educationunder12_count;
	rel_educationover12_count_s      := le.bs.Ship_To_Out.relatives.relative_educationover12_count;
	wealth_index_s                   := le.bs.Ship_To_Out.wealth_indicator;
	
	c_BEL_EDU                        := le.easi.bel_edu;
	c_FAMMAR_P                       := le.easi.fammar_p;
	c_FAMMAR_P_s                     := le.easi2.fammar_p;
	c_FAMOTF18_P                     := le.easi.famotf18_p;
	c_HHSIZE                         := le.easi.hhsize;
	c_HHSIZE_s                       := le.easi2.hhsize;
	c_HIGH_ED_s                      := le.easi2.high_ed;
	c_MED_INC_s                      := le.easi2.med_inc;
	c_SPAN_LANG                      := le.easi.span_lang;
	c_SPAN_LANG_s                    := le.easi2.span_lang;

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	sysdate_1 := common.sas_date(if(le.bs.Bill_To_Out.historydate=999999, (string)ut.getdate, (string6)le.bs.Bill_To_Out.historydate+'01'));
	
	sysdate := Common.SAS_Date((STRING)(archive_date));
	
	state := _state;
	
	inp_customer_create_date_patched := if(inp_customer_create_date = '19000100', null,  models.common.SAS_Date(inp_customer_create_date) );
	
	pf_wks_since_create_date_calc := ((sysdate - inp_customer_create_date_patched)) / (365.25 /(365.25/7));
	
	pf_wks_since_create_date := if(min(sysdate, inp_customer_create_date_patched) = NULL, NULL, 
		if (pf_wks_since_create_date_calc >= 0, roundup(pf_wks_since_create_date_calc), truncate(pf_wks_since_create_date_calc)) );
	
	pf_pmt_type := map(
	    inp_pay_code_1 = 'A' => 'American Express',
	    inp_pay_code_1 = 'C' => 'Diners Club     ',
	    inp_pay_code_1 = 'D' => 'Discover        ',
	    inp_pay_code_1 = 'M' => 'Mastercard      ',
	    inp_pay_code_1 = 'O' => 'Credit Terms    ',
	    inp_pay_code_1 = 'P' => 'Prepaid Check   ',
	    inp_pay_code_1 = 'R' => 'Dell Credit Card',
	    inp_pay_code_1 = 'V' => 'Visa            ',
	    inp_pay_code_1 = '8' => 'Gift Card       ',
	                            'Other');
	
	pf_avs_addr := (inp_avs_response_code in ['A', 'O', 'Y', 'M']);
	
	pf_avs_zip := (inp_avs_response_code in ['F', 'L', 'M', 'W', 'Y', 'Z']);
	
	pf_avs_name := (inp_avs_response_code in ['K', 'L', 'M', 'O']);
	
	pf_avs_error := (inp_avs_response_code in ['', '**', '+', 'R']);
	
	pf_avs_invalid := (inp_avs_response_code in ['0', 'D', 'E']);
	
	pf_avs_unavail := (inp_avs_response_code in ['U', 'X']);
	
	pf_avs_no_match := (inp_avs_response_code in ['N']);
	
	pf_avs_intl := (inp_avs_response_code in ['G', 'P']);
	
	pf_avs_result := map(
	    pf_avs_addr and pf_avs_zip => 'Full Match   ',
	    pf_avs_addr                => 'Addr Only    ',
	    pf_avs_zip                 => 'Zip Only     ',
	    pf_avs_no_match            => 'No Match     ',
	    pf_avs_intl                => 'International',
	    pf_avs_unavail             => 'Unavailable  ',
	                                  'Error/Inval');
	
	pf_pmt_x_avs_lvl := map(
	    (pf_pmt_type in ['Credit Terms', 'Dell Credit Card', 'Other'])                                   => 8,
	    pf_pmt_type = 'American Express' and pf_avs_result = 'Full Match' and pf_avs_name                => 7,
	    (pf_pmt_type in ['Diners Club', 'Gift Card'])                                                    => 6,
	    pf_pmt_type = 'American Express' and pf_avs_result = 'Full Match'                                => 6,
	    pf_pmt_type = 'American Express' and (pf_avs_result in ['Addr Only', 'Error/Inval', 'Zip Only']) => 6,
	    pf_pmt_type = 'Mastercard' and (pf_avs_result in ['Full Match', 'Unavailable', 'Zip Only'])      => 5,
	    pf_pmt_type = 'Visa' and (pf_avs_result in ['Full Match', 'Zip Only'])                           => 5,
	    pf_pmt_type = 'Discover' and (pf_avs_result in ['Full Match', 'Zip Only'])                       => 4,
	    (pf_pmt_type in ['Visa', 'Mastercard']) and (pf_avs_result in ['Addr Only'])                     => 4,
	    pf_pmt_type = 'Discover' and (pf_avs_result in ['Addr Only', 'Error/Inval'])                     => 3,
	    pf_pmt_type = 'Visa' and (pf_avs_result in ['Error/Inval'])                                      => 3,
	    pf_pmt_type = 'Prepaid Check'                                                                    => 3,
	    (pf_pmt_type in ['Visa', 'Mastercard']) and (pf_avs_result in ['No Match', 'Unavailable'])       => 2,
	    (pf_pmt_type in ['Discover']) and (pf_avs_result in ['Unavailable'])                             => 2,
	    pf_pmt_type = 'Mastercard' and pf_avs_result = 'Error/Inval'                                     => 1,
	    pf_pmt_type = 'American Express' and pf_avs_result = 'No Match'                                  => 1,
	    (pf_avs_result in ['International', 'No Match', 'Unavailable'])                                  => 0,
	                                                                                                        -1);
	
	pf_cid_result := map(
	    (inp_cid_response_code in ['', '**']) => 'Null    ',
	    (inp_cid_response_code in ['I'])      => 'Invalid ',
	    (inp_cid_response_code in ['M', 'Y']) => 'Match   ',
	    (inp_cid_response_code in ['N'])      => 'No Match',
	                                             'Other');
	
	pf_ship_method := map(
	    inp_local_ship_code = '2' => 'Next Day',
	    inp_local_ship_code = '7' => '2nd Day ',
	    inp_local_ship_code = 'E' => '3rd Day ',
	    inp_local_ship_code = 'L' => 'Ground  ',
	                                 'Other');
	
	pf_order_amt_c := min(if(max((real)inp_order_amt, 250) = NULL, -NULL, max((real)inp_order_amt, 250)), 20000);
	
	bt_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';
	
	st_add_apt := StringLib.StringToUpperCase(trim((string)rc_dwelltype_s, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim((string)out_addr_type_s, LEFT, RIGHT)) = 'H' or out_unit_desig_s != ' ' or out_sec_range_s != ' ';
	
	bt_bus_phone_match := if(not(add1_pop), NULL, bus_phone_match);
	
	bt_phn_miskey := if(not(truedid and (hphnpop or addrpop)), NULL, if(rc_hphonemiskeyflag, 1, 0));
	
	bt_valid_phone := map(
	    not(hphnpop)                                                 => '             ',
	    rc_phonevalflag = '0' or rc_hphonevalflag = '0'                  => 'Invalid Phn  ',
	    rc_phonevalflag = '1' or rc_hphonevalflag = '1'                  => 'Valid Bus Phn',
	    rc_phonevalflag = '3' or (rc_hphonevalflag in ['3', '4', '5']) => 'Valid Oth Phn',
	    rc_phonevalflag = '2' or rc_hphonevalflag = '2'                  => 'Valid Res Phn',
	                                                                    '             ');
	
	bt_phone_zip_match := map(
	    not(hphnpop and not((integer)out_z5 = NULL))          => '           ',
	    (integer)rc_phonezipflag = 1 or (integer)rc_pwphonezipflag = 1 => 'Mismatch   ',
	    (rc_pwphonezipflag in ['2', '4'])            => 'Not Issued ',
	    (integer)rc_phonezipflag = 0 or (integer)rc_pwphonezipflag = 0 => 'No Mismatch',
	                                                    '           ');
	
	bt_hriskaddrflag := map(
	    not(add1_pop)           => '             ',
	    (integer)rc_hriskaddrflag = NULL => '           -1',
	    (integer)rc_hriskaddrflag = 0    => 'Not High Risk',
	    (integer)rc_hriskaddrflag = 1    => 'PO Box Only  ',
	    (integer)rc_hriskaddrflag = 2    => 'Corp Zip Code',
	    (integer)rc_hriskaddrflag = 3    => 'Military Zip ',
	    (integer)rc_hriskaddrflag = 4    => 'HR Commercial',
	                               'Addr Empty   ');
	
	// bt_add1_util_pots := if(not(add1_pop), NULL, 
// if(stringlib.stringfind(util_add1_type_list, 'D', 1) > 0 
// or stringlib.stringfind(util_add1_type_list, 'F', 1) > 0
// or stringlib.stringfind(util_add1_type_list, 'T', 1) > 0,
// 1, 0) );
	
	bt_inp_addr_res_or_business := map(
	    not(add1_pop)                    => '  ',
	    add1_advo_res_or_business = '' => '-1',
	                                        add1_advo_res_or_business);
	
	bt_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));
	
	_paw_first_seen := Common.SAS_Date((STRING)(paw_first_seen));
	
	bt_mos_since_paw_first_seen_calc := (sysdate - _paw_first_seen) / (365.25 / 12);
	
	bt_mos_since_paw_first_seen := map(
	    not(truedid)                => NULL,
	    not(_paw_first_seen = NULL) => if (bt_mos_since_paw_first_seen_calc >= 0, 
														truncate(bt_mos_since_paw_first_seen_calc), 
														roundup(bt_mos_since_paw_first_seen_calc) ),
	     -1);		
	
	bt_inq_retail_recency := map(
	    not(truedid)       => NULL,
	    inq_retail_count01 > 0 => 1,
	    inq_retail_count03 > 0 => 3,
	    inq_retail_count06 > 0 => 6,
	    inq_retail_count12 > 0 => 12,
	    inq_retail_count24 > 0 => 24,
	    inq_retail_count > 0   => 99,
	                          0);
	
	bt_paw_source_count := if(not(truedid), NULL, paw_source_count);
	
	st_bus_phone_match := if(not((boolean)(integer)add1_pop_s), NULL, bus_phone_match_s);
	
	st_phone_zip_match := map(
	    not((boolean)(integer)hphnpop_s and not((integer)out_z5_s = NULL)) => '           ',
	    rc_phonezipflag_s = '1' or rc_pwphonezipflag_s = '1'          => 'Mismatch   ',
	    (rc_pwphonezipflag_s in ['2', '4'])                           => 'Not Issued ',
	    rc_phonezipflag_s = '0' or rc_pwphonezipflag_s = '0'          => 'No Mismatch',
	                                                                 '           ');
	
	st_inp_addr_res_or_business := map(
	    not((boolean)(integer)add1_pop_s)  => '  ',
	    add1_advo_res_or_business_s = '' => '-1',
	                                          add1_advo_res_or_business_s);
	
	st_paw_source_count := if(not((boolean)(integer)truedid_s), NULL, paw_source_count_s);
	
	st_bus_name_match := if(not((boolean)(integer)add1_pop_s), NULL, bus_name_match_s);
	
	st_valid_phone := map(
	    not((boolean)(integer)hphnpop_s)                           => '             ',
	    rc_phonevalflag_s = '0' or rc_hphonevalflag_s = '0'            => 'Invalid Phn  ',
	    rc_phonevalflag_s = '1' or rc_hphonevalflag_s = '1'            => 'Valid Bus Phn',
	    rc_phonevalflag_s = '3' or (rc_hphonevalflag_s in ['3', '4', '5']) => 'Valid Oth Phn',
	    rc_phonevalflag_s = '2' or rc_hphonevalflag_s = '2'            => 'Valid Res Phn',
	                                                                  '             ');
	
	st_inq_highriskcredit_recency := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    inq_highRiskCredit_count01_s > 0     => 1,
	    inq_highRiskCredit_count03_s > 0    => 3,
	    inq_highRiskCredit_count06_s > 0     => 6,
	    inq_highRiskCredit_count12_s > 0     => 12,
	    inq_highRiskCredit_count24_s > 0     => 24,
	    inq_highRiskCredit_count_s > 0       => 99,
	                                        0);
	
	bt_cen_hhsize := IF(c_HHSIZE='', NULL, (real)c_HHSIZE);
	
	bt_cen_famotf18_p := IF(c_FAMOTF18_P='', NULL, (real)C_FAMOTF18_P);
	
	bt_inp_addr_ownership_lvl := map(
	    not(add1_pop)        => '            ',
	    add1_applicant_owned => 'Applicant   ',
	    add1_family_owned    => 'Family      ',
	    add1_occupant_owned  => 'Occupant    ',
	                            'No Ownership');
	
	bt_inq_adls_per_addr := if(not(add1_pop), NULL, inq_adlsperaddr);
	
	ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	inf_phn_ver_lvl := map(
	    ver_phn_inf     => 3,
	    infutor_nap = 1 => 1,
	    infutor_nap = 0 => 0,
	                       2);
	
	nap_phn_ver_lvl := map(
	    ver_phn_nap     => 3,
	    nap_summary = 1 => 1,
	    nap_summary = 0 => 0,
	                       2);
	
	bt_nap_phn_ver_x_inf_phn_ver := map(
	    not(addrpop or hphnpop) => '   ',
	    not(hphnpop)            => ' -1',
	                               trim((string)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl, LEFT, RIGHT));
	
	bt_cen_bel_edu := if(c_BEL_EDU='', null, (real)c_BEL_EDU);
	
	bt_lname_eda_sourced_type := map(
	    not((hphnpop or addrpop) and lnamepop) => '  ',
	    trim(lname_eda_sourced_type) = ''          => '-1',
	                                              lname_eda_sourced_type);
	
	inp_addr_date_first_seen := Common.SAS_Date((STRING)(add1_date_first_seen));
	
	bt_mos_since_inp_addr_fseen_calc := (sysdate - inp_addr_date_first_seen) / (365.25 / 12);
	
	bt_mos_since_inp_addr_fseen := map(
	    not(add1_pop)                   => NULL,
	    inp_addr_date_first_seen = NULL => -1,
	    if (bt_mos_since_inp_addr_fseen_calc >= 0, truncate(bt_mos_since_inp_addr_fseen_calc), roundup(bt_mos_since_inp_addr_fseen_calc)) );
	
	bt_infutor_nap := if(not(hphnpop), NULL, infutor_nap);
	
	bt_cen_fammar_p := if(c_FAMMAR_P='', null, (real)c_FAMMAR_P);
	bt_cen_span_lang := if(c_SPAN_LANG='', null, (real)c_SPAN_LANG);
	
	bt_inp_addr_lres := if(not(add1_pop), NULL, add1_lres);
	
	bt_adls_per_sfd_addr := map(
	    not(add1_pop) => NULL,
	    bt_add_apt    => -1,
	                     adls_per_addr);
	
	st_cen_high_ed := if(c_HIGH_ED_s='', null, (real)c_high_ed_s);
	
	st_inq_collection_recency := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    inq_collection_count01_s  >0       => 1,
	    inq_collection_count03_s  >0       => 3,
	    inq_collection_count06_s  >0     => 6,
	    inq_collection_count12_s  >0       => 12,
	    inq_collection_count24_s  >0       => 24,
	    inq_collection_count_s    >0       => 99,
	                                        0);
	
	_impulse_first_seen_s := Common.SAS_Date((STRING)(impulse_first_seen_s));
	
	st_mos_since_impulse_first_seen_calc := (sysdate - _impulse_first_seen_s) / (365.25 / 12);
	st_mos_since_impulse_first_seen := map(
	    not((boolean)(integer)truedid_s)  => NULL,
	    not(_impulse_first_seen_s = NULL) => if (st_mos_since_impulse_first_seen_calc >= 0, truncate(st_mos_since_impulse_first_seen_calc), roundup(st_mos_since_impulse_first_seen_calc)),
	                                         -1);
	
	st_email_domain_free_count := if(not((boolean)(integer)truedid_s), NULL, email_domain_free_count_s);
	
	st_derog_ratio := map(
	    not((boolean)(integer)truedid_s)                            => NULL,
	    attr_num_nonderogs_s = 0 and attr_total_number_derogs_s = 0 => -1,
	    attr_num_nonderogs_s > 0 and attr_total_number_derogs_s = 0 => 100 + 10 * min(if(attr_num_nonderogs_s = NULL, -NULL, attr_num_nonderogs_s), 10),
	                                                                   if (attr_total_number_derogs_s / if(max(attr_num_nonderogs_s, attr_total_number_derogs_s) = NULL, NULL, sum(if(attr_num_nonderogs_s = NULL, 0, attr_num_nonderogs_s), if(attr_total_number_derogs_s = NULL, 0, attr_total_number_derogs_s))) * 10 >= 0, roundup(attr_total_number_derogs_s / if(max(attr_num_nonderogs_s, attr_total_number_derogs_s) = NULL, NULL, sum(if(attr_num_nonderogs_s = NULL, 0, attr_num_nonderogs_s), if(attr_total_number_derogs_s = NULL, 0, attr_total_number_derogs_s))) * 10), truncate(attr_total_number_derogs_s / if(max(attr_num_nonderogs_s, attr_total_number_derogs_s) = NULL, NULL, sum(if(attr_num_nonderogs_s = NULL, 0, attr_num_nonderogs_s), if(attr_total_number_derogs_s = NULL, 0, attr_total_number_derogs_s))) * 10)) * 10);
	
	st_average_rel_income := map(
	    not((boolean)(integer)truedid_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            => NULL,
	    rel_count_s = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             => -1,
	    if(max(rel_incomeunder25_count_s, rel_incomeunder50_count_s, rel_incomeunder75_count_s, rel_incomeunder100_count_s, rel_incomeover100_count_s) = NULL, NULL, sum(if(rel_incomeunder25_count_s = NULL, 0, rel_incomeunder25_count_s), if(rel_incomeunder50_count_s = NULL, 0, rel_incomeunder50_count_s), if(rel_incomeunder75_count_s = NULL, 0, rel_incomeunder75_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s), if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   if (if(max(rel_incomeunder25_count_s * 25, rel_incomeunder50_count_s * 50, rel_incomeunder75_count_s * 75, rel_incomeunder100_count_s * 100, rel_incomeover100_count_s * 125) = NULL, NULL, sum(if(rel_incomeunder25_count_s * 25 = NULL, 0, rel_incomeunder25_count_s * 25), if(rel_incomeunder50_count_s * 50 = NULL, 0, rel_incomeunder50_count_s * 50), if(rel_incomeunder75_count_s * 75 = NULL, 0, rel_incomeunder75_count_s * 75), if(rel_incomeunder100_count_s * 100 = NULL, 0, rel_incomeunder100_count_s * 100), if(rel_incomeover100_count_s * 125 = NULL, 0, rel_incomeover100_count_s * 125))) / if(max(rel_incomeunder25_count_s, rel_incomeunder50_count_s, rel_incomeunder75_count_s, rel_incomeunder100_count_s, rel_incomeover100_count_s) = NULL, NULL, sum(if(rel_incomeunder25_count_s = NULL, 0, rel_incomeunder25_count_s), if(rel_incomeunder50_count_s = NULL, 0, rel_incomeunder50_count_s), if(rel_incomeunder75_count_s = NULL, 0, rel_incomeunder75_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s), if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s))) >= 0, truncate(if(max(rel_incomeunder25_count_s * 25, rel_incomeunder50_count_s * 50, rel_incomeunder75_count_s * 75, rel_incomeunder100_count_s * 100, rel_incomeover100_count_s * 125) = NULL, NULL, sum(if(rel_incomeunder25_count_s * 25 = NULL, 0, rel_incomeunder25_count_s * 25), if(rel_incomeunder50_count_s * 50 = NULL, 0, rel_incomeunder50_count_s * 50), if(rel_incomeunder75_count_s * 75 = NULL, 0, rel_incomeunder75_count_s * 75), if(rel_incomeunder100_count_s * 100 = NULL, 0, rel_incomeunder100_count_s * 100), if(rel_incomeover100_count_s * 125 = NULL, 0, rel_incomeover100_count_s * 125))) / if(max(rel_incomeunder25_count_s, rel_incomeunder50_count_s, rel_incomeunder75_count_s, rel_incomeunder100_count_s, rel_incomeover100_count_s) = NULL, NULL, sum(if(rel_incomeunder25_count_s = NULL, 0, rel_incomeunder25_count_s), if(rel_incomeunder50_count_s = NULL, 0, rel_incomeunder50_count_s), if(rel_incomeunder75_count_s = NULL, 0, rel_incomeunder75_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s), if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s)))), roundup(if(max(rel_incomeunder25_count_s * 25, rel_incomeunder50_count_s * 50, rel_incomeunder75_count_s * 75, rel_incomeunder100_count_s * 100, rel_incomeover100_count_s * 125) = NULL, NULL, sum(if(rel_incomeunder25_count_s * 25 = NULL, 0, rel_incomeunder25_count_s * 25), if(rel_incomeunder50_count_s * 50 = NULL, 0, rel_incomeunder50_count_s * 50), if(rel_incomeunder75_count_s * 75 = NULL, 0, rel_incomeunder75_count_s * 75), if(rel_incomeunder100_count_s * 100 = NULL, 0, rel_incomeunder100_count_s * 100), if(rel_incomeover100_count_s * 125 = NULL, 0, rel_incomeover100_count_s * 125))) / if(max(rel_incomeunder25_count_s, rel_incomeunder50_count_s, rel_incomeunder75_count_s, rel_incomeunder100_count_s, rel_incomeover100_count_s) = NULL, NULL, sum(if(rel_incomeunder25_count_s = NULL, 0, rel_incomeunder25_count_s), if(rel_incomeunder50_count_s = NULL, 0, rel_incomeunder50_count_s), if(rel_incomeunder75_count_s = NULL, 0, rel_incomeunder75_count_s), if(rel_incomeunder100_count_s = NULL, 0, rel_incomeunder100_count_s), if(rel_incomeover100_count_s = NULL, 0, rel_incomeover100_count_s))))) * 1000);
	
	bt_inq_retail_count12 := if(not(truedid), NULL, inq_retail_count12);
	
	st_max_ids_per_addr := if(not((boolean)(integer)add1_pop_s), NULL, max(adls_per_addr_s, ssns_per_addr_s));
	
	st_inq_ssns_per_addr := if(not((boolean)(integer)add1_pop_s), NULL, inq_ssnsperaddr_s);
	
	st_unreleased_liens_ct := if(not((boolean)(integer)truedid_s), NULL, if(max(liens_recent_unreleased_count_s, liens_historical_unreleased_ct_s) = NULL, NULL, sum(if(liens_recent_unreleased_count_s = NULL, 0, liens_recent_unreleased_count_s), if(liens_historical_unreleased_ct_s = NULL, 0, liens_historical_unreleased_ct_s))));
	
	st_average_rel_education := map(
	    not((boolean)(integer)truedid_s)                                                                                                                                                                                                                                                                                                                => NULL,
	    rel_count_s = 0                                                                                                                                                                                                                                                                                                                                 => -1,
	    if(max(rel_educationunder8_count_s, rel_educationunder12_count_s, rel_educationover12_count_s) = NULL, NULL, sum(if(rel_educationunder8_count_s = NULL, 0, rel_educationunder8_count_s), if(rel_educationunder12_count_s = NULL, 0, rel_educationunder12_count_s), if(rel_educationover12_count_s = NULL, 0, rel_educationover12_count_s))) = 0 => 0,
	                                                                                                                                                                                                                                                                                                                                                       if (if(max(rel_educationunder8_count_s * 8, rel_educationunder12_count_s * 12, rel_educationover12_count_s * 16) = NULL, NULL, sum(if(rel_educationunder8_count_s * 8 = NULL, 0, rel_educationunder8_count_s * 8), if(rel_educationunder12_count_s * 12 = NULL, 0, rel_educationunder12_count_s * 12), if(rel_educationover12_count_s * 16 = NULL, 0, rel_educationover12_count_s * 16))) / if(max(rel_educationunder8_count_s, rel_educationunder12_count_s, rel_educationover12_count_s) = NULL, NULL, sum(if(rel_educationunder8_count_s = NULL, 0, rel_educationunder8_count_s), if(rel_educationunder12_count_s = NULL, 0, rel_educationunder12_count_s), if(rel_educationover12_count_s = NULL, 0, rel_educationover12_count_s))) >= 0, truncate(if(max(rel_educationunder8_count_s * 8, rel_educationunder12_count_s * 12, rel_educationover12_count_s * 16) = NULL, NULL, sum(if(rel_educationunder8_count_s * 8 = NULL, 0, rel_educationunder8_count_s * 8), if(rel_educationunder12_count_s * 12 = NULL, 0, rel_educationunder12_count_s * 12), if(rel_educationover12_count_s * 16 = NULL, 0, rel_educationover12_count_s * 16))) / if(max(rel_educationunder8_count_s, rel_educationunder12_count_s, rel_educationover12_count_s) = NULL, NULL, sum(if(rel_educationunder8_count_s = NULL, 0, rel_educationunder8_count_s), if(rel_educationunder12_count_s = NULL, 0, rel_educationunder12_count_s), if(rel_educationover12_count_s = NULL, 0, rel_educationover12_count_s)))), roundup(if(max(rel_educationunder8_count_s * 8, rel_educationunder12_count_s * 12, rel_educationover12_count_s * 16) = NULL, NULL, sum(if(rel_educationunder8_count_s * 8 = NULL, 0, rel_educationunder8_count_s * 8), if(rel_educationunder12_count_s * 12 = NULL, 0, rel_educationunder12_count_s * 12), if(rel_educationover12_count_s * 16 = NULL, 0, rel_educationover12_count_s * 16))) / if(max(rel_educationunder8_count_s, rel_educationunder12_count_s, rel_educationover12_count_s) = NULL, NULL, sum(if(rel_educationunder8_count_s = NULL, 0, rel_educationunder8_count_s), if(rel_educationunder12_count_s = NULL, 0, rel_educationunder12_count_s), if(rel_educationover12_count_s = NULL, 0, rel_educationover12_count_s))))));
	
	st_rel_derog_summary := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => -1,
	                                        if(max(min(if(rel_bankrupt_count_s = NULL, -NULL, rel_bankrupt_count_s), 3), min(if(rel_felony_count_s = NULL, -NULL, rel_felony_count_s), 3), min(if(rel_criminal_count_s - rel_felony_count_s = NULL, -NULL, rel_criminal_count_s - rel_felony_count_s), 3)) = NULL, NULL, sum(if(min(if(rel_bankrupt_count_s = NULL, -NULL, rel_bankrupt_count_s), 3) = NULL, 0, min(if(rel_bankrupt_count_s = NULL, -NULL, rel_bankrupt_count_s), 3)), if(min(if(rel_felony_count_s = NULL, -NULL, rel_felony_count_s), 3) = NULL, 0, min(if(rel_felony_count_s = NULL, -NULL, rel_felony_count_s), 3)), if(min(if(rel_criminal_count_s - rel_felony_count_s = NULL, -NULL, rel_criminal_count_s - rel_felony_count_s), 3) = NULL, 0, min(if(rel_criminal_count_s - rel_felony_count_s = NULL, -NULL, rel_criminal_count_s - rel_felony_count_s), 3)))));
	
	st_wealth_index := if(not((boolean)(integer)truedid_s), NULL, (integer)wealth_index_s);
	
	bt_addr_ver_sources := map(
	    not(truedid and add1_pop)                                                  => '             ',
	    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 'Phn & NonPhn ',
	    rc_addrcount > 0                                                           => 'NonPhn Only  ',
	    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 'Phn Only     ',
	                                                                                  'Addr not Verd');
	
	bt_inq_highriskcredit_recency := map(
	    not(truedid)               => NULL,
	    inq_highRiskCredit_count01 >0 => 1,
	    inq_highRiskCredit_count03 >0 => 3,
	    inq_highRiskCredit_count06 >0 => 6,
	    inq_highRiskCredit_count12 >0 => 12,
	    inq_highRiskCredit_count24 >0 => 24,
	    inq_highRiskCredit_count   >0 => 99,
	                                  0);
	
	bt_wealth_index := if(not(truedid), NULL, (integer)wealth_index);
	
	st_cvi := if(not((boolean)(integer)truedid_s or (integer)ssnlength_s > 0) 
		and not((boolean)(integer)hphnpop_s or (boolean)(integer)addrpop_s), NULL, (integer)cvi_s);
	
	src_white_pages_adl_fseen_s := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'WP' , ', ', 'E'), ',') = '0', 
			NULL, 
			(integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'WP' , ', ', 'E'), ','));
	
	_src_white_pages_adl_fseen_s := Common.SAS_Date((STRING)(src_white_pages_adl_fseen_s));
	
	st_mos_src_white_pages_adl_fseen := map(
	    not((boolean)(integer)truedid_s)    => NULL,
	    _src_white_pages_adl_fseen_s = NULL => -1,
	                                           if ((sysdate - _src_white_pages_adl_fseen_s) / 365.25 / 12 >= 0, truncate((sysdate - _src_white_pages_adl_fseen_s) / 365.25 / 12), roundup((sysdate - _src_white_pages_adl_fseen_s) / 365.25 / 12)));
	
	st_inp_addr_naprop := if(not((boolean)(integer)add1_pop_s), NULL, add1_naprop_s);
	
	st_max_ids_per_addr_c6 := if(not((boolean)(integer)add1_pop_s), NULL, max(adls_per_addr_c6_s, ssns_per_addr_c6_s));
	
	src_bureau_adl_fseen_tn := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TN' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TN' , ', ', 'E'), ','));
	
	src_bureau_adl_fseen_ts := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TS' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TS' , ', ', 'E'), ','));
	
	src_bureau_adl_fseen_tu := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TU' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'TU' , ', ', 'E'), ','));
	
	src_bureau_adl_fseen_en := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'EN' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'EN' , ', ', 'E'), ','));
	
	src_bureau_adl_fseen_eq := if(Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'EQ' , ', ', 'E'), ',') = '0', NULL, (integer)Models.Common.getw(ver_sources_first_seen_s, Models.Common.findw_cpp(ver_sources_s, 'EQ' , ', ', 'E'), ','));
	
	src_bureau_adl_fseen_s := if(
	max(src_bureau_adl_fseen_tn, src_bureau_adl_fseen_ts, src_bureau_adl_fseen_tu, src_bureau_adl_fseen_en, src_bureau_adl_fseen_eq) = NULL, NULL, 
	
	min(if(src_bureau_adl_fseen_tn in [0,NULL], -NULL, src_bureau_adl_fseen_tn), 
			if(src_bureau_adl_fseen_ts in [0,NULL], -NULL, src_bureau_adl_fseen_ts), 
			if(src_bureau_adl_fseen_tu in [0,NULL], -NULL, src_bureau_adl_fseen_tu), 
			if(src_bureau_adl_fseen_en in [0,NULL], -NULL, src_bureau_adl_fseen_en), 
			if(src_bureau_adl_fseen_eq in [0,NULL], -NULL, src_bureau_adl_fseen_eq)));
	
	_src_bureau_adl_fseen_s := Common.SAS_Date((STRING)(src_bureau_adl_fseen_s));
	
	st_mos_src_bureau_adl_fseen_calc := (sysdate - _src_bureau_adl_fseen_s) / (365.25 / 12);
	st_mos_src_bureau_adl_fseen := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    _src_bureau_adl_fseen_s = NULL   => -1,
	    if (st_mos_src_bureau_adl_fseen_calc >= 0, truncate(st_mos_src_bureau_adl_fseen_calc), roundup(st_mos_src_bureau_adl_fseen_calc)));
	
	st_inp_addr_eda_sourced := if(not((boolean)(integer)add1_pop_s), NULL, (integer)add1_eda_sourced_s);
	
	st_inp_addr_ownership_lvl := map(
	    not((boolean)(integer)add1_pop_s) => '            ',
	    add1_applicant_owned_s            => 'Applicant   ',
	    add1_family_owned_s               => 'Family      ',
	    add1_occupant_owned_s             => 'Occupant    ',
	                                         'No Ownership');
	
	st_phones_per_sfd_addr := map(
	    not((boolean)(integer)add1_pop_s) => NULL,
	    st_add_apt                        => -1,
	                                         phones_per_addr_s);
	
	st_closest_rel_distance := map(
	    not((boolean)(integer)truedid_s) => NULL,
	    rel_count_s = 0                  => -1,
	    rel_within25miles_count_s > 0    => 25,
	    rel_within100miles_count_s > 0   => 100,
	    rel_within500miles_count_s > 0   => 500,
	    rel_withinOther_count_s > 0      => 1000,
	                                        0);
	
	st_cen_fammar_p := IF(c_FAMMAR_P_s='', NULL, (real)c_FAMMAR_P_s);
	
	st_cen_med_inc := if(c_MED_INC_s='', NULL, (real)c_MED_INC_s);
	
	st_full_name_ver_sources := map(
	    not(((boolean)(integer)hphnpop_s or (boolean)(integer)addrpop_s) and (boolean)(integer)lnamepop_s and (boolean)(integer)fnamepop_s) => '             ',
	    (integer)source_count_s > 0 and not(trim(fname_eda_sourced_type_s) = '') and not(trim(lname_eda_sourced_type_s) = '')                                => 'Phn & NonPhn ',
	    (integer)source_count_s > 0                                                                                                                  => 'NonPhn Only  ',
	    not(trim(fname_eda_sourced_type_s) = '') and not(trim(lname_eda_sourced_type_s) = '')                                                       => 'Phn Only     ',
	                                                                                                                                           'Name not Verd');
	
	st_addr_ver_sources := map(
	    not((boolean)(integer)truedid_s and (boolean)(integer)add1_pop_s)                => '             ',
	    (integer)rc_addrcount_s > 0 and ((integer)rc_phoneaddrcount_s > 0 or (integer)rc_phoneaddr_addrcount_s > 0) => 'Phn & NonPhn ',
	    (integer)rc_addrcount_s > 0                                                               => 'NonPhn Only  ',
	    (integer)rc_phoneaddrcount_s > 0 or (integer)rc_phoneaddr_addrcount_s > 0                          => 'Phn Only     ',
	                                                                                        'Addr not Verd');
	
	// st_add1_util_sum := if(not((boolean)(integer)add1_pop_s), NULL, 
					// if(stringlib.stringfind(util_add1_type_list_s, 'S', 1) > 0 
					// or stringlib.stringfind(util_add1_type_list_s, 'U', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'V', 1) > 0,
					// 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'D', 1) > 0 
					// or stringlib.stringfind(util_add1_type_list_s, 'F', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'T', 1) > 0,
					// 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'A', 1) > 0 
					// or stringlib.stringfind(util_add1_type_list_s, 'H', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'I', 1) > 0,
					// 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'L', 1) > 0 
					// or stringlib.stringfind(util_add1_type_list_s, 'N', 1) > 0,
					// 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'C', 1) > 0 
					// or stringlib.stringfind(util_add1_type_list_s, 'E', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'G', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'O', 1) > 0
					// or stringlib.stringfind(util_add1_type_list_s, 'P', 1) > 0,
					// 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'W', 1) > 0, 1, 0) +
					// if(stringlib.stringfind(util_add1_type_list_s, 'Z', 1) > 0, 1, 0) ) ;
	
	st_max_ids_per_sfd_addr_c6 := map(
	    not((boolean)(integer)add1_pop_s) => NULL,
	    st_add_apt                        => -1,
	                                         max(adls_per_addr_c6_s, ssns_per_addr_c6_s));
	
	st_inq_adls_per_addr := if(not((boolean)(integer)add1_pop_s), NULL, inq_adlsperaddr_s);
	
	ver_phn_inf_s := (infutor_nap_s in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_phn_nap_s := (nap_summary_s in [4, 6, 7, 9, 10, 11, 12]);
	
	inf_phn_ver_lvl_s := map(
	    ver_phn_inf_s     => 3,
	    infutor_nap_s = 1 => 1,
	    infutor_nap_s = 0 => 0,
	                         2);
	
	nap_phn_ver_lvl_s := map(
	    ver_phn_nap_s     => 3,
	    nap_summary_s = 1 => 1,
	    nap_summary_s = 0 => 0,
	                         2);
	
	st_nap_phn_ver_x_inf_phn_ver := map(
	    not((boolean)(integer)addrpop_s or (boolean)(integer)hphnpop_s) => '   ',
	    not((boolean)(integer)hphnpop_s)                                => ' -1',
	                                                                       trim((string)nap_phn_ver_lvl_s, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)inf_phn_ver_lvl_s, LEFT, RIGHT));
	
	st_cen_hhsize := if(c_HHSIZE_s='', null, (real)c_hhsize_s);
	
	st_high_risk_phone := map(
	    not((boolean)(integer)hphnpop_s)                                                                     => '             ',
	    (rc_hriskphoneflag_s in ['5', '6']) or (rc_hphonetypeflag_s in ['5', '6', '7', '8', '9', 'A', 'B', 'U']) => 'Oth High Risk',
	    (rc_hriskphoneflag_s in ['1', '2', '3']) or (rc_hphonetypeflag_s in ['1', '2', '3'])                       => 'Cell/Mobile  ',
	    rc_hriskphoneflag_s = '4' or rc_hphonetypeflag_s = '4'                                                 => 'Oth Non-POTS ',
	    rc_hriskphoneflag_s = '0' or rc_hphonetypeflag_s = '0'                                                 => 'Not High Risk',
	                                                                                                            '             ');
	
	st_cen_span_lang := if(c_SPAN_LANG_s='', null, (real)c_SPAN_LANG_s);
	
	btst_email_first_x_last_score := trim(efirstscore, LEFT, RIGHT) + trim(':', LEFT, RIGHT) + trim(elastscore, LEFT, RIGHT);
	
	ip_continent := map(
	    continent = '1' => 'Africa       ',
	    continent = '2' => 'Asia         ',
	    continent = '3' => 'Australia    ',
	    continent = '4' => 'Europe       ',
	    continent = '7' => 'South America',
	    continent = '5' => 'North America',
	                     'Other');
	
	ip_state_match := map(trim(out_st) = '' or trim(state) = '' => NULL, 
												stringlib.stringtouppercase(out_st) = stringlib.stringtouppercase(state) => 1,
												0);
	
	ip_topleveldomain_lvl := map(
	    ipaddr = ''                                                         => '  ',
	    topleveldomain = ''                                                 => '-1',
	    (stringlib.stringtouppercase(topleveldomain) in ['COM', 'EDU', 'GOV', 'NET', 'ORG', 'US']) => stringlib.stringtouppercase(topleveldomain),
	    contains_i(topleveldomain, '.') > 0                                   => 'DOT',
	    length(trim((string)topleveldomain, ALL)) < 3                         => 'TWO',
	                                                                             'OTH');
	
	ip_routingmethod := map(
	    ipaddr = ''          => '  ',
	    iproutingmethod = '' => '-1',
	                              iproutingmethod);
	
	ip_area_code_match := map(
	    in_phone10 = '' or areacode = '' => NULL,
	    areacode = '0'                       => -1,
	    in_phone10[1..3] = stringlib.stringtouppercase(areacode) => 1,
			0);
	
	ip_dma_lvl := map(
	    ipaddr = ''      => '               ',
	    ipdma = ''       => '1. Missing DMA ',
	    ipdma = '-1'       => '2. DMA: -1     ',
	    ipdma = '0'        => '3. DMA: 0      ',
	    length(ipdma) = 3  => '4. DMA: US Code',
	    length(ipdma) != 3 => '5. DMA: Unknown',
	                          '6. Other');
	
	// get the 2nd word in the string, first word after the @ sign
	domain := Models.Common.getw(in_email_address, 2, '@');
	// now get the carrier from the domain
	email_secondleveldomain := trim(Models.Common.getw(domain, 1, '.'));
	
	btst_email_domain_risk_level := map(
	    (email_secondleveldomain in ['YMAIL', 'LIVE'])                                                                                                                                                 => 7,
	    (email_secondleveldomain in ['HOTMAIL'])                                                                                                                                                       => 6,
	    (email_secondleveldomain in ['YAHOO'])                                                                                                                                                         => 5,
	    (email_secondleveldomain in ['GMAIL', 'JUNO', 'ME'])                                                                                                                                           => 4,
	    (email_secondleveldomain in ['AOL', 'ATT', 'EARTHLINK', 'VERIZON', '2661'])                                                                                                                    => 2,
	    (email_secondleveldomain in ['BELLSOUTH', 'CHARTER', 'COMCAST', 'COX', 'DELL', 'EMBARQMAIL', 'FRONTIER', 'FRONTIERNET', 'MCHSI', 'MSN', 'OPTONLINE', 'ROADRUNNER', 'SBCGLOBAL', 'WINDSTREAM']) => 1,
	    in_email_address = ''                                                                                                                                                                        => NULL,
	                                                                                                                                                                                                      3);
	
	btst_distaddraddr2 := if(trim(distaddraddr2)='', NULL, (integer)distaddraddr2);
	
	btst_relatives_lvl := map(
	    did = 0 and did_s = 0    => '1. BOTH DID 0         ',
	    did = 0                  => '2. BILLTO DID 0       ',
	    did_s = 0                => '2. SHIPTO DID 0       ',
	    did = did_s              => '4. DIDS EQUAL         ',
	    btst_are_relatives       => '5. RELATIVES          ',
	    btst_relatives_in_common => '6. RELATIVES IN COMMON',
	                                '7. NO RELATION');
	
	num_inp_lat := (real)StringLib.StringFilterOut(out_lat, '<>');
	
	num_inp_long := (real)StringLib.StringFilterOut(out_long, '<>');
	
	num_ip_lat := (real)StringLib.StringFilterOut((string)latitude, '<>');
	
	num_ip_long := (real)StringLib.StringFilterOut((string)longitude, '<>');
	
	// added code here to check if either one is 0, then set to null like SAS does
	d_lat := if(num_inp_lat=0 or num_ip_lat=0, null, num_inp_lat - num_ip_lat);
	d_long := if(num_inp_long=0 or num_ip_long=0, null, num_inp_long - num_ip_long);
	
	// changed ** 2 to power( , 2)
	// added check for 0 or null like SAS does
	a := if(num_inp_lat=0 or num_ip_lat=0 or d_lat=null or d_long=null, null,
		power(sin(d_lat / 2), 2) + power(sin(d_long / 2), 2) * cos(num_inp_lat) * cos(num_ip_lat));
	
	c := if(a=null, null, 2 * atan2(sqrt(a), sqrt(1 - a)));
	
	dist := if(c=null, null, 3959 * c);
	
	ip_dist_inp_addr_to_ip_addr := if(dist=null, null, round(dist));
	
	// btst_distphoneaddr := if(not(hphnpop) and not(addrpop), NULL, (integer)distphoneaddr);
	// btst_distphone2addr2 := if(not((boolean)(integer)hphnpop_s) and not((boolean)(integer)addrpop_s), NULL, (integer)distphone2addr2);
	// btst_distaddrphone2 := if(not(addrpop) and not((boolean)(integer)hphnpop_s), NULL, (integer)distaddrphone2);
	
	btst_distphoneaddr := if(trim(distphoneaddr)='', NULL, (integer)distphoneaddr);
	btst_distphone2addr2 := if(trim(distphone2addr2)='', NULL, (integer)distphone2addr2);
	btst_distaddrphone2 := if(trim(distaddrphone2)='', NULL, (integer)distaddrphone2);
	
	addr_match := (integer)addrscore = 100 or not((boolean)(integer)addrpop_s);
	
	fname_match := (integer)firstscore = 100;
	
	lname_match := (integer)lastscore = 100;
	
	did_match := truedid and (boolean)(integer)truedid_s and did = did_s;
	
	btst_segment2 := map(
	    addr_match and did_match                                       => 1,
	    addr_match and (boolean)(integer)btst_are_relatives            => 1,
	    addr_match and (boolean)(integer)btst_relatives_in_common      => 1,
	    addr_match                                                     => 2,
	    not(addr_match) and did_match                                  => 3,
	    not(addr_match) and (boolean)(integer)btst_are_relatives       => 3,
	    not(addr_match) and (boolean)(integer)btst_relatives_in_common => 3,
	    not(addr_match) and lname_match                                => 4,
	                                                                      5);
	
	dell_segmentation2 := map(
	    inp_us_business_consumer_flag = '1' => btst_segment2,
	    addr_match                        => 8,
	                                         9);
	
	dell_segmentation3 := if(not(in_ip_address = ''), dell_segmentation2, dell_segmentation2 + 10);
	
	final_model_segment := map(
	    dell_segmentation3 = 1  => 'CONS ADDR+ ID/RELS WEB',
	    dell_segmentation3 = 2  => 'CONS ADDR+ DIFF    WEB',
	    dell_segmentation3 = 3  => 'CONS ADDR- ID/RELS WEB',
	    dell_segmentation3 = 4  => 'CONS ADDR- LNAME   WEB',
	    dell_segmentation3 = 5  => 'CONS ADDR- DIFF    WEB',
	    dell_segmentation3 = 8  => 'BUS  ADDR+         WEB',
	    dell_segmentation3 = 9  => 'BUS  ADDR-         WEB',
	    dell_segmentation3 = 11 => 'CONS ADDR+ ID/RELS PHN',
	    dell_segmentation3 = 12 => 'CONS ADDR+ DIFF    PHN',
	    dell_segmentation3 = 13 => 'CONS ADDR- ID/RELS PHN',
	    dell_segmentation3 = 14 => 'CONS ADDR- LNAME   PHN',
	    dell_segmentation3 = 15 => 'CONS ADDR- DIFF    PHN',
	    dell_segmentation3 = 18 => 'BUS  ADDR+         PHN',
	                               'BUS  ADDR-         PHN');
	
	bs_p_subscore0 := map(
	    (bt_bus_phone_match in [0]) => -1.560315,
	    (bt_bus_phone_match in [1]) => 0.219192,
	    (bt_bus_phone_match in [2]) => -0.347666,
	    (bt_bus_phone_match in [3]) => 1.413636,
	                                   0.000000);
	
	bs_p_subscore1 := map(
	    (bt_phn_miskey in [0]) => 0.131376,
	    (bt_phn_miskey in [1]) => -1.733465,
	                              -0.000000);
	
	bs_p_subscore2 := map(
	    (bt_valid_phone in ['Other'])                                         => 0.000000,
	    (bt_valid_phone in ['Invalid Phn', 'Valid Oth Phn', 'Valid Res Phn']) => -0.212256,
	    (bt_valid_phone in ['Valid Bus Phn'])                                 => 0.440310,
	                                                                             0.000000);
	
	bs_p_subscore3 := map(
	    (bt_phone_zip_match in ['Other'])                  => -0.000000,
	    (bt_phone_zip_match in ['Mismatch', 'Not Issued']) => -0.600628,
	    (bt_phone_zip_match in ['No Mismatch'])            => 0.154946,
	                                                          -0.000000);
	
	bs_p_subscore4 := map(
	    (bt_hriskaddrflag in ['Corp Zip Code', 'Not High Risk', 'PO Box Only']) => 0.096154,
	    (bt_hriskaddrflag in ['HR Commercial'])                                 => -1.209750,
	                                                                               -0.000000);
	
	// bs_p_subscore5 := map(
	    // (bt_add1_util_pots in [0]) => 0.204791,
	    // (bt_add1_util_pots in [1]) => -1.307868,
	                                  // -0.000000);
	
	bs_p_subscore6 := map(
	    (bt_inp_addr_res_or_business in ['-1', 'A', 'C', 'D']) => -0.315606,
	    (bt_inp_addr_res_or_business in ['B'])                 => 0.465484,
	                                                              0.000000);
	
	bs_p_subscore7 := map(
	    NULL < bt_max_ids_per_addr AND bt_max_ids_per_addr < 1 => -0.309051,
	    1 <= bt_max_ids_per_addr                               => 0.135207,
	                                                              0.000000);
	
	bs_p_subscore8 := map(
	    NULL < bt_mos_since_paw_first_seen AND bt_mos_since_paw_first_seen < 0 => -0.309934,
	    0 <= bt_mos_since_paw_first_seen                                       => 0.234859,
	                                                                              0.000000);
	
	bs_p_subscore9 := map(
	    (inp_product_desc in ['0'])    => 0.825242,
	    (inp_product_desc in ['1', '2']) => 0.480454,
	    (inp_product_desc in ['3', '5']) => -0.688351,
	                                    -0.000000);
	
	bs_p_subscore10 := map(
	    (pf_pmt_x_avs_lvl in [0, 1])    => -2.862858,
	    (pf_pmt_x_avs_lvl in [2, 3, 4]) => -1.329319,
	    (pf_pmt_x_avs_lvl in [5])       => 0.321625,
	    (pf_pmt_x_avs_lvl in [6])       => 0.432155,
	    (pf_pmt_x_avs_lvl in [7, 8])    => 1.666946,
	                                       -0.000000);
	
	bs_p_subscore11 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.855088,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.563890,
	                                                          0.000000);
	
	bs_p_subscore12 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 1382.32     => 0.867027,
	    1382.32 <= pf_order_amt_c AND pf_order_amt_c < 2370.07 => -0.135880,
	    2370.07 <= pf_order_amt_c                              => -0.904085,
	                                                              -0.000000);
	// removed bs_p_subscore5 with utility change
	bs_p_rawscore := if(max(bs_p_subscore0, bs_p_subscore1, bs_p_subscore2, bs_p_subscore3, bs_p_subscore4, bs_p_subscore6, bs_p_subscore7, bs_p_subscore8, bs_p_subscore9, bs_p_subscore10, bs_p_subscore11, bs_p_subscore12) = NULL, NULL, sum(if(bs_p_subscore0 = NULL, 0, bs_p_subscore0), if(bs_p_subscore1 = NULL, 0, bs_p_subscore1), if(bs_p_subscore2 = NULL, 0, bs_p_subscore2), if(bs_p_subscore3 = NULL, 0, bs_p_subscore3), if(bs_p_subscore4 = NULL, 0, bs_p_subscore4), if(bs_p_subscore6 = NULL, 0, bs_p_subscore6), if(bs_p_subscore7 = NULL, 0, bs_p_subscore7), if(bs_p_subscore8 = NULL, 0, bs_p_subscore8), if(bs_p_subscore9 = NULL, 0, bs_p_subscore9), if(bs_p_subscore10 = NULL, 0, bs_p_subscore10), if(bs_p_subscore11 = NULL, 0, bs_p_subscore11), if(bs_p_subscore12 = NULL, 0, bs_p_subscore12)));
	
	bs_p_lnoddsscore := bs_p_rawscore + 4.847447;
	
	bs_w_subscore0 := map(
	    (bt_bus_phone_match in [0, 1, 2]) => -0.358730,
	    (bt_bus_phone_match in [3])       => 0.765704,
	                                         -0.000000);
	
	bs_w_subscore1 := map(
	    (bt_phone_zip_match in ['Other'])                  => -0.000000,
	    (bt_phone_zip_match in ['Mismatch', 'Not Issued']) => -1.283874,
	    (bt_phone_zip_match in ['No Mismatch'])            => 0.455029,
	                                                          -0.000000);
	
	bs_w_subscore2 := map(
	    (bt_inp_addr_res_or_business in ['-1', 'A', 'C', 'D']) => -0.242841,
	    (bt_inp_addr_res_or_business in ['B'])                 => 0.491440,
	                                                              -0.000000);
	
	bs_w_subscore3 := map(
	    (btst_email_first_x_last_score in ['-1:-1', '-1:1', '0:-1', '0:0'])                  => -0.558041,
	    (btst_email_first_x_last_score in ['0:1', '0:2', '1:0', '1:1', '1:2', '2:0', '2:1']) => 0.370946,
	    (btst_email_first_x_last_score in ['1:3', '2:2', '2:3', '3:1', '3:2', '3:3'])        => 0.911424,
	                                                                                            -0.000000);
	
	bs_w_subscore4 := map(
	    (ip_continent in ['Africa', 'Asia', 'Australia', 'Europe', 'Other', 'South America']) => -0.559840,
	    (ip_continent in ['North America'])                                                   => 0.037199,
	                                                                                             0.000000);
	
	bs_w_subscore5 := map(
	    (ip_state_match in [0]) => -0.494294,
	    (ip_state_match in [1]) => 0.312739,
	                               0.000000);
	
	bs_w_subscore6 := map(
	    (ip_topleveldomain_lvl in ['-1'])                => -0.460493,
	    (ip_topleveldomain_lvl in ['COM', 'NET', 'ORG']) => 0.057624,
	    (ip_topleveldomain_lvl in ['DOT', 'OTH', 'TWO']) => -0.838708,
	    (ip_topleveldomain_lvl in ['EDU', 'GOV', 'US'])  => 1.861685,
	                                                        0.000000);
	
	bs_w_subscore7 := map(
	    (ip_routingmethod in ['02', '16'])                               => -2.791505,
	    (ip_routingmethod in ['06', '10', '11', '12', '13', '14', '15']) => 0.410786,
	                                                                        -0.000000);
	
	bs_w_subscore8 := map(
	    (ip_area_code_match in [-1, 0]) => -0.243350,
	    (ip_area_code_match in [1])     => 0.510266,
	                                       -0.000000);
	
	bs_w_subscore9 := map(
	    (ip_dma_lvl in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unknown']) => -0.723782,
	    (ip_dma_lvl in ['4. DMA: US Code'])                                              => 0.076013,
	                                                                                        -0.000000);
	
	bs_w_subscore10 := map(
	    NULL < btst_email_domain_risk_level AND btst_email_domain_risk_level < 2 => 1.571103,
	    2 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 4   => 0.441739,
	    4 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 5   => -0.149577,
	    5 <= btst_email_domain_risk_level                                        => -0.937977,
	                                                                                -0.000000);
	
	bs_w_subscore11 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.702190,
	    2 <= pf_wks_since_create_date                                    => 2.084801,
	                                                                        0.000000);
	
	bs_w_subscore12 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4]) => -0.865773,
	    (pf_pmt_x_avs_lvl in [5, 6])          => 0.421341,
	    (pf_pmt_x_avs_lvl in [7, 8])          => 1.067322,
	                                             -0.000000);
	
	bs_w_subscore13 := map(
	    (pf_cid_result in ['Invalid', 'No Match', 'Other']) => -1.136814,
	    (pf_cid_result in ['Match', 'Null'])                => 0.045565,
	                                                           0.000000);
	
	bs_w_subscore14 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.718209,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.713934,
	                                                          0.000000);
	
	bs_w_subscore15 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 411.36   => 1.613216,
	    411.36 <= pf_order_amt_c AND pf_order_amt_c < 694.1 => 0.307878,
	    694.1 <= pf_order_amt_c                             => -0.188997,
	                                                           -0.000000);
	
	bs_w_rawscore := if(max(bs_w_subscore0, bs_w_subscore1, bs_w_subscore2, bs_w_subscore3, bs_w_subscore4, bs_w_subscore5, bs_w_subscore6, bs_w_subscore7, bs_w_subscore8, bs_w_subscore9, bs_w_subscore10, bs_w_subscore11, bs_w_subscore12, bs_w_subscore13, bs_w_subscore14, bs_w_subscore15) = NULL, NULL, sum(if(bs_w_subscore0 = NULL, 0, bs_w_subscore0), if(bs_w_subscore1 = NULL, 0, bs_w_subscore1), if(bs_w_subscore2 = NULL, 0, bs_w_subscore2), if(bs_w_subscore3 = NULL, 0, bs_w_subscore3), if(bs_w_subscore4 = NULL, 0, bs_w_subscore4), if(bs_w_subscore5 = NULL, 0, bs_w_subscore5), if(bs_w_subscore6 = NULL, 0, bs_w_subscore6), if(bs_w_subscore7 = NULL, 0, bs_w_subscore7), if(bs_w_subscore8 = NULL, 0, bs_w_subscore8), if(bs_w_subscore9 = NULL, 0, bs_w_subscore9), if(bs_w_subscore10 = NULL, 0, bs_w_subscore10), if(bs_w_subscore11 = NULL, 0, bs_w_subscore11), if(bs_w_subscore12 = NULL, 0, bs_w_subscore12), if(bs_w_subscore13 = NULL, 0, bs_w_subscore13), if(bs_w_subscore14 = NULL, 0, bs_w_subscore14), if(bs_w_subscore15 = NULL, 0, bs_w_subscore15)));
	
	bs_w_lnoddsscore := bs_w_rawscore + 4.617623;
	
	bd_p_subscore0 := map(
	    (bt_valid_phone in ['Other'])                                           => -0.000000,
	    (bt_valid_phone in ['Invalid Phn'])                                     => -1.766236,
	    (bt_valid_phone in ['Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.138247,
	                                                                               -0.000000);
	
	bd_p_subscore1 := map(
	    NULL < bt_inq_retail_recency AND bt_inq_retail_recency < 1 => -1.064906,
	    1 <= bt_inq_retail_recency                                 => 1.025027,
	                                                                  0.000000);
	
	bd_p_subscore2 := map(
	    NULL < bt_paw_source_count AND bt_paw_source_count < 1 => -0.671513,
	    1 <= bt_paw_source_count                               => 0.340501,
	                                                              0.000000);
	
	bd_p_subscore3 := map(
	    (st_bus_phone_match in [0])    => -0.436265,
	    (st_bus_phone_match in [1, 2]) => 0.054001,
	    (st_bus_phone_match in [3])    => 0.536012,
	                                      0.000000);
	
	bd_p_subscore4 := map(
	    (st_phone_zip_match in ['Other'])                  => -0.000000,
	    (st_phone_zip_match in ['Mismatch', 'Not Issued']) => -0.395621,
	    (st_phone_zip_match in ['No Mismatch'])            => 0.242545,
	                                                          -0.000000);
	
	bd_p_subscore5 := map(
	    (st_inp_addr_res_or_business in ['Other', '-1', 'A', 'C', 'D']) => -0.444277,
	    (st_inp_addr_res_or_business in ['B'])                          => 0.824667,
	                                                                       0.000000);
	
	bd_p_subscore6 := map(
	    NULL < st_paw_source_count AND st_paw_source_count < 1 => -0.572610,
	    1 <= st_paw_source_count                               => 0.351855,
	                                                              0.000000);
	
	bd_p_subscore7 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 117 => 0.833031,
	    117 <= btst_distaddraddr2                              => -0.991343,
	                                                              -0.000000);
	
	bd_p_subscore8 := map(
	    (btst_relatives_lvl in ['1. BOTH DID 0', '2. BILLTO DID 0'])                        => 0.037162,
	    (btst_relatives_lvl in ['2. SHIPTO DID 0'])                                         => -0.279020,
	    (btst_relatives_lvl in ['4. DIDS EQUAL', '5. RELATIVES', '6. RELATIVES IN COMMON']) => 0.941370,
	    (btst_relatives_lvl in ['7. NO RELATION'])                                          => -0.225166,
	                                                                                           -0.000000);
	
	bd_p_subscore9 := map(
	    (inp_product_desc in ['0'])          => 0.954858,
	    (inp_product_desc in ['1', '2', '3', '5']) => -0.273467,
	                                          0.000000);
	
	bd_p_subscore10 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 1 => -1.507751,
	    1 <= pf_wks_since_create_date                                    => 0.756891,
	                                                                        -0.000000);
	
	bd_p_subscore11 := map(
	    (pf_pmt_type in ['American Express', 'Credit Terms', 'Dell Credit Card'])                                 => 0.740692,
	    (pf_pmt_type in ['Diners Club', 'Discover', 'Gift Card', 'Mastercard', 'Other', 'Prepaid Check', 'Visa']) => -0.427178,
	                                                                                                                 0.000000);
	
	bd_p_subscore12 := map(
	    (pf_ship_method in ['2nd Day', 'Ground', 'Other']) => 0.444896,
	    (pf_ship_method in ['Next Day'])                   => -0.595171,
	                                                          -0.000000);
	
	bd_p_rawscore := if(max(bd_p_subscore0, bd_p_subscore1, bd_p_subscore2, bd_p_subscore3, bd_p_subscore4, bd_p_subscore5, bd_p_subscore6, bd_p_subscore7, bd_p_subscore8, bd_p_subscore9, bd_p_subscore10, bd_p_subscore11, bd_p_subscore12) = NULL, NULL, sum(if(bd_p_subscore0 = NULL, 0, bd_p_subscore0), if(bd_p_subscore1 = NULL, 0, bd_p_subscore1), if(bd_p_subscore2 = NULL, 0, bd_p_subscore2), if(bd_p_subscore3 = NULL, 0, bd_p_subscore3), if(bd_p_subscore4 = NULL, 0, bd_p_subscore4), if(bd_p_subscore5 = NULL, 0, bd_p_subscore5), if(bd_p_subscore6 = NULL, 0, bd_p_subscore6), if(bd_p_subscore7 = NULL, 0, bd_p_subscore7), if(bd_p_subscore8 = NULL, 0, bd_p_subscore8), if(bd_p_subscore9 = NULL, 0, bd_p_subscore9), if(bd_p_subscore10 = NULL, 0, bd_p_subscore10), if(bd_p_subscore11 = NULL, 0, bd_p_subscore11), if(bd_p_subscore12 = NULL, 0, bd_p_subscore12)));
	
	bd_p_lnoddsscore := bd_p_rawscore + 4.540995;
	
	bd_w_subscore0 := map(
	    (bt_valid_phone in ['Other'])                                           => 0.000000,
	    (bt_valid_phone in ['Invalid Phn'])                                     => -0.988792,
	    (bt_valid_phone in ['Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.043589,
	                                                                               0.000000);
	
	bd_w_subscore1 := map(
	    NULL < bt_inq_retail_recency AND bt_inq_retail_recency < 1 => -0.520666,
	    1 <= bt_inq_retail_recency                                 => 0.468320,
	                                                                  0.000000);
	
	bd_w_subscore2 := map(
	    (st_bus_name_match in [0])       => -0.354550,
	    (st_bus_name_match in [1])       => 0.130356,
	    (st_bus_name_match in [2, 3, 4]) => 0.807064,
	                                        -0.000000);
	
	bd_w_subscore3 := map(
	    (st_valid_phone in ['Other'])                                           => 0.000000,
	    (st_valid_phone in ['Invalid Phn'])                                     => -1.119960,
	    (st_valid_phone in ['Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.081106,
	                                                                               0.000000);
	
	bd_w_subscore4 := map(
	    (st_phone_zip_match in ['Other'])                  => -0.000000,
	    (st_phone_zip_match in ['Mismatch', 'Not Issued']) => -0.837710,
	    (st_phone_zip_match in ['No Mismatch'])            => 0.356755,
	                                                          -0.000000);
	
	bd_w_subscore5 := map(
	    (st_inp_addr_res_or_business in ['Other'])             => 0.000000,
	    (st_inp_addr_res_or_business in ['-1', 'A', 'C', 'D']) => -0.280561,
	    (st_inp_addr_res_or_business in ['B'])                 => 0.538895,
	                                                              0.000000);
	
	bd_w_subscore6 := map(
	    NULL < st_inq_highriskcredit_recency AND st_inq_highriskcredit_recency < 1 => 0.194002,
	    1 <= st_inq_highriskcredit_recency                                         => -1.083620,
	                                                                                  -0.000000);
	
	bd_w_subscore7 := map(
	    NULL < ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 2953 => 0.495517,
	    2953 <= ip_dist_inp_addr_to_ip_addr                                       => -0.556760,
	                                                                                 -0.000000);
	
	bd_w_subscore8 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 19  => 0.948662,
	    19 <= btst_distaddraddr2 AND btst_distaddraddr2 < 113  => 0.583606,
	    113 <= btst_distaddraddr2 AND btst_distaddraddr2 < 702 => -0.686338,
	    702 <= btst_distaddraddr2                              => -0.972769,
	                                                              -0.000000);
	
	bd_w_subscore9 := map(
	    (btst_relatives_lvl in ['1. BOTH DID 0', '2. BILLTO DID 0'])                        => 0.304637,
	    (btst_relatives_lvl in ['2. SHIPTO DID 0'])                                         => -0.378086,
	    (btst_relatives_lvl in ['4. DIDS EQUAL', '5. RELATIVES', '6. RELATIVES IN COMMON']) => 0.491329,
	    (btst_relatives_lvl in ['7. NO RELATION'])                                          => -0.161026,
	                                                                                           0.000000);
	
	bd_w_subscore10 := map(
	    (ip_continent in ['Africa', 'Asia', 'Australia', 'Europe', 'South America']) => -2.269011,
	    (ip_continent in ['North America'])                                          => 0.082635,
	    (ip_continent in ['Other'])                                                  => -0.000000,
	                                                                                    -0.000000);
	
	bd_w_subscore11 := map(
	    (ip_routingmethod in ['Other'])                                  => -0.000000,
	    (ip_routingmethod in ['02', '16'])                               => -2.682653,
	    (ip_routingmethod in ['06', '10', '11', '12', '13', '14', '15']) => 0.317590,
	                                                                        -0.000000);
	
	bd_w_subscore12 := map(
	    (ip_dma_lvl in ['Other', '1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unknown']) => -0.321176,
	    (ip_dma_lvl in ['4. DMA: US Code'])                                                       => 0.015218,
	                                                                                                 -0.000000);
	
	bd_w_subscore13 := map(
	    NULL < btst_email_domain_risk_level AND btst_email_domain_risk_level < 4 => 0.611309,
	    4 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 5   => 0.214625,
	    5 <= btst_email_domain_risk_level                                        => -1.118698,
	                                                                                0.000000);
	
	bd_w_subscore14 := map(
	    (inp_product_desc in ['0'])          => 0.885921,
	    (inp_product_desc in ['1', '2', '3', '5']) => -0.309394,
	                                          0.000000);
	
	bd_w_subscore15 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.711316,
	    2 <= pf_wks_since_create_date                                    => 1.450152,
	                                                                        0.000000);
	
	bd_w_subscore16 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4]) => -0.827692,
	    (pf_pmt_x_avs_lvl in [5, 6, 7, 8])    => 0.169369,
	                                             0.000000);
	
	bd_w_subscore17 := map(
	    (pf_cid_result in ['Invalid'])           => -0.000000,
	    (pf_cid_result in ['Match'])             => 0.015701,
	    (pf_cid_result in ['No Match', 'Other']) => -0.546103,
	    (pf_cid_result in ['Null'])              => 0.088456,
	                                                -0.000000);
	
	bd_w_subscore18 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.799881,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.954041,
	                                                          0.000000);
	
	bd_w_rawscore := if(max(bd_w_subscore0, bd_w_subscore1, bd_w_subscore2, bd_w_subscore3, bd_w_subscore4, bd_w_subscore5, bd_w_subscore6, bd_w_subscore7, bd_w_subscore8, bd_w_subscore9, bd_w_subscore10, bd_w_subscore11, bd_w_subscore12, bd_w_subscore13, bd_w_subscore14, bd_w_subscore15, bd_w_subscore16, bd_w_subscore17, bd_w_subscore18) = NULL, NULL, sum(if(bd_w_subscore0 = NULL, 0, bd_w_subscore0), if(bd_w_subscore1 = NULL, 0, bd_w_subscore1), if(bd_w_subscore2 = NULL, 0, bd_w_subscore2), if(bd_w_subscore3 = NULL, 0, bd_w_subscore3), if(bd_w_subscore4 = NULL, 0, bd_w_subscore4), if(bd_w_subscore5 = NULL, 0, bd_w_subscore5), if(bd_w_subscore6 = NULL, 0, bd_w_subscore6), if(bd_w_subscore7 = NULL, 0, bd_w_subscore7), if(bd_w_subscore8 = NULL, 0, bd_w_subscore8), if(bd_w_subscore9 = NULL, 0, bd_w_subscore9), if(bd_w_subscore10 = NULL, 0, bd_w_subscore10), if(bd_w_subscore11 = NULL, 0, bd_w_subscore11), if(bd_w_subscore12 = NULL, 0, bd_w_subscore12), if(bd_w_subscore13 = NULL, 0, bd_w_subscore13), if(bd_w_subscore14 = NULL, 0, bd_w_subscore14), if(bd_w_subscore15 = NULL, 0, bd_w_subscore15), if(bd_w_subscore16 = NULL, 0, bd_w_subscore16), if(bd_w_subscore17 = NULL, 0, bd_w_subscore17), if(bd_w_subscore18 = NULL, 0, bd_w_subscore18)));
	
	bd_w_lnoddsscore := bd_w_rawscore + 3.725928;
	
	csdp_subscore0 := map(
	    NULL < bt_cen_hhsize AND bt_cen_hhsize < 2.27  => 0.789213,
	    2.27 <= bt_cen_hhsize AND bt_cen_hhsize < 2.55 => 0.137221,
	    2.55 <= bt_cen_hhsize                          => -0.364979,
	                                                      0.000000);
	
	csdp_subscore1 := map(
	    NULL < bt_cen_famotf18_p AND bt_cen_famotf18_p < 3.4 => 0.598985,
	    3.4 <= bt_cen_famotf18_p AND bt_cen_famotf18_p < 7   => 0.216505,
	    7 <= bt_cen_famotf18_p AND bt_cen_famotf18_p < 12.4  => -0.065058,
	    12.4 <= bt_cen_famotf18_p                            => -0.507934,
	                                                            0.000000);
	
	csdp_subscore2 := map(
	    (bt_phone_zip_match in ['Other'])                  => 0.000000,
	    (bt_phone_zip_match in ['Mismatch', 'Not Issued']) => -0.616890,
	    (bt_phone_zip_match in ['No Mismatch'])            => 0.188458,
	                                                          0.000000);
	
	csdp_subscore3 := map(
	    (bt_inp_addr_ownership_lvl in ['Applicant', 'Family']) => 0.199861,
	    (bt_inp_addr_ownership_lvl in ['No Ownership'])        => 0.115424,
	    (bt_inp_addr_ownership_lvl in ['Occupant'])            => -0.293685,
	                                                              0.000000);
	
	csdp_subscore4 := map(
	    NULL < bt_max_ids_per_addr AND bt_max_ids_per_addr < 1 => 0.161597,
	    1 <= bt_max_ids_per_addr AND bt_max_ids_per_addr < 14  => 0.155875,
	    14 <= bt_max_ids_per_addr AND bt_max_ids_per_addr < 28 => -0.149125,
	    28 <= bt_max_ids_per_addr                              => -0.357149,
	                                                              0.000000);
	
	csdp_subscore5 := map(
	    NULL < bt_inq_adls_per_addr AND bt_inq_adls_per_addr < 2 => 0.176976,
	    2 <= bt_inq_adls_per_addr                                => -0.460388,
	                                                                -0.000000);
	
	csdp_subscore6 := map(
	    (bt_nap_phn_ver_x_inf_phn_ver in ['-1'])                              => -0.000000,
	    (bt_nap_phn_ver_x_inf_phn_ver in ['0-0'])                             => -0.349748,
	    (bt_nap_phn_ver_x_inf_phn_ver in ['0-1', '2-0', '2-1', '3-1', '3-3']) => -0.264542,
	    (bt_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-0'])               => 1.194480,
	                                                                             -0.000000);
	
	csdp_subscore7 := map(
	    (btst_relatives_lvl in ['1. BOTH DID 0', '4. DIDS EQUAL'])                       => -0.079926,
	    (btst_relatives_lvl in ['2. BILLTO DID 0', '2. SHIPTO DID 0', '7. NO RELATION']) => 0.593266,
	                                                                                        -0.000000);
	
	csdp_subscore8 := map(
	    (inp_product_desc in ['0'])       => 1.284781,
	    (inp_product_desc in ['2', '3', '5']) => -0.225336,
	                                       0.000000);
	
	csdp_subscore9 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.236796,
	    2 <= pf_wks_since_create_date                                    => 1.000306,
	                                                                        0.000000);
	
	csdp_subscore10 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4]) => -0.746289,
	    (pf_pmt_x_avs_lvl in [5])             => 0.264906,
	    (pf_pmt_x_avs_lvl in [6, 7, 8])       => 1.718247,
	                                             0.000000);
	
	csdp_subscore11 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 515.12    => 0.739109,
	    515.12 <= pf_order_amt_c AND pf_order_amt_c < 930.87 => 0.197818,
	    930.87 <= pf_order_amt_c                             => -0.391816,
	                                                            0.000000);
	
	csdp_rawscore := if(max(csdp_subscore0, csdp_subscore1, csdp_subscore2, csdp_subscore3, csdp_subscore4, csdp_subscore5, csdp_subscore6, csdp_subscore7, csdp_subscore8, csdp_subscore9, csdp_subscore10, csdp_subscore11) = NULL, NULL, sum(if(csdp_subscore0 = NULL, 0, csdp_subscore0), if(csdp_subscore1 = NULL, 0, csdp_subscore1), if(csdp_subscore2 = NULL, 0, csdp_subscore2), if(csdp_subscore3 = NULL, 0, csdp_subscore3), if(csdp_subscore4 = NULL, 0, csdp_subscore4), if(csdp_subscore5 = NULL, 0, csdp_subscore5), if(csdp_subscore6 = NULL, 0, csdp_subscore6), if(csdp_subscore7 = NULL, 0, csdp_subscore7), if(csdp_subscore8 = NULL, 0, csdp_subscore8), if(csdp_subscore9 = NULL, 0, csdp_subscore9), if(csdp_subscore10 = NULL, 0, csdp_subscore10), if(csdp_subscore11 = NULL, 0, csdp_subscore11)));
	
	csdp_lnoddsscore := csdp_rawscore + 2.236307;
	
	csdw_subscore0 := map(
	    NULL < bt_cen_bel_edu AND bt_cen_bel_edu < 15  => 0.633733,
	    15 <= bt_cen_bel_edu AND bt_cen_bel_edu < 101  => 0.250807,
	    101 <= bt_cen_bel_edu AND bt_cen_bel_edu < 179 => -0.334868,
	    179 <= bt_cen_bel_edu                          => -0.666970,
	                                                      0.000000);
	
	csdw_subscore1 := map(
	    (bt_bus_phone_match in [0, 1, 2]) => -0.247787,
	    (bt_bus_phone_match in [3])       => 0.963717,
	                                         -0.000000);
	
	csdw_subscore2 := map(
	    (bt_phone_zip_match in ['Other'])                  => -0.000000,
	    (bt_phone_zip_match in ['Mismatch', 'Not Issued']) => -0.941840,
	    (bt_phone_zip_match in ['No Mismatch'])            => 0.284076,
	                                                          -0.000000);
	
	csdw_subscore3 := map(
	    (bt_inp_addr_ownership_lvl in ['Applicant'])                => 0.881192,
	    (bt_inp_addr_ownership_lvl in ['Family'])                   => 0.321977,
	    (bt_inp_addr_ownership_lvl in ['No Ownership', 'Occupant']) => -0.103106,
	                                                                   -0.000000);
	
	csdw_subscore4 := map(
	    NULL < bt_max_ids_per_addr AND bt_max_ids_per_addr < 1 => 0.003357,
	    1 <= bt_max_ids_per_addr AND bt_max_ids_per_addr < 8   => 0.417901,
	    8 <= bt_max_ids_per_addr AND bt_max_ids_per_addr < 15  => 0.220543,
	    15 <= bt_max_ids_per_addr AND bt_max_ids_per_addr < 24 => -0.001556,
	    24 <= bt_max_ids_per_addr                              => -0.457966,
	                                                              0.000000);
	
	csdw_subscore5 := map(
	    NULL < ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 262   => 0.734610,
	    262 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 1382  => 0.259299,
	    1382 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 5766 => -0.168025,
	    5766 <= ip_dist_inp_addr_to_ip_addr                                        => -0.550711,
	                                                                                  -0.000000);
	
	csdw_subscore6 := map(
	    (ip_state_match in [0]) => -0.304143,
	    (ip_state_match in [1]) => 0.233958,
	                               -0.000000);
	
	csdw_subscore7 := map(
	    (ip_routingmethod in ['02', '16'])                               => -2.701490,
	    (ip_routingmethod in ['06', '10', '11', '12', '13', '14', '15']) => 0.278324,
	                                                                        -0.000000);
	
	csdw_subscore8 := map(
	    (ip_area_code_match in [-1, 0]) => -0.121153,
	    (ip_area_code_match in [1])     => 0.305735,
	                                       -0.000000);
	
	csdw_subscore9 := map(
	    (ip_dma_lvl in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unknown']) => -0.609101,
	    (ip_dma_lvl in ['4. DMA: US Code'])                                              => 0.110579,
	                                                                                        0.000000);
	
	csdw_subscore10 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.180080,
	    2 <= pf_wks_since_create_date                                    => 0.766414,
	                                                                        -0.000000);
	
	csdw_subscore11 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3]) => -0.682180,
	    (pf_pmt_x_avs_lvl in [4, 5, 6])    => 0.507200,
	    (pf_pmt_x_avs_lvl in [7, 8])       => 1.001554,
	                                          0.000000);
	
	csdw_subscore12 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.621981,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.396049,
	                                                          0.000000);
	
	csdw_subscore13 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 865.95     => 0.478207,
	    865.95 <= pf_order_amt_c AND pf_order_amt_c < 1362.51 => -0.197665,
	    1362.51 <= pf_order_amt_c                             => -0.669858,
	                                                             -0.000000);
	
	csdw_rawscore := if(max(csdw_subscore0, csdw_subscore1, csdw_subscore2, csdw_subscore3, csdw_subscore4, csdw_subscore5, csdw_subscore6, csdw_subscore7, csdw_subscore8, csdw_subscore9, csdw_subscore10, csdw_subscore11, csdw_subscore12, csdw_subscore13) = NULL, NULL, sum(if(csdw_subscore0 = NULL, 0, csdw_subscore0), if(csdw_subscore1 = NULL, 0, csdw_subscore1), if(csdw_subscore2 = NULL, 0, csdw_subscore2), if(csdw_subscore3 = NULL, 0, csdw_subscore3), if(csdw_subscore4 = NULL, 0, csdw_subscore4), if(csdw_subscore5 = NULL, 0, csdw_subscore5), if(csdw_subscore6 = NULL, 0, csdw_subscore6), if(csdw_subscore7 = NULL, 0, csdw_subscore7), if(csdw_subscore8 = NULL, 0, csdw_subscore8), if(csdw_subscore9 = NULL, 0, csdw_subscore9), if(csdw_subscore10 = NULL, 0, csdw_subscore10), if(csdw_subscore11 = NULL, 0, csdw_subscore11), if(csdw_subscore12 = NULL, 0, csdw_subscore12), if(csdw_subscore13 = NULL, 0, csdw_subscore13)));
	
	csdw_lnoddsscore := csdw_rawscore + 2.067644;
	
	cssp_subscore0 := map(
	    (bt_lname_eda_sourced_type in ['Other', '-1']) => -0.229827,
	    (bt_lname_eda_sourced_type in ['A'])           => -0.391237,
	    (bt_lname_eda_sourced_type in ['AP', 'P'])     => 0.712050,
	                                                      0.000000);
	
	cssp_subscore1 := map(
	    (bt_phn_miskey in [0]) => 0.226262,
	    (bt_phn_miskey in [1]) => -2.436748,
	                              -0.000000);
	
	cssp_subscore2 := map(
	    (bt_valid_phone in ['Other', 'Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.019201,
	    (bt_valid_phone in ['Invalid Phn'])                                              => -0.929597,
	                                                                                        -0.000000);
	
	cssp_subscore3 := map(
	    (bt_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.812558,
	    (bt_phone_zip_match in ['No Mismatch'])                     => 0.153614,
	                                                                   -0.000000);
	
	cssp_subscore4 := map(
	    NULL < bt_mos_since_inp_addr_fseen AND bt_mos_since_inp_addr_fseen < 0 => -0.377011,
	    0 <= bt_mos_since_inp_addr_fseen AND bt_mos_since_inp_addr_fseen < 112 => -0.094738,
	    112 <= bt_mos_since_inp_addr_fseen                                     => 0.161082,
	                                                                              -0.000000);
	
	cssp_subscore5 := map(
	    (bt_infutor_nap in [0])                      => -0.036511,
	    (bt_infutor_nap in [1])                      => -0.512696,
	    (bt_infutor_nap in [4, 6, 7, 9, 10, 11, 12]) => 0.939987,
	                                                    0.000000);
	
	cssp_subscore6 := map(
	    NULL < btst_distphoneaddr AND btst_distphoneaddr < 1 => 0.494603,
	    1 <= btst_distphoneaddr                              => -0.557075,
	                                                            0.000000);
	
	cssp_subscore7 := map(
	    (inp_product_desc in ['0'])       => 1.488697,
	    (inp_product_desc in ['2', '3', '5']) => -0.384263,
	                                       -0.000000);
	
	cssp_subscore8 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 1 => -0.288425,
	    1 <= pf_wks_since_create_date                                    => 1.146108,
	                                                                        -0.000000);
	
	cssp_subscore9 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2]) => -1.268365,
	    (pf_pmt_x_avs_lvl in [3, 4, 5]) => -0.190503,
	    (pf_pmt_x_avs_lvl in [6, 7, 8]) => 2.209155,
	                                       0.000000);
	
	cssp_subscore10 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.718638,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.298783,
	                                                          -0.000000);
	
	cssp_subscore11 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 886.89      => 0.946872,
	    886.89 <= pf_order_amt_c AND pf_order_amt_c < 1043.94  => 0.431287,
	    1043.94 <= pf_order_amt_c AND pf_order_amt_c < 1388.38 => -0.333024,
	    1388.38 <= pf_order_amt_c AND pf_order_amt_c < 2161.93 => -0.683785,
	    2161.93 <= pf_order_amt_c                              => -1.956031,
	                                                              -0.000000);
	
	cssp_rawscore := if(max(cssp_subscore0, cssp_subscore1, cssp_subscore2, cssp_subscore3, cssp_subscore4, cssp_subscore5, cssp_subscore6, cssp_subscore7, cssp_subscore8, cssp_subscore9, cssp_subscore10, cssp_subscore11) = NULL, NULL, sum(if(cssp_subscore0 = NULL, 0, cssp_subscore0), if(cssp_subscore1 = NULL, 0, cssp_subscore1), if(cssp_subscore2 = NULL, 0, cssp_subscore2), if(cssp_subscore3 = NULL, 0, cssp_subscore3), if(cssp_subscore4 = NULL, 0, cssp_subscore4), if(cssp_subscore5 = NULL, 0, cssp_subscore5), if(cssp_subscore6 = NULL, 0, cssp_subscore6), if(cssp_subscore7 = NULL, 0, cssp_subscore7), if(cssp_subscore8 = NULL, 0, cssp_subscore8), if(cssp_subscore9 = NULL, 0, cssp_subscore9), if(cssp_subscore10 = NULL, 0, cssp_subscore10), if(cssp_subscore11 = NULL, 0, cssp_subscore11)));
	
	cssp_lnoddsscore := cssp_rawscore + 3.430596;
	
	cssw_subscore0 := map(
	    NULL < bt_cen_fammar_p AND bt_cen_fammar_p < 44.3  => -0.673991,
	    44.3 <= bt_cen_fammar_p AND bt_cen_fammar_p < 75.4 => -0.110309,
	    75.4 <= bt_cen_fammar_p                            => 0.079888,
	                                                          0.000000);
	
	cssw_subscore1 := map(
	    NULL < bt_cen_span_lang AND bt_cen_span_lang < 98  => 0.237207,
	    98 <= bt_cen_span_lang AND bt_cen_span_lang < 134  => 0.096258,
	    134 <= bt_cen_span_lang AND bt_cen_span_lang < 164 => -0.021351,
	    164 <= bt_cen_span_lang                            => -0.522592,
	                                                          0.000000);
	
	cssw_subscore2 := map(
	    (bt_valid_phone in ['Other', 'Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.074043,
	    (bt_valid_phone in ['Invalid Phn'])                                              => -1.703067,
	                                                                                        0.000000);
	
	cssw_subscore3 := map(
	    (bt_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.757006,
	    (bt_phone_zip_match in ['No Mismatch'])                     => 0.245469,
	                                                                   -0.000000);
	
	cssw_subscore4 := map(
	    NULL < bt_inp_addr_lres AND bt_inp_addr_lres < 1 => -0.539026,
	    1 <= bt_inp_addr_lres AND bt_inp_addr_lres < 11  => -0.255532,
	    11 <= bt_inp_addr_lres AND bt_inp_addr_lres < 69 => 0.060628,
	    69 <= bt_inp_addr_lres                           => 0.278745,
	                                                        -0.000000);
	
	cssw_subscore5 := map(
	    NULL < bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 0 => 0.032780,
	    0 <= bt_adls_per_sfd_addr AND bt_adls_per_sfd_addr < 1   => -0.856720,
	    1 <= bt_adls_per_sfd_addr                                => 0.024003,
	                                                                0.000000);
	
	cssw_subscore6 := map(
	    NULL < ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 1696  => 0.288665,
	    1696 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 2658 => 0.065459,
	    2658 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 4363 => -0.058163,
	    4363 <= ip_dist_inp_addr_to_ip_addr                                        => -0.486352,
	                                                                                  0.000000);
	
	cssw_subscore7 := map(
	    (btst_email_first_x_last_score in ['-1:-1', '0:-1', '0:0'])                          => -0.485536,
	    (btst_email_first_x_last_score in ['0:1', '0:2', '1:0', '1:1', '1:2', '2:0', '2:1']) => 0.204174,
	    (btst_email_first_x_last_score in ['1:3', '2:2', '2:3', '3:1', '3:2', '3:3'])        => 0.454081,
	                                                                                            0.000000);
	
	cssw_subscore8 := map(
	    NULL < btst_distphoneaddr AND btst_distphoneaddr < 1 => 0.412639,
	    1 <= btst_distphoneaddr AND btst_distphoneaddr < 5   => -0.248755,
	    5 <= btst_distphoneaddr AND btst_distphoneaddr < 39  => -0.430845,
	    39 <= btst_distphoneaddr                             => -0.819985,
	                                                            -0.000000);
	
	cssw_subscore9 := map(
	    (ip_state_match in [0]) => -0.454830,
	    (ip_state_match in [1]) => 0.257430,
	                               0.000000);
	
	cssw_subscore10 := map(
	    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.243727,
	    (ip_routingmethod in ['02', '16'])                                        => -2.451539,
	                                                                                 0.000000);
	
	cssw_subscore11 := map(
	    (ip_dma_lvl in ['Other', '1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unknown']) => -0.594996,
	    (ip_dma_lvl in ['4. DMA: US Code'])                                                       => 0.049414,
	                                                                                                 -0.000000);
	
	cssw_subscore12 := map(
	    NULL < btst_email_domain_risk_level AND btst_email_domain_risk_level < 3 => 0.980801,
	    3 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 6   => -0.046909,
	    6 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 7   => -0.636418,
	    7 <= btst_email_domain_risk_level                                        => -1.209946,
	                                                                                -0.000000);
	
	cssw_subscore13 := map(
	    (inp_product_desc in ['0'])       => 0.802739,
	    (inp_product_desc in ['2', '3', '5']) => -0.188794,
	                                       -0.000000);
	
	cssw_subscore14 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 1 => -0.260271,
	    1 <= pf_wks_since_create_date AND pf_wks_since_create_date < 105 => 0.441122,
	    105 <= pf_wks_since_create_date                                  => 1.045923,
	                                                                        0.000000);
	
	cssw_subscore15 := map(
	    (pf_pmt_x_avs_lvl in [0, 1])       => -1.785873,
	    (pf_pmt_x_avs_lvl in [2, 3])       => -1.226916,
	    (pf_pmt_x_avs_lvl in [4])          => -0.460956,
	    (pf_pmt_x_avs_lvl in [5, 6, 7, 8]) => 0.422395,
	                                          -0.000000);
	
	cssw_subscore16 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.456983,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.201979,
	                                                          -0.000000);
	
	cssw_subscore17 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 674.95     => 0.621425,
	    674.95 <= pf_order_amt_c AND pf_order_amt_c < 1050.33 => 0.163394,
	    1050.33 <= pf_order_amt_c                             => -0.704505,
	                                                             -0.000000);
	
	cssw_rawscore := if(max(cssw_subscore0, cssw_subscore1, cssw_subscore2, cssw_subscore3, cssw_subscore4, cssw_subscore5, cssw_subscore6, cssw_subscore7, cssw_subscore8, cssw_subscore9, cssw_subscore10, cssw_subscore11, cssw_subscore12, cssw_subscore13, cssw_subscore14, cssw_subscore15, cssw_subscore16, cssw_subscore17) = NULL, NULL, sum(if(cssw_subscore0 = NULL, 0, cssw_subscore0), if(cssw_subscore1 = NULL, 0, cssw_subscore1), if(cssw_subscore2 = NULL, 0, cssw_subscore2), if(cssw_subscore3 = NULL, 0, cssw_subscore3), if(cssw_subscore4 = NULL, 0, cssw_subscore4), if(cssw_subscore5 = NULL, 0, cssw_subscore5), if(cssw_subscore6 = NULL, 0, cssw_subscore6), if(cssw_subscore7 = NULL, 0, cssw_subscore7), if(cssw_subscore8 = NULL, 0, cssw_subscore8), if(cssw_subscore9 = NULL, 0, cssw_subscore9), if(cssw_subscore10 = NULL, 0, cssw_subscore10), if(cssw_subscore11 = NULL, 0, cssw_subscore11), if(cssw_subscore12 = NULL, 0, cssw_subscore12), if(cssw_subscore13 = NULL, 0, cssw_subscore13), if(cssw_subscore14 = NULL, 0, cssw_subscore14), if(cssw_subscore15 = NULL, 0, cssw_subscore15), if(cssw_subscore16 = NULL, 0, cssw_subscore16), if(cssw_subscore17 = NULL, 0, cssw_subscore17)));
	
	cssw_lnoddsscore := cssw_rawscore + 3.929598;
	
	cddp_subscore0 := map(
	    NULL < st_cen_high_ed AND st_cen_high_ed < 9.2  => -0.507210,
	    9.2 <= st_cen_high_ed AND st_cen_high_ed < 32.2 => -0.134541,
	    32.2 <= st_cen_high_ed                          => 0.662251,
	                                                       0.000000);
	
	cddp_subscore1 := map(
	    (st_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.756893,
	    (st_phone_zip_match in ['No Mismatch'])                     => 0.587999,
	                                                                   0.000000);
	
	cddp_subscore2 := map(
	    (st_inp_addr_res_or_business in ['Other', '-1', 'A', 'C']) => -0.125675,
	    (st_inp_addr_res_or_business in ['B'])                     => 0.769144,
	                                                                  0.000000);
	
	cddp_subscore3 := map(
	    NULL < st_inq_collection_recency AND st_inq_collection_recency < 1 => 0.349100,
	    1 <= st_inq_collection_recency                                     => -0.176113,
	                                                                          0.000000);
	
	cddp_subscore4 := map(
	    NULL < st_inq_highriskcredit_recency AND st_inq_highriskcredit_recency < 1 => 0.447674,
	    1 <= st_inq_highriskcredit_recency                                         => -1.037326,
	                                                                                  0.000000);
	
	cddp_subscore5 := map(
	    NULL < st_mos_since_impulse_first_seen AND st_mos_since_impulse_first_seen < 0 => 0.109601,
	    0 <= st_mos_since_impulse_first_seen                                           => -1.192947,
	                                                                                      0.000000);
	
	cddp_subscore6 := map(
	    NULL < st_email_domain_free_count AND st_email_domain_free_count < 1 => 0.208671,
	    1 <= st_email_domain_free_count AND st_email_domain_free_count < 2   => 0.194674,
	    2 <= st_email_domain_free_count                                      => -0.542128,
	                                                                            0.000000);
	
	cddp_subscore7 := map(
	    NULL < st_derog_ratio AND st_derog_ratio < 110 => -0.352978,
	    110 <= st_derog_ratio                          => 0.325417,
	                                                      0.000000);
	
	cddp_subscore8 := map(
	    NULL < st_average_rel_income AND st_average_rel_income < 25000   => -0.000000,
	    25000 <= st_average_rel_income AND st_average_rel_income < 49000 => -0.306750,
	    49000 <= st_average_rel_income AND st_average_rel_income < 62000 => -0.062545,
	    62000 <= st_average_rel_income                                   => 0.531698,
	                                                                        -0.000000);
	
	cddp_subscore9 := map(
	    NULL < btst_distphone2addr2 AND btst_distphone2addr2 < 26 => 0.127290,
	    26 <= btst_distphone2addr2                                => -0.124436,
	                                                                 -0.000000);
	
	cddp_subscore10 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 124  => 1.593100,
	    124 <= btst_distaddraddr2 AND btst_distaddraddr2 < 421  => 0.005261,
	    421 <= btst_distaddraddr2 AND btst_distaddraddr2 < 1859 => -0.777762,
	    1859 <= btst_distaddraddr2                              => -1.394210,
	                                                               0.000000);
	
	cddp_subscore11 := map(
	    (inp_product_desc in ['0'])       => 1.998082,
	    (inp_product_desc in ['2', '3', '5']) => -0.322148,
	                                       0.000000);
	
	cddp_subscore12 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 1 => -0.743033,
	    1 <= pf_wks_since_create_date                                    => 1.701799,
	                                                                        0.000000);
	
	cddp_subscore13 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4, 5]) => -0.406675,
	    (pf_pmt_x_avs_lvl in [6, 7, 8])          => 1.840670,
	                                                0.000000);
	
	cddp_subscore14 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.370656,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.146733,
	                                                          -0.000000);
	
	cddp_rawscore := if(max(cddp_subscore0, cddp_subscore1, cddp_subscore2, cddp_subscore3, cddp_subscore4, cddp_subscore5, cddp_subscore6, cddp_subscore7, cddp_subscore8, cddp_subscore9, cddp_subscore10, cddp_subscore11, cddp_subscore12, cddp_subscore13, cddp_subscore14) = NULL, NULL, sum(if(cddp_subscore0 = NULL, 0, cddp_subscore0), if(cddp_subscore1 = NULL, 0, cddp_subscore1), if(cddp_subscore2 = NULL, 0, cddp_subscore2), if(cddp_subscore3 = NULL, 0, cddp_subscore3), if(cddp_subscore4 = NULL, 0, cddp_subscore4), if(cddp_subscore5 = NULL, 0, cddp_subscore5), if(cddp_subscore6 = NULL, 0, cddp_subscore6), if(cddp_subscore7 = NULL, 0, cddp_subscore7), if(cddp_subscore8 = NULL, 0, cddp_subscore8), if(cddp_subscore9 = NULL, 0, cddp_subscore9), if(cddp_subscore10 = NULL, 0, cddp_subscore10), if(cddp_subscore11 = NULL, 0, cddp_subscore11), if(cddp_subscore12 = NULL, 0, cddp_subscore12), if(cddp_subscore13 = NULL, 0, cddp_subscore13), if(cddp_subscore14 = NULL, 0, cddp_subscore14)));
	
	cddp_lnoddsscore := cddp_rawscore + 1.016923;
	
	cddw_subscore0 := map(
	    (bt_valid_phone in ['Other'])                                           => 0.000000,
	    (bt_valid_phone in ['Invalid Phn'])                                     => -1.293135,
	    (bt_valid_phone in ['Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.063589,
	                                                                               0.000000);
	
	cddw_subscore1 := map(
	    NULL < bt_inq_retail_count12 AND bt_inq_retail_count12 < 1 => -0.122904,
	    1 <= bt_inq_retail_count12                                 => 0.642364,
	                                                                  0.000000);
	
	cddw_subscore2 := map(
	    NULL < st_cen_span_lang AND st_cen_span_lang < 120 => 0.230280,
	    120 <= st_cen_span_lang AND st_cen_span_lang < 180 => -0.017101,
	    180 <= st_cen_span_lang                            => -0.752252,
	                                                          -0.000000);
	
	cddw_subscore3 := map(
	    (st_bus_phone_match in [0, 1, 2]) => -0.149502,
	    (st_bus_phone_match in [3])       => 1.073415,
	                                         0.000000);
	
	cddw_subscore4 := map(
	    (st_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.804858,
	    (st_phone_zip_match in ['No Mismatch'])                     => 0.347205,
	                                                                   0.000000);
	
	cddw_subscore5 := map(
	    NULL < st_max_ids_per_addr AND st_max_ids_per_addr < 1 => -0.041803,
	    1 <= st_max_ids_per_addr AND st_max_ids_per_addr < 8   => 0.586422,
	    8 <= st_max_ids_per_addr AND st_max_ids_per_addr < 14  => 0.135140,
	    14 <= st_max_ids_per_addr                              => -0.334840,
	                                                              -0.000000);
	
	cddw_subscore6 := map(
	    NULL < st_inq_ssns_per_addr AND st_inq_ssns_per_addr < 1 => 0.279262,
	    1 <= st_inq_ssns_per_addr AND st_inq_ssns_per_addr < 4   => -0.195400,
	    4 <= st_inq_ssns_per_addr                                => -0.978715,
	                                                                -0.000000);
	
	cddw_subscore7 := map(
	    NULL < st_unreleased_liens_ct AND st_unreleased_liens_ct < 1 => 0.167434,
	    1 <= st_unreleased_liens_ct                                  => -0.586321,
	                                                                    0.000000);
	
	cddw_subscore8 := map(
	    NULL < st_average_rel_education AND st_average_rel_education < 8 => 0.295470,
	    8 <= st_average_rel_education AND st_average_rel_education < 14  => -0.660061,
	    14 <= st_average_rel_education AND st_average_rel_education < 16 => -0.040620,
	    16 <= st_average_rel_education                                   => 0.657375,
	                                                                        0.000000);
	
	cddw_subscore9 := map(
	    NULL < st_rel_derog_summary AND st_rel_derog_summary < 0 => -0.345688,
	    0 <= st_rel_derog_summary AND st_rel_derog_summary < 1   => 0.506954,
	    1 <= st_rel_derog_summary AND st_rel_derog_summary < 3   => 0.244305,
	    3 <= st_rel_derog_summary AND st_rel_derog_summary < 6   => -0.104159,
	    6 <= st_rel_derog_summary                                => -1.473968,
	                                                                0.000000);
	
	cddw_subscore10 := map(
	    (st_wealth_index in [1, 2]) => -0.542240,
	    (st_wealth_index in [3])    => -0.082347,
	    (st_wealth_index in [4])    => 0.289297,
	    (st_wealth_index in [5, 6]) => 0.707394,
	                                   0.000000);
	
	cddw_subscore11 := map(
	    NULL < ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 622   => 0.499734,
	    622 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 1361  => 0.271208,
	    1361 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 4304 => 0.014731,
	    4304 <= ip_dist_inp_addr_to_ip_addr                                        => -0.389554,
	                                                                                  0.000000);
	
	cddw_subscore12 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 15   => 0.978090,
	    15 <= btst_distaddraddr2 AND btst_distaddraddr2 < 336   => 0.278144,
	    336 <= btst_distaddraddr2 AND btst_distaddraddr2 < 1570 => -0.500134,
	    1570 <= btst_distaddraddr2                              => -0.812293,
	                                                               0.000000);
	
	cddw_subscore13 := map(
	    NULL < btst_distaddrphone2 AND btst_distaddrphone2 < 582 => 0.316998,
	    582 <= btst_distaddrphone2                               => -0.899841,
	                                                                -0.000000);
	
	cddw_subscore14 := map(
	    (btst_relatives_lvl in ['1. BOTH DID 0', '2. BILLTO DID 0', '7. NO RELATION']) => 0.139088,
	    (btst_relatives_lvl in ['2. SHIPTO DID 0'])                                    => -0.281773,
	                                                                                      -0.000000);
	
	cddw_subscore15 := map(
	    (ip_continent in ['Africa', 'Asia', 'Australia', 'Europe', 'South America']) => -0.531435,
	    (ip_continent in ['Other'])                                                  => -0.000000,
	    (ip_continent in ['North America'])                                          => 0.041160,
	                                                                                    -0.000000);
	
	cddw_subscore16 := map(
	    (ip_state_match in [0]) => -0.249295,
	    (ip_state_match in [1]) => 0.250305,
	                               -0.000000);
	
	cddw_subscore17 := map(
	    (ip_routingmethod in ['02', '16'])                               => -2.930425,
	    (ip_routingmethod in ['06', '10', '11', '12', '13', '14', '15']) => 0.398509,
	                                                                        0.000000);
	
	cddw_subscore18 := map(
	    (ip_area_code_match in [-1]) => -0.000000,
	    (ip_area_code_match in [0])  => -0.170297,
	    (ip_area_code_match in [1])  => 0.463193,
	                                    -0.000000);
	
	cddw_subscore19 := map(
	    NULL < btst_email_domain_risk_level AND btst_email_domain_risk_level < 4 => 0.554543,
	    4 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 5   => 0.323535,
	    5 <= btst_email_domain_risk_level                                        => -0.721731,
	                                                                                0.000000);
	
	cddw_subscore20 := map(
	    (inp_product_desc in ['0'])       => 1.147461,
	    (inp_product_desc in ['2', '3', '5']) => -0.208430,
	                                       0.000000);
	
	cddw_subscore21 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.302939,
	    2 <= pf_wks_since_create_date                                    => 0.835780,
	                                                                        0.000000);
	
	cddw_subscore22 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4]) => -0.522385,
	    (pf_pmt_x_avs_lvl in [5])             => 0.012621,
	    (pf_pmt_x_avs_lvl in [6, 7, 8])       => 0.361014,
	                                             0.000000);
	
	cddw_subscore23 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.888481,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.827177,
	                                                          0.000000);
	
	cddw_subscore24 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 506.7 => 0.592744,
	    506.7 <= pf_order_amt_c                          => -0.116785,
	                                                        0.000000);
	
	cddw_rawscore := if(max(cddw_subscore0, cddw_subscore1, cddw_subscore2, cddw_subscore3, cddw_subscore4, cddw_subscore5, cddw_subscore6, cddw_subscore7, cddw_subscore8, cddw_subscore9, cddw_subscore10, cddw_subscore11, cddw_subscore12, cddw_subscore13, cddw_subscore14, cddw_subscore15, cddw_subscore16, cddw_subscore17, cddw_subscore18, cddw_subscore19, cddw_subscore20, cddw_subscore21, cddw_subscore22, cddw_subscore23, cddw_subscore24) = NULL, NULL, sum(if(cddw_subscore0 = NULL, 0, cddw_subscore0), if(cddw_subscore1 = NULL, 0, cddw_subscore1), if(cddw_subscore2 = NULL, 0, cddw_subscore2), if(cddw_subscore3 = NULL, 0, cddw_subscore3), if(cddw_subscore4 = NULL, 0, cddw_subscore4), if(cddw_subscore5 = NULL, 0, cddw_subscore5), if(cddw_subscore6 = NULL, 0, cddw_subscore6), if(cddw_subscore7 = NULL, 0, cddw_subscore7), if(cddw_subscore8 = NULL, 0, cddw_subscore8), if(cddw_subscore9 = NULL, 0, cddw_subscore9), if(cddw_subscore10 = NULL, 0, cddw_subscore10), if(cddw_subscore11 = NULL, 0, cddw_subscore11), if(cddw_subscore12 = NULL, 0, cddw_subscore12), if(cddw_subscore13 = NULL, 0, cddw_subscore13), if(cddw_subscore14 = NULL, 0, cddw_subscore14), if(cddw_subscore15 = NULL, 0, cddw_subscore15), if(cddw_subscore16 = NULL, 0, cddw_subscore16), if(cddw_subscore17 = NULL, 0, cddw_subscore17), if(cddw_subscore18 = NULL, 0, cddw_subscore18), if(cddw_subscore19 = NULL, 0, cddw_subscore19), if(cddw_subscore20 = NULL, 0, cddw_subscore20), if(cddw_subscore21 = NULL, 0, cddw_subscore21), if(cddw_subscore22 = NULL, 0, cddw_subscore22), if(cddw_subscore23 = NULL, 0, cddw_subscore23), if(cddw_subscore24 = NULL, 0, cddw_subscore24)));
	
	cddw_lnoddsscore := cddw_rawscore + 1.852670;
	
	cdsp_subscore0 := map(
	    (bt_addr_ver_sources in ['Other'])                                   => -0.000000,
	    (bt_addr_ver_sources in ['Addr not Verd'])                           => -0.670329,
	    (bt_addr_ver_sources in ['NonPhn Only', 'Phn & NonPhn', 'Phn Only']) => 0.074401,
	                                                                            -0.000000);
	
	cdsp_subscore1 := map(
	    NULL < bt_max_ids_per_addr AND bt_max_ids_per_addr < 8 => 0.381430,
	    8 <= bt_max_ids_per_addr                               => -0.232447,
	                                                              0.000000);
	
	cdsp_subscore2 := map(
	    NULL < bt_inq_highriskcredit_recency AND bt_inq_highriskcredit_recency < 1 => 0.217867,
	    1 <= bt_inq_highriskcredit_recency                                         => -1.835617,
	                                                                                  0.000000);
	
	cdsp_subscore3 := map(
	    (bt_wealth_index in [1, 3])    => -0.493831,
	    (bt_wealth_index in [2, 4, 5]) => 0.142674,
	    (bt_wealth_index in [6])       => 0.503472,
	                                      -0.000000);
	
	cdsp_subscore4 := map(
	    (st_cvi in [0, 10])      => -0.195384,
	    (st_cvi in [20, 30, 40]) => 0.310259,
	                                0.000000);
	
	cdsp_subscore5 := map(
	    NULL < st_mos_src_white_pages_adl_fseen AND st_mos_src_white_pages_adl_fseen < 0 => -0.255362,
	    0 <= st_mos_src_white_pages_adl_fseen                                            => 0.374962,
	                                                                                        0.000000);
	
	cdsp_subscore6 := map(
	    (st_phone_zip_match in ['Other'])                  => -0.000000,
	    (st_phone_zip_match in ['Mismatch', 'Not Issued']) => -1.052357,
	    (st_phone_zip_match in ['No Mismatch'])            => 0.540618,
	                                                          -0.000000);
	
	cdsp_subscore7 := map(
	    (st_inp_addr_naprop in [0, 1, 2]) => -0.210378,
	    (st_inp_addr_naprop in [3, 4])    => 0.774914,
	                                         -0.000000);
	
	cdsp_subscore8 := map(
	    NULL < st_max_ids_per_addr_c6 AND st_max_ids_per_addr_c6 < 2 => 0.104846,
	    2 <= st_max_ids_per_addr_c6                                  => -0.520549,
	                                                                    0.000000);
	
	cdsp_subscore9 := map(
	    (inp_product_desc in ['0'])       => 1.350678,
	    (inp_product_desc in ['2', '3', '5']) => -0.289850,
	                                       0.000000);
	
	cdsp_subscore10 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 2 => -0.077944,
	    2 <= pf_wks_since_create_date                                    => 0.304487,
	                                                                        0.000000);
	
	cdsp_subscore11 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3, 4]) => -0.584725,
	    (pf_pmt_x_avs_lvl in [5, 6, 7, 8])    => 0.169689,
	                                             -0.000000);
	
	cdsp_subscore12 := map(
	    (pf_cid_result in ['Invalid', 'No Match', 'Null', 'Other']) => -0.719179,
	    (pf_cid_result in ['Match'])                                => 0.104244,
	                                                                   0.000000);
	
	cdsp_subscore13 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.222071,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.095918,
	                                                          -0.000000);
	
	cdsp_subscore14 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 887.82 => 0.167983,
	    887.82 <= pf_order_amt_c                          => -0.288526,
	                                                         -0.000000);
	
	cdsp_rawscore := if(max(cdsp_subscore0, cdsp_subscore1, cdsp_subscore2, cdsp_subscore3, cdsp_subscore4, cdsp_subscore5, cdsp_subscore6, cdsp_subscore7, cdsp_subscore8, cdsp_subscore9, cdsp_subscore10, cdsp_subscore11, cdsp_subscore12, cdsp_subscore13, cdsp_subscore14) = NULL, NULL, sum(if(cdsp_subscore0 = NULL, 0, cdsp_subscore0), if(cdsp_subscore1 = NULL, 0, cdsp_subscore1), if(cdsp_subscore2 = NULL, 0, cdsp_subscore2), if(cdsp_subscore3 = NULL, 0, cdsp_subscore3), if(cdsp_subscore4 = NULL, 0, cdsp_subscore4), if(cdsp_subscore5 = NULL, 0, cdsp_subscore5), if(cdsp_subscore6 = NULL, 0, cdsp_subscore6), if(cdsp_subscore7 = NULL, 0, cdsp_subscore7), if(cdsp_subscore8 = NULL, 0, cdsp_subscore8), if(cdsp_subscore9 = NULL, 0, cdsp_subscore9), if(cdsp_subscore10 = NULL, 0, cdsp_subscore10), if(cdsp_subscore11 = NULL, 0, cdsp_subscore11), if(cdsp_subscore12 = NULL, 0, cdsp_subscore12), if(cdsp_subscore13 = NULL, 0, cdsp_subscore13), if(cdsp_subscore14 = NULL, 0, cdsp_subscore14)));
	
	cdsp_lnoddsscore := cdsp_rawscore + 4.393730;
	
	cdsw_subscore0 := map(
	    (bt_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.630524,
	    (bt_phone_zip_match in ['No Mismatch'])                     => 0.126836,
	                                                                   -0.000000);
	
	cdsw_subscore1 := map(
	    NULL < st_mos_src_bureau_adl_fseen AND st_mos_src_bureau_adl_fseen < 0 => -1.073411,
	    0 <= st_mos_src_bureau_adl_fseen AND st_mos_src_bureau_adl_fseen < 154 => -0.249758,
	    154 <= st_mos_src_bureau_adl_fseen                                     => 0.105305,
	                                                                              0.000000);
	
	cdsw_subscore2 := map(
	    (st_bus_name_match in [0])       => -0.143463,
	    (st_bus_name_match in [1])       => 0.031325,
	    (st_bus_name_match in [2, 3, 4]) => 0.604187,
	                                        0.000000);
	
	cdsw_subscore3 := map(
	    (st_valid_phone in ['Other', 'Valid Bus Phn', 'Valid Oth Phn', 'Valid Res Phn']) => 0.032430,
	    (st_valid_phone in ['Invalid Phn'])                                              => -1.725589,
	                                                                                        0.000000);
	
	cdsw_subscore4 := map(
	    (st_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.781328,
	    (st_phone_zip_match in ['No Mismatch'])                     => 0.183664,
	                                                                   0.000000);
	
	cdsw_subscore5 := map(
	    (st_inp_addr_eda_sourced in [0]) => -0.056579,
	    (st_inp_addr_eda_sourced in [1]) => 0.301382,
	                                        0.000000);
	
	cdsw_subscore6 := map(
	    (st_inp_addr_ownership_lvl in ['Other'])               => 0.000000,
	    (st_inp_addr_ownership_lvl in ['Applicant', 'Family']) => 0.183076,
	    (st_inp_addr_ownership_lvl in ['No Ownership'])        => 0.092377,
	    (st_inp_addr_ownership_lvl in ['Occupant'])            => -0.354966,
	                                                              0.000000);
	
	cdsw_subscore7 := map(
	    NULL < st_phones_per_sfd_addr AND st_phones_per_sfd_addr < 0 => 0.000000,
	    0 <= st_phones_per_sfd_addr AND st_phones_per_sfd_addr < 1   => -0.218001,
	    1 <= st_phones_per_sfd_addr                                  => 0.165252,
	                                                                    0.000000);
	
	cdsw_subscore8 := map(
	    NULL < st_closest_rel_distance AND st_closest_rel_distance < 25 => -0.000000,
	    25 <= st_closest_rel_distance AND st_closest_rel_distance < 100 => 0.099366,
	    100 <= st_closest_rel_distance                                  => -0.495193,
	                                                                       -0.000000);
	
	cdsw_subscore9 := map(
	    (btst_email_first_x_last_score in ['-1:-1', '0:0'])                                  => -0.476265,
	    (btst_email_first_x_last_score in ['0:1', '0:2', '1:0', '1:1', '1:2', '2:0', '2:1']) => 0.081944,
	    (btst_email_first_x_last_score in ['1:3', '2:2', '2:3', '3:1', '3:2', '3:3'])        => 0.539050,
	                                                                                            0.000000);
	
	cdsw_subscore10 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 80 => 0.331011,
	    80 <= btst_distaddraddr2                              => -0.648921,
	                                                             0.000000);
	
	cdsw_subscore11 := map(
	    (ip_continent in ['Africa', 'Asia', 'Australia', 'Europe', 'Other', 'South America']) => -0.594825,
	    (ip_continent in ['North America'])                                                   => 0.027132,
	                                                                                             0.000000);
	
	cdsw_subscore12 := map(
	    (ip_state_match in [0]) => -0.406900,
	    (ip_state_match in [1]) => 0.249906,
	                               0.000000);
	
	cdsw_subscore13 := map(
	    (ip_routingmethod in ['Other', '06', '10', '11', '12', '13', '14', '15']) => 0.108549,
	    (ip_routingmethod in ['02', '16'])                                        => -2.010029,
	                                                                                 0.000000);
	
	cdsw_subscore14 := map(
	    (inp_product_desc in ['0'])       => 0.883471,
	    (inp_product_desc in ['2', '3', '5']) => -0.231088,
	                                       -0.000000);
	
	cdsw_subscore15 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 3 => -0.243230,
	    3 <= pf_wks_since_create_date                                    => 0.742080,
	                                                                        0.000000);
	
	cdsw_subscore16 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2])    => -1.158133,
	    (pf_pmt_x_avs_lvl in [3, 4])       => -0.994996,
	    (pf_pmt_x_avs_lvl in [5, 6, 7, 8]) => 0.223648,
	                                          0.000000);
	
	cdsw_subscore17 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.513327,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.260541,
	                                                          -0.000000);
	
	cdsw_subscore18 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 854.24 => 0.155055,
	    854.24 <= pf_order_amt_c                          => -0.251278,
	                                                         -0.000000);
	
	cdsw_rawscore := if(max(cdsw_subscore0, cdsw_subscore1, cdsw_subscore2, cdsw_subscore3, cdsw_subscore4, cdsw_subscore5, cdsw_subscore6, cdsw_subscore7, cdsw_subscore8, cdsw_subscore9, cdsw_subscore10, cdsw_subscore11, cdsw_subscore12, cdsw_subscore13, cdsw_subscore14, cdsw_subscore15, cdsw_subscore16, cdsw_subscore17, cdsw_subscore18) = NULL, NULL, sum(if(cdsw_subscore0 = NULL, 0, cdsw_subscore0), if(cdsw_subscore1 = NULL, 0, cdsw_subscore1), if(cdsw_subscore2 = NULL, 0, cdsw_subscore2), if(cdsw_subscore3 = NULL, 0, cdsw_subscore3), if(cdsw_subscore4 = NULL, 0, cdsw_subscore4), if(cdsw_subscore5 = NULL, 0, cdsw_subscore5), if(cdsw_subscore6 = NULL, 0, cdsw_subscore6), if(cdsw_subscore7 = NULL, 0, cdsw_subscore7), if(cdsw_subscore8 = NULL, 0, cdsw_subscore8), if(cdsw_subscore9 = NULL, 0, cdsw_subscore9), if(cdsw_subscore10 = NULL, 0, cdsw_subscore10), if(cdsw_subscore11 = NULL, 0, cdsw_subscore11), if(cdsw_subscore12 = NULL, 0, cdsw_subscore12), if(cdsw_subscore13 = NULL, 0, cdsw_subscore13), if(cdsw_subscore14 = NULL, 0, cdsw_subscore14), if(cdsw_subscore15 = NULL, 0, cdsw_subscore15), if(cdsw_subscore16 = NULL, 0, cdsw_subscore16), if(cdsw_subscore17 = NULL, 0, cdsw_subscore17), if(cdsw_subscore18 = NULL, 0, cdsw_subscore18)));
	
	cdsw_lnoddsscore := cdsw_rawscore + 4.062286;
	
	cdop_subscore0 := map(
	    (bt_phn_miskey in [0]) => 0.221746,
	    (bt_phn_miskey in [1]) => -3.316749,
	                              -0.000000);
	
	cdop_subscore1 := map(
	    (bt_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.418664,
	    (bt_phone_zip_match in ['No Mismatch'])                     => 0.146210,
	                                                                   -0.000000);
	
	cdop_subscore2 := map(
	    NULL < st_cen_fammar_p AND st_cen_fammar_p < 68 => -0.532341,
	    68 <= st_cen_fammar_p                           => 0.265777,
	                                                       0.000000);
	
	cdop_subscore3 := map(
	    NULL < st_cen_med_inc AND st_cen_med_inc < 54 => -0.637403,
	    54 <= st_cen_med_inc AND st_cen_med_inc < 139 => 0.095762,
	    139 <= st_cen_med_inc                         => 0.476238,
	                                                     -0.000000);
	
	cdop_subscore4 := map(
	    (st_full_name_ver_sources in ['Name not Verd'])                           => -0.153216,
	    (st_full_name_ver_sources in ['NonPhn Only', 'Phn & NonPhn', 'Phn Only']) => 0.537503,
	                                                                                 -0.000000);
	
	cdop_subscore5 := map(
	    (st_addr_ver_sources in ['Other'])                    => 0.000000,
	    (st_addr_ver_sources in ['Addr not Verd'])            => -0.587684,
	    (st_addr_ver_sources in ['NonPhn Only'])              => 0.169598,
	    (st_addr_ver_sources in ['Phn & NonPhn', 'Phn Only']) => 0.888383,
	                                                             0.000000);
	
	cdop_subscore6 := map(
	    (st_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.653059,
	    (st_phone_zip_match in ['No Mismatch'])                     => 0.347699,
	                                                                   0.000000);
	
	// cdop_subscore7 := map(
	    // NULL < st_add1_util_sum AND st_add1_util_sum < 2 => 0.321209,
	    // 2 <= st_add1_util_sum                            => -0.500817,
	                                                        // -0.000000);
	
	cdop_subscore8 := map(
	    (st_inp_addr_res_or_business in ['Other', '-1', 'A', 'C']) => -0.422723,
	    (st_inp_addr_res_or_business in ['B'])                     => 1.438618,
	                                                                  -0.000000);
	
	cdop_subscore9 := map(
	    NULL < st_max_ids_per_sfd_addr_c6 AND st_max_ids_per_sfd_addr_c6 < 0 => 0.234515,
	    0 <= st_max_ids_per_sfd_addr_c6 AND st_max_ids_per_sfd_addr_c6 < 1   => 0.166370,
	    1 <= st_max_ids_per_sfd_addr_c6                                      => -0.436924,
	                                                                            -0.000000);
	
	cdop_subscore10 := map(
	    NULL < st_inq_adls_per_addr AND st_inq_adls_per_addr < 1 => 0.402955,
	    1 <= st_inq_adls_per_addr AND st_inq_adls_per_addr < 2   => -0.150631,
	    2 <= st_inq_adls_per_addr AND st_inq_adls_per_addr < 3   => -0.404640,
	    3 <= st_inq_adls_per_addr                                => -0.919981,
	                                                                0.000000);
	
	cdop_subscore11 := map(
	    (st_nap_phn_ver_x_inf_phn_ver in ['-1', '0-0', '0-1'])         => -0.587503,
	    (st_nap_phn_ver_x_inf_phn_ver in ['0-3', '3-0', '3-1'])        => 1.468268,
	    (st_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1', '2-3', '3-3']) => 0.967026,
	                                                                      -0.000000);
	
	cdop_subscore12 := map(
	    NULL < btst_distphone2addr2 AND btst_distphone2addr2 < 6 => 0.301346,
	    6 <= btst_distphone2addr2 AND btst_distphone2addr2 < 118 => -0.325652,
	    118 <= btst_distphone2addr2                              => -0.134553,
	                                                                0.000000);
	
	cdop_subscore13 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 41 => 1.379582,
	    41 <= btst_distaddraddr2                              => -1.050535,
	                                                             -0.000000);
	
	cdop_subscore14 := map(
	    (inp_product_desc in ['0'])       => 1.012137,
	    (inp_product_desc in ['2', '3', '5']) => -0.191775,
	                                       -0.000000);
	
	cdop_subscore15 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 1 => -0.361083,
	    1 <= pf_wks_since_create_date                                    => 1.377574,
	                                                                        -0.000000);
	
	cdop_subscore16 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.794311,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.469674,
	                                                          -0.000000);
	
	// removed cdop_subscore7 with utility change
	cdop_rawscore := if(max(cdop_subscore0, cdop_subscore1, cdop_subscore2, cdop_subscore3, cdop_subscore4, cdop_subscore5, cdop_subscore6, cdop_subscore8, cdop_subscore9, cdop_subscore10, cdop_subscore11, cdop_subscore12, cdop_subscore13, cdop_subscore14, cdop_subscore15, cdop_subscore16) = NULL, NULL, sum(if(cdop_subscore0 = NULL, 0, cdop_subscore0), if(cdop_subscore1 = NULL, 0, cdop_subscore1), if(cdop_subscore2 = NULL, 0, cdop_subscore2), if(cdop_subscore3 = NULL, 0, cdop_subscore3), if(cdop_subscore4 = NULL, 0, cdop_subscore4), if(cdop_subscore5 = NULL, 0, cdop_subscore5), if(cdop_subscore6 = NULL, 0, cdop_subscore6), if(cdop_subscore8 = NULL, 0, cdop_subscore8), if(cdop_subscore9 = NULL, 0, cdop_subscore9), if(cdop_subscore10 = NULL, 0, cdop_subscore10), if(cdop_subscore11 = NULL, 0, cdop_subscore11), if(cdop_subscore12 = NULL, 0, cdop_subscore12), if(cdop_subscore13 = NULL, 0, cdop_subscore13), if(cdop_subscore14 = NULL, 0, cdop_subscore14), if(cdop_subscore15 = NULL, 0, cdop_subscore15), if(cdop_subscore16 = NULL, 0, cdop_subscore16)));
	
	cdop_lnoddsscore := cdop_rawscore + 1.915529;
	
	cdow_subscore0 := map(
	    NULL < st_cen_hhsize AND st_cen_hhsize < 2.26  => 0.417918,
	    2.26 <= st_cen_hhsize AND st_cen_hhsize < 2.97 => 0.007548,
	    2.97 <= st_cen_hhsize                          => -0.475575,
	                                                      -0.000000);
	
	cdow_subscore1 := map(
	    NULL < st_cen_span_lang AND st_cen_span_lang < 155 => 0.172077,
	    155 <= st_cen_span_lang AND st_cen_span_lang < 180 => 0.009615,
	    180 <= st_cen_span_lang                            => -0.733473,
	                                                          -0.000000);
	
	cdow_subscore2 := map(
	    (st_cvi in [0, 10, 20]) => -0.072549,
	    (st_cvi in [30, 40])    => 0.963219,
	                               -0.000000);
	
	cdow_subscore3 := map(
	    (st_bus_phone_match in [0, 1]) => -0.362758,
	    (st_bus_phone_match in [2, 3]) => 0.368720,
	                                      -0.000000);
	
	cdow_subscore4 := map(
	    (st_high_risk_phone in ['Other', 'Cell/Mobile', 'Not High Risk']) => 0.131306,
	    (st_high_risk_phone in ['Oth High Risk'])                         => -1.643815,
	                                                                         0.000000);
	
	cdow_subscore5 := map(
	    (st_phone_zip_match in ['Other', 'Mismatch', 'Not Issued']) => -0.682141,
	    (st_phone_zip_match in ['No Mismatch'])                     => 0.194751,
	                                                                   0.000000);
	
	cdow_subscore6 := map(
	    NULL < st_max_ids_per_addr AND st_max_ids_per_addr < 1 => -0.051602,
	    1 <= st_max_ids_per_addr AND st_max_ids_per_addr < 7   => 0.377484,
	    7 <= st_max_ids_per_addr AND st_max_ids_per_addr < 15  => 0.239911,
	    15 <= st_max_ids_per_addr                              => -0.311032,
	                                                              0.000000);
	
	cdow_subscore7 := map(
	    NULL < st_inq_adls_per_addr AND st_inq_adls_per_addr < 1 => 0.193293,
	    1 <= st_inq_adls_per_addr AND st_inq_adls_per_addr < 2   => -0.190090,
	    2 <= st_inq_adls_per_addr                                => -0.349814,
	                                                                0.000000);
	
	cdow_subscore8 := map(
	    NULL < ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 974  => 0.632882,
	    974 <= ip_dist_inp_addr_to_ip_addr AND ip_dist_inp_addr_to_ip_addr < 1945 => 0.160817,
	    1945 <= ip_dist_inp_addr_to_ip_addr                                       => -0.461469,
	                                                                                 -0.000000);
	
	cdow_subscore9 := map(
	    (btst_email_first_x_last_score in ['-1:-1', '0:0'])                                                                            => -0.505823,
	    (btst_email_first_x_last_score in ['0:1', '0:2', '1:0', '1:1', '1:2', '1:3', '2:0', '2:1', '2:2', '2:3', '3:1', '3:2', '3:3']) => 0.318954,
	                                                                                                                                      -0.000000);
	
	cdow_subscore10 := map(
	    NULL < btst_distphone2addr2 AND btst_distphone2addr2 < 1 => 0.825672,
	    1 <= btst_distphone2addr2                                => -0.614856,
	                                                                0.000000);
	
	cdow_subscore11 := map(
	    NULL < btst_distaddraddr2 AND btst_distaddraddr2 < 27   => 0.712148,
	    27 <= btst_distaddraddr2 AND btst_distaddraddr2 < 204   => 0.039468,
	    204 <= btst_distaddraddr2 AND btst_distaddraddr2 < 1058 => -0.855988,
	    1058 <= btst_distaddraddr2                              => -1.260952,
	                                                               0.000000);
	
	cdow_subscore12 := map(
	    (ip_routingmethod in ['02', '16'])                               => -2.391410,
	    (ip_routingmethod in ['06', '10', '11', '12', '13', '14', '15']) => 0.187060,
	                                                                        -0.000000);
	
	cdow_subscore13 := map(
	    (ip_dma_lvl in ['1. Missing DMA', '2. DMA: -1', '3. DMA: 0', '5. DMA: Unknown']) => -0.975540,
	    (ip_dma_lvl in ['4. DMA: US Code'])                                              => 0.110803,
	                                                                                        -0.000000);
	
	cdow_subscore14 := map(
	    NULL < btst_email_domain_risk_level AND btst_email_domain_risk_level < 4 => 0.415336,
	    4 <= btst_email_domain_risk_level AND btst_email_domain_risk_level < 5   => -0.081309,
	    5 <= btst_email_domain_risk_level                                        => -0.428491,
	                                                                                0.000000);
	
	cdow_subscore15 := map(
	    (inp_product_desc in ['0'])       => 0.231602,
	    (inp_product_desc in ['2', '3', '5']) => -0.048172,
	                                       0.000000);
	
	cdow_subscore16 := map(
	    NULL < pf_wks_since_create_date AND pf_wks_since_create_date < 3 => -0.155714,
	    3 <= pf_wks_since_create_date                                    => 0.480956,
	                                                                        -0.000000);
	
	cdow_subscore17 := map(
	    (pf_pmt_x_avs_lvl in [0, 1, 2, 3]) => -0.601901,
	    (pf_pmt_x_avs_lvl in [4])          => -0.389110,
	    (pf_pmt_x_avs_lvl in [5])          => -0.035124,
	    (pf_pmt_x_avs_lvl in [6, 7, 8])    => 0.659804,
	                                          0.000000);
	
	cdow_subscore18 := map(
	    (pf_cid_result in ['Invalid', 'No Match', 'Null', 'Other']) => -0.500908,
	    (pf_cid_result in ['Match'])                                => 0.053924,
	                                                                   0.000000);
	
	cdow_subscore19 := map(
	    (pf_ship_method in ['2nd Day', 'Next Day'])        => -0.604115,
	    (pf_ship_method in ['3rd Day', 'Ground', 'Other']) => 0.461667,
	                                                          -0.000000);
	
	cdow_subscore20 := map(
	    NULL < pf_order_amt_c AND pf_order_amt_c < 611.61     => 0.343998,
	    611.61 <= pf_order_amt_c AND pf_order_amt_c < 868.14  => 0.041068,
	    868.14 <= pf_order_amt_c AND pf_order_amt_c < 1315.44 => -0.118299,
	    1315.44 <= pf_order_amt_c                             => -0.438838,
	                                                             0.000000);
	
	cdow_rawscore := if(max(cdow_subscore0, cdow_subscore1, cdow_subscore2, cdow_subscore3, cdow_subscore4, cdow_subscore5, cdow_subscore6, cdow_subscore7, cdow_subscore8, cdow_subscore9, cdow_subscore10, cdow_subscore11, cdow_subscore12, cdow_subscore13, cdow_subscore14, cdow_subscore15, cdow_subscore16, cdow_subscore17, cdow_subscore18, cdow_subscore19, cdow_subscore20) = NULL, NULL, sum(if(cdow_subscore0 = NULL, 0, cdow_subscore0), if(cdow_subscore1 = NULL, 0, cdow_subscore1), if(cdow_subscore2 = NULL, 0, cdow_subscore2), if(cdow_subscore3 = NULL, 0, cdow_subscore3), if(cdow_subscore4 = NULL, 0, cdow_subscore4), if(cdow_subscore5 = NULL, 0, cdow_subscore5), if(cdow_subscore6 = NULL, 0, cdow_subscore6), if(cdow_subscore7 = NULL, 0, cdow_subscore7), if(cdow_subscore8 = NULL, 0, cdow_subscore8), if(cdow_subscore9 = NULL, 0, cdow_subscore9), if(cdow_subscore10 = NULL, 0, cdow_subscore10), if(cdow_subscore11 = NULL, 0, cdow_subscore11), if(cdow_subscore12 = NULL, 0, cdow_subscore12), if(cdow_subscore13 = NULL, 0, cdow_subscore13), if(cdow_subscore14 = NULL, 0, cdow_subscore14), if(cdow_subscore15 = NULL, 0, cdow_subscore15), if(cdow_subscore16 = NULL, 0, cdow_subscore16), if(cdow_subscore17 = NULL, 0, cdow_subscore17), if(cdow_subscore18 = NULL, 0, cdow_subscore18), if(cdow_subscore19 = NULL, 0, cdow_subscore19), if(cdow_subscore20 = NULL, 0, cdow_subscore20)));
	
	cdow_lnoddsscore := cdow_rawscore + 2.584612;
	
	final_model_lnodds := map(
	    final_model_segment = 'BUS  ADDR+         PHN' => bs_p_lnoddsscore,
	    final_model_segment = 'BUS  ADDR+         WEB' => bs_w_lnoddsscore,
	    final_model_segment = 'BUS  ADDR-         PHN' => bd_p_lnoddsscore,
	    final_model_segment = 'BUS  ADDR-         WEB' => bd_w_lnoddsscore,
	    final_model_segment = 'CONS ADDR+ DIFF    PHN' => csdp_lnoddsscore,
	    final_model_segment = 'CONS ADDR+ DIFF    WEB' => csdw_lnoddsscore,
	    final_model_segment = 'CONS ADDR+ ID/RELS PHN' => cssp_lnoddsscore,
	    final_model_segment = 'CONS ADDR+ ID/RELS WEB' => cssw_lnoddsscore,
	    final_model_segment = 'CONS ADDR- DIFF    PHN' => cddp_lnoddsscore,
	    final_model_segment = 'CONS ADDR- DIFF    WEB' => cddw_lnoddsscore,
	    final_model_segment = 'CONS ADDR- ID/RELS PHN' => cdsp_lnoddsscore,
	    final_model_segment = 'CONS ADDR- ID/RELS WEB' => cdsw_lnoddsscore,
	    final_model_segment = 'CONS ADDR- LNAME   PHN' => cdop_lnoddsscore,
	                                                      cdow_lnoddsscore);
	
	base := 660;
	
	points := 30;
	
	odds := (1 - .0264) / .0264;
	
	dell_custom_model := round(points * (final_model_lnodds - ln(odds)) / ln(2) + base);
	
	cdn1205_1_0 := min(if(max(dell_custom_model, 250) = NULL, -NULL, max(dell_custom_model, 250)), 999);
	
	attr_segment := map(
	    final_model_segment = 'BUS  ADDR+         PHN' => 20,
	    final_model_segment = 'BUS  ADDR-         PHN' => 21,
	    final_model_segment = 'BUS  ADDR+         WEB' => 22,
	    final_model_segment = 'BUS  ADDR-         WEB' => 23,
	    final_model_segment = 'CONS ADDR+ ID/RELS PHN' => 10,
	    final_model_segment = 'CONS ADDR+ DIFF    PHN' => 11,
	    final_model_segment = 'CONS ADDR- ID/RELS PHN' => 12,
	    final_model_segment = 'CONS ADDR- LNAME   PHN' => 13,
	    final_model_segment = 'CONS ADDR- DIFF    PHN' => 14,
	    final_model_segment = 'CONS ADDR+ ID/RELS WEB' => 15,
	    final_model_segment = 'CONS ADDR+ DIFF    WEB' => 16,
	    final_model_segment = 'CONS ADDR- ID/RELS WEB' => 17,
	    final_model_segment = 'CONS ADDR- LNAME   WEB' => 18,
	                                                      19);
	
	attr_relation := map(
	    btst_relatives_lvl = '1. BOTH DID 0         ' => 1,
	    btst_relatives_lvl = '2. BILLTO DID 0       ' => 2,
	    btst_relatives_lvl = '2. SHIPTO DID 0       ' => 3,
	    btst_relatives_lvl = '4. DIDS EQUAL         ' => 4,
	    btst_relatives_lvl = '5. RELATIVES          ' => 5,
	    btst_relatives_lvl = '6. RELATIVES IN COMMON' => 6,
	                                                     7);
	
	cdn1205_1_0_custom_attribute := 10 * attr_segment + attr_relation;

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.inp_customer_create_date := inp_customer_create_date;
		SELF.inp_pay_code_1 := inp_pay_code_1;
		SELF.inp_avs_response_code := inp_avs_response_code;
		SELF.inp_cid_response_code := inp_cid_response_code;
		SELF.inp_local_ship_code := inp_local_ship_code;
		SELF.inp_order_amt := inp_order_amt;
		SELF.inp_us_business_consumer_flag := inp_us_business_consumer_flag;
		SELF.inp_product_desc := inp_product_desc;
		SELF._state := _state;
		SELF.efirstscore := efirstscore;
		SELF.elastscore := elastscore;
		SELF.continent := continent;
		SELF.ipaddr := ipaddr;
		SELF.topleveldomain := topleveldomain;
		SELF.iproutingmethod := iproutingmethod;
		SELF.areacode := areacode;
		SELF.ipdma := ipdma;
		SELF.distaddraddr2 := distaddraddr2;
		SELF.btst_are_relatives := if(btst_are_relatives, '1', '0');
		SELF.btst_relatives_in_common := if(btst_relatives_in_common, '1','0');
		SELF.latitude := latitude;
		SELF.longitude := longitude;
		SELF.distphoneaddr := distphoneaddr;
		SELF.distphone2addr2 := distphone2addr2;
		SELF.distaddrphone2 := distaddrphone2;
		SELF.addrscore := addrscore;
		SELF.firstscore := firstscore;
		SELF.lastscore := lastscore;
		SELF.did := (string)did;
		SELF.truedid := truedid;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_st := out_st;
		SELF.out_z5 := out_z5;
		SELF.out_lat := out_lat;
		SELF.out_long := out_long;
		SELF.out_addr_type := out_addr_type;
		SELF.in_email_address := in_email_address;
		SELF.in_ip_address := in_ip_address;
		SELF.in_phone10 := in_phone10;
		SELF.nap_summary := nap_summary;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_phonezipflag := rc_phonezipflag;
		SELF.rc_pwphonezipflag := rc_pwphonezipflag;
		SELF.rc_hriskaddrflag := rc_hriskaddrflag;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_addrcount := rc_addrcount;
		SELF.rc_phoneaddrcount := (string)rc_phoneaddrcount;
		SELF.rc_phoneaddr_addrcount := (string)rc_phoneaddr_addrcount;
		SELF.rc_hphonemiskeyflag := rc_hphonemiskeyflag;
		SELF.bus_phone_match := (string)bus_phone_match;
		SELF.lnamepop := if(lnamepop, '1','0');
		SELF.addrpop := if(addrpop, '1','0');
		SELF.hphnpop := if(hphnpop, '1','0');
		SELF.lname_eda_sourced_type := lname_eda_sourced_type;
		// SELF.util_add1_type_list := util_add1_type_list;
		SELF.add1_lres := (string)add1_lres;
		SELF.add1_advo_res_or_business := add1_advo_res_or_business;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_occupant_owned := add1_occupant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_date_first_seen := (string)add1_date_first_seen;
		SELF.add1_pop := if(add1_pop, '1','0');
		SELF.adls_per_addr := (string)adls_per_addr;
		SELF.ssns_per_addr := ssns_per_addr;
		SELF.inq_highriskcredit_count := (string)inq_highriskcredit_count;
		SELF.inq_highriskcredit_count01 := (string)inq_highriskcredit_count01;
		SELF.inq_highriskcredit_count03 := (string)inq_highriskcredit_count03;
		SELF.inq_highriskcredit_count06 := (string)inq_highriskcredit_count06;
		SELF.inq_highriskcredit_count12 := (string)inq_highriskcredit_count12;
		SELF.inq_highriskcredit_count24 := (string)inq_highriskcredit_count24;
		SELF.inq_retail_count := (string)inq_retail_count;
		SELF.inq_retail_count01 := (string)inq_retail_count01;
		SELF.inq_retail_count03 := (string)inq_retail_count03;
		SELF.inq_retail_count06 := (string)inq_retail_count06;
		SELF.inq_retail_count12 := (string)inq_retail_count12;
		SELF.inq_retail_count24 := (string)inq_retail_count24;
		SELF.inq_adlsperaddr := (string)inq_adlsperaddr;
		SELF.paw_first_seen := (string)paw_first_seen;
		SELF.paw_source_count := (string)paw_source_count;
		SELF.infutor_nap := (string)infutor_nap;
		SELF.wealth_index := wealth_index;
		SELF.archive_date := archive_date;
		SELF.did_s := (string)did_s;
		SELF.truedid_s := if(truedid_s, '1','0');
		SELF.out_unit_desig_s := out_unit_desig_s;
		SELF.out_sec_range_s := out_sec_range_s;
		SELF.out_z5_s := out_z5_s;
		SELF.out_addr_type_s := out_addr_type_s;
		SELF.nap_summary_s := (string)nap_summary_s;
		SELF.cvi_s := (string)cvi_s;
		SELF.rc_hriskphoneflag_s := rc_hriskphoneflag_s;
		SELF.rc_hphonetypeflag_s := rc_hphonetypeflag_s;
		SELF.rc_phonevalflag_s := rc_phonevalflag_s;
		SELF.rc_hphonevalflag_s := rc_hphonevalflag_s;
		SELF.rc_phonezipflag_s := rc_phonezipflag_s;
		SELF.rc_pwphonezipflag_s := rc_pwphonezipflag_s;
		SELF.rc_dwelltype_s := rc_dwelltype_s;
		SELF.rc_addrcount_s := (string)rc_addrcount_s;
		SELF.rc_phoneaddrcount_s := (string)rc_phoneaddrcount_s;
		SELF.rc_phoneaddr_addrcount_s := (string)rc_phoneaddr_addrcount_s;
		SELF.ver_sources_s := ver_sources_s;
		SELF.ver_sources_first_seen_s := ver_sources_first_seen_s;
		SELF.bus_name_match_s := (string)bus_name_match_s;
		SELF.bus_phone_match_s := (string)bus_phone_match_s;
		SELF.fnamepop_s := if(fnamepop_s, '1','0');
		SELF.lnamepop_s := if(lnamepop_s, '1','0');
		SELF.addrpop_s := if(addrpop_s,'1','0');
		SELF.ssnlength_s := ssnlength_s;
		SELF.hphnpop_s := if(hphnpop_s, '1','0');
		SELF.source_count_s := (string)source_count_s;
		SELF.fname_eda_sourced_type_s := fname_eda_sourced_type_s;
		SELF.lname_eda_sourced_type_s := lname_eda_sourced_type_s;
		// SELF.util_add1_type_list_s := util_add1_type_list_s;
		SELF.add1_advo_res_or_business_s := add1_advo_res_or_business_s;
		SELF.add1_eda_sourced_s := if(add1_eda_sourced_s, '1','0');
		SELF.add1_applicant_owned_s := if(add1_applicant_owned_s, '1','0');
		SELF.add1_occupant_owned_s := if(add1_occupant_owned_s, '1','0');
		SELF.add1_family_owned_s := if(add1_family_owned_s, '1','0');
		SELF.add1_naprop_s := (string)add1_naprop_s;
		SELF.add1_pop_s := if(add1_pop_s, '1','0');
		SELF.adls_per_addr_s := (string)adls_per_addr_s;
		SELF.ssns_per_addr_s := (string)ssns_per_addr_s;
		SELF.phones_per_addr_s := (string)phones_per_addr_s;
		SELF.adls_per_addr_c6_s := (string)adls_per_addr_c6_s;
		SELF.ssns_per_addr_c6_s := (string)ssns_per_addr_c6_s;
		SELF.inq_collection_count_s := (string)inq_collection_count_s;
		SELF.inq_collection_count01_s := (string)inq_collection_count01_s;
		SELF.inq_collection_count03_s := (string)inq_collection_count03_s;
		SELF.inq_collection_count06_s := (string)inq_collection_count06_s;
		SELF.inq_collection_count12_s := (string)inq_collection_count12_s;
		SELF.inq_collection_count24_s := (string)inq_collection_count24_s;
		SELF.inq_highriskcredit_count_s := (string)inq_highriskcredit_count_s;
		SELF.inq_highriskcredit_count01_s := (string)inq_highriskcredit_count01_s;
		SELF.inq_highriskcredit_count03_s := (string)inq_highriskcredit_count03_s;
		SELF.inq_highriskcredit_count06_s := (string)inq_highriskcredit_count06_s;
		SELF.inq_highriskcredit_count12_s := (string)inq_highriskcredit_count12_s;
		SELF.inq_highriskcredit_count24_s := (string)inq_highriskcredit_count24_s;
		SELF.inq_adlsperaddr_s := (string)inq_adlsperaddr_s;
		SELF.inq_ssnsperaddr_s := (string)inq_ssnsperaddr_s;
		SELF.paw_source_count_s := (string)paw_source_count_s;
		SELF.infutor_nap_s := (string)infutor_nap_s;
		SELF.impulse_first_seen_s := (string)impulse_first_seen_s;
		SELF.email_domain_free_count_s := (string)email_domain_free_count_s;
		SELF.attr_total_number_derogs_s := (string)attr_total_number_derogs_s;
		SELF.attr_num_nonderogs_s := (string)attr_num_nonderogs_s;
		SELF.liens_recent_unreleased_count_s := (string)liens_recent_unreleased_count_s;
		SELF.liens_historical_unreleased_ct_s := (string)liens_historical_unreleased_ct_s;
		SELF.rel_count_s := (string)rel_count_s;
		SELF.rel_bankrupt_count_s := (string)rel_bankrupt_count_s;
		SELF.rel_criminal_count_s := (string)rel_criminal_count_s;
		SELF.rel_felony_count_s := (string)rel_felony_count_s;
		SELF.rel_within25miles_count_s := (string)rel_within25miles_count_s;
		SELF.rel_within100miles_count_s := (string)rel_within100miles_count_s;
		SELF.rel_within500miles_count_s := (string)rel_within500miles_count_s;
		SELF.rel_withinother_count_s := (string)rel_withinother_count_s;
		SELF.rel_incomeunder25_count_s := (string)rel_incomeunder25_count_s;
		SELF.rel_incomeunder50_count_s := (string)rel_incomeunder50_count_s;
		SELF.rel_incomeunder75_count_s := (string)rel_incomeunder75_count_s;
		SELF.rel_incomeunder100_count_s := (string)rel_incomeunder100_count_s;
		SELF.rel_incomeover100_count_s := (string)rel_incomeover100_count_s;
		SELF.rel_educationunder8_count_s := (string)rel_educationunder8_count_s;
		SELF.rel_educationunder12_count_s := (string)rel_educationunder12_count_s;
		SELF.rel_educationover12_count_s := (string)rel_educationover12_count_s;
		SELF.wealth_index_s := wealth_index_s;
		SELF.c_BEL_EDU := c_BEL_EDU;
		SELF.c_FAMMAR_P := c_FAMMAR_P;
		SELF.c_FAMMAR_P_s := c_FAMMAR_P_s;
		SELF.c_FAMOTF18_P := c_FAMOTF18_P;
		SELF.c_HHSIZE := c_HHSIZE;
		SELF.c_HHSIZE_s := c_HHSIZE_s;
		SELF.c_HIGH_ED_s := c_HIGH_ED_s;
		SELF.c_MED_INC_s := c_MED_INC_s;
		SELF.c_SPAN_LANG := c_SPAN_LANG;
		SELF.c_SPAN_LANG_s := c_SPAN_LANG_s;

		/* Model Intermediate Variables */
		SELF.NULL := (string)NULL;
		// SELF.INTEGER contains_i( string haystack, string needle ) := INTEGER contains_i( string haystack, string needle );
		SELF.sysdate_1 := (string)sysdate_1;
		SELF.sysdate := sysdate;
		SELF.state := state;
		SELF.pf_wks_since_create_date := (string)pf_wks_since_create_date;
		SELF.pf_pmt_type := pf_pmt_type;
		SELF.pf_avs_addr := if(pf_avs_addr, '1','0');
		SELF.pf_avs_zip := if(pf_avs_zip, '1','0');
		SELF.pf_avs_name := if(pf_avs_name, '1','0');
		SELF.pf_avs_error := if(pf_avs_error, '1','0');
		SELF.pf_avs_invalid := if(pf_avs_invalid, '1','0');
		SELF.pf_avs_unavail := if(pf_avs_unavail, '1','0');
		SELF.pf_avs_no_match := if(pf_avs_no_match, '1','0');
		SELF.pf_avs_intl := if(pf_avs_intl, '1','0');
		SELF.pf_avs_result := pf_avs_result;
		SELF.pf_pmt_x_avs_lvl := (string)pf_pmt_x_avs_lvl;
		SELF.pf_cid_result := pf_cid_result;
		SELF.pf_ship_method := pf_ship_method;
		SELF.pf_order_amt_c := (string)pf_order_amt_c;
		SELF.bt_add_apt := if(bt_add_apt, '1','0');
		SELF.st_add_apt := if(st_add_apt, '1','0');
		SELF.bt_bus_phone_match := (string)bt_bus_phone_match;
		SELF.bt_phn_miskey := (string)bt_phn_miskey;
		SELF.bt_valid_phone := bt_valid_phone;
		SELF.bt_phone_zip_match := bt_phone_zip_match;
		SELF.bt_hriskaddrflag := bt_hriskaddrflag;
		// SELF.bt_add1_util_pots := (string)bt_add1_util_pots;
		SELF.bt_inp_addr_res_or_business := bt_inp_addr_res_or_business;
		SELF.bt_max_ids_per_addr := (string)bt_max_ids_per_addr;
		SELF._paw_first_seen := (string)_paw_first_seen;
		SELF.bt_mos_since_paw_first_seen := (string)bt_mos_since_paw_first_seen;
		SELF.bt_inq_retail_recency := (string)bt_inq_retail_recency;
		SELF.bt_paw_source_count := (string)bt_paw_source_count;
		SELF.st_bus_phone_match := (string)st_bus_phone_match;
		SELF.st_phone_zip_match := st_phone_zip_match;
		SELF.st_inp_addr_res_or_business := st_inp_addr_res_or_business;
		SELF.st_paw_source_count := (string)st_paw_source_count;
		SELF.st_bus_name_match := (string)st_bus_name_match;
		SELF.st_valid_phone := st_valid_phone;
		SELF.st_inq_highriskcredit_recency := (string)st_inq_highriskcredit_recency;
		SELF.bt_cen_hhsize := (string)bt_cen_hhsize;
		SELF.bt_cen_famotf18_p := (string)bt_cen_famotf18_p;
		SELF.bt_inp_addr_ownership_lvl := bt_inp_addr_ownership_lvl;
		SELF.bt_inq_adls_per_addr := (string)bt_inq_adls_per_addr;
		SELF.ver_phn_inf := IF(ver_phn_inf, '1','0');
		SELF.ver_phn_nap := IF(ver_phn_nap, '1','0');
		SELF.inf_phn_ver_lvl := (string)inf_phn_ver_lvl;
		SELF.nap_phn_ver_lvl := (string)nap_phn_ver_lvl;
		SELF.bt_nap_phn_ver_x_inf_phn_ver := bt_nap_phn_ver_x_inf_phn_ver;
		SELF.bt_cen_bel_edu := (string)bt_cen_bel_edu;
		SELF.bt_lname_eda_sourced_type := bt_lname_eda_sourced_type;
		SELF.inp_addr_date_first_seen := (string)inp_addr_date_first_seen;
		SELF.bt_mos_since_inp_addr_fseen := (string)bt_mos_since_inp_addr_fseen;
		SELF.bt_infutor_nap := (string)bt_infutor_nap;
		SELF.bt_cen_fammar_p := (string)bt_cen_fammar_p;
		SELF.bt_cen_span_lang := (string)bt_cen_span_lang;
		SELF.bt_inp_addr_lres := (string)bt_inp_addr_lres;
		SELF.bt_adls_per_sfd_addr := (string)bt_adls_per_sfd_addr;
		SELF.st_cen_high_ed := (string)st_cen_high_ed;
		SELF.st_inq_collection_recency := (string)st_inq_collection_recency;
		SELF._impulse_first_seen_s := (string)_impulse_first_seen_s;
		SELF.st_mos_since_impulse_first_seen := (string)st_mos_since_impulse_first_seen;
		SELF.st_email_domain_free_count := (string)st_email_domain_free_count;
		SELF.st_derog_ratio := (string)st_derog_ratio;
		SELF.st_average_rel_income := (string)st_average_rel_income;
		SELF.bt_inq_retail_count12 := (string)bt_inq_retail_count12;
		SELF.st_max_ids_per_addr := (string)st_max_ids_per_addr;
		SELF.st_inq_ssns_per_addr := (string)st_inq_ssns_per_addr;
		SELF.st_unreleased_liens_ct := (string)st_unreleased_liens_ct;
		SELF.st_average_rel_education := (string)st_average_rel_education;
		SELF.st_rel_derog_summary := (string)st_rel_derog_summary;
		SELF.st_wealth_index := (string)st_wealth_index;
		SELF.bt_addr_ver_sources := bt_addr_ver_sources;
		SELF.bt_inq_highriskcredit_recency := (string)bt_inq_highriskcredit_recency;
		SELF.bt_wealth_index := (string)bt_wealth_index;
		SELF.st_cvi := (string)st_cvi;
		SELF.src_white_pages_adl_fseen_s := (string)src_white_pages_adl_fseen_s;
		SELF._src_white_pages_adl_fseen_s := (string)_src_white_pages_adl_fseen_s;
		SELF.st_mos_src_white_pages_adl_fseen := (string)st_mos_src_white_pages_adl_fseen;
		SELF.st_inp_addr_naprop := (string)st_inp_addr_naprop;
		SELF.st_max_ids_per_addr_c6 := (string)st_max_ids_per_addr_c6;
		SELF.src_bureau_adl_fseen_tn := (string)src_bureau_adl_fseen_tn;
		SELF.src_bureau_adl_fseen_ts := (string)src_bureau_adl_fseen_ts;
		SELF.src_bureau_adl_fseen_tu := (string)src_bureau_adl_fseen_tu;
		SELF.src_bureau_adl_fseen_en := (string)src_bureau_adl_fseen_en;
		SELF.src_bureau_adl_fseen_eq := (string)src_bureau_adl_fseen_eq;
		SELF.src_bureau_adl_fseen_s := (string)src_bureau_adl_fseen_s;
		SELF._src_bureau_adl_fseen_s := (string)_src_bureau_adl_fseen_s;
		SELF.st_mos_src_bureau_adl_fseen := (string)st_mos_src_bureau_adl_fseen;
		SELF.st_inp_addr_eda_sourced := (string)st_inp_addr_eda_sourced;
		SELF.st_inp_addr_ownership_lvl := st_inp_addr_ownership_lvl;
		SELF.st_phones_per_sfd_addr := (string)st_phones_per_sfd_addr;
		SELF.st_closest_rel_distance := (string)st_closest_rel_distance;
		SELF.st_cen_fammar_p := (string)st_cen_fammar_p;
		SELF.st_cen_med_inc := (string)st_cen_med_inc;
		SELF.st_full_name_ver_sources := st_full_name_ver_sources;
		SELF.st_addr_ver_sources := st_addr_ver_sources;
		// SELF.st_add1_util_sum := (string)st_add1_util_sum;
		SELF.st_max_ids_per_sfd_addr_c6 := (string)st_max_ids_per_sfd_addr_c6;
		SELF.st_inq_adls_per_addr := (string)st_inq_adls_per_addr;
		SELF.ver_phn_inf_s := (string)ver_phn_inf_s;
		SELF.ver_phn_nap_s := (string)ver_phn_nap_s;
		SELF.inf_phn_ver_lvl_s := (string)inf_phn_ver_lvl_s;
		SELF.nap_phn_ver_lvl_s := (string)nap_phn_ver_lvl_s;
		SELF.st_nap_phn_ver_x_inf_phn_ver := st_nap_phn_ver_x_inf_phn_ver;
		SELF.st_cen_hhsize := (string)st_cen_hhsize;
		SELF.st_high_risk_phone := st_high_risk_phone;
		SELF.st_cen_span_lang := (string)st_cen_span_lang;
		SELF.btst_email_first_x_last_score := btst_email_first_x_last_score;
		SELF.ip_continent := ip_continent;
		SELF.ip_state_match := (string)ip_state_match;
		SELF.ip_topleveldomain_lvl := ip_topleveldomain_lvl;
		SELF.ip_routingmethod := ip_routingmethod;
		SELF.ip_area_code_match := (string)ip_area_code_match;
		SELF.ip_dma_lvl := ip_dma_lvl;
		SELF.email_secondleveldomain := email_secondleveldomain;
		SELF.btst_email_domain_risk_level := (string)btst_email_domain_risk_level;
		SELF.btst_distaddraddr2 := (string)btst_distaddraddr2;
		SELF.btst_relatives_lvl := btst_relatives_lvl;
		SELF.num_inp_lat := (string)num_inp_lat;
		SELF.num_inp_long := (string)num_inp_long;
		SELF.num_ip_lat := (string)num_ip_lat;
		SELF.num_ip_long := (string)num_ip_long;
		SELF.d_lat := (string)d_lat;
		SELF.d_long := (string)d_long;
		SELF.a := (string)a;
		SELF.c := (string)c;
		SELF.dist := (string)dist;
		SELF.ip_dist_inp_addr_to_ip_addr := (string)ip_dist_inp_addr_to_ip_addr;
		SELF.btst_distphoneaddr := (string)btst_distphoneaddr;
		SELF.btst_distphone2addr2 := (string)btst_distphone2addr2;
		SELF.btst_distaddrphone2 := (string)btst_distaddrphone2;
		SELF.addr_match := (string)addr_match;
		SELF.fname_match := (string)fname_match;
		SELF.lname_match := (string)lname_match;
		SELF.did_match := (string)did_match;
		SELF.btst_segment2 := (string)btst_segment2;
		SELF.dell_segmentation2 := (string)dell_segmentation2;
		SELF.dell_segmentation3 := (string)dell_segmentation3;
		SELF.final_model_segment := final_model_segment;
		SELF.bs_p_subscore0 := (string)bs_p_subscore0;
		SELF.bs_p_subscore1 := (string)bs_p_subscore1;
		SELF.bs_p_subscore2 := (string)bs_p_subscore2;
		SELF.bs_p_subscore3 := (string)bs_p_subscore3;
		SELF.bs_p_subscore4 := (string)bs_p_subscore4;
		// SELF.bs_p_subscore5 := (string)bs_p_subscore5;
		SELF.bs_p_subscore6 := (string)bs_p_subscore6;
		SELF.bs_p_subscore7 := (string)bs_p_subscore7;
		SELF.bs_p_subscore8 := (string)bs_p_subscore8;
		SELF.bs_p_subscore9 := (string)bs_p_subscore9;
		SELF.bs_p_subscore10 := (string)bs_p_subscore10;
		SELF.bs_p_subscore11 := (string)bs_p_subscore11;
		SELF.bs_p_subscore12 := (string)bs_p_subscore12;
		SELF.bs_p_rawscore := (string)bs_p_rawscore;
		SELF.bs_p_lnoddsscore := (string)bs_p_lnoddsscore;
		SELF.bs_w_subscore0 := (string)bs_w_subscore0;
		SELF.bs_w_subscore1 := (string)bs_w_subscore1;
		SELF.bs_w_subscore2 := (string)bs_w_subscore2;
		SELF.bs_w_subscore3 := (string)bs_w_subscore3;
		SELF.bs_w_subscore4 := (string)bs_w_subscore4;
		SELF.bs_w_subscore5 := (string)bs_w_subscore5;
		SELF.bs_w_subscore6 := (string)bs_w_subscore6;
		SELF.bs_w_subscore7 := (string)bs_w_subscore7;
		SELF.bs_w_subscore8 := (string)bs_w_subscore8;
		SELF.bs_w_subscore9 := (string)bs_w_subscore9;
		SELF.bs_w_subscore10 := (string)bs_w_subscore10;
		SELF.bs_w_subscore11 := (string)bs_w_subscore11;
		SELF.bs_w_subscore12 := (string)bs_w_subscore12;
		SELF.bs_w_subscore13 := (string)bs_w_subscore13;
		SELF.bs_w_subscore14 := (string)bs_w_subscore14;
		SELF.bs_w_subscore15 := (string)bs_w_subscore15;
		SELF.bs_w_rawscore := (string)bs_w_rawscore;
		SELF.bs_w_lnoddsscore := (string)bs_w_lnoddsscore;
		SELF.bd_p_subscore0 := (string)bd_p_subscore0;
		SELF.bd_p_subscore1 := (string)bd_p_subscore1;
		SELF.bd_p_subscore2 := (string)bd_p_subscore2;
		SELF.bd_p_subscore3 := (string)bd_p_subscore3;
		SELF.bd_p_subscore4 := (string)bd_p_subscore4;
		SELF.bd_p_subscore5 := (string)bd_p_subscore5;
		SELF.bd_p_subscore6 := (string)bd_p_subscore6;
		SELF.bd_p_subscore7 := (string)bd_p_subscore7;
		SELF.bd_p_subscore8 := (string)bd_p_subscore8;
		SELF.bd_p_subscore9 := (string)bd_p_subscore9;
		SELF.bd_p_subscore10 := (string)bd_p_subscore10;
		SELF.bd_p_subscore11 := (string)bd_p_subscore11;
		SELF.bd_p_subscore12 := (string)bd_p_subscore12;
		SELF.bd_p_rawscore := (string)bd_p_rawscore;
		SELF.bd_p_lnoddsscore := (string)bd_p_lnoddsscore;
		SELF.bd_w_subscore0 := (string)bd_w_subscore0;
		SELF.bd_w_subscore1 := (string)bd_w_subscore1;
		SELF.bd_w_subscore2 := (string)bd_w_subscore2;
		SELF.bd_w_subscore3 := (string)bd_w_subscore3;
		SELF.bd_w_subscore4 := (string)bd_w_subscore4;
		SELF.bd_w_subscore5 := (string)bd_w_subscore5;
		SELF.bd_w_subscore6 := (string)bd_w_subscore6;
		SELF.bd_w_subscore7 := (string)bd_w_subscore7;
		SELF.bd_w_subscore8 := (string)bd_w_subscore8;
		SELF.bd_w_subscore9 := (string)bd_w_subscore9;
		SELF.bd_w_subscore10 := (string)bd_w_subscore10;
		SELF.bd_w_subscore11 := (string)bd_w_subscore11;
		SELF.bd_w_subscore12 := (string)bd_w_subscore12;
		SELF.bd_w_subscore13 := (string)bd_w_subscore13;
		SELF.bd_w_subscore14 := (string)bd_w_subscore14;
		SELF.bd_w_subscore15 := (string)bd_w_subscore15;
		SELF.bd_w_subscore16 := (string)bd_w_subscore16;
		SELF.bd_w_subscore17 := (string)bd_w_subscore17;
		SELF.bd_w_subscore18 := (string)bd_w_subscore18;
		SELF.bd_w_rawscore := (string)bd_w_rawscore;
		SELF.bd_w_lnoddsscore := (string)bd_w_lnoddsscore;
		SELF.csdp_subscore0 := (string)csdp_subscore0;
		SELF.csdp_subscore1 := (string)csdp_subscore1;
		SELF.csdp_subscore2 := (string)csdp_subscore2;
		SELF.csdp_subscore3 := (string)csdp_subscore3;
		SELF.csdp_subscore4 := (string)csdp_subscore4;
		SELF.csdp_subscore5 := (string)csdp_subscore5;
		SELF.csdp_subscore6 := (string)csdp_subscore6;
		SELF.csdp_subscore7 := (string)csdp_subscore7;
		SELF.csdp_subscore8 := (string)csdp_subscore8;
		SELF.csdp_subscore9 := (string)csdp_subscore9;
		SELF.csdp_subscore10 := (string)csdp_subscore10;
		SELF.csdp_subscore11 := (string)csdp_subscore11;
		SELF.csdp_rawscore := (string)csdp_rawscore;
		SELF.csdp_lnoddsscore := (string)csdp_lnoddsscore;
		SELF.csdw_subscore0 := (string)csdw_subscore0;
		SELF.csdw_subscore1 := (string)csdw_subscore1;
		SELF.csdw_subscore2 := (string)csdw_subscore2;
		SELF.csdw_subscore3 := (string)csdw_subscore3;
		SELF.csdw_subscore4 := (string)csdw_subscore4;
		SELF.csdw_subscore5 := (string)csdw_subscore5;
		SELF.csdw_subscore6 := (string)csdw_subscore6;
		SELF.csdw_subscore7 := (string)csdw_subscore7;
		SELF.csdw_subscore8 := (string)csdw_subscore8;
		SELF.csdw_subscore9 := (string)csdw_subscore9;
		SELF.csdw_subscore10 := (string)csdw_subscore10;
		SELF.csdw_subscore11 := (string)csdw_subscore11;
		SELF.csdw_subscore12 := (string)csdw_subscore12;
		SELF.csdw_subscore13 := (string)csdw_subscore13;
		SELF.csdw_rawscore := (string)csdw_rawscore;
		SELF.csdw_lnoddsscore := (string)csdw_lnoddsscore;
		SELF.cssp_subscore0 := (string)cssp_subscore0;
		SELF.cssp_subscore1 := (string)cssp_subscore1;
		SELF.cssp_subscore2 := (string)cssp_subscore2;
		SELF.cssp_subscore3 := (string)cssp_subscore3;
		SELF.cssp_subscore4 := (string)cssp_subscore4;
		SELF.cssp_subscore5 := (string)cssp_subscore5;
		SELF.cssp_subscore6 := (string)cssp_subscore6;
		SELF.cssp_subscore7 := (string)cssp_subscore7;
		SELF.cssp_subscore8 := (string)cssp_subscore8;
		SELF.cssp_subscore9 := (string)cssp_subscore9;
		SELF.cssp_subscore10 := (string)cssp_subscore10;
		SELF.cssp_subscore11 := (string)cssp_subscore11;
		SELF.cssp_rawscore := (string)cssp_rawscore;
		SELF.cssp_lnoddsscore := (string)cssp_lnoddsscore;
		SELF.cssw_subscore0 := (string)cssw_subscore0;
		SELF.cssw_subscore1 := (string)cssw_subscore1;
		SELF.cssw_subscore2 := (string)cssw_subscore2;
		SELF.cssw_subscore3 := (string)cssw_subscore3;
		SELF.cssw_subscore4 := (string)cssw_subscore4;
		SELF.cssw_subscore5 := (string)cssw_subscore5;
		SELF.cssw_subscore6 := (string)cssw_subscore6;
		SELF.cssw_subscore7 := (string)cssw_subscore7;
		SELF.cssw_subscore8 := (string)cssw_subscore8;
		SELF.cssw_subscore9 := (string)cssw_subscore9;
		SELF.cssw_subscore10 := (string)cssw_subscore10;
		SELF.cssw_subscore11 := (string)cssw_subscore11;
		SELF.cssw_subscore12 := (string)cssw_subscore12;
		SELF.cssw_subscore13 := (string)cssw_subscore13;
		SELF.cssw_subscore14 := (string)cssw_subscore14;
		SELF.cssw_subscore15 := (string)cssw_subscore15;
		SELF.cssw_subscore16 := (string)cssw_subscore16;
		SELF.cssw_subscore17 := (string)cssw_subscore17;
		SELF.cssw_rawscore := (string)cssw_rawscore;
		SELF.cssw_lnoddsscore := (string)cssw_lnoddsscore;
		SELF.cddp_subscore0 := (string)cddp_subscore0;
		SELF.cddp_subscore1 := (string) cddp_subscore1;
		SELF.cddp_subscore2 := (string) cddp_subscore2;
		SELF.cddp_subscore3 := (string) cddp_subscore3;
		SELF.cddp_subscore4 := (string) cddp_subscore4;
		SELF.cddp_subscore5 := (string) cddp_subscore5;
		SELF.cddp_subscore6 := (string) cddp_subscore6;
		SELF.cddp_subscore7 := (string) cddp_subscore7;
		SELF.cddp_subscore8 := (string) cddp_subscore8;
		SELF.cddp_subscore9 := (string) cddp_subscore9;
		SELF.cddp_subscore10 := (string) cddp_subscore10;
		SELF.cddp_subscore11 := (string) cddp_subscore11;
		SELF.cddp_subscore12 := (string) cddp_subscore12;
		SELF.cddp_subscore13 := (string) cddp_subscore13;
		SELF.cddp_subscore14 := (string) cddp_subscore14;
		SELF.cddp_rawscore := (string) cddp_rawscore;
		SELF.cddp_lnoddsscore := (string) cddp_lnoddsscore;
		SELF.cddw_subscore0 := (string) cddw_subscore0;
		SELF.cddw_subscore1 := (string) cddw_subscore1;
		SELF.cddw_subscore2 := (string) cddw_subscore2;
		SELF.cddw_subscore3 := (string) cddw_subscore3;
		SELF.cddw_subscore4 := (string) cddw_subscore4;
		SELF.cddw_subscore5 := (string) cddw_subscore5;
		SELF.cddw_subscore6 := (string) cddw_subscore6;
		SELF.cddw_subscore7 := (string) cddw_subscore7;
		SELF.cddw_subscore8 := (string) cddw_subscore8;
		SELF.cddw_subscore9 := (string) cddw_subscore9;
		SELF.cddw_subscore10 := (string) cddw_subscore10;
		SELF.cddw_subscore11 := (string) cddw_subscore11;
		SELF.cddw_subscore12 := (string) cddw_subscore12;
		SELF.cddw_subscore13 := (string) cddw_subscore13;
		SELF.cddw_subscore14 := (string) cddw_subscore14;
		SELF.cddw_subscore15 := (string) cddw_subscore15;
		SELF.cddw_subscore16 := (string) cddw_subscore16;
		SELF.cddw_subscore17 := (string) cddw_subscore17;
		SELF.cddw_subscore18 := (string) cddw_subscore18;
		SELF.cddw_subscore19 := (string) cddw_subscore19;
		SELF.cddw_subscore20 := (string) cddw_subscore20;
		SELF.cddw_subscore21 := (string) cddw_subscore21;
		SELF.cddw_subscore22 := (string) cddw_subscore22;
		SELF.cddw_subscore23 := (string) cddw_subscore23;
		SELF.cddw_subscore24 := (string) cddw_subscore24;
		SELF.cddw_rawscore := (string) cddw_rawscore;
		SELF.cddw_lnoddsscore := (string) cddw_lnoddsscore;
		SELF.cdsp_subscore0 := (string) cdsp_subscore0;
		SELF.cdsp_subscore1 := (string) cdsp_subscore1;
		SELF.cdsp_subscore2 := (string) cdsp_subscore2;
		SELF.cdsp_subscore3 := (string) cdsp_subscore3;
		SELF.cdsp_subscore4 := (string) cdsp_subscore4;
		SELF.cdsp_subscore5 := (string) cdsp_subscore5;
		SELF.cdsp_subscore6 := (string) cdsp_subscore6;
		SELF.cdsp_subscore7 := (string) cdsp_subscore7;
		SELF.cdsp_subscore8 := (string) cdsp_subscore8;
		SELF.cdsp_subscore9 := (string) cdsp_subscore9;
		SELF.cdsp_subscore10 := (string) cdsp_subscore10;
		SELF.cdsp_subscore11 := (string) cdsp_subscore11;
		SELF.cdsp_subscore12 := (string) cdsp_subscore12;
		SELF.cdsp_subscore13 := (string) cdsp_subscore13;
		SELF.cdsp_subscore14 := (string) cdsp_subscore14;
		SELF.cdsp_rawscore := (string) cdsp_rawscore;
		SELF.cdsp_lnoddsscore := (string) cdsp_lnoddsscore;
		SELF.cdsw_subscore0 := (string) cdsw_subscore0;
		SELF.cdsw_subscore1 := (string) cdsw_subscore1;
		SELF.cdsw_subscore2 := (string) cdsw_subscore2;
		SELF.cdsw_subscore3 := (string) cdsw_subscore3;
		SELF.cdsw_subscore4 := (string) cdsw_subscore4;
		SELF.cdsw_subscore5 := (string) cdsw_subscore5;
		SELF.cdsw_subscore6 := (string) cdsw_subscore6;
		SELF.cdsw_subscore7 := (string) cdsw_subscore7;
		SELF.cdsw_subscore8 := (string) cdsw_subscore8;
		SELF.cdsw_subscore9 := (string) cdsw_subscore9;
		SELF.cdsw_subscore10 := (string) cdsw_subscore10;
		SELF.cdsw_subscore11 := (string) cdsw_subscore11;
		SELF.cdsw_subscore12 := (string) cdsw_subscore12;
		SELF.cdsw_subscore13 := (string) cdsw_subscore13;
		SELF.cdsw_subscore14 := (string) cdsw_subscore14;
		SELF.cdsw_subscore15 := (string) cdsw_subscore15;
		SELF.cdsw_subscore16 := (string) cdsw_subscore16;
		SELF.cdsw_subscore17 := (string) cdsw_subscore17;
		SELF.cdsw_subscore18 := (string) cdsw_subscore18;
		SELF.cdsw_rawscore := (string) cdsw_rawscore;
		SELF.cdsw_lnoddsscore := (string) cdsw_lnoddsscore;
		SELF.cdop_subscore0 := (string) cdop_subscore0;
		SELF.cdop_subscore1 := (string) cdop_subscore1;
		SELF.cdop_subscore2 := (string) cdop_subscore2;
		SELF.cdop_subscore3 := (string) cdop_subscore3;
		SELF.cdop_subscore4 := (string) cdop_subscore4;
		SELF.cdop_subscore5 := (string) cdop_subscore5;
		SELF.cdop_subscore6 := (string) cdop_subscore6;
		// SELF.cdop_subscore7 := (string) cdop_subscore7;
		SELF.cdop_subscore8 := (string) cdop_subscore8;
		SELF.cdop_subscore9 := (string) cdop_subscore9;
		SELF.cdop_subscore10 := (string) cdop_subscore10;
		SELF.cdop_subscore11 := (string) cdop_subscore11;
		SELF.cdop_subscore12 := (string) cdop_subscore12;
		SELF.cdop_subscore13 := (string) cdop_subscore13;
		SELF.cdop_subscore14 := (string) cdop_subscore14;
		SELF.cdop_subscore15 := (string) cdop_subscore15;
		SELF.cdop_subscore16 := (string) cdop_subscore16;
		SELF.cdop_rawscore := (string) cdop_rawscore;
		SELF.cdop_lnoddsscore := (string) cdop_lnoddsscore;
		SELF.cdow_subscore0 := (string) cdow_subscore0;
		SELF.cdow_subscore1 := (string) cdow_subscore1;
		SELF.cdow_subscore2 := (string) cdow_subscore2;
		SELF.cdow_subscore3 := (string) cdow_subscore3;
		SELF.cdow_subscore4 := (string) cdow_subscore4;
		SELF.cdow_subscore5 := (string) cdow_subscore5;
		SELF.cdow_subscore6 := (string) cdow_subscore6;
		SELF.cdow_subscore7 := (string) cdow_subscore7;
		SELF.cdow_subscore8 := (string) cdow_subscore8;
		SELF.cdow_subscore9 := (string) cdow_subscore9;
		SELF.cdow_subscore10 := (string) cdow_subscore10;
		SELF.cdow_subscore11 := (string) cdow_subscore11;
		SELF.cdow_subscore12 := (string) cdow_subscore12;
		SELF.cdow_subscore13 := (string) cdow_subscore13;
		SELF.cdow_subscore14 := (string) cdow_subscore14;
		SELF.cdow_subscore15 := (string) cdow_subscore15;
		SELF.cdow_subscore16 := (string) cdow_subscore16;
		SELF.cdow_subscore17 := (string) cdow_subscore17;
		SELF.cdow_subscore18 := (string) cdow_subscore18;
		SELF.cdow_subscore19 := (string) cdow_subscore19;
		SELF.cdow_subscore20 := (string) cdow_subscore20;
		SELF.cdow_rawscore := (string) cdow_rawscore;
		SELF.cdow_lnoddsscore := (string) cdow_lnoddsscore;
		SELF.final_model_lnodds := (string)final_model_lnodds;
		SELF.base := (string)base;
		SELF.points := (string)points;
		SELF.odds := (string)odds;
		SELF.dell_custom_model := (string)dell_custom_model;
		SELF.cdn1205_1_0 := (string)cdn1205_1_0;
		SELF.attr_segment := (string)attr_segment;
		SELF.attr_relation := (string)attr_relation;
		SELF.cdn1205_1_0_custom_attribute := (string)cdn1205_1_0_custom_attribute;
		SELF.rc1 := '';
		SELF.rc2 := '';
		SELF.rc3 := '';
		SELF.rc4 := '';
		
		self.seq := le.cd2i.seq;
		SELF.clam := le.BS;
	#else
	
		bt := riskwise.reasons( le.bs.bill_to_out, PrescreenOptOut:=false, isCalifornia:=false );
		
		billto_consumer_reasons :=
			if(bt.rc09, bt.makeRC('09')) &
			if(bt.rc08, bt.makeRC('08')) &
			if(bt.rc31, bt.makeRC('31')) &
			if(risk_indicators.rcSet.isCodeIF(le.bs.ip2o.countrycode), bt.makeRC('IF')) &
			if(bt.rc19, bt.makeRC('19')) &
			if(bt.rc49, bt.makeRC('49')) &
			if(bt.rc11, bt.makeRC('11')) &
			if(bt.rc16, bt.makeRC('16')) &
			if(bt.rc64, bt.makeRC('64')) &
			if(bt.rcFV, bt.makeRC('FV')) &
			if(bt.rc76, bt.makeRC('76')) &
			if(Risk_Indicators.rcSet.isCodeIE(le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), bt.makeRC('IE')) &
			if(bt.rc77, bt.makeRC('77')) &
			if(bt.rc25, bt.makeRC('25')) &
			if(Risk_Indicators.rcSet.isCodeIB(le.bs.bill_to_out.shell_input.in_state, 
				le.bs.ip2o.state, le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), 
									bt.makeRC('IB')) &
			if(bt.rc37, bt.makeRC('37')) &
			if(bt.rc14, bt.makeRC('14')) &
			if(bt.rc9D, bt.makeRC('9D')) &
			if(bt.rc74, bt.makeRC('74')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			if(bt.rc30, bt.makeRC('30')) &
			if(bt.rc82, bt.makeRC('82')) &
			if(bt.rcMS, bt.makeRC('MS')) &
			if(bt.rc34, bt.makeRC('34')) &
			if(bt.rcSR, bt.makeRC('SR')) &
			if(bt.rc73, bt.makeRC('73')) &
			if(bt.rc40, bt.makeRC('40')) &
			if(bt.rc9K, bt.makeRC('9K')) &
			if(bt.rc97, bt.makeRC('97')) &
			if(bt.rc07, bt.makeRC('07')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(bt.rcBO, bt.makeRC('BO')) &
			if(bt.rc56, bt.makeRC('56')) &
			if(bt.rc27, bt.makeRC('27')) &
			if(bt.rc10, bt.makeRC('10')) &
			if(bt.rc5Q, bt.makeRC('5Q')) &
			if(bt.rc80, bt.makeRC('80')) &
			if(Risk_Indicators.rcSet.isCodeID(le.bs.ip2o.areacode, 
				le.bs.bill_to_out.shell_input.phone10, le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, le.bs.ip2o.countrycode, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.iptype), 
									bt.makeRC('ID')) &
			if(bt.rc57, bt.makeRC('57')) &
			if(bt.rc12, bt.makeRC('12')) &
			if(bt.rcPA, bt.makeRC('PA')) &
			if(bt.rcPO, bt.makeRC('PO')) &
			if(bt.rc15, bt.makeRC('15')) &
			if(bt.rc75, bt.makeRC('75')) &
			if(Risk_Indicators.rcSet.isCodeIC(le.bs.bill_to_out.shell_input.in_zipCode, le.bs.ip2o.zip, 
				le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype, le.bs.ip2o.areacode, le.bs.bill_to_out.shell_input.phone10), 
									bt.makeRC('IC')) &
			if(Risk_Indicators.rcSet.isCodeIG(le.bs.ip2o.iptype), bt.makeRC('IG')) &
			if(bt.rc55, bt.makeRC('55')) &
			if(bt.rc50, bt.makeRC('50')) &
			if(bt.rc13, bt.makeRC('13')) &
			if(bt.rc43, bt.makeRC('43')) &
			if(bt.rc78, bt.makeRC('78')) &
			if(Risk_Indicators.rcSet.isCodeIA(le.bs.bill_to_out.shell_input.ip_address, le.bs.ip2o.ipaddr<>''), bt.makeRC('IA')) &
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00');
			
		st := riskwise.reasons( le.bs.ship_to_out, PrescreenOptOut:=false, isCalifornia:=false );
		
		shipto_consumer_reasons :=
			if(st.rc02, st.makeRC('02')) &
			if(st.rc09, st.makeRC('09')) &
			if(st.rc08, st.makeRC('08')) &
			if(st.rc49, st.makeRC('49')) &
			if(st.rc16, st.makeRC('16')) &
			if(st.rc19, st.makeRC('19')) &
			if(st.rc31, st.makeRC('31')) &
			if(st.rc77, st.makeRC('77')) &
			if(st.rcFV, st.makeRC('FV')) &
			if(st.rc74, st.makeRC('74')) &
			if(st.rc97, st.makeRC('97')) &
			if(st.rc64, st.makeRC('64')) &
			if(st.rc55, st.makeRC('55')) &
			if(st.rc11, st.makeRC('11')) &
			if(st.rc76, st.makeRC('76')) &
			if(st.rcMS, st.makeRC('MS')) &
			if(st.rc9D, st.makeRC('9D')) &
			if(st.rc37, st.makeRC('37')) &
			if(st.rc25, st.makeRC('25')) &
			if(st.rc9K, st.makeRC('9K')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			if(st.rc34, st.makeRC('34')) &
			if(st.rc07, st.makeRC('07')) &
			if(st.rc82, st.makeRC('82')) &
			if(st.rc30, st.makeRC('30')) &
			if(st.rc73, st.makeRC('73')) &
			if(st.rcBO, st.makeRC('BO')) &
			if(st.rc14, st.makeRC('14')) &
			if(st.rc5Q, st.makeRC('5Q')) &
			if(st.rc27, st.makeRC('27')) &
			if(st.rc10, st.makeRC('10')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(st.rc12, st.makeRC('12')) &
			if(st.rcSR, st.makeRC('SR')) &
			if(st.rcPO, st.makeRC('PO')) &
			if(st.rc15, st.makeRC('15')) &
			if(st.rc40, st.makeRC('40')) &
			if(st.rcPA, st.makeRC('PA')) &
			if(st.rc57, st.makeRC('57')) &
			if(st.rc56, st.makeRC('56')) &
			if(st.rc75, st.makeRC('75')) &
			if(st.rc80, st.makeRC('80')) &
			if(st.rc78, st.makeRC('78')) &
			if(st.rc53, st.makeRC('53')) &
			if(st.rc50, st.makeRC('50')) &
			if(st.rc13, st.makeRC('13')) &
			if(st.rc43, st.makeRC('43')) &
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00') & 
			st.makeRC('00')	 ;	
	
billto_business_reasons :=		
			if(bt.rc09, bt.makeRC('09')) &
			if(bt.rc32, bt.makeRC('32')) &
			if(Risk_Indicators.rcSet.isCodeCZ(rt.bill_to_output.statezipflag, rt.bill_to_output.cityzipflag), bt.makeRC('CZ')) &
			if(risk_indicators.rcSet.isCodeIF(le.bs.ip2o.countrycode), bt.makeRC('IF')) &
			if(bt.rc19, bt.makeRC('19')) &
			if(Risk_Indicators.rcSet.isCodeIB(le.bs.bill_to_out.shell_input.in_state, 
				le.bs.ip2o.state, le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), 
									bt.makeRC('IB')) &
			if(bt.rc37, bt.makeRC('37')) &
			if(bt.rc11, bt.makeRC('11')) &
			if(bt.rc25, bt.makeRC('25')) &
			if(bt.rc27, bt.makeRC('27')) &
			if(Risk_Indicators.rcSet.isCodeIE(le.bs.ip2o.ipaddr<>'', le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype), bt.makeRC('IE')) &
			if(bt.rc40, bt.makeRC('40')) &
			if(Risk_Indicators.rcSet.isCodeA7(rt.bill_to_output.vernotrecentFlag), bt.makeRC('A7')) &
			if(bt.rc49, bt.makeRC('49')) &
			if(Risk_Indicators.rcSet.isCode70(rt.bill_to_output.resAddrFlag), bt.makeRC('70')) &
			if(bt.rc74, bt.makeRC('74')) &
			if(bt.rc10, bt.makeRC('10')) &
			if(bt.rc08, bt.makeRC('08')) &
			if(Risk_Indicators.rcSet.isCodeA6(rt.bill_to_output.bdid, rt.bill_to_output.goodstanding), bt.makeRC('A6')) &
			if(bt.rc64, bt.makeRC('64')) &
			if(Risk_Indicators.rcSet.isCode44(rt.bill_to_output.areacodesplitflag), bt.makeRC('44')) &
			if(bt.rc16, bt.makeRC('16')) &
			if(Risk_Indicators.rcSet.isCodeID(le.bs.ip2o.areacode, 
				le.bs.bill_to_out.shell_input.phone10, le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, le.bs.ip2o.countrycode, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.ipaddr<>'', le.bs.ip2o.iptype), 
									bt.makeRC('ID')) &
			if(bt.rc31, bt.makeRC('31')) &
			if(bt.rc07, bt.makeRC('07')) &
			if(Risk_Indicators.rcSet.isCodeA4(rt.bill_to_output.bdid, rt.bill_to_output.goodstanding), bt.makeRC('A4')) &
			if(rt.bill_to_output.resPhoneFlag = 'Y', bt.makeRC('69')) &
			if(Risk_Indicators.rcSet.isCode86(rt.bill_to_output.company_name, rt.bill_to_output.vercmpy, rt.bill_to_output.bestCompanyName), bt.makeRC('86')) &
			if(bt.rc76, bt.makeRC('76')) &
			if(bt.rc14, bt.makeRC('14')) &
			if(bt.rc82, bt.makeRC('82')) &
			if(bt.rc30, bt.makeRC('30')) &
			if(Risk_Indicators.rcSet.isCodeIC(le.bs.bill_to_out.shell_input.in_zipCode, le.bs.ip2o.zip, 
				le.bs.ip2o.countrycode, le.bs.ip2o.ipaddr<>'', le.bs.bill_to_out.shell_input.in_state, le.bs.ip2o.state, 
				le.bs.ip2o.secondleveldomain, le.bs.ip2o.iptype, le.bs.ip2o.areacode, le.bs.bill_to_out.shell_input.phone10), 
									bt.makeRC('IC')) &
			if(bt.rcPO, bt.makeRC('PO')) &
			if(bt.rcPA, bt.makeRC('PA')) &
			if(bt.rc43, bt.makeRC('43')) &
			if(bt.rc12, bt.makeRC('12')) &
			if(rt.bill_to_output.orig_z5<>'' and rt.bill_to_output.zipscore < 100 and 
				~((rt.bill_to_output.prim_name != '' or rt.bill_to_output.z5 != '' or rt.bill_to_output.st != '') and rt.bill_to_output.addrmatchflag = 'N'), 
									bt.makeRC('ZI')) &
			if(Risk_Indicators.rcSet.isCodeA5(rt.bill_to_output.lienbdidflag), bt.makeRC('A5')) &
			if(bt.rc15, bt.makeRC('15')) &
			if(Risk_Indicators.rcSet.isCodeIG(le.bs.ip2o.iptype), bt.makeRC('IG')) &
			if(Risk_Indicators.rcSet.isCodeIA(le.bs.bill_to_out.shell_input.ip_address, le.bs.ip2o.ipaddr<>''), bt.makeRC('IA')) &
			if(bt.rc77, bt.makeRC('77')) &
			if(bt.rc53, bt.makeRC('53')) &
			if(bt.rc50, bt.makeRC('50')) &
			if(bt.rc55, bt.makeRC('55')) &
			if(bt.rc78, bt.makeRC('78')) &
			if(bt.rcCO, bt.makeRC('CO')) &
			if(bt.rcMO, bt.makeRC('MO')) &
			if(bt.rcWL, bt.makeRC('WL')) &
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00') & 
			bt.makeRC('00')	;	

shipto_business_reasons := 
			if(st.rc09, st.makeRC('09')) &
			if(st.rc32, st.makeRC('32')) &
			if(Risk_Indicators.rcSet.isCodeCZ(rt.ship_to_output.statezipflag, rt.ship_to_output.cityzipflag), st.makeRC('CZ')) &
			if(st.rc19, st.makeRC('19')) &
			if(st.rc37, st.makeRC('37')) &
			if(st.rc25, st.makeRC('25')) &
			if(st.rc49, st.makeRC('49')) &
			if(st.rc11, st.makeRC('11')) &
			if(st.rc27, st.makeRC('27')) &
			if(Risk_Indicators.rcSet.isCodeA7(rt.ship_to_output.vernotrecentFlag), st.makeRC('A7')) &
			if(Risk_Indicators.rcSet.isCode70(rt.ship_to_output.resAddrFlag), st.makeRC('70')) &
			if(st.rc16, st.makeRC('16')) &
			if(st.rc74, st.makeRC('74')) &
			if(Risk_Indicators.rcSet.isCodeA6(rt.ship_to_output.bdid, rt.ship_to_output.goodstanding), st.makeRC('A6')) &
			if(st.rc64, st.makeRC('64')) &
			if(st.rc10, st.makeRC('10')) &
			if(st.rc08, st.makeRC('08')) &
			if(Risk_Indicators.rcSet.isCode44(rt.ship_to_output.areacodesplitflag), st.makeRC('44')) &
			if(st.rc12, st.makeRC('12')) &
			if(Risk_Indicators.rcSet.isCodeA4(rt.ship_to_output.bdid, rt.ship_to_output.goodstanding), st.makeRC('A4')) &
			if(st.rc40, st.makeRC('40')) &
			if(st.rc07, st.makeRC('07')) &
			if(st.rcPO, st.makeRC('PO')) &
			if(st.rc14, st.makeRC('14')) &
			if(rt.ship_to_output.resPhoneFlag = 'Y', st.makeRC('69')) &
			if(st.rc43, st.makeRC('43')) &
			if(Risk_Indicators.rcSet.isCode86(rt.ship_to_output.company_name, rt.ship_to_output.vercmpy, rt.ship_to_output.bestCompanyName), st.makeRC('86')) &
			if(st.rc76, st.makeRC('76')) &
			if(st.rc31, st.makeRC('31')) &
			if(st.rc30, st.makeRC('30')) &
			if(rt.ship_to_output.orig_z5<>'' and rt.ship_to_output.zipscore < 100 and 
				~((rt.ship_to_output.prim_name != '' or rt.ship_to_output.z5 != '' or rt.ship_to_output.st != '') and rt.ship_to_output.addrmatchflag = 'N'), st.makeRC('ZI')) &
			if(st.rcPA, st.makeRC('PA')) &
			if(Risk_Indicators.rcSet.isCodeA5(rt.ship_to_output.lienbdidflag), st.makeRC('A5')) &
			if(st.rc82, st.makeRC('82')) &
			if(st.rc15, st.makeRC('15')) &
			if(st.rc77, st.makeRC('77')) &
			if(st.rc53, st.makeRC('53')) &
			if(st.rc50, st.makeRC('50')) &
			if(st.rc55, st.makeRC('55')) &
			if(st.rc78, st.makeRC('78')) &
			if(st.rcCO, st.makeRC('CO')) &
			if(st.rcMO, st.makeRC('MO')) &
			if(st.rcWL, st.makeRC('WL')) &
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00') & 
st.makeRC('00')	;	
			
		// return 12 reason codes, 6 billto followed by 6 shipto, and the CDxO function maps them into their respective fields
		consumer_reasons := choosen(billto_consumer_reasons, 6) + choosen(shipto_consumer_reasons, 6);
		business_reasons := choosen(billto_business_reasons, 6) + choosen(shipto_business_reasons, 6);
		self.ri := if( isBusiness, business_reasons, consumer_reasons );
		
		// position 4..6 will now be blank																			
		SELF.score := (STRING3)cdn1205_1_0 + '   ' + (STRING3)cdn1205_1_0_custom_attribute ;
		SELF.seq := le.bs.bill_to_out.seq;
	#end
	END;

	model := join(with_census, biid, left.bs.bill_to_out.seq=right.Bill_to_Output.seq, doModel(LEFT, right), left outer);

	RETURN(model);
END;
