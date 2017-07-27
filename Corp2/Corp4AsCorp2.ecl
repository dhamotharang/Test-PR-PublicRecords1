import ut, Corporate;

Layout_Corp4_Temp := record
Corporate.Layout_Corporate_Base;
string120 ra_company_name;
string73  ra_clean_name;
end;

Layout_Corporate_Direct_Corp_Base TranslateCorp4ToCorp(Layout_Corp4_Temp l) := transform
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
self.corp_address1_type_cd := l.orig_address_ind;
self.corp_address1_type_desc := case(l.orig_address_ind,
                                          'A' => 'AGENT ADDRESS',
										  'B' => 'BUSINESS OFFICE',
										  'C' => 'CORPORATE ADDRESS',
										  'E' => 'BUSINESS ENTITY',
										  'F' => 'FOREIGN ADDRESS',
										  'H' => 'HOME ADDRESS',
										  'M' => 'MAILING ADDRESS',
										  'P' => 'PARENT ADDRESS',
										  'O' => 'OWNER ADDRESS',
										  'R' => 'REGISTERED AGENT ADDRESS',
										  'CORPORATE ADDRESS');
self.corp_address1_line1 := Stringlib.StringToUpperCase(l.street);
self.corp_address1_line2 := Stringlib.StringCleanSpaces(Stringlib.StringToUpperCase(trim(l.orig_city) + ' ' + l.orig_state + ' ' + l.zip));
self.corp_address1_line3 := '';
self.corp_address1_line4 := '';
self.corp_address1_line5 := '';
self.corp_address1_line6 := '';
self.corp_address1_effective_date := '';
self.corp_address2_type_cd := '';
self.corp_address2_type_desc := if(l.prior_street <> '' or l.prior_city <> '' or l.prior_state <> '' or l.prior_zip <> '',
                                     'PRIOR ADDRESS',
									 '');
