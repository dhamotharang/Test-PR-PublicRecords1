import lib_stringlib;

export mapping_fl_hillsborough(string filedate) := function
 
									
official_records.Layout_In_preclean_document tr_docfinal(File_In_FL_Hillsborough l) := transform
  self.process_date                  := filedate;
  self.vendor                        := '01';
  self.state_origin                  := 'FL';
  self.county_name                   := 'HILLSBOROUGH';
  self.official_record_key           := if( lib_stringlib.StringLib.StringFilter(l.Instrument_Number, '123456789') != '','01' + l.Instrument_Number,lib_stringlib.StringLib.StringFilter(lib_stringlib.StringLib.StringToUpperCase('01' + l.Instrument_Number + l.Record_Date + l.Book_Type + l.Book_Number + l.Page_Number + 
                                            l.Document_Page_Count + l.Document_Description + l.Legal_Description_1 + l.Legal_Description_2 + l.Correction_Flag),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')[1..60]);

  self.fips_st                       := '12';
  self.fips_county                   := '057';
  self.doc_filed_dt                  := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_record_dt                 := fSlashedMDYtoYMD(l.Record_Date);
  self.doc_instrument_or_clerk_filing_num := l.Instrument_Number;
  self.book_type_cd                  := l.Book_Type;
  self.book_type_desc                := map(l.Book_Type = 'C' => 'Condominium Plan',
                                            l.Book_Type = 'M' => 'Minor Subdivision Survey',
							                              l.Book_Type = 'O' => 'Official Records',
							                              l.Book_Type = 'P' => 'Subdivision Plat',
							                              l.Book_Type = 'R' => 'Right of Way Monument',
							                              l.Book_Type = 'S' => 'Survey and Location Map',
							                              l.Book_Type = 'T' => 'Right of Way Transfer Map',
							                              l.Book_Type = 'V' => 'Right of Way Reservation',
							                              l.Book_Type = 'W' => 'Maintained Right of Way','');
  self.book_num                    := l.Book_Number;
  self.page_num                    := l.Page_Number;
  self.doc_page_count              := l.Document_Page_Count;
  self.doc_type_desc               := l.Document_Description;
  self.legal_desc_1                := if (trim(l.Legal_Description_1) != '\\', l.Legal_Description_1,'');

  self.legal_desc_2               := if (trim(l.Legal_Description_2) != '\\', l.Legal_Description_2,'');
  self.doc_amend_cd               := l.Correction_Flag;
  self.doc_amend_desc             := map( l.Correction_Flag = 'C' => 'Record Has been corrected',
                                          l.Correction_Flag = 'R' => 'Record Has been replaced',
							                            l.Correction_Flag = 'blank' => 'No change to the record','');
end;


File_hillsborough_document := project(File_In_FL_Hillsborough,tr_docfinal(LEFT));

sort_hillsborough_document := sort(File_hillsborough_document,record);

dedp_hillsborough_document := dedup(sort_hillsborough_document,all);


official_records.Layout_In_preclean_party tr_brevparty_final(File_In_FL_Hillsborough l) := transform
self.process_date                                   := filedate;
  self.vendor                                       := '01';
  self.state_origin                                 := 'FL';
  self.county_name                                  :='HILLSBOROUGH';
  self.official_record_key                          := if( lib_stringlib.StringLib.StringFilter(l.Instrument_Number, '123456789') != '','01' + l.Instrument_Number,lib_stringlib.StringLib.StringFilter(lib_stringlib.StringLib.Stringtouppercase('01' + l.Instrument_Number + l.Record_Date + l.Book_Type + l.Book_Number + l.Page_Number + 
                                                           l.Document_Page_Count + l.Document_Description + l.Legal_Description_1 + l.Legal_Description_2 + l.Correction_Flag),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ')[1..60]);

 
  self.doc_filed_dt                                 := fSlashedMDYtoYMD(l.Record_Date);

  self.doc_instrument_or_clerk_filing_num           := trim(l.Instrument_Number);
  self.doc_type_desc                                := l.Document_Description;
  self.entity_sequence                              := l.Entity_Sequence;
  self.entity_type_cd                               := l.Party_Code;
  self.entity_type_desc                              := regexreplace('FR',regexreplace('TO',l.Party_Code,'Reverse (grantee)') , 'Direct (grantor)');
  self.entity_nm                                    := l.Party_Name;
  self.entity_nm_format                             := 'L';
  self                                               := l;
  end;
  
  File_hillsborough_party := project(File_In_FL_Hillsborough,tr_brevparty_final(LEFT));
  
  sort_hillsborough_party := sort(File_hillsborough_party,record);
  dedp_hillsborough_party := dedup(sort_hillsborough_party,all);
official_records.MAC_Name_Clean(dedp_hillsborough_document,dedp_hillsborough_party,'fl','hillsborough',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl hillsborough done '+official_records.Version_Development , 
						'Official Records mapping fl hillsborough completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl hillsborough failed '+official_records.Version_Development , 
						'Official Records mapping fl hillsborough failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_hillsborough := sequential(out) : success(succmail),failure(fmail);

return out_hillsborough;
end;
