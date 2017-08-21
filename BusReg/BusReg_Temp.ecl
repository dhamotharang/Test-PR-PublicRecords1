import ut,DID_Add,header_slimsort,Business_Header, Business_Header_SS, Address;
d := BusReg.File_BusReg_In;

// Dedup Input file to remove identical records
busReq_srt := sort(distribute(d,hash(company_name,ofc1_name)),OFC1_NAME,
 OFC1_TITLE,
FIRST_NAME,
 MI,
LAST_NAME,
 SUFFIX,
 GENDER,
 OWNR_CODE,
 XCODE,
COMPANY_NAME,
MAIL_ADD,
MAIL_SUITE,
MAIL_CITY,
 MAIL_STATE,
 MAIL_ZIP_ORIG,
 MAIL_ZIP4_ORIG,
 MAIL_KEY,
COUNTY,
COUNTRY,
DISTRICT,
 CITYLIMITS,
 BIZ_AC,
BIZ_PHONE,
 FAX_AC,
FAX_NUM,
 SIC,
 NAICS,
DESCRIPT,
 EMP_SIZE,
 OWN_SIZE,
 CORPCODE,
 SOS_CODE,
 FILING_COD,
 STATE_CODE,
 STATUS,
STAT_DES,
 LIC_STS,
 LIC_TYPE,
FILING_NUM,
LICID,
 ACCT_NUM,
CO_FEI,
CTRL_NUM,
 START_DATE,
FILE_DATE,
 CCYYMMDD,
 FORM_DATE,
 EXP_DATE,
 DISOL_DATE,
 RPT_DATE,
 RENEW_DATE,
 CHANG_DATE,
 APPT_DATE,
 FISC_DATE_,
DURATION,
LOC_ADD,
LOC_SUITE,
LOC_CITY,
 LOC_STATE,
 LOC_ZIP_ORIG,
 LOC_ZIP4_ORIG,
LOC_IDX,
OFC1_ADD,
OFC1_SUITE,
OFC1_CITY,
 OFC1_STATE,
OFC1_ZIP_ORIG,
 OFC1_AC,
OFC1_PHONE,
OFC1_FEIN,
OFC1_SSN,
OFC1_TYPE,
OFC2_NAME,
 OFC2_TITLE,
OFC2_ADD,
OFC2_CSZ,
OFC2_FEIN,
OFC2_SSN,
OFC3_NAME,
 OFC3_TITLE,
OFC3_ADD,
OFC3_CSZ,
OFC3_FEIN,
OFC3_SSN,
OFC4_NAME,
 OFC4_TITLE,
OFC4_ADD,
OFC4_CSZ,
OFC4_FEIN,
OFC4_SSN,
OFC5_NAME,
 OFC5_TITLE,
OFC5_ADD,
OFC5_CSZ,
OFC5_FEIN,
OFC5_SSN,
OFC6_NAME,
 OFC6_TITLE,
OFC6_ADD,
OFC6_CSZ,
OFC6_FEIN,
OFC6_SSN,
 RA_DATE,
RA_FILE,
RA_NAME,
RA_ADD,
RA_SUITE,
RA_CITY,
 RA_STATE,
RA_ZIP_ORIG,
 RA_AC,
RA_PHONE,
 CLASS,
STOCK_ISS,
 STOCK_PAR,
STOCK_TYPE,
 STOCK_CAP,
 PAIDN_CAP,
 FEE,
 FEE_2,
 FEE_3,
 TAX_CL,
ACT,
CHAPTER,
 PAGE,
 VOLUME,
COMMENTS,
EMAIL_ADDR,
USER_NAME,
 DSF,
 HMBASE,
 HO,
 SOLICIT,
FIPS,
 MISC_CODE,
 AGENT_KEY,
 PROC_DATE,
 crlf,
mail_prim_range,
 mail_predir,
mail_prim_name,
 mail_addr_suffix,
 mail_postdir,
mail_unit_desig,
 mail_sec_range,
mail_p_city_name,
mail_v_city_name,
 mail_st,
 mail_zip,
 mail_zip4,
 mail_cart,
 mail_cr_sort_sz,
 mail_lot,
 mail_lot_order,
 mail_dpbc,
 mail_chk_digit,
 mail_record_type,
 mail_ace_fips_st,
 mail_fipscounty,
mail_geo_lat,
mail_geo_long,
 mail_msa,
 mail_geo_blk,
 mail_geo_match,
 mail_err_stat,
loc_prim_range,
 loc_predir,
loc_prim_name,
 loc_addr_suffix,
 loc_postdir,
loc_unit_desig,
 loc_sec_range,
loc_p_city_name,
loc_v_city_name,
 loc_st,
 loc_zip,
 loc_zip4,
 loc_cart,
 loc_cr_sort_sz,
 loc_lot,
 loc_lot_order,
 loc_dpbc,
 loc_chk_digit,
 loc_record_type,
 loc_ace_fips_st,
 loc_fipscounty,
loc_geo_lat,
loc_geo_long,
 loc_msa,
 loc_geo_blk,
 loc_geo_match,
 loc_err_stat,
ofc1_prim_range,
 ofc1_predir,
ofc1_prim_name,
 ofc1_addr_suffix,
 ofc1_postdir,
ofc1_unit_desig,
 ofc1_sec_range,
ofc1_p_city_name,
ofc1_v_city_name,
 ofc1_st,
 ofc1_zip,
 ofc1_zip4,
 ofc1_cart,
 ofc1_cr_sort_sz,
 ofc1_lot,
 ofc1_lot_order,
 ofc1_dpbc,
 ofc1_chk_digit,
 ofc1_record_type,
 ofc1_ace_fips_st,
 ofc1_fipscounty,
ofc1_geo_lat,
ofc1_geo_long,
 ofc1_msa,
 ofc1_geo_blk,
 ofc1_geo_match,
 ofc1_err_stat,
ofc2_prim_range,
 ofc2_predir,
ofc2_prim_name,
 ofc2_addr_suffix,
 ofc2_postdir,
ofc2_unit_desig,
 ofc2_sec_range,
ofc2_p_city_name,
ofc2_v_city_name,
 ofc2_st,
 ofc2_zip,
 ofc2_zip4,
 ofc2_cart,
 ofc2_cr_sort_sz,
 ofc2_lot,
 ofc2_lot_order,
 ofc2_dpbc,
 ofc2_chk_digit,
 ofc2_record_type,
 ofc2_ace_fips_st,
 ofc2_fipscounty,
ofc2_geo_lat,
ofc2_geo_long,
 ofc2_msa,
 ofc2_geo_blk,
 ofc2_geo_match,
 ofc2_err_stat,
ofc3_prim_range,
 ofc3_predir,
ofc3_prim_name,
 ofc3_addr_suffix,
 ofc3_postdir,
ofc3_unit_desig,
 ofc3_sec_range,
ofc3_p_city_name,
ofc3_v_city_name,
 ofc3_st,
 ofc3_zip,
 ofc3_zip4,
 ofc3_cart,
 ofc3_cr_sort_sz,
 ofc3_lot,
 ofc3_lot_order,
 ofc3_dpbc,
 ofc3_chk_digit,
 ofc3_record_type,
 ofc3_ace_fips_st,
 ofc3_fipscounty,
ofc3_geo_lat,
ofc3_geo_long,
 ofc3_msa,
 ofc3_geo_blk,
 ofc3_geo_match,
 ofc3_err_stat,
ofc4_prim_range,
 ofc4_predir,
ofc4_prim_name,
 ofc4_addr_suffix,
 ofc4_postdir,
ofc4_unit_desig,
 ofc4_sec_range,
ofc4_p_city_name,
ofc4_v_city_name,
 ofc4_st,
 ofc4_zip,
 ofc4_zip4,
 ofc4_cart,
 ofc4_cr_sort_sz,
 ofc4_lot,
 ofc4_lot_order,
 ofc4_dpbc,
 ofc4_chk_digit,
 ofc4_record_type,
 ofc4_ace_fips_st,
 ofc4_fipscounty,
ofc4_geo_lat,
ofc4_geo_long,
 ofc4_msa,
 ofc4_geo_blk,
 ofc4_geo_match,
 ofc4_err_stat,
ofc5_prim_range,
 ofc5_predir,
ofc5_prim_name,
 ofc5_addr_suffix,
 ofc5_postdir,
ofc5_unit_desig,
 ofc5_sec_range,
ofc5_p_city_name,
ofc5_v_city_name,
 ofc5_st,
 ofc5_zip,
 ofc5_zip4,
 ofc5_cart,
 ofc5_cr_sort_sz,
 ofc5_lot,
 ofc5_lot_order,
 ofc5_dpbc,
 ofc5_chk_digit,
 ofc5_record_type,
 ofc5_ace_fips_st,
 ofc5_fipscounty,
ofc5_geo_lat,
ofc5_geo_long,
 ofc5_msa,
 ofc5_geo_blk,
 ofc5_geo_match,
 ofc5_err_stat,
ofc6_prim_range,
 ofc6_predir,
ofc6_prim_name,
 ofc6_addr_suffix,
 ofc6_postdir,
ofc6_unit_desig,
 ofc6_sec_range,
ofc6_p_city_name,
ofc6_v_city_name,
 ofc6_st,
 ofc6_zip,
 ofc6_zip4,
 ofc6_cart,
 ofc6_cr_sort_sz,
 ofc6_lot,
 ofc6_lot_order,
 ofc6_dpbc,
 ofc6_chk_digit,
 ofc6_record_type,
 ofc6_ace_fips_st,
 ofc6_fipscounty,
ofc6_geo_lat,
ofc6_geo_long,
 ofc6_msa,
 ofc6_geo_blk,
 ofc6_geo_match,
 ofc6_err_stat,
ra_prim_range,
 ra_predir,
ra_prim_name,
 ra_addr_suffix,
 ra_postdir,
ra_unit_desig,
 ra_sec_range,
ra_p_city_name,
ra_v_city_name,
 ra_st,
 ra_zip,
 ra_zip4,
 ra_cart,
 ra_cr_sort_sz,
 ra_lot,
 ra_lot_order,
 ra_dpbc,
 ra_chk_digit,
 ra_record_type,
 ra_ace_fips_st,
 ra_fipscounty,
ra_geo_lat,
ra_geo_long,
 ra_msa,
 ra_geo_blk,
 ra_geo_match,
 ra_err_stat,
 ofc1_name_prefix,
ofc1_name_first,
ofc1_name_middle,
ofc1_name_last,
 ofc1_name_suffix,
 ofc1_name_score,
 ofc2_name_prefix,
ofc2_name_first,
ofc2_name_middle,
ofc2_name_last,
 ofc2_name_suffix,
 ofc2_name_score,
 ofc3_name_prefix,
ofc3_name_first,
ofc3_name_middle,
ofc3_name_last,
 ofc3_name_suffix,
 ofc3_name_score,
 ofc4_name_prefix,
ofc4_name_first,
ofc4_name_middle,
ofc4_name_last,
 ofc4_name_suffix,
 ofc4_name_score,
 ofc5_name_prefix,
ofc5_name_first,
ofc5_name_middle,
ofc5_name_last,
 ofc5_name_suffix,
 ofc5_name_score,
 ofc6_name_prefix,
ofc6_name_first,
ofc6_name_middle,
ofc6_name_last,
 ofc6_name_suffix,
 ofc6_name_score,-record_date,local);

