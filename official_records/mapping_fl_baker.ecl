import lib_StringLib;
export mapping_fl_baker(string filedate) := function


official_records.Layout_In_preclean_document map2bakerdoc(File_In_FL_Baker l) := transform
 self.process_date                            := filedate;
  self.vendor                                 := '12';
  self.state_origin                           := 'FL';
  self.county_name                            := 'BAKER';
  self.official_record_key                    := '12' + trim(l.InstrumentNumber,left,right);
  self.fips_st                                := '12';
  self.fips_county                            := '003';
  self.doc_instrument_or_clerk_filing_num     := trim(l.InstrumentNumber,left,right);
  self.doc_type_cd                            := l.UnmappedDocType;
  self.doc_type_desc                          := l.DocTypeDescription;
  self.legal_desc_1                           := l.LegalDescription[1..60];
  self.book_type_cd                           := l.BookType[1..5];
  self.book_type_desc                         := regexreplace('OR',l.BookType, 'Official Record');
  
  self.doc_filed_dt                           := fSlashedMDYtoYMD(l.FileDate);
  self.doc_record_dt                          := fSlashedMDYtoYMD(l.FileDate);
  self.book_num                               := trim(l.Book);
  self.page_num                               := trim(l.Page);
  self.doc_page_count                         := trim(l.NumberPages);
  self.prior_doc_file_num                     := trim(l.PriorInstrumentNumber);
  self.prior_book_num                         := trim(l.PriorBook);
  self.prior_page_num                         := trim(l.PriorPage);
  self.prior_book_type_cd                     := trim(l.PriorBookType);
  self.prior_book_type_desc                   := regexreplace('OR',l.PriorBookType, 'Official Record');
 self.prior_doc_type_cd                       :=  l.PriorUnmappedDocType[1..5];
  self.prior_doc_type_desc                    := get_fl_baker ( l.PriorUnmappedDocType ) ;

self := l;
end;
File_baker_document := project(File_In_FL_Baker,map2bakerdoc(LEFT));
 

sort_baker_document := sort(File_baker_document,record);

dedp_baker_document := dedup(sort_baker_document,all);

 File_In_Baker_filter := File_In_FL_Baker(entitynm <> '');


official_records.Layout_In_preclean_party map2bakerpty(File_In_Baker_filter l) := transform
 self.process_date                  := filedate;
  self.vendor                       := '12';
  self.state_origin                 := 'FL';
  self.county_name                  := 'BAKER';
  self.official_record_key          := '12' + trim(l.InstrumentNumber,left,right);
  self.doc_instrument_or_clerk_filing_num := trim(l.InstrumentNumber);
  self.doc_filed_dt                 := fSlashedMDYtoYMD(l.FileDate);
  self.doc_type_desc                := l.DocTypeDescription;
  self.entity_sequence              := l.EntitySequence;
  self.entity_type_cd               := l.EntityTypeCode;
  self.entity_type_desc             := map (trim(l.EntityTypeCode) = 'TO' => 'TO',
                                            trim(l.EntityTypeCode) = 'FRM' => 'FROM','');

  self.entity_nm                    := l.EntityNm[1..80];
  self.entity_nm_format             := 'L';
  self                              := l;
  end;
  
  File_baker_party := project(File_In_Baker_filter,map2bakerpty(LEFT));
  
  sort_baker_party := sort(File_baker_party,record);
  dedp_baker_party := dedup(sort_baker_party,all);
official_records.MAC_Name_Clean(dedp_baker_document,dedp_baker_party,'fl','baker',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl baker done '+official_records.Version_Development , 
						'Official Records mapping fl baker completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl baker failed '+official_records.Version_Development , 
						'Official Records mapping fl baker failed. Please view  WU-ID: ' + Thorlib.WUID( ));						
out_baker := sequential(out) : success(succmail),failure(fmail);



return out_baker;
end;
