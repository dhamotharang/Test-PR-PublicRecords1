import ut, Corporate, Address;

// Determine if contact date range overlaps company date range
BOOLEAN ValidDateRange(UNSIGNED4 contact_dt_first_seen,
                       UNSIGNED4 contact_dt_last_seen,
                       UNSIGNED4 company_dt_first_seen,
                       UNSIGNED4 company_dt_last_seen) :=
    (contact_dt_first_seen >= company_dt_first_seen AND
        contact_dt_first_seen <= company_dt_last_seen) OR
    (contact_dt_last_seen >= company_dt_first_seen AND
        contact_dt_last_seen <= company_dt_last_seen) OR
    (company_dt_first_seen >= contact_dt_first_seen AND
        company_dt_last_seen <= contact_dt_last_seen);

Layout_Corp4_Cont_Temp := record
Corporate.Layout_Corp_Contacts_DID;
string120 cont_company_name;
string73  cont_clean_name;
end;

Layout_Corporate_Direct_Cont_AID TranslateCorp4ToCorpContacts(Layout_Corp4_Cont_Temp l) := transform
self.dt_first_seen := (unsigned4)fCheckDate(l.dt_first_seen);
self.dt_last_seen := (unsigned4)fCheckDate(l.dt_last_seen);
self.dt_vendor_first_reported := (unsigned4)fCheckDate(l.dt_first_seen);
self.dt_vendor_last_reported := (unsigned4)fCheckDate(l.dt_last_seen);
self.corp_key := fMapCorpKey(l.state_origin, l.sos_ter_nbr);
self.corp_vendor := 'EX';
self.corp_state_origin := l.state_origin;
self.corp_process_date := l.extract_date;
self.corp_orig_sos_charter_nbr := l.sos_ter_nbr;
self.corp_sos_charter_nbr := fMapCharterNumber('EX',l.state_origin,l.sos_ter_nbr);
self.corp_legal_name := Stringlib.StringToUpperCase(l.abbrev_legal_name);
self.corp_address1_type_cd := '';
self.corp_address1_type_desc := '';
self.corp_address1_line1 := '';
self.corp_address1_line2 := '';
self.corp_address1_line3 := '';
self.corp_address1_line4 := '';
self.corp_address1_line5 := '';
self.corp_address1_line6 := '';
self.corp_prep_addr_line1				:=	'';
self.corp_prep_addr_last_line		:=	'';
self.corp_address1_effective_date := '';
self.corp_phone_number := '';
self.corp_phone_number_type_cd := '';
self.corp_phone_number_type_desc := '';
self.corp_email_address := '';
self.corp_web_address := '';
self.cont_filing_reference_nbr := '';
self.cont_filing_date := '';
self.cont_filing_cd := '';
self.cont_filing_desc := '';
self.cont_type_cd := l.officer_title;
self.cont_type_desc := case(l.officer_title,
                                   'HA' => 'REGISTERED AGENT',
                                   '01' => 'CHAIRMAN OF THE BOARD',
								   '02' => 'CHAIRMAN',
								   '03' => 'CHIEF EXECUTIVE OFFICER',
								   '04' => 'CHIEF FINANCIAL OFFICER',
								   '05' => 'VICE CHAIRMAN',
								   '06' => 'GENERAL PARTNER',
								   '07' => 'GENERAL MANAGER',
								   '08' => 'COMPTROLLER',
								   '09' => 'CONTROLLER',
								   '10' => 'TREASURER',
								   '11' => 'PRESIDENT',
								   '12' => 'ASSISTANT CONTROLLER',
								   '13' => 'DEPUTY GENERAL MANAGER',
								   '14' => 'GROUP VICE PRESIDENT',
								   '15' => 'VICE PRESIDENT',
								   '16' => 'VICE PRESIDENT OF FINANCE',
								   '17' => 'SENIOR VICE PRESIDENT',
								   '18' => 'VICE PRESIDENT TREASURER',
								   '19' => 'ASSISTANT TREASURER',
								   '20' => 'PRESIDENT VICE PRESIDENT',
								   '21' => 'PRESIDENT TREASURER',
								   '22' => 'EXECUTIVE VICE PRESIDENT',
								   '23' => 'FIRST VICE PRESIDENT',
								   '24' => 'SECOND VICE PRESIDENT',
								   '25' => 'CHIEF OPERATION OFFICER',
								   '26' => 'VICE PRESIDENT SECRETARY',
								   '27' => 'ASSISTANT VICE PRESIDENT',
								   '28' => 'JUNIOR VICE PRESIDENT',
								   '29' => 'MANAGER',
								   '30' => 'ASSISTANT MANAGER',
								   '31' => 'GENERAL COUNSEL',
								   '32' => 'DIRECTOR',
								   '33' => 'SECRETARY TREASURER',
								   '34' => 'SECRETARY',
								   '35' => 'ASSISTANT SECRETARY',
								   '36' => 'AUTHORIZED REPRESENTATIVE',
								   '37' => 'TRUSTEE',
								   '38' => 'CORRESPONDENT',
								   '39' => 'REGISTRANT',
								   '40' => 'AGENT',
								   '41' => 'APPLICANT',
								   '42' => 'SHARE HOLDER',
								   '43' => 'CLERK',
								   '44' => '',
								   '45' => 'OWNER',
								   '46' => 'CONTACT NAME',
								   '47' => 'PARTNER',
								   '48' => 'INCORPORATOR',
								   '49' => 'LIMITED PARTNER',
								   '50' => 'OFFICER',
								   '');
