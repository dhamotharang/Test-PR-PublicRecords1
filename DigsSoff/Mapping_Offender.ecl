/*
**********************************************************************************
Created by    Comments
Vani 					This attribute joins all the denomalized pieces and creates a complete 
              record in OKc layout to be used by the existing Sex Pred process. 
							
***********************************************************************************
*/	


import Lib_StringLib;


			  
//temp_source := dataset([
// {72,'NV','Nevada Sex Offender'},
// {7,'NV159915439','5469 GREEN PALMS Other'}],Layout_Soff_Source_Lookup);
DS_Suffixes										:= ['(JR)','(SR)','(I)','(II)','(III)','(IV)','(V)'];	
DOffenderData      	 := DISTRIBUTE(File_soff_offender(not (src_id ='21' and trim(registration_type)='Violent')), HASH32(File_soff_offender.id)); 
SortedSourceTable    := SORT(File_Soff_Source_lookup,src_id);     
SortedOffenderTable  := SORT(DOffenderData,src_id,LOCAL);     

//output(count(File_soff_Alias));

Layout_Target_OKC_Layout Transform_offender(Layout_soff_offender R,Layout_Soff_Source_Lookup L ) := TRANSFORM

    varstring v_name_temp    := trim(IF (R.last   <> '',     trim(R.last)  ,'')+','+
                                     IF (R.first  <> '', ' '+trim(R.first) ,'')+
                                     IF (R.middle <> '', ' '+trim(R.middle),''),LEFT,RIGHT);
		varstring p_orig_name    := IF(v_name_temp <> ',' AND v_name_temp <> '' ,StringLib.StringToUpperCase(v_name_temp),
		                                                                         StringLib.StringToUpperCase(trim(R.name)));
 
	 //---------------Extract Alias -----------
		varstring v_alias_matchstr1   := regexfind('AKA [(]+[a-zA-z,. ]*[)]+',p_orig_name,0);
		varstring v_alias_matchstr2   := regexfind('[(]+AKA [a-zA-z,. ]*[)]+',p_orig_name,0);
    varstring v_alias_matchstr3   := regexfind('[(]+[a-zA-z,. ]*[)]+',p_orig_name,0);
	 			
		Varstring RegxAlias           := MAP (v_alias_matchstr1 <> '' and v_alias_matchstr2 <> '' => v_alias_matchstr1[6..]+';'+v_alias_matchstr2[6..],
		                                      v_alias_matchstr1 <> '' and v_alias_matchstr2 ='' => v_alias_matchstr1[6..],
																					v_alias_matchstr2 <> '' and v_alias_matchstr1 ='' => v_alias_matchstr2[6..],
																					v_alias_matchstr3 <> '' and StringLib.stringtouppercase(v_alias_matchstr3) NOT IN DS_Suffixes => v_alias_matchstr3,'');
									
    Varstring RegxName1           := IF (v_alias_matchstr1 <> '' , StringLib.StringFindReplace(p_orig_name,v_alias_matchstr1,''),p_orig_name );
		Varstring RegxName2           := IF (v_alias_matchstr2 <> '' , StringLib.StringFindReplace(RegxName1,v_alias_matchstr2,'' ),RegxName1);
		Varstring RegxName3           := IF (v_alias_matchstr2 = '' and 
		                                     v_alias_matchstr1 = '' and 
																				 v_alias_matchstr3 <>'' and 
																				 StringLib.stringtouppercase(v_alias_matchstr3) NOT IN DS_Suffixes ,StringLib.StringFindReplace(RegxName2,v_alias_matchstr3,'') ,RegxName2);
		
		//2 Separate the AKA 																																					 
		integer alias_AKA_cnt			    := StringLib.StringFind(p_orig_name,' AKA ',1);
		Varstring v_AKA_fullname      := IF( alias_AKA_cnt> 0,p_orig_name[1..alias_AKA_cnt-1], '');	
		varstring v_AKA_alias         := IF( alias_AKA_cnt> 0,p_orig_name[alias_AKA_cnt+5..], '');	
		
		//3 Alias in ( and )		
    integer alias_openbraces_cnt	:=  StringLib.StringFind(p_orig_name,'(',1);
		integer alias_Closnbraces_cnt	:=  StringLib.StringFind(p_orig_name,')',1);
		varstring v_bracesFullname1   := trim(IF( alias_openbraces_cnt > 0,p_orig_name[1..alias_openbraces_cnt-1],''),LEFT,RIGHT);	
		varstring v_bracesFullname2   := trim(IF( alias_Closnbraces_cnt> 0,p_orig_name[alias_Closnbraces_cnt+1..],''),LEFT,RIGHT);	
		varstring v_bracesFullName    := trim(v_bracesFullname1+' '+v_bracesFullname2,LEFT,RIGHT); 
		varstring v_bracesalias       := IF( alias_openbraces_cnt > 0 ,
		                                                   IF (alias_Closnbraces_cnt> 0, p_orig_name[alias_openbraces_cnt+1..alias_Closnbraces_cnt-1], 
																											                               p_orig_name[alias_openbraces_cnt+1..]),
																											 '');		
   
	  varstring v_FullNameFinal     := MAP (alias_openbraces_cnt > 0 and  RegxName3 <> '' => StringLib.StringFindReplace(RegxName3,'  ',' ')+';'+StringLib.StringFilterOut(RegxAlias,'()'),
		                                      alias_openbraces_cnt > 0 and  v_bracesFullName <> '' => v_bracesFullName+';'+v_bracesalias, 
		                                      alias_openbraces_cnt = 0 and  v_AKA_fullname <> '' => v_AKA_fullname+';'+v_AKA_alias,
																					p_orig_name+';');	
		
		
    integer   v_ParsedNameAlias_sep  :=  StringLib.StringFind(v_FullNameFinal,';',1);
    v_fullname                := v_FullNameFinal[1..v_ParsedNameAlias_sep-1];
		
		v_aliasname               := v_FullNameFinal[v_ParsedNameAlias_sep+1..];  
		string OffenderStatTemp   := MAP( length(R.current_state) > 50 and REGEXFIND('in a correctional facility', R.current_state)  => 'INCARCERATED',
                                      length(R.current_state) > 50 and REGEXFIND('is in compliance', R.current_state) =>  'IN COMPLIANCE',
																			length(R.current_state) > 50 and REGEXFIND('currently out of compliance', R.current_state) =>  'NON COMPLIANT',
																			length(R.current_state) > 50 and REGEXFIND('Location UnknownOffender has fled the address',R.current_state) => 'ABSCONDED',
																			trim(R.current_state) ='Status of Warrant Subject to Change: n/a' => '',
																			trim(R.current_state)
																	  );			
		string v_custody_status   := MAP( trim(R.custody_status) = 'Yes' => '',
		                                  trim(R.custody_status));
		integer addl1_cnt := 				StringLib.StringFind(R.notes,'ADDL1:',1);
    integer addl2_cnt := 				StringLib.StringFind(R.notes,'ADDL2:',1);														
   
		SELF.source					        := L.source_name;
		SELF.date_added			        := R.insert_date[1..4]+R.insert_date[6..7]+R.insert_date[9..10];
		SELF.date_updated   		    := R.insert_date[1..4]+R.insert_date[6..7]+R.insert_date[9..10];
		SELF.state_of_origin        := L.src_state;
		SELF.name_orig			        := v_fullname;
		SELF.name_aka	              := v_aliasname;
		SELF.offender_status        := trim(trim(OffenderStatTemp)+' '+v_custody_status,LEFT,RIGHT);

    String  v_offender_category:= MAP(R.offender_category ='Offender is Incarcerated' => 'INCARCERATED',
		                                  R.offender_category ='Offender is Compliant' => 'COMPLIANT',
																			R.offender_category ='Offender is NOT Compliant' => 'NON-COMPLIANT',
																			R.offender_category );
																						 
	  string  v_other_offender_category := MAP(
		                                         StringLib.stringtouppercase(R.predator) IN ['Y','YES'] => 'SEXUAL PREDATOR', 
																						 StringLib.stringtouppercase(R.predator) IN ['N','NO'] => '',
																						 R.predator);

		SELF.offender_category      := IF (v_offender_category <> '', IF (V_other_offender_category <> '' and 
		                                                                  (not regexfind('PREDATOR', StringLib.stringtouppercase(R.offender_category))), trim(v_offender_category)+';'+V_other_offender_category,
		                                                                                                   trim(v_offender_category)),
																																	V_other_offender_category);																		 
		SELF.risk_level_code        := trim(R.risk_level)+trim(R.tier_level);
		SELF.risk_description       := trim(R.risk_description);
		SELF.police_agency          := trim(R.registering_agency);
		SELF.police_agency_contact_name:= IF (trim(R.police_agency_contact_name)='Offender currently incarcerated','', trim(R.police_agency_contact_name)) ;
		SELF.police_agency_address_1   := trim(R.police_agency_address_1);
		SELF.police_agency_address_2   := trim(R.police_agency_address_2);
		SELF.police_agency_phone       := StringLib.StringFilterOut(trim(R.police_agency_phone), '()- ');
		SELF.registration_type         := trim(R.registration_type);
		
		varstring temp_reg_date1:= MAP(R.registration_date <> '' => 'REGISTRATION DATE;'+trim(R.registration_date),
                                   R.re_registration_dt<> '' => 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt),
                                   R.reg_exp_date      <> '' => 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date),
                                   R.last_contact_date <> '' => 'LAST CONTACT DATE;'+trim(R.last_contact_date),
                                   R.date_value_1  <> ''     => trim(R.date_type_1)+';'+trim(R.date_value_1),
                                   R.date_value_2  <> ''     => trim(R.date_type_2)+';'+trim(R.date_value_2),
                                   ''); 
		varstring temp_reg_date2:= MAP(    R.re_registration_dt<> '' 
		                               and temp_reg_date1      <> 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt) => 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt),
                                       R.reg_exp_date      <> '' 
																	 and temp_reg_date1      <> 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date)=> 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date),
                                       R.last_contact_date <> '' 
																	 and temp_reg_date1      <> 'LAST CONTACT DATE;'+trim(R.last_contact_date)=> 'LAST CONTACT DATE;'+trim(R.last_contact_date),
                                       R.date_value_1      <> '' 
																	 and temp_reg_date1      <> trim(R.date_type_1)+';'+trim(R.date_value_1)=> trim(R.date_type_1)+';'+trim(R.date_value_1),
                                       R.date_value_2      <> '' 
																	 and temp_reg_date1      <> trim(R.date_type_2)+';'+trim(R.date_value_2)=> trim(R.date_type_2)+';'+trim(R.date_value_2),
                                   '');
																	 
 varstring temp_reg_date3:= MAP(       R.re_registration_dt<> ''
		                               and temp_reg_date1      <> 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt)
																	 and temp_reg_date2      <> 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt) => 'RE-REGISTRATION DATE;'+trim(R.re_registration_dt),
                                       R.reg_exp_date      <> '' 
																	 and temp_reg_date1      <> 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date)
																	 and temp_reg_date2      <> 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date) => 'REGISTRATION EXPIRATION INFO;'+trim(R.reg_exp_date),
                                       R.last_contact_date <> '' 
																	 and temp_reg_date1      <> 'LAST CONTACT DATE;'+trim(R.last_contact_date)
																	 and temp_reg_date2      <> 'LAST CONTACT DATE;'+trim(R.last_contact_date)  => 'LAST CONTACT DATE;'+trim(R.last_contact_date),
                                       R.date_value_1      <> '' 
																	 and temp_reg_date1      <> trim(R.date_type_1)+';'+trim(R.date_value_1)
																	 and temp_reg_date2      <> trim(R.date_type_1)+';'+trim(R.date_value_1)    => trim(R.date_type_1)+';'+trim(R.date_value_1),
                                       R.date_value_2      <> '' 
																	 and temp_reg_date1      <> trim(R.date_type_2)+';'+trim(R.date_value_2)
																	 and temp_reg_date2      <> trim(R.date_type_2)+';'+trim(R.date_value_2)    => trim(R.date_type_2)+';'+trim(R.date_value_2),
                                   '');	
    integer regdate1_cnt    := StringLib.StringFind(temp_reg_date1,';',1)	;																 
		SELF.reg_date_1         := temp_reg_date1[regdate1_cnt+1..]; 		                              
		SELF.reg_date_1_type    := temp_reg_date1[1..regdate1_cnt-1];
		
