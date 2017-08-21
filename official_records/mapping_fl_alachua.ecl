import lib_StringLib;
export mapping_fl_alachua(string filedate) := function
//Alachua document clean
official_records.Layout_In_preclean_document map2alchdoc(official_records.File_In_FL_Alachua l) := transform
self.process_date                := filedate;
self.vendor                      := '20';
self.state_origin                := 'FL';
self.county_name                 := 'ALACHUA';
self.official_record_key         := '20' + trim(l.Instrument_Num,left,right);
self.fips_st                     := '12';
self.fips_county                 := '001';
self.doc_instrument_or_clerk_filing_num := trim(l.Instrument_Num,left,right);
self.doc_type_cd                := trim(l.Instrument_Type)[1..5];
self.legal_desc_1               := trim(l.Legal_Description[1..60],left,right);
self.book_num                   := l.book;
self.page_num                   := l.page;
self.doc_filed_dt               := lib_StringLib.StringLib.StringFilterOut(trim(l.Date_or_Time_Rec)[1..10],'-');
self.doc_record_dt              := lib_StringLib.StringLib.StringFilterOut(trim(l.Date_or_Time_Rec)[1..10],'-');
self.doc_type_desc              := get_fl_alachua(trim(l.Instrument_Type)) ;
self := l;
end;

File_aldocument := project(File_In_FL_Alachua,map2alchdoc(LEFT));

sort_File_document := sort(File_aldocument,record);
dedp_File_document := dedup(sort_File_document,all);


//Alachua Party Clean
official_records.Layout_In_preclean_party map2alchpty(File_In_FL_Alachua l) := transform
self.process_date                  := filedate;
self.vendor                        := '20';
self.state_origin                  := 'FL';
self.county_name                   := 'ALACHUA';
self.official_record_key           := '20' + trim(l.Instrument_Num,left,right);
self.doc_instrument_or_clerk_filing_num := trim(l.Instrument_Num,left,right);
self.doc_filed_dt                  := lib_StringLib.StringLib.StringFilterOut(trim(l.Date_or_Time_Rec)[1..10],'-');
self.entity_sequence               := trim(l.sequence_num,left,right);
self.entity_type_cd                := trim(l.Name_Type,left,right);
self.entity_type_desc              := map(trim(l.Name_Type,left,right) = 'F' => 'FROM',
                                          trim(l.Name_Type,left,right) = 'T' => 'TO','');
self.entity_nm                     := trim(l.Last_Name,left,right) + ' '+ trim(l.First_Name,left,right) [1..80];
self.entity_nm_format              := 'L';
self.doc_type_desc                 := get_fl_alachua(trim(l.Instrument_Type)) ;
self := l;

end;
File_alparty := project(File_In_FL_Alachua,map2alchpty(LEFT));

sort_File_party := sort(File_alparty,record);
dedp_File_party := dedup(sort_File_party,all);
official_records.MAC_Name_Clean(dedp_File_document,dedp_File_party,'fl','alachua',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl alachua done '+official_records.Version_Development , 
						'Official Records mapping fl alachua completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl alachua failed '+official_records.Version_Development , 
						'Official Records mapping fl alachua failed. Please view  WU-ID: ' + Thorlib.WUID( ));						
out_alachua := sequential(out) : success(succmail),failure(fmail);//out_alachua := sequential(File_preclean_document,File_preclean_party);

return out_alachua;
end;