import lib_stringlib;
export mapping_fl_miami_dade(string filedate) := function


Layout_miami_doc := record
official_records.Layout_In_preclean_document;
string13 key;
string1 transaction_type;
end;

Layout_miami_doc tr_doc_final(File_In_FL_MDade l) := transform
self.process_date                             := filedate;
  self.vendor                                 := '07';
  self.state_origin                           := 'FL';
  self.county_name                            := 'MIAMI DADE';
  self.official_record_key                    := '07' + trim(l.cfn_year,left,right) + trim(l.cfn_sequence_char,left,right) + trim(l.group_id,left,right) + trim(intformat((integer)l.recording_book,14,0),left,right) + trim(intformat((integer)l.recording_page,5,0),left,right);
  self.fips_st                                := '12';
  self.fips_county                            := '086';
  self.doc_instrument_or_clerk_filing_num     := l.cfn_sequence_char;
  self.batch_id                               := l.group_id;
  self.doc_filed_dt                           := l.recording_date[5..8] + l.recording_date[1..4];
  self.book_num                               := l.recording_book[5..14];
  self.page_num                               := l.recording_page;
  self.book_type_cd                           := l.book_type_character;
  self.book_type_desc                         := map (trim(l.book_type_character) = 'O' => 'Official Record',
                                                      trim(l.book_type_character) = 'P' => 'Plat Record','');
  self.doc_page_count                         := l.document_pages;
  self.doc_type_cd                            := trim(l.document_type)[1..5];
  self.doc_type_desc                          := l.document_type_description;
  self.execution_dt                           := if(lib_stringlib.stringlib.StringCleanSpaces(l.document_date[5..8] + l.document_date[1..4]) = '00000000','',lib_stringlib.stringlib.StringCleanSpaces(l.document_date[5..8] + l.document_date[1..4]));
  self.prior_doc_file_num                     := l.original_cfn_sequence;
  self.prior_book_num                         := l.original_recording_book[5..14];
  self.prior_page_num                         := l.original_recording_page;
  self.legal_desc_1                           := trim(l.legal_description)[1..60];
  self.parcel_or_case_num                     := trim(l.case_number)[1..lib_stringlib.stringlib.stringfind(l.case_number,' ',1)];
  self.consideration_amt                      := if(trim(((string)intformat((integer)lib_stringlib.stringlib.stringfilterout(trim(l.consideration_1,left,right),'.'),25,0)),left,right) = '0','',(string)intformat((integer)lib_stringlib.stringlib.stringfilterout(trim(l.consideration_1,left,right),'.'),25,0));
  self.intangible_tax_amt                     := (string)intformat((integer)lib_stringlib.stringlib.stringfilterout(trim(l.intangible,left,right),'.'), 28,0)[10..28];
  self.documentary_stamps_fee                 := (string)intformat((integer)lib_stringlib.stringlib.stringfilterout(trim(l.documentary_stamps,left,right),'.'), 28,0)[10..28];
  self.doc_record_dt                          := l.recording_date[5..8] + l.recording_date[1..4];
  self.key                                    := trim(intformat((integer)l.key,13,0));
  self.transaction_type                       := l.transaction_type;

end;


File_doc_miami := project(File_In_FL_MDade,tr_doc_final(LEFT));
sort_miami := sort(File_doc_miami,record);
dedp_doc_miami := dedup(sort_miami,all);

Layout_miami_party := record
official_records.Layout_In_preclean_Party;
string13 key;
string1 transaction_type;
end;
 
Layout_miami_party tr_miamiparty_final(File_In_FL_MDade l) := transform
  self.process_date                     := filedate;
  self.vendor                           := '07';
  self.state_origin                     := 'FL';
  self.county_name                      := 'MIAMI DADE';
  self.official_record_key              := '07' + trim(l.cfn_year,left,right) + trim(l.cfn_sequence_char,left,right) + trim(l.group_id,left,right) + trim(intformat((integer)l.recording_book,14,0),left,right) + trim(intformat((integer)l.recording_page,5,0),left,right);
  self.doc_instrument_or_clerk_filing_num := l.cfn_sequence_char;
  self.doc_filed_dt                     := l.recording_date[5..8] + l.recording_date[1..4];
  self.doc_type_desc                    := l.document_type_description;
  self.entity_nm                        := trim(l.first_party);
  self.entity_nm_format                 := 'L';
  self.entity_type_cd                   := l.first_party_code;
  self.entity_type_desc                 := map(l.first_party_code = 'D' => 'Direct',
                                               l.first_party_code = 'R' =>  'Reverse','');
  self.key                              := trim(intformat((integer)l.key,13,0));
  self.transaction_type                 := l.transaction_type;
   self.entity_sequence                 := trim(l.party_sequence);


end;
  
  File_party_miami := project(File_In_FL_MDade,tr_miamiparty_final(LEFT));
sort_party_miami := sort(File_party_miami,record);
dedp_miami_party := dedup(sort_party_miami,all);
  official_records.MAC_Miami_Name_Clean(dedp_doc_miami,dedp_miami_party,'fl','miami_dade',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl miami_dade done '+official_records.Version_Development , 
						'Official Records mapping fl miami_dade completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl miami_dade failed '+official_records.Version_Development , 
						'Official Records mapping fl miami_dade failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_miami_dade := sequential(out) : success(succmail),failure(fmail);

return out_miami_dade;
end;