/*		                             if (temp_reg_date1 <>'' ,
		                               MAP(temp_reg_date1 = trim(R.registration_date)  => 'Registration Date',
                                       temp_reg_date1 = trim(R.re_registration_dt) => 'Re-Registration Date',
                                       temp_reg_date1 = trim(R.reg_exp_date)       => 'Registration Expiration Info',
                                       temp_reg_date1 = trim(R.last_contact_date)  => 'Last contact date',
                                       temp_reg_date1 = trim(R.date_value_1)       => trim(R.date_type_1),
                                       temp_reg_date1 = trim(R.date_value_2)       => trim(R.date_type_2),
                                       ''),''
																	);*/
		integer regdate2_cnt    := StringLib.StringFind(temp_reg_date2,';',1)		;													 
		SELF.reg_date_2         := temp_reg_date2[regdate2_cnt+1..];
		SELF.reg_date_2_type    := temp_reg_date2[1..regdate2_cnt-1];
		/*if (temp_reg_date2 <>'' ,
		                               MAP(temp_reg_date2 = trim(R.registration_date)  => 'Registration Date',
                                       temp_reg_date2 = trim(R.re_registration_dt) => 'Re-Registration Date',
                                       temp_reg_date2 = trim(R.reg_exp_date)       => 'Registration Expiration Info',
                                       temp_reg_date2 = trim(R.last_contact_date)  => 'Last contact date',
                                       temp_reg_date2 = trim(R.date_value_1)       => trim(R.date_type_1),
                                       temp_reg_date2 = trim(R.date_value_2)       => trim(R.date_type_2),
                                       ''),''
																	);*/
		integer regdate3_cnt    := StringLib.StringFind(temp_reg_date3,';',1)		;																				
		SELF.reg_date_3         := temp_reg_date3[regdate3_cnt+1..];
		SELF.reg_date_3_type    := temp_reg_date3[1..regdate3_cnt-1];
		/*if (temp_reg_date3 <>'' ,
		                               MAP(temp_reg_date3 = trim(R.registration_date)  => 'Registration Date',
                                       temp_reg_date3 = trim(R.re_registration_dt) => 'Re-Registration Date',
                                       temp_reg_date3 = trim(R.reg_exp_date)       => 'Registration Expiration Info',
                                       temp_reg_date3 = trim(R.last_contact_date)  => 'Last contact date',
                                       temp_reg_date3 = trim(R.date_value_1)       => trim(R.date_type_1),
                                       temp_reg_date3 = trim(R.date_value_2)       => trim(R.date_type_2),
                                       ''),''
																	);*/
		varstring  v_offender_id_temp := MAP (R.sor_number <> '' and R.offender_id <> '' and R.sor_number = R.offender_id => trim(R.sor_number),
		                                      R.sor_number <> '' and R.offender_id <> '' and R.sor_number <> R.offender_id => trim(R.sor_number)+';'+R.offender_id,
		                                      R.sor_number <> '' and R.offender_id = ''  => trim(R.sor_number),
																					R.sor_number =  '' and R.offender_id <> '' => trim(R.offender_id), '');
																					
		integer OFID_colon_pos_cnt    := StringLib.StringFind(v_offender_id_temp,':',1);			
		SELF.offender_id              := IF (OFID_colon_pos_cnt >0 , v_offender_id_temp[OFID_colon_pos_cnt+1..],v_offender_id_temp);
		SELF.doc_number               := trim(R.doc_number);
		SELF.sor_number               := trim(R.id);
		SELF.st_id_number             := trim(R.st_id_number);
		SELF.fbi_number               := trim(R.fbi_number);
		SELF.ncic_number              := trim(R.ncic_number);
		SELF.orig_ssn                 := trim(R.orig_ssn);
		SELF.date_of_birth            := trim(R.DOB);
		SELF.date_of_birth_aka        := trim(R.alias_dob);
		SELF.age                      := trim(R.age);
		SELF.dna                      := trim(R.dna);
		SELF.race                     := IF(trim(R.race)   in Invalid_values,'',trim(R.race));
		SELF.ethnicity                := trim(R.ethnicity);
		SELF.sex                      := trim(R.sex);
		SELF.hair_color               := IF(trim(R.hair)   in Invalid_values,'',trim(R.hair));
		SELF.eye_color                := IF(trim(R.eyes)   in Invalid_values,'',trim(R.eyes));
		SELF.height                   := IF(trim(R.height) in Invalid_values,'',trim(R.height));
		SELF.weight                   := IF(trim(R.weight) in Invalid_values,'',trim(R.weight));
		SELF.skin_tone                := IF(trim(R.skin)   in Invalid_values,'',trim(R.skin));
		SELF.build_type               := trim(R.build_desc);

		SELF.shoe_size                := trim(R.shoe_size);
		SELF.corrective_lense_flag    := trim(R.corrective_lens);
		STRING v_Addl_comment_1_temp  := StringLib.StringFilterOut(
		                                   IF(addl1_cnt >0, IF (addl2_cnt >0 , trim(R.Notes[addl1_cnt+6..addl2_cnt-1],LEFT,RIGHT),
																													                 trim(R.Notes[addl1_cnt+6..],LEFT,RIGHT)
																													  ),''
																				 ),'*' );	 
		SELF.addl_comments_1          := MAP (    v_Addl_comment_1_temp <> '' => v_Addl_comment_1_temp, 
		                                          R.place_of_birth      <> '' => 'BIRTH PLACE: '+trim(R.place_of_birth),
																					    addl1_cnt=0 and addl2_cnt =0 
																					and R.notes <> '' and r.notes[1..5] = 'ADDL1'=> trim(R.notes[6..]),
																					    addl1_cnt=0 and addl2_cnt =0 
																					and R.notes <> '' and r.notes[1..5] <> 'ADDL1'=> trim(R.notes),
																					'');
		STRING v_Addl_comment_2_temp  := trim(StringLib.StringFilterOut(
		                                        IF (addl2_cnt >0 , R.Notes[addl2_cnt+6..],''),'*' ),LEFT,RIGHT);																		
																						
		SELF.addl_comments_2          := MAP(    v_Addl_comment_2_temp <> '' => v_Addl_comment_2_temp,
		                                         v_Addl_comment_1_temp <> '' 
																				 and R.place_of_birth <> ''      => 'BIRTH PLACE: '+trim(R.place_of_birth), 
																				 '');
		
		SELF.orig_dl_number           := trim(R.orig_dl_number);
		SELF.orig_dl_state            := trim(R.orig_dl_state);
		SELF.orig_dl_link             := trim(R.orig_dl_link);
		SELF.orig_dl_date             := trim(R.orig_dl_date);
		SELF.passport_type            := trim(R.passport_type);
		SELF.passport_code            := trim(R.passport_code);
		SELF.passport_number          := trim(R.passport_number);
		SELF.passport_first_name      := trim(R.passport_first_name);
		SELF.passport_given_name      := trim(R.passport_given_name);
		SELF.passport_nationality	    := trim(R.passport_nationality);
		SELF.passport_dob             := trim(R.passport_dob);
		SELF.passport_place_of_birth  := trim(R.passport_place_of_birth);
		SELF.passport_sex             := trim(R.passport_sex);
		SELF.passport_issue_date      := trim(R.passport_issue_date);
		SELF.passport_authority       := trim(R.passport_authority);
		SELF.passport_expiration_date := trim(R.passport_expiration_date);
		SELF.passport_endorsement     := trim(R.passport_endorsement);
		SELF.passport_link            := trim(R.passport_link);
		SELF.passport_date            := trim(R.passport_date);
		
		SELF.fingerprint_link	        := trim(R.finger_print_link);
		SELF.fingerprint_date         := trim(R.finger_print_date);
		SELF.palmprint_link           := trim(R.palm_print_link);
		SELF.palmprint_date           := trim(R.palm_print_date);

		
