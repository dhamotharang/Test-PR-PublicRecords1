import lib_stringlib;
export mapping_fl_sarasota(string filedate) := function


  official_records.Layout_In_preclean_document map2stadoc(File_In_FL_Sarasota l) := transform
self.process_date                               := filedate;
  self.vendor                                   := '14';
  self.state_origin                             := 'FL';
  self.county_name                              := 'SARASOTA';
  self.official_record_key                       := '14' + l.instrument_number;
  self.fips_st                                 := '12';
  self.fips_county                             := '115';
  self.doc_instrument_or_clerk_filing_num      := l.instrument_number;
  self.doc_type_cd                             := l.document_type_code[1..5];
  self.doc_type_desc                           := get_fl_sarasota( l.document_type_code) ;
  self.legal_desc_1                            := l.freeform_legal[1..60];
  self.book_num                                := if (lib_stringlib.StringLib.StringFilterout(l.book, '0') = '','',l.book);
  self.page_num                                := if (lib_stringlib.StringLib.StringFilterout(l.page, '0') = '','',l.page);
  self.doc_filed_dt                            := fSlashedMDYtoYMD(l.timeReceived);
  self.doc_record_dt                           := fSlashedMDYtoYMD(l.timeReceived);
	self.book_type_cd                            := l.book_type;
  self.doc_page_count                          := l.number_pgs_recorded;
  self.consideration_amt                       := if ( (integer) l.consideration <> 0, (string)INTFORMAT((integer)lib_stringlib.StringLib.StringFilterOut(l.consideration,'.'),25,0),'') ;
  self.parcel_or_case_num                      := l.mapcase_number;
  self.doc_status_cd                           := l.indx_status;
  self.legal_desc_2                            := l.addition;

  self                                         := l;

end;
    File_doc_sarasota := project(File_In_FL_Sarasota,map2stadoc(LEFT));


sort_sarasota := sort(File_doc_sarasota,record);
dedp_doc_sarasota := dedup(sort_sarasota,all);

 
official_records.Layout_In_preclean_party map2grantor(File_In_FL_Sarasota l) := transform
self.process_date                         := filedate;
  self.vendor                             := '14';
  self.state_origin                       := 'FL';
  self.county_name                        := 'SARASOTA' ;
  self.official_record_key                := '14' + l.instrument_number;
self.doc_instrument_or_clerk_filing_num   := l.instrument_number;
  self.doc_filed_dt                       := fSlashedMDYtoYMD(l.timeReceived);
  self.doc_type_desc                      := get_fl_sarasota( l.document_type_code);
   self.entity_sequence                   :=  l.grantor_seqno;

  self.entity_type_cd                     := l.grantor_from_to;
  self.entity_type_desc                   := 'From';
  self.entity_nm                          := trim(l.grantor_last_name) + ' '+ trim(l.grantor_first_name) + ' '+ trim(l.grantor_middle_name) + ' ' + trim(l.grantor_suffix) [1..80];
  self.entity_nm_format                    := 'L';

end;
      dWithGrantor := project(File_In_FL_Sarasota,map2grantor(LEFT));
			

dWithGrantorsort := sort(dWithGrantor,record);
dWithGrantoruniq := dedup(dWithGrantorsort,all);


official_records.Layout_In_preclean_party map2grantee(File_In_FL_Sarasota l) := transform
self.process_date                         := filedate;
  self.vendor                             := '14';
  self.state_origin                       := 'FL';
  self.county_name                        := 'SARASOTA' ;
  self.official_record_key                := '14' + l.instrument_number;
self.doc_instrument_or_clerk_filing_num   := l.instrument_number;
  self.doc_filed_dt                       := fSlashedMDYtoYMD(l.timeReceived);
  self.doc_type_desc                      := get_fl_sarasota( l.document_type_code);
   self.entity_sequence                   :=  l.grantor_seqno;

  self.entity_type_cd                     := l.grantee_from_to;
  self.entity_type_desc                   := 'To';
  self.entity_nm                          := trim(l.grantee_last_name) + ' '+ trim(l.grantee_first_name) + ' '+ trim(l.grantee_middle_name) + ' ' + trim(l.grantee_suffix) [1..80];
  self.entity_nm_format                    := 'L';

end;
      dWithGrantee := project(File_In_FL_Sarasota,map2grantee(LEFT));
	
	dWithGranteesort := sort(dWithGrantee,record);
dWithGranteeuniq := dedup(dWithGranteesort,record,except entity_sequence);

dWithPartyAll := 		dWithGrantoruniq + dWithGranteeuniq ;	
			
  official_records.MAC_Name_Clean(dedp_doc_sarasota,dWithPartyAll,'fl','sarasota',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl sarasota done '+official_records.Version_Development , 
						'Official Records mapping fl sarasota completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl sarasota failed '+official_records.Version_Development , 
						'Official Records mapping fl sarasota failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_sarasota := sequential(out) : success(succmail),failure(fmail);
 
 return out_sarasota;
 end;

