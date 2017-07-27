import Corp2,  Address,corp2_mapping,_Control,AK_Comm_Fish_Vessels,_validate,versioncontrol;

export CA(string8 fileDate, string version, boolean pShouldSpray = _Dataset().bShouldSpray,boolean pOverwrite = false) 
:=FUNCTION
//**************************************************************************
// 									vendor data format
//**************************************************************************

dleag :=['05','06','08','09','10','15','16','17','18'];

Layout_mast 
:= RECORD, maxlength(1281)
   EBCDIC STRING5 	Transaction_Julian_Date;
   EBCDIC STRING8 	Corp_Number;
   EBCDIC STRING8 	Incorp_Date;
   EBCDIC STRING1 	Corp_Status;
   EBCDIC STRING4 	Corp_Type;
   EBCDIC STRING1 	Corp_Tax_base;
   EBCDIC STRING2 	Corp_Classification;
   EBCDIC STRING11 	Filler;
   EBCDIC STRING8 	Term_Expiration_Date;
   EBCDIC STRING1 	FTB_Suspen_Status_Code;
   EBCDIC STRING8 	FTB_Suspen_Date;
   EBCDIC STRING7 	Statement_of_Officers_File_Num;
   EBCDIC STRING6 	Statement_of_File_Date;
   EBCDIC STRING350 Corp_Name;
   EBCDIC STRING50 	Care_of_Name;
   EBCDIC STRING40 	Mail_Address1;
   EBCDIC STRING40 	Mail_Address2;
   EBCDIC STRING24 	Mail_Address_City;
   EBCDIC STRING15 	Mail_Address_State;
   EBCDIC STRING10 	Mail_Address_ZipCode;
   EBCDIC STRING50 	President_Name;
   EBCDIC STRING40 	President_Address1;
   EBCDIC STRING40 	President_Address2;
   EBCDIC STRING24 	President_Address_City;
   EBCDIC STRING15 	President_Address_State;
   EBCDIC STRING10 	President_Address_ZipCode;
   EBCDIC STRING350 Agent_Name;
   EBCDIC STRING40 	Agent_Address1;
   EBCDIC STRING40 	Agent_Address2;
   EBCDIC STRING24 	Agent_Address_City;
   EBCDIC STRING15 	Agent_Address_State;
   EBCDIC STRING10 	Agent_Address_ZipCode;
   EBCDIC STRING24 	State_Foreign_County;
 
END;

Layout_hist 
:= RECORD, maxlength(423)
   EBCDIC STRING5 	Transaction_Julian_Date;
   EBCDIC STRING8 	Corp_Number;
   EBCDIC STRING4 	Transaction_Code;
   EBCDIC STRING8 	Transaction_Date;
   EBCDIC STRING2 	Amendment_Page_Count;
   EBCDIC STRING30 	Comment;
   EBCDIC STRING8 	Amendment_Number;
   EBCDIC STRING8 	Name_Corp_Number;
   EBCDIC STRING350 Old_Corp_Name;
END; 
Layout_lp 
:= RECORD, maxlength(1400)
   EBCDIC STRING12 	file_number;
   EBCDIC STRING8 	file_date;
   EBCDIC STRING1 	status;
   EBCDIC STRING1 	filing_type;
   EBCDIC STRING220 name;
   EBCDIC STRING40 	executive_address;
   EBCDIC STRING24 	executive_city;
   EBCDIC STRING2 	executive_state;
   EBCDIC STRING10 	executive_zip;
   EBCDIC STRING40 	calif_address;
   EBCDIC STRING22 	calif_city;
   EBCDIC STRING2 	calif_state;
   EBCDIC STRING10 	calif_zip;
   EBCDIC STRING20 	original_file_number;
   EBCDIC STRING8 	original_file_date;
   EBCDIC STRING2 	original_county;
   EBCDIC STRING65 	agent_name;
   EBCDIC STRING40 	agent_address1;
   EBCDIC STRING40 	agent_address2;
   EBCDIC STRING24 	agent_city;
   EBCDIC STRING2 	agent_state;
   EBCDIC STRING10 	agent_zip;
   EBCDIC STRING20 	term;
   EBCDIC STRING2 	number_gp_amend;
   EBCDIC STRING3 	number_amendments;
   EBCDIC STRING5 	total_pages;
   EBCDIC STRING2 	addl_gp;
   EBCDIC STRING140 people1_name;
   EBCDIC STRING40 	people1_address;
   EBCDIC STRING24 	people1_city;
   EBCDIC STRING2 	people1_state;
   EBCDIC STRING10 	people1_zip;
   EBCDIC STRING140 people2_name;
   EBCDIC STRING40 	people2_address;
   EBCDIC STRING24 	people2_city;
   EBCDIC STRING2 	people2_state;
   EBCDIC STRING10 	people2_zip;
   EBCDIC STRING140 people3_name;
   EBCDIC STRING40	people3_address;
   EBCDIC STRING24 	people3_city;
   EBCDIC STRING2 	people3_state;
   EBCDIC STRING10 	people3_zip;
   EBCDIC STRING2 	llc_jurisdiction;
   EBCDIC STRING1 	llc_mgmt_code;
   EBCDIC STRING40 	llc_business_type;
   EBCDIC STRING128	filler;
END;
//**************************************************************************
// 									Mapping corp, cont, event
//**************************************************************************

string fXlateUnprintable(string pInput)	:=stringlib.StringToUpperCase(regexreplace('[^\\x20-\\x7F]',pInput,''));

