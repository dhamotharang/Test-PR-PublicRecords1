import TopBusiness_External;

export DNB := Module

export layout_rawdnbflat := RECORD
   string9 dnb_duns_number;
   string90 dnb_business_name;
   string30 dnb_trade_style;
   string25 dnb_street;
   string20 dnb_city;
   string2 dnb_state;
   string9 dnb_zip_code;
   string17 dnb_mail_address;
   string14 dnb_mail_city;
   string2 dnb_mail_state;
   string5 dnb_mail_zip_code;
   string10 dnb_telephone_number;
   string21 dnb_county_name;
   string4 dnb_msa_code;
   string40 dnb_msa_name;
   string128 dnb_line_of_business_description;
   string8 dnb_sic1;
   string60 dnb_sic1desc;
   string8 dnb_sic1a;
   string60 dnb_sic1adesc;
   string8 dnb_sic1b;
   string60 dnb_sic1bdesc;
   string8 dnb_sic1c;
   string60 dnb_sic1cdesc;
   string8 dnb_sic1d;
   string60 dnb_sic1ddesc;
   string8 dnb_sic2;
   string60 dnb_sic2desc;
   string8 dnb_sic2a;
   string60 dnb_sic2adesc;
   string8 dnb_sic2b;
   string60 dnb_sic2bdesc;
   string8 dnb_sic2c;
   string60 dnb_sic2cdesc;
   string8 dnb_sic2d;
   string60 dnb_sic2ddesc;
   string8 dnb_sic3;
   string60 dnb_sic3desc;
   string8 dnb_sic3a;
   string60 dnb_sic3adesc;
   string8 dnb_sic3b;
   string60 dnb_sic3bdesc;
   string8 dnb_sic3c;
   string60 dnb_sic3cdesc;
   string8 dnb_sic3d;
   string60 dnb_sic3ddesc;
   string8 dnb_sic4;
   string60 dnb_sic4desc;
   string8 dnb_sic4a;
   string60 dnb_sic4adesc;
   string8 dnb_sic4b;
   string60 dnb_sic4bdesc;
   string8 dnb_sic4c;
   string60 dnb_sic4cdesc;
   string8 dnb_sic4d;
   string60 dnb_sic4ddesc;
   string8 dnb_sic5;
   string60 dnb_sic5desc;
   string8 dnb_sic5a;
   string60 dnb_sic5adesc;
   string8 dnb_sic5b;
   string60 dnb_sic5bdesc;
   string8 dnb_sic5c;
   string60 dnb_sic5cdesc;
   string8 dnb_sic5d;
   string60 dnb_sic5ddesc;
   string8 dnb_sic6;
   string60 dnb_sic6desc;
   string8 dnb_sic6a;
   string60 dnb_sic6adesc;
   string8 dnb_sic6b;
   string60 dnb_sic6bdesc;
   string8 dnb_sic6c;
   string60 dnb_sic6cdesc;
   string8 dnb_sic6d;
   string60 dnb_sic6ddesc;
   string1 dnb_industry_group;
   string4 dnb_year_started;
   string8 dnb_date_of_incorporation;
   string2 dnb_state_of_incorporation_abbr;
   string1 dnb_annual_sales_volume_sign;
   string15 dnb_annual_sales_volume;
   string1 dnb_annual_sales_code;
   string1 dnb_employees_here_sign;
   string10 dnb_employees_here;
   string1 dnb_employees_total_sign;
   string10 dnb_employees_total;
   string1 dnb_employees_here_code;
   string1 dnb_internal_use;
   string8 dnb_annual_sales_revision_date;
   string1 dnb_net_worth_sign;
   string12 dnb_net_worth;
   string1 dnb_trend_sales_sign;
   string15 dnb_trend_sales;
   string1 dnb_trend_employment_total_sign;
   string10 dnb_trend_employment_total;
   string1 dnb_base_sales_sign;
   string15 dnb_base_sales;
   string1 dnb_base_employment_total_sign;
   string10 dnb_base_employment_total;
   string1 dnb_percentage_sales_growth_sign;
   string4 dnb_percentage_sales_growth;
   string1 dnb_percentage_employment_growth_sign;
   string4 dnb_percentage_employment_growth;
   string9 dnb_square_footage;
   string1 dnb_sals_territory;
   string1 dnb_owns_rents;
   string9 dnb_number_of_accounts;
   string9 dnb_bank_duns_number;
   string30 dnb_bank_name;
   string30 dnb_accounting_firm_name;
   string1 dnb_small_business_indicator;
   string1 dnb_minority_owned;
   string1 dnb_cottage_indicator;
   string1 dnb_foreign_owned;
   string1 dnb_manufacturing_here_indicator;
   string1 dnb_public_indicator;
   string1 dnb_importer_exporter_indicator;
   string1 dnb_structure_type;
   string1 dnb_type_of_establishment;
   string9 dnb_parent_duns_number;
   string9 dnb_ultimate_duns_number;
   string9 dnb_headquarters_duns_number;
   string30 dnb_parent_company_name;
   string30 dnb_ultimate_company_name;
   string9 dnb_dias_code;
   string3 dnb_hierarchy_code;
   string1 dnb_ultimate_indicator;
   string30 dnb_internal_use1;
   string10 dnb_internal_use2;
   string1 dnb_internal_use3;
   string1 dnb_hot_list_new_indicator;
   string1 dnb_hot_list_ownership_change_indicator;
   string1 dnb_hot_list_ceo_change_indicator;
   string1 dnb_hot_list_company_name_change_ind;
   string1 dnb_hot_list_address_change_indicator;
   string1 dnb_hot_list_telephone_change_indicator;
   string6 dnb_hot_list_new_change_date;
   string6 dnb_hot_list_ownership_change_date;
   string6 dnb_hot_list_ceo_change_date;
   string6 dnb_hot_list_company_name_chg_date;
   string6 dnb_hot_list_address_change_date;
   string6 dnb_hot_list_telephone_change_date;
   string8 dnb_report_date;
   string1 dnb_delete_record_indicator;
  END;