self.corp_address2_line1 := Stringlib.StringToUpperCase(l.prior_street);
self.corp_address2_line2 := Stringlib.StringCleanSpaces(Stringlib.StringToUpperCase(trim(l.prior_city) + ' ' + l.prior_state + ' ' + l.prior_zip));
self.corp_address2_line3 := '';
self.corp_address2_line4 := '';
self.corp_address2_line5 := '';
self.corp_address2_line6 := '';
self.corp_address2_effective_date := '';
self.corp_phone_number := '';
self.corp_phone_number_type_cd := '';
self.corp_phone_number_type_desc := '';
self.corp_email_address := '';
self.corp_web_address := '';
self.corp_filing_reference_nbr := '';
self.corp_filing_date := l.rcnt_filing;
self.corp_filing_cd := l.file_type;
self.corp_filing_desc := 
 case(l.file_type,
                              'A05' => 'ACCOUNT OF GOVERNMENT',
							  'A10' => 'AGRICULTURE COOP',
							  'A13' => 'ALIEN CORPORATION',
							  'A15' => 'ANNEXATION',
							  'A20' => 'ASSUMED NAME ENTITY',
							  'B05' => 'BANK',
							  'B10' => 'BANK COOPERATIVE',
							  'B15' => 'BANK CREDIT UNION',
							  'B20' => 'BUSINESS TRUST',
							  'C05' => 'CHARITABLE HOSPITAL',
							  'C10' => 'COOPERATIVE',
							  'C15' => 'COOPERATIVE ASSOC',
							  'C20' => 'COOPERATIVE OTHER',
							  'C25' => 'CORPORATION SOLE',
							  'C30' => 'CREDIT UNION',
							  'D15' => 'DOMESTIC BCA',
							  'D20' => 'DOMESTIC BUSINESS',
							  'D25' => 'DOMESTIC BUSINESS TRUST',
							  'D28' => 'DOMESTIC COOPERATIVE',
							  'D30' => 'DOMESTIC CORPORATION',
							  'D33' => 'DOMESTIC GOVERNMENT',
							  'D35' => 'DOMESTIC INDUSTRIAL LOAN',
							  'D40' => 'DOMESTIC LP',
							  'D42' => 'DOMESTIC LLC',
							  'D43' => 'DOMESTIC LLP',
							  'D45' => 'DOMESTIC NONPROFIT',
							  'D46' => 'DOMESTIC PARTNERSHIP',
							  'D50' => 'DOMESTIC PROFIT',
							  'D55' => 'DOMESTIC RELIGIOUS',
							  'F15' => 'FOREIGN BCA',
							  'F20' => 'FOREIGN BUSINESS',
							  'F23' => 'FOREIGN BUSINESS FICT NAME',
							  'F25' => 'FOREIGN BUSINESS TRUST',
							  'F28' => 'FOREIGN COOPERATIVE',
							  'F30' => 'FOREIGN CORPORATION',
							  'F35' => 'FOREIGN INDUSTRIAL LOAN',
							  'F40' => 'FOREIGN LP',
							  'F42' => 'FOREIGN LLC',
							  'F43' => 'DOMESTIC LLP',
							  'F45' => 'FOREIGN NONPROFIT',
							  'F46' => 'FOREIGN PARTNERSHIP',
							  'F48' => 'FOREIGN NONPROFIT FICT NAME',
							  'F50' => 'FOREIGN PROFESSIONAL',
							  'F55' => 'FOREIGN PROFIT',
							  'F80' => 'FRATERNAL BUILDING SOCIETY',
							  'F85' => 'FRATERNAL SOCIETY',
							  'G05' => 'GAS ELECTRIC UTILITY',
							  'G08' => 'GOVERNMENT AGENCY',
							  'G10' => 'GRANGE',
							  'H05' => 'HOUSING COOPERATIVE',
							  'I05' => 'DISTRICT IMPROV NONPROFIT',
							  'I10' => 'DISTRICT IMPROV PROFIT',
							  'I15' => 'INSURANCE COMPANY',
							  'L05' => 'LIBRARY ASSOCIATION',
							  'L10' => 'LOAN',
							  'L15' => 'LP NAME REGISTRATION',
							  'L20' => 'LP NAME RESERVATION',
							  'M05' => 'MASSACHUSSETS TRUST',
							  'M10' => 'MISCELLANEOUS',
							  'M15' => 'MISC MUTUAL ASSOC',
							  'M20' => 'MUTUAL BENEFIT',
							  'N05' => 'NAME REGISTRATION',
							  'N10' => 'NAME RESERVATION',
							  'N15' => 'NEW FORMING CHURCHES',
							  'N20' => 'NON FILING INSURANCE',
							  'N25' => 'NON PROFIT CEMETARIES',
							  'N30' => 'NON PROFIT CHURCH',
							  'N35' => 'NON PROFIT SCHOOLS',
							  'N40' => 'NOT FOR PROFIT',
							  'N45' => 'NOT FOR PROFIT CORPORATION',
							  'O05' => 'OTHER CORPORATE STRUCTURE',
							  'P05' => 'PROFESSIONAL',
							  'P10' => 'PROFESSIONAL ASSOC',
							  'P15' => 'PROFESSIONAL CORP',
							  'P20' => 'PROFESSIONAL SERVICE',
							  'P25' => 'PROFIT',
							  'P30' => 'PUBLIC BENEFIT',
							  'P35' => 'PUBLIC UTILITIES',
							  'R05' => 'RAILROAD',
							  'R10' => 'REGULAR',
							  'R15' => 'RELIGIOUS',
							  'S05' => 'SAVINGS AND LOAN',
							  'S10' => 'SPECIAL PROFIT',
							  'S15' => 'SPECIAL QUALIFICATION',
							  'S20' => 'SUMMONS NOT QUALIFIED',
							  'T05' => 'TRADEMARK',
							  'T10' => 'TRUST',
							  'U01' => 'UNAUTHORIZED BUSINESS',
							  'U03' => 'UNAUTHORIZED NON PROFIT',
							  'U05' => 'URBAN DEVELOPMENT',
							  'W05' => 'WATER COMPANY',
							  'W10' => 'WATER UTILITY',
							  '');
