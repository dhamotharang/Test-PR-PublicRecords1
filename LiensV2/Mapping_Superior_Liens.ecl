import liensV2;
// Mapping judgments file
liensV2.Layout_Liens_temp_base mapping_judgement(LiensV2.Layout_Liens_Superior_Judgment_In L) := transform

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.record_code  := 'C';
self.date_vendor_removed:= '';
self.filing_jurisdiction := L.description;
self.filing_state := L.header_filing_state;
self.orig_filing_number :=  L.case_number;
self.orig_filing_type   := L.filing_type_desc;
self.orig_filing_date   := '';
self.orig_filing_time   := '';
self.filing_status     := if(L.disp_code_desc <> '' , L.disp_code_desc , L.status_code_desc) ;
self.case_number        := L.header_casenumber_num_prefix + '-' +L.header_casenumber_seq_num 
	  + '-' + L.header_casenumber_year + '-' + L.header_casenumber_suffix ;

	  
self.filing_number  := '';
self.filing_type_desc := l.case_type_desc;
self.filing_date := l.docket_date;
//self.status_date := l.disposition_dt ;
self.filing_time := '';
self.vendor_entry_date := '';
self.judge := L.judge_name;
self.case_title := '';
self.filing_book  := '';
self.filing_page  := '';
self.release_date := '';
self.amount       := '';
self.eviction     := '';
self.judg_satisfied_date := '';
self.judg_vacated_date := '';
self.tax_code := L.tax_type_code_desc;
self.irs_serial_number := '';
self.effective_date    := '';
self.lapse_date        := '';
self.agency := L.place_filed;
self.agency_city :='';
self.agency_state := L.header_filing_state;
self.agency_county :=  L.county;

end; 

mapping_superior_judgment_liens := project(LiensV2.file_superior_judgment_header_in,mapping_judgement(left));

// Mapping sub judgments file
liensV2.Layout_Liens_temp_base mapping_sub_judgement(LiensV2.Layout_Liens_Superior_Sub_Judgment_In L) := transform

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.record_code  := 'E';
self.date_vendor_removed:= '';
self.filing_jurisdiction := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';
self.filing_page  := '';
self.release_date := '';
self.amount       := L.TOTAL_AMOUNT;
//self.status_date := L.DISPOSITION_DATE ;
self.eviction     := '';
self.filing_status := if(L.disp_code_desc <> ''  , L.disp_code_desc , L.status_code_desc) ;
end; 

mapping_superior_sub_judgment_liens := project(LiensV2.file_superior_subjudgment_header_in,mapping_sub_judgement(left));

//Mapping remarks file
/*liensV2.Layout_Liens_temp_base mapping_remarks(LiensV2.Layout_Liens_Superior_Remarks_In L) := transform

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.record_code  := 'X';
self.date_vendor_removed:= '';
self.filing_jurisdiction := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';
self.filing_page  := '';
self.release_date := '';
self.amount       := '';
self.eviction     := '';
//self.remarks := l.remarks ;
end; 

mapping_superior_remarks_liens := project(LiensV2.file_Superior_Remarks_in,mapping_remarks(left)); */

//mapping  debtor file 
liensV2.Layout_Liens_temp_base mapping_debtor(LiensV2.Layout_Liens_Superior_Debtor_In L) := transform

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.record_code  := '';
self.date_vendor_removed:= '';
self.filing_jurisdiction := '';
self.judge := '';
self.case_title := '';
self.filing_book  := '';
self.filing_page  := '';
self.release_date := '';
self.debtor_name := L.DEBTOR_NAME; 
//self.debtor_name_desc := L.name_code_desc_1;
//self.debtor_name_association := L.link_code_desc;
//self.debtor_dob := L.DATE_OF_BIRTH; 
self.debtor_lname := '';
self.debtor_fname := '';
self.debtor_mname := '';
self.debtor_suffix := '';
self.debtor_tax_id :=  if(L.DEBTOR_TYPE = 'C', stringlib.stringfilterout(L.ssn,'-'), '');
self.debtor_ssn :=     if(L.DEBTOR_TYPE = 'I', stringlib.stringfilterout(L.ssn,'-'), '');
self.debtor_address1 := map(L.unit_number= '' and L.street_number= '' and L.street_direction ='' and L.street_name ='' and L.street_type ='' =>l.address2,
                         l.unit_number<> '' and l.street_number <> '' and l.unit_number = l.street_number => L.street_number + ' ' + L.street_direction,
						  l.unit_number+' '+ L.street_number + ' ' + L.street_direction) ;
