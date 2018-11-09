EXPORT Layout_FIDO := MODULE

export extract_in := RECORD
  integer4 customer_account_sk;
  string30 hist_subaccount_id;
  string30 current_subaccount_id;
  string255 hh_name;
  integer4 mbs_gc_id;
  integer4 mbs_company_id;
  integer4 mbs_product_id;
  integer4 mbs_sub_product_id;
  integer4 hh_id;
  string2 primary_market_cd;
  string2 secondary_market_cd;
  string2 industry_code_1;
  string2 industry_code_2;
  string100 sub_market;
  integer4 cy_vertical_sk;
  string15 vc_id;
  boolean internal_flag;
  string50 vertical_market;
  string50 abstracted_vertical_market;
  string100 subaccount_name;
  integer8 bip_prox_id;
  string50 inquiry_tracking_industry;
  string4 ranked_sic_code;
  string100 industry;
  string30 use;
  integer1 opt_out;
  integer1 disable_observation;
  string16 content;
  integer1 exclude_from_access;
  string allow_flag;
  string mask;
  string market;
	unsigned4 first_seen_dt;
  unsigned4 last_seen_dt;
  string100 country;
  string100 country_gen1;
  string100 country_gen2;
  string100 country_gen3;

 END;

export extract_out := record
  
 string30 hist_subaccount_id;
  string30 current_subaccount_id;
  integer4 mbs_gc_id;
  integer4 mbs_company_id;
  integer4 mbs_product_id;
  integer4 mbs_sub_product_id;
 string2 primary_market_cd;
  string2 secondary_market_cd;
  string2 industry_code_1;
  string2 industry_code_2;
  string100 sub_market;
  integer4 cy_vertical_sk;
  string15 vc_id;
  boolean internal_flag;
  string50 vertical_market;
  string50 abstracted_vertical_market;
  string100 subaccount_name;
  string50 inquiry_tracking_industry;
  string4 ranked_sic_code;
	string industry;
  string use;
  string opt_out;
  string disable_observation;
  string content;
	integer1 exclude_from_access;
  string mask;
  string market;
  unsigned4 first_seen_dt;
  unsigned4 last_seen_dt;
  string100 country;
  string100 country_gen1;
  string100 country_gen2;
  string100 country_gen3;
	
 END;

export new_MBS := record
  
 		            string product_id;
								string sub_product_id;
								string gc_id;
								string company_id;
								string sub_acct_id;
								string vertical;
								string market;
								string sub_market;
								string industry;
								string use;
								string primary_market_code;
								string secondary_market_code;
								string industry_code_1;
								string industry_code_2;
								string disable_observation;
								string opt_out;
								string content;
								unsigned8 allowflags;
								string translation;
								string internal_flag;
								string mbs_company_name;
								string4 ranked_sic_code;
								integer1 exclude_from_access;
								string mask;
								integer1 priority_flag;
								string100 country;

		
 END;

END;