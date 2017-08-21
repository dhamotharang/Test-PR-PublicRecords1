import ut,SALT26;
export hygiene(dataset(layout_DOT_Base) h) := MODULE
 
//A simple summary record
export Summary(SALT26.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_cnp_number_pcnt := AVE(GROUP,IF(h.cnp_number = (TYPEOF(h.cnp_number))'',0,100));
    maxlength_cnp_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_number)));
    avelength_cnp_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_number)),h.cnp_number<>(typeof(h.cnp_number))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_active_enterprise_number_pcnt := AVE(GROUP,IF(h.active_enterprise_number = (TYPEOF(h.active_enterprise_number))'',0,100));
    maxlength_active_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.active_enterprise_number)));
    avelength_active_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.active_enterprise_number)),h.active_enterprise_number<>(typeof(h.active_enterprise_number))'');
    populated_MN_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MN_foreign_corp_key = (TYPEOF(h.MN_foreign_corp_key))'',0,100));
    maxlength_MN_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MN_foreign_corp_key)));
    avelength_MN_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MN_foreign_corp_key)),h.MN_foreign_corp_key<>(typeof(h.MN_foreign_corp_key))'');
    populated_NJ_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NJ_foreign_corp_key = (TYPEOF(h.NJ_foreign_corp_key))'',0,100));
    maxlength_NJ_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NJ_foreign_corp_key)));
    avelength_NJ_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NJ_foreign_corp_key)),h.NJ_foreign_corp_key<>(typeof(h.NJ_foreign_corp_key))'');
    populated_active_duns_number_pcnt := AVE(GROUP,IF(h.active_duns_number = (TYPEOF(h.active_duns_number))'',0,100));
    maxlength_active_duns_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.active_duns_number)));
    avelength_active_duns_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.active_duns_number)),h.active_duns_number<>(typeof(h.active_duns_number))'');
    populated_hist_enterprise_number_pcnt := AVE(GROUP,IF(h.hist_enterprise_number = (TYPEOF(h.hist_enterprise_number))'',0,100));
    maxlength_hist_enterprise_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.hist_enterprise_number)));
    avelength_hist_enterprise_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.hist_enterprise_number)),h.hist_enterprise_number<>(typeof(h.hist_enterprise_number))'');
    populated_hist_duns_number_pcnt := AVE(GROUP,IF(h.hist_duns_number = (TYPEOF(h.hist_duns_number))'',0,100));
    maxlength_hist_duns_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.hist_duns_number)));
    avelength_hist_duns_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.hist_duns_number)),h.hist_duns_number<>(typeof(h.hist_duns_number))'');
    populated_ebr_file_number_pcnt := AVE(GROUP,IF(h.ebr_file_number = (TYPEOF(h.ebr_file_number))'',0,100));
    maxlength_ebr_file_number := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.ebr_file_number)));
    avelength_ebr_file_number := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.ebr_file_number)),h.ebr_file_number<>(typeof(h.ebr_file_number))'');
    populated_AR_foreign_corp_key_pcnt := AVE(GROUP,IF(h.AR_foreign_corp_key = (TYPEOF(h.AR_foreign_corp_key))'',0,100));
    maxlength_AR_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.AR_foreign_corp_key)));
    avelength_AR_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.AR_foreign_corp_key)),h.AR_foreign_corp_key<>(typeof(h.AR_foreign_corp_key))'');
    populated_CA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.CA_foreign_corp_key = (TYPEOF(h.CA_foreign_corp_key))'',0,100));
    maxlength_CA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.CA_foreign_corp_key)));
    avelength_CA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.CA_foreign_corp_key)),h.CA_foreign_corp_key<>(typeof(h.CA_foreign_corp_key))'');
    populated_CO_foreign_corp_key_pcnt := AVE(GROUP,IF(h.CO_foreign_corp_key = (TYPEOF(h.CO_foreign_corp_key))'',0,100));
    maxlength_CO_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.CO_foreign_corp_key)));
    avelength_CO_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.CO_foreign_corp_key)),h.CO_foreign_corp_key<>(typeof(h.CO_foreign_corp_key))'');
    populated_DC_foreign_corp_key_pcnt := AVE(GROUP,IF(h.DC_foreign_corp_key = (TYPEOF(h.DC_foreign_corp_key))'',0,100));
    maxlength_DC_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.DC_foreign_corp_key)));
    avelength_DC_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.DC_foreign_corp_key)),h.DC_foreign_corp_key<>(typeof(h.DC_foreign_corp_key))'');
    populated_KS_foreign_corp_key_pcnt := AVE(GROUP,IF(h.KS_foreign_corp_key = (TYPEOF(h.KS_foreign_corp_key))'',0,100));
    maxlength_KS_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.KS_foreign_corp_key)));
    avelength_KS_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.KS_foreign_corp_key)),h.KS_foreign_corp_key<>(typeof(h.KS_foreign_corp_key))'');
    populated_KY_foreign_corp_key_pcnt := AVE(GROUP,IF(h.KY_foreign_corp_key = (TYPEOF(h.KY_foreign_corp_key))'',0,100));
    maxlength_KY_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.KY_foreign_corp_key)));
    avelength_KY_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.KY_foreign_corp_key)),h.KY_foreign_corp_key<>(typeof(h.KY_foreign_corp_key))'');
    populated_MA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MA_foreign_corp_key = (TYPEOF(h.MA_foreign_corp_key))'',0,100));
    maxlength_MA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MA_foreign_corp_key)));
    avelength_MA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MA_foreign_corp_key)),h.MA_foreign_corp_key<>(typeof(h.MA_foreign_corp_key))'');
    populated_MD_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MD_foreign_corp_key = (TYPEOF(h.MD_foreign_corp_key))'',0,100));
    maxlength_MD_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MD_foreign_corp_key)));
    avelength_MD_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MD_foreign_corp_key)),h.MD_foreign_corp_key<>(typeof(h.MD_foreign_corp_key))'');
    populated_ME_foreign_corp_key_pcnt := AVE(GROUP,IF(h.ME_foreign_corp_key = (TYPEOF(h.ME_foreign_corp_key))'',0,100));
    maxlength_ME_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.ME_foreign_corp_key)));
    avelength_ME_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.ME_foreign_corp_key)),h.ME_foreign_corp_key<>(typeof(h.ME_foreign_corp_key))'');
    populated_MI_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MI_foreign_corp_key = (TYPEOF(h.MI_foreign_corp_key))'',0,100));
    maxlength_MI_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MI_foreign_corp_key)));
    avelength_MI_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MI_foreign_corp_key)),h.MI_foreign_corp_key<>(typeof(h.MI_foreign_corp_key))'');
    populated_MO_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MO_foreign_corp_key = (TYPEOF(h.MO_foreign_corp_key))'',0,100));
    maxlength_MO_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MO_foreign_corp_key)));
    avelength_MO_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MO_foreign_corp_key)),h.MO_foreign_corp_key<>(typeof(h.MO_foreign_corp_key))'');
    populated_NC_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NC_foreign_corp_key = (TYPEOF(h.NC_foreign_corp_key))'',0,100));
    maxlength_NC_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NC_foreign_corp_key)));
    avelength_NC_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NC_foreign_corp_key)),h.NC_foreign_corp_key<>(typeof(h.NC_foreign_corp_key))'');
    populated_ND_foreign_corp_key_pcnt := AVE(GROUP,IF(h.ND_foreign_corp_key = (TYPEOF(h.ND_foreign_corp_key))'',0,100));
    maxlength_ND_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.ND_foreign_corp_key)));
    avelength_ND_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.ND_foreign_corp_key)),h.ND_foreign_corp_key<>(typeof(h.ND_foreign_corp_key))'');
    populated_NM_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NM_foreign_corp_key = (TYPEOF(h.NM_foreign_corp_key))'',0,100));
    maxlength_NM_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NM_foreign_corp_key)));
    avelength_NM_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NM_foreign_corp_key)),h.NM_foreign_corp_key<>(typeof(h.NM_foreign_corp_key))'');
    populated_OK_foreign_corp_key_pcnt := AVE(GROUP,IF(h.OK_foreign_corp_key = (TYPEOF(h.OK_foreign_corp_key))'',0,100));
    maxlength_OK_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.OK_foreign_corp_key)));
    avelength_OK_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.OK_foreign_corp_key)),h.OK_foreign_corp_key<>(typeof(h.OK_foreign_corp_key))'');
    populated_PA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.PA_foreign_corp_key = (TYPEOF(h.PA_foreign_corp_key))'',0,100));
    maxlength_PA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.PA_foreign_corp_key)));
    avelength_PA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.PA_foreign_corp_key)),h.PA_foreign_corp_key<>(typeof(h.PA_foreign_corp_key))'');
    populated_SC_foreign_corp_key_pcnt := AVE(GROUP,IF(h.SC_foreign_corp_key = (TYPEOF(h.SC_foreign_corp_key))'',0,100));
    maxlength_SC_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.SC_foreign_corp_key)));
    avelength_SC_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.SC_foreign_corp_key)),h.SC_foreign_corp_key<>(typeof(h.SC_foreign_corp_key))'');
    populated_SD_foreign_corp_key_pcnt := AVE(GROUP,IF(h.SD_foreign_corp_key = (TYPEOF(h.SD_foreign_corp_key))'',0,100));
    maxlength_SD_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.SD_foreign_corp_key)));
    avelength_SD_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.SD_foreign_corp_key)),h.SD_foreign_corp_key<>(typeof(h.SD_foreign_corp_key))'');
    populated_TN_foreign_corp_key_pcnt := AVE(GROUP,IF(h.TN_foreign_corp_key = (TYPEOF(h.TN_foreign_corp_key))'',0,100));
    maxlength_TN_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.TN_foreign_corp_key)));
    avelength_TN_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.TN_foreign_corp_key)),h.TN_foreign_corp_key<>(typeof(h.TN_foreign_corp_key))'');
    populated_VT_foreign_corp_key_pcnt := AVE(GROUP,IF(h.VT_foreign_corp_key = (TYPEOF(h.VT_foreign_corp_key))'',0,100));
    maxlength_VT_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.VT_foreign_corp_key)));
    avelength_VT_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.VT_foreign_corp_key)),h.VT_foreign_corp_key<>(typeof(h.VT_foreign_corp_key))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_domestic_corp_key_pcnt := AVE(GROUP,IF(h.domestic_corp_key = (TYPEOF(h.domestic_corp_key))'',0,100));
    maxlength_domestic_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.domestic_corp_key)));
    avelength_domestic_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.domestic_corp_key)),h.domestic_corp_key<>(typeof(h.domestic_corp_key))'');
    populated_AL_foreign_corp_key_pcnt := AVE(GROUP,IF(h.AL_foreign_corp_key = (TYPEOF(h.AL_foreign_corp_key))'',0,100));
    maxlength_AL_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.AL_foreign_corp_key)));
    avelength_AL_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.AL_foreign_corp_key)),h.AL_foreign_corp_key<>(typeof(h.AL_foreign_corp_key))'');
    populated_FL_foreign_corp_key_pcnt := AVE(GROUP,IF(h.FL_foreign_corp_key = (TYPEOF(h.FL_foreign_corp_key))'',0,100));
    maxlength_FL_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.FL_foreign_corp_key)));
    avelength_FL_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.FL_foreign_corp_key)),h.FL_foreign_corp_key<>(typeof(h.FL_foreign_corp_key))'');
    populated_GA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.GA_foreign_corp_key = (TYPEOF(h.GA_foreign_corp_key))'',0,100));
    maxlength_GA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.GA_foreign_corp_key)));
    avelength_GA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.GA_foreign_corp_key)),h.GA_foreign_corp_key<>(typeof(h.GA_foreign_corp_key))'');
    populated_IL_foreign_corp_key_pcnt := AVE(GROUP,IF(h.IL_foreign_corp_key = (TYPEOF(h.IL_foreign_corp_key))'',0,100));
    maxlength_IL_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.IL_foreign_corp_key)));
    avelength_IL_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.IL_foreign_corp_key)),h.IL_foreign_corp_key<>(typeof(h.IL_foreign_corp_key))'');
    populated_IN_foreign_corp_key_pcnt := AVE(GROUP,IF(h.IN_foreign_corp_key = (TYPEOF(h.IN_foreign_corp_key))'',0,100));
    maxlength_IN_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.IN_foreign_corp_key)));
    avelength_IN_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.IN_foreign_corp_key)),h.IN_foreign_corp_key<>(typeof(h.IN_foreign_corp_key))'');
    populated_MS_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MS_foreign_corp_key = (TYPEOF(h.MS_foreign_corp_key))'',0,100));
    maxlength_MS_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MS_foreign_corp_key)));
    avelength_MS_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MS_foreign_corp_key)),h.MS_foreign_corp_key<>(typeof(h.MS_foreign_corp_key))'');
    populated_NH_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NH_foreign_corp_key = (TYPEOF(h.NH_foreign_corp_key))'',0,100));
    maxlength_NH_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NH_foreign_corp_key)));
    avelength_NH_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NH_foreign_corp_key)),h.NH_foreign_corp_key<>(typeof(h.NH_foreign_corp_key))'');
    populated_NV_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NV_foreign_corp_key = (TYPEOF(h.NV_foreign_corp_key))'',0,100));
    maxlength_NV_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NV_foreign_corp_key)));
    avelength_NV_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NV_foreign_corp_key)),h.NV_foreign_corp_key<>(typeof(h.NV_foreign_corp_key))'');
    populated_NY_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NY_foreign_corp_key = (TYPEOF(h.NY_foreign_corp_key))'',0,100));
    maxlength_NY_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NY_foreign_corp_key)));
    avelength_NY_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NY_foreign_corp_key)),h.NY_foreign_corp_key<>(typeof(h.NY_foreign_corp_key))'');
    populated_OR_foreign_corp_key_pcnt := AVE(GROUP,IF(h.OR_foreign_corp_key = (TYPEOF(h.OR_foreign_corp_key))'',0,100));
    maxlength_OR_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.OR_foreign_corp_key)));
    avelength_OR_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.OR_foreign_corp_key)),h.OR_foreign_corp_key<>(typeof(h.OR_foreign_corp_key))'');
    populated_RI_foreign_corp_key_pcnt := AVE(GROUP,IF(h.RI_foreign_corp_key = (TYPEOF(h.RI_foreign_corp_key))'',0,100));
    maxlength_RI_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.RI_foreign_corp_key)));
    avelength_RI_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.RI_foreign_corp_key)),h.RI_foreign_corp_key<>(typeof(h.RI_foreign_corp_key))'');
    populated_UT_foreign_corp_key_pcnt := AVE(GROUP,IF(h.UT_foreign_corp_key = (TYPEOF(h.UT_foreign_corp_key))'',0,100));
    maxlength_UT_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.UT_foreign_corp_key)));
    avelength_UT_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.UT_foreign_corp_key)),h.UT_foreign_corp_key<>(typeof(h.UT_foreign_corp_key))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_cnp_name_pcnt := AVE(GROUP,IF(h.cnp_name = (TYPEOF(h.cnp_name))'',0,100));
    maxlength_cnp_name := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_name)));
    avelength_cnp_name := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_name)),h.cnp_name<>(typeof(h.cnp_name))'');
    populated_AK_foreign_corp_key_pcnt := AVE(GROUP,IF(h.AK_foreign_corp_key = (TYPEOF(h.AK_foreign_corp_key))'',0,100));
    maxlength_AK_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.AK_foreign_corp_key)));
    avelength_AK_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.AK_foreign_corp_key)),h.AK_foreign_corp_key<>(typeof(h.AK_foreign_corp_key))'');
    populated_CT_foreign_corp_key_pcnt := AVE(GROUP,IF(h.CT_foreign_corp_key = (TYPEOF(h.CT_foreign_corp_key))'',0,100));
    maxlength_CT_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.CT_foreign_corp_key)));
    avelength_CT_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.CT_foreign_corp_key)),h.CT_foreign_corp_key<>(typeof(h.CT_foreign_corp_key))'');
    populated_HI_foreign_corp_key_pcnt := AVE(GROUP,IF(h.HI_foreign_corp_key = (TYPEOF(h.HI_foreign_corp_key))'',0,100));
    maxlength_HI_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.HI_foreign_corp_key)));
    avelength_HI_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.HI_foreign_corp_key)),h.HI_foreign_corp_key<>(typeof(h.HI_foreign_corp_key))'');
    populated_IA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.IA_foreign_corp_key = (TYPEOF(h.IA_foreign_corp_key))'',0,100));
    maxlength_IA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.IA_foreign_corp_key)));
    avelength_IA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.IA_foreign_corp_key)),h.IA_foreign_corp_key<>(typeof(h.IA_foreign_corp_key))'');
    populated_LA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.LA_foreign_corp_key = (TYPEOF(h.LA_foreign_corp_key))'',0,100));
    maxlength_LA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.LA_foreign_corp_key)));
    avelength_LA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.LA_foreign_corp_key)),h.LA_foreign_corp_key<>(typeof(h.LA_foreign_corp_key))'');
    populated_MT_foreign_corp_key_pcnt := AVE(GROUP,IF(h.MT_foreign_corp_key = (TYPEOF(h.MT_foreign_corp_key))'',0,100));
    maxlength_MT_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.MT_foreign_corp_key)));
    avelength_MT_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.MT_foreign_corp_key)),h.MT_foreign_corp_key<>(typeof(h.MT_foreign_corp_key))'');
    populated_NE_foreign_corp_key_pcnt := AVE(GROUP,IF(h.NE_foreign_corp_key = (TYPEOF(h.NE_foreign_corp_key))'',0,100));
    maxlength_NE_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.NE_foreign_corp_key)));
    avelength_NE_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.NE_foreign_corp_key)),h.NE_foreign_corp_key<>(typeof(h.NE_foreign_corp_key))'');
    populated_VA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.VA_foreign_corp_key = (TYPEOF(h.VA_foreign_corp_key))'',0,100));
    maxlength_VA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.VA_foreign_corp_key)));
    avelength_VA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.VA_foreign_corp_key)),h.VA_foreign_corp_key<>(typeof(h.VA_foreign_corp_key))'');
    populated_AZ_foreign_corp_key_pcnt := AVE(GROUP,IF(h.AZ_foreign_corp_key = (TYPEOF(h.AZ_foreign_corp_key))'',0,100));
    maxlength_AZ_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.AZ_foreign_corp_key)));
    avelength_AZ_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.AZ_foreign_corp_key)),h.AZ_foreign_corp_key<>(typeof(h.AZ_foreign_corp_key))'');
    populated_TX_foreign_corp_key_pcnt := AVE(GROUP,IF(h.TX_foreign_corp_key = (TYPEOF(h.TX_foreign_corp_key))'',0,100));
    maxlength_TX_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.TX_foreign_corp_key)));
    avelength_TX_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.TX_foreign_corp_key)),h.TX_foreign_corp_key<>(typeof(h.TX_foreign_corp_key))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_cnp_btype_pcnt := AVE(GROUP,IF(h.cnp_btype = (TYPEOF(h.cnp_btype))'',0,100));
    maxlength_cnp_btype := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_btype)));
    avelength_cnp_btype := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_btype)),h.cnp_btype<>(typeof(h.cnp_btype))'');
    populated_iscorp_pcnt := AVE(GROUP,IF(h.iscorp = (TYPEOF(h.iscorp))'',0,100));
    maxlength_iscorp := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.iscorp)));
    avelength_iscorp := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.iscorp)),h.iscorp<>(typeof(h.iscorp))'');
    populated_cnp_lowv_pcnt := AVE(GROUP,IF(h.cnp_lowv = (TYPEOF(h.cnp_lowv))'',0,100));
    maxlength_cnp_lowv := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_lowv)));
    avelength_cnp_lowv := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_lowv)),h.cnp_lowv<>(typeof(h.cnp_lowv))'');
    populated_cnp_translated_pcnt := AVE(GROUP,IF(h.cnp_translated = (TYPEOF(h.cnp_translated))'',0,100));
    maxlength_cnp_translated := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_translated)));
    avelength_cnp_translated := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_translated)),h.cnp_translated<>(typeof(h.cnp_translated))'');
    populated_cnp_classid_pcnt := AVE(GROUP,IF(h.cnp_classid = (TYPEOF(h.cnp_classid))'',0,100));
    maxlength_cnp_classid := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_classid)));
    avelength_cnp_classid := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_classid)),h.cnp_classid<>(typeof(h.cnp_classid))'');
    populated_company_foreign_domestic_pcnt := AVE(GROUP,IF(h.company_foreign_domestic = (TYPEOF(h.company_foreign_domestic))'',0,100));
    maxlength_company_foreign_domestic := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_foreign_domestic)));
    avelength_company_foreign_domestic := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_foreign_domestic)),h.company_foreign_domestic<>(typeof(h.company_foreign_domestic))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_cnp_hasnumber_pcnt := AVE(GROUP,IF(h.cnp_hasnumber = (TYPEOF(h.cnp_hasnumber))'',0,100));
    maxlength_cnp_hasnumber := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_hasnumber)));
    avelength_cnp_hasnumber := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.cnp_hasnumber)),h.cnp_hasnumber<>(typeof(h.cnp_hasnumber))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_DE_foreign_corp_key_pcnt := AVE(GROUP,IF(h.DE_foreign_corp_key = (TYPEOF(h.DE_foreign_corp_key))'',0,100));
    maxlength_DE_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.DE_foreign_corp_key)));
    avelength_DE_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.DE_foreign_corp_key)),h.DE_foreign_corp_key<>(typeof(h.DE_foreign_corp_key))'');
    populated_ID_foreign_corp_key_pcnt := AVE(GROUP,IF(h.ID_foreign_corp_key = (TYPEOF(h.ID_foreign_corp_key))'',0,100));
    maxlength_ID_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.ID_foreign_corp_key)));
    avelength_ID_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.ID_foreign_corp_key)),h.ID_foreign_corp_key<>(typeof(h.ID_foreign_corp_key))'');
    populated_OH_foreign_corp_key_pcnt := AVE(GROUP,IF(h.OH_foreign_corp_key = (TYPEOF(h.OH_foreign_corp_key))'',0,100));
    maxlength_OH_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.OH_foreign_corp_key)));
    avelength_OH_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.OH_foreign_corp_key)),h.OH_foreign_corp_key<>(typeof(h.OH_foreign_corp_key))'');
    populated_PR_foreign_corp_key_pcnt := AVE(GROUP,IF(h.PR_foreign_corp_key = (TYPEOF(h.PR_foreign_corp_key))'',0,100));
    maxlength_PR_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.PR_foreign_corp_key)));
    avelength_PR_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.PR_foreign_corp_key)),h.PR_foreign_corp_key<>(typeof(h.PR_foreign_corp_key))'');
    populated_VI_foreign_corp_key_pcnt := AVE(GROUP,IF(h.VI_foreign_corp_key = (TYPEOF(h.VI_foreign_corp_key))'',0,100));
    maxlength_VI_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.VI_foreign_corp_key)));
    avelength_VI_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.VI_foreign_corp_key)),h.VI_foreign_corp_key<>(typeof(h.VI_foreign_corp_key))'');
    populated_WA_foreign_corp_key_pcnt := AVE(GROUP,IF(h.WA_foreign_corp_key = (TYPEOF(h.WA_foreign_corp_key))'',0,100));
    maxlength_WA_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.WA_foreign_corp_key)));
    avelength_WA_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.WA_foreign_corp_key)),h.WA_foreign_corp_key<>(typeof(h.WA_foreign_corp_key))'');
    populated_WI_foreign_corp_key_pcnt := AVE(GROUP,IF(h.WI_foreign_corp_key = (TYPEOF(h.WI_foreign_corp_key))'',0,100));
    maxlength_WI_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.WI_foreign_corp_key)));
    avelength_WI_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.WI_foreign_corp_key)),h.WI_foreign_corp_key<>(typeof(h.WI_foreign_corp_key))'');
    populated_WV_foreign_corp_key_pcnt := AVE(GROUP,IF(h.WV_foreign_corp_key = (TYPEOF(h.WV_foreign_corp_key))'',0,100));
    maxlength_WV_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.WV_foreign_corp_key)));
    avelength_WV_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.WV_foreign_corp_key)),h.WV_foreign_corp_key<>(typeof(h.WV_foreign_corp_key))'');
    populated_WY_foreign_corp_key_pcnt := AVE(GROUP,IF(h.WY_foreign_corp_key = (TYPEOF(h.WY_foreign_corp_key))'',0,100));
    maxlength_WY_foreign_corp_key := MAX(GROUP,LENGTH(TRIM((SALT26.StrType)h.WY_foreign_corp_key)));
    avelength_WY_foreign_corp_key := AVE(GROUP,LENGTH(TRIM((SALT26.StrType)h.WY_foreign_corp_key)),h.WY_foreign_corp_key<>(typeof(h.WY_foreign_corp_key))'');
  END;
  RETURN table(h,SummaryLayout);