self.debtor_address2 := if(L.unit_number= '' and L.street_number= '' and L.street_direction ='' and L.street_name ='' and L.street_type ='','',L.street_name + ' ' + L.street_type);
self.debtor_city := L.city_name;
self.debtor_state := L.st;
self.debtor_zip5 := L.z5;
self.debtor_zip4 := L.z4;
self.debtor_county := '';
self.debtor_country :='';
self.clean_debtor_title						:= L.clean_debtor_pname[1..5]			    ;
self.clean_debtor_fname						:= L.clean_debtor_pname[6..25]			;
self.clean_debtor_mname						:= L.clean_debtor_pname[26..45]			;
self.clean_debtor_lname						:= L.clean_debtor_pname[46..65]			;
self.clean_debtor_name_suffix	   		 :=    L.clean_debtor_pname[66..70]			;
self.clean_debtor_score				     :=    L.clean_debtor_pname[71..73]			;
self.clean_debtor_prim_range 		     :=    L.clean_debtor_address[1..10]				;
self.clean_debtor_predir     		     :=	   L.clean_debtor_address[11..12]				;
self.clean_debtor_prim_name			     := 	L.clean_debtor_address[13..40]				;
self.clean_debtor_addr_suffix		     := 	L.clean_debtor_address[41..44]				;
self.clean_debtor_postdir				:=		L.clean_debtor_address[45..46]				;
self.clean_debtor_unit_desig			:= 		L.clean_debtor_address[47..56]				;
self.clean_debtor_sec_range				:= 		L.clean_debtor_address[57..64]				;
self.clean_debtor_p_city_name			:= 		L.clean_debtor_address[65..89]				;
self.clean_debtor_v_city_name			:= 		L.clean_debtor_address[90..114]				;
self.clean_debtor_st					:= 		L.clean_debtor_address[115..116]			;
self.clean_debtor_zip					:=		L.clean_debtor_address[117..121]			;
self.clean_debtor_zip4					:=		L.clean_debtor_address[122..125]			;
self.clean_debtor_cart					:=		L.clean_debtor_address[126..129]			;
self.clean_debtor_cr_sort_sz			:=		L.clean_debtor_address[130]					;
self.clean_debtor_lot					:=		L.clean_debtor_address[131..134]			;
self.clean_debtor_lot_order				:=		L.clean_debtor_address[135]					;
self.clean_debtor_dpbc					:=		L.clean_debtor_address[136..137]			;
self.clean_debtor_chk_digit				:=		L.clean_debtor_address[138]					;
self.clean_debtor_record_type			:=		L.clean_debtor_address[139..140]			;
self.clean_debtor_ace_fips_st			:=		L.clean_debtor_address[141..142]			;
self.clean_debtor_fipscounty			:=		L.clean_debtor_address[143..145]			;
self.clean_debtor_geo_lat				:=		L.clean_debtor_address[146..155]			;
self.clean_debtor_geo_long				:=		L.clean_debtor_address[156..166]			;
self.clean_debtor_msa					:=		L.clean_debtor_address[167..170]			;
self.clean_debtor_geo_match				:=		L.clean_debtor_address[178]					;
self.clean_debtor_err_stat				:=		L.clean_debtor_address[179..182]		;
self.clean_debtor_cname := L.clean_debtor_cname;

end ; 
mapping_superior_debtor_liens_pro := project(LiensV2.file_Superior_Debtor_in,mapping_debtor(left)); 
mapping_superior_debtor_liens :=  mapping_superior_debtor_liens_pro(debtor_name <> '');
//mapping debtor attroney 
liensV2.Layout_Liens_temp_base mapping_debtor_atty(LiensV2.Layout_Liens_Superior_Debtor_Atty_In L) :=  transform 

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
//self.thd_name 			:= if(L.ATTORNEY_NAME ='' and l.FIRM_NAME <> '',l.FIRM_NAME,L.ATTORNEY_NAME); //check atty company name naming