end;
	 								

   OffenderDataInOKCLayout:= JOIN(SortedOffenderTable, 
                                SortedSourceTable, LEFT.src_id=RIGHT.src_id,
                                Transform_offender(LEFT,RIGHT),LEFT OUTER,LOOKUP,NOSORT);

	 DMugshot           		   := DISTRIBUTE(File_soff_mugshot,       HASH32(File_soff_Mugshot.id));
	 SortedMugshot             := SORT(DMugshot,id,-image_name,LOCAL);
   DSortedDedupedMugshot     := DEDUP(SortedMugshot,id,LOCAL);
	 DSortedDedupedOffAgency   := Mapping_Denorm_Arrest_Agency; 
	 DSortedDenormedAddress    := Mapping_Denorm_Address;
	 DSortedDenormedOffense    := Mapping_Denorm_Offense;
	 DSortedDenormedAttribute  := Mapping_Denorm_Attribute;
	 DSortedDenormedAlias      := Mapping_Denorm_Alias;
	 DSortedDenormedVehicle    := Mapping_Denorm_Vehicle;
	 DSortedOffenderData       := SORT(OffenderDataInOKCLayout,sor_number,LOCAL);	 
	 
Layout_Target_OKC_Layout Join_OffenseAgency(Layout_Target_OKC_Layout L, Layout_Denorm_Offense_agency R ) := TRANSFORM

    
		SELF.addl_comments_1 := IF (L.addl_comments_1 <> '' ,
		                                   IF(R.Arrest_agency <> '', L.addl_comments_1 +'; '+ trim(R.Arrest_agency) ,
																			                           L.addl_comments_1),
																			 trim(R.Arrest_agency));
		SELF.police_agency   := IF (L.police_agency <> '',L.police_agency	, trim(R.Police_agency));

    //SELF := R;
    SELF := L;
