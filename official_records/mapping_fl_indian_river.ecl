import lib_stringlib;
export mapping_fl_indian_river(string filedate) := function

									
official_records.Layout_In_preclean_document mappingIRdoc(File_In_FL_Indian_River l) := transform
 self.process_date                          := filedate;
  self.vendor                               := '21';
  self.state_origin                         := 'FL';
  self.county_name                          := 'INDIAN RIVER';
  self.official_record_key                  := '21' +  l.Instrument_Number;
  self.fips_st                              := '12';
  self.fips_county                          := '061';
  self.doc_instrument_or_clerk_filing_num   := l.Instrument_Number;
  self.doc_filed_dt                         := map (l.Record_Date[5] = '-' => lib_stringlib.StringLib.StringFilterOut(l.Record_Date[1..10], '-'),
                                                    l.Record_Date[3] = '/' => fSlashedMDYtoYMD(l.Record_Date),trim(l.Record_Date));

  self.doc_record_dt                        :=  map (l.Record_Date[5] = '-' => lib_stringlib.StringLib.StringFilterOut(l.Record_Date[1..10], '-'),
                                                     l.Record_Date[3] = '/' => fSlashedMDYtoYMD(l.Record_Date),trim(l.Record_Date));
  self.book_num                             := l.Book_Number;
  self.page_num                             := l.Page_Number;
  self.doc_type_cd                          := l.Unmapped_doctype[1..5];
  self.doc_type_desc                        := l.Document_Description;
  self.legal_desc_1                         := l.Legal_Description;
  self.doc_page_count                       := trim(l.Document_Page_Count);
	self.book_type_cd                         := trim(l.Book_Type);

end;
File_indian_river_document := project(File_In_FL_Indian_River,mappingIRdoc(LEFT));


sort_indian_river_document := sort(File_indian_river_document,record);

dedp_indian_river_document := dedup(sort_indian_river_document,all);
 


official_records.Layout_In_preclean_Party mappingIRparty(File_In_FL_Indian_River l) := transform
self.process_date                                 := filedate;
  self.vendor                                     := '21';
  self.state_origin                               := 'FL';
  self.county_name                                := 'INDIAN RIVER';
  self.official_record_key                        := '21' +  l.Instrument_Number;
 
  self.doc_instrument_or_clerk_filing_num         := l.Instrument_Number;
  self.doc_filed_dt                               := map (l.Record_Date[5] = '-' => lib_stringlib.StringLib.StringFilterOut(l.Record_Date[1..10], '-'),
                                                          l.Record_Date[3] = '/' => fSlashedMDYtoYMD(l.Record_Date),trim(l.Record_Date));
							 
  self.doc_type_desc                              := l.Document_Description;
  self.entity_type_cd                             := l.Party_Type;
  self.entity_type_desc                           := map(trim(l.Party_Type) = 'D' => 'DIRECT',
                                                         trim(l.Party_Type) = 'I' => 'REVERSE','');

  self.entity_nm                                  := l.Party_Name;
  self.entity_nm_format                           := 'L';
  self                                            := l;
  end;
  File_indian_river_party := project(File_In_FL_Indian_River,mappingIRparty(LEFT));

  
  sort_indian_river_party := sort(File_indian_river_party,record);
  dedp_indian_river_party := dedup(sort_indian_river_party,all);
official_records.MAC_Name_Clean(dedp_indian_river_document,dedp_indian_river_party,'fl','indian_river',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl indian_river done '+official_records.Version_Development , 
						'Official Records mapping fl indian_river completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl indian_river failed '+official_records.Version_Development , 
						'Official Records mapping fl indian_river failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_indian_river := sequential(out) : success(succmail),failure(fmail);

return out_indian_river;
end;