corp2.layout_Corporate_Direct_Corp_in Trans_Corp(Layout_mast pInput)
:=TRANSFORM 

  STRING  state                   := IF(corp2_mapping.functions.TRIMUpper(pInput.State_Foreign_County)='','CA',
										 corp2_mapping.functions.TRIMUpper(pInput.State_Foreign_County));
  clean_address 	    		  := Address.CleanAddress182((String)pInput.Mail_Address1+' '+(String)pInput.Mail_Address2,
																regexreplace('[ ]+',(String)pInput.Mail_Address_City +' '
																+(String)pInput.Mail_Address_State+ ','
																+(String)pInput.Mail_Address_ZipCode,' '));	
  clean_ra_address 				  := Address.CleanAddress182((String)pInput.Agent_Address1+' '+(String)pInput.Agent_Address2,
																regexreplace('[ ]+',(String)pInput.Agent_Address_City+ ' '
																+(String)pInput.Agent_Address_state + ' ' 
  															    +(String)pInput.Agent_Address_ZipCode,' '));
  ra_name                         :=corp2_mapping.functions.TRIMUpper(REGEXREPLACE(' +',(STRING)pInput.Agent_Name,' '));
  pname			    			  := IF((integer)Address.CleanPersonFML73(ra_name)[71..73]>87, Address.CleanPersonFML73(ra_name),Address.CleanPersonLFM73(ra_name));
  cname 						  := IF(AK_Comm_Fish_Vessels.fIsCompany(ra_name) and ~Regexfind('FISH', pname),corp2_mapping.functions.TRIMUpper(ra_name),'');

 
  SELF.dt_first_seen				:= filedate;
  SELF.dt_last_seen					:= filedate;
  SELF.dt_vENDor_first_reported		:= filedate;
  SELF.dt_vENDor_last_reported		:= filedate;
 
  SELF.corp_ra_dt_first_seen 		:= filedate;
  SELF.corp_ra_dt_last_seen 		:= filedate; 
  SELF.corp_key 					:= '06-'+trim((STRING) pInput.Corp_Number,all);
  SELF.corp_vendor 					:= '06';
  SELF.corp_state_origin 			:= 'CA';
  SELF.corp_process_date 			:= filedate;
  SELF.corp_orig_sos_charter_nbr 	:= 'C'+REGEXREPLACE('^0',trim((STRING) pInput.Corp_Number,all),'');
  SELF.corp_src_type 					:= 'SOS';
  SELF.corp_legal_name 				:= pInput.Corp_Name;
	SELF.corp_ln_name_type_desc 		:= 'LEGAL';
  SELF.corp_address1_type_desc 		:= IF((STRING) (pInput.Mail_Address1+pInput.Mail_Address_City)<>'', 'MAILING','');
  //SELF.corp_address1_line1 			:= pInput.Care_of_Name;
  SELF.corp_address1_line1			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Mail_Address1);
  SELF.corp_address1_line2 			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Mail_Address2);
  SELF.corp_address1_line3			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Mail_Address_City);
  SELF.corp_address1_line4			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Mail_Address_State);
  SELF.corp_address1_line5			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Mail_Address_ZipCode);
  SELF.corp_filing_cd 				:= pInput.Corp_Type;
  SELF.corp_filing_desc 			:= corp2_mapping.functions.decode_filing_type(pInput.Corp_Type);
	SELF.corp_status_date				:= IF(_validate.date.fIsValid(pInput.FTB_Suspen_Date) ,pInput.FTB_Suspen_Date, '');
	SELF.corp_tax_program_desc	:= map (corp2_mapping.functions.TRIMUpper(pInput.FTB_Suspen_Status_Code) = '' => 'NOT SUSPENDED (GOOD STANDING)',
																			corp2_mapping.functions.TRIMUpper(pInput.FTB_Suspen_Status_Code) = 'F' => 'FORFEITED',
																			corp2_mapping.functions.TRIMUpper(pInput.FTB_Suspen_Status_Code) = 'S' => 'SUSPENDED',
																			''
																			);
  SELF.corp_status_cd 				:= pInput.Corp_Status;
  SELF.corp_status_desc 			:= corp2_mapping.functions.Decode_StatusCA(pInput.Corp_Status);
  SELF.corp_inc_state				:= IF(state<> 'CA','',State);
  SELF.corp_forgn_state_cd          := IF(state = 'CA','',corp2_mapping.functions.decode_cd(State));												   
  SELF.corp_forgn_state_desc        := IF(state = 'CA','',
										IF(self.corp_forgn_state_cd ='',
										   corp2_mapping.functions.decode_country(State),corp2_mapping.functions.decode_desc(self.corp_forgn_state_cd)));												   
  SELF.corp_inc_date 				:= IF(state='CA',pInput.Incorp_Date,'');
  SELF.corp_forgn_date 			    := IF(state='CA','',pInput.Incorp_Date);
  SELF.CORP_TERM_EXIST_EXP          := IF(state='CA',pInput.Term_Expiration_Date,'');
  SELF.CORP_TERM_EXIST_CD           := IF(_validate.date.fIsValid(SELF.CORP_TERM_EXIST_EXP) ,'D',
										 IF(pInput.Term_Expiration_Date<>'', 'N' , ''));
  SELF.corp_term_exist_desc 		:= CASE(SELF.corp_term_exist_cd,'D'=>'EXPIRATION DATE','N'=>'NUMBER OF YEARS', '');
  SELF.CORP_forgn_TERM_EXIST_EXP    := IF(state<>'CA',pInput.Term_Expiration_Date,'');
  SELF.CORP_forgn_TERM_EXIST_CD     := IF(_validate.date.fIsValid(SELF.CORP_forgn_TERM_EXIST_EXP) ,'D',
										 IF(pInput.Term_Expiration_Date<>'', 'N' , ''));
  SELF.CORP_forgn_TERM_EXIST_DESC   := CASE(SELF.CORP_forgn_TERM_EXIST_CD ,'D'=>'EXPIRATION DATE','N'=>'NUMBER OF YEARS', '');
  SELF.corp_foreign_domestic_ind 	:= IF(SELF.corp_inc_state='CA' , 'D' , 'F');
  SELF.corp_orig_org_structure_desc := 'CORPORATION';
  SELF.corp_for_profit_ind 			:= IF(pInput.Corp_Tax_base='S', 'Y' ,IF( pInput.Corp_Tax_base='N','N',''));
  SELF.corp_orig_bus_type_cd 		:= pInput.Corp_Classification;
  SELF.corp_orig_bus_type_desc 		:= corp2_mapping.functions.decode_bus_type(pInput.Corp_Classification);
  SELF.corp_ra_title_desc 			:= IF(pInput.Agent_Name<>'','REGISTERED AGENT', '');
  SELF.corp_ra_name 				:= corp2_mapping.functions.TRIMUpper(REGEXREPLACE(' +',(STRING)pInput.Agent_Name,' '));
  SELF.corp_ra_address_type_desc 	:= IF((STRING)(pInput.Agent_Address1+pInput.Agent_Address_City) <>'', 'REGISTERED OFFICE', '');
  SELF.corp_ra_address_line1 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Agent_Address1);
  SELF.corp_ra_address_line2 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Agent_Address2);
  SELF.corp_ra_address_line3 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Agent_Address_City);
  SELF.corp_ra_address_line4 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.Agent_Address_State);
  SELF.corp_ra_address_line5 		:= pInput.Agent_Address_ZipCode;
  SELF.corp_ra_cname1 			    := IF((integer)pname[71..73]>85  ,'',
										     IF(regexfind('[0~9]|[a-z]|[A-Z]',cname),cname,
										     IF(Cname='',corp2_mapping.functions.TRIMUpper(SELF.corp_ra_name),'')));
  SELF.corp_ra_cname1_score 		:= IF(SELF.corp_ra_cname1='','',pName[71..73]);
  SELF.corp_ra_title1		    	:= IF(SELF.corp_ra_cname1='', pname[1..5], '');
  SELF.corp_ra_fname1 				:= IF(SELF.corp_ra_cname1='', pname[6..25], '');
  SELF.corp_ra_mname1 				:= IF(SELF.corp_ra_cname1='', pname[26..45], '');
  SELF.corp_ra_lname1 				:= IF(SELF.corp_ra_cname1='', pname[46..65], '');
  SELF.corp_ra_name_suffix1 		:= IF(SELF.corp_ra_cname1='', pname[66..70], '');
  SELF.corp_ra_score1 				:= IF(SELF.corp_ra_cname1='', pname[71..73], '');
  SELF.corp_ra_prim_range    		:= clean_ra_address[1..10];
  SELF.corp_ra_predir 	    		:= clean_ra_address[11..12];
  SELF.corp_ra_prim_name 	  		:= clean_ra_address[13..40];
  SELF.corp_ra_addr_suffix   		:= clean_ra_address[41..44];
  SELF.corp_ra_postdir 	    		:= clean_ra_address[45..46];
  SELF.corp_ra_unit_desig 			:= clean_ra_address[47..56];
  SELF.corp_ra_sec_range 	  		:= clean_ra_address[57..64];
  SELF.corp_ra_p_city_name			:= clean_ra_address[65..89];
  SELF.corp_ra_v_city_name			:= clean_ra_address[90..114];
  SELF.corp_ra_state		    	:= clean_ra_address[115..116];
  SELF.corp_ra_zip5 		    	:= clean_ra_address[117..121];
  SELF.corp_ra_zip4 		    	:= clean_ra_address[122..125];
  SELF.corp_ra_cart 		    	:= clean_ra_address[126..129];
  SELF.corp_ra_cr_sort_sz 			:= clean_ra_address[130];
  SELF.corp_ra_lot 		    		:= clean_ra_address[131..134];
  SELF.corp_ra_lot_order 	  		:= clean_ra_address[135];
  SELF.corp_ra_dpbc 		    	:= clean_ra_address[136..137];
  SELF.corp_ra_chk_digit 	  	    := clean_ra_address[138];
  SELF.corp_ra_rec_type				:= clean_ra_address[139..140];
  SELF.corp_ra_ace_fips_st			:= clean_ra_address[141..142];
  SELF.corp_ra_county 	  			:= clean_ra_address[143..145];
  SELF.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
  SELF.corp_ra_geo_long 	    	:= clean_ra_address[156..166];
  SELF.corp_ra_msa 		    		:= clean_ra_address[167..170];
  SELF.corp_ra_geo_blk				:= clean_ra_address[171..177];
  SELF.corp_ra_geo_match 	  		:= clean_ra_address[178];
  SELF.corp_ra_err_stat 	    	:= clean_ra_address[179..182];													
  SELF.corp_addr1_prim_range  		:= clean_address[1..10];
  SELF.corp_addr1_predir 	    	:= clean_address[11..12];
  SELF.corp_addr1_prim_name 		:= clean_address[13..40];
  SELF.corp_addr1_addr_suffix 		:= clean_address[41..44];
  SELF.corp_addr1_postdir 			:= clean_address[45..46];
  SELF.corp_addr1_unit_desig 		:= clean_address[47..56];
  SELF.corp_addr1_sec_range 		:= clean_address[57..64];
  SELF.corp_addr1_p_city_name		:= clean_address[65..89];
  SELF.corp_addr1_v_city_name		:= clean_address[90..114];
  SELF.corp_addr1_state 			:= clean_address[115..116];
  SELF.corp_addr1_zip5 				:= clean_address[117..121];
  SELF.corp_addr1_zip4 				:= clean_address[122..125];
  SELF.corp_addr1_cart 				:= clean_address[126..129];
  SELF.corp_addr1_cr_sort_sz 		:= clean_address[130];
  SELF.corp_addr1_lot 				:= clean_address[131..134];
  SELF.corp_addr1_lot_order 		:= clean_address[135];
  SELF.corp_addr1_dpbc 				:= clean_address[136..137];
  SELF.corp_addr1_chk_digit 		:= clean_address[138];
  SELF.corp_addr1_rec_type			:= clean_address[139..140];
  SELF.corp_addr1_ace_fips_st		:= clean_address[141..142];
  SELF.corp_addr1_county 	  		:= clean_address[143..145];
  SELF.corp_addr1_geo_lat 			:= clean_address[146..155];
  SELF.corp_addr1_geo_long 			:= clean_address[156..166];
  SELF.corp_addr1_msa 				:= clean_address[167..170];
  SELF.corp_addr1_geo_blk			:= clean_address[171..177];
  SELF.corp_addr1_geo_match 		:= clean_address[178];
  SELF.corp_addr1_err_stat 			:= clean_address[179..182]; 
  SELF 							    := PInput; 
  SELF						        := [];