end;	 	
	 
	 
Layout_Target_OKC_Layout Join_address(Layout_Target_OKC_Layout L, Layout_Denorm_Address R ) := TRANSFORM
 //Following fields are getting popolated using R
 /*	SELF.intnet_email_address_1:= '';
		SELF.intnet_email_address_2:= '';
		SELF.intnet_email_address_3:= '';
		SELF.intnet_email_address_4:= '';
		SELF.intnet_email_address_5:= '';
		SELF.intnet_instant_message_addr_1:= '';
		SELF.intnet_instant_message_addr_2:= '';
		SELF.intnet_instant_message_addr_3:= '';
		SELF.intnet_instant_message_addr_4:= '';
		SELF.intnet_instant_message_addr_5:= '';
		SELF.intnet_user_name_1     := '';
		SELF.intnet_user_name_1_url := '';
		SELF.intnet_user_name_2     := '';
		SELF.intnet_user_name_2_url := '';
		SELF.intnet_user_name_3     := '';
		SELF.intnet_user_name_3_url := '';
		SELF.intnet_user_name_4     := '';
		SELF.intnet_user_name_4_url := '';
		SELF.intnet_user_name_5     := '';
		SELF.intnet_user_name_5_url := '';
    SELF.registration_address_1:= '';
		SELF.registration_address_2:= '';
		SELF.registration_address_3:= '';
		SELF.registration_address_4:= '';
		SELF.registration_address_5:= '';
		SELF.registration_county:= '';
		SELF.registration_home_phone:= '';
		SELF.registration_cell_phone:= '';
		SELF.other_registration_address_1:= '';
		SELF.other_registration_address_2:= '';
		SELF.other_registration_address_3:= '';
		SELF.other_registration_address_4:= '';
		SELF.other_registration_address_5:= '';
		SELF.other_registration_county:= '';
		SELF.other_registration_phone:= '';
		SELF.temp_lodge_address_1:= '';
		SELF.temp_lodge_address_2:= '';
		SELF.temp_lodge_address_3:= '';
		SELF.temp_lodge_address_4:= '';
		SELF.temp_lodge_address_5:= '';
		SELF.temp_lodge_county:= '';
		SELF.temp_lodge_phone:= '';
		SELF.employer:= '';
		SELF.employer_address_1:= '';
		SELF.employer_address_2:= '';
		SELF.employer_address_3:= '';
		SELF.employer_address_4:= '';
		SELF.employer_address_5:= '';
		SELF.employer_county:= '';
		SELF.employer_phone:= '';
		SELF.employer_comments:= '';
		SELF.professional_licenses_1:= '';
		SELF.professional_licenses_2:= '';
		SELF.professional_licenses_3:= '';
		SELF.professional_licenses_4:= '';
		SELF.professional_licenses_5:= '';
		SELF.school:= '';
		SELF.school_address_1:= '';
		SELF.school_address_2:= '';
		SELF.school_address_3:= '';
		SELF.school_address_4:= '';
		SELF.school_address_5:= '';
		SELF.school_county	 := '';
		SELF.school_phone		 := '';
		SELF.school_comments := '';*/
		SELF.employer_comments:= IF ( stringLib.StringFind(R.employer_comments,'Municipality:',1)>0, '',R.employer_comments);

		String V_additional_address_temp1 := R.Additional_address_reg +'; '+R.Additional_address_oth; 
		String V_additional_address       := IF (V_additional_address_temp1[1..2] = '; ', V_additional_address_temp1[3..2003],V_additional_address_temp1[1..2003]);
		SELF.addl_comments_1              := IF (L.addl_comments_1 <> '' ,L.addl_comments_1 ,V_additional_address);
		SELF.addl_comments_2              := IF (L.addl_comments_1 = '' OR 
		                                         trim(L.addl_comments_1) = trim(V_additional_address) OR
		                                         L.addl_comments_2 <> '',L.addl_comments_2 ,V_additional_address);
																
		string  v_RegAddrAsOfDate      := MAP (regexfind('Address As Of', R.registration_address_1) => trim(R.registration_address_1),
															  	 		     regexfind('Address As Of', R.registration_address_2) => trim(R.registration_address_2),
																		       regexfind('Address As Of', R.registration_address_3) => trim(R.registration_address_3),
																		       regexfind('Address As Of', R.registration_address_4) => trim(R.registration_address_4),
																		       regexfind('Address As Of', R.registration_address_5) => trim(R.registration_address_5),
 														               '');
		integer v_AOD_colon_pos        :=	StringLib.StringFind(v_RegAddrAsOfDate,':',1);															
		string  v_asofdate             := IF ( v_AOD_colon_pos >0 , v_RegAddrAsOfDate[v_AOD_colon_pos+1..],'');
		string  v_asofdate_type        := IF ( v_AOD_colon_pos >0 , v_RegAddrAsOfDate[1..v_AOD_colon_pos-1],'');
		
		SELF.reg_date_1                := IF (L.reg_date_1 <> '', L.reg_date_1, v_asofdate);
		SELF.reg_date_1_type 		       := IF (L.reg_date_1 <> '', L.reg_date_1_type,
		                                                                IF(v_asofdate_type<>'', 'REG '+v_asofdate_type,''));																																			
																																		
    SELF.reg_date_3                := IF (L.reg_date_3 <> '' or 
		                                       ( trim(L.reg_date_1+L.reg_date_1_type) = trim(v_asofdate)+'REG '+v_asofdate_type or 
																						trim(L.reg_date_1) = ''), L.reg_date_3, v_asofdate);
		SELF.reg_date_3_type 		       := IF (L.reg_date_3 <> '' or
		                                       ( trim(L.reg_date_1+L.reg_date_1_type) = trim(v_asofdate)+'REG '+v_asofdate_type or 
																						trim(L.reg_date_1) = '') , L.reg_date_3_type,IF(v_asofdate_type<>'', 'REG '+v_asofdate_type,'')
		                                                                );														
		
 SELF := R;
 SELF := L;
