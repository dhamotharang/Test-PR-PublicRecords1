import lib_StringLib;
export mapping_fl_broward(string filedate) := function
									
official_records.Layout_In_preclean_document map2brodoc(File_In_FL_Broward l) := transform
 self.process_date                         := filedate ;
  self.vendor                              := '03';
  self.state_origin                        := 'FL';
  self.county_name                         := 'BROWARD';
  self.official_record_key                 := '03' + trim(l.Instrument_Number);
  self.fips_st                             := '12';
  self.fips_county                         := '011';
  self.doc_instrument_or_clerk_filing_num  := l.Instrument_Number;
  self.doc_filed_dt                        := l.Record_Date;
  self.doc_record_dt                       := l.Record_Date;
  self.doc_type_cd                         := trim(l.Document_Type_Code)[1..5];
  self.doc_type_desc                       :=  StringLib.StringtoUpperCase(get_fl_broward_doctype(l.Document_Type_Code));
 self.execution_dt                         := if( fSlashedMDYtoYMD(l.Execution_Date) = '00000000','',fSlashedMDYtoYMD(l.Execution_Date));
  self.consideration_amt                   := if ( (integer) lib_stringlib.StringLib.StringFilterOut(l.Consideration_Amount,'.') <> 0, (string)INTFORMAT((integer)lib_stringlib.StringLib.StringFilterOut(l.Consideration_Amount,'.'),25,0),'') ;
  self.book_num                            := l.Book_Number;
  self.page_num                            := l.Page_Number;
  self.book_type_cd                        := l.Book_Type;
  self.book_type_desc                      := get_fl_broward_booktype(l.Book_Type);
  self.legal_desc_1                        := l.Legal_1;
	self.parcel_or_case_num                  :=  if( l.Case_Number <> '', trim(l.Case_Number),trim(l.Parcel_ID));
  self.address_1                           := l.Address_1;
  self.address_2                           := l.Address_2;
  self.address_3                           := l.City;
  self.address_4                           := l.State + '  '+ l.Zip_Code;
  self.doc_amend_cd                        := l.Re_record_Flag;
  self.doc_amend_desc                      := get_fl_brwd_ctflag( l.Re_record_Flag);
  self.prior_doc_file_num                  := l.Prior_Instrument_Number;
  self.prior_doc_type_cd                   := trim(l.Prior_Document_Type_Code)[1..5];
  self.prior_doc_type_desc                 := StringLib.StringtoUpperCase(get_fl_broward_doctype(l.Prior_Document_Type_Code));
  self.prior_book_num                      := l.Prior_Book_Number;
  self.prior_page_num                      := l.Prior_Page_Number;
  self.prior_book_type_cd                  := l.Prior_Book_Type;
  self.prior_book_type_desc                := get_fl_broward_booktype(l.Prior_Book_Type);
	self.intangible_tax_amt                  := trim(l.Intangible_Tax);
  self.documentary_stamps_fee              := trim(l.Documentary_Tax);
  self.doc_names_count                     := l.Number_of_Names;
  self.doc_other_desc                      := map( l.Confidential = '0' =>  'Public' ,
                                                   l.Confidential = '1' => 'Confidential' ,
                                                   l.Confidential = '2' => 'Sealed' ,
                                                   l.Confidential = '3' => 'Expunged' ,
                                                   l.Confidential = '4' => 'Void' , '');
  self.doc_status_cd                      := l.Status;
  self.doc_status_desc                    := map( l.Status = 'R' =>  'Recorded' ,
                                                  l.Status = 'I' => 'Indexed' ,
                                                  l.Status = 'H' => 'Verified' ,
                                                  l.Status = 'V' => 'Verified and Released' , '');
  self.formatted_parcel_num               := if ( (integer) l.Parcel_ID <> 0, l.Parcel_ID , '');

end;

File_broward_document := project(File_In_FL_Broward,map2brodoc(LEFT));
                             




sort_broward_document := sort(File_broward_document,record);

dedp_broward_document := dedup(sort_broward_document,all);



official_records.Layout_In_preclean_party map2bropty(File_In_FL_Broward l) := transform
 self.process_date                                    := filedate;
  self.vendor                                         := '03';
  self.state_origin                                   := 'FL';
  self.county_name                                    := 'BROWARD';
  self.official_record_key                            := '03' + trim(l.Instrument_Number);
  self.doc_instrument_or_clerk_filing_num             := l.Instrument_Number;
  self.doc_filed_dt                                   := l.Record_Date;
  self.doc_type_desc                                  :=  StringLib.StringtoUpperCase(get_fl_broward_doctype(l.Document_Type_Code));
  self.entity_nm                                      := l.Party_Name;
  self.entity_type_cd                                 := l.Direct_Reverse;
  self.entity_type_desc                               := map (l.Direct_Reverse = 'D' => 'DIRECT',
                                                              l.Direct_Reverse = 'R' => 'REVERSE','');
								   

  self.entity_nm_format                               := map(l.Company_Individual = 'C' =>  'C' ,
                                                              lib_stringLib.StringLib.StringFind(l.Party_Name, ',',1) != 0 => 'L','F');

  self.entity_sequence                                := l.Name_Sequence;
end;
  File_broward_party := project(File_In_FL_Broward, map2bropty(LEFT));

  
  sort_broward_party := sort(File_broward_party,record);
  dedp_broward_party := dedup(sort_broward_party,all);
official_records.MAC_Name_Clean(dedp_broward_document,dedp_broward_party,'fl','broward',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl broward done '+official_records.Version_Development , 
						'Official Records mapping fl broward completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl broward failed '+official_records.Version_Development , 
						'Official Records mapping fl broward failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_broward := sequential(out) : success(succmail),failure(fmail);

return out_broward;
end;