end;

corp2.layout_Corporate_Direct_Corp_in Trans_Corplp(Layout_lp   pInput)
:=TRANSFORM 
  r_dt			:=stringlib.stringfilter((string)pInput.agent_name,'0123456789');
  term			:=stringlib.stringfilter((string)pInput.term,'0123456789');
  r_name		:=case(StringLib.StringFind((string)pInput.agent_name,'*',1),0=>(string)pInput.agent_name,1=>'',(STRING)pInput.agent_name[StringLib.StringFind((string)pInput.agent_name,'*',1)+1..65]);
  clean_address :=Address.CleanAddress182((STRING)pInput.executive_address,
                                          (STRING)pInput.executive_city+' '+(STRING)pInput.executive_state+' '+(STRING)pInput.executive_zip);
  clean_address1:=IF((STRING)pInput.calif_address='','',Address.CleanAddress182((STRING)pInput.calif_address,
										  (STRING)pInput.calif_city+' '+(STRING)pInput.calif_state+' '+(STRING)pInput.calif_zip));
 clean_ra_address:= Address.CleanAddress182((String)pInput.agent_address1+' '+(String)pInput.Agent_Address2,
																regexreplace('[ ]+',(String)pInput.agent_city+ ' '
																+(String)pInput.Agent_state + ' ' 
  															    +(String)pInput.Agent_Zip,' '));
																										  
  pname			:= IF((integer)Address.CleanPersonFML73(r_name)[71..73]>87, Address.CleanPersonFML73(r_name),Address.CleanPersonLFM73(r_name));
  cname 		:= IF(AK_Comm_Fish_Vessels.fIsCompany(r_name) and ~Regexfind('FISH', pname),corp2_mapping.functions.TRIMUpper(r_name),'');
  county		:= CASE(trim((STRING)pInput.original_county,left,right),'01' => 'ALAMEDA',
	                                                                    '02' => 'ALPINE',                              
																		'03' => 'AMADOR',
																		'04' => 'BUTTE',                               
																		'05' => 'CALAVERAS',
																		'06' => 'COLUSA',
																		'07' => 'CONTRA COSTA',
																		'08' => 'DEL NORTE',
																		'09' => 'EL DORADO',      
																		'10' => 'FRESNO',
																		'11' => 'GLEN',
																		'12' => 'HUMBOLDT',
																		'13' => 'IMPERIAL',          
																		'14' => 'INYO',
																		'15' => 'KERN', 
																		'16' => 'KINGS',
																		'17' => 'LAKE', 
																		'18' => 'LASSEN',             
																		'19' => 'LOS ANGELES',   
																		'20' => 'MADERA',            
																		'21' => 'MARIN',
																		'22' => 'MARIPOSA',
 																		'23' => 'MENDOCINO',
 																		'24' => 'MERCED',
 																		'25' => 'MODOC',
 																		'26' => 'MONO',
 																		'27' => 'MONTEREY',
 																		'28' => 'NAPA',
 																		'29' => 'NEVADA',
 																		'30' => 'ORANGE',
 																		'31' => 'PLACER',
 																		'32' => 'PLUMAS',
 																		'33' => 'RIVERSIDE',
 																		'34' => 'SACRAMENTO',
 																		'35' => 'SAN BENITO',
 																		'36' => 'SAN BERNARDINO',
 																		'37' => 'SAN DIEGO',
 																		'38' => 'SAN FRANCISCO',
 																		'39' => 'SAN JOAQUIN',
 																		'40' => 'SAN LUIS OBISPO',
 																		'41' => 'SAN MATEO',
 																		'42' => 'SANTA BARBARA',
 																		'43' => 'SANTA CLARA',
 																		'44' => 'SANTA CRUZ',
 																		'45' => 'SHASTA',
 																		'46' => 'SIERRA',
 																		'47' => 'SISKIYOU',
 																		'48' => 'SOLAN0',
 																		'49' => 'SONOMA',
 																		'50' => 'STANISLAUS',
 																		'51' => 'SUTTER',
 																		'52' => 'TEHAMA',
 																		'53' => 'TRINITY',
 																		'54' => 'TULARE',
 																		'55' => 'TUOLUMNE',
 																		'56' => 'VENTURA',
 																		'57' => 'YOLO',
 																		'58' => 'YUBA',
																		'');
																												

  SELF.dt_first_seen				:= filedate;
  SELF.dt_last_seen					:= filedate;
  SELF.dt_vENDor_first_reported		:= filedate;
  SELF.dt_vENDor_last_reported		:= filedate;
  SELF.corp_ra_dt_first_seen 		:= IF(LENGTH(r_dt)=8 AND R_DT[5..8]+r_dt[1..2]+r_dt[3..4]<=filedate,r_dt[5..8]+r_dt[1..2]+r_dt[3..4],filedate);
  SELF.corp_ra_dt_last_seen 		:= SELF.corp_ra_dt_first_seen ;
  SELF.corp_key 					:= '06-'+(STRING)pInput.file_number;
  SELF.corp_vendor 					:= '06';
  SELF.corp_state_origin 			:= 'CA';
  SELF.corp_process_date 			:= filedate;
  SELF.corp_orig_sos_charter_nbr 	:= pInput.file_number;
  SELF.corp_src_type 				:= 'SOS';
  SELF.corp_legal_name 				:= REGEXREPLACE(' +',pInput.name,' ');
  SELF.corp_ln_name_type_cd 		:= '';
  SELF.corp_ln_name_type_desc 		:= 'LEGAL';
  SELF.corp_address1_type_desc 		:= IF((STRING)(pInput.executive_address+pInput.executive_city)='','', 'BUSINESS');
  SELF.corp_address1_line1 			:= pInput.executive_address;
  SELF.corp_address1_line3			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_City);
  SELF.corp_address1_line4			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_State);
  SELF.corp_address1_line5			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_zip);
  SELF.corp_address2_type_desc 		:= IF((STRING)(pInput.calif_address+pInput.calif_city)<>'', 'MAILING' , '');
  SELF.corp_address2_line1 			:= pInput.calif_address;
  SELF.corp_address2_line3			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.calif_City);
  SELF.corp_address2_line4			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.calif_State);
  SELF.corp_address2_line5			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.calif_zip);
  // SELF.corp_filing_reference_nbr 	:= pInput.file_number;
  SELF.corp_filing_date 			:= pInput.file_date;
  SELF.corp_filing_cd 				:= pInput.filing_type;
  SELF.corp_filing_desc 			:= IF(pInput.filing_type='D', 'DOMESTIC',IF(pInput.filing_type='F','FOREIGN',''));
  SELF.corp_status_cd 				:= pInput.status;
  SELF.corp_status_desc 			:= CASE(pInput.status,'A'=> 'ACTIVE','B' => 'DISHONORED CHECK','C' => 'CANCELLED'
											 ,'D' => 'DISSOLVED','P' => 'PENDING CANCELLATION','M' => 'MERGED OUT' 
											 ,'O' => 'CONVERTED OUT','');
                         
  SELF.corp_status_comment 			:= IF(StringLib.StringFind((string)pInput.name,'*',1)>1,(STRING)pInput.name[StringLib.StringFind((string)pInput.name,'*',1)+1..220],'');
  SELF.corp_ra_name 				:= r_name;
  SELF.corp_ra_title_desc 			:= IF(SELF.corp_ra_name<>'', 'REGISTERED AGENT' , '');
  SELF.corp_ra_address_line1 		:= pInput.agent_address1;
  SELF.corp_ra_address_line2 		:= pInput.agent_address2;
  SELF.corp_ra_address_line3 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.agent_city);
  SELF.corp_ra_address_line4 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.agent_state);
  SELF.corp_ra_address_line5 		:= corp2_mapping.functions.TRIMUpper((STRING)pInput.agent_zip);
  SELF.corp_ra_address_type_desc    := IF((STRING)(pInput.agent_address1+pInput.agent_city)<>'', 'REGISTERED OFFICE' , '');
  SELF.corp_ra_resign_date 			:= IF(LENGTH(r_dt)=8,r_dt[5..8]+r_dt[1..2]+r_dt[3..4],'');
  SELF.corp_ra_addl_info 			:= IF(REGEXFIND('RESIGNED',(STRING)pInput.agent_name),'RESIGNED '+
										IF(SELF.corp_ra_resign_date <>'',SELF.corp_ra_resign_date ,'(DATE UNKNOWN)'), '');
  SELF.corp_orig_org_structure_desc := IF(pInput.filing_type='D','DOMESTIC',IF(pInput.filing_type='F','FOREIGN',''))+
                                         ' '+IF(pInput.file_number[8..8]='0','LP',IF(pInput.file_number[8..8]='1','LLC',''));
  SELF.corp_orig_bus_type_desc 		:= pInput.llc_business_type;
	SELF.corp_inc_county						:= IF ((STRING)pInput.File_Number[8]='0', county, '');
  SELF.corp_inc_state 				:= IF((STRING)pInput.llc_jurisdiction='CA','CA','');
  SELF.corp_foreign_domestic_ind 	:= IF(SELF.corp_inc_state='CA' , 'D' , 'F');
  SELF.corp_forgn_state_cd          :=IF(SELF.corp_inc_state ='',corp2_mapping.functions.TRIMUpper(pInput.llc_jurisdiction),'');
  SELF.corp_forgn_state_desc 		:= IF(SELF.corp_inc_state ='',IF(Corp2_Mapping.Functions.Decode_state(TRIM((STRING)pInput.llc_jurisdiction,ALL))='',
										   corp2_mapping.functions.decode_country(TRIM((STRING)pInput.llc_jurisdiction,ALL)),Corp2_Mapping.Functions.Decode_state(TRIM((STRING)pInput.llc_jurisdiction,ALL))),'');
  SELF.corp_term_exist_cd 			:= IF(LENGTH(term)=8,'D',IF(REGEXFIND('YRS',(STRING)pInput.term),'N',''));
  SELF.corp_term_exist_exp 			:= CASE(SELF.corp_term_exist_cd,'D'=>term[5..8]+term[1..2]+term[3..4],'N'=>TRIM(fXlateUnprintable((STRING)pInput.term),RIGHT, LEFT),'');
  SELF.corp_term_exist_desc 		:= CASE(SELF.corp_term_exist_cd,'D'=>'EXPIRATION DATE','N'=>'NUMBER OF YEARS',TRIM(fXlateUnprintable((STRING)pInput.term),RIGHT, LEFT));
  SELF.corp_inc_date 				:= IF(LENGTH(TRIM((STRING)pInput.original_file_date))=8,pInput.original_file_date,'');
  SELF.corp_previous_nbr 			:= pInput.original_file_number;
  // SELF.corp_inc_county 				:= Corp2_Mapping.Functions.Decode_county(TRIM((STRING)pInput.original_county));
  SELF.corp_addl_info 				:= IF(REGEXREPLACE('[0]',fXlateUnprintable(pInput.number_gp_amend),'')<>'','NUMBER OF GPs REQUIRED TO AMEND: '+(STRING) pInput.number_gp_amend,'')+
									     IF(REGEXREPLACE('[0]',fXlateUnprintable(pInput.number_gp_amend),'')<>'' AND REGEXFIND('1|M|A|S',pInput.llc_mgmt_code),';','')+
											CASE(pInput.llc_mgmt_code,'1'=> 'ONE MANAGER','M' => 'MORE THAN 1 MANAGER' ,'A'=>'ALL MEMBERS ARE MANAGER','S' => 'ONE MEMBER' , '');
  SELF.corp_amendments_filed 		:= IF(pInput.number_amendments<>'000' ,REGEXREPLACE('^0+',(STRING)pInput.number_amendments,'') ,'');
  SELF.corp_ra_cname1 			    := IF((integer)pname[71..73]>85  ,'',
										     IF(regexfind('[0~9]|[a-z]|[A-Z]',cname),cname,
										     IF(Cname='',corp2_mapping.functions.TRIMUpper(SELF.corp_ra_name),'')));
  SELF.corp_ra_cname1_score 		:= IF(SELF.corp_ra_cname1='','',pName[71..73]);
  SELF.corp_ra_title1		    	:= IF(SELF.corp_ra_cname1='', pname[1..5], '');
  SELF.corp_ra_fname1 				:= IF(SELF.corp_ra_cname1='', pname[6..25], '');
  SELF.corp_ra_mname1 				:= IF(SELF.corp_ra_cname1='', pname[26..45], '');
  SELF.corp_ra_lname1 				:= IF(SELF.corp_ra_cname1='', pname[46..65], '');
  SELF.corp_ra_name_suffix1 		:= IF(SELF.corp_ra_cname1='', pname[66..70], '');
  SELF.corp_ra_score1 				:= IF(SELF.corp_ra_cname1='', pname[71..73], '');
  SELF.corp_addr2_prim_range    	:= clean_address1[1..10];
  SELF.corp_addr2_predir 	    	:= clean_address1[11..12];
  SELF.corp_addr2_prim_name 	  	:= clean_address1[13..40];
  SELF.corp_addr2_addr_suffix   	:= clean_address1[41..44];
  SELF.corp_addr2_postdir 	    	:= clean_address1[45..46];
  SELF.corp_addr2_unit_desig 		:= clean_address1[47..56];
  SELF.corp_addr2_sec_range 	  	:= clean_address1[57..64];
  SELF.corp_addr2_p_city_name		:= clean_address1[65..89];
  SELF.corp_addr2_v_city_name		:= clean_address1[90..114];
  SELF.corp_addr2_state		    	:= clean_address1[115..116];
  SELF.corp_addr2_zip5 		    	:= clean_address1[117..121];
  SELF.corp_addr2_zip4 		    	:= clean_address1[122..125];
  SELF.corp_addr2_cart 		    	:= clean_address1[126..129];
  SELF.corp_addr2_cr_sort_sz 		:= clean_address1[130];
  SELF.corp_addr2_lot 		    	:= clean_address1[131..134];
  SELF.corp_addr2_lot_order 	  	:= clean_address1[135];
  SELF.corp_addr2_dpbc 		    	:= clean_address1[136..137];
  SELF.corp_addr2_chk_digit 	  	:= clean_address1[138];
  SELF.corp_addr2_rec_type			:= clean_address1[139..140];
  SELF.corp_addr2_ace_fips_st		:= clean_address1[141..142];
  SELF.corp_addr2_county 	  		:= clean_address1[143..145];
  SELF.corp_addr2_geo_lat 	    	:= clean_address1[146..155];
  SELF.corp_addr2_geo_long 	    	:= clean_address1[156..166];
  SELF.corp_addr2_msa 		    	:= clean_address1[167..170];
  SELF.corp_addr2_geo_blk			:= clean_address1[171..177];
  SELF.corp_addr2_geo_match 	  	:= clean_address1[178];
  SELF.corp_addr2_err_stat 	    	:= clean_address1[179..182];													
  SELF.corp_addr1_prim_range  		:= clean_address[1..10];
  SELF.corp_addr1_predir 	    	:= clean_address[11..12];
  SELF.corp_addr1_prim_name 		:= clean_address[13..40];
  SELF.corp_addr1_addr_suffix 		:= clean_address[41..44];
  SELF.corp_addr1_postdir 			:= clean_address[45..46];
  SELF.corp_addr1_unit_desig 		:= clean_address[47..56];
  SELF.corp_addr1_sec_range 		:= clean_address[57..64];
  SELF.corp_addr1_p_city_name		:= clean_address[65..89];
  SELF.corp_addr1_v_city_name		:= clean_address[90..114];
  SELF.corp_addr1_state 			:= clean_address[115..116];
  SELF.corp_addr1_zip5 				:= clean_address[117..121];
  SELF.corp_addr1_zip4 				:= clean_address[122..125];
  SELF.corp_addr1_cart 				:= clean_address[126..129];
  SELF.corp_addr1_cr_sort_sz 		:= clean_address[130];
  SELF.corp_addr1_lot 				:= clean_address[131..134];
  SELF.corp_addr1_lot_order 		:= clean_address[135];
  SELF.corp_addr1_dpbc 				:= clean_address[136..137];
  SELF.corp_addr1_chk_digit 		:= clean_address[138];
  SELF.corp_addr1_rec_type			:= clean_address[139..140];
  SELF.corp_addr1_ace_fips_st		:= clean_address[141..142];
  SELF.corp_addr1_county 	  		:= clean_address[143..145];
  SELF.corp_addr1_geo_lat 			:= clean_address[146..155];
  SELF.corp_addr1_geo_long 			:= clean_address[156..166];
  SELF.corp_addr1_msa 				:= clean_address[167..170];
  SELF.corp_addr1_geo_blk			:= clean_address[171..177];
  SELF.corp_addr1_geo_match 		:= clean_address[178];
  SELF.corp_addr1_err_stat 			:= clean_address[179..182];
  
  self.corp_ra_prim_range    		:= clean_ra_address[1..10];
  self.corp_ra_predir 	      		:= clean_ra_address[11..12];
  self.corp_ra_prim_name 	  		:= clean_ra_address[13..40];
  self.corp_ra_addr_suffix   		:= clean_ra_address[41..44];
  self.corp_ra_postdir 	    		:= clean_ra_address[45..46];
  self.corp_ra_unit_desig 	  		:= clean_ra_address[47..56];
  self.corp_ra_sec_range 	  		:= clean_ra_address[57..64];
  self.corp_ra_p_city_name	  		:= clean_ra_address[65..89];
  self.corp_ra_v_city_name	  		:= clean_ra_address[90..114];
  self.corp_ra_state 			    := clean_ra_address[115..116];
  self.corp_ra_zip5 		      	:= clean_ra_address[117..121];
  self.corp_ra_zip4 		      	:= clean_ra_address[122..125];
  self.corp_ra_cart 		      	:= clean_ra_address[126..129];
  self.corp_ra_cr_sort_sz 	 		:= clean_ra_address[130];
  self.corp_ra_lot 		      		:= clean_ra_address[131..134];
  self.corp_ra_lot_order 	  		:= clean_ra_address[135];
  self.corp_ra_dpbc 		      	:= clean_ra_address[136..137];
  self.corp_ra_chk_digit 	  		:= clean_ra_address[138];
  self.corp_ra_rec_type		  		:= clean_ra_address[139..140];
  self.corp_ra_ace_fips_st	  		:= clean_ra_address[141..142];
  self.corp_ra_county 	  			:= clean_ra_address[143..145];
  self.corp_ra_geo_lat 	    		:= clean_ra_address[146..155];
  self.corp_ra_geo_long 	    	:= clean_ra_address[156..166];
  self.corp_ra_msa 		      		:= clean_ra_address[167..170];
  self.corp_ra_geo_blk				:= clean_ra_address[171..177];
  self.corp_ra_geo_match 	  		:= clean_ra_address[178];
  self.corp_ra_err_stat 	    	:= clean_ra_address[179..182];
  
  
  SELF                       		:= [];
