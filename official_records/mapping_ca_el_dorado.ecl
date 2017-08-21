import lib_stringlib,ut,Address,lib_fileservices;

export mapping_ca_el_dorado(string filedate) := function

  official_records.Layout_In_preclean_document map2elrdoc(File_In_CA_Eldorado l) := transform
  self.process_date               := filedate;                                                      
  self.vendor                     := '04';                                                          
  self.state_origin               := 'CA';                                                          
  self.county_name                := 'EL DORADO';                                                   
  self.official_record_key        := '04' + trim(l.document_number,left,right) + trim(l.date_filed);
  self.fips_st                    := '06';                                                          
  self.fips_county                := '017';                                                         
  self.doc_instrument_or_clerk_filing_num := trim(l.document_number,left,right);                    
  self.book_num                  := l.book;                                                         
  self.page_num                   := l.page;                                                        
  self.doc_filed_dt               := l.date_filed;                                                  
  self.doc_record_dt              := l.date_filed;                                                  
  self.doc_type_cd                := trim(l.document_title)[1..5];                                  
  self.doc_type_desc              := get_ca_eldorado( trim(l.document_title));                                                 
                                      
end;


dJcodedesc := project(File_In_CA_Eldorado,map2elrdoc(LEFT));

sort_eldorado := sort(dJcodedesc,record);
dUniquedoc := dedup(sort_eldorado,all);
 
official_records.Layout_In_preclean_party map2elrpty(File_In_CA_Eldorado l) := transform
  self.process_date                    := filedate;
  self.vendor                          := '04';
  self.state_origin                    := 'CA';
  self.county_name                     := 'EL DORADO';
  self.official_record_key             := '04' + trim(l.document_number,left,right) + trim(l.date_filed);
  self.doc_instrument_or_clerk_filing_num := trim(l.document_number,left,right);
  self.doc_filed_dt                    := l.date_filed;
  self.doc_type_desc                   := get_ca_eldorado( trim(l.document_title));
  self.entity_type_cd                  := l.grantee;
  self.entity_type_desc                := if (l.grantee = 'E','Grantee','Grantor');
  self.entity_nm                       := trim(l.name1,left,right) + if(l.name1_etal =  'E' , ' ETAL',' ');
  self.entity_nm_format                := 'L';
end;

pJcodedesc := project(File_In_CA_Eldorado,map2elrpty(LEFT));

  
  
sort_party_eldorado := sort(pJcodedesc,record);
dUniqueParty := dedup(sort_party_eldorado,all);



official_records.MAC_Name_Clean(dUniquedoc,dUniqueParty,'ca','el_dorado',filedate,out);

succmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping ca eldorado done '+official_records.Version_Development , 
						'Official Records mapping ca eldorado completed successfully. Please view  WU-ID: ' + Thorlib.WUID( ));
						
fmail := FileServices.SendEmail('skasavajjala@seisint.com','Official Records -  mapping ca eldorado failed '+official_records.Version_Development , 
						'Official Records mapping ca eldorado failed. Please view  WU-ID: ' + Thorlib.WUID( ));						
out_ca_eldorado := sequential(out) : success(succmail),failure(fmail);

return out_ca_eldorado;

end;