self.corp_status_cd := if((integer)l.status_descp > 0, l.status_descp, l.status);
self.corp_status_desc := if((integer)l.status_descp = 0,
                          case(l.status,
						      'A' => 'ACTIVE',
							  'I' => 'INACTIVE',
							  'U' => 'UNKNOWN',
							  'F' => 'FORFEITED',
							  'D' => 'DISSOLVED',
							  'R' => 'REVOKED',
							  'T' => 'TERMINATED',
							  ''),
                          case(l.status_descp,
                              '001' => 'ACTIVE',
							  '002' => 'ADMIN FORFEITED',
							  '003' => 'AGENT CHANGED',
							  '004' => 'AGENT VACATED',
							  '005' => 'AMENDMENT',
							  '006' => 'BAD CHECK',
							  '007' => 'BANKRUPTCY',
							  '008' => 'CANCEL DISSOLUTION',
							  '009' => 'CANCELLED',
							  '010' => 'CERTIFICATE AUTHORIZATION',
							  '011' => 'CERTIFICATE TRUSTEE',
							  '012' => 'CHARTER FORFEITED',
							  '013' => 'CONSENT PERMISSION',
							  '014' => 'CONSOLIDATION',
							  '015' => 'COURT ORDER FORFEITED',
							  '016' => 'DEAD',
							  '017' => 'DELETED',
							  '018' => 'DELINQUENT',
							  '019' => 'DELINQUENT PUBLICATION',
							  '020' => 'DELINQUENT ANNUAL REPORT',
							  '021' => 'DISSOLVED',
							  '022' => 'DISSOLVE IN PROGRESS',
							  '023' => 'DISSOLVE COMPLETE',
							  '024' => 'DISSOLVE INTENDED',
							  '025' => 'DISSOLVE VOLUNTARY',
							  '026' => 'ELECTION',
							  '027' => 'FAILURE TO RENEW',
							  '028' => 'FORFEITED',
							  '029' => 'GOOD STANDING',
							  '030' => 'HOME NAME CHANGED',
							  '031' => 'INACTIVE',
							  '032' => 'MERGED OUT',
							  '033' => 'MISC TRANSFER',
							  '034' => 'NAME CHANGED',
							  '035' => 'NAME GRANTED',
							  '036' => 'NAME LOST',
							  '037' => 'NONFILABLE',
							  '038' => 'OTHER CORP STATUS',
							  '039' => 'OWNER CHANGED',
							  '040' => 'REGISTER ADDRESS CHANGE',
							  '041' => 'REINSTATED',
							  '042' => 'RENEW',
							  '043' => 'REQUALIFY',
							  '044' => 'RESTATE ARTICLES',
							  '045' => 'REVOKED',
							  '046' => 'SPECIAL ACT CORP',
							  '047' => 'STOCK CHANGED',
							  '048' => 'SUSPENDED',
							  '049' => 'SURRENDERED',
							  '050' => 'TERM EXPIRED',
							  '051' => 'TERMINATED',
							  '052' => 'TRANSFER TO BANK',
							  '053' => 'TRANSFER TO INSURANCE',
							  '054' => 'TRANSFER TO SAVINGS',
							  '055' => 'UNFILED',
							  '056' => 'UNKNOWN',
							  '057' => 'WITHDRAWAL IN PROGRESS',
							  '058' => 'WITHDRAWAL COMPLETE',
							  '059' => 'INCORPORATION',
							  '060' => 'APPLICATION AUTHORITY',
							  '061' => 'CERT OF CORRECTION',
							  '062' => 'TAKEOVER DISSOLUTION',
							  '063' => 'COURT ORDER ANULMENT',
							  '064' => 'JOINT STOCK ASSOC',
							  '065' => 'GENERAL ASSOC',
							  '066' => 'EXCHANGE OF SHARES',
							  '067' => 'ANNUAL REPORT',
							  '068' => 'CERT OF COMPLIANCE',
							  '069' => 'ERRONEOUS ENTRIES',
							  '070' => 'DISSOLUTION OF JOINT STOCK',
							  '071' => 'PUBLIC AUTHORITY LAW',
							  '072' => 'ELECTION OF TRUSTEES REORG',
							  '073' => 'DESGNT GEN ASSTN LAW',
							  '074' => 'CANCEL AUTHORITY ANULMENT',
							  '075' => 'CERTIFICATE OF CHANGE',
							  '076' => 'GOVERNMENTAL AGENCY',
							  '077' => 'EXPIRED',
							  '078' => 'PENDING',
							  '079' => 'WITHDRAWN',
							  '080' => 'LIQUIDATED',
							  ''));
