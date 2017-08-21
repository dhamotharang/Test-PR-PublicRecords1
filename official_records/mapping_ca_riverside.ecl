import lib_stringlib;
export mapping_ca_riverside(string filedate) := function
    
official_records.Layout_In_preclean_document map2riverdoc(File_In_CA_Riverside l) := transform
  self.process_date                        := filedate;
  self.vendor                              := '17';
  self.state_origin                        := 'CA';
  self.county_name                         := 'RIVERSIDE';
  self.official_record_key                 := '17' + trim(l.DocNumber,left,right) + trim(l.DocType,left,right);
  self.fips_st                             := '06';
  self.fips_county                         := '065';
  self.doc_filed_dt                        := fSlashedMDYtoYMD(l.RecordingDate[1..(lib_stringlib.stringlib.stringfind(l.RecordingDate, ' ',1) - 1)]);
  self.doc_record_dt                       := fSlashedMDYtoYMD(l.RecordingDate[1..(lib_stringlib.stringlib.stringfind(l.RecordingDate, ' ',1) - 1)]);
  self.doc_type_cd                         := l.DocType[1..5];
  self.doc_type_desc                       :=trim(get_ca_riverside( l.DocType));
  self.doc_instrument_or_clerk_filing_num  := trim(l.DocNumber,left,right);
  self.doc_page_count                      := l.NumOfPages;

end;

dJcodedesc := project(File_In_CA_Riverside, map2riverdoc(LEFT));

sort_riverside := sort(dJcodedesc,record);
dUniquedoc := dedup(sort_riverside,all);

dPartyWithGrantor := File_In_CA_Riverside(Grantor <> '');

 
official_records.Layout_In_preclean_party map2rptygnt(dPartyWithGrantor l) := transform
  self.process_date                          := filedate;
  self.vendor                                := '17';
  self.state_origin                          := 'CA';
  self.county_name                           := 'RIVERSIDE' ;
  self.official_record_key                   := '17' + trim(l.DocNumber,left,right) + trim(l.DocType,left,right);
  self.doc_filed_dt                          := fSlashedMDYtoYMD(l.RecordingDate[1..(lib_stringlib.stringlib.stringfind(l.RecordingDate, ' ',1) - 1)]);
  self.doc_type_desc                         := trim(get_ca_riverside( l.DocType ));
  self.doc_instrument_or_clerk_filing_num    := trim(l.DocNumber,left,right);
  self.entity_type_cd                        := 'Grantor';
  self.entity_type_desc                      := 'Grantor';
  self.entity_nm                             := l.Grantor;
  self.entity_nm_format                      := 'L';

end;
 
dPartyJoinWithGrantor := project(dPartyWithGrantor,map2rptygnt(LEFT));
                    
 
  
  
dPartyWithGrantee := File_In_CA_Riverside(Grantee <> '');

 
official_records.Layout_In_preclean_party map2rptygntee(dPartyWithGrantee l) := transform
  self.process_date                          := filedate;
  self.vendor                                := '17';
  self.state_origin                          := 'CA';
  self.county_name                            := 'RIVERSIDE' ;
  self.official_record_key                   := '17' + trim(l.DocNumber,left,right) + trim(l.DocType,left,right);
  self.doc_filed_dt                          := fSlashedMDYtoYMD(l.RecordingDate[1..(lib_stringlib.stringlib.stringfind(l.RecordingDate, ' ',1) - 1)]);
  self.doc_type_desc                         := trim(get_ca_riverside( l.DocType ));
  self.doc_instrument_or_clerk_filing_num    := trim(l.DocNumber,left,right);
  self.entity_type_cd                        := 'Grantee';
  self.entity_type_desc                      := 'Grantee';
  self.entity_nm                             := l.Grantee;
  self.entity_nm_format                      := 'L';

end;
   dJoinPartyWithGrantee := project(dPartyWithGrantee,map2rptygntee(LEFT));

	
dJoinAll := dPartyJoinWithGrantor + dJoinPartyWithGrantee;

  
sort_party_riverside := sort(dJoinAll,record);
dUniqueParty := dedup(sort_party_riverside,all);

official_records.MAC_Name_Clean(dUniquedoc,dUniqueParty,'ca','riverside',filedate,out);


succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping ca riverside done '+official_records.Version_Development , 
						'Official Records mapping ca riverside completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping ca riverside failed '+official_records.Version_Development , 
						'Official Records mapping ca riverside failed. Please view  WU-ID: ' + Thorlib.WUID( ));						
out_ca_riverside := sequential(out) : success(succmail),failure(fmail);
 return out_ca_riverside;
 end;
