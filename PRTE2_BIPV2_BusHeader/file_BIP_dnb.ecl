IMPORT ADDRESS, ADDRESS_ATTRIBUTES, BIPV2, PRTE2_DNB, TOOLS;

DNB_data := PRTE2_DNB.Files.dnb_linkids;
slim_DNB := DEDUP(SORT(DISTRIBUTE(DNB_data, HASH64(rawfields.duns_number)), rawfields.duns_number, -date_vendor_last_reported, LOCAL), rawfields.duns_number, LOCAL);

dDNB := DISTRIBUTE(slim_DNB, HASH64(clean_address.zip, clean_address.prim_range, clean_address.prim_name, clean_address.addr_suffix, clean_address.predir, clean_address.postdir, clean_address.sec_range));

//Initialize Address Based Counts
Address_Attributes.Layouts.rDnB_Indicators initAddrCnts(dDNB l) := TRANSFORM
	self.business_cnt:= if(l.active_duns_number <> 'N', 1, 0 );
	self.mailAID_ne_rawAID := if(l.mail_rawaid <> 0 and l.mail_rawaid <> l.rawaid ,1, 0);
	self.employee_cnt:= (integer)trim(l.rawfields.employees_here);
	self.employee_tot_cnt:= (integer)trim(l.rawfields.employees_total);
	self.employee_cnt_lt3 := if((integer)trim(l.rawfields.employees_total)< 3, 1, 0);
	self.small_biz_cnt:= if(l.rawfields.small_business_indicator = 'Y', 1, 0 );
	self.public_co_cnt:= if(l.rawfields.public_indicator = 'Y', 1, 0 );
	self.foreign_own_cnt:= if(l.rawfields.foreign_owned = 'Y', 1, 0 );
	self.holding_co_cnt:= if(l.rawfields.ultimate_indicator = 'Y', 1, 0 );
	self.active_duns_cnt:= if(l.active_duns_number = 'Y', 1, 0 );
	self.owns_cnt:= if(l.rawfields.owns_rents = '1', 1, 0 );
	self.rents_cnt:= if(l.rawfields.owns_rents = '2', 1, 0 );
	self.zero_sales_cnt:= if(l.rawfields.annual_sales_volume <> '' and l.rawfields.annual_sales_code = '2', 1, 0 );
	self.prim_range := l.clean_address.prim_range;
	self.predir := l.clean_address.predir;
	self.prim_name := l.clean_address.prim_name;
	self.addr_suffix := l.clean_address.addr_suffix;
	self.postdir := l.clean_address.postdir;
	self.unit_desig := l.clean_address.unit_desig;
	self.sec_range := l.clean_address.sec_range;
	self.p_city_name := l.clean_address.v_city_name;
	self.st := l.clean_address.st;
	self.zip := l.clean_address.zip;
	self.zip4 := l.clean_address.zip4;
	self.geo_lat := l.clean_address.geo_lat;
	self.geo_long := l.clean_address.geo_long;
	self.geo_blk := l.clean_address.geo_blk;
	self.fips_county := l.clean_address.fips_county;
	self.msa := l.clean_address.msa;
	self.geo_match := l.clean_address.geo_match;
	self := l;
	self := [];
END;
	biz_addr_cnts := PROJECT(dDNB, initAddrCnts(left), LOCAL);

//Count Businesses At Each Address - this rolls up all business per each unique address
Address_Attributes.Layouts.rDnB_Indicators rollDNB( Address_Attributes.Layouts.rDnB_Indicators l, Address_Attributes.Layouts.rDnB_Indicators r ) := TRANSFORM
	self.business_cnt := l.business_cnt + r.business_cnt;
	self.mailAID_ne_rawAID := l.mailAID_ne_rawAID + r.mailAID_ne_rawAID;
	self.employee_cnt := l.employee_cnt + r.employee_cnt;
	self.employee_tot_cnt := l.employee_tot_cnt + r.employee_tot_cnt;
	self.employee_cnt_lt3 := l.employee_cnt_lt3 + r.employee_cnt_lt3;
	self.small_biz_cnt := l.small_biz_cnt + r.small_biz_cnt;
	self.public_co_cnt := l.public_co_cnt + r.public_co_cnt;
	self.foreign_own_cnt := l.foreign_own_cnt + r.foreign_own_cnt;
	self.holding_co_cnt := l.holding_co_cnt + r.holding_co_cnt;
	self.active_duns_cnt := l.active_duns_cnt + r.active_duns_cnt;
	self.owns_cnt := l.owns_cnt + r.owns_cnt;
	self.rents_cnt := l.rents_cnt + r.rents_cnt;
	self.zero_sales_cnt := l.zero_sales_cnt + r.zero_sales_cnt;
	self := l;
