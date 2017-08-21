import lib_stringlib;
export mapping_fl_citrus(string filedate) := function
  
									
official_records.Layout_In_preclean_document map2citrdoc(File_In_FL_Citrus l) := transform
  self.process_date                       := filedate;
  self.vendor                             := '18';
  self.state_origin                       := 'FL';
  self.county_name                        := 'CITRUS';
  self.official_record_key                := '18' + trim(l.Instrument_Number);
  self.fips_st                            := '12';
  self.fips_county                        := '017';
  self.doc_instrument_or_clerk_filing_num := trim(l.Instrument_Number);
  self.doc_type_cd                        := l.Document_Type[1..5];
  self.doc_type_desc                      := trim(l.Document_Desc);
  self.legal_desc_1                       := l.Legal_Desc[1..60];
  self.book_type_cd                       := trim(l.Book_Type);
  self.book_type_desc                     := map (trim(l.Book_Type) = 'OR' => 'Official Record',
                                                  trim(l.Book_Type) = 'P' => 'Plat','');
							   

  self.book_num                           := l.Book;
  self.page_num                           := l.Page;
  self.doc_page_count                     := trim(l.Number_Pages);
  self.doc_filed_dt                       := fSlashedMDYtoYMD(l.File_Date);
  self.doc_record_dt                      := fSlashedMDYtoYMD(l.File_Date);
  self                                    := l;
  end;
  
  File_citrus_document := project(File_In_FL_Citrus,map2citrdoc(LEFT));

sort_citrus_document := sort(File_citrus_document,record);

dedp_citrus_document := dedup(sort_citrus_document,all);


official_records.Layout_In_preclean_party map2citrpty(File_In_FL_Citrus l) := transform
 self.process_date                       := filedate;
  self.vendor                            := '18';
  self.state_origin                      := 'FL';
  self.county_name                       := 'CITRUS';
  self.official_record_key               := '18' + trim(l.Instrument_Number,left,right);
  self.doc_instrument_or_clerk_filing_num := trim(l.Instrument_Number,left,right);
  self.doc_filed_dt                      := fSlashedMDYtoYMD(l.File_Date);
  self.doc_type_desc                     := l.Document_Desc;
  self.entity_sequence                   := trim(l.Party_ID);
  self.entity_type_cd                    := l.Party_Type;
  self.entity_type_desc                  := map (trim(l.Party_Type) = '1' => 'TO',
                                                 trim(l.Party_Type) = '2' => 'FROM',
								                                 trim(l.Party_Type) = '3' => 'RETURN TO','');

  self.entity_nm                        := l.Name[1..80];
  self.entity_nm_format                 := 'L';
  self                                  := l;
  end;
  
  File_citrus_party := project(File_In_FL_Citrus,map2citrpty(LEFT));
  
  sort_citrus_party := sort(File_citrus_party,record);
  dedp_citrus_party := dedup(sort_citrus_party,all);
official_records.MAC_Name_Clean(dedp_citrus_document,dedp_citrus_party,'fl','citrus',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl citrus done '+official_records.Version_Development , 
						'Official Records mapping fl citrus completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl citrus failed '+official_records.Version_Development , 
						'Official Records mapping fl citrus failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_citrus := sequential(out) : success(succmail),failure(fmail);



return out_citrus;
end;