end;

corp2.layout_Corporate_Direct_cont_in tNormalizecont(Layout_lp   pInput,unsigned C)
:=TRANSFORM 
  name		    :=CHOOSE(c,pInput.people1_name,pInput.people2_name,pInput.people3_name);
  address1      :=CHOOSE(c,pinput.people1_address,pinput.people2_address,pinput.people3_address);
  address2      :=CHOOSE(c,(STRING)pinput.people1_city+' '+(STRING)pinput.people1_state+' '+(STRING)pinput.people1_zip,
						   (STRING)pinput.people2_city+' '+(STRING)pinput.people2_state+' '+(STRING)pinput.people2_zip,
						   (STRING)pinput.people3_city+' '+(STRING)pinput.people3_state+' '+(STRING)pinput.people3_zip);
  clean_address :=Address.CleanAddress182((STRING)pInput.executive_address,
                                          (STRING)pInput.executive_city+' '+(STRING)pInput.executive_state+' '+(STRING)pInput.executive_zip);
  clean_address1:= IF(address1<>'',Address.CleanAddress182(address1,address2),'');
                                          
  pname			:= IF((integer)Address.CleanPersonFML73(name)[71..73]>87, Address.CleanPersonFML73(name),Address.CleanPersonLFM73(name));
  cname 		:= IF(AK_Comm_Fish_Vessels.fIsCompany(name) and ~Regexfind('FISH', pname),corp2_mapping.functions.TRIMUpper(name),'');

  SELF.corp_process_date 			:= filedate;
  SELF.dt_first_seen				:= filedate;
  SELF.dt_last_seen					:= filedate;
  SELF.corp_key 					:= '06-'+(STRING)pInput.file_number;
  SELF.corp_vendor 					:= '06';
  SELF.corp_state_origin 			:= 'CA';
  SELF.corp_orig_sos_charter_nbr 	:= pInput.file_number;
  SELF.corp_legal_name 				:= REGEXREPLACE(' +',pInput.name,' ');
  SELF.corp_address1_type_desc 		:= IF((STRING)(pInput.executive_address+pInput.executive_city)='','', 'BUSINESS');
  SELF.corp_address1_line1 			:= pInput.executive_address;
  SELF.corp_address1_line3			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_City);
  SELF.corp_address1_line4			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_State);
  SELF.corp_address1_line5			:= corp2_mapping.functions.TRIMUpper((STRING)pInput.executive_zip);
  SELF.cont_name 					:= name;
  SELF.cont_address_line1 			:= CHOOSE(c,pInput.people1_address,pInput.people2_address,pInput.people3_address) ;

  SELF.cont_address_line3 			:= corp2_mapping.functions.TRIMUpper((STRING)CHOOSE(c,pInput.people1_city,pInput.people2_city,pInput.people3_city));
  SELF.cont_address_line4 			:= corp2_mapping.functions.TRIMUpper((STRING)CHOOSE(c,pInput.people1_state,pInput.people2_state,pInput.people3_state));
  SELF.cont_address_line5 			:= corp2_mapping.functions.TRIMUpper((STRING)CHOOSE(c,pInput.people1_zip,pInput.people2_zip,pInput.people3_zip));
  SELF.cont_address_type_desc    	:= IF((STRING)(pInput.agent_address1+pInput.agent_city)<>'', 'REGISTERED OFFICE' , '');
  SELF.cont_type_cd 				:= 'M';
  SELF.cont_type_desc 				:= 'MEMBER/MANAGER/PARTNER';
  SELF.cont_title1_desc 			:= CASE((string)pInput.file_number[8..8],'0'=>'PARTNER','1'=>'MEMBER','');
  SELF.cont_title2_desc 			:= CASE((string)pInput.file_number[8..8],'1'=>'MANAGER','');
  SELF.cont_addl_info 				:= IF(REGEXREPLACE('0',(STRING)pinput.addl_gp,'')<>'',REGEXREPLACE('^0',(STRING)pinput.addl_gp,'')+' ADDITIONAL GPs NOT LISTED', '');
  SELF.cont_cname1 			    	:= IF((integer)pname[71..73]>85  ,'',
										     IF(regexfind('[0~9]|[a-z]|[A-Z]',cname),cname,
										     IF(Cname='',corp2_mapping.functions.TRIMUpper(SELF.cont_name),'')));
  SELF.cont_cname1_score 			:= IF(SELF.cont_cname1='','',pName[71..73]);
  SELF.cont_title1		    		:= IF(SELF.cont_cname1='', pname[1..5], '');
  SELF.cont_fname1 					:= IF(SELF.cont_cname1='', pname[6..25], '');
  SELF.cont_mname1 					:= IF(SELF.cont_cname1='', pname[26..45], '');
  SELF.cont_lname1 					:= IF(SELF.cont_cname1='', pname[46..65], '');
  SELF.cont_name_suffix1 			:= IF(SELF.cont_cname1='', pname[66..70], '');
  SELF.cont_score1 					:= IF(SELF.cont_cname1='', pname[71..73], '');
  SELF.corp_addr1_prim_range  		:= clean_address[1..10];
  SELF.corp_addr1_predir 	    	:= clean_address[11..12];
  SELF.corp_addr1_prim_name 		:= clean_address[13..40];
  SELF.corp_addr1_addr_suffix 		:= clean_address[41..44];
  SELF.corp_addr1_postdir 			:= clean_address[45..46];
  SELF.corp_addr1_unit_desig 		:= clean_address[47..56];
  SELF.corp_addr1_sec_range 		:= clean_address[57..64];
  SELF.corp_addr1_p_city_name		:= clean_address[65..89];
  SELF.corp_addr1_v_city_name		:= clean_address[90..114];
  SELF.corp_addr1_state 			:= clean_address[115..116];
  SELF.corp_addr1_zip5 				:= clean_address[117..121];
  SELF.corp_addr1_zip4 				:= clean_address[122..125];
  SELF.corp_addr1_cart 				:= clean_address[126..129];
  SELF.corp_addr1_cr_sort_sz 		:= clean_address[130];
  SELF.corp_addr1_lot 				:= clean_address[131..134];
  SELF.corp_addr1_lot_order 		:= clean_address[135];
  SELF.corp_addr1_dpbc 				:= clean_address[136..137];
  SELF.corp_addr1_chk_digit 		:= clean_address[138];
  SELF.corp_addr1_rec_type			:= clean_address[139..140];
  SELF.corp_addr1_ace_fips_st		:= clean_address[141..142];
  SELF.corp_addr1_county 	  		:= clean_address[143..145];
  SELF.corp_addr1_geo_lat 			:= clean_address[146..155];
  SELF.corp_addr1_geo_long 			:= clean_address[156..166];
  SELF.corp_addr1_msa 				:= clean_address[167..170];
  SELF.corp_addr1_geo_blk			:= clean_address[171..177];
  SELF.corp_addr1_geo_match 		:= clean_address[178];
  SELF.corp_addr1_err_stat 			:= clean_address[179..182];
  SELF.cont_prim_range    			:= clean_address1[1..10];
  SELF.cont_predir 	    			:= clean_address1[11..12];
  SELF.cont_prim_name 	  			:= clean_address1[13..40];
  SELF.cont_addr_suffix   			:= clean_address1[41..44];
  SELF.cont_postdir 	    		:= clean_address1[45..46];
  SELF.cont_unit_desig 				:= clean_address1[47..56];
  SELF.cont_sec_range 	  			:= clean_address1[57..64];
  SELF.cont_p_city_name				:= clean_address1[65..89];
  SELF.cont_v_city_name				:= clean_address1[90..114];
  SELF.cont_state		    		:= clean_address1[115..116];
  SELF.cont_zip5 		    		:= clean_address1[117..121];
  SELF.cont_zip4 		    		:= clean_address1[122..125];
  SELF.cont_cart 		    		:= clean_address1[126..129];
  SELF.cont_cr_sort_sz 				:= clean_address1[130];
  SELF.cont_lot 		    		:= clean_address1[131..134];
  SELF.cont_lot_order 	  			:= clean_address1[135];
  SELF.cont_dpbc 		    		:= clean_address1[136..137];
  SELF.cont_chk_digit 	  	    	:= clean_address1[138];
  SELF.cont_rec_type				:= clean_address1[139..140];
  SELF.cont_ace_fips_st				:= clean_address1[141..142];
  SELF.cont_county 	  				:= clean_address1[143..145];
  SELF.cont_geo_lat 	    		:= clean_address1[146..155];
  SELF.cont_geo_long 	    		:= clean_address1[156..166];
  SELF.cont_msa 		    		:= clean_address1[167..170];
  SELF.cont_geo_blk					:= clean_address1[171..177];
  SELF.cont_geo_match 	  			:= clean_address1[178];
  SELF.cont_err_stat 	    		:= clean_address1[179..182];	
  SELF                       		:=[];