end;	
   	 
Layout_Target_OKC_Layout Join_alias(Layout_Target_OKC_Layout L, Layout_Denorm_Alias R ) := TRANSFORM

//Following fields are getting popolated using R

 SELF.name_aka := IF(L.name_aka ='', R.name_aka, L.name_aka+';'+ R.name_aka);
 SELF := L;
end;		 
	 
Layout_Target_OKC_Layout Join_attribute(Layout_Target_OKC_Layout L, Layout_Denorm_Attribute R ) := TRANSFORM

 //Following fields are getting popolated using R
 //SELF.scars_marks_tattoos      := '';
																			
 SELF := R;
 SELF := L;
end;		 

Layout_Target_OKC_Layout Join_offense(Layout_Target_OKC_Layout L, Layout_Denorm_Offense R ) := TRANSFORM

 //Following fields are getting popolated using R
 /* SELF.arrest_date_1:= '';
		SELF.arrest_warrant_1:= '';
		SELF.conviction_jurisdiction_1:= '';
		SELF.conviction_date_1:= '';
		SELF.court_1:= '';
		SELF.court_case_number_1:= '';
		SELF.offense_date_1:= '';
		SELF.offense_code_or_statute_1:= '';
		SELF.offense_description_1:= '';
		SELF.offense_description_1_2:= '';
		SELF.victim_minor_1:= '';
		SELF.victim_age_1:= '';
		SELF.victim_gender_1:= '';
		SELF.victim_relationship_1:= '';
		SELF.sentence_description_1:= '';
		SELF.sentence_description_1_2:= '';
		SELF.arrest_date_2:= '';
		SELF.arrest_warrant_2:= '';
		SELF.conviction_jurisdiction_2:= '';
		SELF.conviction_date_2:= '';
		SELF.court_2:= '';
		SELF.court_case_number_2:= '';
		SELF.offense_date_2:= '';
		SELF.offense_code_or_statute_2:= '';
		SELF.offense_description_2:= '';
		SELF.offense_description_2_2:= '';
		SELF.victim_minor_2:= '';
		SELF.victim_age_2:= '';
		SELF.victim_gender_2:= '';
		SELF.victim_relationship_2:= '';
		SELF.sentence_description_2:= '';
		SELF.sentence_description_2_2:= '';
		SELF.arrest_date_3:= '';
		SELF.arrest_warrant_3:= '';
		SELF.conviction_jurisdiction_3:= '';
		SELF.conviction_date_3:= '';
		SELF.court_3:= '';
		SELF.court_case_number_3:= '';
		SELF.offense_date_3:= '';
		SELF.offense_code_or_statute_3:= '';
		SELF.offense_description_3:= '';
		SELF.offense_description_3_2:= '';
		SELF.victim_minor_3:= '';
		SELF.victim_age_3:= '';
		SELF.victim_gender_3:= '';
		SELF.victim_relationship_3:= '';
		SELF.sentence_description_3:= '';
		SELF.sentence_description_3_2:= '';
		SELF.arrest_date_4:= '';
		SELF.arrest_warrant_4:= '';
		SELF.conviction_jurisdiction_4:= '';
		SELF.conviction_date_4:= '';
		SELF.court_4:= '';
		SELF.court_case_number_4:= '';
		SELF.offense_date_4:= '';
		SELF.offense_code_or_statute_4:= '';
		SELF.offense_description_4:= '';
		SELF.offense_description_4_2:= '';
		SELF.victim_minor_4:= '';
		SELF.victim_age_4:= '';
		SELF.victim_gender_4:= '';
		SELF.victim_relationship_4:= '';
		SELF.sentence_description_4:= '';
		SELF.sentence_description_4_2:= '';
		SELF.arrest_date_5:= '';
		SELF.arrest_warrant_5:= '';
		SELF.conviction_jurisdiction_5:= '';
		SELF.conviction_date_5:= '';
		SELF.court_5:= '';
		SELF.court_case_number_5:= '';
		SELF.offense_date_5:= '';
		SELF.offense_code_or_statute_5:= '';
		SELF.offense_description_5:= '';
		SELF.offense_description_5_2:= '';
		SELF.victim_minor_5:= '';
		SELF.victim_age_5:= '';
		SELF.victim_gender_5:= '';
		SELF.victim_relationship_5:= '';
		SELF.sentence_description_5:= '';
		SELF.sentence_description_5_2:= '';*/
		release_date_list := ['RELEASE DATE','RELEASED','Confinement Release Date','PROJECTED RELEASE DATE'];
		
		Boolean Offender_rel_date_notnull := IF (L.reg_date_3_type IN release_date_list or
		                                         L.reg_date_2_type IN release_date_list or
																						 L.reg_date_1_type IN release_date_list, 
																						 true,false); 
		SELF.sentence_description_1_2 := IF ( Offender_rel_date_notnull , R.sentence_description_1_2[1..StringLib.StringFind(R.sentence_description_1_2,'RELEASE DATE:',1)-1],
		                                                                  R.sentence_description_1_2);																						 
		SELF.sentence_description_2_2 := IF ( Offender_rel_date_notnull , R.sentence_description_2_2[1..StringLib.StringFind(R.sentence_description_2_2,'RELEASE DATE:',1)-1],
		                                                                  R.sentence_description_2_2);																						 
		SELF.sentence_description_3_2 := IF ( Offender_rel_date_notnull , R.sentence_description_3_2[1..StringLib.StringFind(R.sentence_description_3_2,'RELEASE DATE:',1)-1],
		                                                                  R.sentence_description_3_2);
		SELF.sentence_description_4_2 := IF ( Offender_rel_date_notnull , R.sentence_description_4_2[1..StringLib.StringFind(R.sentence_description_4_2,'RELEASE DATE:',1)-1],
		                                                                  R.sentence_description_4_2);	
		SELF.sentence_description_5_2 := IF ( Offender_rel_date_notnull , R.sentence_description_5_2[1..StringLib.StringFind(R.sentence_description_5_2,'RELEASE DATE:',1)-1],
		                                                                  R.sentence_description_5_2);

 SELF := R;
 SELF := L;
