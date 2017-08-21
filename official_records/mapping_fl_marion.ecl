import lib_stringlib;
export mapping_fl_marion(string filedate) := function


official_records.Layout_In_preclean_document map2mariondoc(File_In_FL_Marion l) := transform
  self.process_date                  := filedate;
  self.vendor                        := '15' ;
  self.state_origin                  := 'FL';
  self.county_name                   := 'MARION';
  self.official_record_key           := '15' + trim(l.Clerk_File_Number,left,right);
  self.fips_st                       := '12' ;
  self.fips_county                   := '083';
  self.doc_filed_dt                  := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_record_dt                 := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_type_cd                   := l.Document_Type[1..5];
  self.doc_type_desc                 := trim(get_fl_marion (l.Document_Type)) ;
  self.book_num                      := l.Book_Number;
  self.page_num                      := l.Page_Number;
  self.legal_desc_1                  := l.Legal_1;
  self.doc_instrument_or_clerk_filing_num := trim(l.Clerk_File_Number);
  self.consideration_amt             := map (lib_stringlib.StringLib.StringFilterOut(l.Consideration_Amt, '$0.') = '' => '',
                                             lib_stringlib.StringLib.StringFilterOut(l.Consideration_Amt, '1234567890.') = '' =>
                                             lib_stringlib.StringLib.StringFilterOut(l.Consideration_Amt,'.'),l.Consideration_Amt[1..25]);
  self.parcel_or_case_num            := l.Case_Number_or_Parcel_ID;
end;
File_doc_marion := project(File_In_FL_Marion,map2mariondoc(LEFT));


sort_doc_marion := sort(File_doc_marion,record);

dedp_marion_doc := dedup(sort_doc_marion,all);


dWithPartyName := File_In_FL_Marion(Party_Name <> '' and Clerk_File_Number <> '');

official_records.Layout_In_preclean_party map2marionpty(dWithPartyName l) := transform
  self.process_date                          := filedate;
  self.vendor                                :='15' ;
  self.state_origin                          := 'FL';
  self.county_name                           := 'MARION';
  self.official_record_key                   := '15' + trim(l.Clerk_File_Number,left,right);
  self.doc_filed_dt                          := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_type_desc                         := trim(get_fl_marion ( l.Document_Type));
  self.doc_instrument_or_clerk_filing_num    := trim(l.Clerk_File_Number)[1..25];
  self.entity_type_cd                        := l.Direct_Reverse;
  self.entity_type_desc                      := map (l.Direct_Reverse = 'D' => 'Direct',
                                                     l.Direct_Reverse = 'R' =>  'Reverse','');
  self.entity_nm                             := l.Party_Name;
  self.entity_nm_format                      := 'L';
  end;
  dWithPartyNamefinal := project(dWithPartyName,map2marionpty(LEFT));

  
  dWithCrossPartyName := File_In_FL_Marion(Cross_Party_Name <> '' and Clerk_File_Number <> '');
  
  official_records.Layout_In_preclean_Party map2marioncr(dWithCrossPartyName l) := transform
  self.process_date                           := filedate;
  self.vendor                                 :='15' ;
  self.state_origin                           := 'FL';
  self.county_name                            := 'MARION';
  self.official_record_key                    := '15' + trim(l.Clerk_File_Number,left,right);
  self.doc_filed_dt                           := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_type_desc                          := trim(get_fl_marion ( l.Document_Type));
  self.doc_instrument_or_clerk_filing_num     := trim(l.Clerk_File_Number[1..25]);
  self.entity_type_cd                         := map (l.Direct_Reverse = 'D' => 'R',
                                                      l.Direct_Reverse = 'R' => 'D','');

  self.entity_type_desc                       := map (l.Direct_Reverse = 'R' =>  'Direct',
                                                       l.Direct_Reverse = 'D' =>  'Reverse','');
  self.entity_nm                              := l.Cross_Party_Name;
  self.entity_nm_format                       := 'L';
end;
  dWithCrossPartyNamefinal := project(dWithCrossPartyName,map2marioncr(LEFT));

  
  dWithPartyAll := dWithPartyNamefinal + dWithCrossPartyNamefinal;
  
  sort_marion_pty := sort(dWithPartyAll,record);
  
  dedp_marion_pty := dedup(sort_marion_pty,all);
  official_records.MAC_Name_Clean(dedp_marion_doc,dedp_marion_pty,'fl','marion',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl marion done '+official_records.Version_Development , 
						'Official Records mapping fl marion completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl marion failed '+official_records.Version_Development , 
						'Official Records mapping fl marion failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_marion := sequential(out) : success(succmail),failure(fmail);

return out_marion;
end;
  