end;
corp2.layout_Corporate_Direct_cont_in Trans_Cont(Layout_mast pInput)
:=TRANSFORM 
   clean_address 	    		  := Address.CleanAddress182((String)pInput.Mail_Address1+' '+(String)pInput.Mail_Address2,
																regexreplace('[ ]+',(String)pInput.Mail_Address_City +' '
																+(String)pInput.Mail_Address_State+ ','
																+(String)pInput.Mail_Address_ZipCode,' '));	
  clean_ra_address 				  := Address.CleanAddress182((String)pInput.President_Address1+' '+(String)pInput.President_Address2,
																regexreplace('[ ]+',(String)pInput.President_Address_City+ ' '
																+(String)pInput.President_Address_state + ' ' 
  															    +(String)pInput.President_Address_ZipCode,' '));
  pname			    			  := Address.CleanPersonFML73(pInput.President_Name);
 
  SELF.dt_first_seen				:= filedate;
  SELF.dt_last_seen					:= filedate;
  SELF.corp_key 					:= '06-'+trim((STRING) pInput.Corp_Number,all);
  SELF.corp_vendor 					:= '06';
  SELF.corp_state_origin 			:= 'CA';
  SELF.corp_process_date 			:= filedate;
  SELF.corp_orig_sos_charter_nbr 	:= 'C'+REGEXREPLACE('^0',trim((string) pInput.Corp_Number,all),'');
  SELF.corp_legal_name 				:= pInput.Corp_Name;
  SELF.corp_address1_type_desc 		:= IF((string) (pInput.Mail_Address1+pInput.Mail_Address_City)<>'', 'MAILING','');
  //SELF.corp_address1_line1 			:= pInput.Care_of_Name;
  SELF.corp_address1_line1			:= corp2_mapping.functions.TRIMUpper((string)pInput.Mail_Address1);
  SELF.corp_address1_line2 			:= corp2_mapping.functions.TRIMUpper((string)pInput.Mail_Address2);
  SELF.corp_address1_line3			:= corp2_mapping.functions.TRIMUpper((string)pInput.Mail_Address_City);
  SELF.corp_address1_line4			:= corp2_mapping.functions.TRIMUpper((string)pInput.Mail_Address_State);
  SELF.corp_address1_line5			:= corp2_mapping.functions.TRIMUpper((string)pInput.Mail_Address_ZipCode);
  SELF.cont_title1_desc 			:= 'PRESIDENT';
  SELF.cont_type_desc 				:= 'OFFICER';
  SELF.cont_name 					:= corp2_mapping.functions.TRIMUpper(regexreplace(' +',(string)pInput.President_Name,' '));
  SELF.cont_address_type_desc    	:= IF((string)(pInput.President_Address1+pInput.President_Address_City) <>'', 'CONTACT', '');
  SELF.cont_address_line1 		    := corp2_mapping.functions.TRIMUpper((string)pInput.President_Address1);
  SELF.cont_address_line2 		    := corp2_mapping.functions.TRIMUpper((string)pInput.President_Address2);
  SELF.cont_address_line3 		    := corp2_mapping.functions.TRIMUpper((string)pInput.President_Address_City);
  SELF.cont_address_line4 		    := corp2_mapping.functions.TRIMUpper((string)pInput.President_Address_State);
  SELF.cont_address_line5 		    := pInput.President_Address_ZipCode;
  SELF.cont_title1		    		:= pname[1..5];
  SELF.cont_fname1 					:= pname[6..25];
  SELF.cont_mname1 					:= pname[26..45];
  SELF.cont_lname1 					:= pname[46..65];
  SELF.cont_name_suffix1 			:= pname[66..70];
  SELF.cont_score1 					:= pname[71..73];
  SELF.cont_prim_range    			:= clean_ra_address[1..10];
  SELF.cont_predir 	    			:= clean_ra_address[11..12];
  SELF.cont_prim_name 	  			:= clean_ra_address[13..40];
  SELF.cont_addr_suffix   			:= clean_ra_address[41..44];
  SELF.cont_postdir 	    		:= clean_ra_address[45..46];
  SELF.cont_unit_desig 				:= clean_ra_address[47..56];
  SELF.cont_sec_range 	  			:= clean_ra_address[57..64];
  SELF.cont_p_city_name				:= clean_ra_address[65..89];
  SELF.cont_v_city_name				:= clean_ra_address[90..114];
  SELF.cont_state		    		:= clean_ra_address[115..116];
  SELF.cont_zip5 		    		:= clean_ra_address[117..121];
  SELF.cont_zip4 		    		:= clean_ra_address[122..125];
  SELF.cont_cart 		    		:= clean_ra_address[126..129];
  SELF.cont_cr_sort_sz 				:= clean_ra_address[130];
  SELF.cont_lot 		    		:= clean_ra_address[131..134];
  SELF.cont_lot_order 	  			:= clean_ra_address[135];
  SELF.cont_dpbc 		    		:= clean_ra_address[136..137];
  SELF.cont_chk_digit 	  	    	:= clean_ra_address[138];
  SELF.cont_rec_type				:= clean_ra_address[139..140];
  SELF.cont_ace_fips_st				:= clean_ra_address[141..142];
  SELF.cont_county 	  				:= clean_ra_address[143..145];
  SELF.cont_geo_lat 	    		:= clean_ra_address[146..155];
  SELF.cont_geo_long 	    		:= clean_ra_address[156..166];
  SELF.cont_msa 		    		:= clean_ra_address[167..170];
  SELF.cont_geo_blk					:= clean_ra_address[171..177];
  SELF.cont_geo_match 	  			:= clean_ra_address[178];
  SELF.cont_err_stat 	    		:= clean_ra_address[179..182];													
  SELF.corp_addr1_prim_range  		:= clean_address[1..10];
  SELF.corp_addr1_predir 	    	:= clean_address[11..12];
  SELF.corp_addr1_prim_name 		:= clean_address[13..40];
  SELF.corp_addr1_addr_suffix 		:= clean_address[41..44];
  SELF.corp_addr1_postdir 			:= clean_address[45..46];
  SELF.corp_addr1_unit_desig 		:= clean_address[47..56];
  SELF.corp_addr1_sec_range 		:= clean_address[57..64];
  SELF.corp_addr1_p_city_name		:= clean_address[65..89];
  SELF.corp_addr1_v_city_name		:= clean_address[90..114];
  SELF.corp_addr1_state 			:= clean_address[115..116];
  SELF.corp_addr1_zip5 				:= clean_address[117..121];
  SELF.corp_addr1_zip4 				:= clean_address[122..125];
  SELF.corp_addr1_cart 				:= clean_address[126..129];
  SELF.corp_addr1_cr_sort_sz 		:= clean_address[130];
  SELF.corp_addr1_lot 				:= clean_address[131..134];
  SELF.corp_addr1_lot_order 		:= clean_address[135];
  SELF.corp_addr1_dpbc 				:= clean_address[136..137];
  SELF.corp_addr1_chk_digit 		:= clean_address[138];
  SELF.corp_addr1_rec_type			:= clean_address[139..140];
  SELF.corp_addr1_ace_fips_st		:= clean_address[141..142];
  SELF.corp_addr1_county 	  		:= clean_address[143..145];
  SELF.corp_addr1_geo_lat 			:= clean_address[146..155];
  SELF.corp_addr1_geo_long 			:= clean_address[156..166];
  SELF.corp_addr1_msa 				:= clean_address[167..170];
  SELF.corp_addr1_geo_blk			:= clean_address[171..177];
  SELF.corp_addr1_geo_match 		:= clean_address[178];
  SELF.corp_addr1_err_stat 			:= clean_address[179..182]; 
  Self         				        := [];
