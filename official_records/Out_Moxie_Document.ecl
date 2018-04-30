﻿Official_Records.Layout_Moxie_Document tDocumentInToOut(Official_Records.Layout_In_Document pInput)
 :=
  transform
	self			:= pInput;
  end
 ;

dInAsOut		:= project(Official_Records.File_In_Document,tDocumentInToOut(left));
dInAsOutDist	:= distribute(dInAsOut,hash(vendor,state_origin,county_name,official_record_key));
dInAsOutSorted	:= sort(dInAsOutDist,vendor,state_origin,county_name,official_record_key,fips_st,fips_county,batch_id,doc_serial_num,doc_instrument_or_clerk_filing_num,doc_num_dummy_flag,doc_filed_dt,doc_record_dt,doc_type_cd,doc_type_desc,doc_other_desc,doc_page_count,doc_names_count,doc_status_cd,doc_status_desc,doc_amend_cd,doc_amend_desc,execution_dt,consideration_amt,assumption_amt,certified_mail_fee,service_charge,trust_amt,transfer_,mortgage,intangible_tax_amt,intangible_tax_penalty,excise_tax_amt,recording_fee,documentary_stamps_fee,doc_stamps_mtg_fee,book_num,page_num,book_type_cd,book_type_desc,parcel_or_case_num,formatted_parcel_num,legal_desc_1,legal_desc_2,legal_desc_3,legal_desc_4,legal_desc_5,verified_flag,address_1,address_2,address_3,address_4,prior_doc_file_num,prior_doc_type_cd,prior_doc_type_desc,prior_book_num,prior_page_num,prior_book_type_cd,prior_book_type_desc,process_date,local);
dInAsOutDeduped := dedup(dInAsOutSorted,vendor,state_origin,county_name,official_record_key,fips_st,fips_county,batch_id,doc_serial_num,doc_instrument_or_clerk_filing_num,doc_num_dummy_flag,doc_filed_dt,doc_record_dt,doc_type_cd,doc_type_desc,doc_other_desc,doc_page_count,doc_names_count,doc_status_cd,doc_status_desc,doc_amend_cd,doc_amend_desc,execution_dt,consideration_amt,assumption_amt,certified_mail_fee,service_charge,trust_amt,transfer_,mortgage,intangible_tax_amt,intangible_tax_penalty,excise_tax_amt,recording_fee,documentary_stamps_fee,doc_stamps_mtg_fee,book_num,page_num,book_type_cd,book_type_desc,parcel_or_case_num,formatted_parcel_num,legal_desc_1,legal_desc_2,legal_desc_3,legal_desc_4,legal_desc_5,verified_flag,address_1,address_2,address_3,address_4,prior_doc_file_num,prior_doc_type_cd,prior_doc_type_desc,prior_book_num,prior_page_num,prior_book_type_cd,prior_book_type_desc,local);

export Out_Moxie_Document := output(dInAsOutDeduped,,Official_Records.Name_Moxie_Document_Dev,__compressed__,overwrite);