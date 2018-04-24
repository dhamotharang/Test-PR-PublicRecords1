import official_records, lib_keylib,lib_fileservices,ut;

// Party Full File

party_fullfile := dataset('~thor_200::base::official_records_party',Official_records.Layout_Moxie_Party,thor);

party_increment := dataset('~thor_200::in::official_records_party_'+official_records.Version_Development,official_records.Layout_Moxie_Party,thor);

concat_party_funnel := party_fullfile(~(state_origin = 'FL' and trim(county_name) = 'MIAMI-DADE')) + party_increment;

Official_records.Layout_Moxie_Party proj_party_rec(concat_party_funnel l) := transform
	self.county_name := if ( l.county_name = 'MIAMI DADE','MIAMI-DADE',l.county_name);
	self.fname1 := map(l.official_record_key = '043181420020501' and l.entity_nm = 'BROWN ARCH ALEXANDER' => 'ARCH',
	                 l.entity_nm = 'TOUCH OF CLASS LIMOUSINE' => '',
                    l.entity_nm = 'VOLUSIA MALL' => '',
					l.entity_nm = 'LAKE YALE BEND' => '',
					l.entity_nm = 'BREVARD ALZHEIMERS FDTN' => '',
					l.entity_nm = 'ORANGEWOOD PRESBYTERIAN CHURCH' => '',
					l.entity_nm = 'MARION SPRINGSCONDOMINIUM' => '',
					l.entity_nm = 'INDIAN RIVER SHORES TOWN OF' => '',
					l.entity_nm = 'AAA TIME SHARE RESALES' => '', l.fname1);
					
self.lname1 :=  map(l.official_record_key = '043181420020501' and l.entity_nm = 'BROWN ARCH ALEXANDER' => 'BROWN' ,
                    l.entity_nm = 'TOUCH OF CLASS LIMOUSINE' => '',
                    l.entity_nm = 'VOLUSIA MALL' => '',
					l.entity_nm = 'LAKE YALE BEND' => '',
					l.entity_nm = 'BREVARD ALZHEIMERS FDTN' => '',
					l.entity_nm = 'ORANGEWOOD PRESBYTERIAN CHURCH' => '',
					l.entity_nm = 'MARION SPRINGSCONDOMINIUM' => '',
					l.entity_nm = 'INDIAN RIVER SHORES TOWN OF' => '',
					l.entity_nm = 'AAA TIME SHARE RESALES' => '', l.lname1);
					
self.mname1 :=  map(l.official_record_key = '043181420020501' and l.entity_nm = 'BROWN ARCH ALEXANDER' => 'ALEXANDER', 
                    l.entity_nm = 'TOUCH OF CLASS LIMOUSINE' => '',
                    l.entity_nm = 'VOLUSIA MALL' => '',
					l.entity_nm = 'LAKE YALE BEND' => '',
					l.entity_nm = 'BREVARD ALZHEIMERS FDTN' => '',
					l.entity_nm = 'ORANGEWOOD PRESBYTERIAN CHURCH' => '',
					l.entity_nm = 'MARION SPRINGSCONDOMINIUM' => '',
					l.entity_nm = 'INDIAN RIVER SHORES TOWN OF' => '',
					l.entity_nm = 'AAA TIME SHARE RESALES' => '', l.mname1);
					

self.cname1 :=  map(l.official_record_key = '043181420020501' and l.entity_nm = 'BROWN ARCH ALEXANDER' => '',  
                    l.entity_nm = 'TOUCH OF CLASS LIMOUSINE' => 'TOUCH OF CLASS LIMOUSINE',
                    l.entity_nm = 'VOLUSIA MALL' => 'VOLUSIA MALL',
					l.entity_nm = 'LAKE YALE BEND' => 'LAKE YALE BEND',
					l.entity_nm = 'BREVARD ALZHEIMERS FDTN' => 'BREVARD ALZHEIMERS FDTN',
					l.entity_nm = 'ORANGEWOOD PRESBYTERIAN CHURCH' => 'ORANGEWOOD PRESBYTERIAN CHURCH',
					l.entity_nm = 'MARION SPRINGSCONDOMINIUM' => 'MARION SPRINGSCONDOMINIUM',
					l.entity_nm = 'INDIAN RIVER SHORES TOWN OF' => 'INDIAN RIVER SHORES TOWN OF',
					l.entity_nm = 'AAA TIME SHARE RESALES' => 'AAA TIME SHARE RESALES', l.cname1);
					
