IMPORT SALT37;
IMPORT Scrubs_Equifax_Business_Data; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Base_Layout_Equifax_Business_Data)
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 normcompany_type_Invalid;
    UNSIGNED1 normaddress_type_Invalid;
    UNSIGNED1 norm_state_Invalid;
    UNSIGNED1 norm_zip_Invalid;
    UNSIGNED1 norm_zip4_Invalid;
    UNSIGNED1 EFX_NAME_Invalid;
    UNSIGNED1 EFX_LEGAL_NAME_Invalid;
    UNSIGNED1 EFX_ADDRESS_Invalid;
    UNSIGNED1 clean_company_name_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 raw_aid_Invalid;
    UNSIGNED1 ace_aid_Invalid;
    UNSIGNED1 EFX_BUSSTATCD_Invalid;
    UNSIGNED1 EFX_CMSA_Invalid;
    UNSIGNED1 EFX_CORPAMOUNTCD_Invalid;
    UNSIGNED1 EFX_CORPAMOUNTPREC_Invalid;
    UNSIGNED1 EFX_CORPAMOUNTTP_Invalid;
    UNSIGNED1 EFX_CORPEMPCD_Invalid;
    UNSIGNED1 EFX_CTRYISOCD_Invalid;
    UNSIGNED1 EFX_CTRYNUM_Invalid;
    UNSIGNED1 EFX_CTRYTELCD_Invalid;
    UNSIGNED1 EFX_GEOPREC_Invalid;
    UNSIGNED1 EFX_MERCTYPE_Invalid;
    UNSIGNED1 EFX_MRKT_TELESCORE_Invalid;
    UNSIGNED1 EFX_MRKT_TOTALIND_Invalid;
    UNSIGNED1 EFX_MRKT_TOTALSCORE_Invalid;
    UNSIGNED1 EFX_PUBLIC_Invalid;
    UNSIGNED1 EFX_STKEXC_Invalid;
    UNSIGNED1 EFX_PRIMSIC_Invalid;
    UNSIGNED1 EFX_SECSIC1_Invalid;
    UNSIGNED1 EFX_SECSIC2_Invalid;
    UNSIGNED1 EFX_SECSIC3_Invalid;
    UNSIGNED1 EFX_SECSIC4_Invalid;
    UNSIGNED1 EFX_ID_Invalid;
    UNSIGNED1 EFX_CITY_Invalid;
    UNSIGNED1 EFX_CTRYNAME_Invalid;
    UNSIGNED1 EFX_SOHO_Invalid;
    UNSIGNED1 EFX_BIZ_Invalid;
    UNSIGNED1 EFX_RES_Invalid;
    UNSIGNED1 EFX_CMRA_Invalid;
    UNSIGNED1 EFX_SECGEOPREC_Invalid;
    UNSIGNED1 EFX_SECCTRYISOCD_Invalid;
    UNSIGNED1 EFX_SECCTRYNUM_Invalid;
    UNSIGNED1 EFX_PHONE_Invalid;
    UNSIGNED1 EFX_FAXPHONE_Invalid;
    UNSIGNED1 EFX_YREST_Invalid;
    UNSIGNED1 EFX_CORPEMPCNT_Invalid;
    UNSIGNED1 EFX_LOCEMPCNT_Invalid;
    UNSIGNED1 EFX_LOCEMPCD_Invalid;
    UNSIGNED1 EFX_CORPAMOUNT_Invalid;
    UNSIGNED1 EFX_LOCAMOUNT_Invalid;
    UNSIGNED1 EFX_LOCAMOUNTCD_Invalid;
    UNSIGNED1 EFX_LOCAMOUNTTP_Invalid;
    UNSIGNED1 EFX_LOCAMOUNTPREC_Invalid;
    UNSIGNED1 EFX_PRIMNAICSCODE_Invalid;
    UNSIGNED1 EFX_SECNAICS1_Invalid;
    UNSIGNED1 EFX_SECNAICS2_Invalid;
    UNSIGNED1 EFX_SECNAICS3_Invalid;
    UNSIGNED1 EFX_SECNAICS4_Invalid;
    UNSIGNED1 EFX_DEAD_Invalid;
    UNSIGNED1 EFX_DEADDT_Invalid;
    UNSIGNED1 EFX_MRKT_TELEVER_Invalid;
    UNSIGNED1 EFX_MRKT_VACANT_Invalid;
    UNSIGNED1 EFX_MRKT_SEASONAL_Invalid;
    UNSIGNED1 EFX_MBE_Invalid;
    UNSIGNED1 EFX_WBE_Invalid;
    UNSIGNED1 EFX_MWBE_Invalid;
    UNSIGNED1 EFX_SDB_Invalid;
    UNSIGNED1 EFX_HUBZONE_Invalid;
    UNSIGNED1 EFX_DBE_Invalid;
    UNSIGNED1 EFX_VET_Invalid;
    UNSIGNED1 EFX_DVET_Invalid;
    UNSIGNED1 EFX_8a_Invalid;
    UNSIGNED1 EFX_8aEXPDT_Invalid;
    UNSIGNED1 EFX_DIS_Invalid;
    UNSIGNED1 EFX_SBE_Invalid;
    UNSIGNED1 EFX_BUSSIZE_Invalid;
    UNSIGNED1 EFX_LBE_Invalid;
    UNSIGNED1 EFX_GOV_Invalid;
    UNSIGNED1 EFX_FGOV_Invalid;
    UNSIGNED1 EFX_NONPROFIT_Invalid;
    UNSIGNED1 EFX_HBCU_Invalid;
    UNSIGNED1 EFX_GAYLESBIAN_Invalid;
    UNSIGNED1 EFX_WSBE_Invalid;
    UNSIGNED1 EFX_VSBE_Invalid;
    UNSIGNED1 EFX_DVSBE_Invalid;
    UNSIGNED1 EFX_MWBESTATUS_Invalid;
    UNSIGNED1 EFX_NMSDC_Invalid;
    UNSIGNED1 EFX_WBENC_Invalid;
    UNSIGNED1 EFX_CA_PUC_Invalid;
    UNSIGNED1 EFX_TX_HUB_Invalid;
    UNSIGNED1 EFX_GSAX_Invalid;
    UNSIGNED1 EFX_CALTRANS_Invalid;
    UNSIGNED1 EFX_EDU_Invalid;
    UNSIGNED1 EFX_MI_Invalid;
    UNSIGNED1 EFX_ANC_Invalid;
    UNSIGNED1 AT_CERTLEV1_Invalid;
    UNSIGNED1 AT_CERTLEV2_Invalid;
    UNSIGNED1 AT_CERTLEV3_Invalid;
    UNSIGNED1 AT_CERTLEV4_Invalid;
    UNSIGNED1 AT_CERTLEV5_Invalid;
    UNSIGNED1 AT_CERTLEV6_Invalid;
    UNSIGNED1 AT_CERTLEV7_Invalid;
    UNSIGNED1 AT_CERTLEV8_Invalid;
    UNSIGNED1 AT_CERTLEV9_Invalid;
    UNSIGNED1 AT_CERTLEV10_Invalid;
    UNSIGNED1 AT_CERTEXP1_Invalid;
    UNSIGNED1 AT_CERTEXP2_Invalid;
    UNSIGNED1 AT_CERTEXP3_Invalid;
    UNSIGNED1 AT_CERTEXP4_Invalid;
    UNSIGNED1 AT_CERTEXP5_Invalid;
    UNSIGNED1 AT_CERTEXP6_Invalid;
    UNSIGNED1 AT_CERTEXP7_Invalid;
    UNSIGNED1 AT_CERTEXP8_Invalid;
    UNSIGNED1 AT_CERTEXP9_Invalid;
    UNSIGNED1 AT_CERTEXP10_Invalid;
    UNSIGNED1 EFX_EXTRACT_DATE_Invalid;
    UNSIGNED1 EFX_MERCHANT_ID_Invalid;
    UNSIGNED1 EFX_PROJECT_ID_Invalid;
    UNSIGNED1 EFX_FOREIGN_Invalid;
    UNSIGNED1 Record_Update_Refresh_Date_Invalid;
    UNSIGNED1 EFX_DATE_CREATED_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Equifax_Business_Data)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
  END;
