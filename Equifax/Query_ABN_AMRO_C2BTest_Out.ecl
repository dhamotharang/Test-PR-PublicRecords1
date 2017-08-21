import ut;

abn_amro_base := dataset('~thor_data400::TMTEST::abn_amro_c2btest_data_append', Equifax.Layout_ABN_AMRO_C2BTest_Base, flat, __compressed__);

Equifax.Layout_ABN_AMRO_C2BTest_Out FormatOutput(abn_amro_base l) := transform
self.contact_title_rank := ut.TitleRank(l.contact_title);
self.contact_is_business_owner := if(self.contact_title_rank = 1, 'Y', 'N');
self := l;
end;

abn_amro_out_init := project(abn_amro_base, FormatOutput(left));
abn_amro_out_sort := sort(abn_amro_out_init, seq, confidence_level, group_id, bdid);

count(abn_amro_out_sort);

// Sample output data
output(choosen(abn_amro_out_sort, 5000),all);

// Output file for transfer
output(abn_amro_out_sort,,'TMTEST::ABN_AMRO_C2BTest_Out_CSV',csv(
heading(
'seq,did,DESCRIPTION1,HOUSEHOLD_KEY,INDIVIDUAL_KEY,NAME_FULL,MAILING_ADDRESS_1,MAILING_ADDRESS_2,' +
'MAILING_CITY,MAILING_STATE,MAILING_ZIP_CODE,PHONE,bdid,group_id,confidence_level,best_CompanyName,' +
'best_addr1,best_city,best_state,best_zip,best_zip4,best_phone,best_fein,contact_title,contact_title_rank,' +
'contact_fname,contact_mname,contact_lname,contact_name_suffix,contact_is_business_owner,' +
'SIC_Code1,SIC_Code2,SIC_Code3,Number_Of_Employees,Annual_Sales\n'),
separator(','),
terminator('\n'),
quote('"')));