self.corp_status_date := l.rcnt_filing;
self.corp_ticker_symbol := '';
self.corp_stock_exchange := '';
self.corp_inc_state := l.orig_filing_state;
self.corp_inc_date := l.date_incorp;
self.corp_fed_tax_id := l.fed_tax_id_9;
self.corp_state_tax_id := l.state_tax_id;
self.corp_term_exist_cd := l.term_of_existence_flag;
self.corp_term_exist_exp := l.term_exist;
self.corp_term_exist_desc := case(l.term_of_existence_flag,
                                       'D' => 'DATE OF EXPIRATION',
									   'N' => 'NUMBER OF YEARS',
									   'P' => 'PERPETUAL',
									   'U' => 'UNKNOWN',
									   '');
self.corp_foreign_domestic_ind := l.foreign_domestic_flag;
self.corp_forgn_state_cd := '';
self.corp_forgn_state_desc := '';
self.corp_forgn_sos_charter_nbr := if(l.foreign_domestic_flag = 'F', l.orig_sos_ter_nbr, '');
self.corp_forgn_date := if(l.foreign_domestic_flag = 'F', l.date_orig_filing, '');
self.corp_forgn_fed_tax_id := '';
self.corp_forgn_state_tax_id := '';
self.corp_forgn_term_exist_cd := '';
self.corp_forgn_term_exist_exp := '';
self.corp_forgn_term_exist_desc := '';
self.corp_orig_org_structure_cd := if(self.corp_filing_desc <> '', self.corp_filing_cd, l.partner_proprietor_flag);
self.corp_orig_org_structure_desc := if(self.corp_filing_desc <> '',
                                        self.corp_filing_desc,
                                        case(l.partner_proprietor_flag,
                                               'L' => 'LIMITED PARTNERSHIP',
											   'O' => 'OTHER',
											   'G' => 'GENERAL PARTNERSHIP',
											   'P' => 'PARTNERSHIP',
											   'S' => 'SOLE PROPRIETOR',
											   'D' => 'LIMITED LIABILITY PARTNERSHIP',
											   'C' => 'LIMITED LIABILITY CORPORATION',
											   ''));
self.corp_for_profit_ind := map(l.profit_code = 'P' => 'Y',
                                     l.profit_code = 'N' => 'N',
									 ' ');
