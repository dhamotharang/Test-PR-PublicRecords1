import ut;

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Official_Mar_Div_Records_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := 0;
 self.dt_vendor_last_reported  := 0;
 

 self.filing_type  					:= le.filing_type;
 self.filing_subtype				:= le.doc_type_desc;
 self.vendor       					:= 'OFR'+le.vendor;
 self.source_file  					:= 'OFR-'+le.state_origin+'-'+le.county_name[1..18];
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= le.state_origin;
 


//Entity1									  R = grantor T = grantee
 self.party1_type 					:= if(le.master_party_type_cd='1','R',
															 if(le.master_party_type_cd='5','T',''));
 															     
 self.party1_name_format 		:= 'L';
 self.party1_name        		:= if(le.entity_nm != '',le.entity_nm,'UNKNOWN');	

 

//Entity2										 R = grantor T = grantee	

 self.party2_type 					:= if(le.master_party_type_cd2='1','R',
															 if(le.master_party_type_cd2='5','T',''));
 self.party2_name_format 		:= 'L';
 self.party2_name        		:= if(le.entity_nm2 != '',le.entity_nm2,'UNKNOWN');	



 //marriage info
 self.marriage_filing_dt			:= if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'MARRIAGE' or 
																    stringlib.stringtouppercase(trim(le.doc_type_desc))  = 'DECLARATION MARRIAGE',le.doc_filed_dt,'');
 
 self.marriage_county			  	:= if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'MARRIAGE' or
																    stringlib.stringtouppercase(trim(le.doc_type_desc))  = 'DECLARATION MARRIAGE',le.county_name,'');
 
 self.marriage_filing_number	:= if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'MARRIAGE' or
																		stringlib.stringtouppercase(trim(le.doc_type_desc))  = 'DECLARATION MARRIAGE',le.doc_instrument_or_clerk_filing_num,'');

//divorce info
 self.divorce_filing_dt				:= if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'INTERLOCUTORY DIVORCE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'DISSOLUTION MARRIAGE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'FINAL DIVORCE',le.doc_filed_dt,'');
																 
 self.divorce_county 				  := if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'INTERLOCUTORY DIVORCE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'DISSOLUTION MARRIAGE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'FINAL DIVORCE',le.county_name,'');
 
 self.divorce_filing_number		:= if(stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'INTERLOCUTORY DIVORCE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'DISSOLUTION MARRIAGE' or
																			stringlib.stringtouppercase(trim(le.doc_type_desc)) = 'FINAL DIVORCE',le.doc_instrument_or_clerk_filing_num,'');
 
 self := [];

 
end;

export mapping_official_mar_div_records := project(marriage_divorce_v2.File_Official_Mar_Div_Records_In,t_map_to_common(left)) : persist('official_mar_div_records');