self.thd_name 			:= map(L.ATTORNEY_NAME ='' and l.FIRM_NAME <> '' =>l.FIRM_NAME,
                               L.ATTORNEY_NAME <>'' and l.FIRM_NAME = ''  => L.ATTORNEY_NAME,L.ATTORNEY_NAME);
self.thd_lname			:= '';
self.thd_fname			:= '';
self.thd_mname			:= '';
self.thd_address1 		:=L.ADDRESS_LINE_1; 
self.thd_address2 		:=L.ADDRESS_LINE_2;    
self.thd_city 			:=L.CITY; 
self.thd_state 			:= L.STATE; 
self.thd_zip5 			:=L.ZIP5;
self.thd_zip4 			:=L.ZIP4;
self.thd_phone          := L.PHONE_NUMBER;
//self.debtoratty_license_number := l.STATE_ASSIGNED_LICENSE_NUMBER;
self.clean_thd_title				:=      L.clean_atty_pname[1..5]			    ;
self.clean_thd_fname				:=      L.clean_atty_pname[6..25]			;
self.clean_thd_mname				:=      L.clean_atty_pname[26..45]			;
self.clean_thd_lname				:=      L.clean_atty_pname[46..65]			;
self.clean_thd_name_suffix	   		:=      L.clean_atty_pname[66..70]			;
self.clean_thd_score		        :=      L.clean_atty_pname[71..73]			;
self.clean_thd_prim_range 		    := 		L.clean_atty_address[1..10]				;
self.clean_thd_predir     		    :=		L.clean_atty_address[11..12]				;
self.clean_thd_prim_name			:= 		L.clean_atty_address[13..40]				;
self.clean_thd_addr_suffix		    := 		L.clean_atty_address[41..44]				;
self.clean_thd_postdir				:=		L.clean_atty_address[45..46]				;
self.clean_thd_unit_desig			:= 		L.clean_atty_address[47..56]				;
self.clean_thd_sec_range			:= 		L.clean_atty_address[57..64]				;
self.clean_thd_p_city_name			:= 		L.clean_atty_address[65..89]				;
self.clean_thd_v_city_name			:= 		L.clean_atty_address[90..114]				;
self.clean_thd_st					:= 		L.clean_atty_address[115..116]			;
self.clean_thd_zip					:=		L.clean_atty_address[117..121]			;
self.clean_thd_zip4					:=		L.clean_atty_address[122..125]			;
self.clean_thd_cart					:=		L.clean_atty_address[126..129]			;
self.clean_thd_cr_sort_sz			:=		L.clean_atty_address[130]					;
self.clean_thd_lot					:=		L.clean_atty_address[131..134]			;
self.clean_thd_lot_order			:=		L.clean_atty_address[135]					;
self.clean_thd_dpbc					:=		L.clean_atty_address[136..137]			;
self.clean_thd_chk_digit			:=		L.clean_atty_address[138]					;
self.clean_thd_record_type			:=		L.clean_atty_address[139..140]			;
self.clean_thd_ace_fips_st			:=		L.clean_atty_address[141..142]			;
self.clean_thd_fipscounty			:=		L.clean_atty_address[143..145]			;
self.clean_thd_geo_lat				:=		L.clean_atty_address[146..155]			;
self.clean_thd_geo_long				:=		L.clean_atty_address[156..166]			;
self.clean_thd_msa					:=		L.clean_atty_address[167..170]			;
self.clean_thd_geo_match		    :=		L.clean_atty_address[178]					;
self.clean_thd_err_stat				:=		L.clean_atty_address[179..182]		;
self.clean_thd_cname := L.clean_atty_cname;
//self.atty_phone := L.PHONE_NUMBER ;
end; 
mapping_superior_debtor_atty_liens_pro := project(LiensV2.file_Superior_Debtor_Atty_in,mapping_debtor_atty(left)); 
mapping_superior_debtor_atty_liens := mapping_superior_debtor_atty_liens_pro(thd_name <>'');