end;

corp2.layout_Corporate_Direct_Stock_in Trans_Stock(Layout_mast pInput)
:=TRANSFORM

	SELF.corp_key 							:='06-'+(STRING)pInput.Corp_Number;
	SELF.corp_vendor 						:='06';
	SELF.corp_state_origin 			:='CA';
	SELF.corp_process_date 			:= filedate;
	SELF.corp_sos_charter_nbr 	:='C'+(STRING)IF(pInput.Corp_Number[1]='0',pInput.Corp_Number[2..8],pInput.Corp_Number);
	SELF.stock_addl_info				:= map (corp2_mapping.functions.TRIMUpper(pInput.corp_tax_base) = 'S' => 'STOCK',
																			corp2_mapping.functions.TRIMUpper(pInput.corp_tax_base) = 'N' => 'NON-STOCK (NONPROFIT)',
																			''
																			);
	SELF												:= [];
end;
 
corp2.layout_Corporate_Direct_event_in tNormalizeName(Layout_mast pInput, unsigned c)
:=TRANSFORM 
  filing_date  :=IF(pinput.Statement_of_File_Date[1..2]='35','19'+(string)pinput.Statement_of_File_Date, 
                    IF(pinput.Statement_of_File_Date[1..2]<>'','20'+(string)pInput.Statement_of_File_Date,''));

  SELF.corp_sos_charter_nbr 	    := 'C'+REGEXREPLACE('^0',trim((STRING) pInput.Corp_Number,all),'');
  SELF.corp_key 					:= '06-'+trim((STRING) pInput.Corp_Number,all);
  SELF.corp_vendor 					:= '06';
  SELF.corp_state_origin 			:= 'CA';
  SELF.corp_process_date 			:= filedate;
  SELF.event_date_type_desc         := CHOOSE(C,IF(pinput.FTB_Suspen_Date='',skip,IF(((string)pInput.FTB_Suspen_Status_Code+'S')[1]='S','SUSPENSION',
                                                  IF(pInput.FTB_Suspen_Status_Code='F','FORFEITURE',''))),
												IF(pInput.Statement_of_File_Date='',skip,'FILING'));
  SELF.event_filing_desc            := IF(SELF.event_date_type_desc<>'FILING','', 'STATEMENT OF OFFICERS');
  SELF.event_filing_reference_nbr   := pInput.Statement_of_Officers_File_Num ;
  SELF                              := [];