end;		


Layout_Target_OKC_Layout Join_vehicle(Layout_Target_OKC_Layout L, Layout_Denorm_Vehicle R ) := TRANSFORM

    //Following fields are getting popolated using R
 		/*SELF.orig_veh_year_1:= '';
		SELF.orig_veh_color_1:= '';
		SELF.orig_veh_make_model_1:= '';
		SELF.orig_veh_plate_1:= '';
		SELF.orig_registration_number_1:= '';
		SELF.orig_veh_state_1:= '';
		SELF.orig_veh_location_1:= '';
		SELF.orig_veh_year_2:= '';
		SELF.orig_veh_color_2:= '';
		SELF.orig_veh_make_model_2:= '';
		SELF.orig_veh_plate_2:= '';
		SELF.orig_registration_number_2:= '';
		SELF.orig_veh_state_2:= '';
		SELF.orig_veh_location_2:= '';
		SELF.orig_veh_year_3:= '';
		SELF.orig_veh_color_3:= '';
		SELF.orig_veh_make_model_3:= '';
		SELF.orig_veh_plate_3:= '';
		SELF.orig_registration_number_3:= '';
		SELF.orig_veh_state_3:= '';
		SELF.orig_veh_location_3:= '';
		SELF.orig_veh_year_4:= '';
		SELF.orig_veh_color_4:= '';
		SELF.orig_veh_make_model_4:= '';
		SELF.orig_veh_plate_4:= '';
		SELF.orig_registration_number_4:= '';
		SELF.orig_veh_state_4:= '';
		SELF.orig_veh_location_4:= '';
		SELF.orig_veh_year_5:= '';
		SELF.orig_veh_color_5:= '';
		SELF.orig_veh_make_model_5:= '';
		SELF.orig_veh_plate_5:= '';
		SELF.orig_registration_number_5:= '';
		SELF.orig_veh_state_5:= '';
		SELF.orig_veh_location_5:= '';*/
		SELF.addl_comments_1 := IF (L.addl_comments_1 <> '' ,L.addl_comments_1 ,R.Addl_veh_information);
		SELF.addl_comments_2 := IF (L.addl_comments_1 = '' OR 
		                            trim(L.addl_comments_1) = trim(R.Addl_veh_information) OR
		                            L.addl_comments_2 <> '',L.addl_comments_2 ,R.Addl_veh_information);
    SELF := R;
    SELF := L;