BusReq_Dedup := DEDUP(busreq_srt,OFC1_NAME,
 OFC1_TITLE,
FIRST_NAME,
 MI,
LAST_NAME,
 SUFFIX,
 GENDER,
 OWNR_CODE,
 XCODE,
COMPANY_NAME,
MAIL_ADD,
MAIL_SUITE,
MAIL_CITY,
 MAIL_STATE,
 MAIL_ZIP_ORIG,
 MAIL_ZIP4_ORIG,
 MAIL_KEY,
COUNTY,
COUNTRY,
DISTRICT,
 CITYLIMITS,
 BIZ_AC,
BIZ_PHONE,
 FAX_AC,
FAX_NUM,
 SIC,
 NAICS,
DESCRIPT,
 EMP_SIZE,
 OWN_SIZE,
 CORPCODE,
 SOS_CODE,
 FILING_COD,
 STATE_CODE,
 STATUS,
STAT_DES,
 LIC_STS,
 LIC_TYPE,
FILING_NUM,
LICID,
 ACCT_NUM,
CO_FEI,
CTRL_NUM,
 START_DATE,
FILE_DATE,
 CCYYMMDD,
 FORM_DATE,
 EXP_DATE,
 DISOL_DATE,
 RPT_DATE,
 RENEW_DATE,
 CHANG_DATE,
 APPT_DATE,
 FISC_DATE_,
DURATION,
LOC_ADD,
LOC_SUITE,
LOC_CITY,
 LOC_STATE,
 LOC_ZIP_ORIG,
 LOC_ZIP4_ORIG,
LOC_IDX,
OFC1_ADD,
OFC1_SUITE,
OFC1_CITY,
 OFC1_STATE,
OFC1_ZIP_ORIG,
 OFC1_AC,
OFC1_PHONE,
OFC1_FEIN,
OFC1_SSN,
OFC1_TYPE,
OFC2_NAME,
 OFC2_TITLE,
OFC2_ADD,
OFC2_CSZ,
OFC2_FEIN,
OFC2_SSN,
OFC3_NAME,
 OFC3_TITLE,
OFC3_ADD,
OFC3_CSZ,
OFC3_FEIN,
OFC3_SSN,
OFC4_NAME,
 OFC4_TITLE,
OFC4_ADD,
OFC4_CSZ,
OFC4_FEIN,
OFC4_SSN,
OFC5_NAME,
 OFC5_TITLE,
OFC5_ADD,
OFC5_CSZ,
OFC5_FEIN,
OFC5_SSN,
OFC6_NAME,
 OFC6_TITLE,
OFC6_ADD,
OFC6_CSZ,
OFC6_FEIN,
OFC6_SSN,
 RA_DATE,
RA_FILE,
RA_NAME,
RA_ADD,
RA_SUITE,
RA_CITY,
 RA_STATE,
RA_ZIP_ORIG,
 RA_AC,
RA_PHONE,
 CLASS,
STOCK_ISS,
 STOCK_PAR,
STOCK_TYPE,
 STOCK_CAP,
 PAIDN_CAP,
 FEE,
 FEE_2,
 FEE_3,
 TAX_CL,
ACT,
CHAPTER,
 PAGE,
 VOLUME,
COMMENTS,
EMAIL_ADDR,
USER_NAME,
 DSF,
 HMBASE,
 HO,
 SOLICIT,
FIPS,
 MISC_CODE,
 AGENT_KEY,
 crlf,
mail_prim_range,
 mail_predir,
mail_prim_name,
 mail_addr_suffix,
 mail_postdir,
mail_unit_desig,
 mail_sec_range,
mail_p_city_name,
mail_v_city_name,
 mail_st,
 mail_zip,
 mail_zip4,
 mail_cart,
 mail_cr_sort_sz,
 mail_lot,
 mail_lot_order,
 mail_dpbc,
 mail_chk_digit,
 mail_record_type,
 mail_ace_fips_st,
 mail_fipscounty,
mail_geo_lat,
mail_geo_long,
 mail_msa,
 mail_geo_blk,
 mail_geo_match,
 mail_err_stat,
loc_prim_range,
 loc_predir,
loc_prim_name,
 loc_addr_suffix,
 loc_postdir,
loc_unit_desig,
 loc_sec_range,
loc_p_city_name,
loc_v_city_name,
 loc_st,
 loc_zip,
 loc_zip4,
 loc_cart,
 loc_cr_sort_sz,
 loc_lot,
 loc_lot_order,
 loc_dpbc,
 loc_chk_digit,
 loc_record_type,
 loc_ace_fips_st,
 loc_fipscounty,
loc_geo_lat,
loc_geo_long,
 loc_msa,
 loc_geo_blk,
 loc_geo_match,
 loc_err_stat,
ofc1_prim_range,
 ofc1_predir,
ofc1_prim_name,
 ofc1_addr_suffix,
 ofc1_postdir,
ofc1_unit_desig,
 ofc1_sec_range,
ofc1_p_city_name,
ofc1_v_city_name,
 ofc1_st,
 ofc1_zip,
 ofc1_zip4,
 ofc1_cart,
 ofc1_cr_sort_sz,
 ofc1_lot,
 ofc1_lot_order,
 ofc1_dpbc,
 ofc1_chk_digit,
 ofc1_record_type,
 ofc1_ace_fips_st,
 ofc1_fipscounty,
ofc1_geo_lat,
ofc1_geo_long,
 ofc1_msa,
 ofc1_geo_blk,
 ofc1_geo_match,
 ofc1_err_stat,
ofc2_prim_range,
 ofc2_predir,
ofc2_prim_name,
 ofc2_addr_suffix,
 ofc2_postdir,
ofc2_unit_desig,
 ofc2_sec_range,
ofc2_p_city_name,
ofc2_v_city_name,
 ofc2_st,
 ofc2_zip,
 ofc2_zip4,
 ofc2_cart,
 ofc2_cr_sort_sz,
 ofc2_lot,
 ofc2_lot_order,
 ofc2_dpbc,
 ofc2_chk_digit,
 ofc2_record_type,
 ofc2_ace_fips_st,
 ofc2_fipscounty,
ofc2_geo_lat,
ofc2_geo_long,
 ofc2_msa,
 ofc2_geo_blk,
 ofc2_geo_match,
 ofc2_err_stat,
ofc3_prim_range,
 ofc3_predir,
ofc3_prim_name,
 ofc3_addr_suffix,
 ofc3_postdir,
ofc3_unit_desig,
 ofc3_sec_range,
ofc3_p_city_name,
ofc3_v_city_name,
 ofc3_st,
 ofc3_zip,
 ofc3_zip4,
 ofc3_cart,
 ofc3_cr_sort_sz,
 ofc3_lot,
 ofc3_lot_order,
 ofc3_dpbc,
 ofc3_chk_digit,
 ofc3_record_type,
 ofc3_ace_fips_st,
 ofc3_fipscounty,
ofc3_geo_lat,
ofc3_geo_long,
 ofc3_msa,
 ofc3_geo_blk,
 ofc3_geo_match,
 ofc3_err_stat,
ofc4_prim_range,
 ofc4_predir,
ofc4_prim_name,
 ofc4_addr_suffix,
 ofc4_postdir,
ofc4_unit_desig,
 ofc4_sec_range,
ofc4_p_city_name,
ofc4_v_city_name,
 ofc4_st,
 ofc4_zip,
 ofc4_zip4,
 ofc4_cart,
 ofc4_cr_sort_sz,
 ofc4_lot,
 ofc4_lot_order,
 ofc4_dpbc,
 ofc4_chk_digit,
 ofc4_record_type,
 ofc4_ace_fips_st,
 ofc4_fipscounty,
ofc4_geo_lat,
ofc4_geo_long,
 ofc4_msa,
 ofc4_geo_blk,
 ofc4_geo_match,
 ofc4_err_stat,
ofc5_prim_range,
 ofc5_predir,
ofc5_prim_name,
 ofc5_addr_suffix,
 ofc5_postdir,
ofc5_unit_desig,
 ofc5_sec_range,
ofc5_p_city_name,
ofc5_v_city_name,
 ofc5_st,
 ofc5_zip,
 ofc5_zip4,
 ofc5_cart,
 ofc5_cr_sort_sz,
 ofc5_lot,
 ofc5_lot_order,
 ofc5_dpbc,
 ofc5_chk_digit,
 ofc5_record_type,
 ofc5_ace_fips_st,
 ofc5_fipscounty,
ofc5_geo_lat,
ofc5_geo_long,
 ofc5_msa,
 ofc5_geo_blk,
 ofc5_geo_match,
 ofc5_err_stat,
ofc6_prim_range,
 ofc6_predir,
ofc6_prim_name,
 ofc6_addr_suffix,
 ofc6_postdir,
ofc6_unit_desig,
 ofc6_sec_range,
ofc6_p_city_name,
ofc6_v_city_name,
 ofc6_st,
 ofc6_zip,
 ofc6_zip4,
 ofc6_cart,
 ofc6_cr_sort_sz,
 ofc6_lot,
 ofc6_lot_order,
 ofc6_dpbc,
 ofc6_chk_digit,
 ofc6_record_type,
 ofc6_ace_fips_st,
 ofc6_fipscounty,
ofc6_geo_lat,
ofc6_geo_long,
 ofc6_msa,
 ofc6_geo_blk,
 ofc6_geo_match,
 ofc6_err_stat,
ra_prim_range,
 ra_predir,
ra_prim_name,
 ra_addr_suffix,
 ra_postdir,
ra_unit_desig,
 ra_sec_range,
ra_p_city_name,
ra_v_city_name,
 ra_st,
 ra_zip,
 ra_zip4,
 ra_cart,
 ra_cr_sort_sz,
 ra_lot,
 ra_lot_order,
 ra_dpbc,
 ra_chk_digit,
 ra_record_type,
 ra_ace_fips_st,
 ra_fipscounty,
ra_geo_lat,
ra_geo_long,
 ra_msa,
 ra_geo_blk,
 ra_geo_match,
 ra_err_stat,
 ofc1_name_prefix,
ofc1_name_first,
ofc1_name_middle,
ofc1_name_last,
 ofc1_name_suffix,
 ofc1_name_score,
 ofc2_name_prefix,
ofc2_name_first,
ofc2_name_middle,
ofc2_name_last,
 ofc2_name_suffix,
 ofc2_name_score,
 ofc3_name_prefix,
ofc3_name_first,
ofc3_name_middle,
ofc3_name_last,
 ofc3_name_suffix,
 ofc3_name_score,
 ofc4_name_prefix,
ofc4_name_first,
ofc4_name_middle,
ofc4_name_last,
 ofc4_name_suffix,
 ofc4_name_score,
 ofc5_name_prefix,
ofc5_name_first,
ofc5_name_middle,
ofc5_name_last,
 ofc5_name_suffix,
 ofc5_name_score,
 ofc6_name_prefix,
ofc6_name_first,
ofc6_name_middle,
ofc6_name_last,
 ofc6_name_suffix,
 ofc6_name_score,local);

