import Standard;

dInAsOutDist	:= distribute(Official_Records.File_In_Document,hash(vendor,state_origin,county_name,official_record_key));
dInAsOutSorted	:= sort(dInAsOutDist,vendor,state_origin,county_name,official_record_key,fips_st,fips_county,batch_id,doc_serial_num,doc_instrument_or_clerk_filing_num,doc_num_dummy_flag,doc_filed_dt,doc_record_dt,doc_type_cd,doc_type_desc,doc_other_desc,doc_page_count,doc_names_count,doc_status_cd,doc_status_desc,doc_amend_cd,doc_amend_desc,execution_dt,consideration_amt,assumption_amt,certified_mail_fee,service_charge,trust_amt,transfer_,mortgage,intangible_tax_amt,intangible_tax_penalty,excise_tax_amt,recording_fee,documentary_stamps_fee,doc_stamps_mtg_fee,book_num,page_num,book_type_cd,book_type_desc,parcel_or_case_num,formatted_parcel_num,legal_desc_1,legal_desc_2,legal_desc_3,legal_desc_4,legal_desc_5,verified_flag,address_1,address_2,address_3,address_4,prior_doc_file_num,prior_doc_type_cd,prior_doc_type_desc,prior_book_num,prior_page_num,prior_book_type_cd,prior_book_type_desc,process_date,local);
dInAsOutDeduped := dedup(dInAsOutSorted,vendor,state_origin,county_name,official_record_key,fips_st,fips_county,batch_id,doc_serial_num,doc_instrument_or_clerk_filing_num,doc_num_dummy_flag,doc_filed_dt,doc_record_dt,doc_type_cd,doc_type_desc,doc_other_desc,doc_page_count,doc_names_count,doc_status_cd,doc_status_desc,doc_amend_cd,doc_amend_desc,execution_dt,consideration_amt,assumption_amt,certified_mail_fee,service_charge,trust_amt,transfer_,mortgage,intangible_tax_amt,intangible_tax_penalty,excise_tax_amt,recording_fee,documentary_stamps_fee,doc_stamps_mtg_fee,book_num,page_num,book_type_cd,book_type_desc,parcel_or_case_num,formatted_parcel_num,legal_desc_1,legal_desc_2,legal_desc_3,legal_desc_4,legal_desc_5,verified_flag,address_1,address_2,address_3,address_4,prior_doc_file_num,prior_doc_type_cd,prior_doc_type_desc,prior_book_num,prior_page_num,prior_book_type_cd,prior_book_type_desc,local);

Standard.Official_Records_Document tDocumentInToRoxie(DInAsOutDeduped pInput)
 :=
  transform
    self.process_date		:= (INTEGER) pInput.process_date;
	self.county_name_origin	:= pInput.county_name;
	self.fips_st_origin		:=	pInput.fips_st;
	self.fips_county_origin	:= pInput.fips_county;
	self.doc_filed_date		:= (INTEGER) pInput.doc_filed_dt;
	self.doc_record_date 	:= (INTEGER) pInput.doc_record_dt;
	self.doc_type_code		:= pInput.doc_type_cd;
	self.doc_status_code 	:= pInput.doc_status_cd;
	self.doc_amend_code 	:= pInput.doc_amend_cd;
	self.execution_date		:= (INTEGER) pInput.execution_dt;
	self.consideration_amount := pInput.consideration_amt;
	self.assumption_amount 	:= pInput.assumption_amt;
	self.trust_amount		:= pInput.trust_amt;
	self.transfer_amount	:= pInput.transfer_;
	self.intangible_tax_amount	:= pInput.intangible_tax_amt;
	self.excise_tax_amount	:= pInput.excise_tax_amt;
	self.book_type_code		:= pInput.book_type_cd;
	self.address_line_1		:= pInput.address_1;
	self.address_line_2		:= pInput.address_2;
	self.address_line_3		:= pInput.address_3;
	self.address_line_4		:= pInput.address_4;
	self.prior_doc_type_code	:= pInput.prior_doc_type_cd;
	self.prior_book_type_code	:= pInput.prior_book_type_cd;
	self.prim_range := pinput.prim_range;
	self.predir := pinput.predir;
	self.prim_name := pinput.prim_name;
	self.addr_suffix := pinput.addr_suffix;
	self.postdir := pinput.postdir;
	self.unit_desig := pinput.unit_desig;
	self.sec_range := pinput.sec_range;
	self.v_city_name := pinput.v_city_name;
	self.st := pinput.st;
	self.zip5 := pinput.zip;
	self.zip4 := pinput.zip4;
	self.addr_rec_type := pinput.rec_type;
	self.fips_state := pinput.ace_fips_st;
	self.fips_county := pinput.ace_fips_county;
	self.geo_lat := pinput.geo_lat;
	self.geo_long := pinput.geo_long;
	self.cbsa := pinput.msa;
	self.geo_blk := pinput.geo_blk;
	self.geo_match := pinput.geo_match;
	self.err_stat := pinput.err_stat;
	//self.address := ROW({
		//		  pInput.prim_range, pInput.predir, pInput.prim_name, pInput.addr_suffix, pInput.postdir,
	      //           pInput.unit_desig, pInput.sec_range, pInput.v_city_name, pInput.st, 
			//	  pInput.zip, pInput.zip4, pInput.rec_type, pInput.ace_fips_st, 
				//  pInput.ace_fips_county, pInput.geo_lat, pInput.geo_long, 
				 // pInput.msa, pInput.geo_blk, pInput.geo_match, pInput.err_stat},Standard.Addr);
	self := pInput;
  end
 ;

dDocumentAsRoxie		:= project(DInAsOutDeduped,tDocumentInToRoxie(left));

export Out_Roxie_Document := output(dDocumentAsRoxie,,Official_Records.Name_Roxie_Document_Dev,__compressed__,overwrite);