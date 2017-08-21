import doxie;

document_base := official_records.File_Base_Document(official_record_key != '');

export Key_Document_ORID := index(document_base,
                                  {official_record_key},
							                    {state_origin,county_name,
																	 doc_instrument_or_clerk_filing_num,doc_filed_dt,
																	 doc_type_desc,legal_desc_1,doc_page_count,
																	 doc_amend_desc,execution_dt,consideration_amt,
																	 transfer_,mortgage,intangible_tax_amt,
																	 book_num,page_num,book_type_desc,
																	 prior_doc_file_num,prior_doc_type_desc,
									                 prior_book_num,prior_page_num,prior_book_type_desc},
 					     '~thor_200::key::official_records_document_orid_' + doxie.Version_SuperKey);
// For testing on dataland, comment out the line above and uncomment the line below.
// Make the same change to: Constants, Key_Party_ORID and Key_Official_Record_Payload.
// 					     '~thor_data400::key::official_records_document_orid_' + doxie.Version_SuperKey);
