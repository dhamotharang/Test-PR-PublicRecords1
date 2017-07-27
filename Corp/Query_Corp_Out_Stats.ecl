import Business_Header;

#workunit('name', 'Corporate Out Stats ' + corp.Corp_Build_Date);

f := Corp.File_Corp_Out;

layout_corp_slim := record
f.bdid;
f.corp_key;
f.corp_vendor;
f.corp_state_origin;
f.corp_process_date;
f.corp_sos_charter_nbr;
f.corp_legal_name;
f.corp_address1_type_cd;
f.corp_address1_type_desc;
f.corp_address1_line1;
f.corp_address1_line2;
f.corp_address1_line3;
f.corp_address1_line4;
f.corp_address1_line5;
f.corp_address1_line6;
f.corp_address1_effective_date;
f.corp_address2_type_cd;
f.corp_address2_type_desc;
f.corp_address2_line1;
f.corp_address2_line2;
f.corp_address2_line3;
f.corp_address2_line4;
f.corp_address2_line5;
f.corp_address2_line6;
f.corp_address2_effective_date;
f.corp_phone_number;
f.corp_phone_number_type_cd;
f.corp_phone_number_type_desc;
f.corp_email_address;
f.corp_web_address;
f.corp_filing_reference_nbr;
f.corp_filing_date;
f.corp_filing_cd;
f.corp_filing_desc;
f.corp_status_cd;
f.corp_status_desc;
f.corp_status_date;
f.corp_ticker_symbol;
f.corp_stock_exchange;
f.corp_inc_state;
f.corp_inc_date;
f.corp_fed_tax_id;
f.corp_state_tax_id;
f.corp_term_exist_cd;
f.corp_term_exist_exp;
f.corp_term_exist_desc;
f.corp_foreign_domestic_ind;
f.corp_forgn_state_cd;
f.corp_forgn_state_desc;
f.corp_forgn_sos_charter_nbr;
f.corp_forgn_date;
f.corp_forgn_fed_tax_id;
f.corp_forgn_state_tax_id;
f.corp_forgn_term_exist_cd;
f.corp_forgn_term_exist_exp;
f.corp_forgn_term_exist_desc;
f.corp_orig_org_structure_cd;
f.corp_orig_org_structure_desc;
f.corp_for_profit_ind;
f.corp_sic_code;
f.corp_orig_bus_type_cd;
f.corp_orig_bus_type_desc;
f.corp_ra_name;
f.corp_ra_title_cd;
f.corp_ra_title_desc;
f.corp_ra_fein;
f.corp_ra_ssn;
f.corp_ra_dob;
f.corp_ra_effective_date;
f.corp_ra_address_type_cd;
f.corp_ra_address_type_desc;
f.corp_ra_address_line1;
f.corp_ra_address_line2;
f.corp_ra_address_line3;
f.corp_ra_address_line4;
f.corp_ra_address_line5;
f.corp_ra_address_line6;
f.corp_ra_phone_number;
f.corp_ra_phone_number_type_cd;
f.corp_ra_phone_number_type_desc;
f.corp_ra_email_address;
f.corp_ra_web_address;
f.corp_addr1_zip5;
f.corp_addr2_zip5;
f.corp_addr1_err_stat;
f.corp_addr2_err_stat;
f.corp_phone10;
f.corp_ra_phone10;
f.record_type;
f.address_ind; 
end;

fslim := table(f, layout_corp_slim);

layout_corp_stat := record
fslim.corp_state_origin;
integer4 total:= count(group);

// BDID Counts
integer4 bdid_count := count(group, fslim.bdid <> '');

