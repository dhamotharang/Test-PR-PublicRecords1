import lib_StringLib;
export mapping_fl_brevard(string filedate) := function

official_records.Layout_In_preclean_document map2brevdoc(File_In_FL_Brevard l) := transform
 self.process_date                              := filedate;
  self.vendor                                   := '10';
  self.state_origin                             := 'FL';
  self.county_name                              := 'BREVARD';
  self.official_record_key                      := '10' + trim(l.InstrumentNumber);
  self.fips_st                                  := '12';
  self.fips_county                              := '009';
  self.doc_instrument_or_clerk_filing_num       := trim(l.InstrumentNumber);
  self.doc_type_cd                              := l.UnmappedDocType;
  self.doc_type_desc                            := l.DocTypeDescription;
  self.legal_desc_1                             := l.LegalDescription[1..60];
  self.book_type_cd                             := l.BookType[1..5];
  self.book_type_desc                           := map(trim(l.BookType) = 'L' =>  'Marriage License',
                                                       trim(l.BookType) = 'M' =>  'Marriage License',
							                                         trim(l.BookType) = 'O' =>  'Official Record','');
  self.doc_filed_dt                             := fSlashedMDYtoYMD(l.FileDate);
  self.doc_record_dt                            := fSlashedMDYtoYMD(l.FileDate);
  self.prior_doc_type_cd                        := l.PriorUnmappedDocType[1..5];
  self.prior_doc_type_desc                      := get_fl_brevard( l.PriorUnmappedDocType);
  self.book_num                                 := trim(l.Book);
  self.page_num                                 := trim(l.Page);
  self.doc_page_count                           := trim(l.NumberPages);
  self.prior_doc_file_num                       := trim(l.PriorInstrumentNumber);
  self.prior_book_num                           := trim(l.PriorBook);
  self.prior_page_num                           := trim(l.PriorPage);
  self.prior_book_type_cd                       := trim(l.PriorBookType);
  self.prior_book_type_desc                     := map(trim(l.PriorBookType) = 'L' =>  'Marriage License',
                                                      trim(l.PriorBookType) = 'M' =>  'Marriage License',
							                                        trim(l.PriorBookType) = 'O' =>  'Official Record','');
self := l;
end;

join_brevdoc := project(File_In_FL_Brevard,map2brevdoc(LEFT));

sort_brevard_document := sort(join_brevdoc,record);

dedp_brevard_document := dedup(sort_brevard_document,all);



official_records.Layout_In_preclean_party map2brevpty(File_In_FL_Brevard l) := transform
 self.process_date                        := filedate;
  self.vendor                             := '10';
  self.state_origin                       := 'FL';
  self.county_name                        := 'BREVARD';
  self.official_record_key                := '10' + trim(l.InstrumentNumber);
  self.doc_instrument_or_clerk_filing_num := trim(l.InstrumentNumber);
  self.doc_filed_dt                       := fSlashedMDYtoYMD(l.FileDate);
  self.doc_type_desc                      := l.DocTypeDescription;
  self.entity_sequence                    := l.EntitySequence;
  self.entity_type_cd                     := l.EntityTypeCode;
  self.entity_type_desc                   := map (trim(l.EntityTypeCode) = 'TO' => 'TO',
                                                   trim(l.EntityTypeCode) = 'FRM' => 'FROM','');

  self.entity_nm                          := l.EntityNm;
  self.entity_nm_format                   := 'L';
  self                                    := l;
  end;
  
  File_brevard_party := project(File_In_FL_Brevard,map2brevpty(LEFT));
  
  sort_brevard_party := sort(File_brevard_party,record);
  dedp_brevard_party := dedup(sort_brevard_party,all);
official_records.MAC_Name_Clean(dedp_brevard_document,dedp_brevard_party,'fl','brevard',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl brevard done '+official_records.Version_Development , 
						'Official Records mapping fl brevard completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl brevard failed '+official_records.Version_Development , 
						'Official Records mapping fl brevard failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_brevard := sequential(out) : success(succmail),failure(fmail);

return out_brevard;
end;