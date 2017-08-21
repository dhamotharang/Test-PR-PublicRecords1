import lib_stringlib;
export mapping_fl_martin(string filedate) := function

									
official_records.Layout_In_preclean_document tr_docfinal( File_In_FL_Martin l) := transform
self.process_date                          := filedate;
  self.vendor                              := '22';
  self.state_origin                        := 'FL';
  self.county_name                         := 'MARTIN';
  self.official_record_key                 := '22' + trim(l.File_Number,left,right);
  self.fips_st                             := '12';
  self.fips_county                         := '085';
  self.doc_instrument_or_clerk_filing_num  := l.File_Number;
  self.book_num                            := l.Book;
  self.page_num                            := l.Page;
  self.doc_type_cd                         := l.Document_Type;
  self.legal_desc_1                        := l.Legal_1;
  self.doc_page_count                      := l.Page_Count;
  self.legal_desc_2                        := if(lib_stringlib.StringLib.StringFind(l.Legal_1, l.Legal_2,1) > 0 ,'', l.Legal_2);
  self.doc_filed_dt                        := fSlashedMDYtoYMD(l.Recorded_Date[1..(lib_stringlib.stringlib.stringfind(l.Recorded_Date,' ',1) - 1)]);
  self.doc_record_dt                       := fSlashedMDYtoYMD(l.Recorded_Date[1..(lib_stringlib.stringlib.stringfind(l.Recorded_Date,' ',1) - 1)]);
  self.doc_type_desc                       := regexreplace('V 1',trim(l.Name),'');
  self.doc_amend_cd                        := if ( l.Correction_Flag = 'C' or l.Correction_Flag = 'R' , l.Correction_Flag,'');                           
  self.doc_amend_desc                      := map ( l.Correction_Flag = 'C' => 'Corrected',
                                                    l.Correction_Flag = 'R' => 'Replaced',''); 

end;


File_doc_martin := project(File_In_FL_Martin,tr_docfinal(LEFT));
sort_martin := sort(File_doc_martin,record);
dedp_doc_martin := dedup(sort_martin,all);

 
official_records.Layout_In_preclean_Party tr_mtnparty_final(File_In_FL_Martin l) := transform
self.process_date                        := filedate;
  self.vendor                            := '22';
  self.state_origin                      := 'FL';
  self.county_name                       := 'MARTIN';
  self.official_record_key               := '22' + trim(l.File_Number,left,right);
  self.doc_instrument_or_clerk_filing_num := l.File_Number;
   self.doc_filed_dt                      := fSlashedMDYtoYMD(l.Recorded_Date[1..(lib_stringlib.stringlib.stringfind(l.Recorded_Date,' ',1) - 1)]);
  self.doc_type_desc                      := regexreplace('V 1',trim(l.Name),'');
  self.entity_type_cd                     := map(l.Party_Code = 'R' => 'D', 
                                                 l.Party_Code = 'D' => 'R',''); 
  self.entity_type_desc                   := map(l.Party_Code = 'R' => 'Direct', 
                                                 l.Party_Code = 'D' => 'Reverse',''); 
  self.entity_nm                          := l.Cross_Party_Name;
  self.entity_nm_format                   := 'L';
  end;
  
  File_crossparty_martin := project(File_In_FL_Martin,tr_mtnparty_final(LEFT));
	
official_records.Layout_In_preclean_Party tr_party_final(File_In_FL_Martin l) := transform
self.process_date                        := filedate;
  self.vendor                            := '22';
  self.state_origin                      := 'FL';
  self.county_name                       := 'MARTIN';
  self.official_record_key               := '22' + trim(l.File_Number,left,right);
  self.doc_instrument_or_clerk_filing_num := l.File_Number;
   self.doc_filed_dt                      := fSlashedMDYtoYMD(l.Recorded_Date[1..(lib_stringlib.stringlib.stringfind(l.Recorded_Date,' ',1) - 1)]);
  self.doc_type_desc                      := regexreplace('V 1',trim(l.Name),'');
  self.entity_type_cd                     := map(l.Party_Code = 'R' => 'D', 
                                                 l.Party_Code = 'D' => 'R',''); 
  self.entity_type_desc                   := map(l.Party_Code = 'R' => 'Direct', 
                                                 l.Party_Code = 'D' => 'Reverse',''); 
  self.entity_nm                          := l.Party_Name;
  self.entity_nm_format                   := 'L';
  end;
	
	  File_party_martin := project(File_In_FL_Martin,tr_party_final(LEFT));
		
		File_party_all := File_crossparty_martin + File_party_martin;

	
sort_party_martin := sort(File_party_all,record);
dedp_martin_party := dedup(sort_party_martin,all);
  official_records.MAC_Name_Clean(dedp_doc_martin,dedp_martin_party,'fl','martin',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl martin done '+official_records.Version_Development , 
						'Official Records mapping fl martin completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl martin failed '+official_records.Version_Development , 
						'Official Records mapping fl martin failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_martin := sequential(out) : success(succmail),failure(fmail);
 
 return out_martin;
 end;
 