self.cont_name := l.officer_name;
self.cont_title_desc := self.cont_type_desc;
self.cont_fein := '';
self.cont_ssn := '';
self.cont_dob := '';
self.cont_effective_date := '';
self.cont_address_type_cd := '';
self.cont_address_type_desc := '';
self.cont_address_line1 := Stringlib.StringToUpperCase(l.officer_street);
self.cont_address_line2 := Stringlib.StringCleanSpaces(Stringlib.StringToUpperCase(trim(l.officer_city) + ' ' + l.officer_state + ' ' + l.officer_zip));
self.cont_address_line3 := '';
self.cont_address_line4 := '';
self.cont_address_line5 := '';
self.cont_address_line6 := '';
self.cont_prep_addr_line1				:=	Stringlib.StringToUpperCase(l.officer_street);
self.cont_prep_addr_last_line		:=	if (trim(l.officer_city,left,right) != '',
																						StringLib.StringCleanSpaces(Stringlib.StringToUpperCase(	trim(l.officer_city,left,right) + ', ' +
																																																			trim(l.officer_state,left,right) + ' ' + 
																																																			trim(l.officer_zip,left,right)[1..5])), 
																						 StringLib.StringCleanSpaces(Stringlib.StringToUpperCase(	trim(l.officer_state,left,right) + ' ' + 
																																																			trim(l.officer_zip,left,right)[1..5]))
                                            ); 						
self.cont_address_effective_date := '';
self.cont_phone_number := '';
self.cont_phone_number_type_cd := '';
self.cont_phone_number_type_desc := '';
self.cont_email_address := '';
self.cont_web_address := '';
self.corp_addr1_prim_range := '';
self.corp_addr1_predir := '';
self.corp_addr1_prim_name := '';
self.corp_addr1_addr_suffix := '';
self.corp_addr1_postdir := '';
self.corp_addr1_unit_desig := '';
self.corp_addr1_sec_range := '';
self.corp_addr1_p_city_name := '';
self.corp_addr1_v_city_name := '';
self.corp_addr1_state := '';
self.corp_addr1_zip5 := '';
self.corp_addr1_zip4 := '';
self.corp_addr1_cart := '';
self.corp_addr1_cr_sort_sz := '';
self.corp_addr1_lot := '';
self.corp_addr1_lot_order := '';
self.corp_addr1_dpbc := '';
self.corp_addr1_chk_digit := '';
self.corp_addr1_rec_type := '';
self.corp_addr1_ace_fips_st := '';
self.corp_addr1_county := '';
self.corp_addr1_geo_lat := '';
self.corp_addr1_geo_long := '';
self.corp_addr1_msa := '';
self.corp_addr1_geo_blk := '';
self.corp_addr1_geo_match := '';
self.corp_addr1_err_stat := '';
self.cont_title := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.title,
						   '');
self.cont_fname := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.fname,
						   '');
self.cont_mname := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.mname,
						   '');
self.cont_lname := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.lname,
						   '');
self.cont_name_suffix := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.name_suffix,
						   '');
self.cont_score := if(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85,
						   l.score,
						   '');
self.cont_cname := if(not(l.cont_company_name[41..120] = '' AND
                           (integer)(l.cont_clean_name[71..73]) >= 85),
						   l.officer_name,
						   '');
self.cont_cname_score := '';
self.cont_prim_range := l.prim_range;
self.cont_predir := l.predir;
self.cont_prim_name := l.prim_name;
self.cont_addr_suffix := l.addr_suffix;
self.cont_postdir := l.postdir;
self.cont_unit_desig := l.unit_desig;
self.cont_sec_range := l.sec_range;
self.cont_p_city_name := l.p_city_name;
self.cont_v_city_name := l.v_city_name;
self.cont_state := l.state;
self.cont_zip5 := l.zip5;
self.cont_zip4 := l.zip4;
self.cont_cart := l.cart;
self.cont_cr_sort_sz := l.cr_sort_sz;
self.cont_lot := l.lot;
self.cont_lot_order := l.lot_order;
self.cont_dpbc := l.dpbc;
self.cont_chk_digit := l.chk_digit;
self.cont_rec_type := l.rec_type;
self.cont_ace_fips_st := l.ace_fips_st;
self.cont_county := l.county;
self.cont_geo_lat := l.geo_lat;
self.cont_geo_long := l.geo_long;
self.cont_msa := l.msa;
self.cont_geo_blk := l.geo_blk;
self.cont_geo_match := l.geo_match;
self.cont_err_stat := l.err_stat;
self.corp_phone10 := '';
self.cont_phone10 := '';
self.record_type := l.record_type;
// -- new corp2 fields
self.corp_supp_key                  := '';
self.corp_vendor_county             := '';
self.corp_vendor_subcode            := '';
self.corp_fax_nbr                   := '';
self.cont_sos_charter_nbr           := '';
self.cont_status_cd                 := '';
self.cont_status_desc               := '';
self.cont_effective_cd              := '';
self.cont_effective_desc            := '';
self.cont_addl_info                 := '';
self.cont_address_county            := '';
self.cont_fax_nbr                   := '';
self.Append_Corp_Addr_RawAID				:=	0;
self.Append_Corp_Addr_ACEAID				:=	0;
self.Append_Cont_Addr_RawAID				:=	0;	
self.Append_Cont_Addr_ACEAID				:=	0;	
self := l;
end;

