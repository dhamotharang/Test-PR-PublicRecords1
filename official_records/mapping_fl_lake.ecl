import lib_stringlib;
export mapping_fl_lake(string filedate) := function

									
official_records.Layout_In_preclean_document map2lakedoc(File_In_FL_Lake l) := transform
 RECD_DT                            := if(l.RECORD_DATE[7] = '0' or l.RECORD_DATE[7] = '1' , '20' , '19' );
 self.process_date                  := filedate;
  self.vendor                       := '09';
  self.state_origin                 := 'FL';
  self.county_name                  :=  'LAKE';
  self.official_record_key          := '09' + trim(l.DOC_FILE_NUMBER) + trim(l.DOC_BOOK) + trim(l.DOC_PAGE);
  self.fips_st                      := '12' ;
  self.fips_county                  := '069';
  self.doc_instrument_or_clerk_filing_num := l.DOC_FILE_NUMBER;
  self.book_num                     := l.DOC_BOOK;
  self.page_num                     := l.DOC_PAGE;
  self.doc_type_cd                  := trim(l.DOC_TYPE);
  self.doc_type_desc                := get_fl_lake (trim(l.DOC_TYPE)) ;
  self.doc_page_count               := l.NUMBER_OF_PAGES;
  self.doc_filed_dt                 := if(length(trim(l.RECORD_DATE)) = 10 ,fSlashedMDYtoYMD(l.RECORD_DATE),fSlashedMDYtoYMD(l.RECORD_DATE[1..6] + RECD_DT + l.RECORD_DATE[7..8]));
  self.doc_record_dt                := if(length(trim(l.RECORD_DATE)) = 10 ,fSlashedMDYtoYMD(l.RECORD_DATE),fSlashedMDYtoYMD(l.RECORD_DATE[1..6] + RECD_DT + l.RECORD_DATE[7..8]));
  self.address_1                    := trim(l.ADDRESS_1,left,right);
  self.address_2                    := trim(l.ADDRESS_2,left,right);
  self.address_3                    := lib_StringLib.StringLib.StringToUpperCase(trim(l.city,left,right)
                                                                                 + if(l.city <> '', ', ', '')
                                                                                 + trim(l.state,left,right)
                                                                                 + ' '
                                                                                 + trim(l.zip[1..5],left,right)

                                                                         );


  self.intangible_tax_amt         := (string)intformat((integer)lib_stringlib.StringLib.StringFilter(l.INTANGIBLE_TAX, '1234567890'), 10,0);
  self.documentary_stamps_fee     := (string)intformat((integer)lib_stringlib.StringLib.StringFilter(l.DOC_STAMP_TAX, '1234567890'), 10, 0);
  self.consideration_amt          := if ( (integer) l.CONSIDERATION <> 0,(string)intformat((integer)lib_stringlib.StringLib.StringFilter(l.CONSIDERATION, '1234567890'), 25, 0),'');
  self.legal_desc_1               := l.PARTY_LEGAL_1[1..60];
  self.legal_desc_2               := if(lib_stringlib.StringLib.StringFind(l.PARTY_LEGAL_1[1..60], trim(l.PARTY_LEGAL_2[1..60]),1) = 0, trim(l.PARTY_LEGAL_2[1..60]),'');
  self.doc_amend_cd               := l.CORRECTION_FLAG;
  self.doc_amend_desc             := map (trim(l.CORRECTION_FLAG) = 'C' => 'Record has been corrected',
                                          trim(l.CORRECTION_FLAG) = 'N' => 'No change to the record',
                                          trim(l.CORRECTION_FLAG) = 'R' => 'Record has been replaced','');
  self.prior_doc_file_num         := l.RELATED_DOC_FILE_NO;
  self.prior_book_num             := l.RELATED_DOC_BOOK;
  self.prior_page_num             := l.RELATED_DOC_PAGE;
  self.prior_book_type_cd         := l.RELATED_DOC_TYPE;
  self.prior_book_type_desc       := get_fl_lake (trim(l.RELATED_DOC_TYPE)) ;
end;
File_lake_document := project(File_In_FL_Lake,map2lakedoc(LEFT));


sort_lake_document := sort(File_lake_document,record);

dedp_lake_document := dedup(sort_lake_document,all);



official_records.Layout_In_preclean_party map2lakepty(File_In_FL_Lake l) := transform
  RECD_DT                             := if(l.RECORD_DATE[7] = '0' or l.RECORD_DATE[7] = '1', '20' , '19' );
 self.process_date                    := filedate;
  self.vendor                         := '09';
  self.state_origin                   := 'FL';
  self.county_name                    :=  'LAKE';
  self.official_record_key            := '09'+ trim(l.DOC_FILE_NUMBER) + trim(l.DOC_BOOK) + trim(l.DOC_PAGE);
  self.doc_instrument_or_clerk_filing_num := trim(l.DOC_FILE_NUMBER);
  self.doc_type_desc                  := get_fl_lake (trim(l.DOC_TYPE)) ;
  self.doc_filed_dt                   := if(length(trim(l.RECORD_DATE)) = 10 ,fSlashedMDYtoYMD(l.RECORD_DATE),fSlashedMDYtoYMD(l.RECORD_DATE[1..6] + RECD_DT + l.RECORD_DATE[7..8]));

  self.entity_type_cd                 := l.PARTY_CODE;
  self.entity_type_desc               := map (trim(l.PARTY_CODE) = 'D' => 'Direct',
                                              trim(l.PARTY_CODE) = 'R' => 'Reverse','');

  self.entity_nm                      := l.PARTY_NAME;
  self.entity_nm_format               := 'L';
  self                                := l;
  end;
  File_lake_party := project(File_In_FL_Lake,map2lakepty(LEFT));

  
  sort_lake_party := sort(File_lake_party,record);
  dedp_lake_party := dedup(sort_lake_party,all);
official_records.MAC_Name_Clean(dedp_lake_document,dedp_lake_party,'fl','lake',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl lake done '+official_records.Version_Development , 
						'Official Records mapping fl lake completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl lake failed '+official_records.Version_Development , 
						'Official Records mapping fl lake failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_lake := sequential(out) : success(succmail),failure(fmail);


return out_lake;
end;