busreg.Layout_BusReg_Temp IDLayout(busreg.layout_BusReg_In L) := transform
 self.bdid := 0;
 self.br_id := 0;
 self.dt_first_seen := IF(l.ccyymmdd='',l.record_date,l.ccyymmdd);
 self.dt_last_seen := l.record_date;
 self.record_type := 'C';
 self.company_phone10 := Address.CleanPhone(trim(l.biz_ac)+trim(l.BIZ_PHONE));
 self.ofc1_phone10 := Address.CleanPhone(trim(l.ofc1_ac)+trim(l.OFC1_PHONE));
 self.ra_phone10 := Address.CleanPhone(trim(l.ra_ac)+trim(l.RA_PHONE));
 self.mail_p_city_name := if(l.mail_err_stat='E101','',l.mail_p_city_name);
 self.mail_v_city_name := if(l.mail_err_stat='E101','',l.mail_v_city_name);
 self.loc_p_city_name := if(l.loc_err_stat='E101','',l.loc_p_city_name);
 self.loc_v_city_name := if(l.loc_err_stat='E101','',l.loc_v_city_name);
 self := l;
end;

//Project into temp layout
temp_format := project(busreq_dedup,IDLayout(left));

//Add BR_IDs to all records
ut.MAC_Sequence_Records(temp_format,br_id,with_id)
/*max_br_id := max(File_BusReg_Base,br_id);

busreg.layout_busreg_temp addID(busreg.layout_busreg_temp L) := transform
 self.br_id := l.br_id + max_br_id;
 self := l;
end;

IDed := project(with_id,addID(left)) : persist('Temp::BusReg_Ids');*/