end;

corp2.layout_Corporate_Direct_event_in Trans_event(Layout_hist  pInput)
:=TRANSFORM

	SELF.corp_key 					:='06-'+(STRING)pInput.Corp_Number;
	SELF.corp_vendor 				:='06';
	SELF.corp_state_origin 			:='CA';
	SELF.corp_process_date 			:= filedate;
	SELF.corp_sos_charter_nbr 		:='C'+(STRING)IF(pInput.Corp_Number[1]='0',pInput.Corp_Number[2..8],pInput.Corp_Number);
	SELF.event_filing_date 			:= pInput.Transaction_Date;
	SELF.event_date_type_desc 		:='FILING';
	SELF.event_filing_reference_nbr		:= pInput.Amendment_Number;
	SELF.event_filing_cd 			:= pInput.Transaction_Code;
	SELF.event_filing_desc 			:= corp2_mapping.functions.Decode_Trans(pInput.Transaction_Code);
	SELF.event_corp_nbr 			:= IF(pInput.Name_Corp_Number[1]='6' OR pInput.Name_Corp_Number='', '' ,'C'+ REGEXREPLACE('^0',pInput.Name_Corp_Number,''));
	SELF.event_desc 				:= MAP( pInput.Transaction_Code='AMDT' AND pInput.Comment='UPDATED'=>'AMENDMENT - FILE REVIEWED BY SOS (NO CERT. AVAILABLE',
											pInput.Transaction_Code='DSMR' AND pInput.Comment ='OFF'=>'OFFICER',
											pInput.Transaction_Code='DSMR' AND pInput.Comment ='PERS'=>'PRESIDENT',
											pInput.Transaction_Code='DSMR' AND pInput.Comment ='DIR'=>'DIRECTOR',
											pInput.Comment[1..11]='NAME CHANGE' AND pInput.Old_Corp_Name<>''=>corp2_mapping.functions.TRIMUpper(pInput.Comment)+' '+corp2_mapping.functions.TRIMUpper(pInput.Old_Corp_Name),
											pInput.Comment<>'' AND pInput.Old_Corp_Name<>''=>corp2_mapping.functions.TRIMUpper(pInput.Comment)+';'+corp2_mapping.functions.TRIMUpper(pInput.Old_Corp_Name),
											pInput.Comment<>''=>pInput.Comment,
											pInput.Old_Corp_Name<>''=>pInput.Old_Corp_Name,pInput.Comment);
	SELF                             :=[];
