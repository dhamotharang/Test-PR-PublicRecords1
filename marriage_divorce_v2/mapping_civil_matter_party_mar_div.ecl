/*2008-02-20T21:33:00Z (Khurram Humayun_Prod)

*/
import ut;

myregex := '^[^,-]*[,-](.*)$'; 

// transform that maps the raw input files into an intermediate layout.
marriage_divorce_v2.layout_mar_div_intermediate t_map_to_common(marriage_divorce_v2.File_Civil_Matter_Party_Mar_Div_In le) := transform
 
 string100 v_party1_name := stringlib.stringcleanspaces(le.e1_lname1+le.e1_fname1+le.e1_mname1+le.e1_suffix1);
 string100 v_party2_name := stringlib.stringcleanspaces(le.e2_lname1+le.e2_fname1+le.e2_mname1+le.e2_suffix1);
 
 string v_Party1_Type:=marriage_divorce_V2.fn_civ_partyTypeLookup(le.entity_type_description_1_orig);
 string v_Party2_Type:=marriage_divorce_V2.fn_civ_partyTypeLookup(le.entity2_type_description_2_orig);
 boolean unknown_Type:=(v_Party1_Type='P' and v_Party2_Type='P') or
												(v_Party1_Type='H' and v_Party2_Type='H') or
                        (v_Party1_Type='M' and v_Party2_Type='M')or
												(v_Party1_Type='D' and v_Party2_Type='D')or
												(v_Party1_Type='I' and v_Party2_Type='I')or
												(v_Party1_Type='N' and v_Party2_Type='N');
 //Not relevant because there's no address information
 self.dt_first_seen            := 0;
 self.dt_last_seen             := 0;
 self.dt_vendor_first_reported := (unsigned3)le.dt_first_reported[1..6];
 self.dt_vendor_last_reported  := (unsigned3)le.dt_last_reported[1..6];
 
 self.vendor       := 'CIV'+le.vendor;
 self.source_file  := 'CIV'+le.source_file;
 self.process_date := marriage_divorce_v2.process_date;
 self.state_origin := le.state_origin;

 
 
 self.filing_type  	 := if(trim(le.case_type) ='MARRIAGE','3','7');																	
 self.filing_subtype := if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'DISSOLUTION MINOR CHILDREN ','DISSO W/ MNR CHILDREN', 
					    if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'DISSO WITHOUT CHILDREN','DISSO W/0 CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITH UCCA','LSP W/ UCCA', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITH CHILDREN','LSP W/ CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'LEGAL SEPARATION WITHOUT CHILDREN','LSP W/O CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DISSOLUTION WITHOUT CHILDREN','X-DISSO W/O MNR CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DIVORCE WITHOUT CHILDREN','X-DIV W/O CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DISSOLUTION WITH CHILDREN','X-DISSO W/ CHILDREN', 
						if(stringlib.stringtouppercase(trim(le.entity_type_description_1_orig)) = 'EXTRA DR CODE - DIVORCE WITH CHILDREN ','X-DIV W/ CHILDREN',
						'')))))))));

 self.party1_type := if(unknown_Type,'U',if(v_party1_type in ['P','H','M'],v_party1_type,'U'));
 
 self.party1_name_format := if(trim(le.entity_nm_format_1) in ['L','U',''],'L','F');

 self.party1_name        		:= if(le.recordsWithMutiKeys = true,if(le.entity_1='','UNKNOWN',le.entity_1),
														   if(le.recordsWithMutiKeys = false and le.entity_1='','UNKNOWN',le.entity_1));

 self.party1_alias					:= if(le.entity_type_code_1_master='11' or le.entity_type_code_1_master='31',
																	le.entity1_alias,'');
 
 self.party1_dob	     := le.entity_1_dob;
 self.party1_age       := if(le.entity_1_dob <> '',(string2)ut.Age((Integer)le.entity_1_dob),'');
 self.party1_addr1 := marriage_divorce_v2.mod_parse_civil_addresses(le.entity_1_address_1,le.entity_1_address_2,le.entity_1_address_3,le.entity_1_address_4).parsed_addr;
 self.party1_csz   := marriage_divorce_v2.mod_parse_civil_addresses(le.entity_1_address_1,le.entity_1_address_2,le.entity_1_address_3,le.entity_1_address_4).parsed_csz;
 								     
 self.party2_type := if(unknown_Type,'U',if(v_party2_type in ['D','I','N'],v_party2_type,'U'));
 //if(v_party2_type not in ['D','I','N'],'U',v_party2_type);
 

 //use same format as entity1
 self.party2_name_format := self.party1_name_format;
 
 self.party2_name        		:= if(le.recordsWithMutiKeys = true,if(le.entity2='','UNKNOWN',le.entity2),
														   if(le.recordsWithMutiKeys = false and le.entity2='','UNKNOWN',le.entity2));
 

 self.party2_alias					:= if(le.entity_type_code_1_master='11' or le.entity_type_code_1_master='31',
																	le.entity2_alias,'');

 self.party2_dob   := le.entity_2_dob;
 self.party2_age   := if(le.entity_2_dob <> '',(string2)ut.Age((Integer)le.entity_2_dob),'');
 self.party2_addr1 := marriage_divorce_v2.mod_parse_civil_addresses(le.entity_2_address_1,le.entity_2_address_2,le.entity_2_address_3,le.entity_2_address_4).parsed_addr;
 self.party2_csz   := marriage_divorce_v2.mod_parse_civil_addresses(le.entity_2_address_1,le.entity_2_address_2,le.entity_2_address_3,le.entity_2_address_4).parsed_csz;

 self.marriage_filing_dt	 := if(trim(le.case_type) = 'MARRIAGE',le.filing_date,'');
 self.marriage_filing_number := if(trim(le.case_type) = 'MARRIAGE',le.case_number,'');
 self.marriage_county		 := if(trim(le.case_type) = 'MARRIAGE',
                               if(stringlib.stringtouppercase(trim(le.source_file))='CA-FRESNO-CO-CIV-CRT','FRESNO',
																	 if(stringlib.stringtouppercase(trim(le.source_file))='CA-FRESNO-CO-CIV-CRT','LOS ANGELES',
																	       regexreplace(myregex,le.court,'$1'))),'');

 
 
 self.divorce_filing_dt 	 := if(trim(le.case_type) != 'MARRIAGE',le.filing_date,'');
 self.divorce_filing_number	 := if(trim(le.case_type) != 'MARRIAGE',le.case_number,'');
 self.divorce_dt			 := le.disposition_date;
	
 self.divorce_county		 := if(trim(le.case_type) != 'MARRIAGE',
                               if(stringlib.stringtouppercase(trim(le.source_file))='CA-FRESNO-CO-CIV-CRT','FRESNO',
																	 if(stringlib.stringtouppercase(trim(le.source_file))='CA-LA-CNTY-CIV-COURT','LOS ANGELES',
																	       regexreplace(myregex,le.court,'$1'))),'');
 
 
 self.grounds_for_divorce := if(trim(le.case_type) != 'MARRIAGE',if(le.case_cause!='',le.case_cause,le.case_type),'');
 
 self := [];

end;


 civ_matr_pty_ds := project(marriage_divorce_v2.File_Civil_Matter_Party_Mar_Div_In,t_map_to_common(left)); 


export mapping_civil_matter_party_mar_div := civ_matr_pty_ds(state_origin !='CT'): persist('civil_matter_party_mar_div');