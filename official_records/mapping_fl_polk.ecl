export mapping_fl_polk(string filedate) := function

									
official_records.Layout_In_preclean_document map2polkdoc(File_In_FL_Polk l) := transform
self.process_date                               := filedate;
  self.vendor                                   := '16';
  self.state_origin                             := 'FL';
  self.county_name                              := 'POLK';
  self.official_record_key                      := '16' + trim(l.doc_instrument_or_clerk_filing_num,left,right);
  self.fips_st                                  := '12';
  self.fips_county                              := '105';
  self.doc_instrument_or_clerk_filing_num       := l.doc_instrument_or_clerk_filing_num;
  self.book_type_cd                             := l.book_type_cd;
  self.book_type_desc                           := 'Official Record';
  self.book_num                                 := l.book_num;
  self.page_num                                 := l.page_num;
  self.doc_type_cd                              := l.doc_type_cd[1..5];
  self.doc_type_desc                            := regexreplace('([(]ANY KIND[)])|([(]OF ANY KIND[)])',get_fl_polk(l.doc_type_cd) ,'',NOCASE);

  self.doc_filed_dt                             := fSlashedMDYtoYMD(l.doc_filed_dt);
  self.doc_record_dt                            := fSlashedMDYtoYMD(l.doc_filed_dt);
  self.legal_desc_1                             := l.legal_desc_1;
  self.doc_amend_cd                             := l.correction_flag;
  self.doc_amend_desc                           := map( l.correction_flag = 'C' => 'Corrected',
                                                         l.correction_flag = 'R' => 'Replaced' ,'');

end;

  File_doc_polk := project(File_In_FL_Polk,map2polkdoc(LEFT));

sort_polk := sort(File_doc_polk,record);
dedp_doc_polk := dedup(sort_polk,all);

 
official_records.Layout_In_preclean_Party map2polkpty(File_In_FL_Polk l) := transform
self.process_date                                    := filedate;
  self.vendor                                        := '16';
  self.state_origin                                  := 'FL';
  self.county_name                                   := 'POLK';
  self.official_record_key                           := '16' + trim(l.doc_instrument_or_clerk_filing_num,left,right);
 self.doc_instrument_or_clerk_filing_num             := l.doc_instrument_or_clerk_filing_num;
  self.doc_type_desc                                 := regexreplace('([(]ANY KIND[)])|([(]OF ANY KIND[)])',get_fl_polk(l.doc_type_cd),'',NOCASE);

  self.doc_filed_dt                                  := fSlashedMDYtoYMD(l.doc_filed_dt);
  self.entity_type_cd                                := l.entity_1_type_cd;
  self.entity_type_desc                              := map (trim(l.entity_1_type_cd) = 'D' => 'Direct',
                                                             trim(l.entity_1_type_cd) = 'R' => 'Reverse','');
  self.entity_nm                                     := l.entity_1_nm;
  self.entity_nm_format                              := 'L';
  end;
    File_party_polk := project(File_In_FL_Polk,map2polkpty(LEFT));

sort_party_polk := sort(File_party_polk,record);
dedp_polk_party := dedup(sort_party_polk,all);

official_records.MAC_Name_Clean(dedp_doc_polk,dedp_polk_party,'fl','polk',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl polk done '+official_records.Version_Development , 
						'Official Records mapping fl polk completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl polk failed '+official_records.Version_Development , 
						'Official Records mapping fl polk failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_polk := sequential(out) : success(succmail),failure(fmail);
 
 return out_polk;
 end;
 