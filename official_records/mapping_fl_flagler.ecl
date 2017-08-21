import lib_StringLib;
export mapping_fl_flagler(string filedate) := function

official_records.Layout_In_preclean_document map2flgdoc(File_In_FL_Flagler l ) := transform
 self.process_date                                 := filedate;
  self.vendor                                      := '08';
  self.state_origin                                := 'FL';
  self.county_name                                 := 'FLAGLER';
  self.official_record_key                         := '08' + trim(l.instrumentNumber,left,right);
  self.fips_st                                     := '12';
  self.fips_county                                 := '035';
  self.doc_instrument_or_clerk_filing_num          := trim(l.InstrumentNumber,left,right);
  self.doc_type_cd                                 := l.UnmappedDocType;
  self.doc_type_desc                               := trim(l.DocTypeDescription,left,right);
  self.legal_desc_1                                := trim(l.LegalDescription[1..60],left,right);
  self.book_type_cd                                := l.BookType[1..5];
  self.book_type_desc                              := regexreplace('OR',l.BookType, 'Official Record');
  self.book_num                                    := l.Book;
  self.page_num                                    := l.Page;
  self.doc_page_count                              := l.NumberPages;
  self.doc_filed_dt                                := fSlashedMDYtoYMD(l.FileDate);
  self.doc_record_dt                               := fSlashedMDYtoYMD(l.FileDate);
  self.prior_doc_file_num                          := l.PriorInstrumentNumber;
  self.prior_book_num                              := l.PriorBook;
  self.prior_page_num                              := l.PriorPage;
  self.prior_book_type_cd                          := l.PriorBookType;
  self.prior_book_type_desc                        := regexreplace('OR',l.PriorBookType, 'Official Record');
  self.prior_doc_type_cd                           := l.PriorUnmappedDocType[1..5];
  self.prior_doc_type_desc                         := get_fl_flagler( l.PriorUnmappedDocType );
self := l;
end;
File_flagler_document := project(File_In_FL_Flagler,map2flgdoc(LEFT));


sort_flagler_document := sort(File_flagler_document,record);

dedp_flagler_document := dedup(sort_flagler_document,all);


official_records.Layout_In_preclean_party map2flgpty(File_In_FL_Flagler l) := transform
 self.process_date                            := filedate;
  self.vendor                                 := '08';
  self.state_origin                           := 'FL';
  self.county_name                            := 'FLAGLER';
  self.official_record_key                    := '08' + trim(l.InstrumentNumber,left,right);
  self.doc_instrument_or_clerk_filing_num     := trim(l.InstrumentNumber,left,right);
  self.doc_filed_dt                           := fSlashedMDYtoYMD(l.FileDate);
  self.doc_type_desc                          := trim(l.DocTypeDescription,left,right);
  self.entity_sequence                        := l.EntitySequence;
  self.entity_type_cd                         := l.EntityTypeCode;
  self.entity_type_desc                       := map (trim(l.EntityTypeCode) = 'TO' => 'TO',
                                                      trim(l.EntityTypeCode) = 'FRM' => 'FROM','');

  self.entity_nm                              := l.EntityNm;
  self.entity_nm_format                       := 'L';
  self                                        := l;
  end;
  
  File_flagler_party := project(File_In_FL_Flagler(EntityNm <> ''),map2flgpty(LEFT));
  
  sort_flagler_party := sort(File_flagler_party,record);
  dedp_flagler_party := dedup(sort_flagler_party,all);
official_records.MAC_Name_Clean(dedp_flagler_document,dedp_flagler_party,'fl','flagler',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl flagler done '+official_records.Version_Development , 
						'Official Records mapping fl flagler completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl flagler failed '+official_records.Version_Development , 
						'Official Records mapping fl flagler failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_flagler := sequential(out) : success(succmail),failure(fmail);

return out_flagler;
end;