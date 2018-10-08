IMPORT SALT37;
IMPORT Scrubs_Equifax_Business_Data; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Input_Layout_Equifax_Business_Data)
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
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Equifax_Business_Data)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Input_Layout_Equifax_Business_Data) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Input_Fields.InValid_dt_first_seen((SALT37.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Input_Fields.InValid_dt_last_seen((SALT37.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Input_Fields.InValid_dt_vendor_first_reported((SALT37.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Input_Fields.InValid_dt_vendor_last_reported((SALT37.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Input_Fields.InValid_process_date((SALT37.StrType)le.process_date);
    SELF.record_type_Invalid := Input_Fields.InValid_record_type((SALT37.StrType)le.record_type);
    SELF.normcompany_type_Invalid := Input_Fields.InValid_normcompany_type((SALT37.StrType)le.normcompany_type);
    SELF.normaddress_type_Invalid := Input_Fields.InValid_normaddress_type((SALT37.StrType)le.normaddress_type);
    SELF.norm_state_Invalid := Input_Fields.InValid_norm_state((SALT37.StrType)le.norm_state);
    SELF.norm_zip_Invalid := Input_Fields.InValid_norm_zip((SALT37.StrType)le.norm_zip);
    SELF.norm_zip4_Invalid := Input_Fields.InValid_norm_zip4((SALT37.StrType)le.norm_zip4);
    SELF.EFX_NAME_Invalid := Input_Fields.InValid_EFX_NAME((SALT37.StrType)le.EFX_NAME);
    SELF.EFX_LEGAL_NAME_Invalid := Input_Fields.InValid_EFX_LEGAL_NAME((SALT37.StrType)le.EFX_LEGAL_NAME);
    SELF.EFX_ADDRESS_Invalid := Input_Fields.InValid_EFX_ADDRESS((SALT37.StrType)le.EFX_ADDRESS);
    SELF.EFX_BUSSTATCD_Invalid := Input_Fields.InValid_EFX_BUSSTATCD((SALT37.StrType)le.EFX_BUSSTATCD);
    SELF.EFX_CMSA_Invalid := Input_Fields.InValid_EFX_CMSA((SALT37.StrType)le.EFX_CMSA);
    SELF.EFX_CORPAMOUNTCD_Invalid := Input_Fields.InValid_EFX_CORPAMOUNTCD((SALT37.StrType)le.EFX_CORPAMOUNTCD);
    SELF.EFX_CORPAMOUNTPREC_Invalid := Input_Fields.InValid_EFX_CORPAMOUNTPREC((SALT37.StrType)le.EFX_CORPAMOUNTPREC);
    SELF.EFX_CORPAMOUNTTP_Invalid := Input_Fields.InValid_EFX_CORPAMOUNTTP((SALT37.StrType)le.EFX_CORPAMOUNTTP);
    SELF.EFX_CORPEMPCD_Invalid := Input_Fields.InValid_EFX_CORPEMPCD((SALT37.StrType)le.EFX_CORPEMPCD);
    SELF.EFX_CTRYISOCD_Invalid := Input_Fields.InValid_EFX_CTRYISOCD((SALT37.StrType)le.EFX_CTRYISOCD);
    SELF.EFX_CTRYNUM_Invalid := Input_Fields.InValid_EFX_CTRYNUM((SALT37.StrType)le.EFX_CTRYNUM);
    SELF.EFX_CTRYTELCD_Invalid := Input_Fields.InValid_EFX_CTRYTELCD((SALT37.StrType)le.EFX_CTRYTELCD);
    SELF.EFX_GEOPREC_Invalid := Input_Fields.InValid_EFX_GEOPREC((SALT37.StrType)le.EFX_GEOPREC);
    SELF.EFX_MERCTYPE_Invalid := Input_Fields.InValid_EFX_MERCTYPE((SALT37.StrType)le.EFX_MERCTYPE);
    SELF.EFX_MRKT_TELESCORE_Invalid := Input_Fields.InValid_EFX_MRKT_TELESCORE((SALT37.StrType)le.EFX_MRKT_TELESCORE);
    SELF.EFX_MRKT_TOTALIND_Invalid := Input_Fields.InValid_EFX_MRKT_TOTALIND((SALT37.StrType)le.EFX_MRKT_TOTALIND);
    SELF.EFX_MRKT_TOTALSCORE_Invalid := Input_Fields.InValid_EFX_MRKT_TOTALSCORE((SALT37.StrType)le.EFX_MRKT_TOTALSCORE);
    SELF.EFX_PUBLIC_Invalid := Input_Fields.InValid_EFX_PUBLIC((SALT37.StrType)le.EFX_PUBLIC);
    SELF.EFX_STKEXC_Invalid := Input_Fields.InValid_EFX_STKEXC((SALT37.StrType)le.EFX_STKEXC);
    SELF.EFX_PRIMSIC_Invalid := Input_Fields.InValid_EFX_PRIMSIC((SALT37.StrType)le.EFX_PRIMSIC);
    SELF.EFX_SECSIC1_Invalid := Input_Fields.InValid_EFX_SECSIC1((SALT37.StrType)le.EFX_SECSIC1);
    SELF.EFX_SECSIC2_Invalid := Input_Fields.InValid_EFX_SECSIC2((SALT37.StrType)le.EFX_SECSIC2);
    SELF.EFX_SECSIC3_Invalid := Input_Fields.InValid_EFX_SECSIC3((SALT37.StrType)le.EFX_SECSIC3);
    SELF.EFX_SECSIC4_Invalid := Input_Fields.InValid_EFX_SECSIC4((SALT37.StrType)le.EFX_SECSIC4);
    SELF.EFX_ID_Invalid := Input_Fields.InValid_EFX_ID((SALT37.StrType)le.EFX_ID);
    SELF.EFX_CITY_Invalid := Input_Fields.InValid_EFX_CITY((SALT37.StrType)le.EFX_CITY);
    SELF.EFX_CTRYNAME_Invalid := Input_Fields.InValid_EFX_CTRYNAME((SALT37.StrType)le.EFX_CTRYNAME);
    SELF.EFX_SOHO_Invalid := Input_Fields.InValid_EFX_SOHO((SALT37.StrType)le.EFX_SOHO);
    SELF.EFX_BIZ_Invalid := Input_Fields.InValid_EFX_BIZ((SALT37.StrType)le.EFX_BIZ);
    SELF.EFX_RES_Invalid := Input_Fields.InValid_EFX_RES((SALT37.StrType)le.EFX_RES);
    SELF.EFX_CMRA_Invalid := Input_Fields.InValid_EFX_CMRA((SALT37.StrType)le.EFX_CMRA);
    SELF.EFX_SECGEOPREC_Invalid := Input_Fields.InValid_EFX_SECGEOPREC((SALT37.StrType)le.EFX_SECGEOPREC);
    SELF.EFX_SECCTRYISOCD_Invalid := Input_Fields.InValid_EFX_SECCTRYISOCD((SALT37.StrType)le.EFX_SECCTRYISOCD);
    SELF.EFX_SECCTRYNUM_Invalid := Input_Fields.InValid_EFX_SECCTRYNUM((SALT37.StrType)le.EFX_SECCTRYNUM);
    SELF.EFX_PHONE_Invalid := Input_Fields.InValid_EFX_PHONE((SALT37.StrType)le.EFX_PHONE);
    SELF.EFX_FAXPHONE_Invalid := Input_Fields.InValid_EFX_FAXPHONE((SALT37.StrType)le.EFX_FAXPHONE);
    SELF.EFX_YREST_Invalid := Input_Fields.InValid_EFX_YREST((SALT37.StrType)le.EFX_YREST);
    SELF.EFX_CORPEMPCNT_Invalid := Input_Fields.InValid_EFX_CORPEMPCNT((SALT37.StrType)le.EFX_CORPEMPCNT);
    SELF.EFX_LOCEMPCNT_Invalid := Input_Fields.InValid_EFX_LOCEMPCNT((SALT37.StrType)le.EFX_LOCEMPCNT);
    SELF.EFX_LOCEMPCD_Invalid := Input_Fields.InValid_EFX_LOCEMPCD((SALT37.StrType)le.EFX_LOCEMPCD);
    SELF.EFX_CORPAMOUNT_Invalid := Input_Fields.InValid_EFX_CORPAMOUNT((SALT37.StrType)le.EFX_CORPAMOUNT);
    SELF.EFX_LOCAMOUNT_Invalid := Input_Fields.InValid_EFX_LOCAMOUNT((SALT37.StrType)le.EFX_LOCAMOUNT);
    SELF.EFX_LOCAMOUNTCD_Invalid := Input_Fields.InValid_EFX_LOCAMOUNTCD((SALT37.StrType)le.EFX_LOCAMOUNTCD);
    SELF.EFX_LOCAMOUNTTP_Invalid := Input_Fields.InValid_EFX_LOCAMOUNTTP((SALT37.StrType)le.EFX_LOCAMOUNTTP);
    SELF.EFX_LOCAMOUNTPREC_Invalid := Input_Fields.InValid_EFX_LOCAMOUNTPREC((SALT37.StrType)le.EFX_LOCAMOUNTPREC);
    SELF.EFX_PRIMNAICSCODE_Invalid := Input_Fields.InValid_EFX_PRIMNAICSCODE((SALT37.StrType)le.EFX_PRIMNAICSCODE);
    SELF.EFX_SECNAICS1_Invalid := Input_Fields.InValid_EFX_SECNAICS1((SALT37.StrType)le.EFX_SECNAICS1);
    SELF.EFX_SECNAICS2_Invalid := Input_Fields.InValid_EFX_SECNAICS2((SALT37.StrType)le.EFX_SECNAICS2);
    SELF.EFX_SECNAICS3_Invalid := Input_Fields.InValid_EFX_SECNAICS3((SALT37.StrType)le.EFX_SECNAICS3);
    SELF.EFX_SECNAICS4_Invalid := Input_Fields.InValid_EFX_SECNAICS4((SALT37.StrType)le.EFX_SECNAICS4);
    SELF.EFX_DEAD_Invalid := Input_Fields.InValid_EFX_DEAD((SALT37.StrType)le.EFX_DEAD);
    SELF.EFX_DEADDT_Invalid := Input_Fields.InValid_EFX_DEADDT((SALT37.StrType)le.EFX_DEADDT);
    SELF.EFX_MRKT_TELEVER_Invalid := Input_Fields.InValid_EFX_MRKT_TELEVER((SALT37.StrType)le.EFX_MRKT_TELEVER);
    SELF.EFX_MRKT_VACANT_Invalid := Input_Fields.InValid_EFX_MRKT_VACANT((SALT37.StrType)le.EFX_MRKT_VACANT);
    SELF.EFX_MRKT_SEASONAL_Invalid := Input_Fields.InValid_EFX_MRKT_SEASONAL((SALT37.StrType)le.EFX_MRKT_SEASONAL);
    SELF.EFX_MBE_Invalid := Input_Fields.InValid_EFX_MBE((SALT37.StrType)le.EFX_MBE);
    SELF.EFX_WBE_Invalid := Input_Fields.InValid_EFX_WBE((SALT37.StrType)le.EFX_WBE);
    SELF.EFX_MWBE_Invalid := Input_Fields.InValid_EFX_MWBE((SALT37.StrType)le.EFX_MWBE);
    SELF.EFX_SDB_Invalid := Input_Fields.InValid_EFX_SDB((SALT37.StrType)le.EFX_SDB);
    SELF.EFX_HUBZONE_Invalid := Input_Fields.InValid_EFX_HUBZONE((SALT37.StrType)le.EFX_HUBZONE);
    SELF.EFX_DBE_Invalid := Input_Fields.InValid_EFX_DBE((SALT37.StrType)le.EFX_DBE);
    SELF.EFX_VET_Invalid := Input_Fields.InValid_EFX_VET((SALT37.StrType)le.EFX_VET);
    SELF.EFX_DVET_Invalid := Input_Fields.InValid_EFX_DVET((SALT37.StrType)le.EFX_DVET);
    SELF.EFX_8a_Invalid := Input_Fields.InValid_EFX_8a((SALT37.StrType)le.EFX_8a);
    SELF.EFX_8aEXPDT_Invalid := Input_Fields.InValid_EFX_8aEXPDT((SALT37.StrType)le.EFX_8aEXPDT);
    SELF.EFX_DIS_Invalid := Input_Fields.InValid_EFX_DIS((SALT37.StrType)le.EFX_DIS);
    SELF.EFX_SBE_Invalid := Input_Fields.InValid_EFX_SBE((SALT37.StrType)le.EFX_SBE);
    SELF.EFX_BUSSIZE_Invalid := Input_Fields.InValid_EFX_BUSSIZE((SALT37.StrType)le.EFX_BUSSIZE);
    SELF.EFX_LBE_Invalid := Input_Fields.InValid_EFX_LBE((SALT37.StrType)le.EFX_LBE);
    SELF.EFX_GOV_Invalid := Input_Fields.InValid_EFX_GOV((SALT37.StrType)le.EFX_GOV);
    SELF.EFX_FGOV_Invalid := Input_Fields.InValid_EFX_FGOV((SALT37.StrType)le.EFX_FGOV);
    SELF.EFX_NONPROFIT_Invalid := Input_Fields.InValid_EFX_NONPROFIT((SALT37.StrType)le.EFX_NONPROFIT);
    SELF.EFX_HBCU_Invalid := Input_Fields.InValid_EFX_HBCU((SALT37.StrType)le.EFX_HBCU);
    SELF.EFX_GAYLESBIAN_Invalid := Input_Fields.InValid_EFX_GAYLESBIAN((SALT37.StrType)le.EFX_GAYLESBIAN);
    SELF.EFX_WSBE_Invalid := Input_Fields.InValid_EFX_WSBE((SALT37.StrType)le.EFX_WSBE);
    SELF.EFX_VSBE_Invalid := Input_Fields.InValid_EFX_VSBE((SALT37.StrType)le.EFX_VSBE);
    SELF.EFX_DVSBE_Invalid := Input_Fields.InValid_EFX_DVSBE((SALT37.StrType)le.EFX_DVSBE);
    SELF.EFX_MWBESTATUS_Invalid := Input_Fields.InValid_EFX_MWBESTATUS((SALT37.StrType)le.EFX_MWBESTATUS);
    SELF.EFX_NMSDC_Invalid := Input_Fields.InValid_EFX_NMSDC((SALT37.StrType)le.EFX_NMSDC);
    SELF.EFX_WBENC_Invalid := Input_Fields.InValid_EFX_WBENC((SALT37.StrType)le.EFX_WBENC);
    SELF.EFX_CA_PUC_Invalid := Input_Fields.InValid_EFX_CA_PUC((SALT37.StrType)le.EFX_CA_PUC);
    SELF.EFX_TX_HUB_Invalid := Input_Fields.InValid_EFX_TX_HUB((SALT37.StrType)le.EFX_TX_HUB);
    SELF.EFX_GSAX_Invalid := Input_Fields.InValid_EFX_GSAX((SALT37.StrType)le.EFX_GSAX);
    SELF.EFX_CALTRANS_Invalid := Input_Fields.InValid_EFX_CALTRANS((SALT37.StrType)le.EFX_CALTRANS);
    SELF.EFX_EDU_Invalid := Input_Fields.InValid_EFX_EDU((SALT37.StrType)le.EFX_EDU);
    SELF.EFX_MI_Invalid := Input_Fields.InValid_EFX_MI((SALT37.StrType)le.EFX_MI);
    SELF.EFX_ANC_Invalid := Input_Fields.InValid_EFX_ANC((SALT37.StrType)le.EFX_ANC);
    SELF.AT_CERTLEV1_Invalid := Input_Fields.InValid_AT_CERTLEV1((SALT37.StrType)le.AT_CERTLEV1);
    SELF.AT_CERTLEV2_Invalid := Input_Fields.InValid_AT_CERTLEV2((SALT37.StrType)le.AT_CERTLEV2);
    SELF.AT_CERTLEV3_Invalid := Input_Fields.InValid_AT_CERTLEV3((SALT37.StrType)le.AT_CERTLEV3);
    SELF.AT_CERTLEV4_Invalid := Input_Fields.InValid_AT_CERTLEV4((SALT37.StrType)le.AT_CERTLEV4);
    SELF.AT_CERTLEV5_Invalid := Input_Fields.InValid_AT_CERTLEV5((SALT37.StrType)le.AT_CERTLEV5);
    SELF.AT_CERTLEV6_Invalid := Input_Fields.InValid_AT_CERTLEV6((SALT37.StrType)le.AT_CERTLEV6);
    SELF.AT_CERTLEV7_Invalid := Input_Fields.InValid_AT_CERTLEV7((SALT37.StrType)le.AT_CERTLEV7);
    SELF.AT_CERTLEV8_Invalid := Input_Fields.InValid_AT_CERTLEV8((SALT37.StrType)le.AT_CERTLEV8);
    SELF.AT_CERTLEV9_Invalid := Input_Fields.InValid_AT_CERTLEV9((SALT37.StrType)le.AT_CERTLEV9);
    SELF.AT_CERTLEV10_Invalid := Input_Fields.InValid_AT_CERTLEV10((SALT37.StrType)le.AT_CERTLEV10);
    SELF.AT_CERTEXP1_Invalid := Input_Fields.InValid_AT_CERTEXP1((SALT37.StrType)le.AT_CERTEXP1);
    SELF.AT_CERTEXP2_Invalid := Input_Fields.InValid_AT_CERTEXP2((SALT37.StrType)le.AT_CERTEXP2);
    SELF.AT_CERTEXP3_Invalid := Input_Fields.InValid_AT_CERTEXP3((SALT37.StrType)le.AT_CERTEXP3);
    SELF.AT_CERTEXP4_Invalid := Input_Fields.InValid_AT_CERTEXP4((SALT37.StrType)le.AT_CERTEXP4);
    SELF.AT_CERTEXP5_Invalid := Input_Fields.InValid_AT_CERTEXP5((SALT37.StrType)le.AT_CERTEXP5);
    SELF.AT_CERTEXP6_Invalid := Input_Fields.InValid_AT_CERTEXP6((SALT37.StrType)le.AT_CERTEXP6);
    SELF.AT_CERTEXP7_Invalid := Input_Fields.InValid_AT_CERTEXP7((SALT37.StrType)le.AT_CERTEXP7);
    SELF.AT_CERTEXP8_Invalid := Input_Fields.InValid_AT_CERTEXP8((SALT37.StrType)le.AT_CERTEXP8);
    SELF.AT_CERTEXP9_Invalid := Input_Fields.InValid_AT_CERTEXP9((SALT37.StrType)le.AT_CERTEXP9);
    SELF.AT_CERTEXP10_Invalid := Input_Fields.InValid_AT_CERTEXP10((SALT37.StrType)le.AT_CERTEXP10);
    SELF.EFX_EXTRACT_DATE_Invalid := Input_Fields.InValid_EFX_EXTRACT_DATE((SALT37.StrType)le.EFX_EXTRACT_DATE);
    SELF.EFX_MERCHANT_ID_Invalid := Input_Fields.InValid_EFX_MERCHANT_ID((SALT37.StrType)le.EFX_MERCHANT_ID);
    SELF.EFX_PROJECT_ID_Invalid := Input_Fields.InValid_EFX_PROJECT_ID((SALT37.StrType)le.EFX_PROJECT_ID);
    SELF.EFX_FOREIGN_Invalid := Input_Fields.InValid_EFX_FOREIGN((SALT37.StrType)le.EFX_FOREIGN);
    SELF.Record_Update_Refresh_Date_Invalid := Input_Fields.InValid_Record_Update_Refresh_Date((SALT37.StrType)le.Record_Update_Refresh_Date);
    SELF.EFX_DATE_CREATED_Invalid := Input_Fields.InValid_EFX_DATE_CREATED((SALT37.StrType)le.EFX_DATE_CREATED);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Equifax_Business_Data);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.process_date_Invalid << 4 ) + ( le.record_type_Invalid << 5 ) + ( le.normcompany_type_Invalid << 6 ) + ( le.normaddress_type_Invalid << 7 ) + ( le.norm_state_Invalid << 8 ) + ( le.norm_zip_Invalid << 9 ) + ( le.norm_zip4_Invalid << 10 ) + ( le.EFX_NAME_Invalid << 11 ) + ( le.EFX_LEGAL_NAME_Invalid << 12 ) + ( le.EFX_ADDRESS_Invalid << 13 ) + ( le.EFX_BUSSTATCD_Invalid << 14 ) + ( le.EFX_CMSA_Invalid << 15 ) + ( le.EFX_CORPAMOUNTCD_Invalid << 16 ) + ( le.EFX_CORPAMOUNTPREC_Invalid << 17 ) + ( le.EFX_CORPAMOUNTTP_Invalid << 18 ) + ( le.EFX_CORPEMPCD_Invalid << 19 ) + ( le.EFX_CTRYISOCD_Invalid << 20 ) + ( le.EFX_CTRYNUM_Invalid << 21 ) + ( le.EFX_CTRYTELCD_Invalid << 22 ) + ( le.EFX_GEOPREC_Invalid << 23 ) + ( le.EFX_MERCTYPE_Invalid << 24 ) + ( le.EFX_MRKT_TELESCORE_Invalid << 25 ) + ( le.EFX_MRKT_TOTALIND_Invalid << 26 ) + ( le.EFX_MRKT_TOTALSCORE_Invalid << 27 ) + ( le.EFX_PUBLIC_Invalid << 28 ) + ( le.EFX_STKEXC_Invalid << 29 ) + ( le.EFX_PRIMSIC_Invalid << 30 ) + ( le.EFX_SECSIC1_Invalid << 31 ) + ( le.EFX_SECSIC2_Invalid << 32 ) + ( le.EFX_SECSIC3_Invalid << 33 ) + ( le.EFX_SECSIC4_Invalid << 34 ) + ( le.EFX_ID_Invalid << 35 ) + ( le.EFX_CITY_Invalid << 36 ) + ( le.EFX_CTRYNAME_Invalid << 37 ) + ( le.EFX_SOHO_Invalid << 38 ) + ( le.EFX_BIZ_Invalid << 39 ) + ( le.EFX_RES_Invalid << 40 ) + ( le.EFX_CMRA_Invalid << 41 ) + ( le.EFX_SECGEOPREC_Invalid << 42 ) + ( le.EFX_SECCTRYISOCD_Invalid << 43 ) + ( le.EFX_SECCTRYNUM_Invalid << 44 ) + ( le.EFX_PHONE_Invalid << 45 ) + ( le.EFX_FAXPHONE_Invalid << 46 ) + ( le.EFX_YREST_Invalid << 47 ) + ( le.EFX_CORPEMPCNT_Invalid << 48 ) + ( le.EFX_LOCEMPCNT_Invalid << 49 ) + ( le.EFX_LOCEMPCD_Invalid << 50 ) + ( le.EFX_CORPAMOUNT_Invalid << 51 ) + ( le.EFX_LOCAMOUNT_Invalid << 52 ) + ( le.EFX_LOCAMOUNTCD_Invalid << 53 ) + ( le.EFX_LOCAMOUNTTP_Invalid << 54 ) + ( le.EFX_LOCAMOUNTPREC_Invalid << 55 ) + ( le.EFX_PRIMNAICSCODE_Invalid << 56 ) + ( le.EFX_SECNAICS1_Invalid << 57 ) + ( le.EFX_SECNAICS2_Invalid << 58 ) + ( le.EFX_SECNAICS3_Invalid << 59 ) + ( le.EFX_SECNAICS4_Invalid << 60 ) + ( le.EFX_DEAD_Invalid << 61 ) + ( le.EFX_DEADDT_Invalid << 62 ) + ( le.EFX_MRKT_TELEVER_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.EFX_MRKT_VACANT_Invalid << 0 ) + ( le.EFX_MRKT_SEASONAL_Invalid << 1 ) + ( le.EFX_MBE_Invalid << 2 ) + ( le.EFX_WBE_Invalid << 3 ) + ( le.EFX_MWBE_Invalid << 4 ) + ( le.EFX_SDB_Invalid << 5 ) + ( le.EFX_HUBZONE_Invalid << 6 ) + ( le.EFX_DBE_Invalid << 7 ) + ( le.EFX_VET_Invalid << 8 ) + ( le.EFX_DVET_Invalid << 9 ) + ( le.EFX_8a_Invalid << 10 ) + ( le.EFX_8aEXPDT_Invalid << 11 ) + ( le.EFX_DIS_Invalid << 12 ) + ( le.EFX_SBE_Invalid << 13 ) + ( le.EFX_BUSSIZE_Invalid << 14 ) + ( le.EFX_LBE_Invalid << 15 ) + ( le.EFX_GOV_Invalid << 16 ) + ( le.EFX_FGOV_Invalid << 17 ) + ( le.EFX_NONPROFIT_Invalid << 18 ) + ( le.EFX_HBCU_Invalid << 19 ) + ( le.EFX_GAYLESBIAN_Invalid << 20 ) + ( le.EFX_WSBE_Invalid << 21 ) + ( le.EFX_VSBE_Invalid << 22 ) + ( le.EFX_DVSBE_Invalid << 23 ) + ( le.EFX_MWBESTATUS_Invalid << 24 ) + ( le.EFX_NMSDC_Invalid << 25 ) + ( le.EFX_WBENC_Invalid << 26 ) + ( le.EFX_CA_PUC_Invalid << 27 ) + ( le.EFX_TX_HUB_Invalid << 28 ) + ( le.EFX_GSAX_Invalid << 29 ) + ( le.EFX_CALTRANS_Invalid << 30 ) + ( le.EFX_EDU_Invalid << 31 ) + ( le.EFX_MI_Invalid << 32 ) + ( le.EFX_ANC_Invalid << 33 ) + ( le.AT_CERTLEV1_Invalid << 34 ) + ( le.AT_CERTLEV2_Invalid << 35 ) + ( le.AT_CERTLEV3_Invalid << 36 ) + ( le.AT_CERTLEV4_Invalid << 37 ) + ( le.AT_CERTLEV5_Invalid << 38 ) + ( le.AT_CERTLEV6_Invalid << 39 ) + ( le.AT_CERTLEV7_Invalid << 40 ) + ( le.AT_CERTLEV8_Invalid << 41 ) + ( le.AT_CERTLEV9_Invalid << 42 ) + ( le.AT_CERTLEV10_Invalid << 43 ) + ( le.AT_CERTEXP1_Invalid << 44 ) + ( le.AT_CERTEXP2_Invalid << 45 ) + ( le.AT_CERTEXP3_Invalid << 46 ) + ( le.AT_CERTEXP4_Invalid << 47 ) + ( le.AT_CERTEXP5_Invalid << 48 ) + ( le.AT_CERTEXP6_Invalid << 49 ) + ( le.AT_CERTEXP7_Invalid << 50 ) + ( le.AT_CERTEXP8_Invalid << 51 ) + ( le.AT_CERTEXP9_Invalid << 52 ) + ( le.AT_CERTEXP10_Invalid << 53 ) + ( le.EFX_EXTRACT_DATE_Invalid << 54 ) + ( le.EFX_MERCHANT_ID_Invalid << 55 ) + ( le.EFX_PROJECT_ID_Invalid << 56 ) + ( le.EFX_FOREIGN_Invalid << 57 ) + ( le.Record_Update_Refresh_Date_Invalid << 58 ) + ( le.EFX_DATE_CREATED_Invalid << 59 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Equifax_Business_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.normcompany_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.normaddress_type_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.norm_state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.norm_zip_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.norm_zip4_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.EFX_NAME_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.EFX_LEGAL_NAME_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.EFX_ADDRESS_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.EFX_BUSSTATCD_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.EFX_CMSA_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.EFX_CORPAMOUNTCD_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.EFX_CORPAMOUNTPREC_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.EFX_CORPAMOUNTTP_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.EFX_CORPEMPCD_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.EFX_CTRYISOCD_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.EFX_CTRYNUM_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.EFX_CTRYTELCD_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.EFX_GEOPREC_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.EFX_MERCTYPE_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.EFX_MRKT_TELESCORE_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.EFX_MRKT_TOTALIND_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.EFX_MRKT_TOTALSCORE_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.EFX_PUBLIC_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.EFX_STKEXC_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.EFX_PRIMSIC_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.EFX_SECSIC1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.EFX_SECSIC2_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.EFX_SECSIC3_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.EFX_SECSIC4_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.EFX_ID_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.EFX_CITY_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.EFX_CTRYNAME_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.EFX_SOHO_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.EFX_BIZ_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.EFX_RES_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.EFX_CMRA_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.EFX_SECGEOPREC_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.EFX_SECCTRYISOCD_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.EFX_SECCTRYNUM_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.EFX_PHONE_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.EFX_FAXPHONE_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.EFX_YREST_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.EFX_CORPEMPCNT_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.EFX_LOCEMPCNT_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.EFX_LOCEMPCD_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.EFX_CORPAMOUNT_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.EFX_LOCAMOUNT_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.EFX_LOCAMOUNTCD_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.EFX_LOCAMOUNTTP_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.EFX_LOCAMOUNTPREC_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.EFX_PRIMNAICSCODE_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.EFX_SECNAICS1_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.EFX_SECNAICS2_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.EFX_SECNAICS3_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.EFX_SECNAICS4_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.EFX_DEAD_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.EFX_DEADDT_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.EFX_MRKT_TELEVER_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.EFX_MRKT_VACANT_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.EFX_MRKT_SEASONAL_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.EFX_MBE_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.EFX_WBE_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.EFX_MWBE_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.EFX_SDB_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.EFX_HUBZONE_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.EFX_DBE_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.EFX_VET_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.EFX_DVET_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.EFX_8a_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.EFX_8aEXPDT_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.EFX_DIS_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.EFX_SBE_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.EFX_BUSSIZE_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.EFX_LBE_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.EFX_GOV_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.EFX_FGOV_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.EFX_NONPROFIT_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.EFX_HBCU_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.EFX_GAYLESBIAN_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.EFX_WSBE_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.EFX_VSBE_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.EFX_DVSBE_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.EFX_MWBESTATUS_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.EFX_NMSDC_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.EFX_WBENC_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.EFX_CA_PUC_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.EFX_TX_HUB_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.EFX_GSAX_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.EFX_CALTRANS_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.EFX_EDU_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.EFX_MI_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.EFX_ANC_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.AT_CERTLEV1_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.AT_CERTLEV2_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.AT_CERTLEV3_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.AT_CERTLEV4_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.AT_CERTLEV5_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.AT_CERTLEV6_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.AT_CERTLEV7_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.AT_CERTLEV8_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.AT_CERTLEV9_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.AT_CERTLEV10_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.AT_CERTEXP1_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.AT_CERTEXP2_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.AT_CERTEXP3_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.AT_CERTEXP4_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.AT_CERTEXP5_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.AT_CERTEXP6_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.AT_CERTEXP7_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.AT_CERTEXP8_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.AT_CERTEXP9_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.AT_CERTEXP10_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.EFX_EXTRACT_DATE_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.EFX_MERCHANT_ID_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.EFX_PROJECT_ID_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.EFX_FOREIGN_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.Record_Update_Refresh_Date_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.EFX_DATE_CREATED_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.normcompany_type_Invalid,le.normaddress_type_Invalid,le.norm_state_Invalid,le.norm_zip_Invalid,le.norm_zip4_Invalid,le.EFX_NAME_Invalid,le.EFX_LEGAL_NAME_Invalid,le.EFX_ADDRESS_Invalid,le.EFX_BUSSTATCD_Invalid,le.EFX_CMSA_Invalid,le.EFX_CORPAMOUNTCD_Invalid,le.EFX_CORPAMOUNTPREC_Invalid,le.EFX_CORPAMOUNTTP_Invalid,le.EFX_CORPEMPCD_Invalid,le.EFX_CTRYISOCD_Invalid,le.EFX_CTRYNUM_Invalid,le.EFX_CTRYTELCD_Invalid,le.EFX_GEOPREC_Invalid,le.EFX_MERCTYPE_Invalid,le.EFX_MRKT_TELESCORE_Invalid,le.EFX_MRKT_TOTALIND_Invalid,le.EFX_MRKT_TOTALSCORE_Invalid,le.EFX_PUBLIC_Invalid,le.EFX_STKEXC_Invalid,le.EFX_PRIMSIC_Invalid,le.EFX_SECSIC1_Invalid,le.EFX_SECSIC2_Invalid,le.EFX_SECSIC3_Invalid,le.EFX_SECSIC4_Invalid,le.EFX_ID_Invalid,le.EFX_CITY_Invalid,le.EFX_CTRYNAME_Invalid,le.EFX_SOHO_Invalid,le.EFX_BIZ_Invalid,le.EFX_RES_Invalid,le.EFX_CMRA_Invalid,le.EFX_SECGEOPREC_Invalid,le.EFX_SECCTRYISOCD_Invalid,le.EFX_SECCTRYNUM_Invalid,le.EFX_PHONE_Invalid,le.EFX_FAXPHONE_Invalid,le.EFX_YREST_Invalid,le.EFX_CORPEMPCNT_Invalid,le.EFX_LOCEMPCNT_Invalid,le.EFX_LOCEMPCD_Invalid,le.EFX_CORPAMOUNT_Invalid,le.EFX_LOCAMOUNT_Invalid,le.EFX_LOCAMOUNTCD_Invalid,le.EFX_LOCAMOUNTTP_Invalid,le.EFX_LOCAMOUNTPREC_Invalid,le.EFX_PRIMNAICSCODE_Invalid,le.EFX_SECNAICS1_Invalid,le.EFX_SECNAICS2_Invalid,le.EFX_SECNAICS3_Invalid,le.EFX_SECNAICS4_Invalid,le.EFX_DEAD_Invalid,le.EFX_DEADDT_Invalid,le.EFX_MRKT_TELEVER_Invalid,le.EFX_MRKT_VACANT_Invalid,le.EFX_MRKT_SEASONAL_Invalid,le.EFX_MBE_Invalid,le.EFX_WBE_Invalid,le.EFX_MWBE_Invalid,le.EFX_SDB_Invalid,le.EFX_HUBZONE_Invalid,le.EFX_DBE_Invalid,le.EFX_VET_Invalid,le.EFX_DVET_Invalid,le.EFX_8a_Invalid,le.EFX_8aEXPDT_Invalid,le.EFX_DIS_Invalid,le.EFX_SBE_Invalid,le.EFX_BUSSIZE_Invalid,le.EFX_LBE_Invalid,le.EFX_GOV_Invalid,le.EFX_FGOV_Invalid,le.EFX_NONPROFIT_Invalid,le.EFX_HBCU_Invalid,le.EFX_GAYLESBIAN_Invalid,le.EFX_WSBE_Invalid,le.EFX_VSBE_Invalid,le.EFX_DVSBE_Invalid,le.EFX_MWBESTATUS_Invalid,le.EFX_NMSDC_Invalid,le.EFX_WBENC_Invalid,le.EFX_CA_PUC_Invalid,le.EFX_TX_HUB_Invalid,le.EFX_GSAX_Invalid,le.EFX_CALTRANS_Invalid,le.EFX_EDU_Invalid,le.EFX_MI_Invalid,le.EFX_ANC_Invalid,le.AT_CERTLEV1_Invalid,le.AT_CERTLEV2_Invalid,le.AT_CERTLEV3_Invalid,le.AT_CERTLEV4_Invalid,le.AT_CERTLEV5_Invalid,le.AT_CERTLEV6_Invalid,le.AT_CERTLEV7_Invalid,le.AT_CERTLEV8_Invalid,le.AT_CERTLEV9_Invalid,le.AT_CERTLEV10_Invalid,le.AT_CERTEXP1_Invalid,le.AT_CERTEXP2_Invalid,le.AT_CERTEXP3_Invalid,le.AT_CERTEXP4_Invalid,le.AT_CERTEXP5_Invalid,le.AT_CERTEXP6_Invalid,le.AT_CERTEXP7_Invalid,le.AT_CERTEXP8_Invalid,le.AT_CERTEXP9_Invalid,le.AT_CERTEXP10_Invalid,le.EFX_EXTRACT_DATE_Invalid,le.EFX_MERCHANT_ID_Invalid,le.EFX_PROJECT_ID_Invalid,le.EFX_FOREIGN_Invalid,le.Record_Update_Refresh_Date_Invalid,le.EFX_DATE_CREATED_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Input_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Input_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Input_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Input_Fields.InvalidMessage_process_date(le.process_date_Invalid),Input_Fields.InvalidMessage_record_type(le.record_type_Invalid),Input_Fields.InvalidMessage_normcompany_type(le.normcompany_type_Invalid),Input_Fields.InvalidMessage_normaddress_type(le.normaddress_type_Invalid),Input_Fields.InvalidMessage_norm_state(le.norm_state_Invalid),Input_Fields.InvalidMessage_norm_zip(le.norm_zip_Invalid),Input_Fields.InvalidMessage_norm_zip4(le.norm_zip4_Invalid),Input_Fields.InvalidMessage_EFX_NAME(le.EFX_NAME_Invalid),Input_Fields.InvalidMessage_EFX_LEGAL_NAME(le.EFX_LEGAL_NAME_Invalid),Input_Fields.InvalidMessage_EFX_ADDRESS(le.EFX_ADDRESS_Invalid),Input_Fields.InvalidMessage_EFX_BUSSTATCD(le.EFX_BUSSTATCD_Invalid),Input_Fields.InvalidMessage_EFX_CMSA(le.EFX_CMSA_Invalid),Input_Fields.InvalidMessage_EFX_CORPAMOUNTCD(le.EFX_CORPAMOUNTCD_Invalid),Input_Fields.InvalidMessage_EFX_CORPAMOUNTPREC(le.EFX_CORPAMOUNTPREC_Invalid),Input_Fields.InvalidMessage_EFX_CORPAMOUNTTP(le.EFX_CORPAMOUNTTP_Invalid),Input_Fields.InvalidMessage_EFX_CORPEMPCD(le.EFX_CORPEMPCD_Invalid),Input_Fields.InvalidMessage_EFX_CTRYISOCD(le.EFX_CTRYISOCD_Invalid),Input_Fields.InvalidMessage_EFX_CTRYNUM(le.EFX_CTRYNUM_Invalid),Input_Fields.InvalidMessage_EFX_CTRYTELCD(le.EFX_CTRYTELCD_Invalid),Input_Fields.InvalidMessage_EFX_GEOPREC(le.EFX_GEOPREC_Invalid),Input_Fields.InvalidMessage_EFX_MERCTYPE(le.EFX_MERCTYPE_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_TELESCORE(le.EFX_MRKT_TELESCORE_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_TOTALIND(le.EFX_MRKT_TOTALIND_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_TOTALSCORE(le.EFX_MRKT_TOTALSCORE_Invalid),Input_Fields.InvalidMessage_EFX_PUBLIC(le.EFX_PUBLIC_Invalid),Input_Fields.InvalidMessage_EFX_STKEXC(le.EFX_STKEXC_Invalid),Input_Fields.InvalidMessage_EFX_PRIMSIC(le.EFX_PRIMSIC_Invalid),Input_Fields.InvalidMessage_EFX_SECSIC1(le.EFX_SECSIC1_Invalid),Input_Fields.InvalidMessage_EFX_SECSIC2(le.EFX_SECSIC2_Invalid),Input_Fields.InvalidMessage_EFX_SECSIC3(le.EFX_SECSIC3_Invalid),Input_Fields.InvalidMessage_EFX_SECSIC4(le.EFX_SECSIC4_Invalid),Input_Fields.InvalidMessage_EFX_ID(le.EFX_ID_Invalid),Input_Fields.InvalidMessage_EFX_CITY(le.EFX_CITY_Invalid),Input_Fields.InvalidMessage_EFX_CTRYNAME(le.EFX_CTRYNAME_Invalid),Input_Fields.InvalidMessage_EFX_SOHO(le.EFX_SOHO_Invalid),Input_Fields.InvalidMessage_EFX_BIZ(le.EFX_BIZ_Invalid),Input_Fields.InvalidMessage_EFX_RES(le.EFX_RES_Invalid),Input_Fields.InvalidMessage_EFX_CMRA(le.EFX_CMRA_Invalid),Input_Fields.InvalidMessage_EFX_SECGEOPREC(le.EFX_SECGEOPREC_Invalid),Input_Fields.InvalidMessage_EFX_SECCTRYISOCD(le.EFX_SECCTRYISOCD_Invalid),Input_Fields.InvalidMessage_EFX_SECCTRYNUM(le.EFX_SECCTRYNUM_Invalid),Input_Fields.InvalidMessage_EFX_PHONE(le.EFX_PHONE_Invalid),Input_Fields.InvalidMessage_EFX_FAXPHONE(le.EFX_FAXPHONE_Invalid),Input_Fields.InvalidMessage_EFX_YREST(le.EFX_YREST_Invalid),Input_Fields.InvalidMessage_EFX_CORPEMPCNT(le.EFX_CORPEMPCNT_Invalid),Input_Fields.InvalidMessage_EFX_LOCEMPCNT(le.EFX_LOCEMPCNT_Invalid),Input_Fields.InvalidMessage_EFX_LOCEMPCD(le.EFX_LOCEMPCD_Invalid),Input_Fields.InvalidMessage_EFX_CORPAMOUNT(le.EFX_CORPAMOUNT_Invalid),Input_Fields.InvalidMessage_EFX_LOCAMOUNT(le.EFX_LOCAMOUNT_Invalid),Input_Fields.InvalidMessage_EFX_LOCAMOUNTCD(le.EFX_LOCAMOUNTCD_Invalid),Input_Fields.InvalidMessage_EFX_LOCAMOUNTTP(le.EFX_LOCAMOUNTTP_Invalid),Input_Fields.InvalidMessage_EFX_LOCAMOUNTPREC(le.EFX_LOCAMOUNTPREC_Invalid),Input_Fields.InvalidMessage_EFX_PRIMNAICSCODE(le.EFX_PRIMNAICSCODE_Invalid),Input_Fields.InvalidMessage_EFX_SECNAICS1(le.EFX_SECNAICS1_Invalid),Input_Fields.InvalidMessage_EFX_SECNAICS2(le.EFX_SECNAICS2_Invalid),Input_Fields.InvalidMessage_EFX_SECNAICS3(le.EFX_SECNAICS3_Invalid),Input_Fields.InvalidMessage_EFX_SECNAICS4(le.EFX_SECNAICS4_Invalid),Input_Fields.InvalidMessage_EFX_DEAD(le.EFX_DEAD_Invalid),Input_Fields.InvalidMessage_EFX_DEADDT(le.EFX_DEADDT_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_TELEVER(le.EFX_MRKT_TELEVER_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_VACANT(le.EFX_MRKT_VACANT_Invalid),Input_Fields.InvalidMessage_EFX_MRKT_SEASONAL(le.EFX_MRKT_SEASONAL_Invalid),Input_Fields.InvalidMessage_EFX_MBE(le.EFX_MBE_Invalid),Input_Fields.InvalidMessage_EFX_WBE(le.EFX_WBE_Invalid),Input_Fields.InvalidMessage_EFX_MWBE(le.EFX_MWBE_Invalid),Input_Fields.InvalidMessage_EFX_SDB(le.EFX_SDB_Invalid),Input_Fields.InvalidMessage_EFX_HUBZONE(le.EFX_HUBZONE_Invalid),Input_Fields.InvalidMessage_EFX_DBE(le.EFX_DBE_Invalid),Input_Fields.InvalidMessage_EFX_VET(le.EFX_VET_Invalid),Input_Fields.InvalidMessage_EFX_DVET(le.EFX_DVET_Invalid),Input_Fields.InvalidMessage_EFX_8a(le.EFX_8a_Invalid),Input_Fields.InvalidMessage_EFX_8aEXPDT(le.EFX_8aEXPDT_Invalid),Input_Fields.InvalidMessage_EFX_DIS(le.EFX_DIS_Invalid),Input_Fields.InvalidMessage_EFX_SBE(le.EFX_SBE_Invalid),Input_Fields.InvalidMessage_EFX_BUSSIZE(le.EFX_BUSSIZE_Invalid),Input_Fields.InvalidMessage_EFX_LBE(le.EFX_LBE_Invalid),Input_Fields.InvalidMessage_EFX_GOV(le.EFX_GOV_Invalid),Input_Fields.InvalidMessage_EFX_FGOV(le.EFX_FGOV_Invalid),Input_Fields.InvalidMessage_EFX_NONPROFIT(le.EFX_NONPROFIT_Invalid),Input_Fields.InvalidMessage_EFX_HBCU(le.EFX_HBCU_Invalid),Input_Fields.InvalidMessage_EFX_GAYLESBIAN(le.EFX_GAYLESBIAN_Invalid),Input_Fields.InvalidMessage_EFX_WSBE(le.EFX_WSBE_Invalid),Input_Fields.InvalidMessage_EFX_VSBE(le.EFX_VSBE_Invalid),Input_Fields.InvalidMessage_EFX_DVSBE(le.EFX_DVSBE_Invalid),Input_Fields.InvalidMessage_EFX_MWBESTATUS(le.EFX_MWBESTATUS_Invalid),Input_Fields.InvalidMessage_EFX_NMSDC(le.EFX_NMSDC_Invalid),Input_Fields.InvalidMessage_EFX_WBENC(le.EFX_WBENC_Invalid),Input_Fields.InvalidMessage_EFX_CA_PUC(le.EFX_CA_PUC_Invalid),Input_Fields.InvalidMessage_EFX_TX_HUB(le.EFX_TX_HUB_Invalid),Input_Fields.InvalidMessage_EFX_GSAX(le.EFX_GSAX_Invalid),Input_Fields.InvalidMessage_EFX_CALTRANS(le.EFX_CALTRANS_Invalid),Input_Fields.InvalidMessage_EFX_EDU(le.EFX_EDU_Invalid),Input_Fields.InvalidMessage_EFX_MI(le.EFX_MI_Invalid),Input_Fields.InvalidMessage_EFX_ANC(le.EFX_ANC_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV1(le.AT_CERTLEV1_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV2(le.AT_CERTLEV2_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV3(le.AT_CERTLEV3_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV4(le.AT_CERTLEV4_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV5(le.AT_CERTLEV5_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV6(le.AT_CERTLEV6_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV7(le.AT_CERTLEV7_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV8(le.AT_CERTLEV8_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV9(le.AT_CERTLEV9_Invalid),Input_Fields.InvalidMessage_AT_CERTLEV10(le.AT_CERTLEV10_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP1(le.AT_CERTEXP1_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP2(le.AT_CERTEXP2_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP3(le.AT_CERTEXP3_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP4(le.AT_CERTEXP4_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP5(le.AT_CERTEXP5_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP6(le.AT_CERTEXP6_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP7(le.AT_CERTEXP7_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP8(le.AT_CERTEXP8_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP9(le.AT_CERTEXP9_Invalid),Input_Fields.InvalidMessage_AT_CERTEXP10(le.AT_CERTEXP10_Invalid),Input_Fields.InvalidMessage_EFX_EXTRACT_DATE(le.EFX_EXTRACT_DATE_Invalid),Input_Fields.InvalidMessage_EFX_MERCHANT_ID(le.EFX_MERCHANT_ID_Invalid),Input_Fields.InvalidMessage_EFX_PROJECT_ID(le.EFX_PROJECT_ID_Invalid),Input_Fields.InvalidMessage_EFX_FOREIGN(le.EFX_FOREIGN_Invalid),Input_Fields.InvalidMessage_Record_Update_Refresh_Date(le.Record_Update_Refresh_Date_Invalid),Input_Fields.InvalidMessage_EFX_DATE_CREATED(le.EFX_DATE_CREATED_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
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
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','normcompany_type','normaddress_type','norm_state','norm_zip','norm_zip4','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','EFX_BUSSTATCD','EFX_CMSA','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTPREC','EFX_CORPAMOUNTTP','EFX_CORPEMPCD','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYTELCD','EFX_GEOPREC','EFX_MERCTYPE','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALIND','EFX_MRKT_TOTALSCORE','EFX_PUBLIC','EFX_STKEXC','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_ID','EFX_CITY','EFX_CTRYNAME','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_SECGEOPREC','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_PHONE','EFX_FAXPHONE','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_NONPROFIT','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_reformated_date','invalid_record_type','invalid_norm_type','invalid_address_type_code','invalid_st','invalid_zip5','invalid_zip4','invalid_name','invalid_legal_name','invalid_mandatory','invalid_busstatcd','invalid_cmsa','invalid_corpamountcd','invalid_corpamountprec','invalid_corpamounttp','invalid_corpempcd','invalid_ctryisocd','invalid_ctrynum','invalid_ctrytelcd','invalid_geoprec','invalid_merctype','invalid_mrkt_telescore','invalid_mrkt_totalind','invalid_mrkt_totalscore','invalid_public','invalid_stkexc','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_numeric','invalid_mandatory','invalid_mandatory','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_geoprec','invalid_ctryisocd','invalid_ctrynum','invalid_phone','invalid_phone','invalid_year_established','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpempcd','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_corpamountcd','invalid_corpamounttp','invalid_corpamountprec','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_yes_blank','invalid_past_date','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_general_date','invalid_yes_blank','invalid_yes_blank','invalid_business_size','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_cert_or_class','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_yes_blank','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_cert_or_class','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_general_date','invalid_past_date','invalid_numeric','invalid_numeric_or_blank','invalid_yes_blank','invalid_past_date','invalid_date_created','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.dt_first_seen,(SALT37.StrType)le.dt_last_seen,(SALT37.StrType)le.dt_vendor_first_reported,(SALT37.StrType)le.dt_vendor_last_reported,(SALT37.StrType)le.process_date,(SALT37.StrType)le.record_type,(SALT37.StrType)le.normcompany_type,(SALT37.StrType)le.normaddress_type,(SALT37.StrType)le.norm_state,(SALT37.StrType)le.norm_zip,(SALT37.StrType)le.norm_zip4,(SALT37.StrType)le.EFX_NAME,(SALT37.StrType)le.EFX_LEGAL_NAME,(SALT37.StrType)le.EFX_ADDRESS,(SALT37.StrType)le.EFX_BUSSTATCD,(SALT37.StrType)le.EFX_CMSA,(SALT37.StrType)le.EFX_CORPAMOUNTCD,(SALT37.StrType)le.EFX_CORPAMOUNTPREC,(SALT37.StrType)le.EFX_CORPAMOUNTTP,(SALT37.StrType)le.EFX_CORPEMPCD,(SALT37.StrType)le.EFX_CTRYISOCD,(SALT37.StrType)le.EFX_CTRYNUM,(SALT37.StrType)le.EFX_CTRYTELCD,(SALT37.StrType)le.EFX_GEOPREC,(SALT37.StrType)le.EFX_MERCTYPE,(SALT37.StrType)le.EFX_MRKT_TELESCORE,(SALT37.StrType)le.EFX_MRKT_TOTALIND,(SALT37.StrType)le.EFX_MRKT_TOTALSCORE,(SALT37.StrType)le.EFX_PUBLIC,(SALT37.StrType)le.EFX_STKEXC,(SALT37.StrType)le.EFX_PRIMSIC,(SALT37.StrType)le.EFX_SECSIC1,(SALT37.StrType)le.EFX_SECSIC2,(SALT37.StrType)le.EFX_SECSIC3,(SALT37.StrType)le.EFX_SECSIC4,(SALT37.StrType)le.EFX_ID,(SALT37.StrType)le.EFX_CITY,(SALT37.StrType)le.EFX_CTRYNAME,(SALT37.StrType)le.EFX_SOHO,(SALT37.StrType)le.EFX_BIZ,(SALT37.StrType)le.EFX_RES,(SALT37.StrType)le.EFX_CMRA,(SALT37.StrType)le.EFX_SECGEOPREC,(SALT37.StrType)le.EFX_SECCTRYISOCD,(SALT37.StrType)le.EFX_SECCTRYNUM,(SALT37.StrType)le.EFX_PHONE,(SALT37.StrType)le.EFX_FAXPHONE,(SALT37.StrType)le.EFX_YREST,(SALT37.StrType)le.EFX_CORPEMPCNT,(SALT37.StrType)le.EFX_LOCEMPCNT,(SALT37.StrType)le.EFX_LOCEMPCD,(SALT37.StrType)le.EFX_CORPAMOUNT,(SALT37.StrType)le.EFX_LOCAMOUNT,(SALT37.StrType)le.EFX_LOCAMOUNTCD,(SALT37.StrType)le.EFX_LOCAMOUNTTP,(SALT37.StrType)le.EFX_LOCAMOUNTPREC,(SALT37.StrType)le.EFX_PRIMNAICSCODE,(SALT37.StrType)le.EFX_SECNAICS1,(SALT37.StrType)le.EFX_SECNAICS2,(SALT37.StrType)le.EFX_SECNAICS3,(SALT37.StrType)le.EFX_SECNAICS4,(SALT37.StrType)le.EFX_DEAD,(SALT37.StrType)le.EFX_DEADDT,(SALT37.StrType)le.EFX_MRKT_TELEVER,(SALT37.StrType)le.EFX_MRKT_VACANT,(SALT37.StrType)le.EFX_MRKT_SEASONAL,(SALT37.StrType)le.EFX_MBE,(SALT37.StrType)le.EFX_WBE,(SALT37.StrType)le.EFX_MWBE,(SALT37.StrType)le.EFX_SDB,(SALT37.StrType)le.EFX_HUBZONE,(SALT37.StrType)le.EFX_DBE,(SALT37.StrType)le.EFX_VET,(SALT37.StrType)le.EFX_DVET,(SALT37.StrType)le.EFX_8a,(SALT37.StrType)le.EFX_8aEXPDT,(SALT37.StrType)le.EFX_DIS,(SALT37.StrType)le.EFX_SBE,(SALT37.StrType)le.EFX_BUSSIZE,(SALT37.StrType)le.EFX_LBE,(SALT37.StrType)le.EFX_GOV,(SALT37.StrType)le.EFX_FGOV,(SALT37.StrType)le.EFX_NONPROFIT,(SALT37.StrType)le.EFX_HBCU,(SALT37.StrType)le.EFX_GAYLESBIAN,(SALT37.StrType)le.EFX_WSBE,(SALT37.StrType)le.EFX_VSBE,(SALT37.StrType)le.EFX_DVSBE,(SALT37.StrType)le.EFX_MWBESTATUS,(SALT37.StrType)le.EFX_NMSDC,(SALT37.StrType)le.EFX_WBENC,(SALT37.StrType)le.EFX_CA_PUC,(SALT37.StrType)le.EFX_TX_HUB,(SALT37.StrType)le.EFX_GSAX,(SALT37.StrType)le.EFX_CALTRANS,(SALT37.StrType)le.EFX_EDU,(SALT37.StrType)le.EFX_MI,(SALT37.StrType)le.EFX_ANC,(SALT37.StrType)le.AT_CERTLEV1,(SALT37.StrType)le.AT_CERTLEV2,(SALT37.StrType)le.AT_CERTLEV3,(SALT37.StrType)le.AT_CERTLEV4,(SALT37.StrType)le.AT_CERTLEV5,(SALT37.StrType)le.AT_CERTLEV6,(SALT37.StrType)le.AT_CERTLEV7,(SALT37.StrType)le.AT_CERTLEV8,(SALT37.StrType)le.AT_CERTLEV9,(SALT37.StrType)le.AT_CERTLEV10,(SALT37.StrType)le.AT_CERTEXP1,(SALT37.StrType)le.AT_CERTEXP2,(SALT37.StrType)le.AT_CERTEXP3,(SALT37.StrType)le.AT_CERTEXP4,(SALT37.StrType)le.AT_CERTEXP5,(SALT37.StrType)le.AT_CERTEXP6,(SALT37.StrType)le.AT_CERTEXP7,(SALT37.StrType)le.AT_CERTEXP8,(SALT37.StrType)le.AT_CERTEXP9,(SALT37.StrType)le.AT_CERTEXP10,(SALT37.StrType)le.EFX_EXTRACT_DATE,(SALT37.StrType)le.EFX_MERCHANT_ID,(SALT37.StrType)le.EFX_PROJECT_ID,(SALT37.StrType)le.EFX_FOREIGN,(SALT37.StrType)le.Record_Update_Refresh_Date,(SALT37.StrType)le.EFX_DATE_CREATED,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,124,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
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
          ,Input_Fields.InvalidMessage_dt_first_seen(1)
          ,Input_Fields.InvalidMessage_dt_last_seen(1)
          ,Input_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Input_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Input_Fields.InvalidMessage_process_date(1)
          ,Input_Fields.InvalidMessage_record_type(1)
          ,Input_Fields.InvalidMessage_normcompany_type(1)
          ,Input_Fields.InvalidMessage_normaddress_type(1)
          ,Input_Fields.InvalidMessage_norm_state(1)
          ,Input_Fields.InvalidMessage_norm_zip(1)
          ,Input_Fields.InvalidMessage_norm_zip4(1)
          ,Input_Fields.InvalidMessage_EFX_NAME(1)
          ,Input_Fields.InvalidMessage_EFX_LEGAL_NAME(1)
          ,Input_Fields.InvalidMessage_EFX_ADDRESS(1)
          ,Input_Fields.InvalidMessage_EFX_BUSSTATCD(1)
          ,Input_Fields.InvalidMessage_EFX_CMSA(1)
          ,Input_Fields.InvalidMessage_EFX_CORPAMOUNTCD(1)
          ,Input_Fields.InvalidMessage_EFX_CORPAMOUNTPREC(1)
          ,Input_Fields.InvalidMessage_EFX_CORPAMOUNTTP(1)
          ,Input_Fields.InvalidMessage_EFX_CORPEMPCD(1)
          ,Input_Fields.InvalidMessage_EFX_CTRYISOCD(1)
          ,Input_Fields.InvalidMessage_EFX_CTRYNUM(1)
          ,Input_Fields.InvalidMessage_EFX_CTRYTELCD(1)
          ,Input_Fields.InvalidMessage_EFX_GEOPREC(1)
          ,Input_Fields.InvalidMessage_EFX_MERCTYPE(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_TELESCORE(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_TOTALIND(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_TOTALSCORE(1)
          ,Input_Fields.InvalidMessage_EFX_PUBLIC(1)
          ,Input_Fields.InvalidMessage_EFX_STKEXC(1)
          ,Input_Fields.InvalidMessage_EFX_PRIMSIC(1)
          ,Input_Fields.InvalidMessage_EFX_SECSIC1(1)
          ,Input_Fields.InvalidMessage_EFX_SECSIC2(1)
          ,Input_Fields.InvalidMessage_EFX_SECSIC3(1)
          ,Input_Fields.InvalidMessage_EFX_SECSIC4(1)
          ,Input_Fields.InvalidMessage_EFX_ID(1)
          ,Input_Fields.InvalidMessage_EFX_CITY(1)
          ,Input_Fields.InvalidMessage_EFX_CTRYNAME(1)
          ,Input_Fields.InvalidMessage_EFX_SOHO(1)
          ,Input_Fields.InvalidMessage_EFX_BIZ(1)
          ,Input_Fields.InvalidMessage_EFX_RES(1)
          ,Input_Fields.InvalidMessage_EFX_CMRA(1)
          ,Input_Fields.InvalidMessage_EFX_SECGEOPREC(1)
          ,Input_Fields.InvalidMessage_EFX_SECCTRYISOCD(1)
          ,Input_Fields.InvalidMessage_EFX_SECCTRYNUM(1)
          ,Input_Fields.InvalidMessage_EFX_PHONE(1)
          ,Input_Fields.InvalidMessage_EFX_FAXPHONE(1)
          ,Input_Fields.InvalidMessage_EFX_YREST(1)
          ,Input_Fields.InvalidMessage_EFX_CORPEMPCNT(1)
          ,Input_Fields.InvalidMessage_EFX_LOCEMPCNT(1)
          ,Input_Fields.InvalidMessage_EFX_LOCEMPCD(1)
          ,Input_Fields.InvalidMessage_EFX_CORPAMOUNT(1)
          ,Input_Fields.InvalidMessage_EFX_LOCAMOUNT(1)
          ,Input_Fields.InvalidMessage_EFX_LOCAMOUNTCD(1)
          ,Input_Fields.InvalidMessage_EFX_LOCAMOUNTTP(1)
          ,Input_Fields.InvalidMessage_EFX_LOCAMOUNTPREC(1)
          ,Input_Fields.InvalidMessage_EFX_PRIMNAICSCODE(1)
          ,Input_Fields.InvalidMessage_EFX_SECNAICS1(1)
          ,Input_Fields.InvalidMessage_EFX_SECNAICS2(1)
          ,Input_Fields.InvalidMessage_EFX_SECNAICS3(1)
          ,Input_Fields.InvalidMessage_EFX_SECNAICS4(1)
          ,Input_Fields.InvalidMessage_EFX_DEAD(1)
          ,Input_Fields.InvalidMessage_EFX_DEADDT(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_TELEVER(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_VACANT(1)
          ,Input_Fields.InvalidMessage_EFX_MRKT_SEASONAL(1)
          ,Input_Fields.InvalidMessage_EFX_MBE(1)
          ,Input_Fields.InvalidMessage_EFX_WBE(1)
          ,Input_Fields.InvalidMessage_EFX_MWBE(1)
          ,Input_Fields.InvalidMessage_EFX_SDB(1)
          ,Input_Fields.InvalidMessage_EFX_HUBZONE(1)
          ,Input_Fields.InvalidMessage_EFX_DBE(1)
          ,Input_Fields.InvalidMessage_EFX_VET(1)
          ,Input_Fields.InvalidMessage_EFX_DVET(1)
          ,Input_Fields.InvalidMessage_EFX_8a(1)
          ,Input_Fields.InvalidMessage_EFX_8aEXPDT(1)
          ,Input_Fields.InvalidMessage_EFX_DIS(1)
          ,Input_Fields.InvalidMessage_EFX_SBE(1)
          ,Input_Fields.InvalidMessage_EFX_BUSSIZE(1)
          ,Input_Fields.InvalidMessage_EFX_LBE(1)
          ,Input_Fields.InvalidMessage_EFX_GOV(1)
          ,Input_Fields.InvalidMessage_EFX_FGOV(1)
          ,Input_Fields.InvalidMessage_EFX_NONPROFIT(1)
          ,Input_Fields.InvalidMessage_EFX_HBCU(1)
          ,Input_Fields.InvalidMessage_EFX_GAYLESBIAN(1)
          ,Input_Fields.InvalidMessage_EFX_WSBE(1)
          ,Input_Fields.InvalidMessage_EFX_VSBE(1)
          ,Input_Fields.InvalidMessage_EFX_DVSBE(1)
          ,Input_Fields.InvalidMessage_EFX_MWBESTATUS(1)
          ,Input_Fields.InvalidMessage_EFX_NMSDC(1)
          ,Input_Fields.InvalidMessage_EFX_WBENC(1)
          ,Input_Fields.InvalidMessage_EFX_CA_PUC(1)
          ,Input_Fields.InvalidMessage_EFX_TX_HUB(1)
          ,Input_Fields.InvalidMessage_EFX_GSAX(1)
          ,Input_Fields.InvalidMessage_EFX_CALTRANS(1)
          ,Input_Fields.InvalidMessage_EFX_EDU(1)
          ,Input_Fields.InvalidMessage_EFX_MI(1)
          ,Input_Fields.InvalidMessage_EFX_ANC(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV1(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV2(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV3(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV4(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV5(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV6(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV7(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV8(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV9(1)
          ,Input_Fields.InvalidMessage_AT_CERTLEV10(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP1(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP2(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP3(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP4(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP5(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP6(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP7(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP8(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP9(1)
          ,Input_Fields.InvalidMessage_AT_CERTEXP10(1)
          ,Input_Fields.InvalidMessage_EFX_EXTRACT_DATE(1)
          ,Input_Fields.InvalidMessage_EFX_MERCHANT_ID(1)
          ,Input_Fields.InvalidMessage_EFX_PROJECT_ID(1)
          ,Input_Fields.InvalidMessage_EFX_FOREIGN(1)
          ,Input_Fields.InvalidMessage_Record_Update_Refresh_Date(1)
          ,Input_Fields.InvalidMessage_EFX_DATE_CREATED(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
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
    SummaryInfo := NORMALIZE(SummaryStats,124,Into(LEFT,COUNTER));
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