Layout_Corp4_Cont_Temp CleanContactName(Corporate.Layout_Corp_Contacts_DID l) := transform
self.cont_company_name := Datalib.CompanyClean(l.officer_name);
self.cont_clean_name := Address.cleanPerson73(l.officer_name);
self := l;
end;

Corp4_Cont_Init := project(Corporate.File_Corp4_Contacts_Base_DID, CleanContactName(left));

Corp_Cont_Init := project(Corp4_Cont_Init, TranslateCorp4ToCorpContacts(left));

// Join with companies to add company information
Corp_Cont_Dist := distribute(Corp_Cont_Init(cont_lname <> '' or cont_cname <> ''), hash(corp_key));
Corp_Company_Dist := distribute(Corp4AsCorp2, hash(corp_key));

Layout_Corporate_Direct_Cont_AID AppendCompanyToContact(Layout_Corporate_Direct_Cont_AID l, Layout_Corporate_Direct_Corp_AID r) := transform
self.corp_address1_type_cd := r.corp_address1_type_cd;
self.corp_address1_type_desc := r.corp_address1_type_desc;
self.corp_address1_line1 := r.corp_address1_line1;
self.corp_address1_line2 := r.corp_address1_line2;
self.corp_address1_line3 := r.corp_address1_line3;
self.corp_address1_line4 := r.corp_address1_line4;
self.corp_address1_line5 := r.corp_address1_line5;
self.corp_address1_line6 := r.corp_address1_line6;
self.corp_address1_effective_date := r.corp_address1_effective_date;
self.corp_phone_number := r.corp_phone_number;
self.corp_phone_number_type_cd := r.corp_phone_number_type_cd;
self.corp_phone_number_type_desc := r.corp_phone_number_type_desc;
self.corp_email_address := r.corp_email_address;
self.corp_web_address := r.corp_web_address;
self.corp_addr1_prim_range := r.corp_addr1_prim_range;
self.corp_addr1_predir := r.corp_addr1_predir;
self.corp_addr1_prim_name := r.corp_addr1_prim_name;
self.corp_addr1_addr_suffix := r.corp_addr1_addr_suffix;
self.corp_addr1_postdir := r.corp_addr1_postdir;
self.corp_addr1_unit_desig := r.corp_addr1_unit_desig;
self.corp_addr1_sec_range := r.corp_addr1_sec_range;
self.corp_addr1_p_city_name := r.corp_addr1_p_city_name;
self.corp_addr1_v_city_name := r.corp_addr1_v_city_name;
self.corp_addr1_state := r.corp_addr1_state;
self.corp_addr1_zip5 := r.corp_addr1_zip5;
self.corp_addr1_zip4 := r.corp_addr1_zip4;
self.corp_addr1_cart := r.corp_addr1_cart;
self.corp_addr1_cr_sort_sz := r.corp_addr1_cr_sort_sz;
self.corp_addr1_lot := r.corp_addr1_lot;
self.corp_addr1_lot_order := r.corp_addr1_lot_order;
self.corp_addr1_dpbc := r.corp_addr1_dpbc;
self.corp_addr1_chk_digit := r.corp_addr1_chk_digit;
self.corp_addr1_rec_type := r.corp_addr1_rec_type;
self.corp_addr1_ace_fips_st := r.corp_addr1_ace_fips_st;
self.corp_addr1_county := r.corp_addr1_county;
self.corp_addr1_geo_lat := r.corp_addr1_geo_lat;
self.corp_addr1_geo_long := r.corp_addr1_geo_long;
self.corp_addr1_msa := r.corp_addr1_msa;
self.corp_addr1_geo_blk := r.corp_addr1_geo_blk;
self.corp_addr1_geo_match := r.corp_addr1_geo_match;
self.corp_addr1_err_stat := r.corp_addr1_err_stat;
self.corp_phone10 := r.corp_phone10;
self := l;
end;

Corp_Cont_Append := join(Corp_Cont_Dist,
                       Corp_Company_Dist,
                       left.corp_key = right.corp_key and
                       left.corp_legal_name = right.corp_legal_name and
                       ValidDateRange(left.dt_first_seen, left.dt_last_seen, right.dt_first_seen, right.dt_last_seen),
                       AppendCompanyToContact(left, right),
                       local);

Corp_Cont_Dedup := dedup(Corp_Cont_Append, all);

export Corp4AsCorp2Contacts := Corp_Cont_Dedup : persist(persistnames.Corp4_As_Corp2_Contacts);