self.title1 :=  map(
                    l.entity_nm = 'TOUCH OF CLASS LIMOUSINE' => '',
                    l.entity_nm = 'VOLUSIA MALL' => '',
					l.entity_nm = 'LAKE YALE BEND' => '',
					l.entity_nm = 'BREVARD ALZHEIMERS FDTN' => '',
					l.entity_nm = 'ORANGEWOOD PRESBYTERIAN CHURCH' => '',
					l.entity_nm = 'MARION SPRINGSCONDOMINIUM' => '',
					l.entity_nm = 'INDIAN RIVER SHORES TOWN OF' => '',
					l.entity_nm = 'AAA TIME SHARE RESALES' => '', l.title1);
					

	
	self := l;
end;

concat_party := project(concat_party_funnel,proj_party_rec(left));

sort_party := sort(concat_party,vendor,
state_origin,
county_name,
official_record_key,
doc_instrument_or_clerk_filing_num,
doc_filed_dt,
doc_type_desc,
entity_sequence,
entity_type_cd,
entity_type_desc,
entity_nm,
entity_nm_format,
entity_dob,
entity_ssn,
title1,
fname1,
mname1,
lname1,
suffix1,
pname1_score,
cname1,
title2,
fname2,
mname2,
lname2,
suffix2,
pname2_score,
cname2,
title3,
fname3,
mname3,
lname3,
suffix3,
pname3_score,
cname3,
title4,
fname4,
mname4,
lname4,
suffix4,
pname4_score,
cname4,
title5,
fname5,
mname5,
lname5,
suffix5,
pname5_score,
cname5,
master_party_type_cd,-process_date);

dedup_concat_party := dedup(sort_party,vendor,
state_origin,
county_name,
official_record_key,
doc_instrument_or_clerk_filing_num,
doc_filed_dt,
doc_type_desc,
entity_sequence,
entity_type_cd,
entity_type_desc,
entity_nm,
entity_nm_format,
entity_dob,
entity_ssn,
title1,
fname1,
mname1,
lname1,
suffix1,
pname1_score,
cname1,
title2,
fname2,
mname2,
lname2,
suffix2,
pname2_score,
cname2,
title3,
fname3,
mname3,
lname3,
suffix3,
pname3_score,
cname3,
title4,
fname4,
mname4,
lname4,
suffix4,
pname4_score,
cname4,
title5,
fname5,
mname5,
lname5,
suffix5,
pname5_score,
cname5,
master_party_type_cd);

output_party := output(dedup_concat_party(trim(entity_nm) <> 'ÿÿ'),,'~thor_200::in::official_records_party_full_'+official_records.Version_Development,__compressed__,overwrite);


// Document Full File

document_fullfile := dataset('~thor_200::base::official_records_document',Official_records.Layout_Moxie_document,thor);

document_increment := dataset('~thor_200::in::official_records_document_'+official_records.Version_Development,official_records.Layout_Moxie_document,thor);

concat_document_funnel := document_fullfile(~(state_origin = 'FL' and trim(county_name) = 'MIAMI-DADE')) + document_increment;


Official_records.Layout_Moxie_document proj_document_rec(concat_document_funnel l) := transform
self.county_name := if ( l.county_name = 'MIAMI DADE','MIAMI-DADE',l.county_name);
self.book_num := if(l.book_num = '0',' ',l.book_num);
self.page_num :=  if(l.page_num = '0',' ',l.page_num);
self.prior_doc_file_num := if(l.prior_doc_file_num = '0000000000','',l.prior_doc_file_num);
self.prior_book_num := if(l.prior_book_num = '0000000000','',l.prior_book_num);
self.prior_page_num := if(l.prior_page_num = '00000','',l.prior_page_num);
self.execution_dt := if(l.execution_dt = '00000000','',l.execution_dt);
self.doc_type_desc := if(l.doc_type_desc = 'DISSOULTION OF MARRIAGE','DISSOLUTION OF MARRIAGE',l.doc_type_desc);
self := l;
end;

	
concat_document := project(concat_document_funnel,proj_document_rec(left));