integer4 corp_key_cnt := count(group, fslim.corp_key <> '');
integer4 corp_vendor_cnt := count(group, fslim.corp_vendor <> '');
integer4 corp_process_date_cnt := count(group, fslim.corp_process_date <> '');
integer4 corp_sos_charter_nbr_cnt := count(group, fslim.corp_sos_charter_nbr <> '');
integer4 corp_legal_name_cnt := count(group, fslim.corp_legal_name <> '');
integer4 corp_address1_type_cd_cnt := count(group, fslim.corp_address1_type_cd <> '');
integer4 corp_address1_type_desc_cnt := count(group, fslim.corp_address1_type_desc <> '');
integer4 corp_address1_line1_cnt := count(group, fslim.corp_address1_line1 <> '');
integer4 corp_address1_line2_cnt := count(group, fslim.corp_address1_line2 <> '');
integer4 corp_address1_line3_cnt := count(group, fslim.corp_address1_line3 <> '');
integer4 corp_address1_line4_cnt := count(group, fslim.corp_address1_line4 <> '');
integer4 corp_address1_line5_cnt := count(group, fslim.corp_address1_line5 <> '');
integer4 corp_address1_line6_cnt := count(group, fslim.corp_address1_line6 <> '');
integer4 corp_address1_effective_date_cnt := count(group, fslim.corp_address1_effective_date <> '');
integer4 corp_address2_type_cd_cnt := count(group, fslim.corp_address2_type_cd <> '');
integer4 corp_address2_type_desc_cnt := count(group, fslim.corp_address2_type_desc <> '');
integer4 corp_address2_line1_cnt := count(group, fslim.corp_address2_line1 <> '');
integer4 corp_address2_line2_cnt := count(group, fslim.corp_address2_line2 <> '');
integer4 corp_address2_line3_cnt := count(group, fslim.corp_address2_line3 <> '');
integer4 corp_address2_line4_cnt := count(group, fslim.corp_address2_line4 <> '');
integer4 corp_address2_line5_cnt := count(group, fslim.corp_address2_line5 <> '');
integer4 corp_address2_line6_cnt := count(group, fslim.corp_address2_line6 <> '');
integer4 corp_address2_effective_date_cnt := count(group, fslim.corp_address2_effective_date <> '');
integer4 corp_phone_number_cnt := count(group, fslim.corp_phone_number <> '');
integer4 corp_phone_number_type_cd_cnt := count(group, fslim.corp_phone_number_type_cd <> '');
integer4 corp_phone_number_type_desc_cnt := count(group, fslim.corp_phone_number_type_desc <> '');
integer4 corp_email_address_cnt := count(group, fslim.corp_email_address <> '');
integer4 corp_web_address_cnt := count(group, fslim.corp_web_address <> '');
integer4 corp_filing_reference_nbr_cnt := count(group, fslim.corp_filing_reference_nbr <> '');
integer4 corp_filing_date_cnt := count(group, fslim.corp_filing_date <> '');
integer4 corp_filing_cd_cnt := count(group, fslim.corp_filing_cd <> '');
integer4 corp_filing_desc_cnt := count(group, fslim.corp_filing_desc <> '');
integer4 corp_status_cd_cnt := count(group, fslim.corp_status_cd <> '');
integer4 corp_status_desc_cnt := count(group, fslim.corp_status_desc <> '');
integer4 corp_status_date_cnt := count(group, fslim.corp_status_date <> '');
integer4 corp_ticker_symbol_cnt := count(group, fslim.corp_ticker_symbol <> '');
integer4 corp_stock_exchange_cnt := count(group, fslim.corp_stock_exchange <> '');
integer4 corp_inc_state_cnt := count(group, fslim.corp_inc_state <> '');
integer4 corp_inc_date_cnt := count(group, fslim.corp_inc_date <> '');
integer4 corp_fed_tax_id_cnt := count(group, fslim.corp_fed_tax_id <> '' and fslim.corp_fed_tax_id <> '000000000');
integer4 corp_fed_tax_id_valid_cnt := count(group, fslim.corp_fed_tax_id <> '' and fslim.corp_fed_tax_id <> '000000000' and Business_Header.ValidFEIN((unsigned4)fslim.corp_fed_tax_id));
integer4 corp_state_tax_id_cnt := count(group, (integer)fslim.corp_state_tax_id <> 0);

// Term of Existence code
integer4 corp_term_exist_cd_cnt := count(group, fslim.corp_term_exist_cd <> '');
integer4 corp_term_exist_cd_P := count(group, fslim.corp_term_exist_cd = 'P');
integer4 corp_term_exist_cd_N := count(group, fslim.corp_term_exist_cd = 'N');
integer4 corp_term_exist_cd_D := count(group, fslim.corp_term_exist_cd = 'D');
integer4 corp_term_exist_cd_other := count(group, fslim.corp_term_exist_cd not in ['P','N','D',' ']);
integer4 corp_term_exist_cd_blank := count(group, fslim.corp_term_exist_cd = ' ');