//mapping creditor file  
liensV2.Layout_Liens_temp_base mapping_creditor(LiensV2.Layout_liens_Superior_Creditor_in L) :=  transform 

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.creditor_name   	:= L.CREDITOR_NAME;
//self.creditor_name_desc := l.name_code_desc_1;
//self.creditor_name_association := L.link_code_desc;
self.creditor_lname		:= '';
self.creditor_fname		:= '';
self.creditor_mname		:= '';
self.creditor_address1 	:= map(L.unit_number= '' and L.street_number= '' and L.street_direction ='' and L.street_name ='' and L.STREET_TYPE_USPS_STD_CODE ='' =>l.STREET_ADDRESS2,
                         l.unit_number<> '' and l.street_number <> '' and l.unit_number = l.street_number => L.street_number + ' ' + L.street_direction,
						  l.unit_number+' '+ L.street_number + ' ' + L.street_direction) ;

self.creditor_address2 	:= if(L.unit_number= '' and L.street_number= '' and L.street_direction ='' and L.street_name ='' and L.STREET_TYPE_USPS_STD_CODE ='' ,'',L.STREET_NAME + ' ' + L.STREET_TYPE_USPS_STD_CODE);
self.creditor_city     	:= L.CITY_NAME;
self.creditor_state    	:= L.STATE_ABBREVIATION;
self.creditor_zip5     	:= L.ZIPS;
self.creditor_zip4     	:= L.ZIP4;
self.creditor_country  	:= '';
self.clean_creditor_title				:=      L.clean_creditor_pname[1..5]			    ;
self.clean_creditor_fname				:=      L.clean_creditor_pname[6..25]			;
self.clean_creditor_mname				:=      L.clean_creditor_pname[26..45]			;
self.clean_creditor_lname				:=      L.clean_creditor_pname[46..65]			;
self.clean_creditor_name_suffix	   		:=      L.clean_creditor_pname[66..70]			;
self.clean_creditor_score				:=      L.clean_creditor_pname[71..73]			;
self.clean_creditor_prim_range 		    := 		L.clean_creditor_address[1..10]				;
self.clean_creditor_predir     		    :=		L.clean_creditor_address[11..12]				;
self.clean_creditor_prim_name			:= 		L.clean_creditor_address[13..40]				;
self.clean_creditor_addr_suffix		    := 		L.clean_creditor_address[41..44]				;
self.clean_creditor_postdir				:=		L.clean_creditor_address[45..46]				;
self.clean_creditor_unit_desig			:= 		L.clean_creditor_address[47..56]				;
self.clean_creditor_sec_range			:= 		L.clean_creditor_address[57..64]				;
self.clean_creditor_p_city_name			:= 		L.clean_creditor_address[65..89]				;
self.clean_creditor_v_city_name			:= 		L.clean_creditor_address[90..114]				;
self.clean_creditor_st					:= 		L.clean_creditor_address[115..116]			;
self.clean_creditor_zip				    :=		L.clean_creditor_address[117..121]			;
self.clean_creditor_zip4				:=		L.clean_creditor_address[122..125]			;
self.clean_creditor_cart				:=		L.clean_creditor_address[126..129]			;
self.clean_creditor_cr_sort_sz		:=		L.clean_creditor_address[130]					;
self.clean_creditor_lot				:=		L.clean_creditor_address[131..134]			;
self.clean_creditor_lot_order		:=		L.clean_creditor_address[135]					;
self.clean_creditor_dpbc			:=		L.clean_creditor_address[136..137]			;
self.clean_creditor_chk_digit		:=		L.clean_creditor_address[138]					;
self.clean_creditor_record_type		:=		L.clean_creditor_address[139..140]			;
self.clean_creditor_ace_fips_st		:=		L.clean_creditor_address[141..142]			;
self.clean_creditor_fipscounty		:=		L.clean_creditor_address[143..145]			;
self.clean_creditor_geo_lat			:=		L.clean_creditor_address[146..155]			;
self.clean_creditor_geo_long		:=		L.clean_creditor_address[156..166]			;
self.clean_creditor_msa				:=		L.clean_creditor_address[167..170]			;
self.clean_creditor_geo_match		:=		L.clean_creditor_address[178]					;
self.clean_creditor_err_stat		:=		L.clean_creditor_address[179..182]		;
self.clean_creditor_cname := L.clean_creditor_cname;
end; 
mapping_superior_creditor_pro := project(LiensV2.file_Superior_Creditor_in,mapping_creditor(left)); 
mapping_superior_creditor := mapping_superior_creditor_pro(creditor_name <> '') ;

//mapping creditor attorney file 
liensV2.Layout_Liens_temp_base mapping_creditor_atty(LiensV2.Layout_Liens_Superior_Creditor_Atty_In L) :=  transform 

