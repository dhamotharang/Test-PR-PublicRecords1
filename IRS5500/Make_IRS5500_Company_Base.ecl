IMPORT Business_Header, Business_Header_SS, ut, did_add;

f := IRS5500.File_In;

// Dedup by unique field, the name cleaning seems to
// have introduced extra rows.
f_ded := DEDUP(f, document_locator_number, ALL);

extr := irs5500.Infile_Is_Extract;

#if(extr)
IRS5500.Layout_IRS5500_Base Slim(f l) := TRANSFORM
	SELF.mail_addr := FALSE;
	SELF.spons_prim_range := l.prim_range;
	SELF.spons_predir := l.predir;
	SELF.spons_prim_name := l.prim_name;
	SELF.spons_addr_suffix := l.addr_suffix;
	SELF.spons_postdir := l.postdir;
	SELF.spons_unit_desig := l.unit_desig;
	SELF.spons_sec_range := l.sec_range;
	SELF.spons_p_city_name := l.p_city_name;
	SELF.spons_st := l.st;
	SELF.spons_zip5 := l.zip;
	SELF.spons_zip4 := l.zip4;
	SELF.spons_cart := l.cart;
	SELF.spons_cr_sort_sz := l.cr_sort_sz;
	SELF.spons_lot := l.lot;
	SELF.spons_lot_order := l.lot_order;
	SELF.spons_dpbc := l.dpbc;
	SELF.spons_chk_digit := l.chk_digit;
	SELF.spons_rec_type := l.record_type;
	SELF.spons_county := l.fipscounty;
	SELF.spons_geo_lat := l.geo_lat;
	SELF.spons_geo_long := l.geo_long;
	SELF.spons_msa := l.msa;
	SELF.spons_geo_blk := l.geo_blk;
	SELF.spons_geo_match := l.geo_match;
	SELF.spons_err_stat := l.err_stat;

	SELF.spons_sign_title := l.name_prefix;
	SELF.spons_sign_fname := l.name_first;
	SELF.spons_sign_mname := l.name_middle;
	SELF.spons_sign_lname := l.name_last;
	SELF.spons_sign_suffix := l.name_suffix;
	SELF.spons_sign_name_score := (UNSIGNED1) l.score;
	SELF := l;
END;

#else
// For now, we just want the sponsored company and sponsor
// signer name info
clean_name(f l) := addrcleanlib.cleanPerson73(l.spons_signed_name);

clean_mail(f l) := addrcleanlib.CleanAddress182(
	l.spons_dfe_mail_str_address,
	l.spons_dfe_city + ' ' + l.spons_dfe_state + ' ' + l.spons_dfe_zip_code);
	
clean_str(f l) := addrcleanlib.CleanAddress182(
	l.spons_dfe_loc_01_addr + ' ' +	l.spons_dfe_loc_02_addr,
	l.spons_dfe_city + ' ' + l.spons_dfe_state + ' ' + l.spons_dfe_zip_code);
	
IRS5500.Layout_IRS5500_Base Slim(f l) := TRANSFORM
	SELF.mail_addr := IF(
		CASE(clean_mail(l)[179],'E'=>1,' '=>3,'U'=>2,0) <
		CASE(clean_str(l)[179],'E'=>1,' '=>3,'U'=>2,0), TRUE, FALSE);
	
	SELF.spons_prim_range := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[1..10];
	SELF.spons_predir := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[11..12];
	SELF.spons_prim_name := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[13..40];
	SELF.spons_addr_suffix := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
	SELF.spons_postdir := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[45..46];
	SELF.spons_unit_desig := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[47..56];
	SELF.spons_sec_range := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[57..64];
	SELF.spons_p_city_name := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[65..89];
	SELF.spons_st := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[115..116];
	SELF.spons_zip5 := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[117..121];
	SELF.spons_zip4 := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[122..125];
	SELF.spons_cart := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[126..129];
	SELF.spons_cr_sort_sz := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[130];
	SELF.spons_lot := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[131..134];
	SELF.spons_lot_order := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[135];
	SELF.spons_dpbc := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[136..137];
	SELF.spons_chk_digit := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[138];
	SELF.spons_rec_type := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[139..140];
	SELF.spons_county := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[141..145];
	SELF.spons_geo_lat := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[146..155];
	SELF.spons_geo_long := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[156..166];
	SELF.spons_msa := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[167..170];
	SELF.spons_geo_blk := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[171..177];
	SELF.spons_geo_match := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[178];
	SELF.spons_err_stat := IF(SELF.mail_addr, clean_mail(l), clean_str(l))[179..182];

	SELF.spons_sign_title := clean_name(l)[1..5];
	SELF.spons_sign_fname := clean_name(l)[6..25];
	SELF.spons_sign_mname := clean_name(l)[26..45];
	SELF.spons_sign_lname := clean_name(l)[46..65];
	SELF.spons_sign_suffix := clean_name(l)[66..70];
	SELF.spons_sign_name_score := (UNSIGNED1) (clean_name(l)[71..73]);
	SELF := l;
END;

#end

IRS5500_Base := PROJECT(f_ded, Slim(LEFT));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(IRS5500_Base, IRS5500_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'I',
                        TRUE, document_locator_number,
                        sponsor_dfe_name,
                        spons_prim_range, spons_prim_name, spons_sec_range, spons_zip5,
                        TRUE, spon_dfe_phone_num,
                        TRUE, ein,
						TRUE, document_locator_number)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

IRS5500_Base_BDID_Match := IRS5500_Base_BDID_Init(bdid <> 0);
IRS5500_Base_BDID_NoMatch := IRS5500_Base_BDID_Init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(IRS5500_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  sponsor_dfe_name,
                                  spons_prim_range, spons_prim_name, spons_zip5,
                                  spons_sec_range, spons_st,
                                  spon_dfe_phone_num, ein,
                                  bdid, IRS5500.Layout_IRS5500_Base,
                                  FALSE, BDID_score_field,
                                  IRS5500_Base_BDID_Rematch)

IRS5500_Base_BDID_All := IRS5500_Base_BDID_Match + IRS5500_Base_BDID_Rematch;

//OUTPUT(IRS5500_Base_BDID_All,, '~thor_data400::BASE::IRS5500_' + IRS5500.Version, OVERWRITE);
ut.MAC_SF_BuildProcess(irs5500_base_bdid_all,'~thor_data400::base::irs5500',do1,2);

export make_irs5500_Company_base := do1;