integer4 corp_term_exist_exp_cnt := count(group, fslim.corp_term_exist_exp <> '');
integer4 corp_term_exist_desc_cnt := count(group, fslim.corp_term_exist_desc <> '');

// Foreign-Domestic Inidcator
integer4 corp_foreign_domestic_ind_cnt := count(group, fslim.corp_foreign_domestic_ind <> '');
integer4 corp_foreign_domestic_ind_F := count(group, fslim.corp_foreign_domestic_ind = 'F');
integer4 corp_foreign_domestic_ind_D := count(group, fslim.corp_foreign_domestic_ind = 'D');
integer4 corp_foreign_domestic_ind_other := count(group, fslim.corp_foreign_domestic_ind not in ['F','D',' ']);
integer4 corp_foreign_domestic_ind_blank := count(group, fslim.corp_foreign_domestic_ind = ' ');

integer4 corp_forgn_state_cd_cnt := count(group, fslim.corp_forgn_state_cd <> '');
integer4 corp_forgn_state_desc_cnt := count(group, fslim.corp_forgn_state_desc <> '');
integer4 corp_forgn_sos_charter_nbr_cnt := count(group, fslim.corp_forgn_sos_charter_nbr <> '');
integer4 corp_forgn_date_cnt := count(group, fslim.corp_forgn_date <> '');
integer4 corp_forgn_fed_tax_id_cnt := count(group, fslim.corp_forgn_fed_tax_id <> ''and fslim.corp_forgn_fed_tax_id <> '000000000');
integer4 corp_forgn_fed_tax_id_valid_cnt := count(group, fslim.corp_forgn_fed_tax_id <> ''and fslim.corp_forgn_fed_tax_id <> '000000000' and Business_Header.ValidFEIN((unsigned4)fslim.corp_forgn_fed_tax_id));
integer4 corp_forgn_state_tax_id_cnt := count(group, fslim.corp_forgn_state_tax_id <> '');

// Foreign Term of Existence code
integer4 corp_forgn_term_exist_cd_cnt := count(group, fslim.corp_forgn_term_exist_cd <> '');
integer4 corp_forgn_term_exist_cd_P := count(group, fslim.corp_forgn_term_exist_cd = 'P');
integer4 corp_forgn_term_exist_cd_N := count(group, fslim.corp_forgn_term_exist_cd = 'N');
integer4 corp_forgn_term_exist_cd_D := count(group, fslim.corp_forgn_term_exist_cd = 'D');
integer4 corp_forgn_term_exist_cd_other := count(group, fslim.corp_forgn_term_exist_cd not in ['P','N','D',' ']);
integer4 corp_forgn_term_exist_cd_blank := count(group, fslim.corp_forgn_term_exist_cd = ' ');

integer4 corp_forgn_term_exist_exp_cnt := count(group, fslim.corp_forgn_term_exist_exp <> '');
integer4 corp_forgn_term_exist_desc_cnt := count(group, fslim.corp_forgn_term_exist_desc <> '');
integer4 corp_orig_org_structure_cd_cnt := count(group, fslim.corp_orig_org_structure_cd <> '');
integer4 corp_orig_org_structure_desc_cnt := count(group, fslim.corp_orig_org_structure_desc <> '');

// Profit - NonProfit Indicator
integer4 corp_for_profit_ind_cnt := count(group, fslim.corp_for_profit_ind <> '');
integer4 corp_for_profit_ind_Y := count(group, fslim.corp_for_profit_ind = 'Y');
integer4 corp_for_profit_ind_N := count(group, fslim.corp_for_profit_ind = 'N');
integer4 corp_for_profit_ind_other := count(group, fslim.corp_for_profit_ind not in ['Y','N',' ']);
integer4 corp_for_profit_ind_blank := count(group, fslim.corp_for_profit_ind = ' ');

