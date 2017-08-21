#OPTION('maxLength',99999)

import lib_stringlib;

export mapping_fl_volusia(string filedate) := function

  official_records.Layout_In_preclean_document map2voldoc( File_In_FL_Volusia l) := transform
  fDATE := if( regexfind('[[:space:]]*',l.date) = true,regexreplace('[[:space:]]*',l.date,'$2$3$4'),l.date);
   fType := if( regexfind('[[:space:]]*',l.TYPE1) = true,regexreplace('[[:space:]]*',l.TYPE1,'$2$3$4'),l.TYPE1);

  self.process_date                        := filedate;
  self.vendor                              := '05';
  self.state_origin                        := 'FL';
  self.county_name                         := 'VOLUSIA';
  self.official_record_key                 := '05' + trim(l.Instrument,left,right);
  self.fips_st                             := '12';
  self.fips_county                         := '127';
   self.doc_instrument_or_clerk_filing_num := trim(l.Instrument,left,right);         
  self.doc_filed_dt                        := fSlashedMDYtoYMD(fDATE);                      
  self.book_num                            := l.BOOK;                                        
  self.page_num                            := l.PAGE;                                        
  self.doc_type_cd                         := fType;                                     
  self.transfer_                           := if( regexfind('[1-9]',lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.TRANSFER1,10,2),'.')) = true,lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.TRANSFER1,10,2),'.'),'') ;               
  self.mortgage                            := if( regexfind('[1-9]',lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.MORTGAGE,10,2),'.')) = true,lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.MORTGAGE,10,2),'.'),'');                  
  self.documentary_stamps_fee              := if( regexfind('[1-9]',lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.DOCSTAMPS,10,2),'.')) = true,lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.DOCSTAMPS,10,2),'.'),''); 
  self.intangible_tax_amt                  := if( regexfind('[1-9]',lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.INTANGTAX,10,2),'.')) = true,lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.INTANGTAX,10,2),'.'),''); 
  self.recording_fee                       := if( regexfind('[1-9]',lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.RECFEE,10,2),'.')) = true,lib_stringlib.StringLib.StringFilterOut(REALFORMAT((REAL)l.RECFEE,10,2),'.'),'');
  self.doc_type_desc                       := get_fl_volusia(fType);
  self.doc_record_dt                       :=   fSlashedMDYtoYMD(fDATE);             
  self.doc_page_count                      := l.PAGES;                                 
  self.prior_doc_file_num                  := l.RELATEDS;                          
  self.legal_desc_1                        := l.LEGAL1;                                  
  self.legal_desc_2                        := l.LEGAL2;                                  
  self.legal_desc_3                        := l.LEGAL3;                                  
  self.legal_desc_4                        := l.LEGAL4;                                  
  self.legal_desc_5                        := l.LEGAL5;                                  
  self.parcel_or_case_num                  := lib_stringlib.StringLib.StringCleanSpaces(l.MISC);                              
end;
      File_doc_volusia := project(File_In_FL_Volusia,map2voldoc(LEFT));


sort_volusia := sort(File_doc_volusia,record);
dedp_doc_volusia := dedup(sort_volusia,all);

 
official_records.Layout_In_preclean_Party map2volpty(File_In_FL_Volusia l) := transform
fDATE := if( regexfind('[[:space:]]*',l.date) = true,regexreplace('[[:space:]]*',l.date,'$2$3$4'),l.date);
fType := if( regexfind('[[:space:]]*',l.TYPE1) = true,regexreplace('[[:space:]]*',l.TYPE1,'$2$3$4'),l.TYPE1);

  self.process_date                     := filedate;
  self.vendor                           := '05';
  self.state_origin                     := 'FL';
  self.county_name                      := 'VOLUSIA' ;
  self.official_record_key              := '05' + trim(l.Instrument,left,right);
  self.doc_instrument_or_clerk_filing_num := trim(l.Instrument,left,right);      
  self.doc_filed_dt                    := fSlashedMDYtoYMD(fDATE);                         
  self.doc_type_desc                   := get_fl_volusia(fType);
  self.entity_type_cd                  := l.NAME_index;                      
  self.entity_type_desc                := map(l.NAME_index = 'D' => 'Direct' , 
                                              l.NAME_index = 'R' => 'Reverse','');                             
                                                           
  self.entity_nm                       := trim(l.NAME,left,right);                                 
  self.entity_nm_format                := 'L';                             
                                                              
    self                              := l;                                                          
                                                              


end;
  File_party_volusia := project(File_In_FL_Volusia( NAME <> ''),map2volpty(LEFT));

sort_party_volusia := sort(File_party_volusia,record);
dedp_volusia_party := dedup(sort_party_volusia,all);

  official_records.MAC_Name_Clean(dedp_doc_volusia,dedp_volusia_party,'fl','volusia',filedate,out);
  
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl volusia done '+official_records.Version_Development , 
						'Official Records mapping fl volusia completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl volusia failed '+official_records.Version_Development , 
						'Official Records mapping fl volusia failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_volusia := sequential(out) : success(succmail),failure(fmail);
 
 return out_volusia;
 end;