shared layout_clean182_fips := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 p_city_name;
   string25 v_city_name;
   string2 st;
   string5 zip;
   string4 zip4;
   string4 cart;
   string1 cr_sort_sz;
   string4 lot;
   string1 lot_order;
   string2 dbpc;
   string1 chk_digit;
   string2 rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 msa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;


shared layout_raw := RECORD
  unsigned6 rid;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 bid;
  unsigned1 bid_score;
  unsigned4 date_first_seen;
  unsigned4 date_last_seen;
  unsigned4 date_vendor_first_reported;
  unsigned4 date_vendor_last_reported;
  layout_rawdnbflat rawfields;
  Layout_Clean182_fips clean_mail_address;
  Layout_Clean182_fips clean_address;
  unsigned1 record_type;
  string1 active_duns_number;
  unsigned8 mail_rawaid;
  unsigned8 mail_aceaid;
  unsigned8 rawaid;
  unsigned8 aceaid;
 END;

shared layout_dnb_bid := record
  unsigned6 rid;
  unsigned6 bdid;
  unsigned1 bdid_score;
  unsigned6 bid;
  unsigned1 bid_score;
	layout_rawdnbflat;
	Layout_Clean182_fips;
end;

export file_raw :=
	dataset('~thor_data400::base::dnb_dmi::20111202::companies', layout_raw, thor);


layout_dnb_bid norm(recordof(file_raw) parent, integer c) := transform
	self := parent;
	self := parent.rawfields;
	self := parent.clean_address;
end;

export file_flat := normalize(file_raw, 1, norm(left,counter));

//	//uncomment in order to build D&B/BID file

// output(file_flat);
// count( file_flat );

// output( count(dnb_flat(bdid=0)), named('bdid_no_hit_cnt') );
// output( count(dnb_flat(bdid!=0)), named('bdid_hit_cnt') );

TopBusiness_External.MAC_External_BID(file_flat,
																			BIDFile,
																			bid,
																			bid_score,
																			,,,
																			dnb_business_name,
																			zip,
																			prim_name,
																			prim_range,
																			,dnb_telephone_number,
																			true );
                                      
// output( count(BIDFile(bid=0)), named('bid_no_hit_cnt') );
// output( count(BIDFile(bid!=0)), named('bid_hit_cnt') );

// output( BIDFile(bid=0), named('bid_no_hit') );
// output( BIDFile(bid!=0), named('bid_hit') );

// carefull -- this will take a while
export proc_AppendBID :=
	output(BIDFile, ,
				 'poc::dnb_with_bid', 
				 csv(heading(single), quote(''), separator('\t'), terminator('\n')),
				 overwrite
				 );