END;
 

dmast	  :=DATASET('~thor_data400::in::corp2::'+filedate+'::MAST::CA',Layout_mast ,flat);
dhist	  :=DATASET('~thor_data400::in::corp2::'+filedate+'::hist::CA',Layout_hist ,flat);
dlp 	  :=DATASET('~thor_data400::in::corp2::'+filedate+'::lp::CA',Layout_lp ,flat);

dcorp     :=PROJECT(dmast,Trans_Corp(left))+PROJECT(dlp((STRING)name<>''),Trans_Corplp(left));
dStock		:=PROJECT(dmast,Trans_Stock(left));
devent    :=PROJECT(dhist,TRANS_EVENT(LEFT))+NORMALIZE(dmast(Statement_of_File_Date<>'' or FTB_Suspen_Date<>'')  ,2,tNormalizeName(LEFT,counter));
dCont     :=PROJECT(dmast((STRING)president_name<>''),Trans_Cont(left))+NORMALIZE(dlp(people1_name<>''),3,tNormalizeCont(LEFT,COUNTER));

//**************************************************************************
// 									Output
//**************************************************************************
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::corp::CA'	,dedup(dCorp,ALL)																	,corp_out		,,,pOverwrite);		
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::stock::CA',dedup(dStock,EXCEPT corp_key, ALL)								,stock_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::event::CA',dedup(dEvent,EXCEPT corp_key, ALL)								,event_out	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::in::corp2::'+version+'::cont::CA'	,dedup(dCont(cont_fname1+cont_cname1 <>''),all)		,cont_out		,,,pOverwrite);
                                                                                                                                                          
dOut:= sequential(
	 corp_out	
	,stock_out
	,event_out
	,cont_out	
);

result := 
		sequential(
			 if(pshouldspray = true,fSprayFiles('ca',filedate,pOverwrite := pOverwrite))
			,dOut
			,parallel(
				 fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::corp'	,'~thor_data400::in::corp2::'+version+'::corp::CA')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::cont'	,'~thor_data400::in::corp2::'+version+'::cont::CA')
				,fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::stock','~thor_data400::in::corp2::'+version+'::stock::CA')												 
				,Fileservices.addsuperfile('~thor_data400::in::corp2::sprayed::event','~thor_data400::in::corp2::'+version+'::event::CA')
			)							
		);


		return result;
				  
END;