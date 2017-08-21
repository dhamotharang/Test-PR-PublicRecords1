import ut,lib_stringlib;
export mapping_fl_hernando(string filedate) := function

									
official_records.Layout_In_preclean_document tr_docfinal(File_In_FL_Hernando l) := transform
doc_date                   := fSlashedMDYtoYMD(l.Document_Date[1..lib_stringlib.stringlib.stringfind(l.Document_Date, ' ',1)]);
 self.process_date         := filedate;
  self.vendor              := '02';
  self.state_origin        := 'FL';
  self.county_name         := 'HERNANDO';
  self.official_record_key := '02' + trim(l.Instrument_File);
  self.fips_st             := '12';
  self.fips_county         := '053';
  self.doc_instrument_or_clerk_filing_num := l.Instrument_File;
  self.doc_type_desc       :=trim(lib_stringlib.stringlib.stringfilterout(trim(l.Document_Type), 'X|"'));
  self.legal_desc_1        := l.Legal_Description[1..60];
  self.book_num            := l.Book_number;
  self.page_num            := l.Page_number;
  self.doc_filed_dt        := if(regexfind('[1..9]',doc_date) = false,'',doc_date);
  self.doc_record_dt       := if(regexfind('[1..9]',doc_date) = false,'',doc_date);
self := l;
end;

File_hernando_document := project(File_In_FL_Hernando,tr_docfinal(LEFT));

sort_hernando_document := sort(File_hernando_document,record);

dedp_hernando_document := dedup(sort_hernando_document,all);

//Process Non blank Direct_Name_or_Grantor_FromParty
File_nonblank_party := File_In_FL_Hernando(Direct_Name_or_Grantor_FromParty <> '');

official_records.Layout_In_preclean_party tr_brevparty_final(File_nonblank_party l) := transform
  doc_date                   := fSlashedMDYtoYMD(l.Document_Date[1..lib_stringlib.stringlib.stringfind(l.Document_Date, ' ',1)]);
  self.process_date          := filedate;
  self.vendor                := '02';
  self.state_origin          := 'FL';
  self.county_name           := 'HERNANDO';
  self.official_record_key   := '02' + trim(l.Instrument_File);
  self.doc_instrument_or_clerk_filing_num := l.Instrument_File;
  self.doc_type_desc         :=trim(lib_stringlib.stringlib.stringfilterout(trim(l.Document_Type), 'X|"'));
  self.doc_filed_dt          := if(regexfind('[1..9]',doc_date) = false,'',doc_date);
  self.entity_type_desc      := 'Direct Name or Grantor From Party';
  self.entity_nm             := l.Direct_Name_or_Grantor_FromParty;
  self.entity_nm_format      := 'L';
  self                       := l;
  end;
  
  File_Direct_party := project(File_nonblank_party,tr_brevparty_final(LEFT));
  
 //Process Reverse_Name_or_Grantee_ToParty
 
 File_nonblk_reverse := File_In_FL_Hernando(Reverse_Name_or_Grantee_ToParty <> '');
  
  official_records.Layout_In_preclean_party tr_reverseparty_final(File_nonblk_reverse l) := transform
    doc_date                  := fSlashedMDYtoYMD(l.Document_Date[1..lib_stringlib.stringlib.stringfind(l.Document_Date, ' ',1)]);
  self.process_date           := filedate;
  self.vendor                 := '02';
  self.state_origin           := 'FL';
  self.county_name            := 'HERNANDO';
  self.official_record_key    := '02' + trim(l.Instrument_File);
  self.doc_instrument_or_clerk_filing_num := l.Instrument_File;
  self.doc_type_desc          :=trim(lib_stringlib.stringlib.stringfilterout(trim(l.Document_Type), 'X|"'));
  self.doc_filed_dt           := if(regexfind('[1..9]',doc_date) = false,'',doc_date);
  self.entity_type_desc       := 'Reverse Name or Grantee To Party';
  self.entity_nm              := l.Reverse_Name_or_Grantee_ToParty;
  self.entity_nm_format       := 'L';
  self                        := l;
  end;
  
  
  File_reverse_party_final := project(File_nonblk_reverse,tr_reverseparty_final(LEFT));
  
  File_party_full := File_Direct_party + File_reverse_party_final;
  
  
  
  sort_hernando_party := sort(File_party_full,record);
  dedp_hernando_party := dedup(sort_hernando_party,all);
official_records.MAC_Name_Clean(dedp_hernando_document,dedp_hernando_party,'fl','hernando',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl hernando done '+official_records.Version_Development , 
						'Official Records mapping fl hernando completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl hernando failed '+official_records.Version_Development , 
						'Official Records mapping fl hernando failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_hernando := sequential(out) : success(succmail),failure(fmail);

return out_hernando;
end;





