import ut;


myregex := '^[^,-]*[,-](.*)$'; 

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Civil_Matter_Party_Mar_Div_In le) := transform
 
 					
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := (unsigned3)le.dt_first_reported[1..6];
 self.dt_vendor_last_reported  := (unsigned3)le.dt_last_reported[1..6];
 

 self.filing_type  					:= if(le.case_type_code ='CL','3','7');
									
													
																	
 self.filing_subtype				:= if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'DISSOLUTION MINOR CHILDREN ','DISSO W/ MNR CHILDREN', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'DISSO WITHOUT CHILDREN','DISSO W/0 CHILDREN', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITH UCCA','LSP W/ UCCA', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITH CHILDREN','LSP W/ CHILDREN', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITHOUT CHILDREN','LSP W/O CHILDREN', 
														   if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DISSOLUTION WITHOUT CHILDREN','X-DISSO W/O MNR CHILDREN', 
													     if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DIVORCE WITHOUT CHILDREN','X-DIV W/O CHILDREN', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DISSOLUTION WITH CHILDREN','X-DISSO W/ CHILDREN', 
											         if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DIVORCE WITH CHILDREN ','X-DIV W/ CHILDREN','')))))))));

 
 
 self.vendor       					:= 'CIV'+le.vendor;
 self.source_file  					:= 'CIV'+le.source_file;
 self.process_date 					:= marriage_divorce_v2.process_date;
 self.state_origin 					:= le.state_origin;
 





//Entity1									     
 self.party1_type 					:= if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'PLAINTIFF','P', 
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'DEFENDANT','D',
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'PRIMARY PLANTIFF','H',
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'PRIMARY DEFENDANT','I',
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'PETITIONER','M',
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'RESPONDENT','N',
															 if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'OTHER','O','')))))));

 self.party1_name_format 		:= 'L';
 self.party1_name        		:= if(le.recordsWithMutiKeys = true,le.e1_lname1+le.e1_fname1+le.e1_mname1+le.e1_suffix1,
														   if(le.recordsWithMutiKeys = false and le.entity_1='','UNKNOWN',le.e1_lname1+le.e1_fname1+le.e1_mname1+le.e1_suffix1));

 self.party1_alias					:= if(le.entity_type_code_1_master='11' or le.entity_type_code_1_master='31',
																	le.e1_lname1+le.e1_fname1+le.e1_mname1+le.e1_suffix1,'UNKNOWN');
self.party1_dob			        := le.entity_1_dob;

self.party1_addr1						:=trim(le.entity_1_address_1)+trim(le.entity_1_address_2)+trim(le.entity_1_address_3)+trim(le.entity_1_address_4);





//Entity2										 

self.party2_type 					:=   if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'PLAINTIFF','P', 
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'DEFENDANT','D',
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'PRIMARY PLANTIFF','J',
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'PRIMARY DEFENDANT','I',
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'PETITIONER','M',
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'RESPONDENT','N',
															 if(stringlib.stringtouppercase(trim(le.entity2_type_description_2_orig)) = 'OTHER','O','')))))));

 self.party2_name_format 		:= 'L';
 self.party2_name        		:= if(le.recordsWithMutiKeys = true,le.e2_lname1+le.e2_fname1+le.e2_mname1+le.e2_suffix1,
														   if(le.recordsWithMutiKeys = false and le.entity2='','UNKNOWN',le.e2_lname1+le.e2_fname1+le.e2_mname1+le.e2_suffix1));

  self.party2_alias					:= if(le.entity2_type_code_2_master='11' or le.entity2_type_code_2_master='31',
																le.e2_lname1+le.e2_fname1+le.e2_mname1+le.e2_suffix1,'UNKNOWN');

 self.party2_dob			        := le.entity_2_dob;
 self.party2_addr1						:=trim(le.entity_2_address_1)+trim(le.entity_2_address_2)+trim(le.entity_2_address_3)+trim(le.entity_2_address_4);


 //marriage info
 self.marriage_filing_dt			:= if(le.case_type_code = 'CL',le.filing_date,'');
 self.marriage_filing_number	:= if(le.case_type_code = 'CL',le.case_number,'');
 self.marriage_county				  := if(le.case_type_code = 'CL',regexreplace(myregex,le.court,'$1'),'');
//divorce																		
 self.divorce_filing_dt 		  := if(le.case_type_code != 'CL',le.filing_date,'');
 self.divorce_filing_number	  := if(le.case_type_code != 'CL',le.case_number,'');
 self.divorce_dt						  := le.disposition_date;
 self.divorce_county				  := if(le.case_type_code = 'CL',regexreplace(myregex,le.court,'$1'),'');
 
 self := [];

end;


 civ_matr_pty_ds := project(marriage_divorce_v2.File_Civil_Matter_Party_Mar_Div_In,t_map_to_common(left)); 



export mapping_civil_matter_party_mar_div := civ_matr_pty_ds(state_origin !='CT' and filing_type !='3') : persist('civil_matter_party_mar_div');




