#workunit('name','Official Records Document Stats');

import official_records,Business_Header;

d1 := official_records.File_Moxie_Document_Dev(doc_filed_dt <> '');
 
Official_Records.Layout_Moxie_Document proj_rec(d1 l) := transform
 self.doc_filed_dt := Business_Header.validatedate(l.doc_filed_dt);
 self := l;
end;
 

d := project(d1,proj_rec(left));

stat_rec :=  record
'official_records_document',
d.vendor,
d.state_origin,
d.county_name,

process_dt := max(group,d.process_date);
start_date := min(group,d.doc_filed_dt);
end_date := max(group,d.doc_filed_dt );

total := count(group);
process_date_count := count(group, d.process_date <> '');
vendor_count := count(group, d.vendor <> '');
state_origin_count := count(group, d.state_origin <> '');
county_name_count := count(group, d.county_name <> '');
official_record_key_count := count(group, d.official_record_key <> '');
fips_st_count := count(group, d.fips_st <> '');
fips_county_count := count(group, d.fips_county <> '');
batch_id_count := count(group, d.batch_id <> '');
doc_serial_num_count := count(group, d.doc_serial_num <> '');
doc_instrument_or_clerk_filing_num_count := count(group, d.doc_instrument_or_clerk_filing_num <> '');
doc_num_dummy_flag_count := count(group, d.doc_num_dummy_flag <> '');
doc_record_dt_count := count(group, d.doc_record_dt <> '');
doc_type_cd_count := count(group, d.doc_type_cd <> '');
doc_type_desc_count := count(group, d.doc_type_desc <> '');
doc_other_desc_count := count(group, d.doc_other_desc <> '');
doc_page_count_count := count(group, d.doc_page_count <> '');
doc_names_count_count := count(group, d.doc_names_count <> '');
doc_status_cd_count := count(group, d.doc_status_cd <> '');
doc_status_desc_count := count(group, d.doc_status_desc <> '');
doc_amend_cd_count := count(group, d.doc_amend_cd <> '');
doc_amend_desc_count := count(group, d.doc_amend_desc <> '');
execution_dt_count := count(group, d.execution_dt <> '');
consideration_amt_count := count(group, d.consideration_amt <> '');
assumption_amt_count := count(group, d.assumption_amt <> '');
certified_mail_fee_count := count(group, d.certified_mail_fee <> '');
service_charge_count := count(group, d.service_charge <> '');
trust_amt_count := count(group, d.trust_amt <> '');
transfer__count := count(group, d.transfer_ <> '');
mortgage_count := count(group, d.mortgage <> '');
intangible_tax_amt_count := count(group, d.intangible_tax_amt <> '');
intangible_tax_penalty_count := count(group, d.intangible_tax_penalty <> '');
excise_tax_amt_count := count(group, d.excise_tax_amt <> '');
recording_fee_count := count(group, d.recording_fee <> '');
documentary_stamps_fee_count := count(group, d.documentary_stamps_fee <> '');
doc_stamps_mtg_fee_count := count(group, d.doc_stamps_mtg_fee <> '');
book_num_count := count(group, d.book_num <> '');
page_num_count := count(group, d.page_num <> '');
book_type_cd_count := count(group, d.book_type_cd <> '');
book_type_desc_count := count(group, d.book_type_desc <> '');
parcel_or_case_num_count := count(group, d.parcel_or_case_num <> '');
formatted_parcel_num_count := count(group, d.formatted_parcel_num <> '');
legal_desc_1_count := count(group, d.legal_desc_1 <> '');
legal_desc_2_count := count(group, d.legal_desc_2 <> '');
legal_desc_3_count := count(group, d.legal_desc_3 <> '');
legal_desc_4_count := count(group, d.legal_desc_4 <> '');
legal_desc_5_count := count(group, d.legal_desc_5 <> '');
verified_flag_count := count(group, d.verified_flag <> '');
address_1_count := count(group, d.address_1 <> '');
address_2_count := count(group, d.address_2 <> '');
address_3_count := count(group, d.address_3 <> '');
address_4_count := count(group, d.address_4 <> '');
prior_doc_file_num_count := count(group, d.prior_doc_file_num <> '');
prior_doc_type_cd_count := count(group, d.prior_doc_type_cd <> '');
prior_doc_type_desc_count := count(group, d.prior_doc_type_desc <> '');
prior_book_num_count := count(group, d.prior_book_num <> '');
prior_page_num_count := count(group, d.prior_page_num <> '');
prior_book_type_cd_count := count(group, d.prior_book_type_cd <> '');
prior_book_type_desc_count := count(group, d.prior_book_type_desc <> '');

doc_filed_dt_count := count(group, d.doc_filed_dt <> '');
doc_filed_dt_blank := count(group,d.doc_filed_dt='');
doc_filed_dt_less_than_1980 := count(group,d.doc_filed_dt<>'' and d.doc_filed_dt[1..3]<'198');
doc_filed_dt_1980_through_1989 := count(group,d.doc_filed_dt[1..3]='198');
doc_filed_dt_1990_through_1999 := count(group,d.doc_filed_dt[1..3]='199');
doc_filed_dt_2000 := count(group,d.doc_filed_dt[1..4]='2000');
doc_filed_dt_2001 := count(group,d.doc_filed_dt[1..4]='2001');
doc_filed_dt_2002 := count(group,d.doc_filed_dt[1..4]='2002');
doc_filed_dt_2003 := count(group,d.doc_filed_dt[1..4]='2003');
doc_filed_dt_2004 := count(group,d.doc_filed_dt[1..4]='2004');
doc_filed_dt_2005 := count(group,d.doc_filed_dt[1..4]='2005');
doc_filed_dt_200601 := count(group,d.doc_filed_dt[1..6]='200601');
doc_filed_dt_200602 := count(group,d.doc_filed_dt[1..6]='200602');
doc_filed_dt_200603 := count(group,d.doc_filed_dt[1..6]='200603');
doc_filed_dt_200604 := count(group,d.doc_filed_dt[1..6]='200604');
doc_filed_dt_200605 := count(group,d.doc_filed_dt[1..6]='200605');
doc_filed_dt_200606 := count(group,d.doc_filed_dt[1..6]='200606');
doc_filed_dt_200607 := count(group,d.doc_filed_dt[1..6]='200607');
doc_filed_dt_200608 := count(group,d.doc_filed_dt[1..6]='200608');
doc_filed_dt_200609 := count(group,d.doc_filed_dt[1..6]='200609');
doc_filed_dt_200610 := count(group,d.doc_filed_dt[1..6]='200610');
doc_filed_dt_200611 := count(group,d.doc_filed_dt[1..6]='200611');
doc_filed_dt_200612 := count(group,d.doc_filed_dt[1..6]='200612');
doc_filed_dt_greater_than_200612 := count(group,d.doc_filed_dt[1..6]>'200612');
end;




stats := table(d(doc_filed_dt <> ''),stat_rec,vendor,state_origin,county_name,few);



export official_records_document_stats := output(topn(stats,100,county_name));