//Assign BDID
Layout_4_BDID := RECORD
BusReg.Layout_BusReg_Temp;
UNSIGNED4 fein;
STRING34  company_source_group;
END;

Layout_4_BDID InitForBDID(BusReg.Layout_BusReg_Temp L) := TRANSFORM
SELF.fein := MAP(L.co_fei=''=>0,
				 L.co_fei[1]='N'=>0,
				 L.co_fei[3] != '-' => (UNSIGNED4)L.co_fei,
				 (UNSIGNED4)(L.co_fei[1..2] + L.co_fei[4..10]));
SELF.company_source_group := IF(L.filing_num <> '',
                               (STRING34)(trim(L.filing_num)+trim(L.company_name)),
                               '');
SELF := L;
END;

Base_ToBDID := PROJECT(with_id, InitForBDID(LEFT));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(Base_ToBDID, Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'BR',
                        TRUE, company_source_group,
                        company_name,
                        mail_prim_range, mail_prim_name, mail_sec_range, mail_zip,
                        TRUE, company_phone10,
                        TRUE, fein)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Base_BDID_Match := Base_BDID_Init(bdid <> 0);
Base_BDID_NoMatch := Base_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  company_name,
                                  mail_prim_range, mail_prim_name, mail_zip,
								  mail_sec_range, mail_st,
                                  company_phone10, fein,
                                  bdid, Layout_4_BDID,
                                  FALSE, BDID_score_field,
                                  Base_BDID_Rematch)

Base_BDID_All := Base_BDID_Match + Base_BDID_Rematch;

BusReg.Layout_BusReg_Temp FormatOutput(Layout_4_BDID L) := TRANSFORM
SELF := L;
END;

export BusReg_Temp := PROJECT(Base_BDID_All, FormatOutput(LEFT)) : persist('persist::BusReg');