import lib_stringlib;

export mapping_fl_orange(string filedate) := function


  official_records.Layout_In_preclean_document map2orgdoc(File_In_FL_Orange l) := transform
self.process_date                               := filedate;
  self.vendor                                   := '11';
  self.state_origin                             := 'FL';
  self.county_name                              := 'ORANGE' ;
  self.official_record_key                      := '11'+ trim(l.instrument_or_clerk_file_no,LEFT,RIGHT) + trim(l.book,LEFT,RIGHT) + trim(l.page,LEFT,RIGHT);
  self.fips_st                                  := '12';
  self.fips_county                              := '095';
  self.book_num                                 := l.book;
  self.page_num                                 := l.page;
  self.doc_instrument_or_clerk_filing_num       := l.instrument_or_clerk_file_no;
  self.doc_filed_dt                             := fSlashedMDYtoYMD(l.recording_date);
  self.doc_record_dt                            := fSlashedMDYtoYMD(l.recording_date);
	self.doc_type_cd                              := l.document_type[1..5];
  
  self.doc_type_desc                            := get_fl_orange( l.document_type );

  self.legal_desc_1                             := l.legal_1[1..60];
  self.consideration_amt                        := map(lib_stringlib.StringLib.StringFilter(l.consideration, '123456789') = ''=> '',
                                                       lib_stringlib.StringLib.StringFind(l.consideration,'.',1) != 0 => (string)intformat((integer)trim(regexreplace(',',l.consideration,'')),25,0),(string)intformat((integer)(trim(l.consideration) + '00'),25,0));

  self.mortgage                                 := l.mortgageamt[1..10];
  self.intangible_tax_amt                       := l.intangibletax;
  self.parcel_or_case_num                       := lib_stringlib.StringLib.StringFilterout(l.court_case_number,',')[1..25];
  self.excise_tax_amt                           := trim(l.deeddoctax);
end;

  File_doc_orange := project(File_In_FL_Orange, map2orgdoc(LEFT));

sort_orange := sort(File_doc_orange,record);
dedp_doc_orange := dedup(sort_orange,all);

 
official_records.Layout_In_preclean_Party map2orgpty(File_In_FL_Orange l) := transform
self.process_date                                 := filedate;
  self.vendor                                     := '11';
  self.state_origin                               := 'FL';
  self.county_name                                := 'ORANGE' ;
  self.official_record_key                        := '11' + trim(l.instrument_or_clerk_file_no,LEFT,RIGHT) + trim(l.book,LEFT,RIGHT) + trim(l.page,LEFT,RIGHT);
self.doc_instrument_or_clerk_filing_num           := l.instrument_or_clerk_file_no;
  self.doc_filed_dt                               := fSlashedMDYtoYMD(l.recording_date);
  self.doc_type_desc                              := get_fl_orange( l.document_type );
  self.entity_type_cd                             := l.party_code;
  self.entity_type_desc                           := map(l.party_code = 'D' => 'Direct',
                                                           l.party_code = 'R' => 'Reverse','');
  self.entity_nm                                  := trim(l.party_name)[1..80];
  self.entity_nm_format                            := 'L';

end;
  
   File_party_orange := project(File_In_FL_Orange(party_name <> ''), map2orgpty(LEFT));

sort_party_orange := sort(File_party_orange,record);
dedp_orange_party := dedup(sort_party_orange,all);
  official_records.MAC_Name_Clean(dedp_doc_orange,dedp_orange_party,'fl','orange',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl orange done '+official_records.Version_Development , 
						'Official Records mapping fl orange completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl orange failed '+official_records.Version_Development , 
						'Official Records mapping fl orange failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_orange := sequential(out) : success(succmail),failure(fmail);

 
 return out_orange;
 end;