self.corp_sic_code := l.sic_code;
self.corp_orig_bus_type_cd := '';
self.corp_orig_bus_type_desc := '';
self.corp_ra_name := Stringlib.StringToUpperCase(l.orig_reg_agent_name);
self.corp_ra_title_cd := 'RA';
self.corp_ra_title_desc := 'REGISTERED AGENT';
self.corp_ra_fein := '';
self.corp_ra_ssn := '';
self.corp_ra_dob := '';
self.corp_ra_effective_date := '';
self.corp_ra_address_type_cd := 'A';
self.corp_ra_address_type_desc := 'AGENT ADDRESS';
self.corp_ra_address_line1 := Stringlib.StringToUpperCase(l.reg_agent_street);
self.corp_ra_address_line2 := Stringlib.StringCleanSpaces(Stringlib.StringToUpperCase(trim(l.reg_agent_city) + ' ' + l.reg_agent_state + ' ' + l.reg_agent_zip5));
self.corp_ra_address_line3 := '';
self.corp_ra_address_line4 := '';
self.corp_ra_address_line5 := '';
self.corp_ra_address_line6 := '';
self.corp_ra_phone_number := '';
self.corp_ra_phone_number_type_cd := '';
self.corp_ra_phone_number_type_desc := '';
self.corp_ra_email_address := '';
self.corp_ra_web_address := '';
self.corp_addr1_prim_range := l.prim_range;
self.corp_addr1_predir := l.predir;
self.corp_addr1_prim_name := l.prim_name;
self.corp_addr1_addr_suffix := l.addr_suffix;
self.corp_addr1_postdir := l.postdir;
self.corp_addr1_unit_desig := l.unit_desig;
self.corp_addr1_sec_range := l.sec_range;
self.corp_addr1_p_city_name := l.p_city_name;
self.corp_addr1_v_city_name := l.v_city_name;
self.corp_addr1_state := l.state;
self.corp_addr1_zip5 := l.zip5;
self.corp_addr1_zip4 := l.zip4;
self.corp_addr1_cart := l.cart;
self.corp_addr1_cr_sort_sz := l.cr_sort_sz;
self.corp_addr1_lot := l.lot;
self.corp_addr1_lot_order := l.lot_order;
self.corp_addr1_dpbc := l.dpbc;
self.corp_addr1_chk_digit := l.chk_digit;
self.corp_addr1_rec_type := l.rec_type;
self.corp_addr1_ace_fips_st := l.ace_fips_st;
self.corp_addr1_county := l.county;
self.corp_addr1_geo_lat := l.geo_lat;
self.corp_addr1_geo_long := l.geo_long;
self.corp_addr1_msa := l.msa;
self.corp_addr1_geo_blk := l.geo_blk;
self.corp_addr1_geo_match := l.geo_match;
self.corp_addr1_err_stat := l.err_stat;
self.corp_addr2_prim_range := l.prior_prim_range;
self.corp_addr2_predir := l.prior_predir;
self.corp_addr2_prim_name := l.prior_prim_name;
self.corp_addr2_addr_suffix := l.prior_addr_suffix;
self.corp_addr2_postdir := l.prior_postdir;
self.corp_addr2_unit_desig := l.prior_unit_desig;
self.corp_addr2_sec_range := l.prior_sec_range;
self.corp_addr2_p_city_name := l.prior_p_city_name;
self.corp_addr2_v_city_name := l.prior_v_city_name;
self.corp_addr2_state := l.prior_state;
self.corp_addr2_zip5 := l.prior_zip5;
self.corp_addr2_zip4 := l.prior_zip4;
self.corp_addr2_cart := l.prior_cart;
self.corp_addr2_cr_sort_sz := l.prior_cr_sort_sz;
self.corp_addr2_lot := l.prior_lot;
self.corp_addr2_lot_order := l.prior_lot_order;
self.corp_addr2_dpbc := l.prior_dpbc;
self.corp_addr2_chk_digit := l.prior_chk_digit;
self.corp_addr2_rec_type := l.prior_rec_type;
self.corp_addr2_ace_fips_st := l.prior_ace_fips_st;
self.corp_addr2_county := l.prior_county;
self.corp_addr2_geo_lat := l.prior_geo_lat;
self.corp_addr2_geo_long := l.prior_geo_long;
self.corp_addr2_msa := l.prior_msa;
self.corp_addr2_geo_blk := l.prior_geo_blk;
self.corp_addr2_geo_match := l.prior_geo_match;
self.corp_addr2_err_stat := l.prior_err_stat;
self.corp_ra_title1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[1..5],
						   '');
self.corp_ra_fname1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[6..25],
						   '');
self.corp_ra_mname1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[26..45],
						   '');
self.corp_ra_lname1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[46..65],
						   '');
self.corp_ra_name_suffix1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[66..70],
						   '');
self.corp_ra_score1 := if(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85,
						   l.ra_clean_name[71..73],
						   '');
self.corp_ra_title2 := '';
self.corp_ra_fname2 := '';
self.corp_ra_mname2 := '';
self.corp_ra_lname2 := '';
self.corp_ra_name_suffix2 := '';
self.corp_ra_score2 := '';
self.corp_ra_cname1 := if(not(l.ra_company_name[41..120] = '' AND
                           (integer)(l.ra_clean_name[71..73]) >= 85),
						   l.reg_agent_name,
						   '');
