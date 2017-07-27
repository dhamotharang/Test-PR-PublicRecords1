import Business_Header;

#workunit('name', 'Corporate Contact Stats ' + corp.Corp_Build_Date);

f := Corp.File_Corp_Cont_Base;

layout_corp_slim := record
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
f.cont_title1;
f.cont_fname1;
f.cont_mname1;
f.cont_lname1;
f.cont_name_suffix1;
f.cont_score1;
f.cont_title2;
f.cont_fname2;
f.cont_mname2;
f.cont_lname2;
f.cont_name_suffix2;
f.cont_score2;
f.cont_title3;
f.cont_fname3;
f.cont_mname3;
f.cont_lname3;
f.cont_name_suffix3;
f.cont_score3;
f.cont_title4;
f.cont_fname4;
f.cont_mname4;
f.cont_lname4;
f.cont_name_suffix4;
f.cont_score4;
f.cont_title5;
f.cont_fname5;
f.cont_mname5;
f.cont_lname5;
f.cont_name_suffix5;
f.cont_score5;
f.cont_cname1;
f.cont_cname1_score;
f.cont_cname2;
f.cont_cname2_score;
f.corp_addr1_zip5;
f.corp_addr1_err_stat;
f.cont_zip5;
f.cont_err_stat;
f.corp_phone10;
f.cont_phone10;
f.record_type;
end;

fslim := table(f, layout_corp_slim);

layout_corp_stat := record
fslim.corp_state_origin;
integer4 total:= count(group);

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
integer4 cont_title1_cnt := count(group, fslim.cont_title1 <> '');
integer4 cont_fname1_cnt := count(group, fslim.cont_fname1 <> '');
integer4 cont_mname1_cnt := count(group, fslim.cont_mname1 <> '');
integer4 cont_lname1_cnt := count(group, fslim.cont_lname1 <> '');
integer4 cont_name_suffix1_cnt := count(group, fslim.cont_name_suffix1 <> '');
integer4 cont_score1_cnt := count(group, fslim.cont_score1 <> '');
integer4 cont_title2_cnt := count(group, fslim.cont_title2 <> '');
integer4 cont_fname2_cnt := count(group, fslim.cont_fname2 <> '');
integer4 cont_mname2_cnt := count(group, fslim.cont_mname2 <> '');
integer4 cont_lname2_cnt := count(group, fslim.cont_lname2 <> '');
integer4 cont_name_suffix2_cnt := count(group, fslim.cont_name_suffix2 <> '');
integer4 cont_score2_cnt := count(group, fslim.cont_score2 <> '');
integer4 cont_title3_cnt := count(group, fslim.cont_title3 <> '');
integer4 cont_fname3_cnt := count(group, fslim.cont_fname3 <> '');
integer4 cont_mname3_cnt := count(group, fslim.cont_mname3 <> '');
integer4 cont_lname3_cnt := count(group, fslim.cont_lname3 <> '');
integer4 cont_name_suffix3_cnt := count(group, fslim.cont_name_suffix3 <> '');
integer4 cont_score3_cnt := count(group, fslim.cont_score3 <> '');
integer4 cont_title4_cnt := count(group, fslim.cont_title4 <> '');
integer4 cont_fname4_cnt := count(group, fslim.cont_fname4 <> '');
integer4 cont_mname4_cnt := count(group, fslim.cont_mname4 <> '');
integer4 cont_lname4_cnt := count(group, fslim.cont_lname4 <> '');
integer4 cont_name_suffix4_cnt := count(group, fslim.cont_name_suffix4 <> '');
integer4 cont_score4_cnt := count(group, fslim.cont_score4 <> '');
integer4 cont_title5_cnt := count(group, fslim.cont_title5 <> '');
integer4 cont_fname5_cnt := count(group, fslim.cont_fname5 <> '');
integer4 cont_mname5_cnt := count(group, fslim.cont_mname5 <> '');
integer4 cont_lname5_cnt := count(group, fslim.cont_lname5 <> '');
integer4 cont_name_suffix5_cnt := count(group, fslim.cont_name_suffix5 <> '');
integer4 cont_score5_cnt := count(group, fslim.cont_score5 <> '');
integer4 cont_cname1_cnt := count(group, fslim.cont_cname1 <> '');
integer4 cont_cname1_score_cnt := count(group, fslim.cont_cname1_score <> '');
integer4 cont_cname2_cnt := count(group, fslim.cont_cname2 <> '');
integer4 cont_cname2_score_cnt := count(group, fslim.cont_cname2_score <> '');

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
end;

fstat := table(fslim, layout_corp_stat, corp_state_origin, few);

output(fstat);