integer4 corp_sic_code_cnt := count(group, fslim.corp_sic_code <> '');
integer4 corp_orig_bus_type_cd_cnt := count(group, fslim.corp_orig_bus_type_cd <> '');
integer4 corp_orig_bus_type_desc_cnt := count(group, fslim.corp_orig_bus_type_desc <> '');
integer4 corp_ra_name_cnt := count(group, fslim.corp_ra_name <> '');
integer4 corp_ra_title_cd_cnt := count(group, fslim.corp_ra_title_cd <> '');
integer4 corp_ra_title_desc_cnt := count(group, fslim.corp_ra_title_desc <> '');
integer4 corp_ra_fein_cnt := count(group, fslim.corp_ra_fein <> '' and fslim.corp_ra_fein <> '000000000');
integer4 corp_ra_fein_valid_cnt := count(group, fslim.corp_ra_fein <> '' and fslim.corp_ra_fein <> '000000000' and Business_Header.ValidFEIN((unsigned4)fslim.corp_ra_fein));
integer4 corp_ra_ssn_cnt := count(group, fslim.corp_ra_ssn <> '');
integer4 corp_ra_dob_cnt := count(group, fslim.corp_ra_dob <> '');
integer4 corp_ra_effective_date_cnt := count(group, fslim.corp_ra_effective_date <> '');
integer4 corp_ra_address_type_cd_cnt := count(group, fslim.corp_ra_address_type_cd <> '');
integer4 corp_ra_address_type_desc_cnt := count(group, fslim.corp_ra_address_type_desc <> '');
integer4 corp_ra_address_line1_cnt := count(group, fslim.corp_ra_address_line1 <> '');
integer4 corp_ra_address_line2_cnt := count(group, fslim.corp_ra_address_line2 <> '');
integer4 corp_ra_address_line3_cnt := count(group, fslim.corp_ra_address_line3 <> '');
integer4 corp_ra_address_line4_cnt := count(group, fslim.corp_ra_address_line4 <> '');
integer4 corp_ra_address_line5_cnt := count(group, fslim.corp_ra_address_line5 <> '');
integer4 corp_ra_address_line6_cnt := count(group, fslim.corp_ra_address_line6 <> '');
integer4 corp_ra_phone_number_cnt := count(group, fslim.corp_ra_phone_number <> '');
integer4 corp_ra_phone_number_type_cd_cnt := count(group, fslim.corp_ra_phone_number_type_cd <> '');
integer4 corp_ra_phone_number_type_desc_cnt := count(group, fslim.corp_ra_phone_number_type_desc <> '');
integer4 corp_ra_email_address_cnt := count(group, fslim.corp_ra_email_address <> '');
integer4 corp_ra_web_address_cnt := count(group, fslim.corp_ra_web_address <> '');

// clean zip stats
integer4 corp_addr1_zip5_cnt := count(group, (integer)fslim.corp_addr1_zip5 <> 0);
integer4 corp_addr2_zip5_cnt := count(group, (integer)fslim.corp_addr2_zip5 <> 0);

// clean address error stats
integer4 corp_addr1_err_stat_S := count(group, fslim.corp_addr1_err_stat[1] = 'S');
integer4 corp_addr1_err_stat_E := count(group, fslim.corp_addr1_err_stat[1] = 'E');
integer4 corp_addr1_err_stat_U := count(group, fslim.corp_addr1_err_stat[1] = 'U');
integer4 corp_addr1_err_stat_other := count(group, fslim.corp_addr1_err_stat[1] not in ['S','E','U']);
integer4 corp_addr2_err_stat_S := count(group, fslim.corp_addr2_err_stat[1] = 'S');
integer4 corp_addr2_err_stat_E := count(group, fslim.corp_addr2_err_stat[1] = 'E');
integer4 corp_addr2_err_stat_U := count(group, fslim.corp_addr2_err_stat[1] = 'U');
integer4 corp_addr2_err_stat_other := count(group, fslim.corp_addr2_err_stat[1] not in ['S','E','U']);

// Clean Phone Numbers
integer4 corp_phone10_cnt := count(group, (integer)fslim.corp_phone10 <> 0);
integer4 corp_ra_phone10_cnt := count(group, (integer)fslim.corp_ra_phone10 <> 0);

// Record Type
integer4  record_type_C := count(group, fslim.record_type='C');
integer4  record_type_H := count(group,fslim.record_type='H');

//Address Indicator
integer4  address_ind_R := count(group, fslim.address_ind='R');
integer4  address_ind_blank := count(group, fslim.address_ind=' ');
end;

fstat := table(fslim, layout_corp_stat, corp_state_origin, few);

output(fstat);