END;
		
wIndicators := ROLLUP(SORT(biz_addr_cnts, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, LOCAL), 
		left.zip = right.zip and
		left.prim_range = right.prim_range and 
		left.prim_name = right.prim_name and 
		left.addr_suffix = right.addr_suffix and 
		left.predir = right.predir and
		left.postdir = right.postdir and
		left.sec_range = right.sec_range, 
	rollDNB(left,right), LOCAL);		

// Join back indicators to main file
Address_Attributes.Layouts.rDnB_Final joinFlags(slim_DNB l, wIndicators r) := TRANSFORM
	self.prim_range := l.clean_address.prim_range;
	self.predir := l.clean_address.predir;
	self.prim_name := l.clean_address.prim_name;
	self.addr_suffix := l.clean_address.addr_suffix;
	self.postdir := l.clean_address.postdir;
	self.unit_desig := l.clean_address.unit_desig;
	self.sec_range := l.clean_address.sec_range;
	self.p_city_name := l.clean_address.v_city_name;
	self.st := l.clean_address.st;
	self.zip := l.clean_address.zip;
	self.zip4 := l.clean_address.zip4;
	self.geo_lat := l.clean_address.geo_lat;
	self.geo_long := l.clean_address.geo_long;
	self.geo_blk := l.clean_address.geo_blk;
	self.fips_county := l.clean_address.fips_county;
	self.msa := l.clean_address.msa;
	self.geo_match := l.clean_address.geo_match;
	
	self.duns_number := l.rawfields.duns_number;
	self.Business_Name := l.rawfields.Business_Name;
	self.trade_style := l.rawfields.trade_style;
	self.telephone_number := l.rawfields.telephone_number;
	self.line_of_business_description := l.rawfields.line_of_business_description;
	self.industry_group := l.rawfields.industry_group;
	self.YEAR_STARTED := l.rawfields.YEAR_STARTED;
	self.sic1 := l.rawfields.sic1;
	self.sic1desc := l.rawfields.sic1desc;
	self.sic2 := l.rawfields.sic2;
	self.sic2desc := l.rawfields.sic2desc;
	self.date_of_incorporation := l.rawfields.date_of_incorporation;
	self.state_of_incorporation_abbr := l.rawfields.state_of_incorporation_abbr;
	// self.annual_sales_volume_sign := l.rawfields.annual_sales_volume_sign;
	self.annual_sales_volume := l.rawfields.annual_sales_volume;
	self.annual_sales_code := l.rawfields.annual_sales_code;
	// self.employees_here_sign := l.rawfields.employees_here_sign;
	self.employees_here := l.rawfields.employees_here;
	// self.employees_total_sign := l.rawfields.employees_total_sign;
	self.employees_total := l.rawfields.employees_total;
	self.employees_here_code := l.rawfields.employees_here_code;
	self.annual_sales_revision_date := l.rawfields.annual_sales_revision_date;
	// self.net_worth_sign := l.rawfields.net_worth_sign;
	self.net_worth := l.rawfields.net_worth;
	// self.trend_sales_sign := l.rawfields.trend_sales_sign;
	self.trend_sales := l.rawfields.trend_sales;
	// self.trend_employment_total_sign := l.rawfields.trend_employment_total_sign;
	self.trend_employment_total := l.rawfields.trend_employment_total;
	// self.base_sales_sign := l.rawfields.base_sales_sign;
	self.base_sales := l.rawfields.base_sales;
	// self.base_employment_total_sign := l.rawfields.base_employment_total_sign;
	self.base_employment_total := l.rawfields.base_employment_total;
	// self.percentage_sales_growth_sign := l.rawfields.percentage_sales_growth_sign;
	self.percentage_sales_growth := l.rawfields.percentage_sales_growth;
	// self.percentage_employment_growth_sign := l.rawfields.percentage_employment_growth_sign;
	self.percentage_employment_growth := l.rawfields.percentage_employment_growth;
	self.square_footage := l.rawfields.square_footage;
	self.sals_territory := l.rawfields.sals_territory;
	self.owns_rents := l.rawfields.owns_rents;
	self.number_of_accounts := l.rawfields.number_of_accounts;
	self.bank_duns_number := l.rawfields.bank_duns_number;
	self.bank_name := l.rawfields.bank_name;
	self.accounting_firm_name := l.rawfields.accounting_firm_name;
	self.small_business_indicator := l.rawfields.small_business_indicator;
	self.minority_owned := l.rawfields.minority_owned;
	self.cottage_indicator := l.rawfields.cottage_indicator;
	self.foreign_owned := l.rawfields.foreign_owned;
	self.manufacturing_here_indicator := l.rawfields.manufacturing_here_indicator;
	self.public_indicator := l.rawfields.public_indicator;
	self.importer_exporter_indicator := l.rawfields.importer_exporter_indicator;
	self.structure_type := l.rawfields.structure_type;
	self.type_of_establishment := l.rawfields.type_of_establishment;
	self.parent_duns_number := l.rawfields.parent_duns_number;
	self.ultimate_duns_number := l.rawfields.ultimate_duns_number;
	self.headquarters_duns_number := l.rawfields.headquarters_duns_number;
	self.parent_company_name := l.rawfields.parent_company_name;
	self.ultimate_company_name := l.rawfields.ultimate_company_name;
	self.dias_code := l.rawfields.dias_code;
	self.hierarchy_code := l.rawfields.hierarchy_code;
	self.ultimate_indicator := l.rawfields.ultimate_indicator;
	self.hot_list_new_indicator := l.rawfields.hot_list_new_indicator;
	self.hot_list_ownership_change_indicator := l.rawfields.hot_list_ownership_change_indicator;
	self.hot_list_ceo_change_indicator := l.rawfields.hot_list_ceo_change_indicator;
	self.hot_list_company_name_change_ind := l.rawfields.hot_list_company_name_change_ind;
	self.hot_list_address_change_indicator := l.rawfields.hot_list_address_change_indicator;
	self.hot_list_telephone_change_indicator := l.rawfields.hot_list_telephone_change_indicator;
	self.hot_list_new_change_date := l.rawfields.hot_list_new_change_date;
	self.hot_list_ownership_change_date := l.rawfields.hot_list_ownership_change_date;
	self.hot_list_ceo_change_date := l.rawfields.hot_list_ceo_change_date;
	self.hot_list_company_name_chg_date := l.rawfields.hot_list_company_name_chg_date;
	self.hot_list_address_change_date := l.rawfields.hot_list_address_change_date;
	self.hot_list_telephone_change_date := l.rawfields.hot_list_telephone_change_date;
	self.report_date := l.rawfields.report_date;
	self.delete_record_indicator := l.rawfields.delete_record_indicator;
	
	self := r;
	self := l;
END;

final := JOIN(slim_DNB, wIndicators,		
		trim(left.clean_address.zip) = trim(right.zip) and
		trim(left.clean_address.prim_range) = trim(right.prim_range) and 
		trim(left.clean_address.prim_name) = trim(right.prim_name) and 
		trim(left.clean_address.addr_suffix) = trim(right.addr_suffix) and 
		trim(left.clean_address.predir) = trim(right.predir) and
		trim(left.clean_address.postdir) = trim(right.postdir) and
		trim(left.clean_address.sec_range) = trim(right.sec_range), 
	joinFlags(left,right), left outer, HASH);


EXPORT file_BIP_dnb := final ;