self.tmsid  := L.tmsid;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
//self.atty_Name         	:= L.ATTORNEY_NAME;
self.atty_Name         	:= map(L.ATTORNEY_NAME ='' and l.FIRM_NAME <> '' =>l.FIRM_NAME,
                               L.ATTORNEY_NAME <>'' and l.FIRM_NAME = ''  => L.ATTORNEY_NAME,L.ATTORNEY_NAME);
self.atty_lname			:= '';
self.atty_fname			:= '';
self.atty_mname			:= '';
self.atty_address1     	:= L.ADDRESS_LINE_1;
self.atty_address2     	:= L.ADDRESS_LINE_2;
self.atty_city         	:= L.CITY;
self.atty_state        	:= L.STATE;
self.atty_zip5         	:= L.ZIP5;
self.atty_zip4         	:= L.ZIP4;
self.atty_phone        	:= L.PHONE_NUMBER;
//self.Credatty_license_number := l.STATE_ASSIGNED_LICENSE_NUMBER ;
self.clean_atty_title				:=      L.clean_atty_pname[1..5]			    ;
self.clean_atty_fname				:=      L.clean_atty_pname[6..25]			;
self.clean_atty_mname				:=      L.clean_atty_pname[26..45]			;
self.clean_atty_lname				:=      L.clean_atty_pname[46..65]			;
self.clean_atty_name_suffix	   		:=      L.clean_atty_pname[66..70]			;
self.clean_atty_score		        :=      L.clean_atty_pname[71..73]			;
self.clean_atty_prim_range 		    := 		L.clean_atty_address[1..10]				;
self.clean_atty_predir     		    :=		L.clean_atty_address[11..12]				;
self.clean_atty_prim_name			:= 		L.clean_atty_address[13..40]				;
self.clean_atty_addr_suffix		    := 		L.clean_atty_address[41..44]				;
self.clean_atty_postdir				:=		L.clean_atty_address[45..46]				;
self.clean_atty_unit_desig			:= 		L.clean_atty_address[47..56]				;
self.clean_atty_sec_range			:= 		L.clean_atty_address[57..64]				;
self.clean_atty_p_city_name			:= 		L.clean_atty_address[65..89]				;
self.clean_atty_v_city_name			:= 		L.clean_atty_address[90..114]				;
self.clean_atty_st					:= 		L.clean_atty_address[115..116]			;
self.clean_atty_zip					:=		L.clean_atty_address[117..121]			;
self.clean_atty_zip4				:=		L.clean_atty_address[122..125]			;
self.clean_atty_cart				:=		L.clean_atty_address[126..129]			;
self.clean_atty_cr_sort_sz			:=		L.clean_atty_address[130]					;
self.clean_atty_lot					:=		L.clean_atty_address[131..134]			;
self.clean_atty_lot_order			:=		L.clean_atty_address[135]					;
self.clean_atty_dpbc				:=		L.clean_atty_address[136..137]			;
self.clean_atty_chk_digit			:=		L.clean_atty_address[138]					;
self.clean_atty_record_type			:=		L.clean_atty_address[139..140]			;
self.clean_atty_ace_fips_st			:=		L.clean_atty_address[141..142]			;
self.clean_atty_fipscounty			:=		L.clean_atty_address[143..145]			;
self.clean_atty_geo_lat				:=		L.clean_atty_address[146..155]			;
self.clean_atty_geo_long			:=		L.clean_atty_address[156..166]			;
self.clean_atty_msa					:=		L.clean_atty_address[167..170]			;
self.clean_atty_geo_match			:=		L.clean_atty_address[178]					;
self.clean_atty_err_stat			:=		L.clean_atty_address[179..182]		;
self.clean_atty_cname               :=      L.clean_atty_cname ;
end ; 

mapping_superior_creditor_atty_pro := project(LiensV2.file_Superior_Creditor_Atty_in,mapping_creditor_atty(left)); 
mapping_superior_creditor_atty := mapping_superior_creditor_atty_pro(atty_Name <> '') ;

export mapping_superior_liens := mapping_superior_judgment_liens + mapping_superior_sub_judgment_liens + mapping_superior_debtor_liens
                                 + mapping_superior_debtor_atty_liens + mapping_superior_creditor + mapping_superior_creditor_atty ;