self.corp_ra_cname1_score := '';
self.corp_ra_cname2 := '';
self.corp_ra_cname2_score := '';
self.corp_ra_prim_range := l.ra_prim_range;
self.corp_ra_predir := l.ra_predir;
self.corp_ra_prim_name := l.ra_prim_name;
self.corp_ra_addr_suffix := l.ra_addr_suffix;
self.corp_ra_postdir := l.ra_postdir;
self.corp_ra_unit_desig := l.ra_unit_desig;
self.corp_ra_sec_range := l.ra_sec_range;
self.corp_ra_p_city_name := l.ra_p_city_name;
self.corp_ra_v_city_name := l.ra_v_city_name;
self.corp_ra_state := l.ra_state;
self.corp_ra_zip5 := l.ra_zip5;
self.corp_ra_zip4 := l.ra_zip4;
self.corp_ra_cart := l.ra_cart;
self.corp_ra_cr_sort_sz := l.ra_cr_sort_sz;
self.corp_ra_lot := l.ra_lot;
self.corp_ra_lot_order := l.ra_lot_order;
self.corp_ra_dpbc := l.ra_dpbc;
self.corp_ra_chk_digit := l.ra_chk_digit;
self.corp_ra_rec_type := l.ra_rec_type;
self.corp_ra_ace_fips_st := l.ra_ace_fips_st;
self.corp_ra_county := l.ra_county;
self.corp_ra_geo_lat := l.ra_geo_lat;
self.corp_ra_geo_long := l.ra_geo_long;
self.corp_ra_msa := l.ra_msa;
self.corp_ra_geo_blk := l.ra_geo_blk;
self.corp_ra_geo_match := l.ra_geo_match;
self.corp_ra_err_stat := l.ra_err_stat;
self.corp_phone10 := '';
self.corp_ra_phone10 := '';
self.record_type := l.record_type;
	self.corp_ra_dt_first_seen			:= 0;
	self.corp_ra_dt_last_seen			:= 0;
	self.corp_supp_key                  := '';
	self.corp_vendor_county             := '';
	self.corp_vendor_subcode            := '';
	self.corp_src_type                  := '';
	self.corp_ln_name_type_cd           := '';
	self.corp_ln_name_type_desc         := '';
	self.corp_supp_nbr                  := '';
	self.corp_name_comment              := '';
	self.corp_fax_nbr                   := '';
	self.corp_standing                  := '';
	self.corp_status_comment            := '';
	self.corp_inc_county                := '';
	self.corp_anniversary_month         := '';
	self.corp_public_or_private_ind     := '';
	self.corp_naic_code                 := '';
	self.corp_entity_desc               := '';
	self.corp_certificate_nbr           := '';
	self.corp_internal_nbr              := '';
	self.corp_previous_nbr              := '';
	self.corp_microfilm_nbr             := '';
	self.corp_amendments_filed          := '';
	self.corp_acts                      := '';
	self.corp_partnership_ind           := '';
	self.corp_mfg_ind                   := '';
	self.corp_addl_info                 := '';
	self.corp_taxes                     := '';
	self.corp_franchise_taxes           := '';
	self.corp_tax_program_cd            := '';
	self.corp_tax_program_desc          := '';
	self.corp_ra_resign_date            := '';
	self.corp_ra_no_comp                := '';
	self.corp_ra_no_comp_igs            := '';
	self.corp_ra_addl_info              := '';
	self.corp_ra_fax_nbr                := '';

self := l;
end;

Layout_Corp4_Temp BlankCorpAddress(Layout_Corp4_Temp l) := transform
self.prim_range := '';
self.predir := '';
self.prim_name := '';
self.addr_suffix := '';
self.postdir := '';
self.unit_desig := '';
self.sec_range := '';
self.p_city_name := '';
self.state := '';
self.zip5 := '';
self.zip4 := '';
self.county := '';
self.msa := '';
self.geo_lat := '';
self.geo_long := '';
self := l;
end;

Layout_Corp4_Temp CleanRAName(Corporate.Layout_Corporate_Base l) := transform
self.ra_company_name := Datalib.CompanyClean(l.reg_agent_name);
self.ra_clean_name := addrcleanlib.cleanPerson73(l.reg_agent_name);
self := l;
end;

Corp4_Init := project(Corporate.File_Corp4_Base, CleanRAName(left));

Corp4_RA_Addr := Corp4_Init(not(
                              suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               ra_company_name[41..120] = '' AND
                                (integer)(ra_clean_name[71..73]) >= 85
                               )));

Corp4_Blank_Addr := project(Corp4_RA_Addr, BlankCorpAddress(left));


Corp4_Not_RA_Addr := Corp4_Init(stringlib.stringfind(abbrev_legal_name, '0000000000', 1) = 0,
                               suppress_ra_addr<>'Y' OR
                              (suppress_ra_addr='Y' AND
                               ra_officer_also='Y' AND
                               ra_company_name[41..120] = '' AND
                                (integer)(ra_clean_name[71..73]) >= 85
                               ));

Corp4_Clean := Corp4_Not_RA_Addr + Corp4_Blank_Addr;

Corp4_As_Corp_Init := project(Corp4_Clean, TranslateCorp4ToCorp(left));

export Corp4AsCorp2 := Corp4_As_Corp_Init : persist(persistnames.Corp4_As_Corp2);