sort_document := sort(concat_document,vendor,
state_origin,
county_name,
official_record_key,
fips_st,
fips_county,
batch_id,
doc_serial_num,
doc_instrument_or_clerk_filing_num,
doc_num_dummy_flag,
doc_filed_dt,
doc_record_dt,
doc_type_cd,
doc_type_desc,
doc_other_desc,
doc_page_count,
doc_names_count,
doc_status_cd,
doc_status_desc,
doc_amend_cd,
doc_amend_desc,
execution_dt,
consideration_amt,
assumption_amt,
certified_mail_fee,
service_charge,
trust_amt,
transfer_,
mortgage,
intangible_tax_amt,
intangible_tax_penalty,
excise_tax_amt,
recording_fee,
documentary_stamps_fee,
doc_stamps_mtg_fee,
book_num,
page_num,
book_type_cd,
book_type_desc,
parcel_or_case_num,
formatted_parcel_num,
legal_desc_1,
legal_desc_2,
legal_desc_3,
legal_desc_4,
legal_desc_5,
verified_flag,
address_1,
address_2,
address_3,
address_4,
prior_doc_file_num,
prior_doc_type_cd,
prior_doc_type_desc,
prior_book_num,
prior_page_num,
prior_book_type_cd,
prior_book_type_desc,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip,
zip4,
cart,
cr_sort_sz,
lot,
lot_order,
dpbc,
chk_digit,
rec_type,
ace_fips_st,
ace_fips_county,
geo_lat,
geo_long,
msa,
geo_blk,
geo_match,
err_stat,-process_date);

dedup_concat_document := dedup(sort_document,vendor,
state_origin,
county_name,
official_record_key,
fips_st,
fips_county,
batch_id,
doc_serial_num,
doc_instrument_or_clerk_filing_num,
doc_num_dummy_flag,
doc_filed_dt,
doc_record_dt,
doc_type_cd,
doc_type_desc,
doc_other_desc,
doc_page_count,
doc_names_count,
doc_status_cd,
doc_status_desc,
doc_amend_cd,
doc_amend_desc,
execution_dt,
consideration_amt,
assumption_amt,
certified_mail_fee,
service_charge,
trust_amt,
transfer_,
mortgage,
intangible_tax_amt,
intangible_tax_penalty,
excise_tax_amt,
recording_fee,
documentary_stamps_fee,
doc_stamps_mtg_fee,
book_num,
page_num,
book_type_cd,
book_type_desc,
parcel_or_case_num,
formatted_parcel_num,
legal_desc_1,
legal_desc_2,
legal_desc_3,
legal_desc_4,
legal_desc_5,
verified_flag,
address_1,
address_2,
address_3,
address_4,
prior_doc_file_num,
prior_doc_type_cd,
prior_doc_type_desc,
prior_book_num,
prior_page_num,
prior_book_type_cd,
prior_book_type_desc,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip,
zip4,
cart,
cr_sort_sz,
lot,
lot_order,
dpbc,
chk_digit,
rec_type,
ace_fips_st,
ace_fips_county,
geo_lat,
geo_long,
msa,
geo_blk,
geo_match,
err_stat
);

output_document := output(dedup_concat_document,,'~thor_200::in::official_records_document_full_'+official_records.Version_Development,__compressed__,overwrite);

// Super File Transaction - Party

superfile_transaction_party := sequential(output_party,
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_200::base::official_records_party_delete','~thor_200::base::official_records_party_grandfather',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_party_grandfather'),
				FileServices.AddSuperFile('~thor_200::base::official_records_party_grandfather','~thor_200::base::official_records_party_father',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_party_father'),
				FileServices.AddSuperFile('~thor_200::base::official_records_party_father', '~thor_200::base::official_records_party',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_party'),
				FileServices.AddSuperFile('~thor_200::base::official_records_party', '~thor_200::in::official_records_party_full_'+official_records.Version_Development),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_200::base::official_records_party_delete',true));


			
				
// Super File Transaction - Document

superfile_transaction_document := sequential(output_document,
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_200::base::official_records_document_delete','~thor_200::base::official_records_document_grandfather',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_document_grandfather'),
				FileServices.AddSuperFile('~thor_200::base::official_records_document_grandfather','~thor_200::base::official_records_document_father',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_document_father'),
				FileServices.AddSuperFile('~thor_200::base::official_records_document_father', '~thor_200::base::official_records_document',, true),
				FileServices.ClearSuperFile('~thor_200::base::official_records_document'),
				FileServices.AddSuperFile('~thor_200::base::official_records_document', '~thor_200::in::official_records_document_full_'+official_records.Version_Development),
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile('~thor_200::base::official_records_document_delete',true));
				


export Moxie_Official_Records_Full_File := parallel(superfile_transaction_party,superfile_transaction_document);