END;
 
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT26.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.id := le.Proxid;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT26.StrType)le.cnp_number),TRIM((SALT26.StrType)le.prim_range),TRIM((SALT26.StrType)le.prim_name),TRIM((SALT26.StrType)le.st),TRIM((SALT26.StrType)le.active_enterprise_number),TRIM((SALT26.StrType)le.MN_foreign_corp_key),TRIM((SALT26.StrType)le.NJ_foreign_corp_key),TRIM((SALT26.StrType)le.active_duns_number),TRIM((SALT26.StrType)le.hist_enterprise_number),TRIM((SALT26.StrType)le.hist_duns_number),TRIM((SALT26.StrType)le.ebr_file_number),TRIM((SALT26.StrType)le.AR_foreign_corp_key),TRIM((SALT26.StrType)le.CA_foreign_corp_key),TRIM((SALT26.StrType)le.CO_foreign_corp_key),TRIM((SALT26.StrType)le.DC_foreign_corp_key),TRIM((SALT26.StrType)le.KS_foreign_corp_key),TRIM((SALT26.StrType)le.KY_foreign_corp_key),TRIM((SALT26.StrType)le.MA_foreign_corp_key),TRIM((SALT26.StrType)le.MD_foreign_corp_key),TRIM((SALT26.StrType)le.ME_foreign_corp_key),TRIM((SALT26.StrType)le.MI_foreign_corp_key),TRIM((SALT26.StrType)le.MO_foreign_corp_key),TRIM((SALT26.StrType)le.NC_foreign_corp_key),TRIM((SALT26.StrType)le.ND_foreign_corp_key),TRIM((SALT26.StrType)le.NM_foreign_corp_key),TRIM((SALT26.StrType)le.OK_foreign_corp_key),TRIM((SALT26.StrType)le.PA_foreign_corp_key),TRIM((SALT26.StrType)le.SC_foreign_corp_key),TRIM((SALT26.StrType)le.SD_foreign_corp_key),TRIM((SALT26.StrType)le.TN_foreign_corp_key),TRIM((SALT26.StrType)le.VT_foreign_corp_key),TRIM((SALT26.StrType)le.company_phone),TRIM((SALT26.StrType)le.domestic_corp_key),TRIM((SALT26.StrType)le.AL_foreign_corp_key),TRIM((SALT26.StrType)le.FL_foreign_corp_key),TRIM((SALT26.StrType)le.GA_foreign_corp_key),TRIM((SALT26.StrType)le.IL_foreign_corp_key),TRIM((SALT26.StrType)le.IN_foreign_corp_key),TRIM((SALT26.StrType)le.MS_foreign_corp_key),TRIM((SALT26.StrType)le.NH_foreign_corp_key),TRIM((SALT26.StrType)le.NV_foreign_corp_key),TRIM((SALT26.StrType)le.NY_foreign_corp_key),TRIM((SALT26.StrType)le.OR_foreign_corp_key),TRIM((SALT26.StrType)le.RI_foreign_corp_key),TRIM((SALT26.StrType)le.UT_foreign_corp_key),TRIM((SALT26.StrType)le.company_fein),TRIM((SALT26.StrType)le.cnp_name),TRIM((SALT26.StrType)le.AK_foreign_corp_key),TRIM((SALT26.StrType)le.CT_foreign_corp_key),TRIM((SALT26.StrType)le.HI_foreign_corp_key),TRIM((SALT26.StrType)le.IA_foreign_corp_key),TRIM((SALT26.StrType)le.LA_foreign_corp_key),TRIM((SALT26.StrType)le.MT_foreign_corp_key),TRIM((SALT26.StrType)le.NE_foreign_corp_key),TRIM((SALT26.StrType)le.VA_foreign_corp_key),TRIM((SALT26.StrType)le.AZ_foreign_corp_key),TRIM((SALT26.StrType)le.TX_foreign_corp_key),TRIM((SALT26.StrType)le.zip),TRIM((SALT26.StrType)le.sec_range),TRIM((SALT26.StrType)le.v_city_name),TRIM((SALT26.StrType)le.cnp_btype),TRIM((SALT26.StrType)le.iscorp),TRIM((SALT26.StrType)le.cnp_lowv),TRIM((SALT26.StrType)le.cnp_translated),TRIM((SALT26.StrType)le.cnp_classid),TRIM((SALT26.StrType)le.company_foreign_domestic),TRIM((SALT26.StrType)le.company_bdid),TRIM((SALT26.StrType)le.cnp_hasnumber),TRIM((SALT26.StrType)le.company_name),TRIM((SALT26.StrType)le.dt_first_seen),TRIM((SALT26.StrType)le.dt_last_seen),TRIM((SALT26.StrType)le.DE_foreign_corp_key),TRIM((SALT26.StrType)le.ID_foreign_corp_key),TRIM((SALT26.StrType)le.OH_foreign_corp_key),TRIM((SALT26.StrType)le.PR_foreign_corp_key),TRIM((SALT26.StrType)le.VI_foreign_corp_key),TRIM((SALT26.StrType)le.WA_foreign_corp_key),TRIM((SALT26.StrType)le.WI_foreign_corp_key),TRIM((SALT26.StrType)le.WV_foreign_corp_key),TRIM((SALT26.StrType)le.WY_foreign_corp_key)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,80,Into(LEFT,COUNTER));
SHARED FldIds := DATASET([{1,'cnp_number'}
      ,{2,'prim_range'}
      ,{3,'prim_name'}
      ,{4,'st'}
      ,{5,'active_enterprise_number'}
      ,{6,'MN_foreign_corp_key'}
      ,{7,'NJ_foreign_corp_key'}
      ,{8,'active_duns_number'}
      ,{9,'hist_enterprise_number'}
      ,{10,'hist_duns_number'}
      ,{11,'ebr_file_number'}
      ,{12,'AR_foreign_corp_key'}
      ,{13,'CA_foreign_corp_key'}
      ,{14,'CO_foreign_corp_key'}
      ,{15,'DC_foreign_corp_key'}
      ,{16,'KS_foreign_corp_key'}
      ,{17,'KY_foreign_corp_key'}
      ,{18,'MA_foreign_corp_key'}
      ,{19,'MD_foreign_corp_key'}
      ,{20,'ME_foreign_corp_key'}
      ,{21,'MI_foreign_corp_key'}
      ,{22,'MO_foreign_corp_key'}
      ,{23,'NC_foreign_corp_key'}
      ,{24,'ND_foreign_corp_key'}
      ,{25,'NM_foreign_corp_key'}
      ,{26,'OK_foreign_corp_key'}
      ,{27,'PA_foreign_corp_key'}
      ,{28,'SC_foreign_corp_key'}
      ,{29,'SD_foreign_corp_key'}
      ,{30,'TN_foreign_corp_key'}
      ,{31,'VT_foreign_corp_key'}
      ,{32,'company_phone'}
      ,{33,'domestic_corp_key'}
      ,{34,'AL_foreign_corp_key'}
      ,{35,'FL_foreign_corp_key'}
      ,{36,'GA_foreign_corp_key'}
      ,{37,'IL_foreign_corp_key'}
      ,{38,'IN_foreign_corp_key'}
      ,{39,'MS_foreign_corp_key'}
      ,{40,'NH_foreign_corp_key'}
      ,{41,'NV_foreign_corp_key'}
      ,{42,'NY_foreign_corp_key'}
      ,{43,'OR_foreign_corp_key'}
      ,{44,'RI_foreign_corp_key'}
      ,{45,'UT_foreign_corp_key'}
      ,{46,'company_fein'}
      ,{47,'cnp_name'}
      ,{49,'AK_foreign_corp_key'}
      ,{50,'CT_foreign_corp_key'}
      ,{51,'HI_foreign_corp_key'}
      ,{52,'IA_foreign_corp_key'}
      ,{53,'LA_foreign_corp_key'}
      ,{54,'MT_foreign_corp_key'}
      ,{55,'NE_foreign_corp_key'}
      ,{56,'VA_foreign_corp_key'}
      ,{57,'AZ_foreign_corp_key'}
      ,{58,'TX_foreign_corp_key'}
      ,{60,'zip'}
      ,{62,'sec_range'}
      ,{63,'v_city_name'}
      ,{64,'cnp_btype'}
      ,{65,'iscorp'}
      ,{66,'cnp_lowv'}
      ,{67,'cnp_translated'}
      ,{68,'cnp_classid'}
      ,{69,'company_foreign_domestic'}
      ,{70,'company_bdid'}
      ,{71,'cnp_hasnumber'}
      ,{72,'company_name'}
      ,{73,'dt_first_seen'}
      ,{74,'dt_last_seen'}
      ,{75,'DE_foreign_corp_key'}
      ,{76,'ID_foreign_corp_key'}
      ,{77,'OH_foreign_corp_key'}
      ,{78,'PR_foreign_corp_key'}
      ,{79,'VI_foreign_corp_key'}
      ,{80,'WA_foreign_corp_key'}
      ,{81,'WI_foreign_corp_key'}
      ,{82,'WV_foreign_corp_key'}
      ,{83,'WY_foreign_corp_key'}],SALT26.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT26.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT26.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
ErrorRecord := record
  unsigned1 FieldNum;
  unsigned1 ErrorNum;
end;
ErrorRecord NoteErrors(h le,unsigned1 c) := transform
  self.ErrorNum := CHOOSE(c,
    Fields.InValid_cnp_number((SALT26.StrType)le.cnp_number),
    Fields.InValid_prim_range((SALT26.StrType)le.prim_range),
    Fields.InValid_prim_name((SALT26.StrType)le.prim_name),
    Fields.InValid_st((SALT26.StrType)le.st),
    Fields.InValid_active_enterprise_number((SALT26.StrType)le.active_enterprise_number),
    Fields.InValid_MN_foreign_corp_key((SALT26.StrType)le.MN_foreign_corp_key),
    Fields.InValid_NJ_foreign_corp_key((SALT26.StrType)le.NJ_foreign_corp_key),
    Fields.InValid_active_duns_number((SALT26.StrType)le.active_duns_number),
    Fields.InValid_hist_enterprise_number((SALT26.StrType)le.hist_enterprise_number),
    Fields.InValid_hist_duns_number((SALT26.StrType)le.hist_duns_number),
    Fields.InValid_ebr_file_number((SALT26.StrType)le.ebr_file_number),
    Fields.InValid_AR_foreign_corp_key((SALT26.StrType)le.AR_foreign_corp_key),
    Fields.InValid_CA_foreign_corp_key((SALT26.StrType)le.CA_foreign_corp_key),
    Fields.InValid_CO_foreign_corp_key((SALT26.StrType)le.CO_foreign_corp_key),
    Fields.InValid_DC_foreign_corp_key((SALT26.StrType)le.DC_foreign_corp_key),
    Fields.InValid_KS_foreign_corp_key((SALT26.StrType)le.KS_foreign_corp_key),
    Fields.InValid_KY_foreign_corp_key((SALT26.StrType)le.KY_foreign_corp_key),
    Fields.InValid_MA_foreign_corp_key((SALT26.StrType)le.MA_foreign_corp_key),
    Fields.InValid_MD_foreign_corp_key((SALT26.StrType)le.MD_foreign_corp_key),
    Fields.InValid_ME_foreign_corp_key((SALT26.StrType)le.ME_foreign_corp_key),
    Fields.InValid_MI_foreign_corp_key((SALT26.StrType)le.MI_foreign_corp_key),
    Fields.InValid_MO_foreign_corp_key((SALT26.StrType)le.MO_foreign_corp_key),
    Fields.InValid_NC_foreign_corp_key((SALT26.StrType)le.NC_foreign_corp_key),
    Fields.InValid_ND_foreign_corp_key((SALT26.StrType)le.ND_foreign_corp_key),
    Fields.InValid_NM_foreign_corp_key((SALT26.StrType)le.NM_foreign_corp_key),
    Fields.InValid_OK_foreign_corp_key((SALT26.StrType)le.OK_foreign_corp_key),
    Fields.InValid_PA_foreign_corp_key((SALT26.StrType)le.PA_foreign_corp_key),
    Fields.InValid_SC_foreign_corp_key((SALT26.StrType)le.SC_foreign_corp_key),
    Fields.InValid_SD_foreign_corp_key((SALT26.StrType)le.SD_foreign_corp_key),
    Fields.InValid_TN_foreign_corp_key((SALT26.StrType)le.TN_foreign_corp_key),
    Fields.InValid_VT_foreign_corp_key((SALT26.StrType)le.VT_foreign_corp_key),
    Fields.InValid_company_phone((SALT26.StrType)le.company_phone),
    Fields.InValid_domestic_corp_key((SALT26.StrType)le.domestic_corp_key),
    Fields.InValid_AL_foreign_corp_key((SALT26.StrType)le.AL_foreign_corp_key),
    Fields.InValid_FL_foreign_corp_key((SALT26.StrType)le.FL_foreign_corp_key),
    Fields.InValid_GA_foreign_corp_key((SALT26.StrType)le.GA_foreign_corp_key),
    Fields.InValid_IL_foreign_corp_key((SALT26.StrType)le.IL_foreign_corp_key),
    Fields.InValid_IN_foreign_corp_key((SALT26.StrType)le.IN_foreign_corp_key),
    Fields.InValid_MS_foreign_corp_key((SALT26.StrType)le.MS_foreign_corp_key),
    Fields.InValid_NH_foreign_corp_key((SALT26.StrType)le.NH_foreign_corp_key),
    Fields.InValid_NV_foreign_corp_key((SALT26.StrType)le.NV_foreign_corp_key),
    Fields.InValid_NY_foreign_corp_key((SALT26.StrType)le.NY_foreign_corp_key),
    Fields.InValid_OR_foreign_corp_key((SALT26.StrType)le.OR_foreign_corp_key),
    Fields.InValid_RI_foreign_corp_key((SALT26.StrType)le.RI_foreign_corp_key),
    Fields.InValid_UT_foreign_corp_key((SALT26.StrType)le.UT_foreign_corp_key),
    Fields.InValid_company_fein((SALT26.StrType)le.company_fein),
    Fields.InValid_cnp_name((SALT26.StrType)le.cnp_name),
    0, // Uncleanable field
    Fields.InValid_AK_foreign_corp_key((SALT26.StrType)le.AK_foreign_corp_key),
    Fields.InValid_CT_foreign_corp_key((SALT26.StrType)le.CT_foreign_corp_key),
    Fields.InValid_HI_foreign_corp_key((SALT26.StrType)le.HI_foreign_corp_key),
    Fields.InValid_IA_foreign_corp_key((SALT26.StrType)le.IA_foreign_corp_key),
    Fields.InValid_LA_foreign_corp_key((SALT26.StrType)le.LA_foreign_corp_key),
    Fields.InValid_MT_foreign_corp_key((SALT26.StrType)le.MT_foreign_corp_key),
    Fields.InValid_NE_foreign_corp_key((SALT26.StrType)le.NE_foreign_corp_key),
    Fields.InValid_VA_foreign_corp_key((SALT26.StrType)le.VA_foreign_corp_key),
    Fields.InValid_AZ_foreign_corp_key((SALT26.StrType)le.AZ_foreign_corp_key),
    Fields.InValid_TX_foreign_corp_key((SALT26.StrType)le.TX_foreign_corp_key),
    0, // Uncleanable field
    Fields.InValid_zip((SALT26.StrType)le.zip),
    0, // Uncleanable field
    Fields.InValid_sec_range((SALT26.StrType)le.sec_range),
    Fields.InValid_v_city_name((SALT26.StrType)le.v_city_name),
    Fields.InValid_cnp_btype((SALT26.StrType)le.cnp_btype),
    Fields.InValid_iscorp((SALT26.StrType)le.iscorp),
    Fields.InValid_cnp_lowv((SALT26.StrType)le.cnp_lowv),
    Fields.InValid_cnp_translated((SALT26.StrType)le.cnp_translated),
    Fields.InValid_cnp_classid((SALT26.StrType)le.cnp_classid),
    Fields.InValid_company_foreign_domestic((SALT26.StrType)le.company_foreign_domestic),
    Fields.InValid_company_bdid((SALT26.StrType)le.company_bdid),
    Fields.InValid_cnp_hasnumber((SALT26.StrType)le.cnp_hasnumber),
    Fields.InValid_company_name((SALT26.StrType)le.company_name),
    Fields.InValid_dt_first_seen((SALT26.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT26.StrType)le.dt_last_seen),
    Fields.InValid_DE_foreign_corp_key((SALT26.StrType)le.DE_foreign_corp_key),
    Fields.InValid_ID_foreign_corp_key((SALT26.StrType)le.ID_foreign_corp_key),
    Fields.InValid_OH_foreign_corp_key((SALT26.StrType)le.OH_foreign_corp_key),
    Fields.InValid_PR_foreign_corp_key((SALT26.StrType)le.PR_foreign_corp_key),
    Fields.InValid_VI_foreign_corp_key((SALT26.StrType)le.VI_foreign_corp_key),
    Fields.InValid_WA_foreign_corp_key((SALT26.StrType)le.WA_foreign_corp_key),
    Fields.InValid_WI_foreign_corp_key((SALT26.StrType)le.WI_foreign_corp_key),
    Fields.InValid_WV_foreign_corp_key((SALT26.StrType)le.WV_foreign_corp_key),
    Fields.InValid_WY_foreign_corp_key((SALT26.StrType)le.WY_foreign_corp_key),
    0);
  self.FieldNum := IF(self.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
end;
Errors := normalize(h,83,NoteErrors(left,counter));
ErrorRecordsTotals := record
  Errors.FieldNum;
  Errors.ErrorNum;
  unsigned Cnt := count(group);
end;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := record
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_cnp_number(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_active_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_MN_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NJ_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_active_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_enterprise_number(TotalErrors.ErrorNum),Fields.InValidMessage_hist_duns_number(TotalErrors.ErrorNum),Fields.InValidMessage_ebr_file_number(TotalErrors.ErrorNum),Fields.InValidMessage_AR_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_CA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_CO_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_DC_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_KS_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_KY_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MD_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ME_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MI_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MO_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NC_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ND_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NM_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_OK_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_PA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_SC_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_SD_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_TN_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_VT_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Fields.InValidMessage_domestic_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_AL_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_FL_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_GA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_IL_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_IN_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MS_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NH_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NV_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NY_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_OR_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_RI_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_UT_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_name(TotalErrors.ErrorNum),'',Fields.InValidMessage_AK_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_CT_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_HI_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_IA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_LA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_MT_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_NE_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_VA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_AZ_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_TX_foreign_corp_key(TotalErrors.ErrorNum),'',Fields.InValidMessage_zip(TotalErrors.ErrorNum),'',Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_btype(TotalErrors.ErrorNum),Fields.InValidMessage_iscorp(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_lowv(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_translated(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_classid(TotalErrors.ErrorNum),Fields.InValidMessage_company_foreign_domestic(TotalErrors.ErrorNum),Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_cnp_hasnumber(TotalErrors.ErrorNum),Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_DE_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_ID_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_OH_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_PR_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_VI_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_WA_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_WI_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_WV_foreign_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_WY_foreign_corp_key(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
end;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
export ValidityErrors := ValErr;
//We have Proxid specified - so we can compute statistics on the cluster counts
EXPORT ClusterCounts := SALT26.MOD_ClusterStats.Counts(h,Proxid);
end;
