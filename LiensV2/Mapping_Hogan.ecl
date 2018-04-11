import liensv2;


Layout_Liens_Hogan_temp := record

liensv2.file_Hogan_in ;
string county_name  ; 
string court_description ;
end ;

//New court source, MSHINC3, does not have description in the lookup file so adding it here
Layout_Liens_Hogan_temp tjoin(liensv2.file_Hogan_in L, liensv2.file_lookup_in R) := transform

self.county_name := IF(L.courtid = 'MSHINC3','',R.county_name);
self.court_description := IF(L.courtid = 'MSHINC3','MISSISSIPPI DEPT OF REVENUE',R.desc);
self := L ;
end;

filein_join := join(liensv2.file_Hogan_in, liensv2.file_lookup_in, left.COURTID = right.court_id, tjoin(left,right), left outer,many LOOKUP);

liensV2.Layout_Liens_temp_base main_mapping_format(Layout_Liens_Hogan_temp L) := transform

integer	position	:=	StringLib.StringFind(trim(L.AtyAddress,left,right), ' ', 1);
string	block	:=	if (l.courtid[1..2] = 'NY',
												l.atyAddress[1..position-1],
												''
											);
string	lot		:=	if (l.courtid[1..2] = 'NY',
												l.atyAddress[position+1..],
												''
											);		
											