// //dnb/bid file is built...
			 
export file_bid := 
	dataset('~thor20_11::poc::dnb_with_bid', layout_dnb_bid, csv(heading(1), quote('"'), separator('\t'), terminator(['\r\n', '\n']), maxlength(102400000)), opt);


export spray_sample := 
	sequential(
		output(choosen(file_bid,100000), ,
					 'poc::dnb_with_bid_sample', 
					 csv(heading(single), quote(''), separator('\t'), terminator('\n'), maxlength(102400000)),
					 overwrite
					 )
		,FileServices.DeSpray('~thor20_11::poc::dnb_with_bid_sample', Constants.landing_ip, 'w:\\poc\\dnb_bid_sample.tsv', ,,,true)
	);

export
	ln_subset := join(file_bid(bid!=0),
										CompanyAddresses.file_bid_deduped(bid!=0),
										left.bid=right.bid,
										lookup) : persist('poc::tmp::dnb_ln_with_bid');

shared layout_dnb_numbers := record
	layout_rawdnbflat.dnb_duns_number;
  layout_rawdnbflat.dnb_parent_duns_number;
  layout_rawdnbflat.dnb_headquarters_duns_number;
  layout_rawdnbflat.dnb_ultimate_duns_number;
end;

export ln_subset_numbers := dedup(sort(distribute(project(ln_subset,layout_dnb_numbers),hash(dnb_duns_number)),dnb_duns_number,local),dnb_duns_number,local) : persist('poc::tmp::dnb_ln_subset_numbers');

export dnb_unique_numbers := dedup(sort(distribute(project(file_bid,layout_dnb_numbers),hash(dnb_duns_number)),dnb_duns_number,local),dnb_duns_number,local) : persist('poc::tmp::dnb_unique_numbers');

parent_level := join(dnb_unique_numbers,
									   ln_subset_numbers(dnb_parent_duns_number!=''),
										 left.dnb_duns_number=right.dnb_parent_duns_number,
										 lookup);
										 
headquarter_level := join(dnb_unique_numbers,
													ln_subset_numbers(dnb_headquarters_duns_number!='')+parent_level(dnb_headquarters_duns_number!=''),
													left.dnb_duns_number=right.dnb_headquarters_duns_number,
													lookup);
													
ultimate_level := join(dnb_unique_numbers,
											 ln_subset_numbers(dnb_ultimate_duns_number!=''),
											 left.dnb_duns_number=right.dnb_ultimate_duns_number,
											 lookup);
											 
export ln_all_levels := dedup(sort(distribute(ln_subset_numbers+parent_level+headquarter_level+ultimate_level,hash(dnb_duns_number)),dnb_duns_number,local),dnb_duns_number,local) : persist('poc::tmp::dnb_ln_all_numbers');

full_ln_dnb_file := join(file_bid,
												 ln_all_levels,
												 left.dnb_duns_number=right.dnb_duns_number,
												 lookup);
                         

export spray_full_ln_dnb_file := 
	sequential(
		output(full_ln_dnb_file, ,
					 'poc::dnb_full_ln_file', 
					 csv(heading(single), quote('"'), separator(','), terminator('\n'), maxlength(102400000)),
					 overwrite
					 )
		,FileServices.DeSpray('~thor20_11::poc::dnb_full_ln_file', Constants.landing_ip, 'w:\\poc\\dnb_full_ln_file.csv', ,,,true)
	);
										 
export ds_full_ln_dnb_file := 
	dataset('~thor20_11::poc::dnb_full_ln_file', layout_dnb_bid, csv(heading(1), quote('"'), separator(','), terminator(['\r\n', '\n']), maxlength(102400000)), opt);