end;	 	
 
Layout_Target_OKC_Layout Join_mugshot(Layout_Target_OKC_Layout L, Layout_soff_mugshot R ) := TRANSFORM

    //Following fields are getting popolated using R
		string v_imagename          := StringLib.StringFindReplace(R.Image_name, 'C:\\SOFF\\','');
		string v_imagename_1        := StringLib.StringFindReplace(v_imagename, 'C:/SOFF/','');
		string v_imagename_2        := StringLib.StringSubstituteOut(v_imagename_1, '/\\','_')	;
 		SELF.image_link             := trim(v_imagename_2);
		SELF.image_date             := trim(R.image_date);
    SELF := L;
end;	 	 

JOffenderOffAgy                   := JOIN(DSortedOffenderData, 
                                        DSortedDedupedOffAgency, LEFT.sor_number=RIGHT.id,
                                        Join_OffenseAgency(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);
//output(JOffenderOffAgy(state_of_origin = 'NY'));

JOffenderAddress                  := JOIN(JOffenderOffAgy, 
                                        DSortedDenormedAddress, LEFT.sor_number=RIGHT.id,
                                        Join_address(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);
//output(JOffenderAddress(state_of_origin = 'NY'));									
JOffenderAddrAlias	              := JOIN(JOffenderAddress, 
                                        DSortedDenormedAlias, LEFT.sor_number=RIGHT.id,
                                        Join_alias(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);	
																
JOffenderAddrAliasAttrib	        := JOIN(JOffenderAddrAlias, 
                                        DSortedDenormedAttribute, LEFT.sor_number=RIGHT.id,
                                        Join_attribute(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);	

JOffenderAddrAliasAttribOffn	    := JOIN(JOffenderAddrAliasAttrib, 
                                        DSortedDenormedOffense, LEFT.sor_number=RIGHT.id,
                                        Join_offense(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);	
																				
JOffenderAddrAliasAttOffnVeh	    := JOIN(JOffenderAddrAliasAttribOffn, 
                                        DSortedDenormedVehicle, LEFT.sor_number=RIGHT.id,
                                        Join_vehicle(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);																	
//output(JOffenderAddrAliasAttOffnVeh(state_of_origin = 'NY'));		
															
JOffenderAddrAliasAttOffnVehMug	  := JOIN(JOffenderAddrAliasAttOffnVeh, 
                                        DSortedDedupedMugshot, LEFT.sor_number=RIGHT.id,
                                        Join_mugshot(LEFT,RIGHT),LEFT OUTER,NOSORT,LOCAL);
																				
export Mapping_Offender		        := JOffenderAddrAliasAttOffnVehMug;		

// export Mapping_Offender		        := OffenderDataInOKCLayout;									
