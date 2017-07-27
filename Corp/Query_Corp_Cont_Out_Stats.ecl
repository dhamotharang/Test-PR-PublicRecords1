import Business_Header;

#workunit('name', 'Corporate Contact Out Stats ' + corp.Corp_Build_Date);

f := Corp.File_Corp_Cont_Out;

layout_corp_slim := record
f.did;
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
f.corp_phone_number;
f.corp_phone_number_type_cd;
f.corp_phone_number_type_desc;
f.corp_email_address;
f.corp_web_address;
f.cont_filing_reference_nbr;
f.cont_filing_date;
f.cont_filing_cd;
f.cont_filing_desc;
f.cont_type_cd;
f.cont_type_desc;
f.cont_name;
f.cont_title1_desc;
f.cont_title2_desc;
f.cont_title3_desc;
f.cont_title4_desc;
f.cont_title5_desc;
f.cont_fein;
f.cont_ssn;
f.cont_dob;
f.cont_effective_date;
f.cont_address_type_cd;
f.cont_address_type_desc;
f.cont_address_line1;
f.cont_address_line2;
f.cont_address_line3;
f.cont_address_line4;
f.cont_address_line5;
f.cont_address_line6;
f.cont_address_effective_date;
f.cont_phone_number;
f.cont_phone_number_type_cd;
f.cont_phone_number_type_desc;
f.cont_email_address;
f.cont_web_address;
f.cont_title;
f.cont_fname;
f.cont_mname;
f.cont_lname;
f.cont_name_suffix;
f.cont_score;
f.corp_addr1_zip5;
f.corp_addr1_err_stat;
f.cont_zip5;
f.cont_err_stat;
f.corp_phone10;
f.cont_phone10;
f.record_type;
f.address_ind;
end;

fslim := table(f, layout_corp_slim);

layout_corp_stat := record
fslim.corp_state_origin;
integer4 total:= count(group);

// BDID and DID counts
integer4 bdid_count := count(group, fslim.bdid <> '');
integer4 did_count := count(group, fslim.did <> '');

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
integer4 corp_phone_number_cnt := count(group, fslim.corp_phone_number <> '');
integer4 corp_phone_number_type_cd_cnt := count(group, fslim.corp_phone_number_type_cd <> '');
integer4 corp_phone_number_type_desc_cnt := count(group, fslim.corp_phone_number_type_desc <> '');
integer4 corp_email_address_cnt := count(group, fslim.corp_email_address <> '');
integer4 corp_web_address_cnt := count(group, fslim.corp_web_address <> '');
integer4 cont_filing_reference_nbr_cnt := count(group, fslim.cont_filing_reference_nbr <> '');
integer4 cont_filing_date_cnt := count(group, fslim.cont_filing_date <> '');
integer4 cont_filing_cd_cnt := count(group, fslim.cont_filing_cd <> '');
integer4 cont_filing_desc_cnt := count(group, fslim.cont_filing_desc <> '');
integer4 cont_type_cd_cnt := count(group, fslim.cont_type_cd <> '');
integer4 cont_type_desc_cnt := count(group, fslim.cont_type_desc <> '');
integer4 cont_name_cnt := count(group, fslim.cont_name <> '');
integer4 cont_title1_desc_cnt := count(group, fslim.cont_title1_desc <> '');
integer4 cont_title2_desc_cnt := count(group, fslim.cont_title2_desc <> '');
integer4 cont_title3_desc_cnt := count(group, fslim.cont_title3_desc <> '');
integer4 cont_title4_desc_cnt := count(group, fslim.cont_title4_desc <> '');
integer4 cont_title5_desc_cnt := count(group, fslim.cont_title5_desc <> '');
integer4 cont_fein_cnt := count(group, fslim.cont_fein <> '');
integer4 cont_ssn_cnt := count(group, fslim.cont_ssn <> '');
integer4 cont_dob_cnt := count(group, fslim.cont_dob <> '');
integer4 cont_effective_date_cnt := count(group, fslim.cont_effective_date <> '');
integer4 cont_address_type_cd_cnt := count(group, fslim.cont_address_type_cd <> '');
integer4 cont_address_type_desc_cnt := count(group, fslim.cont_address_type_desc <> '');
integer4 cont_address_line1_cnt := count(group, fslim.cont_address_line1 <> '');
integer4 cont_address_line2_cnt := count(group, fslim.cont_address_line2 <> '');
integer4 cont_address_line3_cnt := count(group, fslim.cont_address_line3 <> '');
integer4 cont_address_line4_cnt := count(group, fslim.cont_address_line4 <> '');
integer4 cont_address_line5_cnt := count(group, fslim.cont_address_line5 <> '');
integer4 cont_address_line6_cnt := count(group, fslim.cont_address_line6 <> '');
integer4 cont_address_effective_date_cnt := count(group, fslim.cont_address_effective_date <> '');
integer4 cont_phone_number_cnt := count(group, fslim.cont_phone_number <> '');
integer4 cont_phone_number_type_cd_cnt := count(group, fslim.cont_phone_number_type_cd <> '');
integer4 cont_phone_number_type_desc_cnt := count(group, fslim.cont_phone_number_type_desc <> '');
integer4 cont_email_address_cnt := count(group, fslim.cont_email_address <> '');
integer4 cont_web_address_cnt := count(group, fslim.cont_web_address <> '');
integer4 cont_title_cnt := count(group, fslim.cont_title<> '');
integer4 cont_fname_cnt := count(group, fslim.cont_fname <> '');
integer4 cont_mname_cnt := count(group, fslim.cont_mname <> '');
integer4 cont_lname_cnt := count(group, fslim.cont_lname <> '');
integer4 cont_name_suffix_cnt := count(group, fslim.cont_name_suffix <> '');
integer4 cont_score_cnt := count(group, fslim.cont_score <> '');

// clean corp zip stats
integer4 corp_addr1_zip5_cnt := count(group, (integer)fslim.corp_addr1_zip5 <> 0);

// clean corp address error stats
integer4 corp_addr1_err_stat_S := count(group, fslim.corp_addr1_err_stat[1] = 'S');
integer4 corp_addr1_err_stat_E := count(group, fslim.corp_addr1_err_stat[1] = 'E');
integer4 corp_addr1_err_stat_U := count(group, fslim.corp_addr1_err_stat[1] = 'U');
integer4 corp_addr1_err_stat_other := count(group, fslim.corp_addr1_err_stat[1] not in ['S','E','U']);

// clean cont zip stats
integer4 cont_zip5_cnt := count(group, (integer)fslim.cont_zip5 <> 0);

// clean cont address error stats
integer4 cont_err_stat_S := count(group, fslim.cont_err_stat[1] = 'S');
integer4 cont_err_stat_E := count(group, fslim.cont_err_stat[1] = 'E');
integer4 cont_err_stat_U := count(group, fslim.cont_err_stat[1] = 'U');
integer4 cont_err_stat_other := count(group, fslim.cont_err_stat[1] not in ['S','E','U']);

// Clean Phone Numbers
integer4 corp_phone10_cnt := count(group, (integer)fslim.corp_phone10 <> 0);
integer4 cont_phone10_cnt := count(group, (integer)fslim.cont_phone10 <> 0);

// Record Type
integer4  record_type_C := count(group, fslim.record_type='C');
integer4  record_type_H := count(group,fslim.record_type='H');

//Address Indicator
integer4  address_ind_C := count(group, fslim.address_ind='C');
integer4  address_ind_blank := count(group, fslim.address_ind=' ');
end;

fstat := table(fslim, layout_corp_stat, corp_state_origin, few);

output(fstat);