layout_slim_ln_dnb_file := record
	ds_full_ln_dnb_file.bdid;
	ds_full_ln_dnb_file.bdid_score;
	ds_full_ln_dnb_file.bid;
	ds_full_ln_dnb_file.bid_score;
	ds_full_ln_dnb_file.dnb_duns_number;
	ds_full_ln_dnb_file.dnb_business_name;
	ds_full_ln_dnb_file.dnb_state;
	ds_full_ln_dnb_file.dnb_line_of_business_description;
	ds_full_ln_dnb_file.dnb_sic1;
	ds_full_ln_dnb_file.dnb_sic1desc;
	ds_full_ln_dnb_file.dnb_sic1a;
	ds_full_ln_dnb_file.dnb_sic1adesc;
	ds_full_ln_dnb_file.dnb_industry_group;
	ds_full_ln_dnb_file.dnb_year_started;
	ds_full_ln_dnb_file.dnb_date_of_incorporation;
	ds_full_ln_dnb_file.dnb_annual_sales_volume_sign;
	ds_full_ln_dnb_file.dnb_annual_sales_volume;
	ds_full_ln_dnb_file.dnb_employees_here_sign;
	ds_full_ln_dnb_file.dnb_employees_here;
	ds_full_ln_dnb_file.dnb_employees_total_sign;
	ds_full_ln_dnb_file.dnb_employees_total;
	ds_full_ln_dnb_file.dnb_annual_sales_revision_date;
	ds_full_ln_dnb_file.dnb_net_worth_sign;
	ds_full_ln_dnb_file.dnb_net_worth;
	ds_full_ln_dnb_file.dnb_trend_sales_sign;
	ds_full_ln_dnb_file.dnb_trend_sales;
	ds_full_ln_dnb_file.dnb_trend_employment_total_sign;
	ds_full_ln_dnb_file.dnb_trend_employment_total;
	ds_full_ln_dnb_file.dnb_base_sales_sign;
	ds_full_ln_dnb_file.dnb_base_sales;
	ds_full_ln_dnb_file.dnb_base_employment_total_sign;
	ds_full_ln_dnb_file.dnb_base_employment_total;
	ds_full_ln_dnb_file.dnb_percentage_sales_growth_sign;
	ds_full_ln_dnb_file.dnb_percentage_sales_growth;
	ds_full_ln_dnb_file.dnb_percentage_employment_growth_sign;
	ds_full_ln_dnb_file.dnb_percentage_employment_growth;
	ds_full_ln_dnb_file.dnb_owns_rents;
	ds_full_ln_dnb_file.dnb_small_business_indicator;
	ds_full_ln_dnb_file.dnb_foreign_owned;
	ds_full_ln_dnb_file.dnb_structure_type;
	ds_full_ln_dnb_file.dnb_type_of_establishment;
	ds_full_ln_dnb_file.dnb_parent_duns_number;
	ds_full_ln_dnb_file.dnb_ultimate_duns_number;
	ds_full_ln_dnb_file.dnb_headquarters_duns_number;
	ds_full_ln_dnb_file.dnb_parent_company_name;
	ds_full_ln_dnb_file.dnb_ultimate_company_name;
	ds_full_ln_dnb_file.dnb_hot_list_new_indicator;
	ds_full_ln_dnb_file.dnb_hot_list_ownership_change_indicator;
	ds_full_ln_dnb_file.dnb_hot_list_ceo_change_indicator;
	ds_full_ln_dnb_file.dnb_hot_list_company_name_change_ind;
	ds_full_ln_dnb_file.dnb_hot_list_address_change_indicator;
	ds_full_ln_dnb_file.dnb_hot_list_telephone_change_indicator;
	ds_full_ln_dnb_file.dnb_hot_list_new_change_date;
	ds_full_ln_dnb_file.dnb_hot_list_ownership_change_date;
	ds_full_ln_dnb_file.dnb_hot_list_ceo_change_date;
	ds_full_ln_dnb_file.dnb_hot_list_company_name_chg_date;
	ds_full_ln_dnb_file.dnb_hot_list_address_change_date;
	ds_full_ln_dnb_file.dnb_hot_list_telephone_change_date;
	ds_full_ln_dnb_file.dnb_report_date;
end;

ds_slim_ln_dnb_file := table(ds_full_ln_dnb_file, layout_slim_ln_dnb_file);

export spray_slim_ln_dnb_file := 
	sequential(
		output(ds_slim_ln_dnb_file, ,
					 'poc::dnb_slim_ln_file', 
					 csv(heading(single), quote('"'), separator(','), terminator('\n'), maxlength(102400000)),
					 overwrite
					 )
		,FileServices.DeSpray('~thor20_11::poc::dnb_slim_ln_file', Constants.landing_ip, 'w:\\poc\\dnb_slim_ln_file.csv', ,,,true)
	);

end;