export mapping_fl_monroe(string filedate) := function


official_records.Layout_In_preclean_document tr_doc_final(File_In_FL_Monroe l) := transform
self.process_date                                 := filedate;
  self.vendor                                     := '24';
  self.state_origin                               := 'FL';
  self.county_name                                := 'MONROE' ;
  self.official_record_key                        := trim(l.sDocumentNO,left,right) + trim(l.sBookNo,left,right) + trim(l.sPageNo,left,right);
  self.fips_st                                    := '12';
  self.fips_county                                := '087';
  self.book_num                                   := l.sBookNo[1..10];
  self.page_num                                   := l.sPageNo[1..10];
  self.doc_instrument_or_clerk_filing_num         := trim(l.sDocumentNO,left,right);
  self.doc_filed_dt                               := map(length(trim(l.FiledDate,left,right)) = 10 and trim(l.FiledDate,left,right)[7..8] in ['19','20'] => trim(l.FiledDate,left,right)[7..10] +  trim(l.FiledDate,left,right)[1..2] + trim(l.FiledDate,left,right)[4..5] , 
	                                                  length(trim(l.FiledDate,left,right)) = 8 and trim(l.FiledDate,left,right)[5..6] in ['19','20'] => trim(l.FiledDate,left,right)[5..8] + trim(l.FiledDate,left,right)[1..2] + trim(l.FiledDate,left,right)[3..4] ,
																										'');
  
  self.parcel_or_case_num                          := trim(l.sParcel,left,right)[1..25];
  self.consideration_amt                           := map ( trim(l.mnyConsideration) = '0.0000' =>  '',
                                                             StringLib.stringfind(trim(l.mnyConsideration),'.0000',1) <> 0 =>  trim(l.mnyConsideration)[1..StringLib.stringfind(trim(l.mnyConsideration),'.0000',1)] + '00'
                                                             , trim(l.mnyConsideration)
																														);
  self.address_1                                   := trim(l.sAddress1);
  self.address_2                                   := trim(l.sAddress2);
  self.address_3                                   := trim(l.sAddress3);
  self.doc_type_desc                               := trim(l.sInstrumentType);
  self.execution_dt                                := trim(l.InstrumentDate);
  self.book_type_desc                              := trim(l.sBookType);

end;


File_doc_monroe := project(File_In_FL_Monroe,tr_doc_final(LEFT));
sort_monroe := sort(File_doc_monroe,record);
dedp_doc_monroe := dedup(sort_monroe,all);

 
official_records.Layout_In_preclean_Party tr_monroeparty_final(File_In_FL_Monroe l) := transform
self.process_date                                  := filedate;
  self.vendor                                      := '24';
  self.state_origin                                := 'FL';
  self.county_name                                 := 'MONROE' ;
  self.official_record_key                         := trim(l.sDocumentNO,left,right) + trim(l.sBookNo,left,right) + trim(l.sPageNo,left,right);
  self.doc_filed_dt                                := map(length(trim(l.FiledDate,left,right)) = 10 and trim(l.FiledDate,left,right)[7..8] in ['19','20'] => trim(l.FiledDate,left,right)[7..10] + trim(l.FiledDate,left,right)[1..2] +  trim(l.FiledDate,left,right)[4..5]  , 
	                                                  length(trim(l.FiledDate,left,right)) = 8 and trim(l.FiledDate,left,right)[5..6] in ['19','20'] => trim(l.FiledDate,left,right)[5..8] + trim(l.FiledDate,left,right)[1..2] + trim(l.FiledDate,left,right)[3..4] ,
																										'');
 self.entity_type_cd                             := trim(l.tiPartyType);
  self.entity_type_desc                          :=  map (l.tiPartyType = '1' =>  'Grantor',
                                                            l.tiPartyType = '2'=>  'Grantee',
                                                            l.tiPartyType = '3'=>  'Groom',
                                                            l.tiPartyType = '4'=>  'Bride',
                                                            l.tiPartyType = '5'=>  'Officer(Marriage=> ',
                                                            l.tiPartyType = '6'=>  'Proxy(Marriage=> ',
                                                            l.tiPartyType = '7'=>  'Child (Birth=> /Deceased',
                                                            l.tiPartyType = '8'=>  'Father (Birth/Death=> ',
                                                            l.tiPartyType = '9'=>  'Mother (Birth/Death=> ',
                                                            l.tiPartyType = '10'=>  'Witness (Marriage=> ',
                                                            l.tiPartyType = '15'=>  'Licensee',
                                                            l.tiPartyType = '16'=>  'Defendant',
                                                            l.tiPartyType = '17'=>  'Plaintiff',
                                                            l.tiPartyType = '18'=>  'Def. Attorney',
                                                            l.tiPartyType = '19'=>  'Plaint. Attorney',
                                                            l.tiPartyType = '20'=>  'Debtor',
                                                            l.tiPartyType = '21'=>  'Secured Party',
                                                            l.tiPartyType = '22'=>  'DBA',
                                                            l.tiPartyType = '23'=>  'Owner',
                                                            l.tiPartyType = '24'=>  'Pistol Assoc.',
                                                            l.tiPartyType = '25'=>  'Spouse (Death) '
																														,'');


  
  self.entity_nm_format                            := 'L';
  self.doc_instrument_or_clerk_filing_num           := trim(l.sDocumentNO,left,right);
  self.doc_type_desc                               := trim(l.sInstrumentType,left,right);
  self.entity_nm                                   := trim(l.sNameLast) + ' '+ trim(l.sNameFirst) + ' ' + trim(l.sNameMiddle) [1..80];
end;
  
  File_party_monroe := project(File_In_FL_Monroe,tr_monroeparty_final(LEFT));
sort_party_monroe := sort(File_party_monroe,record);
dedp_monroe_party := dedup(sort_party_monroe,all);
  official_records.MAC_Name_Clean(dedp_doc_monroe,dedp_monroe_party,'fl','monroe',filedate,out);
succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl monroe done '+official_records.Version_Development , 
						'Official Records mapping fl monroe completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping fl monroe failed '+official_records.Version_Development , 
						'Official Records mapping fl monroe failed. Please view  WU-ID: ' + Thorlib.WUID( ));		
						
out_monroe := sequential(out) : success(succmail),failure(fmail);
 
 return out_monroe;
 end;
 

 