self.tmsid  := trim(L.tmsid) ;
self.rmsid  := L.rmsid;
self.process_date := L.process_date;
self.record_code  := trim(L.COURTID) + L.casenumber;
self.ADDDELFLAG := L.ADDDELFLAG;
self.date_vendor_removed:= '';
self.filing_jurisdiction := L.courtid[1..2];
self.filing_state := '';
self.orig_filing_number := L.origcase;
self.orig_filing_type   := '';
self.orig_filing_date   := L.actiondate;
self.orig_filing_time   := '';
self.filing_status      := '';
self.case_number        := '';
self.filing_number  := L.casenumber;
self.filing_type_desc := L.filingtype_desc;
self.filing_date := '';
self.filing_time := '';
self.vendor_entry_date := '';
self.judge := '';
self.case_title := '';
self.filing_book  := L.book;
self.filing_page  := L.page;
self.release_date := L.ORIGLIEN;
self.amount       := L.amount;
self.eviction     := L.UNLAWDETYN;
self.judg_satisfied_date := '';
self.judg_vacated_date := '';
self.tax_code := '';
self.irs_serial_number := if(L.FILETYPEID = 'FR' or L.FILETYPEID = 'FT', L.othercase, '');
self.effective_date    := '';
self.lapse_date        := '';
self.orig_full_debtorname := '';
self.debtor_name := L.defname; 
self.debtor_lname:= '';
self.debtor_fname:= '';
self.debtor_mname:= '';
self.debtor_suffix := L.generation;
self.debtor_tax_id := if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), '', L.ssn);
self.debtor_ssn    := if(L.INDIVBUSUN ='I' and (L.AKA_YN = ' ' or L.AKA_YN = 'I'), L.ssn, '');
self.debtor_address1 := L.address;
self.debtor_address2 := '';
self.debtor_city     := L.city;
self.debtor_state    := L.state;
self.debtor_zip5     := L.zip;
self.debtor_zip4     := '';
self.debtor_country  := '';
self.creditor_name   := L.PLAINTIFF;
self.creditor_address1 := '';
self.creditor_address2 := '';
self.creditor_city     := '';
self.creditor_state    := '';
self.creditor_zip5     := '';
self.creditor_zip4     := '';
self.creditor_country  := '';
self.atty_Name         := L.ATTORNEY;
self.atty_address1      := L.ATYADDRESS;
self.atty_city         := L.ATYCITY;
self.atty_state        := L.ATYSTATE;
self.atty_zip5          := L.ATYZIP;
self.atty_phone        := L.attorphone;
self.agency            := L.court_description;
self.agency_city       := '';
self.agency_state      := L.courtid[1..2];
self.agency_county     := L.county_name ;
self.clean_debtor_title						:= L.clean_def_pname[1..5]			    ;
self.clean_debtor_fname						:= L.clean_def_pname[6..25]			;
self.clean_debtor_mname						:= L.clean_def_pname[26..45]			;
self.clean_debtor_lname						:= L.clean_def_pname[46..65]			;
self.clean_debtor_name_suffix	   				:= L.clean_def_pname[66..70]			;
self.clean_debtor_score				:= L.clean_def_pname[71..73]			;
self.clean_debtor_prim_range 		            := 		L.clean_defendent_addr[1..10]				;
self.clean_debtor_predir     		:=		L.clean_defendent_addr[11..12]				;
self.clean_debtor_prim_name			:= 		L.clean_defendent_addr[13..40]				;
self.clean_debtor_addr_suffix		:= 		L.clean_defendent_addr[41..44]				;
self.clean_debtor_postdir				:=		L.clean_defendent_addr[45..46]				;
self.clean_debtor_unit_desig			:= 		L.clean_defendent_addr[47..56]				;
self.clean_debtor_sec_range				:= 		L.clean_defendent_addr[57..64]				;
self.clean_debtor_p_city_name			:= 		L.clean_defendent_addr[65..89]				;
self.clean_debtor_v_city_name			:= 		L.clean_defendent_addr[90..114]				;
self.clean_debtor_st					:= 		L.clean_defendent_addr[115..116]			;
self.clean_debtor_zip					:=		L.clean_defendent_addr[117..121]			;
self.clean_debtor_zip4					:=		L.clean_defendent_addr[122..125]			;
self.clean_debtor_cart					:=		L.clean_defendent_addr[126..129]			;
self.clean_debtor_cr_sort_sz			:=		L.clean_defendent_addr[130]					;
self.clean_debtor_lot					:=		L.clean_defendent_addr[131..134]			;
self.clean_debtor_lot_order				:=		L.clean_defendent_addr[135]					;
self.clean_debtor_dpbc					:=		L.clean_defendent_addr[136..137]			;
self.clean_debtor_chk_digit				:=		L.clean_defendent_addr[138]					;
self.clean_debtor_record_type			:=		L.clean_defendent_addr[139..140]			;
self.clean_debtor_ace_fips_st			:=		L.clean_defendent_addr[141..142]			;
self.clean_debtor_fipscounty			:=		L.clean_defendent_addr[143..145]			;
self.clean_debtor_geo_lat				:=		L.clean_defendent_addr[146..155]			;
self.clean_debtor_geo_long				:=		L.clean_defendent_addr[156..166]			;
self.clean_debtor_msa					:=		L.clean_defendent_addr[167..170]			;
self.clean_debtor_geo_match				:=		L.clean_defendent_addr[178]					;
self.clean_debtor_err_stat				:=		L.clean_defendent_addr[179..182]		;
self.clean_creditor_title						:= L.clean_plaintiff_pname[1..5]			    ;
self.clean_creditor_fname						:= L.clean_plaintiff_pname[6..25]			;
self.clean_creditor_mname						:= L.clean_plaintiff_pname[26..45]			;
self.clean_creditor_lname						:= L.clean_plaintiff_pname[46..65]			;
self.clean_creditor_name_suffix	   				:= L.clean_plaintiff_pname[66..70]			;
self.clean_creditor_score				:= L.clean_plaintiff_pname[71..73]			;
self.clean_atty_title				:= L.clean_atty_pname[1..5]			    ;
self.clean_atty_fname				:= L.clean_atty_pname[6..25]			;
self.clean_atty_mname				:= L.clean_atty_pname[26..45]			;
self.clean_atty_lname				:= L.clean_atty_pname[46..65]			;
self.clean_atty_name_suffix	   		:= L.clean_atty_pname[66..70]			;
self.clean_atty_score		        := L.clean_atty_pname[71..73]			;
self.clean_atty_prim_range 		    := 		L.clean_atty_addr[1..10]				;
self.clean_atty_predir     		    :=		L.clean_atty_addr[11..12]				;
self.clean_atty_prim_name			:= 		L.clean_atty_addr[13..40]				;
self.clean_atty_addr_suffix		    := 		L.clean_atty_addr[41..44]				;
self.clean_atty_postdir				:=		L.clean_atty_addr[45..46]				;
self.clean_atty_unit_desig			:= 		L.clean_atty_addr[47..56]				;
self.clean_atty_sec_range			:= 		L.clean_atty_addr[57..64]				;
self.clean_atty_p_city_name			:= 		L.clean_atty_addr[65..89]				;
self.clean_atty_v_city_name			:= 		L.clean_atty_addr[90..114]				;
self.clean_atty_st					:= 		L.clean_atty_addr[115..116]			;
self.clean_atty_zip					:=		L.clean_atty_addr[117..121]			;
self.clean_atty_zip4				:=		L.clean_atty_addr[122..125]			;
self.clean_atty_cart				:=		L.clean_atty_addr[126..129]			;
self.clean_atty_cr_sort_sz			:=		L.clean_atty_addr[130]					;
self.clean_atty_lot					:=		L.clean_atty_addr[131..134]			;
self.clean_atty_lot_order			:=		L.clean_atty_addr[135]					;
self.clean_atty_dpbc				:=		L.clean_atty_addr[136..137]			;
self.clean_atty_chk_digit			:=		L.clean_atty_addr[138]					;
self.clean_atty_record_type			:=		L.clean_atty_addr[139..140]			;
self.clean_atty_ace_fips_st			:=		L.clean_atty_addr[141..142]			;
self.clean_atty_fipscounty			:=		L.clean_atty_addr[143..145]			;
self.clean_atty_geo_lat				:=		L.clean_atty_addr[146..155]			;
self.clean_atty_geo_long			:=		L.clean_atty_addr[156..166]			;
self.clean_atty_msa					:=		L.clean_atty_addr[167..170]			;
self.clean_atty_geo_match			:=		L.clean_atty_addr[178]					;
self.clean_atty_err_stat			:=		L.clean_atty_addr[179..182]		;
self.clean_debtor_cname := L.clean_def_cname;
self.clean_creditor_cname := L.clean_plaintiff_cname;
self.clean_atty_cname := L.clean_atty_cname;
self.orig_rmsid := l.orig_rmsid;
self.certificate_number		:= L.othercase;
self.legal_lot := lot;
self.legal_block := block;
self.bCBFlag	:=	IF(l.VOL_INVOL='1',TRUE,FALSE);
SELF.DOB	:=	L.DOB;
SELF.Filing_Type_ID	:=	L.FILETYPEID;
SELF.Collection_Date	:=	L.Collection_Date;
SELF.CaseLinkID	:=	L.CaseLinkID;
SELF.TMSID_old	:=	L.TMSID_old;
SELF.RMSID_old	:=	L.RMSID_old;
SELF.CaseLinkID_Prop_Flag	:=	FALSE;
end;

export Mapping_Hogan := project(filein_join, main_mapping_format(left));