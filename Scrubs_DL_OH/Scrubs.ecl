IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_OH; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_OH)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 dbkoln_Invalid;
    UNSIGNED1 pinss4_Invalid;
    UNSIGNED1 dvnlic_Invalid;
    UNSIGNED1 dvccls_Invalid;
    UNSIGNED1 dvctyp_Invalid;
    UNSIGNED1 pifdon_Invalid;
    UNSIGNED1 pichcl_Invalid;
    UNSIGNED1 picecl_Invalid;
    UNSIGNED1 piqwgt_Invalid;
    UNSIGNED1 pinhft_Invalid;
    UNSIGNED1 pinhin_Invalid;
    UNSIGNED1 picsex_Invalid;
    UNSIGNED1 dvddoi_Invalid;
    UNSIGNED1 dvc2pl_Invalid;
    UNSIGNED1 dvdexp_Invalid;
    UNSIGNED1 drnagy_Invalid;
    UNSIGNED1 dvfocd_Invalid;
    UNSIGNED1 dvfopd_Invalid;
    UNSIGNED1 dvnapp_Invalid;
    UNSIGNED1 dvcatt_Invalid;
    UNSIGNED1 dvdnov_Invalid;
    UNSIGNED1 dvcded_Invalid;
    UNSIGNED1 dvcgrs_Invalid;
    UNSIGNED1 dvfdup_Invalid;
    UNSIGNED1 dvcgen_Invalid;
    UNSIGNED1 dvflsd_Invalid;
    UNSIGNED1 dvqdup_Invalid;
    UNSIGNED1 dvfohr_Invalid;
    UNSIGNED1 dbkmtk_Invalid;
    UNSIGNED1 dvfrcs_Invalid;
    UNSIGNED1 dvnwbi_Invalid;
    UNSIGNED1 sycpgm_Invalid;
    UNSIGNED1 sytda1_Invalid;
    UNSIGNED1 sycuid_Invalid;
    UNSIGNED1 dvffrd_Invalid;
    UNSIGNED1 dvctsa_Invalid;
    UNSIGNED1 dvcsce_Invalid;
    UNSIGNED1 dvdmce_Invalid;
    UNSIGNED1 pigcty_Invalid;
    UNSIGNED1 pigsta_Invalid;
    UNSIGNED1 pigzip_Invalid;
    UNSIGNED1 pincnt_Invalid;
    UNSIGNED1 pidd01_Invalid;
    UNSIGNED1 piddod_Invalid;
    UNSIGNED1 pidaup_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 cleaning_score_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_OH)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_In_OH) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT35.StrType)le.process_date);
    SELF.dbkoln_Invalid := Fields.InValid_dbkoln((SALT35.StrType)le.dbkoln);
    SELF.pinss4_Invalid := Fields.InValid_pinss4((SALT35.StrType)le.pinss4);
    SELF.dvnlic_Invalid := Fields.InValid_dvnlic((SALT35.StrType)le.dvnlic);
    SELF.dvccls_Invalid := Fields.InValid_dvccls((SALT35.StrType)le.dvccls);
    SELF.dvctyp_Invalid := Fields.InValid_dvctyp((SALT35.StrType)le.dvctyp);
    SELF.pifdon_Invalid := Fields.InValid_pifdon((SALT35.StrType)le.pifdon);
    SELF.pichcl_Invalid := Fields.InValid_pichcl((SALT35.StrType)le.pichcl);
    SELF.picecl_Invalid := Fields.InValid_picecl((SALT35.StrType)le.picecl);
    SELF.piqwgt_Invalid := Fields.InValid_piqwgt((SALT35.StrType)le.piqwgt);
    SELF.pinhft_Invalid := Fields.InValid_pinhft((SALT35.StrType)le.pinhft,(SALT35.StrType)le.pinhin);
    SELF.pinhin_Invalid := Fields.InValid_pinhin((SALT35.StrType)le.pinhin);
    SELF.picsex_Invalid := Fields.InValid_picsex((SALT35.StrType)le.picsex);
    SELF.dvddoi_Invalid := Fields.InValid_dvddoi((SALT35.StrType)le.dvddoi);
    SELF.dvc2pl_Invalid := Fields.InValid_dvc2pl((SALT35.StrType)le.dvc2pl);
    SELF.dvdexp_Invalid := Fields.InValid_dvdexp((SALT35.StrType)le.dvdexp);
    SELF.drnagy_Invalid := Fields.InValid_drnagy((SALT35.StrType)le.drnagy);
    SELF.dvfocd_Invalid := Fields.InValid_dvfocd((SALT35.StrType)le.dvfocd);
    SELF.dvfopd_Invalid := Fields.InValid_dvfopd((SALT35.StrType)le.dvfopd);
    SELF.dvnapp_Invalid := Fields.InValid_dvnapp((SALT35.StrType)le.dvnapp);
    SELF.dvcatt_Invalid := Fields.InValid_dvcatt((SALT35.StrType)le.dvcatt);
    SELF.dvdnov_Invalid := Fields.InValid_dvdnov((SALT35.StrType)le.dvdnov);
    SELF.dvcded_Invalid := Fields.InValid_dvcded((SALT35.StrType)le.dvcded);
    SELF.dvcgrs_Invalid := Fields.InValid_dvcgrs((SALT35.StrType)le.dvcgrs);
    SELF.dvfdup_Invalid := Fields.InValid_dvfdup((SALT35.StrType)le.dvfdup);
    SELF.dvcgen_Invalid := Fields.InValid_dvcgen((SALT35.StrType)le.dvcgen);
    SELF.dvflsd_Invalid := Fields.InValid_dvflsd((SALT35.StrType)le.dvflsd);
    SELF.dvqdup_Invalid := Fields.InValid_dvqdup((SALT35.StrType)le.dvqdup);
    SELF.dvfohr_Invalid := Fields.InValid_dvfohr((SALT35.StrType)le.dvfohr);
    SELF.dbkmtk_Invalid := Fields.InValid_dbkmtk((SALT35.StrType)le.dbkmtk);
    SELF.dvfrcs_Invalid := Fields.InValid_dvfrcs((SALT35.StrType)le.dvfrcs);
    SELF.dvnwbi_Invalid := Fields.InValid_dvnwbi((SALT35.StrType)le.dvnwbi);
    SELF.sycpgm_Invalid := Fields.InValid_sycpgm((SALT35.StrType)le.sycpgm);
    SELF.sytda1_Invalid := Fields.InValid_sytda1((SALT35.StrType)le.sytda1);
    SELF.sycuid_Invalid := Fields.InValid_sycuid((SALT35.StrType)le.sycuid);
    SELF.dvffrd_Invalid := Fields.InValid_dvffrd((SALT35.StrType)le.dvffrd);
    SELF.dvctsa_Invalid := Fields.InValid_dvctsa((SALT35.StrType)le.dvctsa);
    SELF.dvcsce_Invalid := Fields.InValid_dvcsce((SALT35.StrType)le.dvcsce);
    SELF.dvdmce_Invalid := Fields.InValid_dvdmce((SALT35.StrType)le.dvdmce);
    SELF.pigcty_Invalid := Fields.InValid_pigcty((SALT35.StrType)le.pigcty);
    SELF.pigsta_Invalid := Fields.InValid_pigsta((SALT35.StrType)le.pigsta);
    SELF.pigzip_Invalid := Fields.InValid_pigzip((SALT35.StrType)le.pigzip);
    SELF.pincnt_Invalid := Fields.InValid_pincnt((SALT35.StrType)le.pincnt);
    SELF.pidd01_Invalid := Fields.InValid_pidd01((SALT35.StrType)le.pidd01);
    SELF.piddod_Invalid := Fields.InValid_piddod((SALT35.StrType)le.piddod);
    SELF.pidaup_Invalid := Fields.InValid_pidaup((SALT35.StrType)le.pidaup);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname);
    SELF.cleaning_score_Invalid := Fields.InValid_cleaning_score((SALT35.StrType)le.cleaning_score);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_OH);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.dbkoln_Invalid << 2 ) + ( le.pinss4_Invalid << 4 ) + ( le.dvnlic_Invalid << 6 ) + ( le.dvccls_Invalid << 7 ) + ( le.dvctyp_Invalid << 8 ) + ( le.pifdon_Invalid << 9 ) + ( le.pichcl_Invalid << 10 ) + ( le.picecl_Invalid << 11 ) + ( le.piqwgt_Invalid << 12 ) + ( le.pinhft_Invalid << 13 ) + ( le.pinhin_Invalid << 14 ) + ( le.picsex_Invalid << 15 ) + ( le.dvddoi_Invalid << 16 ) + ( le.dvc2pl_Invalid << 18 ) + ( le.dvdexp_Invalid << 19 ) + ( le.drnagy_Invalid << 21 ) + ( le.dvfocd_Invalid << 23 ) + ( le.dvfopd_Invalid << 24 ) + ( le.dvnapp_Invalid << 25 ) + ( le.dvcatt_Invalid << 26 ) + ( le.dvdnov_Invalid << 28 ) + ( le.dvcded_Invalid << 30 ) + ( le.dvcgrs_Invalid << 31 ) + ( le.dvfdup_Invalid << 32 ) + ( le.dvcgen_Invalid << 33 ) + ( le.dvflsd_Invalid << 34 ) + ( le.dvqdup_Invalid << 35 ) + ( le.dvfohr_Invalid << 36 ) + ( le.dbkmtk_Invalid << 37 ) + ( le.dvfrcs_Invalid << 39 ) + ( le.dvnwbi_Invalid << 40 ) + ( le.sycpgm_Invalid << 42 ) + ( le.sytda1_Invalid << 43 ) + ( le.sycuid_Invalid << 45 ) + ( le.dvffrd_Invalid << 46 ) + ( le.dvctsa_Invalid << 47 ) + ( le.dvcsce_Invalid << 48 ) + ( le.dvdmce_Invalid << 49 ) + ( le.pigcty_Invalid << 51 ) + ( le.pigsta_Invalid << 52 ) + ( le.pigzip_Invalid << 53 ) + ( le.pincnt_Invalid << 55 ) + ( le.pidd01_Invalid << 56 ) + ( le.piddod_Invalid << 58 ) + ( le.pidaup_Invalid << 60 ) + ( le.lname_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.cleaning_score_Invalid << 0 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_OH);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dbkoln_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.pinss4_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dvnlic_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dvccls_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.dvctyp_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.pifdon_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.pichcl_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.picecl_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.piqwgt_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.pinhft_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.pinhin_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.picsex_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.dvddoi_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.dvc2pl_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.dvdexp_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.drnagy_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.dvfocd_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.dvfopd_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.dvnapp_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dvcatt_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.dvdnov_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.dvcded_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.dvcgrs_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.dvfdup_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.dvcgen_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.dvflsd_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.dvqdup_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.dvfohr_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.dbkmtk_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.dvfrcs_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.dvnwbi_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.sycpgm_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.sytda1_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.sycuid_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.dvffrd_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.dvctsa_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.dvcsce_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.dvdmce_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.pigcty_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.pigsta_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.pigzip_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.pincnt_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.pidd01_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.piddod_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.pidaup_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.cleaning_score_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    dbkoln_ALLOW_ErrorCount := COUNT(GROUP,h.dbkoln_Invalid=1);
    dbkoln_LENGTH_ErrorCount := COUNT(GROUP,h.dbkoln_Invalid=2);
    dbkoln_Total_ErrorCount := COUNT(GROUP,h.dbkoln_Invalid>0);
    pinss4_ALLOW_ErrorCount := COUNT(GROUP,h.pinss4_Invalid=1);
    pinss4_LENGTH_ErrorCount := COUNT(GROUP,h.pinss4_Invalid=2);
    pinss4_Total_ErrorCount := COUNT(GROUP,h.pinss4_Invalid>0);
    dvnlic_CUSTOM_ErrorCount := COUNT(GROUP,h.dvnlic_Invalid=1);
    dvccls_CUSTOM_ErrorCount := COUNT(GROUP,h.dvccls_Invalid=1);
    dvctyp_CUSTOM_ErrorCount := COUNT(GROUP,h.dvctyp_Invalid=1);
    pifdon_CUSTOM_ErrorCount := COUNT(GROUP,h.pifdon_Invalid=1);
    pichcl_CUSTOM_ErrorCount := COUNT(GROUP,h.pichcl_Invalid=1);
    picecl_CUSTOM_ErrorCount := COUNT(GROUP,h.picecl_Invalid=1);
    piqwgt_CUSTOM_ErrorCount := COUNT(GROUP,h.piqwgt_Invalid=1);
    pinhft_CUSTOM_ErrorCount := COUNT(GROUP,h.pinhft_Invalid=1);
    pinhin_ALLOW_ErrorCount := COUNT(GROUP,h.pinhin_Invalid=1);
    picsex_ENUM_ErrorCount := COUNT(GROUP,h.picsex_Invalid=1);
    dvddoi_CUSTOM_ErrorCount := COUNT(GROUP,h.dvddoi_Invalid=1);
    dvddoi_LENGTH_ErrorCount := COUNT(GROUP,h.dvddoi_Invalid=2);
    dvddoi_Total_ErrorCount := COUNT(GROUP,h.dvddoi_Invalid>0);
    dvc2pl_ENUM_ErrorCount := COUNT(GROUP,h.dvc2pl_Invalid=1);
    dvdexp_CUSTOM_ErrorCount := COUNT(GROUP,h.dvdexp_Invalid=1);
    dvdexp_LENGTH_ErrorCount := COUNT(GROUP,h.dvdexp_Invalid=2);
    dvdexp_Total_ErrorCount := COUNT(GROUP,h.dvdexp_Invalid>0);
    drnagy_ALLOW_ErrorCount := COUNT(GROUP,h.drnagy_Invalid=1);
    drnagy_LENGTH_ErrorCount := COUNT(GROUP,h.drnagy_Invalid=2);
    drnagy_Total_ErrorCount := COUNT(GROUP,h.drnagy_Invalid>0);
    dvfocd_ENUM_ErrorCount := COUNT(GROUP,h.dvfocd_Invalid=1);
    dvfopd_ENUM_ErrorCount := COUNT(GROUP,h.dvfopd_Invalid=1);
    dvnapp_CUSTOM_ErrorCount := COUNT(GROUP,h.dvnapp_Invalid=1);
    dvcatt_CUSTOM_ErrorCount := COUNT(GROUP,h.dvcatt_Invalid=1);
    dvcatt_LENGTH_ErrorCount := COUNT(GROUP,h.dvcatt_Invalid=2);
    dvcatt_Total_ErrorCount := COUNT(GROUP,h.dvcatt_Invalid>0);
    dvdnov_CUSTOM_ErrorCount := COUNT(GROUP,h.dvdnov_Invalid=1);
    dvdnov_LENGTH_ErrorCount := COUNT(GROUP,h.dvdnov_Invalid=2);
    dvdnov_Total_ErrorCount := COUNT(GROUP,h.dvdnov_Invalid>0);
    dvcded_ENUM_ErrorCount := COUNT(GROUP,h.dvcded_Invalid=1);
    dvcgrs_ALLOW_ErrorCount := COUNT(GROUP,h.dvcgrs_Invalid=1);
    dvfdup_ENUM_ErrorCount := COUNT(GROUP,h.dvfdup_Invalid=1);
    dvcgen_ALLOW_ErrorCount := COUNT(GROUP,h.dvcgen_Invalid=1);
    dvflsd_ENUM_ErrorCount := COUNT(GROUP,h.dvflsd_Invalid=1);
    dvqdup_ENUM_ErrorCount := COUNT(GROUP,h.dvqdup_Invalid=1);
    dvfohr_ENUM_ErrorCount := COUNT(GROUP,h.dvfohr_Invalid=1);
    dbkmtk_ALLOW_ErrorCount := COUNT(GROUP,h.dbkmtk_Invalid=1);
    dbkmtk_LENGTH_ErrorCount := COUNT(GROUP,h.dbkmtk_Invalid=2);
    dbkmtk_Total_ErrorCount := COUNT(GROUP,h.dbkmtk_Invalid>0);
    dvfrcs_ENUM_ErrorCount := COUNT(GROUP,h.dvfrcs_Invalid=1);
    dvnwbi_ALLOW_ErrorCount := COUNT(GROUP,h.dvnwbi_Invalid=1);
    dvnwbi_LENGTH_ErrorCount := COUNT(GROUP,h.dvnwbi_Invalid=2);
    dvnwbi_Total_ErrorCount := COUNT(GROUP,h.dvnwbi_Invalid>0);
    sycpgm_CUSTOM_ErrorCount := COUNT(GROUP,h.sycpgm_Invalid=1);
    sytda1_ALLOW_ErrorCount := COUNT(GROUP,h.sytda1_Invalid=1);
    sytda1_CUSTOM_ErrorCount := COUNT(GROUP,h.sytda1_Invalid=2);
    sytda1_LENGTH_ErrorCount := COUNT(GROUP,h.sytda1_Invalid=3);
    sytda1_Total_ErrorCount := COUNT(GROUP,h.sytda1_Invalid>0);
    sycuid_ALLOW_ErrorCount := COUNT(GROUP,h.sycuid_Invalid=1);
    dvffrd_ENUM_ErrorCount := COUNT(GROUP,h.dvffrd_Invalid=1);
    dvctsa_ENUM_ErrorCount := COUNT(GROUP,h.dvctsa_Invalid=1);
    dvcsce_ENUM_ErrorCount := COUNT(GROUP,h.dvcsce_Invalid=1);
    dvdmce_ALLOW_ErrorCount := COUNT(GROUP,h.dvdmce_Invalid=1);
    dvdmce_LENGTH_ErrorCount := COUNT(GROUP,h.dvdmce_Invalid=2);
    dvdmce_Total_ErrorCount := COUNT(GROUP,h.dvdmce_Invalid>0);
    pigcty_ALLOW_ErrorCount := COUNT(GROUP,h.pigcty_Invalid=1);
    pigsta_CUSTOM_ErrorCount := COUNT(GROUP,h.pigsta_Invalid=1);
    pigzip_ALLOW_ErrorCount := COUNT(GROUP,h.pigzip_Invalid=1);
    pigzip_LENGTH_ErrorCount := COUNT(GROUP,h.pigzip_Invalid=2);
    pigzip_Total_ErrorCount := COUNT(GROUP,h.pigzip_Invalid>0);
    pincnt_ALLOW_ErrorCount := COUNT(GROUP,h.pincnt_Invalid=1);
    pidd01_CUSTOM_ErrorCount := COUNT(GROUP,h.pidd01_Invalid=1);
    pidd01_LENGTH_ErrorCount := COUNT(GROUP,h.pidd01_Invalid=2);
    pidd01_Total_ErrorCount := COUNT(GROUP,h.pidd01_Invalid>0);
    piddod_CUSTOM_ErrorCount := COUNT(GROUP,h.piddod_Invalid=1);
    piddod_LENGTH_ErrorCount := COUNT(GROUP,h.piddod_Invalid=2);
    piddod_Total_ErrorCount := COUNT(GROUP,h.piddod_Invalid>0);
    pidaup_CUSTOM_ErrorCount := COUNT(GROUP,h.pidaup_Invalid=1);
    pidaup_LENGTH_ErrorCount := COUNT(GROUP,h.pidaup_Invalid=2);
    pidaup_Total_ErrorCount := COUNT(GROUP,h.pidaup_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    cleaning_score_ALLOW_ErrorCount := COUNT(GROUP,h.cleaning_score_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.dbkoln_Invalid,le.pinss4_Invalid,le.dvnlic_Invalid,le.dvccls_Invalid,le.dvctyp_Invalid,le.pifdon_Invalid,le.pichcl_Invalid,le.picecl_Invalid,le.piqwgt_Invalid,le.pinhft_Invalid,le.pinhin_Invalid,le.picsex_Invalid,le.dvddoi_Invalid,le.dvc2pl_Invalid,le.dvdexp_Invalid,le.drnagy_Invalid,le.dvfocd_Invalid,le.dvfopd_Invalid,le.dvnapp_Invalid,le.dvcatt_Invalid,le.dvdnov_Invalid,le.dvcded_Invalid,le.dvcgrs_Invalid,le.dvfdup_Invalid,le.dvcgen_Invalid,le.dvflsd_Invalid,le.dvqdup_Invalid,le.dvfohr_Invalid,le.dbkmtk_Invalid,le.dvfrcs_Invalid,le.dvnwbi_Invalid,le.sycpgm_Invalid,le.sytda1_Invalid,le.sycuid_Invalid,le.dvffrd_Invalid,le.dvctsa_Invalid,le.dvcsce_Invalid,le.dvdmce_Invalid,le.pigcty_Invalid,le.pigsta_Invalid,le.pigzip_Invalid,le.pincnt_Invalid,le.pidd01_Invalid,le.piddod_Invalid,le.pidaup_Invalid,le.lname_Invalid,le.cleaning_score_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_dbkoln(le.dbkoln_Invalid),Fields.InvalidMessage_pinss4(le.pinss4_Invalid),Fields.InvalidMessage_dvnlic(le.dvnlic_Invalid),Fields.InvalidMessage_dvccls(le.dvccls_Invalid),Fields.InvalidMessage_dvctyp(le.dvctyp_Invalid),Fields.InvalidMessage_pifdon(le.pifdon_Invalid),Fields.InvalidMessage_pichcl(le.pichcl_Invalid),Fields.InvalidMessage_picecl(le.picecl_Invalid),Fields.InvalidMessage_piqwgt(le.piqwgt_Invalid),Fields.InvalidMessage_pinhft(le.pinhft_Invalid),Fields.InvalidMessage_pinhin(le.pinhin_Invalid),Fields.InvalidMessage_picsex(le.picsex_Invalid),Fields.InvalidMessage_dvddoi(le.dvddoi_Invalid),Fields.InvalidMessage_dvc2pl(le.dvc2pl_Invalid),Fields.InvalidMessage_dvdexp(le.dvdexp_Invalid),Fields.InvalidMessage_drnagy(le.drnagy_Invalid),Fields.InvalidMessage_dvfocd(le.dvfocd_Invalid),Fields.InvalidMessage_dvfopd(le.dvfopd_Invalid),Fields.InvalidMessage_dvnapp(le.dvnapp_Invalid),Fields.InvalidMessage_dvcatt(le.dvcatt_Invalid),Fields.InvalidMessage_dvdnov(le.dvdnov_Invalid),Fields.InvalidMessage_dvcded(le.dvcded_Invalid),Fields.InvalidMessage_dvcgrs(le.dvcgrs_Invalid),Fields.InvalidMessage_dvfdup(le.dvfdup_Invalid),Fields.InvalidMessage_dvcgen(le.dvcgen_Invalid),Fields.InvalidMessage_dvflsd(le.dvflsd_Invalid),Fields.InvalidMessage_dvqdup(le.dvqdup_Invalid),Fields.InvalidMessage_dvfohr(le.dvfohr_Invalid),Fields.InvalidMessage_dbkmtk(le.dbkmtk_Invalid),Fields.InvalidMessage_dvfrcs(le.dvfrcs_Invalid),Fields.InvalidMessage_dvnwbi(le.dvnwbi_Invalid),Fields.InvalidMessage_sycpgm(le.sycpgm_Invalid),Fields.InvalidMessage_sytda1(le.sytda1_Invalid),Fields.InvalidMessage_sycuid(le.sycuid_Invalid),Fields.InvalidMessage_dvffrd(le.dvffrd_Invalid),Fields.InvalidMessage_dvctsa(le.dvctsa_Invalid),Fields.InvalidMessage_dvcsce(le.dvcsce_Invalid),Fields.InvalidMessage_dvdmce(le.dvdmce_Invalid),Fields.InvalidMessage_pigcty(le.pigcty_Invalid),Fields.InvalidMessage_pigsta(le.pigsta_Invalid),Fields.InvalidMessage_pigzip(le.pigzip_Invalid),Fields.InvalidMessage_pincnt(le.pincnt_Invalid),Fields.InvalidMessage_pidd01(le.pidd01_Invalid),Fields.InvalidMessage_piddod(le.piddod_Invalid),Fields.InvalidMessage_pidaup(le.pidaup_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_cleaning_score(le.cleaning_score_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dbkoln_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pinss4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvnlic_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dvccls_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dvctyp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pifdon_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pichcl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.picecl_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.piqwgt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pinhft_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pinhin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.picsex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvddoi_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvc2pl_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvdexp_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.drnagy_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvfocd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvfopd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvnapp_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dvcatt_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvdnov_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvcded_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvcgrs_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dvfdup_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvcgen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dvflsd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvqdup_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvfohr_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dbkmtk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dvfrcs_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvnwbi_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sycpgm_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sytda1_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.sycuid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dvffrd_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvctsa_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvcsce_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dvdmce_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pigcty_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pigsta_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pigzip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.pincnt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pidd01_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.piddod_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.pidaup_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.cleaning_score_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','dbkoln','pinss4','dvnlic','dvccls','dvctyp','pifdon','pichcl','picecl','piqwgt','pinhft','pinhin','picsex','dvddoi','dvc2pl','dvdexp','drnagy','dvfocd','dvfopd','dvnapp','dvcatt','dvdnov','dvcded','dvcgrs','dvfdup','dvcgen','dvflsd','dvqdup','dvfohr','dbkmtk','dvfrcs','dvnwbi','sycpgm','sytda1','sycuid','dvffrd','dvctsa','dvcsce','dvdmce','pigcty','pigsta','pigzip','pincnt','pidd01','piddod','pidaup','lname','cleaning_score','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_dbkoln','invalid_pinss4','invalid_dvnlic','invalid_dvccls','invalid_dvctyp','invalid_pifdon','invalid_pichcl','invalid_picecl','invalid_piqwgt','invalid_height','invalid_numeric','invalid_picsex','invalid_8pastdate','invalid_boolean_yn_empty','invalid_8generaldate','invalid_drnagy','invalid_dvfocd','invalid_boolean_yn_empty','invalid_dvnlic','invalid_dvcatt','invalid_08generaldate','invalid_dvcded','invalid_alpha_num','invalid_boolean_yn_empty','invalid_dvcgen','invalid_boolean_yn_empty','invalid_dvqdup','invalid_boolean_yn_empty','invalid_dbkmtk','invalid_boolean_yn_empty','invalid_dvnwbi','invalid_sycpgm','invalid_sytda1','invalid_alpha_num','invalid_boolean_yn_empty','invalid_dvctsa','invalid_dvcsce','invalid_dvdmce','invalid_alpha_num_specials','invalid_pigsta','invalid_pigzip','invalid_alpha_num_specials','invalid_8pastdate','invalid_08pastdate','invalid_08pastdate','invalid_name','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.process_date,(SALT35.StrType)le.dbkoln,(SALT35.StrType)le.pinss4,(SALT35.StrType)le.dvnlic,(SALT35.StrType)le.dvccls,(SALT35.StrType)le.dvctyp,(SALT35.StrType)le.pifdon,(SALT35.StrType)le.pichcl,(SALT35.StrType)le.picecl,(SALT35.StrType)le.piqwgt,(SALT35.StrType)le.pinhft,(SALT35.StrType)le.pinhin,(SALT35.StrType)le.picsex,(SALT35.StrType)le.dvddoi,(SALT35.StrType)le.dvc2pl,(SALT35.StrType)le.dvdexp,(SALT35.StrType)le.drnagy,(SALT35.StrType)le.dvfocd,(SALT35.StrType)le.dvfopd,(SALT35.StrType)le.dvnapp,(SALT35.StrType)le.dvcatt,(SALT35.StrType)le.dvdnov,(SALT35.StrType)le.dvcded,(SALT35.StrType)le.dvcgrs,(SALT35.StrType)le.dvfdup,(SALT35.StrType)le.dvcgen,(SALT35.StrType)le.dvflsd,(SALT35.StrType)le.dvqdup,(SALT35.StrType)le.dvfohr,(SALT35.StrType)le.dbkmtk,(SALT35.StrType)le.dvfrcs,(SALT35.StrType)le.dvnwbi,(SALT35.StrType)le.sycpgm,(SALT35.StrType)le.sytda1,(SALT35.StrType)le.sycuid,(SALT35.StrType)le.dvffrd,(SALT35.StrType)le.dvctsa,(SALT35.StrType)le.dvcsce,(SALT35.StrType)le.dvdmce,(SALT35.StrType)le.pigcty,(SALT35.StrType)le.pigsta,(SALT35.StrType)le.pigzip,(SALT35.StrType)le.pincnt,(SALT35.StrType)le.pidd01,(SALT35.StrType)le.piddod,(SALT35.StrType)le.pidaup,(SALT35.StrType)le.lname,(SALT35.StrType)le.cleaning_score,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,48,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTH'
          ,'dbkoln:invalid_dbkoln:ALLOW','dbkoln:invalid_dbkoln:LENGTH'
          ,'pinss4:invalid_pinss4:ALLOW','pinss4:invalid_pinss4:LENGTH'
          ,'dvnlic:invalid_dvnlic:CUSTOM'
          ,'dvccls:invalid_dvccls:CUSTOM'
          ,'dvctyp:invalid_dvctyp:CUSTOM'
          ,'pifdon:invalid_pifdon:CUSTOM'
          ,'pichcl:invalid_pichcl:CUSTOM'
          ,'picecl:invalid_picecl:CUSTOM'
          ,'piqwgt:invalid_piqwgt:CUSTOM'
          ,'pinhft:invalid_height:CUSTOM'
          ,'pinhin:invalid_numeric:ALLOW'
          ,'picsex:invalid_picsex:ENUM'
          ,'dvddoi:invalid_8pastdate:CUSTOM','dvddoi:invalid_8pastdate:LENGTH'
          ,'dvc2pl:invalid_boolean_yn_empty:ENUM'
          ,'dvdexp:invalid_8generaldate:CUSTOM','dvdexp:invalid_8generaldate:LENGTH'
          ,'drnagy:invalid_drnagy:ALLOW','drnagy:invalid_drnagy:LENGTH'
          ,'dvfocd:invalid_dvfocd:ENUM'
          ,'dvfopd:invalid_boolean_yn_empty:ENUM'
          ,'dvnapp:invalid_dvnlic:CUSTOM'
          ,'dvcatt:invalid_dvcatt:CUSTOM','dvcatt:invalid_dvcatt:LENGTH'
          ,'dvdnov:invalid_08generaldate:CUSTOM','dvdnov:invalid_08generaldate:LENGTH'
          ,'dvcded:invalid_dvcded:ENUM'
          ,'dvcgrs:invalid_alpha_num:ALLOW'
          ,'dvfdup:invalid_boolean_yn_empty:ENUM'
          ,'dvcgen:invalid_dvcgen:ALLOW'
          ,'dvflsd:invalid_boolean_yn_empty:ENUM'
          ,'dvqdup:invalid_dvqdup:ENUM'
          ,'dvfohr:invalid_boolean_yn_empty:ENUM'
          ,'dbkmtk:invalid_dbkmtk:ALLOW','dbkmtk:invalid_dbkmtk:LENGTH'
          ,'dvfrcs:invalid_boolean_yn_empty:ENUM'
          ,'dvnwbi:invalid_dvnwbi:ALLOW','dvnwbi:invalid_dvnwbi:LENGTH'
          ,'sycpgm:invalid_sycpgm:CUSTOM'
          ,'sytda1:invalid_sytda1:ALLOW','sytda1:invalid_sytda1:CUSTOM','sytda1:invalid_sytda1:LENGTH'
          ,'sycuid:invalid_alpha_num:ALLOW'
          ,'dvffrd:invalid_boolean_yn_empty:ENUM'
          ,'dvctsa:invalid_dvctsa:ENUM'
          ,'dvcsce:invalid_dvcsce:ENUM'
          ,'dvdmce:invalid_dvdmce:ALLOW','dvdmce:invalid_dvdmce:LENGTH'
          ,'pigcty:invalid_alpha_num_specials:ALLOW'
          ,'pigsta:invalid_pigsta:CUSTOM'
          ,'pigzip:invalid_pigzip:ALLOW','pigzip:invalid_pigzip:LENGTH'
          ,'pincnt:invalid_alpha_num_specials:ALLOW'
          ,'pidd01:invalid_8pastdate:CUSTOM','pidd01:invalid_8pastdate:LENGTH'
          ,'piddod:invalid_08pastdate:CUSTOM','piddod:invalid_08pastdate:LENGTH'
          ,'pidaup:invalid_08pastdate:CUSTOM','pidaup:invalid_08pastdate:LENGTH'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:CUSTOM'
          ,'cleaning_score:invalid_numeric:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_dbkoln(1),Fields.InvalidMessage_dbkoln(2)
          ,Fields.InvalidMessage_pinss4(1),Fields.InvalidMessage_pinss4(2)
          ,Fields.InvalidMessage_dvnlic(1)
          ,Fields.InvalidMessage_dvccls(1)
          ,Fields.InvalidMessage_dvctyp(1)
          ,Fields.InvalidMessage_pifdon(1)
          ,Fields.InvalidMessage_pichcl(1)
          ,Fields.InvalidMessage_picecl(1)
          ,Fields.InvalidMessage_piqwgt(1)
          ,Fields.InvalidMessage_pinhft(1)
          ,Fields.InvalidMessage_pinhin(1)
          ,Fields.InvalidMessage_picsex(1)
          ,Fields.InvalidMessage_dvddoi(1),Fields.InvalidMessage_dvddoi(2)
          ,Fields.InvalidMessage_dvc2pl(1)
          ,Fields.InvalidMessage_dvdexp(1),Fields.InvalidMessage_dvdexp(2)
          ,Fields.InvalidMessage_drnagy(1),Fields.InvalidMessage_drnagy(2)
          ,Fields.InvalidMessage_dvfocd(1)
          ,Fields.InvalidMessage_dvfopd(1)
          ,Fields.InvalidMessage_dvnapp(1)
          ,Fields.InvalidMessage_dvcatt(1),Fields.InvalidMessage_dvcatt(2)
          ,Fields.InvalidMessage_dvdnov(1),Fields.InvalidMessage_dvdnov(2)
          ,Fields.InvalidMessage_dvcded(1)
          ,Fields.InvalidMessage_dvcgrs(1)
          ,Fields.InvalidMessage_dvfdup(1)
          ,Fields.InvalidMessage_dvcgen(1)
          ,Fields.InvalidMessage_dvflsd(1)
          ,Fields.InvalidMessage_dvqdup(1)
          ,Fields.InvalidMessage_dvfohr(1)
          ,Fields.InvalidMessage_dbkmtk(1),Fields.InvalidMessage_dbkmtk(2)
          ,Fields.InvalidMessage_dvfrcs(1)
          ,Fields.InvalidMessage_dvnwbi(1),Fields.InvalidMessage_dvnwbi(2)
          ,Fields.InvalidMessage_sycpgm(1)
          ,Fields.InvalidMessage_sytda1(1),Fields.InvalidMessage_sytda1(2),Fields.InvalidMessage_sytda1(3)
          ,Fields.InvalidMessage_sycuid(1)
          ,Fields.InvalidMessage_dvffrd(1)
          ,Fields.InvalidMessage_dvctsa(1)
          ,Fields.InvalidMessage_dvcsce(1)
          ,Fields.InvalidMessage_dvdmce(1),Fields.InvalidMessage_dvdmce(2)
          ,Fields.InvalidMessage_pigcty(1)
          ,Fields.InvalidMessage_pigsta(1)
          ,Fields.InvalidMessage_pigzip(1),Fields.InvalidMessage_pigzip(2)
          ,Fields.InvalidMessage_pincnt(1)
          ,Fields.InvalidMessage_pidd01(1),Fields.InvalidMessage_pidd01(2)
          ,Fields.InvalidMessage_piddod(1),Fields.InvalidMessage_piddod(2)
          ,Fields.InvalidMessage_pidaup(1),Fields.InvalidMessage_pidaup(2)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3)
          ,Fields.InvalidMessage_cleaning_score(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.dbkoln_ALLOW_ErrorCount,le.dbkoln_LENGTH_ErrorCount
          ,le.pinss4_ALLOW_ErrorCount,le.pinss4_LENGTH_ErrorCount
          ,le.dvnlic_CUSTOM_ErrorCount
          ,le.dvccls_CUSTOM_ErrorCount
          ,le.dvctyp_CUSTOM_ErrorCount
          ,le.pifdon_CUSTOM_ErrorCount
          ,le.pichcl_CUSTOM_ErrorCount
          ,le.picecl_CUSTOM_ErrorCount
          ,le.piqwgt_CUSTOM_ErrorCount
          ,le.pinhft_CUSTOM_ErrorCount
          ,le.pinhin_ALLOW_ErrorCount
          ,le.picsex_ENUM_ErrorCount
          ,le.dvddoi_CUSTOM_ErrorCount,le.dvddoi_LENGTH_ErrorCount
          ,le.dvc2pl_ENUM_ErrorCount
          ,le.dvdexp_CUSTOM_ErrorCount,le.dvdexp_LENGTH_ErrorCount
          ,le.drnagy_ALLOW_ErrorCount,le.drnagy_LENGTH_ErrorCount
          ,le.dvfocd_ENUM_ErrorCount
          ,le.dvfopd_ENUM_ErrorCount
          ,le.dvnapp_CUSTOM_ErrorCount
          ,le.dvcatt_CUSTOM_ErrorCount,le.dvcatt_LENGTH_ErrorCount
          ,le.dvdnov_CUSTOM_ErrorCount,le.dvdnov_LENGTH_ErrorCount
          ,le.dvcded_ENUM_ErrorCount
          ,le.dvcgrs_ALLOW_ErrorCount
          ,le.dvfdup_ENUM_ErrorCount
          ,le.dvcgen_ALLOW_ErrorCount
          ,le.dvflsd_ENUM_ErrorCount
          ,le.dvqdup_ENUM_ErrorCount
          ,le.dvfohr_ENUM_ErrorCount
          ,le.dbkmtk_ALLOW_ErrorCount,le.dbkmtk_LENGTH_ErrorCount
          ,le.dvfrcs_ENUM_ErrorCount
          ,le.dvnwbi_ALLOW_ErrorCount,le.dvnwbi_LENGTH_ErrorCount
          ,le.sycpgm_CUSTOM_ErrorCount
          ,le.sytda1_ALLOW_ErrorCount,le.sytda1_CUSTOM_ErrorCount,le.sytda1_LENGTH_ErrorCount
          ,le.sycuid_ALLOW_ErrorCount
          ,le.dvffrd_ENUM_ErrorCount
          ,le.dvctsa_ENUM_ErrorCount
          ,le.dvcsce_ENUM_ErrorCount
          ,le.dvdmce_ALLOW_ErrorCount,le.dvdmce_LENGTH_ErrorCount
          ,le.pigcty_ALLOW_ErrorCount
          ,le.pigsta_CUSTOM_ErrorCount
          ,le.pigzip_ALLOW_ErrorCount,le.pigzip_LENGTH_ErrorCount
          ,le.pincnt_ALLOW_ErrorCount
          ,le.pidd01_CUSTOM_ErrorCount,le.pidd01_LENGTH_ErrorCount
          ,le.piddod_CUSTOM_ErrorCount,le.piddod_LENGTH_ErrorCount
          ,le.pidaup_CUSTOM_ErrorCount,le.pidaup_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.dbkoln_ALLOW_ErrorCount,le.dbkoln_LENGTH_ErrorCount
          ,le.pinss4_ALLOW_ErrorCount,le.pinss4_LENGTH_ErrorCount
          ,le.dvnlic_CUSTOM_ErrorCount
          ,le.dvccls_CUSTOM_ErrorCount
          ,le.dvctyp_CUSTOM_ErrorCount
          ,le.pifdon_CUSTOM_ErrorCount
          ,le.pichcl_CUSTOM_ErrorCount
          ,le.picecl_CUSTOM_ErrorCount
          ,le.piqwgt_CUSTOM_ErrorCount
          ,le.pinhft_CUSTOM_ErrorCount
          ,le.pinhin_ALLOW_ErrorCount
          ,le.picsex_ENUM_ErrorCount
          ,le.dvddoi_CUSTOM_ErrorCount,le.dvddoi_LENGTH_ErrorCount
          ,le.dvc2pl_ENUM_ErrorCount
          ,le.dvdexp_CUSTOM_ErrorCount,le.dvdexp_LENGTH_ErrorCount
          ,le.drnagy_ALLOW_ErrorCount,le.drnagy_LENGTH_ErrorCount
          ,le.dvfocd_ENUM_ErrorCount
          ,le.dvfopd_ENUM_ErrorCount
          ,le.dvnapp_CUSTOM_ErrorCount
          ,le.dvcatt_CUSTOM_ErrorCount,le.dvcatt_LENGTH_ErrorCount
          ,le.dvdnov_CUSTOM_ErrorCount,le.dvdnov_LENGTH_ErrorCount
          ,le.dvcded_ENUM_ErrorCount
          ,le.dvcgrs_ALLOW_ErrorCount
          ,le.dvfdup_ENUM_ErrorCount
          ,le.dvcgen_ALLOW_ErrorCount
          ,le.dvflsd_ENUM_ErrorCount
          ,le.dvqdup_ENUM_ErrorCount
          ,le.dvfohr_ENUM_ErrorCount
          ,le.dbkmtk_ALLOW_ErrorCount,le.dbkmtk_LENGTH_ErrorCount
          ,le.dvfrcs_ENUM_ErrorCount
          ,le.dvnwbi_ALLOW_ErrorCount,le.dvnwbi_LENGTH_ErrorCount
          ,le.sycpgm_CUSTOM_ErrorCount
          ,le.sytda1_ALLOW_ErrorCount,le.sytda1_CUSTOM_ErrorCount,le.sytda1_LENGTH_ErrorCount
          ,le.sycuid_ALLOW_ErrorCount
          ,le.dvffrd_ENUM_ErrorCount
          ,le.dvctsa_ENUM_ErrorCount
          ,le.dvcsce_ENUM_ErrorCount
          ,le.dvdmce_ALLOW_ErrorCount,le.dvdmce_LENGTH_ErrorCount
          ,le.pigcty_ALLOW_ErrorCount
          ,le.pigsta_CUSTOM_ErrorCount
          ,le.pigzip_ALLOW_ErrorCount,le.pigzip_LENGTH_ErrorCount
          ,le.pincnt_ALLOW_ErrorCount
          ,le.pidd01_CUSTOM_ErrorCount,le.pidd01_LENGTH_ErrorCount
          ,le.piddod_CUSTOM_ErrorCount,le.piddod_LENGTH_ErrorCount
          ,le.pidaup_CUSTOM_ErrorCount,le.pidaup_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,67,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
