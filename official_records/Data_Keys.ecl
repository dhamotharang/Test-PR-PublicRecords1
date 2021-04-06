IMPORT dx_Official_Records,Official_Records;

EXPORT Data_Keys(BOOLEAN IsDelta = FALSE) := MODULE

//delta updates by comparing base file vs. previous base version
	
SHARED party_base      := official_records.File_Base_Party;
SHARED party_base_prev  := official_records.File_Base_Party_Prev;

//slim party file matching key layout																	 
slim_party := project(party_base(official_record_key != ''), dx_Official_Records.layouts.Party);
dedup_party := dedup(sort(distribute(slim_party,hash(official_record_key)),record,local),record,local);
																 																 
slim_party_prev := project(party_base_prev(official_record_key != ''), dx_Official_Records.layouts.Party);
dedup_party_prev := dedup(sort(distribute(slim_party_prev,hash(official_record_key)),record,local),record,local);

party_increment := join(dedup_party,dedup_party_prev,
left.official_record_key = right.official_record_key and 
left.state_origin = right.state_origin and
left.county_name = right.county_name and
left.doc_filed_dt = right.doc_filed_dt and
left.doc_type_desc = right.doc_type_desc and
left.entity_type_desc = right.entity_type_desc and
left.entity_nm = right.entity_nm and
left.title1 = right.title1 and
left.fname1 = right.fname1 and
left.mname1 = right.mname1 and
left.lname1 = right.lname1 and
left.suffix1 = right.suffix1 and
left.cname1 = right.cname1 and
left.master_party_type_cd = right.master_party_type_cd,
transform(dx_Official_Records.layouts.Party, self := left),left only, local);	

EXPORT i_party := if(~isDelta, dedup_party, party_increment);

document_base      := official_records.File_Base_document(official_record_key != '');
document_base_prev := official_records.File_Base_Document_Prev(official_record_key != '');

//slim document file matching key layout																	 
																	 
slim_document := project(document_base, dx_Official_Records.layouts.document);
dedup_document := dedup(sort(distribute(slim_document,hash(official_record_key)),record,local),record,local);	
																 																 
slim_document_prev := project(document_base_prev, dx_Official_Records.layouts.document);
dedup_document_prev := dedup(sort(distribute(slim_document_prev,hash(official_record_key)),record,local),record,local);

document_increment := join(dedup_document,dedup_document_prev,
left.official_record_key = right.official_record_key and 
left.state_origin = right.state_origin and
left.county_name = right.county_name and
left.doc_instrument_or_clerk_filing_num = right.doc_instrument_or_clerk_filing_num and
left.doc_filed_dt = right.doc_filed_dt and
left.doc_type_desc = right.doc_type_desc and
left.legal_desc_1 = right.legal_desc_1 and
left.doc_page_count = right.doc_page_count and
left.doc_amend_desc = right.doc_amend_desc and
left.execution_dt = right.execution_dt and
left.consideration_amt = right.consideration_amt and
left.transfer_ = right.transfer_ and
left.mortgage = right.mortgage and
left.intangible_tax_amt = right.intangible_tax_amt and
left.book_num = right.book_num and
left.page_num = right.page_num and
left.book_type_desc = right.book_type_desc and
left.prior_doc_file_num = right.prior_doc_file_num and
left.prior_doc_type_desc = right.prior_doc_type_desc and
left.prior_book_num = right.prior_book_num and
left.prior_page_num = right.prior_page_num and
left.prior_book_type_desc = right.prior_book_type_desc,
transform(dx_Official_Records.layouts.document, self := left),left only, local);	

EXPORT i_document := if(~isDelta, dedup_document, document_increment);

EXPORT i_autokey_party := if(~isDelta, official_records.File_Autokey_Party, official_records.File_Autokey_Party_Delta);

END;