EXPORT FromNone(DATASET(Base_Layout_Equifax_Business_Data) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dotid_Invalid := Base_Fields.InValid_dotid((SALT37.StrType)le.dotid);
    SELF.dotscore_Invalid := Base_Fields.InValid_dotscore((SALT37.StrType)le.dotscore);
    SELF.dotweight_Invalid := Base_Fields.InValid_dotweight((SALT37.StrType)le.dotweight);
    SELF.empid_Invalid := Base_Fields.InValid_empid((SALT37.StrType)le.empid);
    SELF.empscore_Invalid := Base_Fields.InValid_empscore((SALT37.StrType)le.empscore);
    SELF.empweight_Invalid := Base_Fields.InValid_empweight((SALT37.StrType)le.empweight);
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT37.StrType)le.powid);
    SELF.powscore_Invalid := Base_Fields.InValid_powscore((SALT37.StrType)le.powscore);
    SELF.powweight_Invalid := Base_Fields.InValid_powweight((SALT37.StrType)le.powweight);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT37.StrType)le.proxid);
    SELF.proxscore_Invalid := Base_Fields.InValid_proxscore((SALT37.StrType)le.proxscore);
    SELF.proxweight_Invalid := Base_Fields.InValid_proxweight((SALT37.StrType)le.proxweight);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT37.StrType)le.seleid);
    SELF.selescore_Invalid := Base_Fields.InValid_selescore((SALT37.StrType)le.selescore);
    SELF.seleweight_Invalid := Base_Fields.InValid_seleweight((SALT37.StrType)le.seleweight);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT37.StrType)le.orgid);
    SELF.orgscore_Invalid := Base_Fields.InValid_orgscore((SALT37.StrType)le.orgscore);
    SELF.orgweight_Invalid := Base_Fields.InValid_orgweight((SALT37.StrType)le.orgweight);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT37.StrType)le.ultid);
    SELF.ultscore_Invalid := Base_Fields.InValid_ultscore((SALT37.StrType)le.ultscore);
    SELF.ultweight_Invalid := Base_Fields.InValid_ultweight((SALT37.StrType)le.ultweight);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT37.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT37.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT37.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT37.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Base_Fields.InValid_process_date((SALT37.StrType)le.process_date);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT37.StrType)le.record_type);
    SELF.normcompany_type_Invalid := Base_Fields.InValid_normcompany_type((SALT37.StrType)le.normcompany_type);
    SELF.normaddress_type_Invalid := Base_Fields.InValid_normaddress_type((SALT37.StrType)le.normaddress_type);
    SELF.norm_state_Invalid := Base_Fields.InValid_norm_state((SALT37.StrType)le.norm_state);
    SELF.norm_zip_Invalid := Base_Fields.InValid_norm_zip((SALT37.StrType)le.norm_zip);
    SELF.norm_zip4_Invalid := Base_Fields.InValid_norm_zip4((SALT37.StrType)le.norm_zip4);
    SELF.EFX_NAME_Invalid := Base_Fields.InValid_EFX_NAME((SALT37.StrType)le.EFX_NAME);
    SELF.EFX_LEGAL_NAME_Invalid := Base_Fields.InValid_EFX_LEGAL_NAME((SALT37.StrType)le.EFX_LEGAL_NAME);
    SELF.EFX_ADDRESS_Invalid := Base_Fields.InValid_EFX_ADDRESS((SALT37.StrType)le.EFX_ADDRESS);
    SELF.clean_company_name_Invalid := Base_Fields.InValid_clean_company_name((SALT37.StrType)le.clean_company_name);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT37.StrType)le.clean_phone);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT37.StrType)le.predir);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT37.StrType)le.postdir);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT37.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT37.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT37.StrType)le.zip4);
    SELF.cr_sort_sz_Invalid := Base_Fields.InValid_cr_sort_sz((SALT37.StrType)le.cr_sort_sz);
    SELF.lot_order_Invalid := Base_Fields.InValid_lot_order((SALT37.StrType)le.lot_order);
    SELF.rec_type_Invalid := Base_Fields.InValid_rec_type((SALT37.StrType)le.rec_type);
    SELF.fips_state_Invalid := Base_Fields.InValid_fips_state((SALT37.StrType)le.fips_state);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT37.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT37.StrType)le.geo_long);
    SELF.geo_match_Invalid := Base_Fields.InValid_geo_match((SALT37.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT37.StrType)le.err_stat);
    SELF.raw_aid_Invalid := Base_Fields.InValid_raw_aid((SALT37.StrType)le.raw_aid);
    SELF.ace_aid_Invalid := Base_Fields.InValid_ace_aid((SALT37.StrType)le.ace_aid);
    SELF.EFX_BUSSTATCD_Invalid := Base_Fields.InValid_EFX_BUSSTATCD((SALT37.StrType)le.EFX_BUSSTATCD);
    SELF.EFX_CMSA_Invalid := Base_Fields.InValid_EFX_CMSA((SALT37.StrType)le.EFX_CMSA);
    SELF.EFX_CORPAMOUNTCD_Invalid := Base_Fields.InValid_EFX_CORPAMOUNTCD((SALT37.StrType)le.EFX_CORPAMOUNTCD);
    SELF.EFX_CORPAMOUNTPREC_Invalid := Base_Fields.InValid_EFX_CORPAMOUNTPREC((SALT37.StrType)le.EFX_CORPAMOUNTPREC);
    SELF.EFX_CORPAMOUNTTP_Invalid := Base_Fields.InValid_EFX_CORPAMOUNTTP((SALT37.StrType)le.EFX_CORPAMOUNTTP);
    SELF.EFX_CORPEMPCD_Invalid := Base_Fields.InValid_EFX_CORPEMPCD((SALT37.StrType)le.EFX_CORPEMPCD);
    SELF.EFX_CTRYISOCD_Invalid := Base_Fields.InValid_EFX_CTRYISOCD((SALT37.StrType)le.EFX_CTRYISOCD);
    SELF.EFX_CTRYNUM_Invalid := Base_Fields.InValid_EFX_CTRYNUM((SALT37.StrType)le.EFX_CTRYNUM);
    SELF.EFX_CTRYTELCD_Invalid := Base_Fields.InValid_EFX_CTRYTELCD((SALT37.StrType)le.EFX_CTRYTELCD);
    SELF.EFX_GEOPREC_Invalid := Base_Fields.InValid_EFX_GEOPREC((SALT37.StrType)le.EFX_GEOPREC);
    SELF.EFX_MERCTYPE_Invalid := Base_Fields.InValid_EFX_MERCTYPE((SALT37.StrType)le.EFX_MERCTYPE);
    SELF.EFX_MRKT_TELESCORE_Invalid := Base_Fields.InValid_EFX_MRKT_TELESCORE((SALT37.StrType)le.EFX_MRKT_TELESCORE);
    SELF.EFX_MRKT_TOTALIND_Invalid := Base_Fields.InValid_EFX_MRKT_TOTALIND((SALT37.StrType)le.EFX_MRKT_TOTALIND);
    SELF.EFX_MRKT_TOTALSCORE_Invalid := Base_Fields.InValid_EFX_MRKT_TOTALSCORE((SALT37.StrType)le.EFX_MRKT_TOTALSCORE);
    SELF.EFX_PUBLIC_Invalid := Base_Fields.InValid_EFX_PUBLIC((SALT37.StrType)le.EFX_PUBLIC);
    SELF.EFX_STKEXC_Invalid := Base_Fields.InValid_EFX_STKEXC((SALT37.StrType)le.EFX_STKEXC);
    SELF.EFX_PRIMSIC_Invalid := Base_Fields.InValid_EFX_PRIMSIC((SALT37.StrType)le.EFX_PRIMSIC);
    SELF.EFX_SECSIC1_Invalid := Base_Fields.InValid_EFX_SECSIC1((SALT37.StrType)le.EFX_SECSIC1);
    SELF.EFX_SECSIC2_Invalid := Base_Fields.InValid_EFX_SECSIC2((SALT37.StrType)le.EFX_SECSIC2);
    SELF.EFX_SECSIC3_Invalid := Base_Fields.InValid_EFX_SECSIC3((SALT37.StrType)le.EFX_SECSIC3);
    SELF.EFX_SECSIC4_Invalid := Base_Fields.InValid_EFX_SECSIC4((SALT37.StrType)le.EFX_SECSIC4);
    SELF.EFX_ID_Invalid := Base_Fields.InValid_EFX_ID((SALT37.StrType)le.EFX_ID);
    SELF.EFX_CITY_Invalid := Base_Fields.InValid_EFX_CITY((SALT37.StrType)le.EFX_CITY);
    SELF.EFX_CTRYNAME_Invalid := Base_Fields.InValid_EFX_CTRYNAME((SALT37.StrType)le.EFX_CTRYNAME);
    SELF.EFX_SOHO_Invalid := Base_Fields.InValid_EFX_SOHO((SALT37.StrType)le.EFX_SOHO);
    SELF.EFX_BIZ_Invalid := Base_Fields.InValid_EFX_BIZ((SALT37.StrType)le.EFX_BIZ);
    SELF.EFX_RES_Invalid := Base_Fields.InValid_EFX_RES((SALT37.StrType)le.EFX_RES);
    SELF.EFX_CMRA_Invalid := Base_Fields.InValid_EFX_CMRA((SALT37.StrType)le.EFX_CMRA);
    SELF.EFX_SECGEOPREC_Invalid := Base_Fields.InValid_EFX_SECGEOPREC((SALT37.StrType)le.EFX_SECGEOPREC);
    SELF.EFX_SECCTRYISOCD_Invalid := Base_Fields.InValid_EFX_SECCTRYISOCD((SALT37.StrType)le.EFX_SECCTRYISOCD);
    SELF.EFX_SECCTRYNUM_Invalid := Base_Fields.InValid_EFX_SECCTRYNUM((SALT37.StrType)le.EFX_SECCTRYNUM);
    SELF.EFX_PHONE_Invalid := Base_Fields.InValid_EFX_PHONE((SALT37.StrType)le.EFX_PHONE);
    SELF.EFX_FAXPHONE_Invalid := Base_Fields.InValid_EFX_FAXPHONE((SALT37.StrType)le.EFX_FAXPHONE);
    SELF.EFX_YREST_Invalid := Base_Fields.InValid_EFX_YREST((SALT37.StrType)le.EFX_YREST);
    SELF.EFX_CORPEMPCNT_Invalid := Base_Fields.InValid_EFX_CORPEMPCNT((SALT37.StrType)le.EFX_CORPEMPCNT);
    SELF.EFX_LOCEMPCNT_Invalid := Base_Fields.InValid_EFX_LOCEMPCNT((SALT37.StrType)le.EFX_LOCEMPCNT);
    SELF.EFX_LOCEMPCD_Invalid := Base_Fields.InValid_EFX_LOCEMPCD((SALT37.StrType)le.EFX_LOCEMPCD);
    SELF.EFX_CORPAMOUNT_Invalid := Base_Fields.InValid_EFX_CORPAMOUNT((SALT37.StrType)le.EFX_CORPAMOUNT);
    SELF.EFX_LOCAMOUNT_Invalid := Base_Fields.InValid_EFX_LOCAMOUNT((SALT37.StrType)le.EFX_LOCAMOUNT);
    SELF.EFX_LOCAMOUNTCD_Invalid := Base_Fields.InValid_EFX_LOCAMOUNTCD((SALT37.StrType)le.EFX_LOCAMOUNTCD);
    SELF.EFX_LOCAMOUNTTP_Invalid := Base_Fields.InValid_EFX_LOCAMOUNTTP((SALT37.StrType)le.EFX_LOCAMOUNTTP);
    SELF.EFX_LOCAMOUNTPREC_Invalid := Base_Fields.InValid_EFX_LOCAMOUNTPREC((SALT37.StrType)le.EFX_LOCAMOUNTPREC);
    SELF.EFX_PRIMNAICSCODE_Invalid := Base_Fields.InValid_EFX_PRIMNAICSCODE((SALT37.StrType)le.EFX_PRIMNAICSCODE);
    SELF.EFX_SECNAICS1_Invalid := Base_Fields.InValid_EFX_SECNAICS1((SALT37.StrType)le.EFX_SECNAICS1);
    SELF.EFX_SECNAICS2_Invalid := Base_Fields.InValid_EFX_SECNAICS2((SALT37.StrType)le.EFX_SECNAICS2);
    SELF.EFX_SECNAICS3_Invalid := Base_Fields.InValid_EFX_SECNAICS3((SALT37.StrType)le.EFX_SECNAICS3);
    SELF.EFX_SECNAICS4_Invalid := Base_Fields.InValid_EFX_SECNAICS4((SALT37.StrType)le.EFX_SECNAICS4);
    SELF.EFX_DEAD_Invalid := Base_Fields.InValid_EFX_DEAD((SALT37.StrType)le.EFX_DEAD);
    SELF.EFX_DEADDT_Invalid := Base_Fields.InValid_EFX_DEADDT((SALT37.StrType)le.EFX_DEADDT);
    SELF.EFX_MRKT_TELEVER_Invalid := Base_Fields.InValid_EFX_MRKT_TELEVER((SALT37.StrType)le.EFX_MRKT_TELEVER);
    SELF.EFX_MRKT_VACANT_Invalid := Base_Fields.InValid_EFX_MRKT_VACANT((SALT37.StrType)le.EFX_MRKT_VACANT);
    SELF.EFX_MRKT_SEASONAL_Invalid := Base_Fields.InValid_EFX_MRKT_SEASONAL((SALT37.StrType)le.EFX_MRKT_SEASONAL);
    SELF.EFX_MBE_Invalid := Base_Fields.InValid_EFX_MBE((SALT37.StrType)le.EFX_MBE);
    SELF.EFX_WBE_Invalid := Base_Fields.InValid_EFX_WBE((SALT37.StrType)le.EFX_WBE);
    SELF.EFX_MWBE_Invalid := Base_Fields.InValid_EFX_MWBE((SALT37.StrType)le.EFX_MWBE);
    SELF.EFX_SDB_Invalid := Base_Fields.InValid_EFX_SDB((SALT37.StrType)le.EFX_SDB);
    SELF.EFX_HUBZONE_Invalid := Base_Fields.InValid_EFX_HUBZONE((SALT37.StrType)le.EFX_HUBZONE);
    SELF.EFX_DBE_Invalid := Base_Fields.InValid_EFX_DBE((SALT37.StrType)le.EFX_DBE);
    SELF.EFX_VET_Invalid := Base_Fields.InValid_EFX_VET((SALT37.StrType)le.EFX_VET);
    SELF.EFX_DVET_Invalid := Base_Fields.InValid_EFX_DVET((SALT37.StrType)le.EFX_DVET);
    SELF.EFX_8a_Invalid := Base_Fields.InValid_EFX_8a((SALT37.StrType)le.EFX_8a);
    SELF.EFX_8aEXPDT_Invalid := Base_Fields.InValid_EFX_8aEXPDT((SALT37.StrType)le.EFX_8aEXPDT);
    SELF.EFX_DIS_Invalid := Base_Fields.InValid_EFX_DIS((SALT37.StrType)le.EFX_DIS);
    SELF.EFX_SBE_Invalid := Base_Fields.InValid_EFX_SBE((SALT37.StrType)le.EFX_SBE);
    SELF.EFX_BUSSIZE_Invalid := Base_Fields.InValid_EFX_BUSSIZE((SALT37.StrType)le.EFX_BUSSIZE);
    SELF.EFX_LBE_Invalid := Base_Fields.InValid_EFX_LBE((SALT37.StrType)le.EFX_LBE);
    SELF.EFX_GOV_Invalid := Base_Fields.InValid_EFX_GOV((SALT37.StrType)le.EFX_GOV);
    SELF.EFX_FGOV_Invalid := Base_Fields.InValid_EFX_FGOV((SALT37.StrType)le.EFX_FGOV);
    SELF.EFX_NONPROFIT_Invalid := Base_Fields.InValid_EFX_NONPROFIT((SALT37.StrType)le.EFX_NONPROFIT);
    SELF.EFX_HBCU_Invalid := Base_Fields.InValid_EFX_HBCU((SALT37.StrType)le.EFX_HBCU);
    SELF.EFX_GAYLESBIAN_Invalid := Base_Fields.InValid_EFX_GAYLESBIAN((SALT37.StrType)le.EFX_GAYLESBIAN);
    SELF.EFX_WSBE_Invalid := Base_Fields.InValid_EFX_WSBE((SALT37.StrType)le.EFX_WSBE);
    SELF.EFX_VSBE_Invalid := Base_Fields.InValid_EFX_VSBE((SALT37.StrType)le.EFX_VSBE);
    SELF.EFX_DVSBE_Invalid := Base_Fields.InValid_EFX_DVSBE((SALT37.StrType)le.EFX_DVSBE);
    SELF.EFX_MWBESTATUS_Invalid := Base_Fields.InValid_EFX_MWBESTATUS((SALT37.StrType)le.EFX_MWBESTATUS);
    SELF.EFX_NMSDC_Invalid := Base_Fields.InValid_EFX_NMSDC((SALT37.StrType)le.EFX_NMSDC);
    SELF.EFX_WBENC_Invalid := Base_Fields.InValid_EFX_WBENC((SALT37.StrType)le.EFX_WBENC);
    SELF.EFX_CA_PUC_Invalid := Base_Fields.InValid_EFX_CA_PUC((SALT37.StrType)le.EFX_CA_PUC);
    SELF.EFX_TX_HUB_Invalid := Base_Fields.InValid_EFX_TX_HUB((SALT37.StrType)le.EFX_TX_HUB);
    SELF.EFX_GSAX_Invalid := Base_Fields.InValid_EFX_GSAX((SALT37.StrType)le.EFX_GSAX);
    SELF.EFX_CALTRANS_Invalid := Base_Fields.InValid_EFX_CALTRANS((SALT37.StrType)le.EFX_CALTRANS);
    SELF.EFX_EDU_Invalid := Base_Fields.InValid_EFX_EDU((SALT37.StrType)le.EFX_EDU);
    SELF.EFX_MI_Invalid := Base_Fields.InValid_EFX_MI((SALT37.StrType)le.EFX_MI);
    SELF.EFX_ANC_Invalid := Base_Fields.InValid_EFX_ANC((SALT37.StrType)le.EFX_ANC);
    SELF.AT_CERTLEV1_Invalid := Base_Fields.InValid_AT_CERTLEV1((SALT37.StrType)le.AT_CERTLEV1);
    SELF.AT_CERTLEV2_Invalid := Base_Fields.InValid_AT_CERTLEV2((SALT37.StrType)le.AT_CERTLEV2);
    SELF.AT_CERTLEV3_Invalid := Base_Fields.InValid_AT_CERTLEV3((SALT37.StrType)le.AT_CERTLEV3);
    SELF.AT_CERTLEV4_Invalid := Base_Fields.InValid_AT_CERTLEV4((SALT37.StrType)le.AT_CERTLEV4);
    SELF.AT_CERTLEV5_Invalid := Base_Fields.InValid_AT_CERTLEV5((SALT37.StrType)le.AT_CERTLEV5);
    SELF.AT_CERTLEV6_Invalid := Base_Fields.InValid_AT_CERTLEV6((SALT37.StrType)le.AT_CERTLEV6);
    SELF.AT_CERTLEV7_Invalid := Base_Fields.InValid_AT_CERTLEV7((SALT37.StrType)le.AT_CERTLEV7);
    SELF.AT_CERTLEV8_Invalid := Base_Fields.InValid_AT_CERTLEV8((SALT37.StrType)le.AT_CERTLEV8);
    SELF.AT_CERTLEV9_Invalid := Base_Fields.InValid_AT_CERTLEV9((SALT37.StrType)le.AT_CERTLEV9);
    SELF.AT_CERTLEV10_Invalid := Base_Fields.InValid_AT_CERTLEV10((SALT37.StrType)le.AT_CERTLEV10);
    SELF.AT_CERTEXP1_Invalid := Base_Fields.InValid_AT_CERTEXP1((SALT37.StrType)le.AT_CERTEXP1);
    SELF.AT_CERTEXP2_Invalid := Base_Fields.InValid_AT_CERTEXP2((SALT37.StrType)le.AT_CERTEXP2);
    SELF.AT_CERTEXP3_Invalid := Base_Fields.InValid_AT_CERTEXP3((SALT37.StrType)le.AT_CERTEXP3);
    SELF.AT_CERTEXP4_Invalid := Base_Fields.InValid_AT_CERTEXP4((SALT37.StrType)le.AT_CERTEXP4);
    SELF.AT_CERTEXP5_Invalid := Base_Fields.InValid_AT_CERTEXP5((SALT37.StrType)le.AT_CERTEXP5);
    SELF.AT_CERTEXP6_Invalid := Base_Fields.InValid_AT_CERTEXP6((SALT37.StrType)le.AT_CERTEXP6);
    SELF.AT_CERTEXP7_Invalid := Base_Fields.InValid_AT_CERTEXP7((SALT37.StrType)le.AT_CERTEXP7);
    SELF.AT_CERTEXP8_Invalid := Base_Fields.InValid_AT_CERTEXP8((SALT37.StrType)le.AT_CERTEXP8);
    SELF.AT_CERTEXP9_Invalid := Base_Fields.InValid_AT_CERTEXP9((SALT37.StrType)le.AT_CERTEXP9);
    SELF.AT_CERTEXP10_Invalid := Base_Fields.InValid_AT_CERTEXP10((SALT37.StrType)le.AT_CERTEXP10);
    SELF.EFX_EXTRACT_DATE_Invalid := Base_Fields.InValid_EFX_EXTRACT_DATE((SALT37.StrType)le.EFX_EXTRACT_DATE);
    SELF.EFX_MERCHANT_ID_Invalid := Base_Fields.InValid_EFX_MERCHANT_ID((SALT37.StrType)le.EFX_MERCHANT_ID);
    SELF.EFX_PROJECT_ID_Invalid := Base_Fields.InValid_EFX_PROJECT_ID((SALT37.StrType)le.EFX_PROJECT_ID);
    SELF.EFX_FOREIGN_Invalid := Base_Fields.InValid_EFX_FOREIGN((SALT37.StrType)le.EFX_FOREIGN);
    SELF.Record_Update_Refresh_Date_Invalid := Base_Fields.InValid_Record_Update_Refresh_Date((SALT37.StrType)le.Record_Update_Refresh_Date);
    SELF.EFX_DATE_CREATED_Invalid := Base_Fields.InValid_EFX_DATE_CREATED((SALT37.StrType)le.EFX_DATE_CREATED);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Equifax_Business_Data);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dotid_Invalid << 0 ) + ( le.dotscore_Invalid << 1 ) + ( le.dotweight_Invalid << 2 ) + ( le.empid_Invalid << 3 ) + ( le.empscore_Invalid << 4 ) + ( le.empweight_Invalid << 5 ) + ( le.powid_Invalid << 6 ) + ( le.powscore_Invalid << 7 ) + ( le.powweight_Invalid << 8 ) + ( le.proxid_Invalid << 9 ) + ( le.proxscore_Invalid << 10 ) + ( le.proxweight_Invalid << 11 ) + ( le.seleid_Invalid << 12 ) + ( le.selescore_Invalid << 13 ) + ( le.seleweight_Invalid << 14 ) + ( le.orgid_Invalid << 15 ) + ( le.orgscore_Invalid << 16 ) + ( le.orgweight_Invalid << 17 ) + ( le.ultid_Invalid << 18 ) + ( le.ultscore_Invalid << 19 ) + ( le.ultweight_Invalid << 20 ) + ( le.dt_first_seen_Invalid << 21 ) + ( le.dt_last_seen_Invalid << 22 ) + ( le.dt_vendor_first_reported_Invalid << 23 ) + ( le.dt_vendor_last_reported_Invalid << 24 ) + ( le.process_date_Invalid << 25 ) + ( le.record_type_Invalid << 26 ) + ( le.normcompany_type_Invalid << 27 ) + ( le.normaddress_type_Invalid << 28 ) + ( le.norm_state_Invalid << 29 ) + ( le.norm_zip_Invalid << 30 ) + ( le.norm_zip4_Invalid << 31 ) + ( le.EFX_NAME_Invalid << 32 ) + ( le.EFX_LEGAL_NAME_Invalid << 33 ) + ( le.EFX_ADDRESS_Invalid << 34 ) + ( le.clean_company_name_Invalid << 35 ) + ( le.clean_phone_Invalid << 36 ) + ( le.predir_Invalid << 37 ) + ( le.postdir_Invalid << 38 ) + ( le.st_Invalid << 39 ) + ( le.zip_Invalid << 40 ) + ( le.zip4_Invalid << 41 ) + ( le.cr_sort_sz_Invalid << 42 ) + ( le.lot_order_Invalid << 43 ) + ( le.rec_type_Invalid << 44 ) + ( le.fips_state_Invalid << 45 ) + ( le.geo_lat_Invalid << 46 ) + ( le.geo_long_Invalid << 47 ) + ( le.geo_match_Invalid << 48 ) + ( le.err_stat_Invalid << 49 ) + ( le.raw_aid_Invalid << 50 ) + ( le.ace_aid_Invalid << 51 ) + ( le.EFX_BUSSTATCD_Invalid << 52 ) + ( le.EFX_CMSA_Invalid << 53 ) + ( le.EFX_CORPAMOUNTCD_Invalid << 54 ) + ( le.EFX_CORPAMOUNTPREC_Invalid << 55 ) + ( le.EFX_CORPAMOUNTTP_Invalid << 56 ) + ( le.EFX_CORPEMPCD_Invalid << 57 ) + ( le.EFX_CTRYISOCD_Invalid << 58 ) + ( le.EFX_CTRYNUM_Invalid << 59 ) + ( le.EFX_CTRYTELCD_Invalid << 60 ) + ( le.EFX_GEOPREC_Invalid << 61 ) + ( le.EFX_MERCTYPE_Invalid << 62 ) + ( le.EFX_MRKT_TELESCORE_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.EFX_MRKT_TOTALIND_Invalid << 0 ) + ( le.EFX_MRKT_TOTALSCORE_Invalid << 1 ) + ( le.EFX_PUBLIC_Invalid << 2 ) + ( le.EFX_STKEXC_Invalid << 3 ) + ( le.EFX_PRIMSIC_Invalid << 4 ) + ( le.EFX_SECSIC1_Invalid << 5 ) + ( le.EFX_SECSIC2_Invalid << 6 ) + ( le.EFX_SECSIC3_Invalid << 7 ) + ( le.EFX_SECSIC4_Invalid << 8 ) + ( le.EFX_ID_Invalid << 9 ) + ( le.EFX_CITY_Invalid << 10 ) + ( le.EFX_CTRYNAME_Invalid << 11 ) + ( le.EFX_SOHO_Invalid << 12 ) + ( le.EFX_BIZ_Invalid << 13 ) + ( le.EFX_RES_Invalid << 14 ) + ( le.EFX_CMRA_Invalid << 15 ) + ( le.EFX_SECGEOPREC_Invalid << 16 ) + ( le.EFX_SECCTRYISOCD_Invalid << 17 ) + ( le.EFX_SECCTRYNUM_Invalid << 18 ) + ( le.EFX_PHONE_Invalid << 19 ) + ( le.EFX_FAXPHONE_Invalid << 20 ) + ( le.EFX_YREST_Invalid << 21 ) + ( le.EFX_CORPEMPCNT_Invalid << 22 ) + ( le.EFX_LOCEMPCNT_Invalid << 23 ) + ( le.EFX_LOCEMPCD_Invalid << 24 ) + ( le.EFX_CORPAMOUNT_Invalid << 25 ) + ( le.EFX_LOCAMOUNT_Invalid << 26 ) + ( le.EFX_LOCAMOUNTCD_Invalid << 27 ) + ( le.EFX_LOCAMOUNTTP_Invalid << 28 ) + ( le.EFX_LOCAMOUNTPREC_Invalid << 29 ) + ( le.EFX_PRIMNAICSCODE_Invalid << 30 ) + ( le.EFX_SECNAICS1_Invalid << 31 ) + ( le.EFX_SECNAICS2_Invalid << 32 ) + ( le.EFX_SECNAICS3_Invalid << 33 ) + ( le.EFX_SECNAICS4_Invalid << 34 ) + ( le.EFX_DEAD_Invalid << 35 ) + ( le.EFX_DEADDT_Invalid << 36 ) + ( le.EFX_MRKT_TELEVER_Invalid << 37 ) + ( le.EFX_MRKT_VACANT_Invalid << 38 ) + ( le.EFX_MRKT_SEASONAL_Invalid << 39 ) + ( le.EFX_MBE_Invalid << 40 ) + ( le.EFX_WBE_Invalid << 41 ) + ( le.EFX_MWBE_Invalid << 42 ) + ( le.EFX_SDB_Invalid << 43 ) + ( le.EFX_HUBZONE_Invalid << 44 ) + ( le.EFX_DBE_Invalid << 45 ) + ( le.EFX_VET_Invalid << 46 ) + ( le.EFX_DVET_Invalid << 47 ) + ( le.EFX_8a_Invalid << 48 ) + ( le.EFX_8aEXPDT_Invalid << 49 ) + ( le.EFX_DIS_Invalid << 50 ) + ( le.EFX_SBE_Invalid << 51 ) + ( le.EFX_BUSSIZE_Invalid << 52 ) + ( le.EFX_LBE_Invalid << 53 ) + ( le.EFX_GOV_Invalid << 54 ) + ( le.EFX_FGOV_Invalid << 55 ) + ( le.EFX_NONPROFIT_Invalid << 56 ) + ( le.EFX_HBCU_Invalid << 57 ) + ( le.EFX_GAYLESBIAN_Invalid << 58 ) + ( le.EFX_WSBE_Invalid << 59 ) + ( le.EFX_VSBE_Invalid << 60 ) + ( le.EFX_DVSBE_Invalid << 61 ) + ( le.EFX_MWBESTATUS_Invalid << 62 ) + ( le.EFX_NMSDC_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.EFX_WBENC_Invalid << 0 ) + ( le.EFX_CA_PUC_Invalid << 1 ) + ( le.EFX_TX_HUB_Invalid << 2 ) + ( le.EFX_GSAX_Invalid << 3 ) + ( le.EFX_CALTRANS_Invalid << 4 ) + ( le.EFX_EDU_Invalid << 5 ) + ( le.EFX_MI_Invalid << 6 ) + ( le.EFX_ANC_Invalid << 7 ) + ( le.AT_CERTLEV1_Invalid << 8 ) + ( le.AT_CERTLEV2_Invalid << 9 ) + ( le.AT_CERTLEV3_Invalid << 10 ) + ( le.AT_CERTLEV4_Invalid << 11 ) + ( le.AT_CERTLEV5_Invalid << 12 ) + ( le.AT_CERTLEV6_Invalid << 13 ) + ( le.AT_CERTLEV7_Invalid << 14 ) + ( le.AT_CERTLEV8_Invalid << 15 ) + ( le.AT_CERTLEV9_Invalid << 16 ) + ( le.AT_CERTLEV10_Invalid << 17 ) + ( le.AT_CERTEXP1_Invalid << 18 ) + ( le.AT_CERTEXP2_Invalid << 19 ) + ( le.AT_CERTEXP3_Invalid << 20 ) + ( le.AT_CERTEXP4_Invalid << 21 ) + ( le.AT_CERTEXP5_Invalid << 22 ) + ( le.AT_CERTEXP6_Invalid << 23 ) + ( le.AT_CERTEXP7_Invalid << 24 ) + ( le.AT_CERTEXP8_Invalid << 25 ) + ( le.AT_CERTEXP9_Invalid << 26 ) + ( le.AT_CERTEXP10_Invalid << 27 ) + ( le.EFX_EXTRACT_DATE_Invalid << 28 ) + ( le.EFX_MERCHANT_ID_Invalid << 29 ) + ( le.EFX_PROJECT_ID_Invalid << 30 ) + ( le.EFX_FOREIGN_Invalid << 31 ) + ( le.Record_Update_Refresh_Date_Invalid << 32 ) + ( le.EFX_DATE_CREATED_Invalid << 33 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Equifax_Business_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.normcompany_type_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.normaddress_type_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.norm_state_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.norm_zip_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.norm_zip4_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.EFX_NAME_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.EFX_LEGAL_NAME_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.EFX_ADDRESS_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.clean_company_name_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.raw_aid_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.ace_aid_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.EFX_BUSSTATCD_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.EFX_CMSA_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.EFX_CORPAMOUNTCD_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.EFX_CORPAMOUNTPREC_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.EFX_CORPAMOUNTTP_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.EFX_CORPEMPCD_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.EFX_CTRYISOCD_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.EFX_CTRYNUM_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.EFX_CTRYTELCD_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.EFX_GEOPREC_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.EFX_MERCTYPE_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.EFX_MRKT_TELESCORE_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.EFX_MRKT_TOTALIND_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.EFX_MRKT_TOTALSCORE_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.EFX_PUBLIC_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.EFX_STKEXC_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.EFX_PRIMSIC_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.EFX_SECSIC1_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.EFX_SECSIC2_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.EFX_SECSIC3_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.EFX_SECSIC4_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.EFX_ID_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.EFX_CITY_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.EFX_CTRYNAME_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.EFX_SOHO_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.EFX_BIZ_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.EFX_RES_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.EFX_CMRA_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.EFX_SECGEOPREC_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.EFX_SECCTRYISOCD_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.EFX_SECCTRYNUM_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.EFX_PHONE_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.EFX_FAXPHONE_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.EFX_YREST_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.EFX_CORPEMPCNT_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.EFX_LOCEMPCNT_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.EFX_LOCEMPCD_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.EFX_CORPAMOUNT_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.EFX_LOCAMOUNT_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.EFX_LOCAMOUNTCD_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.EFX_LOCAMOUNTTP_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.EFX_LOCAMOUNTPREC_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.EFX_PRIMNAICSCODE_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.EFX_SECNAICS1_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.EFX_SECNAICS2_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.EFX_SECNAICS3_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.EFX_SECNAICS4_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.EFX_DEAD_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.EFX_DEADDT_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.EFX_MRKT_TELEVER_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.EFX_MRKT_VACANT_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.EFX_MRKT_SEASONAL_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.EFX_MBE_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.EFX_WBE_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.EFX_MWBE_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.EFX_SDB_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.EFX_HUBZONE_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.EFX_DBE_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.EFX_VET_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.EFX_DVET_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.EFX_8a_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.EFX_8aEXPDT_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.EFX_DIS_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.EFX_SBE_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.EFX_BUSSIZE_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.EFX_LBE_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.EFX_GOV_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.EFX_FGOV_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.EFX_NONPROFIT_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.EFX_HBCU_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.EFX_GAYLESBIAN_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.EFX_WSBE_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.EFX_VSBE_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.EFX_DVSBE_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.EFX_MWBESTATUS_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.EFX_NMSDC_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.EFX_WBENC_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.EFX_CA_PUC_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.EFX_TX_HUB_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.EFX_GSAX_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.EFX_CALTRANS_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.EFX_EDU_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.EFX_MI_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.EFX_ANC_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.AT_CERTLEV1_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.AT_CERTLEV2_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.AT_CERTLEV3_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.AT_CERTLEV4_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.AT_CERTLEV5_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.AT_CERTLEV6_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.AT_CERTLEV7_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.AT_CERTLEV8_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.AT_CERTLEV9_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.AT_CERTLEV10_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.AT_CERTEXP1_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.AT_CERTEXP2_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.AT_CERTEXP3_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.AT_CERTEXP4_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.AT_CERTEXP5_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.AT_CERTEXP6_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.AT_CERTEXP7_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.AT_CERTEXP8_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.AT_CERTEXP9_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.AT_CERTEXP10_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.EFX_EXTRACT_DATE_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.EFX_MERCHANT_ID_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.EFX_PROJECT_ID_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.EFX_FOREIGN_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.Record_Update_Refresh_Date_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.EFX_DATE_CREATED_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dotid_ENUM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ENUM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ENUM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ENUM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ENUM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ENUM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_CUSTOM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_CUSTOM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_CUSTOM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_CUSTOM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_CUSTOM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_CUSTOM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_CUSTOM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_CUSTOM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_CUSTOM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_CUSTOM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    normcompany_type_ENUM_ErrorCount := COUNT(GROUP,h.normcompany_type_Invalid=1);
    normaddress_type_ENUM_ErrorCount := COUNT(GROUP,h.normaddress_type_Invalid=1);
    norm_state_CUSTOM_ErrorCount := COUNT(GROUP,h.norm_state_Invalid=1);
    norm_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.norm_zip_Invalid=1);
    norm_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.norm_zip4_Invalid=1);
    EFX_NAME_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_NAME_Invalid=1);
    EFX_LEGAL_NAME_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LEGAL_NAME_Invalid=1);
    EFX_ADDRESS_LENGTH_ErrorCount := COUNT(GROUP,h.EFX_ADDRESS_Invalid=1);
    clean_company_name_LENGTH_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=1);
    clean_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    predir_ENUM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    postdir_ENUM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    raw_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.raw_aid_Invalid=1);
    ace_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_aid_Invalid=1);
    EFX_BUSSTATCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_BUSSTATCD_Invalid=1);
    EFX_CMSA_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CMSA_Invalid=1);
    EFX_CORPAMOUNTCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPAMOUNTCD_Invalid=1);
    EFX_CORPAMOUNTPREC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPAMOUNTPREC_Invalid=1);
    EFX_CORPAMOUNTTP_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPAMOUNTTP_Invalid=1);
    EFX_CORPEMPCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPEMPCD_Invalid=1);
    EFX_CTRYISOCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CTRYISOCD_Invalid=1);
    EFX_CTRYNUM_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CTRYNUM_Invalid=1);
    EFX_CTRYTELCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CTRYTELCD_Invalid=1);
    EFX_GEOPREC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_GEOPREC_Invalid=1);
    EFX_MERCTYPE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_MERCTYPE_Invalid=1);
    EFX_MRKT_TELESCORE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_TELESCORE_Invalid=1);
    EFX_MRKT_TOTALIND_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_TOTALIND_Invalid=1);
    EFX_MRKT_TOTALSCORE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_TOTALSCORE_Invalid=1);
    EFX_PUBLIC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_PUBLIC_Invalid=1);
    EFX_STKEXC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_STKEXC_Invalid=1);
    EFX_PRIMSIC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_PRIMSIC_Invalid=1);
    EFX_SECSIC1_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECSIC1_Invalid=1);
    EFX_SECSIC2_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECSIC2_Invalid=1);
    EFX_SECSIC3_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECSIC3_Invalid=1);
    EFX_SECSIC4_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECSIC4_Invalid=1);
    EFX_ID_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_ID_Invalid=1);
    EFX_CITY_LENGTH_ErrorCount := COUNT(GROUP,h.EFX_CITY_Invalid=1);
    EFX_CTRYNAME_LENGTH_ErrorCount := COUNT(GROUP,h.EFX_CTRYNAME_Invalid=1);
    EFX_SOHO_ENUM_ErrorCount := COUNT(GROUP,h.EFX_SOHO_Invalid=1);
    EFX_BIZ_ENUM_ErrorCount := COUNT(GROUP,h.EFX_BIZ_Invalid=1);
    EFX_RES_ENUM_ErrorCount := COUNT(GROUP,h.EFX_RES_Invalid=1);
    EFX_CMRA_ENUM_ErrorCount := COUNT(GROUP,h.EFX_CMRA_Invalid=1);
    EFX_SECGEOPREC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECGEOPREC_Invalid=1);
    EFX_SECCTRYISOCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECCTRYISOCD_Invalid=1);
    EFX_SECCTRYNUM_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECCTRYNUM_Invalid=1);
    EFX_PHONE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_PHONE_Invalid=1);
    EFX_FAXPHONE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_FAXPHONE_Invalid=1);
    EFX_YREST_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_YREST_Invalid=1);
    EFX_CORPEMPCNT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPEMPCNT_Invalid=1);
    EFX_LOCEMPCNT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCEMPCNT_Invalid=1);
    EFX_LOCEMPCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCEMPCD_Invalid=1);
    EFX_CORPAMOUNT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_CORPAMOUNT_Invalid=1);
    EFX_LOCAMOUNT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCAMOUNT_Invalid=1);
    EFX_LOCAMOUNTCD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCAMOUNTCD_Invalid=1);
    EFX_LOCAMOUNTTP_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCAMOUNTTP_Invalid=1);
    EFX_LOCAMOUNTPREC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_LOCAMOUNTPREC_Invalid=1);
    EFX_PRIMNAICSCODE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_PRIMNAICSCODE_Invalid=1);
    EFX_SECNAICS1_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECNAICS1_Invalid=1);
    EFX_SECNAICS2_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECNAICS2_Invalid=1);
    EFX_SECNAICS3_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECNAICS3_Invalid=1);
    EFX_SECNAICS4_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_SECNAICS4_Invalid=1);
    EFX_DEAD_ENUM_ErrorCount := COUNT(GROUP,h.EFX_DEAD_Invalid=1);
    EFX_DEADDT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_DEADDT_Invalid=1);
    EFX_MRKT_TELEVER_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_TELEVER_Invalid=1);
    EFX_MRKT_VACANT_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_VACANT_Invalid=1);
    EFX_MRKT_SEASONAL_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MRKT_SEASONAL_Invalid=1);
    EFX_MBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MBE_Invalid=1);
    EFX_WBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_WBE_Invalid=1);
    EFX_MWBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MWBE_Invalid=1);
    EFX_SDB_ENUM_ErrorCount := COUNT(GROUP,h.EFX_SDB_Invalid=1);
    EFX_HUBZONE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_HUBZONE_Invalid=1);
    EFX_DBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_DBE_Invalid=1);
    EFX_VET_ENUM_ErrorCount := COUNT(GROUP,h.EFX_VET_Invalid=1);
    EFX_DVET_ENUM_ErrorCount := COUNT(GROUP,h.EFX_DVET_Invalid=1);
    EFX_8a_ENUM_ErrorCount := COUNT(GROUP,h.EFX_8a_Invalid=1);
    EFX_8aEXPDT_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_8aEXPDT_Invalid=1);
    EFX_DIS_ENUM_ErrorCount := COUNT(GROUP,h.EFX_DIS_Invalid=1);
    EFX_SBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_SBE_Invalid=1);
    EFX_BUSSIZE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_BUSSIZE_Invalid=1);
    EFX_LBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_LBE_Invalid=1);
    EFX_GOV_ENUM_ErrorCount := COUNT(GROUP,h.EFX_GOV_Invalid=1);
    EFX_FGOV_ENUM_ErrorCount := COUNT(GROUP,h.EFX_FGOV_Invalid=1);
    EFX_NONPROFIT_ENUM_ErrorCount := COUNT(GROUP,h.EFX_NONPROFIT_Invalid=1);
    EFX_HBCU_ENUM_ErrorCount := COUNT(GROUP,h.EFX_HBCU_Invalid=1);
    EFX_GAYLESBIAN_ENUM_ErrorCount := COUNT(GROUP,h.EFX_GAYLESBIAN_Invalid=1);
    EFX_WSBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_WSBE_Invalid=1);
    EFX_VSBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_VSBE_Invalid=1);
    EFX_DVSBE_ENUM_ErrorCount := COUNT(GROUP,h.EFX_DVSBE_Invalid=1);
    EFX_MWBESTATUS_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MWBESTATUS_Invalid=1);
    EFX_NMSDC_ENUM_ErrorCount := COUNT(GROUP,h.EFX_NMSDC_Invalid=1);
    EFX_WBENC_ENUM_ErrorCount := COUNT(GROUP,h.EFX_WBENC_Invalid=1);
    EFX_CA_PUC_ENUM_ErrorCount := COUNT(GROUP,h.EFX_CA_PUC_Invalid=1);
    EFX_TX_HUB_ENUM_ErrorCount := COUNT(GROUP,h.EFX_TX_HUB_Invalid=1);
    EFX_GSAX_ENUM_ErrorCount := COUNT(GROUP,h.EFX_GSAX_Invalid=1);
    EFX_CALTRANS_ENUM_ErrorCount := COUNT(GROUP,h.EFX_CALTRANS_Invalid=1);
    EFX_EDU_ENUM_ErrorCount := COUNT(GROUP,h.EFX_EDU_Invalid=1);
    EFX_MI_ENUM_ErrorCount := COUNT(GROUP,h.EFX_MI_Invalid=1);
    EFX_ANC_ENUM_ErrorCount := COUNT(GROUP,h.EFX_ANC_Invalid=1);
    AT_CERTLEV1_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV1_Invalid=1);
    AT_CERTLEV2_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV2_Invalid=1);
    AT_CERTLEV3_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV3_Invalid=1);
    AT_CERTLEV4_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV4_Invalid=1);
    AT_CERTLEV5_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV5_Invalid=1);
    AT_CERTLEV6_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV6_Invalid=1);
    AT_CERTLEV7_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV7_Invalid=1);
    AT_CERTLEV8_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV8_Invalid=1);
    AT_CERTLEV9_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV9_Invalid=1);
    AT_CERTLEV10_ENUM_ErrorCount := COUNT(GROUP,h.AT_CERTLEV10_Invalid=1);
    AT_CERTEXP1_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP1_Invalid=1);
    AT_CERTEXP2_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP2_Invalid=1);
    AT_CERTEXP3_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP3_Invalid=1);
    AT_CERTEXP4_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP4_Invalid=1);
    AT_CERTEXP5_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP5_Invalid=1);
    AT_CERTEXP6_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP6_Invalid=1);
    AT_CERTEXP7_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP7_Invalid=1);
    AT_CERTEXP8_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP8_Invalid=1);
    AT_CERTEXP9_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP9_Invalid=1);
    AT_CERTEXP10_CUSTOM_ErrorCount := COUNT(GROUP,h.AT_CERTEXP10_Invalid=1);
    EFX_EXTRACT_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_EXTRACT_DATE_Invalid=1);
    EFX_MERCHANT_ID_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_MERCHANT_ID_Invalid=1);
    EFX_PROJECT_ID_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_PROJECT_ID_Invalid=1);
    EFX_FOREIGN_ENUM_ErrorCount := COUNT(GROUP,h.EFX_FOREIGN_Invalid=1);
    Record_Update_Refresh_Date_CUSTOM_ErrorCount := COUNT(GROUP,h.Record_Update_Refresh_Date_Invalid=1);
    EFX_DATE_CREATED_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_DATE_CREATED_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.normcompany_type_Invalid,le.normaddress_type_Invalid,le.norm_state_Invalid,le.norm_zip_Invalid,le.norm_zip4_Invalid,le.EFX_NAME_Invalid,le.EFX_LEGAL_NAME_Invalid,le.EFX_ADDRESS_Invalid,le.clean_company_name_Invalid,le.clean_phone_Invalid,le.predir_Invalid,le.postdir_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cr_sort_sz_Invalid,le.lot_order_Invalid,le.rec_type_Invalid,le.fips_state_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.raw_aid_Invalid,le.ace_aid_Invalid,le.EFX_BUSSTATCD_Invalid,le.EFX_CMSA_Invalid,le.EFX_CORPAMOUNTCD_Invalid,le.EFX_CORPAMOUNTPREC_Invalid,le.EFX_CORPAMOUNTTP_Invalid,le.EFX_CORPEMPCD_Invalid,le.EFX_CTRYISOCD_Invalid,le.EFX_CTRYNUM_Invalid,le.EFX_CTRYTELCD_Invalid,le.EFX_GEOPREC_Invalid,le.EFX_MERCTYPE_Invalid,le.EFX_MRKT_TELESCORE_Invalid,le.EFX_MRKT_TOTALIND_Invalid,le.EFX_MRKT_TOTALSCORE_Invalid,le.EFX_PUBLIC_Invalid,le.EFX_STKEXC_Invalid,le.EFX_PRIMSIC_Invalid,le.EFX_SECSIC1_Invalid,le.EFX_SECSIC2_Invalid,le.EFX_SECSIC3_Invalid,le.EFX_SECSIC4_Invalid,le.EFX_ID_Invalid,le.EFX_CITY_Invalid,le.EFX_CTRYNAME_Invalid,le.EFX_SOHO_Invalid,le.EFX_BIZ_Invalid,le.EFX_RES_Invalid,le.EFX_CMRA_Invalid,le.EFX_SECGEOPREC_Invalid,le.EFX_SECCTRYISOCD_Invalid,le.EFX_SECCTRYNUM_Invalid,le.EFX_PHONE_Invalid,le.EFX_FAXPHONE_Invalid,le.EFX_YREST_Invalid,le.EFX_CORPEMPCNT_Invalid,le.EFX_LOCEMPCNT_Invalid,le.EFX_LOCEMPCD_Invalid,le.EFX_CORPAMOUNT_Invalid,le.EFX_LOCAMOUNT_Invalid,le.EFX_LOCAMOUNTCD_Invalid,le.EFX_LOCAMOUNTTP_Invalid,le.EFX_LOCAMOUNTPREC_Invalid,le.EFX_PRIMNAICSCODE_Invalid,le.EFX_SECNAICS1_Invalid,le.EFX_SECNAICS2_Invalid,le.EFX_SECNAICS3_Invalid,le.EFX_SECNAICS4_Invalid,le.EFX_DEAD_Invalid,le.EFX_DEADDT_Invalid,le.EFX_MRKT_TELEVER_Invalid,le.EFX_MRKT_VACANT_Invalid,le.EFX_MRKT_SEASONAL_Invalid,le.EFX_MBE_Invalid,le.EFX_WBE_Invalid,le.EFX_MWBE_Invalid,le.EFX_SDB_Invalid,le.EFX_HUBZONE_Invalid,le.EFX_DBE_Invalid,le.EFX_VET_Invalid,le.EFX_DVET_Invalid,le.EFX_8a_Invalid,le.EFX_8aEXPDT_Invalid,le.EFX_DIS_Invalid,le.EFX_SBE_Invalid,le.EFX_BUSSIZE_Invalid,le.EFX_LBE_Invalid,le.EFX_GOV_Invalid,le.EFX_FGOV_Invalid,le.EFX_NONPROFIT_Invalid,le.EFX_HBCU_Invalid,le.EFX_GAYLESBIAN_Invalid,le.EFX_WSBE_Invalid,le.EFX_VSBE_Invalid,le.EFX_DVSBE_Invalid,le.EFX_MWBESTATUS_Invalid,le.EFX_NMSDC_Invalid,le.EFX_WBENC_Invalid,le.EFX_CA_PUC_Invalid,le.EFX_TX_HUB_Invalid,le.EFX_GSAX_Invalid,le.EFX_CALTRANS_Invalid,le.EFX_EDU_Invalid,le.EFX_MI_Invalid,le.EFX_ANC_Invalid,le.AT_CERTLEV1_Invalid,le.AT_CERTLEV2_Invalid,le.AT_CERTLEV3_Invalid,le.AT_CERTLEV4_Invalid,le.AT_CERTLEV5_Invalid,le.AT_CERTLEV6_Invalid,le.AT_CERTLEV7_Invalid,le.AT_CERTLEV8_Invalid,le.AT_CERTLEV9_Invalid,le.AT_CERTLEV10_Invalid,le.AT_CERTEXP1_Invalid,le.AT_CERTEXP2_Invalid,le.AT_CERTEXP3_Invalid,le.AT_CERTEXP4_Invalid,le.AT_CERTEXP5_Invalid,le.AT_CERTEXP6_Invalid,le.AT_CERTEXP7_Invalid,le.AT_CERTEXP8_Invalid,le.AT_CERTEXP9_Invalid,le.AT_CERTEXP10_Invalid,le.EFX_EXTRACT_DATE_Invalid,le.EFX_MERCHANT_ID_Invalid,le.EFX_PROJECT_ID_Invalid,le.EFX_FOREIGN_Invalid,le.Record_Update_Refresh_Date_Invalid,le.EFX_DATE_CREATED_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_dotid(le.dotid_Invalid),Base_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Base_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Base_Fields.InvalidMessage_empid(le.empid_Invalid),Base_Fields.InvalidMessage_empscore(le.empscore_Invalid),Base_Fields.InvalidMessage_empweight(le.empweight_Invalid),Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_powscore(le.powscore_Invalid),Base_Fields.InvalidMessage_powweight(le.powweight_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Base_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_selescore(le.selescore_Invalid),Base_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Base_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Base_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_normcompany_type(le.normcompany_type_Invalid),Base_Fields.InvalidMessage_normaddress_type(le.normaddress_type_Invalid),Base_Fields.InvalidMessage_norm_state(le.norm_state_Invalid),Base_Fields.InvalidMessage_norm_zip(le.norm_zip_Invalid),Base_Fields.InvalidMessage_norm_zip4(le.norm_zip4_Invalid),Base_Fields.InvalidMessage_EFX_NAME(le.EFX_NAME_Invalid),Base_Fields.InvalidMessage_EFX_LEGAL_NAME(le.EFX_LEGAL_NAME_Invalid),Base_Fields.InvalidMessage_EFX_ADDRESS(le.EFX_ADDRESS_Invalid),Base_Fields.InvalidMessage_clean_company_name(le.clean_company_name_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Base_Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Fields.InvalidMessage_raw_aid(le.raw_aid_Invalid),Base_Fields.InvalidMessage_ace_aid(le.ace_aid_Invalid),Base_Fields.InvalidMessage_EFX_BUSSTATCD(le.EFX_BUSSTATCD_Invalid),Base_Fields.InvalidMessage_EFX_CMSA(le.EFX_CMSA_Invalid),Base_Fields.InvalidMessage_EFX_CORPAMOUNTCD(le.EFX_CORPAMOUNTCD_Invalid),Base_Fields.InvalidMessage_EFX_CORPAMOUNTPREC(le.EFX_CORPAMOUNTPREC_Invalid),Base_Fields.InvalidMessage_EFX_CORPAMOUNTTP(le.EFX_CORPAMOUNTTP_Invalid),Base_Fields.InvalidMessage_EFX_CORPEMPCD(le.EFX_CORPEMPCD_Invalid),Base_Fields.InvalidMessage_EFX_CTRYISOCD(le.EFX_CTRYISOCD_Invalid),Base_Fields.InvalidMessage_EFX_CTRYNUM(le.EFX_CTRYNUM_Invalid),Base_Fields.InvalidMessage_EFX_CTRYTELCD(le.EFX_CTRYTELCD_Invalid),Base_Fields.InvalidMessage_EFX_GEOPREC(le.EFX_GEOPREC_Invalid),Base_Fields.InvalidMessage_EFX_MERCTYPE(le.EFX_MERCTYPE_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_TELESCORE(le.EFX_MRKT_TELESCORE_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_TOTALIND(le.EFX_MRKT_TOTALIND_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_TOTALSCORE(le.EFX_MRKT_TOTALSCORE_Invalid),Base_Fields.InvalidMessage_EFX_PUBLIC(le.EFX_PUBLIC_Invalid),Base_Fields.InvalidMessage_EFX_STKEXC(le.EFX_STKEXC_Invalid),Base_Fields.InvalidMessage_EFX_PRIMSIC(le.EFX_PRIMSIC_Invalid),Base_Fields.InvalidMessage_EFX_SECSIC1(le.EFX_SECSIC1_Invalid),Base_Fields.InvalidMessage_EFX_SECSIC2(le.EFX_SECSIC2_Invalid),Base_Fields.InvalidMessage_EFX_SECSIC3(le.EFX_SECSIC3_Invalid),Base_Fields.InvalidMessage_EFX_SECSIC4(le.EFX_SECSIC4_Invalid),Base_Fields.InvalidMessage_EFX_ID(le.EFX_ID_Invalid),Base_Fields.InvalidMessage_EFX_CITY(le.EFX_CITY_Invalid),Base_Fields.InvalidMessage_EFX_CTRYNAME(le.EFX_CTRYNAME_Invalid),Base_Fields.InvalidMessage_EFX_SOHO(le.EFX_SOHO_Invalid),Base_Fields.InvalidMessage_EFX_BIZ(le.EFX_BIZ_Invalid),Base_Fields.InvalidMessage_EFX_RES(le.EFX_RES_Invalid),Base_Fields.InvalidMessage_EFX_CMRA(le.EFX_CMRA_Invalid),Base_Fields.InvalidMessage_EFX_SECGEOPREC(le.EFX_SECGEOPREC_Invalid),Base_Fields.InvalidMessage_EFX_SECCTRYISOCD(le.EFX_SECCTRYISOCD_Invalid),Base_Fields.InvalidMessage_EFX_SECCTRYNUM(le.EFX_SECCTRYNUM_Invalid),Base_Fields.InvalidMessage_EFX_PHONE(le.EFX_PHONE_Invalid),Base_Fields.InvalidMessage_EFX_FAXPHONE(le.EFX_FAXPHONE_Invalid),Base_Fields.InvalidMessage_EFX_YREST(le.EFX_YREST_Invalid),Base_Fields.InvalidMessage_EFX_CORPEMPCNT(le.EFX_CORPEMPCNT_Invalid),Base_Fields.InvalidMessage_EFX_LOCEMPCNT(le.EFX_LOCEMPCNT_Invalid),Base_Fields.InvalidMessage_EFX_LOCEMPCD(le.EFX_LOCEMPCD_Invalid),Base_Fields.InvalidMessage_EFX_CORPAMOUNT(le.EFX_CORPAMOUNT_Invalid),Base_Fields.InvalidMessage_EFX_LOCAMOUNT(le.EFX_LOCAMOUNT_Invalid),Base_Fields.InvalidMessage_EFX_LOCAMOUNTCD(le.EFX_LOCAMOUNTCD_Invalid),Base_Fields.InvalidMessage_EFX_LOCAMOUNTTP(le.EFX_LOCAMOUNTTP_Invalid),Base_Fields.InvalidMessage_EFX_LOCAMOUNTPREC(le.EFX_LOCAMOUNTPREC_Invalid),Base_Fields.InvalidMessage_EFX_PRIMNAICSCODE(le.EFX_PRIMNAICSCODE_Invalid),Base_Fields.InvalidMessage_EFX_SECNAICS1(le.EFX_SECNAICS1_Invalid),Base_Fields.InvalidMessage_EFX_SECNAICS2(le.EFX_SECNAICS2_Invalid),Base_Fields.InvalidMessage_EFX_SECNAICS3(le.EFX_SECNAICS3_Invalid),Base_Fields.InvalidMessage_EFX_SECNAICS4(le.EFX_SECNAICS4_Invalid),Base_Fields.InvalidMessage_EFX_DEAD(le.EFX_DEAD_Invalid),Base_Fields.InvalidMessage_EFX_DEADDT(le.EFX_DEADDT_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_TELEVER(le.EFX_MRKT_TELEVER_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_VACANT(le.EFX_MRKT_VACANT_Invalid),Base_Fields.InvalidMessage_EFX_MRKT_SEASONAL(le.EFX_MRKT_SEASONAL_Invalid),Base_Fields.InvalidMessage_EFX_MBE(le.EFX_MBE_Invalid),Base_Fields.InvalidMessage_EFX_WBE(le.EFX_WBE_Invalid),Base_Fields.InvalidMessage_EFX_MWBE(le.EFX_MWBE_Invalid),Base_Fields.InvalidMessage_EFX_SDB(le.EFX_SDB_Invalid),Base_Fields.InvalidMessage_EFX_HUBZONE(le.EFX_HUBZONE_Invalid),Base_Fields.InvalidMessage_EFX_DBE(le.EFX_DBE_Invalid),Base_Fields.InvalidMessage_EFX_VET(le.EFX_VET_Invalid),Base_Fields.InvalidMessage_EFX_DVET(le.EFX_DVET_Invalid),Base_Fields.InvalidMessage_EFX_8a(le.EFX_8a_Invalid),Base_Fields.InvalidMessage_EFX_8aEXPDT(le.EFX_8aEXPDT_Invalid),Base_Fields.InvalidMessage_EFX_DIS(le.EFX_DIS_Invalid),Base_Fields.InvalidMessage_EFX_SBE(le.EFX_SBE_Invalid),Base_Fields.InvalidMessage_EFX_BUSSIZE(le.EFX_BUSSIZE_Invalid),Base_Fields.InvalidMessage_EFX_LBE(le.EFX_LBE_Invalid),Base_Fields.InvalidMessage_EFX_GOV(le.EFX_GOV_Invalid),Base_Fields.InvalidMessage_EFX_FGOV(le.EFX_FGOV_Invalid),Base_Fields.InvalidMessage_EFX_NONPROFIT(le.EFX_NONPROFIT_Invalid),Base_Fields.InvalidMessage_EFX_HBCU(le.EFX_HBCU_Invalid),Base_Fields.InvalidMessage_EFX_GAYLESBIAN(le.EFX_GAYLESBIAN_Invalid),Base_Fields.InvalidMessage_EFX_WSBE(le.EFX_WSBE_Invalid),Base_Fields.InvalidMessage_EFX_VSBE(le.EFX_VSBE_Invalid),Base_Fields.InvalidMessage_EFX_DVSBE(le.EFX_DVSBE_Invalid),Base_Fields.InvalidMessage_EFX_MWBESTATUS(le.EFX_MWBESTATUS_Invalid),Base_Fields.InvalidMessage_EFX_NMSDC(le.EFX_NMSDC_Invalid),Base_Fields.InvalidMessage_EFX_WBENC(le.EFX_WBENC_Invalid),Base_Fields.InvalidMessage_EFX_CA_PUC(le.EFX_CA_PUC_Invalid),Base_Fields.InvalidMessage_EFX_TX_HUB(le.EFX_TX_HUB_Invalid),Base_Fields.InvalidMessage_EFX_GSAX(le.EFX_GSAX_Invalid),Base_Fields.InvalidMessage_EFX_CALTRANS(le.EFX_CALTRANS_Invalid),Base_Fields.InvalidMessage_EFX_EDU(le.EFX_EDU_Invalid),Base_Fields.InvalidMessage_EFX_MI(le.EFX_MI_Invalid),Base_Fields.InvalidMessage_EFX_ANC(le.EFX_ANC_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV1(le.AT_CERTLEV1_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV2(le.AT_CERTLEV2_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV3(le.AT_CERTLEV3_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV4(le.AT_CERTLEV4_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV5(le.AT_CERTLEV5_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV6(le.AT_CERTLEV6_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV7(le.AT_CERTLEV7_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV8(le.AT_CERTLEV8_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV9(le.AT_CERTLEV9_Invalid),Base_Fields.InvalidMessage_AT_CERTLEV10(le.AT_CERTLEV10_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP1(le.AT_CERTEXP1_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP2(le.AT_CERTEXP2_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP3(le.AT_CERTEXP3_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP4(le.AT_CERTEXP4_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP5(le.AT_CERTEXP5_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP6(le.AT_CERTEXP6_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP7(le.AT_CERTEXP7_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP8(le.AT_CERTEXP8_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP9(le.AT_CERTEXP9_Invalid),Base_Fields.InvalidMessage_AT_CERTEXP10(le.AT_CERTEXP10_Invalid),Base_Fields.InvalidMessage_EFX_EXTRACT_DATE(le.EFX_EXTRACT_DATE_Invalid),Base_Fields.InvalidMessage_EFX_MERCHANT_ID(le.EFX_MERCHANT_ID_Invalid),Base_Fields.InvalidMessage_EFX_PROJECT_ID(le.EFX_PROJECT_ID_Invalid),Base_Fields.InvalidMessage_EFX_FOREIGN(le.EFX_FOREIGN_Invalid),Base_Fields.InvalidMessage_Record_Update_Refresh_Date(le.Record_Update_Refresh_Date_Invalid),Base_Fields.InvalidMessage_EFX_DATE_CREATED(le.EFX_DATE_CREATED_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dotid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.normcompany_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.normaddress_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.norm_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.norm_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.norm_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_NAME_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LEGAL_NAME_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_ADDRESS_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_company_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.raw_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_BUSSTATCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CMSA_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPAMOUNTCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPAMOUNTPREC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPAMOUNTTP_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPEMPCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CTRYISOCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CTRYNUM_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CTRYTELCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_GEOPREC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MERCTYPE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_TELESCORE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_TOTALIND_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_TOTALSCORE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_PUBLIC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_STKEXC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_PRIMSIC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECSIC1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECSIC2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECSIC3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECSIC4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_ID_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CITY_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.EFX_CTRYNAME_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.EFX_SOHO_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_BIZ_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_RES_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_CMRA_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_SECGEOPREC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECCTRYISOCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECCTRYNUM_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_PHONE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_FAXPHONE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_YREST_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPEMPCNT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCEMPCNT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCEMPCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_CORPAMOUNT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCAMOUNT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCAMOUNTCD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCAMOUNTTP_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LOCAMOUNTPREC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_PRIMNAICSCODE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECNAICS1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECNAICS2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECNAICS3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_SECNAICS4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_DEAD_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_DEADDT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_TELEVER_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_VACANT_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MRKT_SEASONAL_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_WBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MWBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_SDB_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_HUBZONE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_DBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_VET_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_DVET_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_8a_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_8aEXPDT_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_DIS_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_SBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_BUSSIZE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_LBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_GOV_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_FGOV_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_NONPROFIT_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_HBCU_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_GAYLESBIAN_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_WSBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_VSBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_DVSBE_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MWBESTATUS_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_NMSDC_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_WBENC_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_CA_PUC_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_TX_HUB_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_GSAX_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_CALTRANS_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_EDU_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_MI_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.EFX_ANC_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV3_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV4_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV5_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV6_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV7_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV8_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV9_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTLEV10_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.AT_CERTEXP10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_EXTRACT_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_MERCHANT_ID_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_PROJECT_ID_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_FOREIGN_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.Record_Update_Refresh_Date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_DATE_CREATED_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','normcompany_type','normaddress_type','norm_state','norm_zip','norm_zip4','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','clean_company_name','clean_phone','predir','postdir','st','zip','zip4','cr_sort_sz','lot_order','rec_type','fips_state','geo_lat','geo_long','geo_match','err_stat','raw_aid','ace_aid','EFX_BUSSTATCD','EFX_CMSA','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_GEOPREC','EFX_MERCTYPE','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_PUBLIC','EFX_STKEXC','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_ID','EFX_CITY','EFX_CTRYNAME','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_SECGEOPREC','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_PHONE','EFX_FAXPHONE','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_NONPROFIT','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_zero_integer','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_record_type','invalid_norm_type','invalid_address_type_code','invalid_st','invalid_zip5','invalid_zip4','invalid_name','invalid_legal_name','invalid_mandatory','invalid_mandatory','invalid_phone','invalid_direction','invalid_direction','invalid_st','invalid_zip5','invalid_zip4','invalid_cr_sort_sz','invalid_lot_order','invalid_rec_type','invalid_fips_state','invalid_geo','invalid_geo','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_busstatcd','invalid_cmsa','invalid_corpamountcd','invalid_corpamountprec','invalid_corpamounttp','invalid_corpempcd','invalid_ctryisocd','invalid_ctrynum','invalid_ctrytelcd','invalid_geoprec','invalid_merctype','invalid_mrkt_telescore','invalid_mrkt_totalind','invalid_mrkt_totalscore','invalid_public','invalid_stkexc','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_geoprec','invalid_ctryisocd','invalid_ctrynum','invalid_phone','invalid_phone','invalid_year_established','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpempcd','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpamountcd','invalid_corpamounttp','invalid_corpamountprec','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_yes_blank','invalid_past_date','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_general_date','invalid_yes_blank','invalid_yes_blank','invalid_business_size','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_cert_or_class','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_past_date','invalid_numeric','invalid_numeric_or_blank','invalid_yes_blank','invalid_past_date','invalid_date_created','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.dotid,(SALT37.StrType)le.dotscore,(SALT37.StrType)le.dotweight,(SALT37.StrType)le.empid,(SALT37.StrType)le.empscore,(SALT37.StrType)le.empweight,(SALT37.StrType)le.powid,(SALT37.StrType)le.powscore,(SALT37.StrType)le.powweight,(SALT37.StrType)le.proxid,(SALT37.StrType)le.proxscore,(SALT37.StrType)le.proxweight,(SALT37.StrType)le.seleid,(SALT37.StrType)le.selescore,(SALT37.StrType)le.seleweight,(SALT37.StrType)le.orgid,(SALT37.StrType)le.orgscore,(SALT37.StrType)le.orgweight,(SALT37.StrType)le.ultid,(SALT37.StrType)le.ultscore,(SALT37.StrType)le.ultweight,(SALT37.StrType)le.dt_first_seen,(SALT37.StrType)le.dt_last_seen,(SALT37.StrType)le.dt_vendor_first_reported,(SALT37.StrType)le.dt_vendor_last_reported,(SALT37.StrType)le.process_date,(SALT37.StrType)le.record_type,(SALT37.StrType)le.normcompany_type,(SALT37.StrType)le.normaddress_type,(SALT37.StrType)le.norm_state,(SALT37.StrType)le.norm_zip,(SALT37.StrType)le.norm_zip4,(SALT37.StrType)le.EFX_NAME,(SALT37.StrType)le.EFX_LEGAL_NAME,(SALT37.StrType)le.EFX_ADDRESS,(SALT37.StrType)le.clean_company_name,(SALT37.StrType)le.clean_phone,(SALT37.StrType)le.predir,(SALT37.StrType)le.postdir,(SALT37.StrType)le.st,(SALT37.StrType)le.zip,(SALT37.StrType)le.zip4,(SALT37.StrType)le.cr_sort_sz,(SALT37.StrType)le.lot_order,(SALT37.StrType)le.rec_type,(SALT37.StrType)le.fips_state,(SALT37.StrType)le.geo_lat,(SALT37.StrType)le.geo_long,(SALT37.StrType)le.geo_match,(SALT37.StrType)le.err_stat,(SALT37.StrType)le.raw_aid,(SALT37.StrType)le.ace_aid,(SALT37.StrType)le.EFX_BUSSTATCD,(SALT37.StrType)le.EFX_CMSA,(SALT37.StrType)le.EFX_CORPAMOUNTCD,(SALT37.StrType)le.EFX_CORPAMOUNTPREC,(SALT37.StrType)le.EFX_CORPAMOUNTTP,(SALT37.StrType)le.EFX_CORPEMPCD,(SALT37.StrType)le.EFX_CTRYISOCD,(SALT37.StrType)le.EFX_CTRYNUM,(SALT37.StrType)le.EFX_CTRYTELCD,(SALT37.StrType)le.EFX_GEOPREC,(SALT37.StrType)le.EFX_MERCTYPE,(SALT37.StrType)le.EFX_MRKT_TELESCORE,(SALT37.StrType)le.EFX_MRKT_TOTALIND,(SALT37.StrType)le.EFX_MRKT_TOTALSCORE,(SALT37.StrType)le.EFX_PUBLIC,(SALT37.StrType)le.EFX_STKEXC,(SALT37.StrType)le.EFX_PRIMSIC,(SALT37.StrType)le.EFX_SECSIC1,(SALT37.StrType)le.EFX_SECSIC2,(SALT37.StrType)le.EFX_SECSIC3,(SALT37.StrType)le.EFX_SECSIC4,(SALT37.StrType)le.EFX_ID,(SALT37.StrType)le.EFX_CITY,(SALT37.StrType)le.EFX_CTRYNAME,(SALT37.StrType)le.EFX_SOHO,(SALT37.StrType)le.EFX_BIZ,(SALT37.StrType)le.EFX_RES,(SALT37.StrType)le.EFX_CMRA,(SALT37.StrType)le.EFX_SECGEOPREC,(SALT37.StrType)le.EFX_SECCTRYISOCD,(SALT37.StrType)le.EFX_SECCTRYNUM,(SALT37.StrType)le.EFX_PHONE,(SALT37.StrType)le.EFX_FAXPHONE,(SALT37.StrType)le.EFX_YREST,(SALT37.StrType)le.EFX_CORPEMPCNT,(SALT37.StrType)le.EFX_LOCEMPCNT,(SALT37.StrType)le.EFX_LOCEMPCD,(SALT37.StrType)le.EFX_CORPAMOUNT,(SALT37.StrType)le.EFX_LOCAMOUNT,(SALT37.StrType)le.EFX_LOCAMOUNTCD,(SALT37.StrType)le.EFX_LOCAMOUNTTP,(SALT37.StrType)le.EFX_LOCAMOUNTPREC,(SALT37.StrType)le.EFX_PRIMNAICSCODE,(SALT37.StrType)le.EFX_SECNAICS1,(SALT37.StrType)le.EFX_SECNAICS2,(SALT37.StrType)le.EFX_SECNAICS3,(SALT37.StrType)le.EFX_SECNAICS4,(SALT37.StrType)le.EFX_DEAD,(SALT37.StrType)le.EFX_DEADDT,(SALT37.StrType)le.EFX_MRKT_TELEVER,(SALT37.StrType)le.EFX_MRKT_VACANT,(SALT37.StrType)le.EFX_MRKT_SEASONAL,(SALT37.StrType)le.EFX_MBE,(SALT37.StrType)le.EFX_WBE,(SALT37.StrType)le.EFX_MWBE,(SALT37.StrType)le.EFX_SDB,(SALT37.StrType)le.EFX_HUBZONE,(SALT37.StrType)le.EFX_DBE,(SALT37.StrType)le.EFX_VET,(SALT37.StrType)le.EFX_DVET,(SALT37.StrType)le.EFX_8a,(SALT37.StrType)le.EFX_8aEXPDT,(SALT37.StrType)le.EFX_DIS,(SALT37.StrType)le.EFX_SBE,(SALT37.StrType)le.EFX_BUSSIZE,(SALT37.StrType)le.EFX_LBE,(SALT37.StrType)le.EFX_GOV,(SALT37.StrType)le.EFX_FGOV,(SALT37.StrType)le.EFX_NONPROFIT,(SALT37.StrType)le.EFX_HBCU,(SALT37.StrType)le.EFX_GAYLESBIAN,(SALT37.StrType)le.EFX_WSBE,(SALT37.StrType)le.EFX_VSBE,(SALT37.StrType)le.EFX_DVSBE,(SALT37.StrType)le.EFX_MWBESTATUS,(SALT37.StrType)le.EFX_NMSDC,(SALT37.StrType)le.EFX_WBENC,(SALT37.StrType)le.EFX_CA_PUC,(SALT37.StrType)le.EFX_TX_HUB,(SALT37.StrType)le.EFX_GSAX,(SALT37.StrType)le.EFX_CALTRANS,(SALT37.StrType)le.EFX_EDU,(SALT37.StrType)le.EFX_MI,(SALT37.StrType)le.EFX_ANC,(SALT37.StrType)le.AT_CERTLEV1,(SALT37.StrType)le.AT_CERTLEV2,(SALT37.StrType)le.AT_CERTLEV3,(SALT37.StrType)le.AT_CERTLEV4,(SALT37.StrType)le.AT_CERTLEV5,(SALT37.StrType)le.AT_CERTLEV6,(SALT37.StrType)le.AT_CERTLEV7,(SALT37.StrType)le.AT_CERTLEV8,(SALT37.StrType)le.AT_CERTLEV9,(SALT37.StrType)le.AT_CERTLEV10,(SALT37.StrType)le.AT_CERTEXP1,(SALT37.StrType)le.AT_CERTEXP2,(SALT37.StrType)le.AT_CERTEXP3,(SALT37.StrType)le.AT_CERTEXP4,(SALT37.StrType)le.AT_CERTEXP5,(SALT37.StrType)le.AT_CERTEXP6,(SALT37.StrType)le.AT_CERTEXP7,(SALT37.StrType)le.AT_CERTEXP8,(SALT37.StrType)le.AT_CERTEXP9,(SALT37.StrType)le.AT_CERTEXP10,(SALT37.StrType)le.EFX_EXTRACT_DATE,(SALT37.StrType)le.EFX_MERCHANT_ID,(SALT37.StrType)le.EFX_PROJECT_ID,(SALT37.StrType)le.EFX_FOREIGN,(SALT37.StrType)le.Record_Update_Refresh_Date,(SALT37.StrType)le.EFX_DATE_CREATED,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,162,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dotid:invalid_zero_integer:ENUM'
          ,'dotscore:invalid_zero_integer:ENUM'
          ,'dotweight:invalid_zero_integer:ENUM'
          ,'empid:invalid_zero_integer:ENUM'
          ,'empscore:invalid_zero_integer:ENUM'
          ,'empweight:invalid_zero_integer:ENUM'
          ,'powid:invalid_numeric:CUSTOM'
          ,'powscore:invalid_percentage:CUSTOM'
          ,'powweight:invalid_numeric:CUSTOM'
          ,'proxid:invalid_numeric:CUSTOM'
          ,'proxscore:invalid_percentage:CUSTOM'
          ,'proxweight:invalid_numeric:CUSTOM'
          ,'seleid:invalid_numeric:CUSTOM'
          ,'selescore:invalid_percentage:CUSTOM'
          ,'seleweight:invalid_numeric:CUSTOM'
          ,'orgid:invalid_numeric:CUSTOM'
          ,'orgscore:invalid_percentage:CUSTOM'
          ,'orgweight:invalid_numeric:CUSTOM'
          ,'ultid:invalid_numeric:CUSTOM'
          ,'ultscore:invalid_percentage:CUSTOM'
          ,'ultweight:invalid_numeric:CUSTOM'
          ,'dt_first_seen:invalid_reformated_date:CUSTOM'
          ,'dt_last_seen:invalid_reformated_date:CUSTOM'
          ,'dt_vendor_first_reported:invalid_reformated_date:CUSTOM'
          ,'dt_vendor_last_reported:invalid_reformated_date:CUSTOM'
          ,'process_date:invalid_reformated_date:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'normcompany_type:invalid_norm_type:ENUM'
          ,'normaddress_type:invalid_address_type_code:ENUM'
          ,'norm_state:invalid_st:CUSTOM'
          ,'norm_zip:invalid_zip5:CUSTOM'
          ,'norm_zip4:invalid_zip4:CUSTOM'
          ,'EFX_NAME:invalid_name:CUSTOM'
          ,'EFX_LEGAL_NAME:invalid_legal_name:CUSTOM'
          ,'EFX_ADDRESS:invalid_mandatory:LENGTH'
          ,'clean_company_name:invalid_mandatory:LENGTH'
          ,'clean_phone:invalid_phone:CUSTOM'
          ,'predir:invalid_direction:ENUM'
          ,'postdir:invalid_direction:ENUM'
          ,'st:invalid_st:CUSTOM'
          ,'zip:invalid_zip5:CUSTOM'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot_order:invalid_lot_order:ENUM'
          ,'rec_type:invalid_rec_type:CUSTOM'
          ,'fips_state:invalid_fips_state:CUSTOM'
          ,'geo_lat:invalid_geo:ALLOW'
          ,'geo_long:invalid_geo:ALLOW'
          ,'geo_match:invalid_geo_match:CUSTOM'
          ,'err_stat:invalid_err_stat:CUSTOM'
          ,'raw_aid:invalid_raw_aid:CUSTOM'
          ,'ace_aid:invalid_ace_aid:CUSTOM'
          ,'EFX_BUSSTATCD:invalid_busstatcd:CUSTOM'
          ,'EFX_CMSA:invalid_cmsa:CUSTOM'
          ,'EFX_CORPAMOUNTCD:invalid_corpamountcd:CUSTOM'
          ,'EFX_CORPAMOUNTPREC:invalid_corpamountprec:CUSTOM'
          ,'EFX_CORPAMOUNTTP:invalid_corpamounttp:CUSTOM'
          ,'EFX_CORPEMPCD:invalid_corpempcd:CUSTOM'
          ,'EFX_CTRYISOCD:invalid_ctryisocd:CUSTOM'
          ,'EFX_CTRYNUM:invalid_ctrynum:CUSTOM'
          ,'EFX_CTRYTELCD:invalid_ctrytelcd:CUSTOM'
          ,'EFX_GEOPREC:invalid_geoprec:CUSTOM'
          ,'EFX_MERCTYPE:invalid_merctype:CUSTOM'
          ,'EFX_MRKT_TELESCORE:invalid_mrkt_telescore:CUSTOM'
          ,'EFX_MRKT_TOTALIND:invalid_mrkt_totalind:CUSTOM'
          ,'EFX_MRKT_TOTALSCORE:invalid_mrkt_totalscore:CUSTOM'
          ,'EFX_PUBLIC:invalid_public:CUSTOM'
          ,'EFX_STKEXC:invalid_stkexc:CUSTOM'
          ,'EFX_PRIMSIC:invalid_sic:CUSTOM'
          ,'EFX_SECSIC1:invalid_sic:CUSTOM'
          ,'EFX_SECSIC2:invalid_sic:CUSTOM'
          ,'EFX_SECSIC3:invalid_sic:CUSTOM'
          ,'EFX_SECSIC4:invalid_sic:CUSTOM'
          ,'EFX_ID:invalid_numeric:CUSTOM'
          ,'EFX_CITY:invalid_mandatory:LENGTH'
          ,'EFX_CTRYNAME:invalid_mandatory:LENGTH'
          ,'EFX_SOHO:invalid_yes_blank:ENUM'
          ,'EFX_BIZ:invalid_yes_blank:ENUM'
          ,'EFX_RES:invalid_yes_blank:ENUM'
          ,'EFX_CMRA:invalid_yes_blank:ENUM'
          ,'EFX_SECGEOPREC:invalid_geoprec:CUSTOM'
          ,'EFX_SECCTRYISOCD:invalid_ctryisocd:CUSTOM'
          ,'EFX_SECCTRYNUM:invalid_ctrynum:CUSTOM'
          ,'EFX_PHONE:invalid_phone:CUSTOM'
          ,'EFX_FAXPHONE:invalid_phone:CUSTOM'
          ,'EFX_YREST:invalid_year_established:CUSTOM'
          ,'EFX_CORPEMPCNT:invalid_numeric_or_blank:CUSTOM'
          ,'EFX_LOCEMPCNT:invalid_numeric_or_blank:CUSTOM'
          ,'EFX_LOCEMPCD:invalid_corpempcd:CUSTOM'
          ,'EFX_CORPAMOUNT:invalid_numeric_or_blank:CUSTOM'
          ,'EFX_LOCAMOUNT:invalid_numeric_or_blank:CUSTOM'
          ,'EFX_LOCAMOUNTCD:invalid_corpamountcd:CUSTOM'
          ,'EFX_LOCAMOUNTTP:invalid_corpamounttp:CUSTOM'
          ,'EFX_LOCAMOUNTPREC:invalid_corpamountprec:CUSTOM'
          ,'EFX_PRIMNAICSCODE:invalid_naics:CUSTOM'
          ,'EFX_SECNAICS1:invalid_naics:CUSTOM'
          ,'EFX_SECNAICS2:invalid_naics:CUSTOM'
          ,'EFX_SECNAICS3:invalid_naics:CUSTOM'
          ,'EFX_SECNAICS4:invalid_naics:CUSTOM'
          ,'EFX_DEAD:invalid_yes_blank:ENUM'
          ,'EFX_DEADDT:invalid_past_date:CUSTOM'
          ,'EFX_MRKT_TELEVER:invalid_yes_blank:ENUM'
          ,'EFX_MRKT_VACANT:invalid_yes_blank:ENUM'
          ,'EFX_MRKT_SEASONAL:invalid_yes_blank:ENUM'
          ,'EFX_MBE:invalid_yes_blank:ENUM'
          ,'EFX_WBE:invalid_yes_blank:ENUM'
          ,'EFX_MWBE:invalid_yes_blank:ENUM'
          ,'EFX_SDB:invalid_yes_blank:ENUM'
          ,'EFX_HUBZONE:invalid_yes_blank:ENUM'
          ,'EFX_DBE:invalid_yes_blank:ENUM'
          ,'EFX_VET:invalid_yes_blank:ENUM'
          ,'EFX_DVET:invalid_yes_blank:ENUM'
          ,'EFX_8a:invalid_yes_blank:ENUM'
          ,'EFX_8aEXPDT:invalid_general_date:CUSTOM'
          ,'EFX_DIS:invalid_yes_blank:ENUM'
          ,'EFX_SBE:invalid_yes_blank:ENUM'
          ,'EFX_BUSSIZE:invalid_business_size:ENUM'
          ,'EFX_LBE:invalid_yes_blank:ENUM'
          ,'EFX_GOV:invalid_yes_blank:ENUM'
          ,'EFX_FGOV:invalid_yes_blank:ENUM'
          ,'EFX_NONPROFIT:invalid_yes_blank:ENUM'
          ,'EFX_HBCU:invalid_yes_blank:ENUM'
          ,'EFX_GAYLESBIAN:invalid_yes_blank:ENUM'
          ,'EFX_WSBE:invalid_yes_blank:ENUM'
          ,'EFX_VSBE:invalid_yes_blank:ENUM'
          ,'EFX_DVSBE:invalid_yes_blank:ENUM'
          ,'EFX_MWBESTATUS:invalid_cert_or_class:ENUM'
          ,'EFX_NMSDC:invalid_yes_blank:ENUM'
          ,'EFX_WBENC:invalid_yes_blank:ENUM'
          ,'EFX_CA_PUC:invalid_yes_blank:ENUM'
          ,'EFX_TX_HUB:invalid_yes_blank:ENUM'
          ,'EFX_GSAX:invalid_yes_blank:ENUM'
          ,'EFX_CALTRANS:invalid_yes_blank:ENUM'
          ,'EFX_EDU:invalid_yes_blank:ENUM'
          ,'EFX_MI:invalid_yes_blank:ENUM'
          ,'EFX_ANC:invalid_yes_blank:ENUM'
          ,'AT_CERTLEV1:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV2:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV3:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV4:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV5:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV6:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV7:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV8:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV9:invalid_cert_or_class:ENUM'
          ,'AT_CERTLEV10:invalid_cert_or_class:ENUM'
          ,'AT_CERTEXP1:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP2:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP3:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP4:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP5:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP6:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP7:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP8:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP9:invalid_general_date:CUSTOM'
          ,'AT_CERTEXP10:invalid_general_date:CUSTOM'
          ,'EFX_EXTRACT_DATE:invalid_past_date:CUSTOM'
          ,'EFX_MERCHANT_ID:invalid_numeric:CUSTOM'
          ,'EFX_PROJECT_ID:invalid_numeric_or_blank:CUSTOM'
          ,'EFX_FOREIGN:invalid_yes_blank:ENUM'
          ,'Record_Update_Refresh_Date:invalid_past_date:CUSTOM'
          ,'EFX_DATE_CREATED:invalid_date_created:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_dotid(1)
          ,Base_Fields.InvalidMessage_dotscore(1)
          ,Base_Fields.InvalidMessage_dotweight(1)
          ,Base_Fields.InvalidMessage_empid(1)
          ,Base_Fields.InvalidMessage_empscore(1)
          ,Base_Fields.InvalidMessage_empweight(1)
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_powscore(1)
          ,Base_Fields.InvalidMessage_powweight(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_proxscore(1)
          ,Base_Fields.InvalidMessage_proxweight(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_selescore(1)
          ,Base_Fields.InvalidMessage_seleweight(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_orgscore(1)
          ,Base_Fields.InvalidMessage_orgweight(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_ultscore(1)
          ,Base_Fields.InvalidMessage_ultweight(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_process_date(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_normcompany_type(1)
          ,Base_Fields.InvalidMessage_normaddress_type(1)
          ,Base_Fields.InvalidMessage_norm_state(1)
          ,Base_Fields.InvalidMessage_norm_zip(1)
          ,Base_Fields.InvalidMessage_norm_zip4(1)
          ,Base_Fields.InvalidMessage_EFX_NAME(1)
          ,Base_Fields.InvalidMessage_EFX_LEGAL_NAME(1)
          ,Base_Fields.InvalidMessage_EFX_ADDRESS(1)
          ,Base_Fields.InvalidMessage_clean_company_name(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Fields.InvalidMessage_lot_order(1)
          ,Base_Fields.InvalidMessage_rec_type(1)
          ,Base_Fields.InvalidMessage_fips_state(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_geo_match(1)
          ,Base_Fields.InvalidMessage_err_stat(1)
          ,Base_Fields.InvalidMessage_raw_aid(1)
          ,Base_Fields.InvalidMessage_ace_aid(1)
          ,Base_Fields.InvalidMessage_EFX_BUSSTATCD(1)
          ,Base_Fields.InvalidMessage_EFX_CMSA(1)
          ,Base_Fields.InvalidMessage_EFX_CORPAMOUNTCD(1)
          ,Base_Fields.InvalidMessage_EFX_CORPAMOUNTPREC(1)
          ,Base_Fields.InvalidMessage_EFX_CORPAMOUNTTP(1)
          ,Base_Fields.InvalidMessage_EFX_CORPEMPCD(1)
          ,Base_Fields.InvalidMessage_EFX_CTRYISOCD(1)
          ,Base_Fields.InvalidMessage_EFX_CTRYNUM(1)
          ,Base_Fields.InvalidMessage_EFX_CTRYTELCD(1)
          ,Base_Fields.InvalidMessage_EFX_GEOPREC(1)
          ,Base_Fields.InvalidMessage_EFX_MERCTYPE(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_TELESCORE(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_TOTALIND(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_TOTALSCORE(1)
          ,Base_Fields.InvalidMessage_EFX_PUBLIC(1)
          ,Base_Fields.InvalidMessage_EFX_STKEXC(1)
          ,Base_Fields.InvalidMessage_EFX_PRIMSIC(1)
          ,Base_Fields.InvalidMessage_EFX_SECSIC1(1)
          ,Base_Fields.InvalidMessage_EFX_SECSIC2(1)
          ,Base_Fields.InvalidMessage_EFX_SECSIC3(1)
          ,Base_Fields.InvalidMessage_EFX_SECSIC4(1)
          ,Base_Fields.InvalidMessage_EFX_ID(1)
          ,Base_Fields.InvalidMessage_EFX_CITY(1)
          ,Base_Fields.InvalidMessage_EFX_CTRYNAME(1)
          ,Base_Fields.InvalidMessage_EFX_SOHO(1)
          ,Base_Fields.InvalidMessage_EFX_BIZ(1)
          ,Base_Fields.InvalidMessage_EFX_RES(1)
          ,Base_Fields.InvalidMessage_EFX_CMRA(1)
          ,Base_Fields.InvalidMessage_EFX_SECGEOPREC(1)
          ,Base_Fields.InvalidMessage_EFX_SECCTRYISOCD(1)
          ,Base_Fields.InvalidMessage_EFX_SECCTRYNUM(1)
          ,Base_Fields.InvalidMessage_EFX_PHONE(1)
          ,Base_Fields.InvalidMessage_EFX_FAXPHONE(1)
          ,Base_Fields.InvalidMessage_EFX_YREST(1)
          ,Base_Fields.InvalidMessage_EFX_CORPEMPCNT(1)
          ,Base_Fields.InvalidMessage_EFX_LOCEMPCNT(1)
          ,Base_Fields.InvalidMessage_EFX_LOCEMPCD(1)
          ,Base_Fields.InvalidMessage_EFX_CORPAMOUNT(1)
          ,Base_Fields.InvalidMessage_EFX_LOCAMOUNT(1)
          ,Base_Fields.InvalidMessage_EFX_LOCAMOUNTCD(1)
          ,Base_Fields.InvalidMessage_EFX_LOCAMOUNTTP(1)
          ,Base_Fields.InvalidMessage_EFX_LOCAMOUNTPREC(1)
          ,Base_Fields.InvalidMessage_EFX_PRIMNAICSCODE(1)
          ,Base_Fields.InvalidMessage_EFX_SECNAICS1(1)
          ,Base_Fields.InvalidMessage_EFX_SECNAICS2(1)
          ,Base_Fields.InvalidMessage_EFX_SECNAICS3(1)
          ,Base_Fields.InvalidMessage_EFX_SECNAICS4(1)
          ,Base_Fields.InvalidMessage_EFX_DEAD(1)
          ,Base_Fields.InvalidMessage_EFX_DEADDT(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_TELEVER(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_VACANT(1)
          ,Base_Fields.InvalidMessage_EFX_MRKT_SEASONAL(1)
          ,Base_Fields.InvalidMessage_EFX_MBE(1)
          ,Base_Fields.InvalidMessage_EFX_WBE(1)
          ,Base_Fields.InvalidMessage_EFX_MWBE(1)
          ,Base_Fields.InvalidMessage_EFX_SDB(1)
          ,Base_Fields.InvalidMessage_EFX_HUBZONE(1)
          ,Base_Fields.InvalidMessage_EFX_DBE(1)
          ,Base_Fields.InvalidMessage_EFX_VET(1)
          ,Base_Fields.InvalidMessage_EFX_DVET(1)
          ,Base_Fields.InvalidMessage_EFX_8a(1)
          ,Base_Fields.InvalidMessage_EFX_8aEXPDT(1)
          ,Base_Fields.InvalidMessage_EFX_DIS(1)
          ,Base_Fields.InvalidMessage_EFX_SBE(1)
          ,Base_Fields.InvalidMessage_EFX_BUSSIZE(1)
          ,Base_Fields.InvalidMessage_EFX_LBE(1)
          ,Base_Fields.InvalidMessage_EFX_GOV(1)
          ,Base_Fields.InvalidMessage_EFX_FGOV(1)
          ,Base_Fields.InvalidMessage_EFX_NONPROFIT(1)
          ,Base_Fields.InvalidMessage_EFX_HBCU(1)
          ,Base_Fields.InvalidMessage_EFX_GAYLESBIAN(1)
          ,Base_Fields.InvalidMessage_EFX_WSBE(1)
          ,Base_Fields.InvalidMessage_EFX_VSBE(1)
          ,Base_Fields.InvalidMessage_EFX_DVSBE(1)
          ,Base_Fields.InvalidMessage_EFX_MWBESTATUS(1)
          ,Base_Fields.InvalidMessage_EFX_NMSDC(1)
          ,Base_Fields.InvalidMessage_EFX_WBENC(1)
          ,Base_Fields.InvalidMessage_EFX_CA_PUC(1)
          ,Base_Fields.InvalidMessage_EFX_TX_HUB(1)
          ,Base_Fields.InvalidMessage_EFX_GSAX(1)
          ,Base_Fields.InvalidMessage_EFX_CALTRANS(1)
          ,Base_Fields.InvalidMessage_EFX_EDU(1)
          ,Base_Fields.InvalidMessage_EFX_MI(1)
          ,Base_Fields.InvalidMessage_EFX_ANC(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV1(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV2(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV3(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV4(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV5(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV6(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV7(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV8(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV9(1)
          ,Base_Fields.InvalidMessage_AT_CERTLEV10(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP1(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP2(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP3(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP4(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP5(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP6(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP7(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP8(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP9(1)
          ,Base_Fields.InvalidMessage_AT_CERTEXP10(1)
          ,Base_Fields.InvalidMessage_EFX_EXTRACT_DATE(1)
          ,Base_Fields.InvalidMessage_EFX_MERCHANT_ID(1)
          ,Base_Fields.InvalidMessage_EFX_PROJECT_ID(1)
          ,Base_Fields.InvalidMessage_EFX_FOREIGN(1)
          ,Base_Fields.InvalidMessage_Record_Update_Refresh_Date(1)
          ,Base_Fields.InvalidMessage_EFX_DATE_CREATED(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount
          ,le.normaddress_type_ENUM_ErrorCount
          ,le.norm_state_CUSTOM_ErrorCount
          ,le.norm_zip_CUSTOM_ErrorCount
          ,le.norm_zip4_CUSTOM_ErrorCount
          ,le.EFX_NAME_CUSTOM_ErrorCount
          ,le.EFX_LEGAL_NAME_CUSTOM_ErrorCount
          ,le.EFX_ADDRESS_LENGTH_ErrorCount
          ,le.clean_company_name_LENGTH_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.EFX_BUSSTATCD_CUSTOM_ErrorCount
          ,le.EFX_CMSA_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTCD_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTPREC_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTTP_CUSTOM_ErrorCount
          ,le.EFX_CORPEMPCD_CUSTOM_ErrorCount
          ,le.EFX_CTRYISOCD_CUSTOM_ErrorCount
          ,le.EFX_CTRYNUM_CUSTOM_ErrorCount
          ,le.EFX_CTRYTELCD_CUSTOM_ErrorCount
          ,le.EFX_GEOPREC_CUSTOM_ErrorCount
          ,le.EFX_MERCTYPE_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TELESCORE_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TOTALIND_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TOTALSCORE_CUSTOM_ErrorCount
          ,le.EFX_PUBLIC_CUSTOM_ErrorCount
          ,le.EFX_STKEXC_CUSTOM_ErrorCount
          ,le.EFX_PRIMSIC_CUSTOM_ErrorCount
          ,le.EFX_SECSIC1_CUSTOM_ErrorCount
          ,le.EFX_SECSIC2_CUSTOM_ErrorCount
          ,le.EFX_SECSIC3_CUSTOM_ErrorCount
          ,le.EFX_SECSIC4_CUSTOM_ErrorCount
          ,le.EFX_ID_CUSTOM_ErrorCount
          ,le.EFX_CITY_LENGTH_ErrorCount
          ,le.EFX_CTRYNAME_LENGTH_ErrorCount
          ,le.EFX_SOHO_ENUM_ErrorCount
          ,le.EFX_BIZ_ENUM_ErrorCount
          ,le.EFX_RES_ENUM_ErrorCount
          ,le.EFX_CMRA_ENUM_ErrorCount
          ,le.EFX_SECGEOPREC_CUSTOM_ErrorCount
          ,le.EFX_SECCTRYISOCD_CUSTOM_ErrorCount
          ,le.EFX_SECCTRYNUM_CUSTOM_ErrorCount
          ,le.EFX_PHONE_CUSTOM_ErrorCount
          ,le.EFX_FAXPHONE_CUSTOM_ErrorCount
          ,le.EFX_YREST_CUSTOM_ErrorCount
          ,le.EFX_CORPEMPCNT_CUSTOM_ErrorCount
          ,le.EFX_LOCEMPCNT_CUSTOM_ErrorCount
          ,le.EFX_LOCEMPCD_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNT_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNT_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTCD_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTTP_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTPREC_CUSTOM_ErrorCount
          ,le.EFX_PRIMNAICSCODE_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS1_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS2_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS3_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS4_CUSTOM_ErrorCount
          ,le.EFX_DEAD_ENUM_ErrorCount
          ,le.EFX_DEADDT_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TELEVER_ENUM_ErrorCount
          ,le.EFX_MRKT_VACANT_ENUM_ErrorCount
          ,le.EFX_MRKT_SEASONAL_ENUM_ErrorCount
          ,le.EFX_MBE_ENUM_ErrorCount
          ,le.EFX_WBE_ENUM_ErrorCount
          ,le.EFX_MWBE_ENUM_ErrorCount
          ,le.EFX_SDB_ENUM_ErrorCount
          ,le.EFX_HUBZONE_ENUM_ErrorCount
          ,le.EFX_DBE_ENUM_ErrorCount
          ,le.EFX_VET_ENUM_ErrorCount
          ,le.EFX_DVET_ENUM_ErrorCount
          ,le.EFX_8a_ENUM_ErrorCount
          ,le.EFX_8aEXPDT_CUSTOM_ErrorCount
          ,le.EFX_DIS_ENUM_ErrorCount
          ,le.EFX_SBE_ENUM_ErrorCount
          ,le.EFX_BUSSIZE_ENUM_ErrorCount
          ,le.EFX_LBE_ENUM_ErrorCount
          ,le.EFX_GOV_ENUM_ErrorCount
          ,le.EFX_FGOV_ENUM_ErrorCount
          ,le.EFX_NONPROFIT_ENUM_ErrorCount
          ,le.EFX_HBCU_ENUM_ErrorCount
          ,le.EFX_GAYLESBIAN_ENUM_ErrorCount
          ,le.EFX_WSBE_ENUM_ErrorCount
          ,le.EFX_VSBE_ENUM_ErrorCount
          ,le.EFX_DVSBE_ENUM_ErrorCount
          ,le.EFX_MWBESTATUS_ENUM_ErrorCount
          ,le.EFX_NMSDC_ENUM_ErrorCount
          ,le.EFX_WBENC_ENUM_ErrorCount
          ,le.EFX_CA_PUC_ENUM_ErrorCount
          ,le.EFX_TX_HUB_ENUM_ErrorCount
          ,le.EFX_GSAX_ENUM_ErrorCount
          ,le.EFX_CALTRANS_ENUM_ErrorCount
          ,le.EFX_EDU_ENUM_ErrorCount
          ,le.EFX_MI_ENUM_ErrorCount
          ,le.EFX_ANC_ENUM_ErrorCount
          ,le.AT_CERTLEV1_ENUM_ErrorCount
          ,le.AT_CERTLEV2_ENUM_ErrorCount
          ,le.AT_CERTLEV3_ENUM_ErrorCount
          ,le.AT_CERTLEV4_ENUM_ErrorCount
          ,le.AT_CERTLEV5_ENUM_ErrorCount
          ,le.AT_CERTLEV6_ENUM_ErrorCount
          ,le.AT_CERTLEV7_ENUM_ErrorCount
          ,le.AT_CERTLEV8_ENUM_ErrorCount
          ,le.AT_CERTLEV9_ENUM_ErrorCount
          ,le.AT_CERTLEV10_ENUM_ErrorCount
          ,le.AT_CERTEXP1_CUSTOM_ErrorCount
          ,le.AT_CERTEXP2_CUSTOM_ErrorCount
          ,le.AT_CERTEXP3_CUSTOM_ErrorCount
          ,le.AT_CERTEXP4_CUSTOM_ErrorCount
          ,le.AT_CERTEXP5_CUSTOM_ErrorCount
          ,le.AT_CERTEXP6_CUSTOM_ErrorCount
          ,le.AT_CERTEXP7_CUSTOM_ErrorCount
          ,le.AT_CERTEXP8_CUSTOM_ErrorCount
          ,le.AT_CERTEXP9_CUSTOM_ErrorCount
          ,le.AT_CERTEXP10_CUSTOM_ErrorCount
          ,le.EFX_EXTRACT_DATE_CUSTOM_ErrorCount
          ,le.EFX_MERCHANT_ID_CUSTOM_ErrorCount
          ,le.EFX_PROJECT_ID_CUSTOM_ErrorCount
          ,le.EFX_FOREIGN_ENUM_ErrorCount
          ,le.Record_Update_Refresh_Date_CUSTOM_ErrorCount
          ,le.EFX_DATE_CREATED_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount
          ,le.normaddress_type_ENUM_ErrorCount
          ,le.norm_state_CUSTOM_ErrorCount
          ,le.norm_zip_CUSTOM_ErrorCount
          ,le.norm_zip4_CUSTOM_ErrorCount
          ,le.EFX_NAME_CUSTOM_ErrorCount
          ,le.EFX_LEGAL_NAME_CUSTOM_ErrorCount
          ,le.EFX_ADDRESS_LENGTH_ErrorCount
          ,le.clean_company_name_LENGTH_ErrorCount
          ,le.clean_phone_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.EFX_BUSSTATCD_CUSTOM_ErrorCount
          ,le.EFX_CMSA_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTCD_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTPREC_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNTTP_CUSTOM_ErrorCount
          ,le.EFX_CORPEMPCD_CUSTOM_ErrorCount
          ,le.EFX_CTRYISOCD_CUSTOM_ErrorCount
          ,le.EFX_CTRYNUM_CUSTOM_ErrorCount
          ,le.EFX_CTRYTELCD_CUSTOM_ErrorCount
          ,le.EFX_GEOPREC_CUSTOM_ErrorCount
          ,le.EFX_MERCTYPE_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TELESCORE_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TOTALIND_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TOTALSCORE_CUSTOM_ErrorCount
          ,le.EFX_PUBLIC_CUSTOM_ErrorCount
          ,le.EFX_STKEXC_CUSTOM_ErrorCount
          ,le.EFX_PRIMSIC_CUSTOM_ErrorCount
          ,le.EFX_SECSIC1_CUSTOM_ErrorCount
          ,le.EFX_SECSIC2_CUSTOM_ErrorCount
          ,le.EFX_SECSIC3_CUSTOM_ErrorCount
          ,le.EFX_SECSIC4_CUSTOM_ErrorCount
          ,le.EFX_ID_CUSTOM_ErrorCount
          ,le.EFX_CITY_LENGTH_ErrorCount
          ,le.EFX_CTRYNAME_LENGTH_ErrorCount
          ,le.EFX_SOHO_ENUM_ErrorCount
          ,le.EFX_BIZ_ENUM_ErrorCount
          ,le.EFX_RES_ENUM_ErrorCount
          ,le.EFX_CMRA_ENUM_ErrorCount
          ,le.EFX_SECGEOPREC_CUSTOM_ErrorCount
          ,le.EFX_SECCTRYISOCD_CUSTOM_ErrorCount
          ,le.EFX_SECCTRYNUM_CUSTOM_ErrorCount
          ,le.EFX_PHONE_CUSTOM_ErrorCount
          ,le.EFX_FAXPHONE_CUSTOM_ErrorCount
          ,le.EFX_YREST_CUSTOM_ErrorCount
          ,le.EFX_CORPEMPCNT_CUSTOM_ErrorCount
          ,le.EFX_LOCEMPCNT_CUSTOM_ErrorCount
          ,le.EFX_LOCEMPCD_CUSTOM_ErrorCount
          ,le.EFX_CORPAMOUNT_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNT_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTCD_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTTP_CUSTOM_ErrorCount
          ,le.EFX_LOCAMOUNTPREC_CUSTOM_ErrorCount
          ,le.EFX_PRIMNAICSCODE_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS1_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS2_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS3_CUSTOM_ErrorCount
          ,le.EFX_SECNAICS4_CUSTOM_ErrorCount
          ,le.EFX_DEAD_ENUM_ErrorCount
          ,le.EFX_DEADDT_CUSTOM_ErrorCount
          ,le.EFX_MRKT_TELEVER_ENUM_ErrorCount
          ,le.EFX_MRKT_VACANT_ENUM_ErrorCount
          ,le.EFX_MRKT_SEASONAL_ENUM_ErrorCount
          ,le.EFX_MBE_ENUM_ErrorCount
          ,le.EFX_WBE_ENUM_ErrorCount
          ,le.EFX_MWBE_ENUM_ErrorCount
          ,le.EFX_SDB_ENUM_ErrorCount
          ,le.EFX_HUBZONE_ENUM_ErrorCount
          ,le.EFX_DBE_ENUM_ErrorCount
          ,le.EFX_VET_ENUM_ErrorCount
          ,le.EFX_DVET_ENUM_ErrorCount
          ,le.EFX_8a_ENUM_ErrorCount
          ,le.EFX_8aEXPDT_CUSTOM_ErrorCount
          ,le.EFX_DIS_ENUM_ErrorCount
          ,le.EFX_SBE_ENUM_ErrorCount
          ,le.EFX_BUSSIZE_ENUM_ErrorCount
          ,le.EFX_LBE_ENUM_ErrorCount
          ,le.EFX_GOV_ENUM_ErrorCount
          ,le.EFX_FGOV_ENUM_ErrorCount
          ,le.EFX_NONPROFIT_ENUM_ErrorCount
          ,le.EFX_HBCU_ENUM_ErrorCount
          ,le.EFX_GAYLESBIAN_ENUM_ErrorCount
          ,le.EFX_WSBE_ENUM_ErrorCount
          ,le.EFX_VSBE_ENUM_ErrorCount
          ,le.EFX_DVSBE_ENUM_ErrorCount
          ,le.EFX_MWBESTATUS_ENUM_ErrorCount
          ,le.EFX_NMSDC_ENUM_ErrorCount
          ,le.EFX_WBENC_ENUM_ErrorCount
          ,le.EFX_CA_PUC_ENUM_ErrorCount
          ,le.EFX_TX_HUB_ENUM_ErrorCount
          ,le.EFX_GSAX_ENUM_ErrorCount
          ,le.EFX_CALTRANS_ENUM_ErrorCount
          ,le.EFX_EDU_ENUM_ErrorCount
          ,le.EFX_MI_ENUM_ErrorCount
          ,le.EFX_ANC_ENUM_ErrorCount
          ,le.AT_CERTLEV1_ENUM_ErrorCount
          ,le.AT_CERTLEV2_ENUM_ErrorCount
          ,le.AT_CERTLEV3_ENUM_ErrorCount
          ,le.AT_CERTLEV4_ENUM_ErrorCount
          ,le.AT_CERTLEV5_ENUM_ErrorCount
          ,le.AT_CERTLEV6_ENUM_ErrorCount
          ,le.AT_CERTLEV7_ENUM_ErrorCount
          ,le.AT_CERTLEV8_ENUM_ErrorCount
          ,le.AT_CERTLEV9_ENUM_ErrorCount
          ,le.AT_CERTLEV10_ENUM_ErrorCount
          ,le.AT_CERTEXP1_CUSTOM_ErrorCount
          ,le.AT_CERTEXP2_CUSTOM_ErrorCount
          ,le.AT_CERTEXP3_CUSTOM_ErrorCount
          ,le.AT_CERTEXP4_CUSTOM_ErrorCount
          ,le.AT_CERTEXP5_CUSTOM_ErrorCount
          ,le.AT_CERTEXP6_CUSTOM_ErrorCount
          ,le.AT_CERTEXP7_CUSTOM_ErrorCount
          ,le.AT_CERTEXP8_CUSTOM_ErrorCount
          ,le.AT_CERTEXP9_CUSTOM_ErrorCount
          ,le.AT_CERTEXP10_CUSTOM_ErrorCount
          ,le.EFX_EXTRACT_DATE_CUSTOM_ErrorCount
          ,le.EFX_MERCHANT_ID_CUSTOM_ErrorCount
          ,le.EFX_PROJECT_ID_CUSTOM_ErrorCount
          ,le.EFX_FOREIGN_ENUM_ErrorCount
          ,le.Record_Update_Refresh_Date_CUSTOM_ErrorCount
          ,le.EFX_DATE_CREATED_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,162,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
