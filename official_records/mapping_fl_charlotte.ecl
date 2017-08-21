export mapping_fl_charlotte(string filedate) := function

									
official_records.Layout_In_preclean_document map2chldoc(File_In_FL_Charlotte l) := transform
 self.process_date                                := filedate;
  self.vendor                                     := '13';
  self.state_origin                               := 'FL';
  self.county_name                                := 'CHARLOTTE';
  self.official_record_key                        := '13' + trim(l.InstrumentNumber);
  self.fips_st                                    := '12';
  self.fips_county                                := '015';
  self.doc_instrument_or_clerk_filing_num         := trim(l.InstrumentNumber);
  self.doc_type_cd                                := l.UnmappedDocType;
  self.doc_type_desc                              := l.DocTypeDescription;
  self.legal_desc_1                               := l.LegalDescription[1..60];
  self.book_type_cd                               := l.BookType[1..5];
  self.book_type_desc                             := map(trim(l.BookType) = 'L' =>  'Marriage License',
                                                         trim(l.BookType) = 'M' =>  'Marriage License',
							                                           trim(l.BookType) = 'O' =>  'Official Record','');
  self.doc_filed_dt                              := fSlashedMDYtoYMD(l.FileDate);
  self.doc_record_dt                             := fSlashedMDYtoYMD(l.FileDate);
  self.prior_doc_type_cd                         := l.PriorUnmappedDocType[1..5];
  self.prior_doc_type_desc                       := get_fl_charlotte ( l.PriorUnmappedDocType) ;
  self.book_num                                  := trim(l.Book);
  self.page_num                                  := trim(l.Page);
  self.doc_page_count                            := trim(l.NumberPages);
  self.prior_doc_file_num                        := trim(l.PriorInstrumentNumber);
  self.prior_book_num                            := trim(l.PriorBook);
  self.prior_page_num                            := trim(l.PriorPage);
  self.prior_book_type_cd                        := trim(l.PriorBookType);
  self.prior_book_type_desc                      := map(trim(l.PriorBookType) = 'L' =>  'Marriage License',
                                                        trim(l.PriorBookType) = 'M' =>  'Marriage License',
							                                          trim(l.PriorBookType) = 'O' =>  'Official Record','');
self := l;
end;
File_charlotte_document := project(File_In_FL_Charlotte,map2chldoc(LEFT));


sort_charlotte_document := sort(File_charlotte_document,record);

dedp_charlotte_document := dedup(sort_charlotte_document,all);



official_records.Layout_In_preclean_party map2chpty(File_In_FL_Charlotte l) := transform
 self.process_date                            := filedate;
  self.vendor                                 := '13';
  self.state_origin                           := 'FL';
  self.county_name                            := 'CHARLOTTE';
  self.official_record_key                    := '13' + trim(l.InstrumentNumber);
  self.doc_instrument_or_clerk_filing_num     := trim(l.InstrumentNumber);
  self.doc_filed_dt                           := fSlashedMDYtoYMD(l.FileDate);
  self.doc_type_desc                          := l.DocTypeDescription;
  self.entity_sequence                        := l.EntitySequence;
  self.entity_type_cd                         := l.EntityTypeCode;
  self.entity_type_desc                       := map (trim(l.EntityTypeCode) = 'TO' => 'TO',
                                                      trim(l.EntityTypeCode) = 'FRM' => 'FROM','');

  self.entity_nm                              := l.EntityNm;
  self.entity_nm_format                       := 'L';
  self                                        := l;
  end;
  
  File_charlotte_party := project(File_In_FL_Charlotte,map2chpty(LEFT));
  
  sort_charlotte_party := sort(File_charlotte_party,record);
  dedp_charlotte_party := dedup(sort_charlotte_party,all);
official_records.MAC_Name_Clean(dedp_charlotte_document,dedp_charlotte_party,'fl','charlotte',filedate,out);


succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl charlotte done '+official_records.Version_Development , 
						'Official Records mapping fl charlotte completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl charlotte failed '+official_records.Version_Development , 
						'Official Records mapping fl charlotte failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_charlotte := sequential(out) : success(succmail),failure(fmail);


return out_charlotte;
end;