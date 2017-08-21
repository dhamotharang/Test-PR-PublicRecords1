// Begin code to produce match candidates
IMPORT SALT26,ut;
EXPORT match_candidates(DATASET(layout_DOT_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,company_name,cnp_name,cnp_hasnumber,cnp_number,cnp_btype,cnp_lowv,cnp_translated,cnp_classid,company_fein,company_foreign_domestic,company_bdid,company_phone,iscorp,prim_range,prim_name,sec_range,v_city_name,st,zip,company_csz,company_addr1,company_address,dt_first_seen,dt_last_seen,active_duns_number,active_enterprise_number,hist_enterprise_number,hist_duns_number,ebr_file_number,domestic_corp_key,AK_foreign_corp_key,AL_foreign_corp_key,AR_foreign_corp_key,AZ_foreign_corp_key,CA_foreign_corp_key,CO_foreign_corp_key,CT_foreign_corp_key,DC_foreign_corp_key,DE_foreign_corp_key,FL_foreign_corp_key,GA_foreign_corp_key,HI_foreign_corp_key,IA_foreign_corp_key,ID_foreign_corp_key,IL_foreign_corp_key,IN_foreign_corp_key,KS_foreign_corp_key,KY_foreign_corp_key,LA_foreign_corp_key,MA_foreign_corp_key,MD_foreign_corp_key,ME_foreign_corp_key,MI_foreign_corp_key,MN_foreign_corp_key,MO_foreign_corp_key,MS_foreign_corp_key,MT_foreign_corp_key,NC_foreign_corp_key,ND_foreign_corp_key,NE_foreign_corp_key,NH_foreign_corp_key,NJ_foreign_corp_key,NM_foreign_corp_key,NV_foreign_corp_key,NY_foreign_corp_key,OH_foreign_corp_key,OK_foreign_corp_key,OR_foreign_corp_key,PA_foreign_corp_key,PR_foreign_corp_key,RI_foreign_corp_key,SC_foreign_corp_key,SD_foreign_corp_key,TN_foreign_corp_key,TX_foreign_corp_key,UT_foreign_corp_key,VA_foreign_corp_key,VI_foreign_corp_key,VT_foreign_corp_key,WA_foreign_corp_key,WI_foreign_corp_key,WV_foreign_corp_key,WY_foreign_corp_key,SALT_Partition,Proxid}),HASH(Proxid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(thin_table.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(thin_table.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 iscorp_pop := AVE(GROUP,IF(thin_table.iscorp IN SET(s.nulls_iscorp,iscorp),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(thin_table.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(thin_table.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(thin_table.company_address IN SET(s.nulls_company_address,company_address),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(thin_table.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(thin_table.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF(thin_table.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF(thin_table.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF(thin_table.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number),0,100));
  REAL8 domestic_corp_key_pop := AVE(GROUP,IF(thin_table.domestic_corp_key IN SET(s.nulls_domestic_corp_key,domestic_corp_key),0,100));
  REAL8 AK_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.AK_foreign_corp_key IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key),0,100));
  REAL8 AL_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.AL_foreign_corp_key IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key),0,100));
  REAL8 AR_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.AR_foreign_corp_key IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key),0,100));
  REAL8 AZ_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.AZ_foreign_corp_key IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key),0,100));
  REAL8 CA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.CA_foreign_corp_key IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key),0,100));
  REAL8 CO_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.CO_foreign_corp_key IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key),0,100));
  REAL8 CT_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.CT_foreign_corp_key IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key),0,100));
  REAL8 DC_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.DC_foreign_corp_key IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key),0,100));
  REAL8 DE_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.DE_foreign_corp_key IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key),0,100));
  REAL8 FL_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.FL_foreign_corp_key IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key),0,100));
  REAL8 GA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.GA_foreign_corp_key IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key),0,100));
  REAL8 HI_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.HI_foreign_corp_key IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key),0,100));
  REAL8 IA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.IA_foreign_corp_key IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key),0,100));
  REAL8 ID_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.ID_foreign_corp_key IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key),0,100));
  REAL8 IL_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.IL_foreign_corp_key IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key),0,100));
  REAL8 IN_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.IN_foreign_corp_key IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key),0,100));
  REAL8 KS_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.KS_foreign_corp_key IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key),0,100));
  REAL8 KY_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.KY_foreign_corp_key IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key),0,100));
  REAL8 LA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.LA_foreign_corp_key IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key),0,100));
  REAL8 MA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MA_foreign_corp_key IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key),0,100));
  REAL8 MD_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MD_foreign_corp_key IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key),0,100));
  REAL8 ME_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.ME_foreign_corp_key IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key),0,100));
  REAL8 MI_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MI_foreign_corp_key IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key),0,100));
  REAL8 MN_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MN_foreign_corp_key IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key),0,100));
  REAL8 MO_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MO_foreign_corp_key IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key),0,100));
  REAL8 MS_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MS_foreign_corp_key IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key),0,100));
  REAL8 MT_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.MT_foreign_corp_key IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key),0,100));
  REAL8 NC_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NC_foreign_corp_key IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key),0,100));
  REAL8 ND_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.ND_foreign_corp_key IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key),0,100));
  REAL8 NE_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NE_foreign_corp_key IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key),0,100));
  REAL8 NH_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NH_foreign_corp_key IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key),0,100));
  REAL8 NJ_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NJ_foreign_corp_key IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key),0,100));
  REAL8 NM_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NM_foreign_corp_key IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key),0,100));
  REAL8 NV_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NV_foreign_corp_key IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key),0,100));
  REAL8 NY_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.NY_foreign_corp_key IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key),0,100));
  REAL8 OH_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.OH_foreign_corp_key IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key),0,100));
  REAL8 OK_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.OK_foreign_corp_key IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key),0,100));
  REAL8 OR_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.OR_foreign_corp_key IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key),0,100));
  REAL8 PA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.PA_foreign_corp_key IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key),0,100));
  REAL8 PR_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.PR_foreign_corp_key IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key),0,100));
  REAL8 RI_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.RI_foreign_corp_key IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key),0,100));
  REAL8 SC_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.SC_foreign_corp_key IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key),0,100));
  REAL8 SD_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.SD_foreign_corp_key IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key),0,100));
  REAL8 TN_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.TN_foreign_corp_key IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key),0,100));
  REAL8 TX_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.TX_foreign_corp_key IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key),0,100));
  REAL8 UT_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.UT_foreign_corp_key IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key),0,100));
  REAL8 VA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.VA_foreign_corp_key IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key),0,100));
  REAL8 VI_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.VI_foreign_corp_key IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key),0,100));
  REAL8 VT_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.VT_foreign_corp_key IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key),0,100));
  REAL8 WA_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.WA_foreign_corp_key IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key),0,100));
  REAL8 WI_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.WI_foreign_corp_key IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key),0,100));
  REAL8 WV_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.WV_foreign_corp_key IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key),0,100));
  REAL8 WY_foreign_corp_key_pop := AVE(GROUP,IF(thin_table.WY_foreign_corp_key IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 cnp_number_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 company_phone_prop := 0;
  UNSIGNED1 iscorp_prop := 0;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 company_csz_prop := 0;
  UNSIGNED1 company_addr1_prop := 0;
  UNSIGNED1 company_address_prop := 0;
  UNSIGNED1 active_duns_number_prop := 0;
  UNSIGNED1 active_enterprise_number_prop := 0;
  UNSIGNED1 hist_enterprise_number_prop := 0;
  UNSIGNED1 hist_duns_number_prop := 0;
  UNSIGNED1 ebr_file_number_prop := 0;
  UNSIGNED1 domestic_corp_key_prop := 0;
  UNSIGNED1 AK_foreign_corp_key_prop := 0;
  UNSIGNED1 AL_foreign_corp_key_prop := 0;
  UNSIGNED1 AR_foreign_corp_key_prop := 0;
  UNSIGNED1 AZ_foreign_corp_key_prop := 0;
  UNSIGNED1 CA_foreign_corp_key_prop := 0;
  UNSIGNED1 CO_foreign_corp_key_prop := 0;
  UNSIGNED1 CT_foreign_corp_key_prop := 0;
  UNSIGNED1 DC_foreign_corp_key_prop := 0;
  UNSIGNED1 DE_foreign_corp_key_prop := 0;
  UNSIGNED1 FL_foreign_corp_key_prop := 0;
  UNSIGNED1 GA_foreign_corp_key_prop := 0;
  UNSIGNED1 HI_foreign_corp_key_prop := 0;
  UNSIGNED1 IA_foreign_corp_key_prop := 0;
  UNSIGNED1 ID_foreign_corp_key_prop := 0;
  UNSIGNED1 IL_foreign_corp_key_prop := 0;
  UNSIGNED1 IN_foreign_corp_key_prop := 0;
  UNSIGNED1 KS_foreign_corp_key_prop := 0;
  UNSIGNED1 KY_foreign_corp_key_prop := 0;
  UNSIGNED1 LA_foreign_corp_key_prop := 0;
  UNSIGNED1 MA_foreign_corp_key_prop := 0;
  UNSIGNED1 MD_foreign_corp_key_prop := 0;
  UNSIGNED1 ME_foreign_corp_key_prop := 0;
  UNSIGNED1 MI_foreign_corp_key_prop := 0;
  UNSIGNED1 MN_foreign_corp_key_prop := 0;
  UNSIGNED1 MO_foreign_corp_key_prop := 0;
  UNSIGNED1 MS_foreign_corp_key_prop := 0;
  UNSIGNED1 MT_foreign_corp_key_prop := 0;
  UNSIGNED1 NC_foreign_corp_key_prop := 0;
  UNSIGNED1 ND_foreign_corp_key_prop := 0;
  UNSIGNED1 NE_foreign_corp_key_prop := 0;
  UNSIGNED1 NH_foreign_corp_key_prop := 0;
  UNSIGNED1 NJ_foreign_corp_key_prop := 0;
  UNSIGNED1 NM_foreign_corp_key_prop := 0;
  UNSIGNED1 NV_foreign_corp_key_prop := 0;
  UNSIGNED1 NY_foreign_corp_key_prop := 0;
  UNSIGNED1 OH_foreign_corp_key_prop := 0;
  UNSIGNED1 OK_foreign_corp_key_prop := 0;
  UNSIGNED1 OR_foreign_corp_key_prop := 0;
  UNSIGNED1 PA_foreign_corp_key_prop := 0;
  UNSIGNED1 PR_foreign_corp_key_prop := 0;
  UNSIGNED1 RI_foreign_corp_key_prop := 0;
  UNSIGNED1 SC_foreign_corp_key_prop := 0;
  UNSIGNED1 SD_foreign_corp_key_prop := 0;
  UNSIGNED1 TN_foreign_corp_key_prop := 0;
  UNSIGNED1 TX_foreign_corp_key_prop := 0;
  UNSIGNED1 UT_foreign_corp_key_prop := 0;
  UNSIGNED1 VA_foreign_corp_key_prop := 0;
  UNSIGNED1 VI_foreign_corp_key_prop := 0;
  UNSIGNED1 VT_foreign_corp_key_prop := 0;
  UNSIGNED1 WA_foreign_corp_key_prop := 0;
  UNSIGNED1 WI_foreign_corp_key_prop := 0;
  UNSIGNED1 WV_foreign_corp_key_prop := 0;
  UNSIGNED1 WY_foreign_corp_key_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT26.mac_prop_field(with_props(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,Proxid,cnp_number_props); // For every DID find the best FULL cnp_number
layout_withpropvars take_cnp_number(with_props le,cnp_number_props ri) := TRANSFORM
  SELF.cnp_number := IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.cnp_number, le.cnp_number );
  SELF.cnp_number_prop := le.cnp_number_prop + IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(with_props,cnp_number_props,left.Proxid=right.Proxid,take_cnp_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,Proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj3,company_fein_props,left.Proxid=right.Proxid,take_company_fein(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(company_phone NOT IN SET(s.nulls_company_phone,company_phone)),company_phone,Proxid,company_phone_props); // For every DID find the best FULL company_phone
layout_withpropvars take_company_phone(with_props le,company_phone_props ri) := TRANSFORM
  SELF.company_phone := IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_phone, le.company_phone );
  SELF.company_phone_prop := le.company_phone_prop + IF ( le.company_phone IN SET(s.nulls_company_phone,company_phone) and ri.company_phone NOT IN SET(s.nulls_company_phone,company_phone) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj8,company_phone_props,left.Proxid=right.Proxid,take_company_phone(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(iscorp NOT IN SET(s.nulls_iscorp,iscorp)),iscorp,Proxid,iscorp_props); // For every DID find the best FULL iscorp
layout_withpropvars take_iscorp(with_props le,iscorp_props ri) := TRANSFORM
  SELF.iscorp := IF ( le.iscorp IN SET(s.nulls_iscorp,iscorp) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.iscorp, le.iscorp );
  SELF.iscorp_prop := le.iscorp_prop + IF ( le.iscorp IN SET(s.nulls_iscorp,iscorp) and ri.iscorp NOT IN SET(s.nulls_iscorp,iscorp) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(pj11,iscorp_props,left.Proxid=right.Proxid,take_iscorp(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,Proxid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj15 := JOIN(pj12,sec_range_props,left.Proxid=right.Proxid,take_sec_range(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),active_duns_number,Proxid,active_duns_number_props); // For every DID find the best FULL active_duns_number
layout_withpropvars take_active_duns_number(with_props le,active_duns_number_props ri) := TRANSFORM
  SELF.active_duns_number := IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_duns_number, le.active_duns_number );
  SELF.active_duns_number_prop := le.active_duns_number_prop + IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj24 := JOIN(pj15,active_duns_number_props,left.Proxid=right.Proxid,take_active_duns_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number)),active_enterprise_number,Proxid,active_enterprise_number_props); // For every DID find the best FULL active_enterprise_number
layout_withpropvars take_active_enterprise_number(with_props le,active_enterprise_number_props ri) := TRANSFORM
  SELF.active_enterprise_number := IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.active_enterprise_number, le.active_enterprise_number );
  SELF.active_enterprise_number_prop := le.active_enterprise_number_prop + IF ( le.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.active_enterprise_number NOT IN SET(s.nulls_active_enterprise_number,active_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj25 := JOIN(pj24,active_enterprise_number_props,left.Proxid=right.Proxid,take_active_enterprise_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number)),hist_enterprise_number,Proxid,hist_enterprise_number_props); // For every DID find the best FULL hist_enterprise_number
layout_withpropvars take_hist_enterprise_number(with_props le,hist_enterprise_number_props ri) := TRANSFORM
  SELF.hist_enterprise_number := IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_enterprise_number, le.hist_enterprise_number );
  SELF.hist_enterprise_number_prop := le.hist_enterprise_number_prop + IF ( le.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.hist_enterprise_number NOT IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj26 := JOIN(pj25,hist_enterprise_number_props,left.Proxid=right.Proxid,take_hist_enterprise_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number)),hist_duns_number,Proxid,hist_duns_number_props); // For every DID find the best FULL hist_duns_number
layout_withpropvars take_hist_duns_number(with_props le,hist_duns_number_props ri) := TRANSFORM
  SELF.hist_duns_number := IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.hist_duns_number, le.hist_duns_number );
  SELF.hist_duns_number_prop := le.hist_duns_number_prop + IF ( le.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.hist_duns_number NOT IN SET(s.nulls_hist_duns_number,hist_duns_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj27 := JOIN(pj26,hist_duns_number_props,left.Proxid=right.Proxid,take_hist_duns_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number)),ebr_file_number,Proxid,ebr_file_number_props); // For every DID find the best FULL ebr_file_number
layout_withpropvars take_ebr_file_number(with_props le,ebr_file_number_props ri) := TRANSFORM
  SELF.ebr_file_number := IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ebr_file_number, le.ebr_file_number );
  SELF.ebr_file_number_prop := le.ebr_file_number_prop + IF ( le.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.ebr_file_number NOT IN SET(s.nulls_ebr_file_number,ebr_file_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj28 := JOIN(pj27,ebr_file_number_props,left.Proxid=right.Proxid,take_ebr_file_number(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(domestic_corp_key NOT IN SET(s.nulls_domestic_corp_key,domestic_corp_key)),domestic_corp_key,Proxid,domestic_corp_key_props); // For every DID find the best FULL domestic_corp_key
layout_withpropvars take_domestic_corp_key(with_props le,domestic_corp_key_props ri) := TRANSFORM
  SELF.domestic_corp_key := IF ( le.domestic_corp_key IN SET(s.nulls_domestic_corp_key,domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.domestic_corp_key, le.domestic_corp_key );
  SELF.domestic_corp_key_prop := le.domestic_corp_key_prop + IF ( le.domestic_corp_key IN SET(s.nulls_domestic_corp_key,domestic_corp_key) and ri.domestic_corp_key NOT IN SET(s.nulls_domestic_corp_key,domestic_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj29 := JOIN(pj28,domestic_corp_key_props,left.Proxid=right.Proxid,take_domestic_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(AK_foreign_corp_key NOT IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key)),AK_foreign_corp_key,Proxid,AK_foreign_corp_key_props); // For every DID find the best FULL AK_foreign_corp_key
layout_withpropvars take_AK_foreign_corp_key(with_props le,AK_foreign_corp_key_props ri) := TRANSFORM
  SELF.AK_foreign_corp_key := IF ( le.AK_foreign_corp_key IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.AK_foreign_corp_key, le.AK_foreign_corp_key );
  SELF.AK_foreign_corp_key_prop := le.AK_foreign_corp_key_prop + IF ( le.AK_foreign_corp_key IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key) and ri.AK_foreign_corp_key NOT IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj30 := JOIN(pj29,AK_foreign_corp_key_props,left.Proxid=right.Proxid,take_AK_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(AL_foreign_corp_key NOT IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key)),AL_foreign_corp_key,Proxid,AL_foreign_corp_key_props); // For every DID find the best FULL AL_foreign_corp_key
layout_withpropvars take_AL_foreign_corp_key(with_props le,AL_foreign_corp_key_props ri) := TRANSFORM
  SELF.AL_foreign_corp_key := IF ( le.AL_foreign_corp_key IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.AL_foreign_corp_key, le.AL_foreign_corp_key );
  SELF.AL_foreign_corp_key_prop := le.AL_foreign_corp_key_prop + IF ( le.AL_foreign_corp_key IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key) and ri.AL_foreign_corp_key NOT IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj31 := JOIN(pj30,AL_foreign_corp_key_props,left.Proxid=right.Proxid,take_AL_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(AR_foreign_corp_key NOT IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key)),AR_foreign_corp_key,Proxid,AR_foreign_corp_key_props); // For every DID find the best FULL AR_foreign_corp_key
layout_withpropvars take_AR_foreign_corp_key(with_props le,AR_foreign_corp_key_props ri) := TRANSFORM
  SELF.AR_foreign_corp_key := IF ( le.AR_foreign_corp_key IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.AR_foreign_corp_key, le.AR_foreign_corp_key );
  SELF.AR_foreign_corp_key_prop := le.AR_foreign_corp_key_prop + IF ( le.AR_foreign_corp_key IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key) and ri.AR_foreign_corp_key NOT IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj32 := JOIN(pj31,AR_foreign_corp_key_props,left.Proxid=right.Proxid,take_AR_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(AZ_foreign_corp_key NOT IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key)),AZ_foreign_corp_key,Proxid,AZ_foreign_corp_key_props); // For every DID find the best FULL AZ_foreign_corp_key
layout_withpropvars take_AZ_foreign_corp_key(with_props le,AZ_foreign_corp_key_props ri) := TRANSFORM
  SELF.AZ_foreign_corp_key := IF ( le.AZ_foreign_corp_key IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.AZ_foreign_corp_key, le.AZ_foreign_corp_key );
  SELF.AZ_foreign_corp_key_prop := le.AZ_foreign_corp_key_prop + IF ( le.AZ_foreign_corp_key IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key) and ri.AZ_foreign_corp_key NOT IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj33 := JOIN(pj32,AZ_foreign_corp_key_props,left.Proxid=right.Proxid,take_AZ_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(CA_foreign_corp_key NOT IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key)),CA_foreign_corp_key,Proxid,CA_foreign_corp_key_props); // For every DID find the best FULL CA_foreign_corp_key
layout_withpropvars take_CA_foreign_corp_key(with_props le,CA_foreign_corp_key_props ri) := TRANSFORM
  SELF.CA_foreign_corp_key := IF ( le.CA_foreign_corp_key IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.CA_foreign_corp_key, le.CA_foreign_corp_key );
  SELF.CA_foreign_corp_key_prop := le.CA_foreign_corp_key_prop + IF ( le.CA_foreign_corp_key IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key) and ri.CA_foreign_corp_key NOT IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj34 := JOIN(pj33,CA_foreign_corp_key_props,left.Proxid=right.Proxid,take_CA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(CO_foreign_corp_key NOT IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key)),CO_foreign_corp_key,Proxid,CO_foreign_corp_key_props); // For every DID find the best FULL CO_foreign_corp_key
layout_withpropvars take_CO_foreign_corp_key(with_props le,CO_foreign_corp_key_props ri) := TRANSFORM
  SELF.CO_foreign_corp_key := IF ( le.CO_foreign_corp_key IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.CO_foreign_corp_key, le.CO_foreign_corp_key );
  SELF.CO_foreign_corp_key_prop := le.CO_foreign_corp_key_prop + IF ( le.CO_foreign_corp_key IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key) and ri.CO_foreign_corp_key NOT IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj35 := JOIN(pj34,CO_foreign_corp_key_props,left.Proxid=right.Proxid,take_CO_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(CT_foreign_corp_key NOT IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key)),CT_foreign_corp_key,Proxid,CT_foreign_corp_key_props); // For every DID find the best FULL CT_foreign_corp_key
layout_withpropvars take_CT_foreign_corp_key(with_props le,CT_foreign_corp_key_props ri) := TRANSFORM
  SELF.CT_foreign_corp_key := IF ( le.CT_foreign_corp_key IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.CT_foreign_corp_key, le.CT_foreign_corp_key );
  SELF.CT_foreign_corp_key_prop := le.CT_foreign_corp_key_prop + IF ( le.CT_foreign_corp_key IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key) and ri.CT_foreign_corp_key NOT IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj36 := JOIN(pj35,CT_foreign_corp_key_props,left.Proxid=right.Proxid,take_CT_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(DC_foreign_corp_key NOT IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key)),DC_foreign_corp_key,Proxid,DC_foreign_corp_key_props); // For every DID find the best FULL DC_foreign_corp_key
layout_withpropvars take_DC_foreign_corp_key(with_props le,DC_foreign_corp_key_props ri) := TRANSFORM
  SELF.DC_foreign_corp_key := IF ( le.DC_foreign_corp_key IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.DC_foreign_corp_key, le.DC_foreign_corp_key );
  SELF.DC_foreign_corp_key_prop := le.DC_foreign_corp_key_prop + IF ( le.DC_foreign_corp_key IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key) and ri.DC_foreign_corp_key NOT IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj37 := JOIN(pj36,DC_foreign_corp_key_props,left.Proxid=right.Proxid,take_DC_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(DE_foreign_corp_key NOT IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key)),DE_foreign_corp_key,Proxid,DE_foreign_corp_key_props); // For every DID find the best FULL DE_foreign_corp_key
layout_withpropvars take_DE_foreign_corp_key(with_props le,DE_foreign_corp_key_props ri) := TRANSFORM
  SELF.DE_foreign_corp_key := IF ( le.DE_foreign_corp_key IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.DE_foreign_corp_key, le.DE_foreign_corp_key );
  SELF.DE_foreign_corp_key_prop := le.DE_foreign_corp_key_prop + IF ( le.DE_foreign_corp_key IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key) and ri.DE_foreign_corp_key NOT IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj38 := JOIN(pj37,DE_foreign_corp_key_props,left.Proxid=right.Proxid,take_DE_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(FL_foreign_corp_key NOT IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key)),FL_foreign_corp_key,Proxid,FL_foreign_corp_key_props); // For every DID find the best FULL FL_foreign_corp_key
layout_withpropvars take_FL_foreign_corp_key(with_props le,FL_foreign_corp_key_props ri) := TRANSFORM
  SELF.FL_foreign_corp_key := IF ( le.FL_foreign_corp_key IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.FL_foreign_corp_key, le.FL_foreign_corp_key );
  SELF.FL_foreign_corp_key_prop := le.FL_foreign_corp_key_prop + IF ( le.FL_foreign_corp_key IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key) and ri.FL_foreign_corp_key NOT IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj39 := JOIN(pj38,FL_foreign_corp_key_props,left.Proxid=right.Proxid,take_FL_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(GA_foreign_corp_key NOT IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key)),GA_foreign_corp_key,Proxid,GA_foreign_corp_key_props); // For every DID find the best FULL GA_foreign_corp_key
layout_withpropvars take_GA_foreign_corp_key(with_props le,GA_foreign_corp_key_props ri) := TRANSFORM
  SELF.GA_foreign_corp_key := IF ( le.GA_foreign_corp_key IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.GA_foreign_corp_key, le.GA_foreign_corp_key );
  SELF.GA_foreign_corp_key_prop := le.GA_foreign_corp_key_prop + IF ( le.GA_foreign_corp_key IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key) and ri.GA_foreign_corp_key NOT IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj40 := JOIN(pj39,GA_foreign_corp_key_props,left.Proxid=right.Proxid,take_GA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(HI_foreign_corp_key NOT IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key)),HI_foreign_corp_key,Proxid,HI_foreign_corp_key_props); // For every DID find the best FULL HI_foreign_corp_key
layout_withpropvars take_HI_foreign_corp_key(with_props le,HI_foreign_corp_key_props ri) := TRANSFORM
  SELF.HI_foreign_corp_key := IF ( le.HI_foreign_corp_key IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.HI_foreign_corp_key, le.HI_foreign_corp_key );
  SELF.HI_foreign_corp_key_prop := le.HI_foreign_corp_key_prop + IF ( le.HI_foreign_corp_key IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key) and ri.HI_foreign_corp_key NOT IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj41 := JOIN(pj40,HI_foreign_corp_key_props,left.Proxid=right.Proxid,take_HI_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(IA_foreign_corp_key NOT IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key)),IA_foreign_corp_key,Proxid,IA_foreign_corp_key_props); // For every DID find the best FULL IA_foreign_corp_key
layout_withpropvars take_IA_foreign_corp_key(with_props le,IA_foreign_corp_key_props ri) := TRANSFORM
  SELF.IA_foreign_corp_key := IF ( le.IA_foreign_corp_key IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.IA_foreign_corp_key, le.IA_foreign_corp_key );
  SELF.IA_foreign_corp_key_prop := le.IA_foreign_corp_key_prop + IF ( le.IA_foreign_corp_key IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key) and ri.IA_foreign_corp_key NOT IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj42 := JOIN(pj41,IA_foreign_corp_key_props,left.Proxid=right.Proxid,take_IA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(ID_foreign_corp_key NOT IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key)),ID_foreign_corp_key,Proxid,ID_foreign_corp_key_props); // For every DID find the best FULL ID_foreign_corp_key
layout_withpropvars take_ID_foreign_corp_key(with_props le,ID_foreign_corp_key_props ri) := TRANSFORM
  SELF.ID_foreign_corp_key := IF ( le.ID_foreign_corp_key IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ID_foreign_corp_key, le.ID_foreign_corp_key );
  SELF.ID_foreign_corp_key_prop := le.ID_foreign_corp_key_prop + IF ( le.ID_foreign_corp_key IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key) and ri.ID_foreign_corp_key NOT IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj43 := JOIN(pj42,ID_foreign_corp_key_props,left.Proxid=right.Proxid,take_ID_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(IL_foreign_corp_key NOT IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key)),IL_foreign_corp_key,Proxid,IL_foreign_corp_key_props); // For every DID find the best FULL IL_foreign_corp_key
layout_withpropvars take_IL_foreign_corp_key(with_props le,IL_foreign_corp_key_props ri) := TRANSFORM
  SELF.IL_foreign_corp_key := IF ( le.IL_foreign_corp_key IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.IL_foreign_corp_key, le.IL_foreign_corp_key );
  SELF.IL_foreign_corp_key_prop := le.IL_foreign_corp_key_prop + IF ( le.IL_foreign_corp_key IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key) and ri.IL_foreign_corp_key NOT IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj44 := JOIN(pj43,IL_foreign_corp_key_props,left.Proxid=right.Proxid,take_IL_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(IN_foreign_corp_key NOT IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key)),IN_foreign_corp_key,Proxid,IN_foreign_corp_key_props); // For every DID find the best FULL IN_foreign_corp_key
layout_withpropvars take_IN_foreign_corp_key(with_props le,IN_foreign_corp_key_props ri) := TRANSFORM
  SELF.IN_foreign_corp_key := IF ( le.IN_foreign_corp_key IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.IN_foreign_corp_key, le.IN_foreign_corp_key );
  SELF.IN_foreign_corp_key_prop := le.IN_foreign_corp_key_prop + IF ( le.IN_foreign_corp_key IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key) and ri.IN_foreign_corp_key NOT IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj45 := JOIN(pj44,IN_foreign_corp_key_props,left.Proxid=right.Proxid,take_IN_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(KS_foreign_corp_key NOT IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key)),KS_foreign_corp_key,Proxid,KS_foreign_corp_key_props); // For every DID find the best FULL KS_foreign_corp_key
layout_withpropvars take_KS_foreign_corp_key(with_props le,KS_foreign_corp_key_props ri) := TRANSFORM
  SELF.KS_foreign_corp_key := IF ( le.KS_foreign_corp_key IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.KS_foreign_corp_key, le.KS_foreign_corp_key );
  SELF.KS_foreign_corp_key_prop := le.KS_foreign_corp_key_prop + IF ( le.KS_foreign_corp_key IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key) and ri.KS_foreign_corp_key NOT IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj46 := JOIN(pj45,KS_foreign_corp_key_props,left.Proxid=right.Proxid,take_KS_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(KY_foreign_corp_key NOT IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key)),KY_foreign_corp_key,Proxid,KY_foreign_corp_key_props); // For every DID find the best FULL KY_foreign_corp_key
layout_withpropvars take_KY_foreign_corp_key(with_props le,KY_foreign_corp_key_props ri) := TRANSFORM
  SELF.KY_foreign_corp_key := IF ( le.KY_foreign_corp_key IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.KY_foreign_corp_key, le.KY_foreign_corp_key );
  SELF.KY_foreign_corp_key_prop := le.KY_foreign_corp_key_prop + IF ( le.KY_foreign_corp_key IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key) and ri.KY_foreign_corp_key NOT IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj47 := JOIN(pj46,KY_foreign_corp_key_props,left.Proxid=right.Proxid,take_KY_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(LA_foreign_corp_key NOT IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key)),LA_foreign_corp_key,Proxid,LA_foreign_corp_key_props); // For every DID find the best FULL LA_foreign_corp_key
layout_withpropvars take_LA_foreign_corp_key(with_props le,LA_foreign_corp_key_props ri) := TRANSFORM
  SELF.LA_foreign_corp_key := IF ( le.LA_foreign_corp_key IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.LA_foreign_corp_key, le.LA_foreign_corp_key );
  SELF.LA_foreign_corp_key_prop := le.LA_foreign_corp_key_prop + IF ( le.LA_foreign_corp_key IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key) and ri.LA_foreign_corp_key NOT IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj48 := JOIN(pj47,LA_foreign_corp_key_props,left.Proxid=right.Proxid,take_LA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MA_foreign_corp_key NOT IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key)),MA_foreign_corp_key,Proxid,MA_foreign_corp_key_props); // For every DID find the best FULL MA_foreign_corp_key
layout_withpropvars take_MA_foreign_corp_key(with_props le,MA_foreign_corp_key_props ri) := TRANSFORM
  SELF.MA_foreign_corp_key := IF ( le.MA_foreign_corp_key IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MA_foreign_corp_key, le.MA_foreign_corp_key );
  SELF.MA_foreign_corp_key_prop := le.MA_foreign_corp_key_prop + IF ( le.MA_foreign_corp_key IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key) and ri.MA_foreign_corp_key NOT IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj49 := JOIN(pj48,MA_foreign_corp_key_props,left.Proxid=right.Proxid,take_MA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MD_foreign_corp_key NOT IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key)),MD_foreign_corp_key,Proxid,MD_foreign_corp_key_props); // For every DID find the best FULL MD_foreign_corp_key
layout_withpropvars take_MD_foreign_corp_key(with_props le,MD_foreign_corp_key_props ri) := TRANSFORM
  SELF.MD_foreign_corp_key := IF ( le.MD_foreign_corp_key IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MD_foreign_corp_key, le.MD_foreign_corp_key );
  SELF.MD_foreign_corp_key_prop := le.MD_foreign_corp_key_prop + IF ( le.MD_foreign_corp_key IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key) and ri.MD_foreign_corp_key NOT IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj50 := JOIN(pj49,MD_foreign_corp_key_props,left.Proxid=right.Proxid,take_MD_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(ME_foreign_corp_key NOT IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key)),ME_foreign_corp_key,Proxid,ME_foreign_corp_key_props); // For every DID find the best FULL ME_foreign_corp_key
layout_withpropvars take_ME_foreign_corp_key(with_props le,ME_foreign_corp_key_props ri) := TRANSFORM
  SELF.ME_foreign_corp_key := IF ( le.ME_foreign_corp_key IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ME_foreign_corp_key, le.ME_foreign_corp_key );
  SELF.ME_foreign_corp_key_prop := le.ME_foreign_corp_key_prop + IF ( le.ME_foreign_corp_key IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key) and ri.ME_foreign_corp_key NOT IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj51 := JOIN(pj50,ME_foreign_corp_key_props,left.Proxid=right.Proxid,take_ME_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MI_foreign_corp_key NOT IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key)),MI_foreign_corp_key,Proxid,MI_foreign_corp_key_props); // For every DID find the best FULL MI_foreign_corp_key
layout_withpropvars take_MI_foreign_corp_key(with_props le,MI_foreign_corp_key_props ri) := TRANSFORM
  SELF.MI_foreign_corp_key := IF ( le.MI_foreign_corp_key IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MI_foreign_corp_key, le.MI_foreign_corp_key );
  SELF.MI_foreign_corp_key_prop := le.MI_foreign_corp_key_prop + IF ( le.MI_foreign_corp_key IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key) and ri.MI_foreign_corp_key NOT IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj52 := JOIN(pj51,MI_foreign_corp_key_props,left.Proxid=right.Proxid,take_MI_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MN_foreign_corp_key NOT IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key)),MN_foreign_corp_key,Proxid,MN_foreign_corp_key_props); // For every DID find the best FULL MN_foreign_corp_key
layout_withpropvars take_MN_foreign_corp_key(with_props le,MN_foreign_corp_key_props ri) := TRANSFORM
  SELF.MN_foreign_corp_key := IF ( le.MN_foreign_corp_key IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MN_foreign_corp_key, le.MN_foreign_corp_key );
  SELF.MN_foreign_corp_key_prop := le.MN_foreign_corp_key_prop + IF ( le.MN_foreign_corp_key IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key) and ri.MN_foreign_corp_key NOT IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj53 := JOIN(pj52,MN_foreign_corp_key_props,left.Proxid=right.Proxid,take_MN_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MO_foreign_corp_key NOT IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key)),MO_foreign_corp_key,Proxid,MO_foreign_corp_key_props); // For every DID find the best FULL MO_foreign_corp_key
layout_withpropvars take_MO_foreign_corp_key(with_props le,MO_foreign_corp_key_props ri) := TRANSFORM
  SELF.MO_foreign_corp_key := IF ( le.MO_foreign_corp_key IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MO_foreign_corp_key, le.MO_foreign_corp_key );
  SELF.MO_foreign_corp_key_prop := le.MO_foreign_corp_key_prop + IF ( le.MO_foreign_corp_key IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key) and ri.MO_foreign_corp_key NOT IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj54 := JOIN(pj53,MO_foreign_corp_key_props,left.Proxid=right.Proxid,take_MO_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MS_foreign_corp_key NOT IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key)),MS_foreign_corp_key,Proxid,MS_foreign_corp_key_props); // For every DID find the best FULL MS_foreign_corp_key
layout_withpropvars take_MS_foreign_corp_key(with_props le,MS_foreign_corp_key_props ri) := TRANSFORM
  SELF.MS_foreign_corp_key := IF ( le.MS_foreign_corp_key IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MS_foreign_corp_key, le.MS_foreign_corp_key );
  SELF.MS_foreign_corp_key_prop := le.MS_foreign_corp_key_prop + IF ( le.MS_foreign_corp_key IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key) and ri.MS_foreign_corp_key NOT IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj55 := JOIN(pj54,MS_foreign_corp_key_props,left.Proxid=right.Proxid,take_MS_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(MT_foreign_corp_key NOT IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key)),MT_foreign_corp_key,Proxid,MT_foreign_corp_key_props); // For every DID find the best FULL MT_foreign_corp_key
layout_withpropvars take_MT_foreign_corp_key(with_props le,MT_foreign_corp_key_props ri) := TRANSFORM
  SELF.MT_foreign_corp_key := IF ( le.MT_foreign_corp_key IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.MT_foreign_corp_key, le.MT_foreign_corp_key );
  SELF.MT_foreign_corp_key_prop := le.MT_foreign_corp_key_prop + IF ( le.MT_foreign_corp_key IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key) and ri.MT_foreign_corp_key NOT IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj56 := JOIN(pj55,MT_foreign_corp_key_props,left.Proxid=right.Proxid,take_MT_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NC_foreign_corp_key NOT IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key)),NC_foreign_corp_key,Proxid,NC_foreign_corp_key_props); // For every DID find the best FULL NC_foreign_corp_key
layout_withpropvars take_NC_foreign_corp_key(with_props le,NC_foreign_corp_key_props ri) := TRANSFORM
  SELF.NC_foreign_corp_key := IF ( le.NC_foreign_corp_key IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NC_foreign_corp_key, le.NC_foreign_corp_key );
  SELF.NC_foreign_corp_key_prop := le.NC_foreign_corp_key_prop + IF ( le.NC_foreign_corp_key IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key) and ri.NC_foreign_corp_key NOT IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj57 := JOIN(pj56,NC_foreign_corp_key_props,left.Proxid=right.Proxid,take_NC_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(ND_foreign_corp_key NOT IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key)),ND_foreign_corp_key,Proxid,ND_foreign_corp_key_props); // For every DID find the best FULL ND_foreign_corp_key
layout_withpropvars take_ND_foreign_corp_key(with_props le,ND_foreign_corp_key_props ri) := TRANSFORM
  SELF.ND_foreign_corp_key := IF ( le.ND_foreign_corp_key IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.ND_foreign_corp_key, le.ND_foreign_corp_key );
  SELF.ND_foreign_corp_key_prop := le.ND_foreign_corp_key_prop + IF ( le.ND_foreign_corp_key IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key) and ri.ND_foreign_corp_key NOT IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj58 := JOIN(pj57,ND_foreign_corp_key_props,left.Proxid=right.Proxid,take_ND_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NE_foreign_corp_key NOT IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key)),NE_foreign_corp_key,Proxid,NE_foreign_corp_key_props); // For every DID find the best FULL NE_foreign_corp_key
layout_withpropvars take_NE_foreign_corp_key(with_props le,NE_foreign_corp_key_props ri) := TRANSFORM
  SELF.NE_foreign_corp_key := IF ( le.NE_foreign_corp_key IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NE_foreign_corp_key, le.NE_foreign_corp_key );
  SELF.NE_foreign_corp_key_prop := le.NE_foreign_corp_key_prop + IF ( le.NE_foreign_corp_key IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key) and ri.NE_foreign_corp_key NOT IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj59 := JOIN(pj58,NE_foreign_corp_key_props,left.Proxid=right.Proxid,take_NE_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NH_foreign_corp_key NOT IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key)),NH_foreign_corp_key,Proxid,NH_foreign_corp_key_props); // For every DID find the best FULL NH_foreign_corp_key
layout_withpropvars take_NH_foreign_corp_key(with_props le,NH_foreign_corp_key_props ri) := TRANSFORM
  SELF.NH_foreign_corp_key := IF ( le.NH_foreign_corp_key IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NH_foreign_corp_key, le.NH_foreign_corp_key );
  SELF.NH_foreign_corp_key_prop := le.NH_foreign_corp_key_prop + IF ( le.NH_foreign_corp_key IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key) and ri.NH_foreign_corp_key NOT IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj60 := JOIN(pj59,NH_foreign_corp_key_props,left.Proxid=right.Proxid,take_NH_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NJ_foreign_corp_key NOT IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key)),NJ_foreign_corp_key,Proxid,NJ_foreign_corp_key_props); // For every DID find the best FULL NJ_foreign_corp_key
layout_withpropvars take_NJ_foreign_corp_key(with_props le,NJ_foreign_corp_key_props ri) := TRANSFORM
  SELF.NJ_foreign_corp_key := IF ( le.NJ_foreign_corp_key IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NJ_foreign_corp_key, le.NJ_foreign_corp_key );
  SELF.NJ_foreign_corp_key_prop := le.NJ_foreign_corp_key_prop + IF ( le.NJ_foreign_corp_key IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key) and ri.NJ_foreign_corp_key NOT IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj61 := JOIN(pj60,NJ_foreign_corp_key_props,left.Proxid=right.Proxid,take_NJ_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NM_foreign_corp_key NOT IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key)),NM_foreign_corp_key,Proxid,NM_foreign_corp_key_props); // For every DID find the best FULL NM_foreign_corp_key
layout_withpropvars take_NM_foreign_corp_key(with_props le,NM_foreign_corp_key_props ri) := TRANSFORM
  SELF.NM_foreign_corp_key := IF ( le.NM_foreign_corp_key IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NM_foreign_corp_key, le.NM_foreign_corp_key );
  SELF.NM_foreign_corp_key_prop := le.NM_foreign_corp_key_prop + IF ( le.NM_foreign_corp_key IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key) and ri.NM_foreign_corp_key NOT IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj62 := JOIN(pj61,NM_foreign_corp_key_props,left.Proxid=right.Proxid,take_NM_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NV_foreign_corp_key NOT IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key)),NV_foreign_corp_key,Proxid,NV_foreign_corp_key_props); // For every DID find the best FULL NV_foreign_corp_key
layout_withpropvars take_NV_foreign_corp_key(with_props le,NV_foreign_corp_key_props ri) := TRANSFORM
  SELF.NV_foreign_corp_key := IF ( le.NV_foreign_corp_key IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NV_foreign_corp_key, le.NV_foreign_corp_key );
  SELF.NV_foreign_corp_key_prop := le.NV_foreign_corp_key_prop + IF ( le.NV_foreign_corp_key IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key) and ri.NV_foreign_corp_key NOT IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj63 := JOIN(pj62,NV_foreign_corp_key_props,left.Proxid=right.Proxid,take_NV_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(NY_foreign_corp_key NOT IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key)),NY_foreign_corp_key,Proxid,NY_foreign_corp_key_props); // For every DID find the best FULL NY_foreign_corp_key
layout_withpropvars take_NY_foreign_corp_key(with_props le,NY_foreign_corp_key_props ri) := TRANSFORM
  SELF.NY_foreign_corp_key := IF ( le.NY_foreign_corp_key IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.NY_foreign_corp_key, le.NY_foreign_corp_key );
  SELF.NY_foreign_corp_key_prop := le.NY_foreign_corp_key_prop + IF ( le.NY_foreign_corp_key IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key) and ri.NY_foreign_corp_key NOT IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj64 := JOIN(pj63,NY_foreign_corp_key_props,left.Proxid=right.Proxid,take_NY_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(OH_foreign_corp_key NOT IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key)),OH_foreign_corp_key,Proxid,OH_foreign_corp_key_props); // For every DID find the best FULL OH_foreign_corp_key
layout_withpropvars take_OH_foreign_corp_key(with_props le,OH_foreign_corp_key_props ri) := TRANSFORM
  SELF.OH_foreign_corp_key := IF ( le.OH_foreign_corp_key IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.OH_foreign_corp_key, le.OH_foreign_corp_key );
  SELF.OH_foreign_corp_key_prop := le.OH_foreign_corp_key_prop + IF ( le.OH_foreign_corp_key IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key) and ri.OH_foreign_corp_key NOT IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj65 := JOIN(pj64,OH_foreign_corp_key_props,left.Proxid=right.Proxid,take_OH_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(OK_foreign_corp_key NOT IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key)),OK_foreign_corp_key,Proxid,OK_foreign_corp_key_props); // For every DID find the best FULL OK_foreign_corp_key
layout_withpropvars take_OK_foreign_corp_key(with_props le,OK_foreign_corp_key_props ri) := TRANSFORM
  SELF.OK_foreign_corp_key := IF ( le.OK_foreign_corp_key IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.OK_foreign_corp_key, le.OK_foreign_corp_key );
  SELF.OK_foreign_corp_key_prop := le.OK_foreign_corp_key_prop + IF ( le.OK_foreign_corp_key IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key) and ri.OK_foreign_corp_key NOT IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj66 := JOIN(pj65,OK_foreign_corp_key_props,left.Proxid=right.Proxid,take_OK_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(OR_foreign_corp_key NOT IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key)),OR_foreign_corp_key,Proxid,OR_foreign_corp_key_props); // For every DID find the best FULL OR_foreign_corp_key
layout_withpropvars take_OR_foreign_corp_key(with_props le,OR_foreign_corp_key_props ri) := TRANSFORM
  SELF.OR_foreign_corp_key := IF ( le.OR_foreign_corp_key IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.OR_foreign_corp_key, le.OR_foreign_corp_key );
  SELF.OR_foreign_corp_key_prop := le.OR_foreign_corp_key_prop + IF ( le.OR_foreign_corp_key IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key) and ri.OR_foreign_corp_key NOT IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj67 := JOIN(pj66,OR_foreign_corp_key_props,left.Proxid=right.Proxid,take_OR_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(PA_foreign_corp_key NOT IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key)),PA_foreign_corp_key,Proxid,PA_foreign_corp_key_props); // For every DID find the best FULL PA_foreign_corp_key
layout_withpropvars take_PA_foreign_corp_key(with_props le,PA_foreign_corp_key_props ri) := TRANSFORM
  SELF.PA_foreign_corp_key := IF ( le.PA_foreign_corp_key IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.PA_foreign_corp_key, le.PA_foreign_corp_key );
  SELF.PA_foreign_corp_key_prop := le.PA_foreign_corp_key_prop + IF ( le.PA_foreign_corp_key IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key) and ri.PA_foreign_corp_key NOT IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj68 := JOIN(pj67,PA_foreign_corp_key_props,left.Proxid=right.Proxid,take_PA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(PR_foreign_corp_key NOT IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key)),PR_foreign_corp_key,Proxid,PR_foreign_corp_key_props); // For every DID find the best FULL PR_foreign_corp_key
layout_withpropvars take_PR_foreign_corp_key(with_props le,PR_foreign_corp_key_props ri) := TRANSFORM
  SELF.PR_foreign_corp_key := IF ( le.PR_foreign_corp_key IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.PR_foreign_corp_key, le.PR_foreign_corp_key );
  SELF.PR_foreign_corp_key_prop := le.PR_foreign_corp_key_prop + IF ( le.PR_foreign_corp_key IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key) and ri.PR_foreign_corp_key NOT IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj69 := JOIN(pj68,PR_foreign_corp_key_props,left.Proxid=right.Proxid,take_PR_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(RI_foreign_corp_key NOT IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key)),RI_foreign_corp_key,Proxid,RI_foreign_corp_key_props); // For every DID find the best FULL RI_foreign_corp_key
layout_withpropvars take_RI_foreign_corp_key(with_props le,RI_foreign_corp_key_props ri) := TRANSFORM
  SELF.RI_foreign_corp_key := IF ( le.RI_foreign_corp_key IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.RI_foreign_corp_key, le.RI_foreign_corp_key );
  SELF.RI_foreign_corp_key_prop := le.RI_foreign_corp_key_prop + IF ( le.RI_foreign_corp_key IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key) and ri.RI_foreign_corp_key NOT IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj70 := JOIN(pj69,RI_foreign_corp_key_props,left.Proxid=right.Proxid,take_RI_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(SC_foreign_corp_key NOT IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key)),SC_foreign_corp_key,Proxid,SC_foreign_corp_key_props); // For every DID find the best FULL SC_foreign_corp_key
layout_withpropvars take_SC_foreign_corp_key(with_props le,SC_foreign_corp_key_props ri) := TRANSFORM
  SELF.SC_foreign_corp_key := IF ( le.SC_foreign_corp_key IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.SC_foreign_corp_key, le.SC_foreign_corp_key );
  SELF.SC_foreign_corp_key_prop := le.SC_foreign_corp_key_prop + IF ( le.SC_foreign_corp_key IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key) and ri.SC_foreign_corp_key NOT IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj71 := JOIN(pj70,SC_foreign_corp_key_props,left.Proxid=right.Proxid,take_SC_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(SD_foreign_corp_key NOT IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key)),SD_foreign_corp_key,Proxid,SD_foreign_corp_key_props); // For every DID find the best FULL SD_foreign_corp_key
layout_withpropvars take_SD_foreign_corp_key(with_props le,SD_foreign_corp_key_props ri) := TRANSFORM
  SELF.SD_foreign_corp_key := IF ( le.SD_foreign_corp_key IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.SD_foreign_corp_key, le.SD_foreign_corp_key );
  SELF.SD_foreign_corp_key_prop := le.SD_foreign_corp_key_prop + IF ( le.SD_foreign_corp_key IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key) and ri.SD_foreign_corp_key NOT IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj72 := JOIN(pj71,SD_foreign_corp_key_props,left.Proxid=right.Proxid,take_SD_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(TN_foreign_corp_key NOT IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key)),TN_foreign_corp_key,Proxid,TN_foreign_corp_key_props); // For every DID find the best FULL TN_foreign_corp_key
layout_withpropvars take_TN_foreign_corp_key(with_props le,TN_foreign_corp_key_props ri) := TRANSFORM
  SELF.TN_foreign_corp_key := IF ( le.TN_foreign_corp_key IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.TN_foreign_corp_key, le.TN_foreign_corp_key );
  SELF.TN_foreign_corp_key_prop := le.TN_foreign_corp_key_prop + IF ( le.TN_foreign_corp_key IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key) and ri.TN_foreign_corp_key NOT IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj73 := JOIN(pj72,TN_foreign_corp_key_props,left.Proxid=right.Proxid,take_TN_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(TX_foreign_corp_key NOT IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key)),TX_foreign_corp_key,Proxid,TX_foreign_corp_key_props); // For every DID find the best FULL TX_foreign_corp_key
layout_withpropvars take_TX_foreign_corp_key(with_props le,TX_foreign_corp_key_props ri) := TRANSFORM
  SELF.TX_foreign_corp_key := IF ( le.TX_foreign_corp_key IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.TX_foreign_corp_key, le.TX_foreign_corp_key );
  SELF.TX_foreign_corp_key_prop := le.TX_foreign_corp_key_prop + IF ( le.TX_foreign_corp_key IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key) and ri.TX_foreign_corp_key NOT IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj74 := JOIN(pj73,TX_foreign_corp_key_props,left.Proxid=right.Proxid,take_TX_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(UT_foreign_corp_key NOT IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key)),UT_foreign_corp_key,Proxid,UT_foreign_corp_key_props); // For every DID find the best FULL UT_foreign_corp_key
layout_withpropvars take_UT_foreign_corp_key(with_props le,UT_foreign_corp_key_props ri) := TRANSFORM
  SELF.UT_foreign_corp_key := IF ( le.UT_foreign_corp_key IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.UT_foreign_corp_key, le.UT_foreign_corp_key );
  SELF.UT_foreign_corp_key_prop := le.UT_foreign_corp_key_prop + IF ( le.UT_foreign_corp_key IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key) and ri.UT_foreign_corp_key NOT IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj75 := JOIN(pj74,UT_foreign_corp_key_props,left.Proxid=right.Proxid,take_UT_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(VA_foreign_corp_key NOT IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key)),VA_foreign_corp_key,Proxid,VA_foreign_corp_key_props); // For every DID find the best FULL VA_foreign_corp_key
layout_withpropvars take_VA_foreign_corp_key(with_props le,VA_foreign_corp_key_props ri) := TRANSFORM
  SELF.VA_foreign_corp_key := IF ( le.VA_foreign_corp_key IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.VA_foreign_corp_key, le.VA_foreign_corp_key );
  SELF.VA_foreign_corp_key_prop := le.VA_foreign_corp_key_prop + IF ( le.VA_foreign_corp_key IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key) and ri.VA_foreign_corp_key NOT IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj76 := JOIN(pj75,VA_foreign_corp_key_props,left.Proxid=right.Proxid,take_VA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(VI_foreign_corp_key NOT IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key)),VI_foreign_corp_key,Proxid,VI_foreign_corp_key_props); // For every DID find the best FULL VI_foreign_corp_key
layout_withpropvars take_VI_foreign_corp_key(with_props le,VI_foreign_corp_key_props ri) := TRANSFORM
  SELF.VI_foreign_corp_key := IF ( le.VI_foreign_corp_key IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.VI_foreign_corp_key, le.VI_foreign_corp_key );
  SELF.VI_foreign_corp_key_prop := le.VI_foreign_corp_key_prop + IF ( le.VI_foreign_corp_key IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key) and ri.VI_foreign_corp_key NOT IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj77 := JOIN(pj76,VI_foreign_corp_key_props,left.Proxid=right.Proxid,take_VI_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(VT_foreign_corp_key NOT IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key)),VT_foreign_corp_key,Proxid,VT_foreign_corp_key_props); // For every DID find the best FULL VT_foreign_corp_key
layout_withpropvars take_VT_foreign_corp_key(with_props le,VT_foreign_corp_key_props ri) := TRANSFORM
  SELF.VT_foreign_corp_key := IF ( le.VT_foreign_corp_key IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.VT_foreign_corp_key, le.VT_foreign_corp_key );
  SELF.VT_foreign_corp_key_prop := le.VT_foreign_corp_key_prop + IF ( le.VT_foreign_corp_key IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key) and ri.VT_foreign_corp_key NOT IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj78 := JOIN(pj77,VT_foreign_corp_key_props,left.Proxid=right.Proxid,take_VT_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(WA_foreign_corp_key NOT IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key)),WA_foreign_corp_key,Proxid,WA_foreign_corp_key_props); // For every DID find the best FULL WA_foreign_corp_key
layout_withpropvars take_WA_foreign_corp_key(with_props le,WA_foreign_corp_key_props ri) := TRANSFORM
  SELF.WA_foreign_corp_key := IF ( le.WA_foreign_corp_key IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.WA_foreign_corp_key, le.WA_foreign_corp_key );
  SELF.WA_foreign_corp_key_prop := le.WA_foreign_corp_key_prop + IF ( le.WA_foreign_corp_key IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key) and ri.WA_foreign_corp_key NOT IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj79 := JOIN(pj78,WA_foreign_corp_key_props,left.Proxid=right.Proxid,take_WA_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(WI_foreign_corp_key NOT IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key)),WI_foreign_corp_key,Proxid,WI_foreign_corp_key_props); // For every DID find the best FULL WI_foreign_corp_key
layout_withpropvars take_WI_foreign_corp_key(with_props le,WI_foreign_corp_key_props ri) := TRANSFORM
  SELF.WI_foreign_corp_key := IF ( le.WI_foreign_corp_key IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.WI_foreign_corp_key, le.WI_foreign_corp_key );
  SELF.WI_foreign_corp_key_prop := le.WI_foreign_corp_key_prop + IF ( le.WI_foreign_corp_key IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key) and ri.WI_foreign_corp_key NOT IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj80 := JOIN(pj79,WI_foreign_corp_key_props,left.Proxid=right.Proxid,take_WI_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(WV_foreign_corp_key NOT IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key)),WV_foreign_corp_key,Proxid,WV_foreign_corp_key_props); // For every DID find the best FULL WV_foreign_corp_key
layout_withpropvars take_WV_foreign_corp_key(with_props le,WV_foreign_corp_key_props ri) := TRANSFORM
  SELF.WV_foreign_corp_key := IF ( le.WV_foreign_corp_key IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.WV_foreign_corp_key, le.WV_foreign_corp_key );
  SELF.WV_foreign_corp_key_prop := le.WV_foreign_corp_key_prop + IF ( le.WV_foreign_corp_key IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key) and ri.WV_foreign_corp_key NOT IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj81 := JOIN(pj80,WV_foreign_corp_key_props,left.Proxid=right.Proxid,take_WV_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
SALT26.mac_prop_field(with_props(WY_foreign_corp_key NOT IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key)),WY_foreign_corp_key,Proxid,WY_foreign_corp_key_props); // For every DID find the best FULL WY_foreign_corp_key
layout_withpropvars take_WY_foreign_corp_key(with_props le,WY_foreign_corp_key_props ri) := TRANSFORM
  SELF.WY_foreign_corp_key := IF ( le.WY_foreign_corp_key IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.WY_foreign_corp_key, le.WY_foreign_corp_key );
  SELF.WY_foreign_corp_key_prop := le.WY_foreign_corp_key_prop + IF ( le.WY_foreign_corp_key IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key) and ri.WY_foreign_corp_key NOT IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj82 := JOIN(pj81,WY_foreign_corp_key_props,left.Proxid=right.Proxid,take_WY_foreign_corp_key(left,right),LEFT OUTER,HASH);
 
pj82 do_computes(pj82 le) := TRANSFORM
  SELF.company_csz := HASH32((SALT26.StrType)le.v_city_name,(SALT26.StrType)le.st,(SALT26.StrType)le.zip); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT26.StrType)le.prim_range,(SALT26.StrType)le.prim_name,(SALT26.StrType)le.sec_range); // Combine child fields into 1 for specificity counting
  self.company_addr1_prop := IF( le.sec_range_prop > 0, 4, 0 );
  SELF.company_address := HASH32((SALT26.StrType)SELF.company_addr1,(SALT26.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  self.company_address_prop := IF( self.company_addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj82,do_computes(left)) : PERSIST('temp::BIPV2_ProxID_dev3_Proxid_DOT_Base_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(propogated.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_phone_pop := AVE(GROUP,IF(propogated.company_phone IN SET(s.nulls_company_phone,company_phone),0,100));
  REAL8 iscorp_pop := AVE(GROUP,IF(propogated.iscorp IN SET(s.nulls_iscorp,iscorp),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(propogated.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(propogated.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(propogated.company_address IN SET(s.nulls_company_address,company_address),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(propogated.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(propogated.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 hist_enterprise_number_pop := AVE(GROUP,IF(propogated.hist_enterprise_number IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number),0,100));
  REAL8 hist_duns_number_pop := AVE(GROUP,IF(propogated.hist_duns_number IN SET(s.nulls_hist_duns_number,hist_duns_number),0,100));
  REAL8 ebr_file_number_pop := AVE(GROUP,IF(propogated.ebr_file_number IN SET(s.nulls_ebr_file_number,ebr_file_number),0,100));
  REAL8 domestic_corp_key_pop := AVE(GROUP,IF(propogated.domestic_corp_key IN SET(s.nulls_domestic_corp_key,domestic_corp_key),0,100));
  REAL8 AK_foreign_corp_key_pop := AVE(GROUP,IF(propogated.AK_foreign_corp_key IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key),0,100));
  REAL8 AL_foreign_corp_key_pop := AVE(GROUP,IF(propogated.AL_foreign_corp_key IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key),0,100));
  REAL8 AR_foreign_corp_key_pop := AVE(GROUP,IF(propogated.AR_foreign_corp_key IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key),0,100));
  REAL8 AZ_foreign_corp_key_pop := AVE(GROUP,IF(propogated.AZ_foreign_corp_key IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key),0,100));
  REAL8 CA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.CA_foreign_corp_key IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key),0,100));
  REAL8 CO_foreign_corp_key_pop := AVE(GROUP,IF(propogated.CO_foreign_corp_key IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key),0,100));
  REAL8 CT_foreign_corp_key_pop := AVE(GROUP,IF(propogated.CT_foreign_corp_key IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key),0,100));
  REAL8 DC_foreign_corp_key_pop := AVE(GROUP,IF(propogated.DC_foreign_corp_key IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key),0,100));
  REAL8 DE_foreign_corp_key_pop := AVE(GROUP,IF(propogated.DE_foreign_corp_key IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key),0,100));
  REAL8 FL_foreign_corp_key_pop := AVE(GROUP,IF(propogated.FL_foreign_corp_key IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key),0,100));
  REAL8 GA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.GA_foreign_corp_key IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key),0,100));
  REAL8 HI_foreign_corp_key_pop := AVE(GROUP,IF(propogated.HI_foreign_corp_key IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key),0,100));
  REAL8 IA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.IA_foreign_corp_key IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key),0,100));
  REAL8 ID_foreign_corp_key_pop := AVE(GROUP,IF(propogated.ID_foreign_corp_key IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key),0,100));
  REAL8 IL_foreign_corp_key_pop := AVE(GROUP,IF(propogated.IL_foreign_corp_key IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key),0,100));
  REAL8 IN_foreign_corp_key_pop := AVE(GROUP,IF(propogated.IN_foreign_corp_key IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key),0,100));
  REAL8 KS_foreign_corp_key_pop := AVE(GROUP,IF(propogated.KS_foreign_corp_key IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key),0,100));
  REAL8 KY_foreign_corp_key_pop := AVE(GROUP,IF(propogated.KY_foreign_corp_key IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key),0,100));
  REAL8 LA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.LA_foreign_corp_key IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key),0,100));
  REAL8 MA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MA_foreign_corp_key IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key),0,100));
  REAL8 MD_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MD_foreign_corp_key IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key),0,100));
  REAL8 ME_foreign_corp_key_pop := AVE(GROUP,IF(propogated.ME_foreign_corp_key IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key),0,100));
  REAL8 MI_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MI_foreign_corp_key IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key),0,100));
  REAL8 MN_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MN_foreign_corp_key IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key),0,100));
  REAL8 MO_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MO_foreign_corp_key IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key),0,100));
  REAL8 MS_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MS_foreign_corp_key IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key),0,100));
  REAL8 MT_foreign_corp_key_pop := AVE(GROUP,IF(propogated.MT_foreign_corp_key IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key),0,100));
  REAL8 NC_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NC_foreign_corp_key IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key),0,100));
  REAL8 ND_foreign_corp_key_pop := AVE(GROUP,IF(propogated.ND_foreign_corp_key IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key),0,100));
  REAL8 NE_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NE_foreign_corp_key IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key),0,100));
  REAL8 NH_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NH_foreign_corp_key IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key),0,100));
  REAL8 NJ_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NJ_foreign_corp_key IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key),0,100));
  REAL8 NM_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NM_foreign_corp_key IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key),0,100));
  REAL8 NV_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NV_foreign_corp_key IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key),0,100));
  REAL8 NY_foreign_corp_key_pop := AVE(GROUP,IF(propogated.NY_foreign_corp_key IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key),0,100));
  REAL8 OH_foreign_corp_key_pop := AVE(GROUP,IF(propogated.OH_foreign_corp_key IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key),0,100));
  REAL8 OK_foreign_corp_key_pop := AVE(GROUP,IF(propogated.OK_foreign_corp_key IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key),0,100));
  REAL8 OR_foreign_corp_key_pop := AVE(GROUP,IF(propogated.OR_foreign_corp_key IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key),0,100));
  REAL8 PA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.PA_foreign_corp_key IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key),0,100));
  REAL8 PR_foreign_corp_key_pop := AVE(GROUP,IF(propogated.PR_foreign_corp_key IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key),0,100));
  REAL8 RI_foreign_corp_key_pop := AVE(GROUP,IF(propogated.RI_foreign_corp_key IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key),0,100));
  REAL8 SC_foreign_corp_key_pop := AVE(GROUP,IF(propogated.SC_foreign_corp_key IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key),0,100));
  REAL8 SD_foreign_corp_key_pop := AVE(GROUP,IF(propogated.SD_foreign_corp_key IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key),0,100));
  REAL8 TN_foreign_corp_key_pop := AVE(GROUP,IF(propogated.TN_foreign_corp_key IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key),0,100));
  REAL8 TX_foreign_corp_key_pop := AVE(GROUP,IF(propogated.TX_foreign_corp_key IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key),0,100));
  REAL8 UT_foreign_corp_key_pop := AVE(GROUP,IF(propogated.UT_foreign_corp_key IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key),0,100));
  REAL8 VA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.VA_foreign_corp_key IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key),0,100));
  REAL8 VI_foreign_corp_key_pop := AVE(GROUP,IF(propogated.VI_foreign_corp_key IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key),0,100));
  REAL8 VT_foreign_corp_key_pop := AVE(GROUP,IF(propogated.VT_foreign_corp_key IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key),0,100));
  REAL8 WA_foreign_corp_key_pop := AVE(GROUP,IF(propogated.WA_foreign_corp_key IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key),0,100));
  REAL8 WI_foreign_corp_key_pop := AVE(GROUP,IF(propogated.WI_foreign_corp_key IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key),0,100));
  REAL8 WV_foreign_corp_key_pop := AVE(GROUP,IF(propogated.WV_foreign_corp_key IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key),0,100));
  REAL8 WY_foreign_corp_key_pop := AVE(GROUP,IF(propogated.WY_foreign_corp_key IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(Proxid)),  EXCEPT rcid, LOCAL ), EXCEPT rcid, LOCAL );// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT26.UIDType Proxid1;
  SALT26.UIDType Proxid2;
  SALT26.UIDType rcid1 := 0;
  SALT26.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [cnp_name]; // remove wordbag fields which need to be expanded
  STRING500 cnp_name := h0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  UNSIGNED cnp_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED cnp_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := h0.company_phone  IN SET(s.nulls_company_phone,company_phone); // Simplify later processing 
  INTEGER2 iscorp_weight100 := 0; // Contains 100x the specificity
  BOOLEAN iscorp_isnull := h0.iscorp  IN SET(s.nulls_iscorp,iscorp); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip)); // Simplify later processing 
  INTEGER2 company_addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr1_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)); // Simplify later processing 
  INTEGER2 company_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_address_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)) AND (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip))); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number); // Simplify later processing 
  INTEGER2 hist_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_enterprise_number_isnull := h0.hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number); // Simplify later processing 
  INTEGER2 hist_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN hist_duns_number_isnull := h0.hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number); // Simplify later processing 
  INTEGER2 ebr_file_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ebr_file_number_isnull := h0.ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number); // Simplify later processing 
  INTEGER2 domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN domestic_corp_key_isnull := h0.domestic_corp_key  IN SET(s.nulls_domestic_corp_key,domestic_corp_key); // Simplify later processing 
  INTEGER2 AK_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN AK_foreign_corp_key_isnull := h0.AK_foreign_corp_key  IN SET(s.nulls_AK_foreign_corp_key,AK_foreign_corp_key); // Simplify later processing 
  INTEGER2 AL_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN AL_foreign_corp_key_isnull := h0.AL_foreign_corp_key  IN SET(s.nulls_AL_foreign_corp_key,AL_foreign_corp_key); // Simplify later processing 
  INTEGER2 AR_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN AR_foreign_corp_key_isnull := h0.AR_foreign_corp_key  IN SET(s.nulls_AR_foreign_corp_key,AR_foreign_corp_key); // Simplify later processing 
  INTEGER2 AZ_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN AZ_foreign_corp_key_isnull := h0.AZ_foreign_corp_key  IN SET(s.nulls_AZ_foreign_corp_key,AZ_foreign_corp_key); // Simplify later processing 
  INTEGER2 CA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CA_foreign_corp_key_isnull := h0.CA_foreign_corp_key  IN SET(s.nulls_CA_foreign_corp_key,CA_foreign_corp_key); // Simplify later processing 
  INTEGER2 CO_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CO_foreign_corp_key_isnull := h0.CO_foreign_corp_key  IN SET(s.nulls_CO_foreign_corp_key,CO_foreign_corp_key); // Simplify later processing 
  INTEGER2 CT_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CT_foreign_corp_key_isnull := h0.CT_foreign_corp_key  IN SET(s.nulls_CT_foreign_corp_key,CT_foreign_corp_key); // Simplify later processing 
  INTEGER2 DC_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DC_foreign_corp_key_isnull := h0.DC_foreign_corp_key  IN SET(s.nulls_DC_foreign_corp_key,DC_foreign_corp_key); // Simplify later processing 
  INTEGER2 DE_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN DE_foreign_corp_key_isnull := h0.DE_foreign_corp_key  IN SET(s.nulls_DE_foreign_corp_key,DE_foreign_corp_key); // Simplify later processing 
  INTEGER2 FL_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN FL_foreign_corp_key_isnull := h0.FL_foreign_corp_key  IN SET(s.nulls_FL_foreign_corp_key,FL_foreign_corp_key); // Simplify later processing 
  INTEGER2 GA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN GA_foreign_corp_key_isnull := h0.GA_foreign_corp_key  IN SET(s.nulls_GA_foreign_corp_key,GA_foreign_corp_key); // Simplify later processing 
  INTEGER2 HI_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN HI_foreign_corp_key_isnull := h0.HI_foreign_corp_key  IN SET(s.nulls_HI_foreign_corp_key,HI_foreign_corp_key); // Simplify later processing 
  INTEGER2 IA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN IA_foreign_corp_key_isnull := h0.IA_foreign_corp_key  IN SET(s.nulls_IA_foreign_corp_key,IA_foreign_corp_key); // Simplify later processing 
  INTEGER2 ID_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ID_foreign_corp_key_isnull := h0.ID_foreign_corp_key  IN SET(s.nulls_ID_foreign_corp_key,ID_foreign_corp_key); // Simplify later processing 
  INTEGER2 IL_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN IL_foreign_corp_key_isnull := h0.IL_foreign_corp_key  IN SET(s.nulls_IL_foreign_corp_key,IL_foreign_corp_key); // Simplify later processing 
  INTEGER2 IN_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN IN_foreign_corp_key_isnull := h0.IN_foreign_corp_key  IN SET(s.nulls_IN_foreign_corp_key,IN_foreign_corp_key); // Simplify later processing 
  INTEGER2 KS_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN KS_foreign_corp_key_isnull := h0.KS_foreign_corp_key  IN SET(s.nulls_KS_foreign_corp_key,KS_foreign_corp_key); // Simplify later processing 
  INTEGER2 KY_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN KY_foreign_corp_key_isnull := h0.KY_foreign_corp_key  IN SET(s.nulls_KY_foreign_corp_key,KY_foreign_corp_key); // Simplify later processing 
  INTEGER2 LA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN LA_foreign_corp_key_isnull := h0.LA_foreign_corp_key  IN SET(s.nulls_LA_foreign_corp_key,LA_foreign_corp_key); // Simplify later processing 
  INTEGER2 MA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MA_foreign_corp_key_isnull := h0.MA_foreign_corp_key  IN SET(s.nulls_MA_foreign_corp_key,MA_foreign_corp_key); // Simplify later processing 
  INTEGER2 MD_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MD_foreign_corp_key_isnull := h0.MD_foreign_corp_key  IN SET(s.nulls_MD_foreign_corp_key,MD_foreign_corp_key); // Simplify later processing 
  INTEGER2 ME_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ME_foreign_corp_key_isnull := h0.ME_foreign_corp_key  IN SET(s.nulls_ME_foreign_corp_key,ME_foreign_corp_key); // Simplify later processing 
  INTEGER2 MI_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MI_foreign_corp_key_isnull := h0.MI_foreign_corp_key  IN SET(s.nulls_MI_foreign_corp_key,MI_foreign_corp_key); // Simplify later processing 
  INTEGER2 MN_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MN_foreign_corp_key_isnull := h0.MN_foreign_corp_key  IN SET(s.nulls_MN_foreign_corp_key,MN_foreign_corp_key); // Simplify later processing 
  INTEGER2 MO_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MO_foreign_corp_key_isnull := h0.MO_foreign_corp_key  IN SET(s.nulls_MO_foreign_corp_key,MO_foreign_corp_key); // Simplify later processing 
  INTEGER2 MS_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MS_foreign_corp_key_isnull := h0.MS_foreign_corp_key  IN SET(s.nulls_MS_foreign_corp_key,MS_foreign_corp_key); // Simplify later processing 
  INTEGER2 MT_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN MT_foreign_corp_key_isnull := h0.MT_foreign_corp_key  IN SET(s.nulls_MT_foreign_corp_key,MT_foreign_corp_key); // Simplify later processing 
  INTEGER2 NC_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NC_foreign_corp_key_isnull := h0.NC_foreign_corp_key  IN SET(s.nulls_NC_foreign_corp_key,NC_foreign_corp_key); // Simplify later processing 
  INTEGER2 ND_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN ND_foreign_corp_key_isnull := h0.ND_foreign_corp_key  IN SET(s.nulls_ND_foreign_corp_key,ND_foreign_corp_key); // Simplify later processing 
  INTEGER2 NE_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NE_foreign_corp_key_isnull := h0.NE_foreign_corp_key  IN SET(s.nulls_NE_foreign_corp_key,NE_foreign_corp_key); // Simplify later processing 
  INTEGER2 NH_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NH_foreign_corp_key_isnull := h0.NH_foreign_corp_key  IN SET(s.nulls_NH_foreign_corp_key,NH_foreign_corp_key); // Simplify later processing 
  INTEGER2 NJ_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NJ_foreign_corp_key_isnull := h0.NJ_foreign_corp_key  IN SET(s.nulls_NJ_foreign_corp_key,NJ_foreign_corp_key); // Simplify later processing 
  INTEGER2 NM_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NM_foreign_corp_key_isnull := h0.NM_foreign_corp_key  IN SET(s.nulls_NM_foreign_corp_key,NM_foreign_corp_key); // Simplify later processing 
  INTEGER2 NV_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NV_foreign_corp_key_isnull := h0.NV_foreign_corp_key  IN SET(s.nulls_NV_foreign_corp_key,NV_foreign_corp_key); // Simplify later processing 
  INTEGER2 NY_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN NY_foreign_corp_key_isnull := h0.NY_foreign_corp_key  IN SET(s.nulls_NY_foreign_corp_key,NY_foreign_corp_key); // Simplify later processing 
  INTEGER2 OH_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN OH_foreign_corp_key_isnull := h0.OH_foreign_corp_key  IN SET(s.nulls_OH_foreign_corp_key,OH_foreign_corp_key); // Simplify later processing 
  INTEGER2 OK_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN OK_foreign_corp_key_isnull := h0.OK_foreign_corp_key  IN SET(s.nulls_OK_foreign_corp_key,OK_foreign_corp_key); // Simplify later processing 
  INTEGER2 OR_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN OR_foreign_corp_key_isnull := h0.OR_foreign_corp_key  IN SET(s.nulls_OR_foreign_corp_key,OR_foreign_corp_key); // Simplify later processing 
  INTEGER2 PA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PA_foreign_corp_key_isnull := h0.PA_foreign_corp_key  IN SET(s.nulls_PA_foreign_corp_key,PA_foreign_corp_key); // Simplify later processing 
  INTEGER2 PR_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN PR_foreign_corp_key_isnull := h0.PR_foreign_corp_key  IN SET(s.nulls_PR_foreign_corp_key,PR_foreign_corp_key); // Simplify later processing 
  INTEGER2 RI_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN RI_foreign_corp_key_isnull := h0.RI_foreign_corp_key  IN SET(s.nulls_RI_foreign_corp_key,RI_foreign_corp_key); // Simplify later processing 
  INTEGER2 SC_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SC_foreign_corp_key_isnull := h0.SC_foreign_corp_key  IN SET(s.nulls_SC_foreign_corp_key,SC_foreign_corp_key); // Simplify later processing 
  INTEGER2 SD_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SD_foreign_corp_key_isnull := h0.SD_foreign_corp_key  IN SET(s.nulls_SD_foreign_corp_key,SD_foreign_corp_key); // Simplify later processing 
  INTEGER2 TN_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TN_foreign_corp_key_isnull := h0.TN_foreign_corp_key  IN SET(s.nulls_TN_foreign_corp_key,TN_foreign_corp_key); // Simplify later processing 
  INTEGER2 TX_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN TX_foreign_corp_key_isnull := h0.TX_foreign_corp_key  IN SET(s.nulls_TX_foreign_corp_key,TX_foreign_corp_key); // Simplify later processing 
  INTEGER2 UT_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN UT_foreign_corp_key_isnull := h0.UT_foreign_corp_key  IN SET(s.nulls_UT_foreign_corp_key,UT_foreign_corp_key); // Simplify later processing 
  INTEGER2 VA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VA_foreign_corp_key_isnull := h0.VA_foreign_corp_key  IN SET(s.nulls_VA_foreign_corp_key,VA_foreign_corp_key); // Simplify later processing 
  INTEGER2 VI_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VI_foreign_corp_key_isnull := h0.VI_foreign_corp_key  IN SET(s.nulls_VI_foreign_corp_key,VI_foreign_corp_key); // Simplify later processing 
  INTEGER2 VT_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN VT_foreign_corp_key_isnull := h0.VT_foreign_corp_key  IN SET(s.nulls_VT_foreign_corp_key,VT_foreign_corp_key); // Simplify later processing 
  INTEGER2 WA_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN WA_foreign_corp_key_isnull := h0.WA_foreign_corp_key  IN SET(s.nulls_WA_foreign_corp_key,WA_foreign_corp_key); // Simplify later processing 
  INTEGER2 WI_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN WI_foreign_corp_key_isnull := h0.WI_foreign_corp_key  IN SET(s.nulls_WI_foreign_corp_key,WI_foreign_corp_key); // Simplify later processing 
  INTEGER2 WV_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN WV_foreign_corp_key_isnull := h0.WV_foreign_corp_key  IN SET(s.nulls_WV_foreign_corp_key,WV_foreign_corp_key); // Simplify later processing 
  INTEGER2 WY_foreign_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN WY_foreign_corp_key_isnull := h0.WY_foreign_corp_key  IN SET(s.nulls_WY_foreign_corp_key,WY_foreign_corp_key); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)(~cnp_name_isnull);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_VI_foreign_corp_key(layout_candidates le,Specificities(ih).VI_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VI_foreign_corp_key_weight100 := MAP (le.VI_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.VI_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j82 := JOIN(h1,PULL(Specificities(ih).VI_foreign_corp_key_values_persisted),LEFT.VI_foreign_corp_key=RIGHT.VI_foreign_corp_key,add_VI_foreign_corp_key(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_PR_foreign_corp_key(layout_candidates le,Specificities(ih).PR_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PR_foreign_corp_key_weight100 := MAP (le.PR_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.PR_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j81 := JOIN(j82,PULL(Specificities(ih).PR_foreign_corp_key_values_persisted),LEFT.PR_foreign_corp_key=RIGHT.PR_foreign_corp_key,add_PR_foreign_corp_key(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_OH_foreign_corp_key(layout_candidates le,Specificities(ih).OH_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.OH_foreign_corp_key_weight100 := MAP (le.OH_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.OH_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j80 := JOIN(j81,PULL(Specificities(ih).OH_foreign_corp_key_values_persisted),LEFT.OH_foreign_corp_key=RIGHT.OH_foreign_corp_key,add_OH_foreign_corp_key(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_ID_foreign_corp_key(layout_candidates le,Specificities(ih).ID_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ID_foreign_corp_key_weight100 := MAP (le.ID_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.ID_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j79 := JOIN(j80,PULL(Specificities(ih).ID_foreign_corp_key_values_persisted),LEFT.ID_foreign_corp_key=RIGHT.ID_foreign_corp_key,add_ID_foreign_corp_key(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_DE_foreign_corp_key(layout_candidates le,Specificities(ih).DE_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DE_foreign_corp_key_weight100 := MAP (le.DE_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.DE_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j78 := JOIN(j79,PULL(Specificities(ih).DE_foreign_corp_key_values_persisted),LEFT.DE_foreign_corp_key=RIGHT.DE_foreign_corp_key,add_DE_foreign_corp_key(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_iscorp(layout_candidates le,Specificities(ih).iscorp_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.iscorp_weight100 := MAP (le.iscorp_isnull => 0, patch_default and ri.field_specificity=0 => s.iscorp_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j68 := JOIN(j78,PULL(Specificities(ih).iscorp_values_persisted),LEFT.iscorp=RIGHT.iscorp,add_iscorp(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j67 := JOIN(j68,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j66 := JOIN(j67,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j66,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j65);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j65,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j64);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j64,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j63);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j63,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j62);
layout_candidates add_company_csz(layout_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j62,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_company_csz,j61);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j61,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j60);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j60,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j59);
layout_candidates add_company_addr1(layout_candidates le,Specificities(ih).company_addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr1_weight100 := MAP (le.company_addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j59,s.nulls_company_addr1,Specificities(ih).company_addr1_values_persisted,company_addr1,company_addr1_weight100,add_company_addr1,j58);
layout_candidates add_TX_foreign_corp_key(layout_candidates le,Specificities(ih).TX_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TX_foreign_corp_key_weight100 := MAP (le.TX_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.TX_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j58,s.nulls_TX_foreign_corp_key,Specificities(ih).TX_foreign_corp_key_values_persisted,TX_foreign_corp_key,TX_foreign_corp_key_weight100,add_TX_foreign_corp_key,j57);
layout_candidates add_AZ_foreign_corp_key(layout_candidates le,Specificities(ih).AZ_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.AZ_foreign_corp_key_weight100 := MAP (le.AZ_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.AZ_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j57,s.nulls_AZ_foreign_corp_key,Specificities(ih).AZ_foreign_corp_key_values_persisted,AZ_foreign_corp_key,AZ_foreign_corp_key_weight100,add_AZ_foreign_corp_key,j56);
layout_candidates add_VA_foreign_corp_key(layout_candidates le,Specificities(ih).VA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VA_foreign_corp_key_weight100 := MAP (le.VA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.VA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j56,s.nulls_VA_foreign_corp_key,Specificities(ih).VA_foreign_corp_key_values_persisted,VA_foreign_corp_key,VA_foreign_corp_key_weight100,add_VA_foreign_corp_key,j55);
layout_candidates add_NE_foreign_corp_key(layout_candidates le,Specificities(ih).NE_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NE_foreign_corp_key_weight100 := MAP (le.NE_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NE_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j55,s.nulls_NE_foreign_corp_key,Specificities(ih).NE_foreign_corp_key_values_persisted,NE_foreign_corp_key,NE_foreign_corp_key_weight100,add_NE_foreign_corp_key,j54);
layout_candidates add_MT_foreign_corp_key(layout_candidates le,Specificities(ih).MT_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MT_foreign_corp_key_weight100 := MAP (le.MT_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MT_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j54,s.nulls_MT_foreign_corp_key,Specificities(ih).MT_foreign_corp_key_values_persisted,MT_foreign_corp_key,MT_foreign_corp_key_weight100,add_MT_foreign_corp_key,j53);
layout_candidates add_LA_foreign_corp_key(layout_candidates le,Specificities(ih).LA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.LA_foreign_corp_key_weight100 := MAP (le.LA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.LA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j53,s.nulls_LA_foreign_corp_key,Specificities(ih).LA_foreign_corp_key_values_persisted,LA_foreign_corp_key,LA_foreign_corp_key_weight100,add_LA_foreign_corp_key,j52);
layout_candidates add_IA_foreign_corp_key(layout_candidates le,Specificities(ih).IA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.IA_foreign_corp_key_weight100 := MAP (le.IA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.IA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j52,s.nulls_IA_foreign_corp_key,Specificities(ih).IA_foreign_corp_key_values_persisted,IA_foreign_corp_key,IA_foreign_corp_key_weight100,add_IA_foreign_corp_key,j51);
layout_candidates add_HI_foreign_corp_key(layout_candidates le,Specificities(ih).HI_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.HI_foreign_corp_key_weight100 := MAP (le.HI_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.HI_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j51,s.nulls_HI_foreign_corp_key,Specificities(ih).HI_foreign_corp_key_values_persisted,HI_foreign_corp_key,HI_foreign_corp_key_weight100,add_HI_foreign_corp_key,j50);
layout_candidates add_CT_foreign_corp_key(layout_candidates le,Specificities(ih).CT_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CT_foreign_corp_key_weight100 := MAP (le.CT_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.CT_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j50,s.nulls_CT_foreign_corp_key,Specificities(ih).CT_foreign_corp_key_values_persisted,CT_foreign_corp_key,CT_foreign_corp_key_weight100,add_CT_foreign_corp_key,j49);
layout_candidates add_AK_foreign_corp_key(layout_candidates le,Specificities(ih).AK_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.AK_foreign_corp_key_weight100 := MAP (le.AK_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.AK_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j49,s.nulls_AK_foreign_corp_key,Specificities(ih).AK_foreign_corp_key_values_persisted,AK_foreign_corp_key,AK_foreign_corp_key_weight100,add_AK_foreign_corp_key,j48);
layout_candidates add_company_address(layout_candidates le,Specificities(ih).company_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_address_weight100 := MAP (le.company_address_isnull => 0, patch_default and ri.field_specificity=0 => s.company_address_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j48,s.nulls_company_address,Specificities(ih).company_address_values_persisted,company_address,company_address_weight100,add_company_address,j47);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j47,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j46);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_cnt := ri.cnt;
  SELF.cnp_name_e1_cnt := ri.e1_cnt;
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT26.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j46,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j45);
layout_candidates add_WY_foreign_corp_key(layout_candidates le,Specificities(ih).WY_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.WY_foreign_corp_key_weight100 := MAP (le.WY_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.WY_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j45,s.nulls_WY_foreign_corp_key,Specificities(ih).WY_foreign_corp_key_values_persisted,WY_foreign_corp_key,WY_foreign_corp_key_weight100,add_WY_foreign_corp_key,j44);
layout_candidates add_WV_foreign_corp_key(layout_candidates le,Specificities(ih).WV_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.WV_foreign_corp_key_weight100 := MAP (le.WV_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.WV_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j44,s.nulls_WV_foreign_corp_key,Specificities(ih).WV_foreign_corp_key_values_persisted,WV_foreign_corp_key,WV_foreign_corp_key_weight100,add_WV_foreign_corp_key,j43);
layout_candidates add_WA_foreign_corp_key(layout_candidates le,Specificities(ih).WA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.WA_foreign_corp_key_weight100 := MAP (le.WA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.WA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j43,s.nulls_WA_foreign_corp_key,Specificities(ih).WA_foreign_corp_key_values_persisted,WA_foreign_corp_key,WA_foreign_corp_key_weight100,add_WA_foreign_corp_key,j42);
layout_candidates add_UT_foreign_corp_key(layout_candidates le,Specificities(ih).UT_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.UT_foreign_corp_key_weight100 := MAP (le.UT_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.UT_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j42,s.nulls_UT_foreign_corp_key,Specificities(ih).UT_foreign_corp_key_values_persisted,UT_foreign_corp_key,UT_foreign_corp_key_weight100,add_UT_foreign_corp_key,j41);
layout_candidates add_RI_foreign_corp_key(layout_candidates le,Specificities(ih).RI_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.RI_foreign_corp_key_weight100 := MAP (le.RI_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.RI_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j41,s.nulls_RI_foreign_corp_key,Specificities(ih).RI_foreign_corp_key_values_persisted,RI_foreign_corp_key,RI_foreign_corp_key_weight100,add_RI_foreign_corp_key,j40);
layout_candidates add_OR_foreign_corp_key(layout_candidates le,Specificities(ih).OR_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.OR_foreign_corp_key_weight100 := MAP (le.OR_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.OR_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j40,s.nulls_OR_foreign_corp_key,Specificities(ih).OR_foreign_corp_key_values_persisted,OR_foreign_corp_key,OR_foreign_corp_key_weight100,add_OR_foreign_corp_key,j39);
layout_candidates add_NY_foreign_corp_key(layout_candidates le,Specificities(ih).NY_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NY_foreign_corp_key_weight100 := MAP (le.NY_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NY_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j39,s.nulls_NY_foreign_corp_key,Specificities(ih).NY_foreign_corp_key_values_persisted,NY_foreign_corp_key,NY_foreign_corp_key_weight100,add_NY_foreign_corp_key,j38);
layout_candidates add_NV_foreign_corp_key(layout_candidates le,Specificities(ih).NV_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NV_foreign_corp_key_weight100 := MAP (le.NV_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NV_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j38,s.nulls_NV_foreign_corp_key,Specificities(ih).NV_foreign_corp_key_values_persisted,NV_foreign_corp_key,NV_foreign_corp_key_weight100,add_NV_foreign_corp_key,j37);
layout_candidates add_NH_foreign_corp_key(layout_candidates le,Specificities(ih).NH_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NH_foreign_corp_key_weight100 := MAP (le.NH_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NH_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j37,s.nulls_NH_foreign_corp_key,Specificities(ih).NH_foreign_corp_key_values_persisted,NH_foreign_corp_key,NH_foreign_corp_key_weight100,add_NH_foreign_corp_key,j36);
layout_candidates add_MS_foreign_corp_key(layout_candidates le,Specificities(ih).MS_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MS_foreign_corp_key_weight100 := MAP (le.MS_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MS_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j36,s.nulls_MS_foreign_corp_key,Specificities(ih).MS_foreign_corp_key_values_persisted,MS_foreign_corp_key,MS_foreign_corp_key_weight100,add_MS_foreign_corp_key,j35);
layout_candidates add_IN_foreign_corp_key(layout_candidates le,Specificities(ih).IN_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.IN_foreign_corp_key_weight100 := MAP (le.IN_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.IN_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j35,s.nulls_IN_foreign_corp_key,Specificities(ih).IN_foreign_corp_key_values_persisted,IN_foreign_corp_key,IN_foreign_corp_key_weight100,add_IN_foreign_corp_key,j34);
layout_candidates add_IL_foreign_corp_key(layout_candidates le,Specificities(ih).IL_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.IL_foreign_corp_key_weight100 := MAP (le.IL_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.IL_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j34,s.nulls_IL_foreign_corp_key,Specificities(ih).IL_foreign_corp_key_values_persisted,IL_foreign_corp_key,IL_foreign_corp_key_weight100,add_IL_foreign_corp_key,j33);
layout_candidates add_GA_foreign_corp_key(layout_candidates le,Specificities(ih).GA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.GA_foreign_corp_key_weight100 := MAP (le.GA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.GA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j33,s.nulls_GA_foreign_corp_key,Specificities(ih).GA_foreign_corp_key_values_persisted,GA_foreign_corp_key,GA_foreign_corp_key_weight100,add_GA_foreign_corp_key,j32);
layout_candidates add_FL_foreign_corp_key(layout_candidates le,Specificities(ih).FL_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.FL_foreign_corp_key_weight100 := MAP (le.FL_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.FL_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j32,s.nulls_FL_foreign_corp_key,Specificities(ih).FL_foreign_corp_key_values_persisted,FL_foreign_corp_key,FL_foreign_corp_key_weight100,add_FL_foreign_corp_key,j31);
layout_candidates add_AL_foreign_corp_key(layout_candidates le,Specificities(ih).AL_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.AL_foreign_corp_key_weight100 := MAP (le.AL_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.AL_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j31,s.nulls_AL_foreign_corp_key,Specificities(ih).AL_foreign_corp_key_values_persisted,AL_foreign_corp_key,AL_foreign_corp_key_weight100,add_AL_foreign_corp_key,j30);
layout_candidates add_domestic_corp_key(layout_candidates le,Specificities(ih).domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.domestic_corp_key_weight100 := MAP (le.domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.domestic_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j30,s.nulls_domestic_corp_key,Specificities(ih).domestic_corp_key_values_persisted,domestic_corp_key,domestic_corp_key_weight100,add_domestic_corp_key,j29);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j29,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j28);
layout_candidates add_VT_foreign_corp_key(layout_candidates le,Specificities(ih).VT_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.VT_foreign_corp_key_weight100 := MAP (le.VT_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.VT_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j28,s.nulls_VT_foreign_corp_key,Specificities(ih).VT_foreign_corp_key_values_persisted,VT_foreign_corp_key,VT_foreign_corp_key_weight100,add_VT_foreign_corp_key,j27);
layout_candidates add_TN_foreign_corp_key(layout_candidates le,Specificities(ih).TN_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.TN_foreign_corp_key_weight100 := MAP (le.TN_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.TN_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j27,s.nulls_TN_foreign_corp_key,Specificities(ih).TN_foreign_corp_key_values_persisted,TN_foreign_corp_key,TN_foreign_corp_key_weight100,add_TN_foreign_corp_key,j26);
layout_candidates add_SD_foreign_corp_key(layout_candidates le,Specificities(ih).SD_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SD_foreign_corp_key_weight100 := MAP (le.SD_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.SD_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j26,s.nulls_SD_foreign_corp_key,Specificities(ih).SD_foreign_corp_key_values_persisted,SD_foreign_corp_key,SD_foreign_corp_key_weight100,add_SD_foreign_corp_key,j25);
layout_candidates add_SC_foreign_corp_key(layout_candidates le,Specificities(ih).SC_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SC_foreign_corp_key_weight100 := MAP (le.SC_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.SC_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j25,s.nulls_SC_foreign_corp_key,Specificities(ih).SC_foreign_corp_key_values_persisted,SC_foreign_corp_key,SC_foreign_corp_key_weight100,add_SC_foreign_corp_key,j24);
layout_candidates add_PA_foreign_corp_key(layout_candidates le,Specificities(ih).PA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.PA_foreign_corp_key_weight100 := MAP (le.PA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.PA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j24,s.nulls_PA_foreign_corp_key,Specificities(ih).PA_foreign_corp_key_values_persisted,PA_foreign_corp_key,PA_foreign_corp_key_weight100,add_PA_foreign_corp_key,j23);
layout_candidates add_OK_foreign_corp_key(layout_candidates le,Specificities(ih).OK_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.OK_foreign_corp_key_weight100 := MAP (le.OK_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.OK_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j23,s.nulls_OK_foreign_corp_key,Specificities(ih).OK_foreign_corp_key_values_persisted,OK_foreign_corp_key,OK_foreign_corp_key_weight100,add_OK_foreign_corp_key,j22);
layout_candidates add_NM_foreign_corp_key(layout_candidates le,Specificities(ih).NM_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NM_foreign_corp_key_weight100 := MAP (le.NM_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NM_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j22,s.nulls_NM_foreign_corp_key,Specificities(ih).NM_foreign_corp_key_values_persisted,NM_foreign_corp_key,NM_foreign_corp_key_weight100,add_NM_foreign_corp_key,j21);
layout_candidates add_ND_foreign_corp_key(layout_candidates le,Specificities(ih).ND_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ND_foreign_corp_key_weight100 := MAP (le.ND_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.ND_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j21,s.nulls_ND_foreign_corp_key,Specificities(ih).ND_foreign_corp_key_values_persisted,ND_foreign_corp_key,ND_foreign_corp_key_weight100,add_ND_foreign_corp_key,j20);
layout_candidates add_NC_foreign_corp_key(layout_candidates le,Specificities(ih).NC_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NC_foreign_corp_key_weight100 := MAP (le.NC_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NC_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j20,s.nulls_NC_foreign_corp_key,Specificities(ih).NC_foreign_corp_key_values_persisted,NC_foreign_corp_key,NC_foreign_corp_key_weight100,add_NC_foreign_corp_key,j19);
layout_candidates add_MO_foreign_corp_key(layout_candidates le,Specificities(ih).MO_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MO_foreign_corp_key_weight100 := MAP (le.MO_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MO_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j19,s.nulls_MO_foreign_corp_key,Specificities(ih).MO_foreign_corp_key_values_persisted,MO_foreign_corp_key,MO_foreign_corp_key_weight100,add_MO_foreign_corp_key,j18);
layout_candidates add_MI_foreign_corp_key(layout_candidates le,Specificities(ih).MI_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MI_foreign_corp_key_weight100 := MAP (le.MI_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MI_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j18,s.nulls_MI_foreign_corp_key,Specificities(ih).MI_foreign_corp_key_values_persisted,MI_foreign_corp_key,MI_foreign_corp_key_weight100,add_MI_foreign_corp_key,j17);
layout_candidates add_ME_foreign_corp_key(layout_candidates le,Specificities(ih).ME_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ME_foreign_corp_key_weight100 := MAP (le.ME_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.ME_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j17,s.nulls_ME_foreign_corp_key,Specificities(ih).ME_foreign_corp_key_values_persisted,ME_foreign_corp_key,ME_foreign_corp_key_weight100,add_ME_foreign_corp_key,j16);
layout_candidates add_MD_foreign_corp_key(layout_candidates le,Specificities(ih).MD_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MD_foreign_corp_key_weight100 := MAP (le.MD_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MD_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j16,s.nulls_MD_foreign_corp_key,Specificities(ih).MD_foreign_corp_key_values_persisted,MD_foreign_corp_key,MD_foreign_corp_key_weight100,add_MD_foreign_corp_key,j15);
layout_candidates add_MA_foreign_corp_key(layout_candidates le,Specificities(ih).MA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MA_foreign_corp_key_weight100 := MAP (le.MA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j15,s.nulls_MA_foreign_corp_key,Specificities(ih).MA_foreign_corp_key_values_persisted,MA_foreign_corp_key,MA_foreign_corp_key_weight100,add_MA_foreign_corp_key,j14);
layout_candidates add_KY_foreign_corp_key(layout_candidates le,Specificities(ih).KY_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.KY_foreign_corp_key_weight100 := MAP (le.KY_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.KY_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j14,s.nulls_KY_foreign_corp_key,Specificities(ih).KY_foreign_corp_key_values_persisted,KY_foreign_corp_key,KY_foreign_corp_key_weight100,add_KY_foreign_corp_key,j13);
layout_candidates add_KS_foreign_corp_key(layout_candidates le,Specificities(ih).KS_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.KS_foreign_corp_key_weight100 := MAP (le.KS_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.KS_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j13,s.nulls_KS_foreign_corp_key,Specificities(ih).KS_foreign_corp_key_values_persisted,KS_foreign_corp_key,KS_foreign_corp_key_weight100,add_KS_foreign_corp_key,j12);
layout_candidates add_DC_foreign_corp_key(layout_candidates le,Specificities(ih).DC_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.DC_foreign_corp_key_weight100 := MAP (le.DC_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.DC_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j12,s.nulls_DC_foreign_corp_key,Specificities(ih).DC_foreign_corp_key_values_persisted,DC_foreign_corp_key,DC_foreign_corp_key_weight100,add_DC_foreign_corp_key,j11);
layout_candidates add_CO_foreign_corp_key(layout_candidates le,Specificities(ih).CO_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CO_foreign_corp_key_weight100 := MAP (le.CO_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.CO_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j11,s.nulls_CO_foreign_corp_key,Specificities(ih).CO_foreign_corp_key_values_persisted,CO_foreign_corp_key,CO_foreign_corp_key_weight100,add_CO_foreign_corp_key,j10);
layout_candidates add_CA_foreign_corp_key(layout_candidates le,Specificities(ih).CA_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CA_foreign_corp_key_weight100 := MAP (le.CA_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.CA_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j10,s.nulls_CA_foreign_corp_key,Specificities(ih).CA_foreign_corp_key_values_persisted,CA_foreign_corp_key,CA_foreign_corp_key_weight100,add_CA_foreign_corp_key,j9);
layout_candidates add_AR_foreign_corp_key(layout_candidates le,Specificities(ih).AR_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.AR_foreign_corp_key_weight100 := MAP (le.AR_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.AR_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j9,s.nulls_AR_foreign_corp_key,Specificities(ih).AR_foreign_corp_key_values_persisted,AR_foreign_corp_key,AR_foreign_corp_key_weight100,add_AR_foreign_corp_key,j8);
layout_candidates add_ebr_file_number(layout_candidates le,Specificities(ih).ebr_file_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.ebr_file_number_weight100 := MAP (le.ebr_file_number_isnull => 0, patch_default and ri.field_specificity=0 => s.ebr_file_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j8,s.nulls_ebr_file_number,Specificities(ih).ebr_file_number_values_persisted,ebr_file_number,ebr_file_number_weight100,add_ebr_file_number,j7);
layout_candidates add_hist_duns_number(layout_candidates le,Specificities(ih).hist_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_duns_number_weight100 := MAP (le.hist_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j7,s.nulls_hist_duns_number,Specificities(ih).hist_duns_number_values_persisted,hist_duns_number,hist_duns_number_weight100,add_hist_duns_number,j6);
layout_candidates add_hist_enterprise_number(layout_candidates le,Specificities(ih).hist_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.hist_enterprise_number_weight100 := MAP (le.hist_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.hist_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j6,s.nulls_hist_enterprise_number,Specificities(ih).hist_enterprise_number_values_persisted,hist_enterprise_number,hist_enterprise_number_weight100,add_hist_enterprise_number,j5);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j5,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j4);
layout_candidates add_WI_foreign_corp_key(layout_candidates le,Specificities(ih).WI_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.WI_foreign_corp_key_weight100 := MAP (le.WI_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.WI_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j4,s.nulls_WI_foreign_corp_key,Specificities(ih).WI_foreign_corp_key_values_persisted,WI_foreign_corp_key,WI_foreign_corp_key_weight100,add_WI_foreign_corp_key,j3);
layout_candidates add_NJ_foreign_corp_key(layout_candidates le,Specificities(ih).NJ_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.NJ_foreign_corp_key_weight100 := MAP (le.NJ_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.NJ_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j3,s.nulls_NJ_foreign_corp_key,Specificities(ih).NJ_foreign_corp_key_values_persisted,NJ_foreign_corp_key,NJ_foreign_corp_key_weight100,add_NJ_foreign_corp_key,j2);
layout_candidates add_MN_foreign_corp_key(layout_candidates le,Specificities(ih).MN_foreign_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.MN_foreign_corp_key_weight100 := MAP (le.MN_foreign_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.MN_foreign_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j2,s.nulls_MN_foreign_corp_key,Specificities(ih).MN_foreign_corp_key_values_persisted,MN_foreign_corp_key,MN_foreign_corp_key_weight100,add_MN_foreign_corp_key,j1);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT26.MAC_Choose_JoinType(j1,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Proxid)) : PERSIST('temp::BIPV2_ProxID_dev3_DOT_Base_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.active_enterprise_number_weight100 + Annotated.MN_foreign_corp_key_weight100 + Annotated.NJ_foreign_corp_key_weight100 + Annotated.WI_foreign_corp_key_weight100 + Annotated.active_duns_number_weight100 + Annotated.hist_enterprise_number_weight100 + Annotated.hist_duns_number_weight100 + Annotated.ebr_file_number_weight100 + Annotated.AR_foreign_corp_key_weight100 + Annotated.CA_foreign_corp_key_weight100 + Annotated.CO_foreign_corp_key_weight100 + Annotated.DC_foreign_corp_key_weight100 + Annotated.KS_foreign_corp_key_weight100 + Annotated.KY_foreign_corp_key_weight100 + Annotated.MA_foreign_corp_key_weight100 + Annotated.MD_foreign_corp_key_weight100 + Annotated.ME_foreign_corp_key_weight100 + Annotated.MI_foreign_corp_key_weight100 + Annotated.MO_foreign_corp_key_weight100 + Annotated.NC_foreign_corp_key_weight100 + Annotated.ND_foreign_corp_key_weight100 + Annotated.NM_foreign_corp_key_weight100 + Annotated.OK_foreign_corp_key_weight100 + Annotated.PA_foreign_corp_key_weight100 + Annotated.SC_foreign_corp_key_weight100 + Annotated.SD_foreign_corp_key_weight100 + Annotated.TN_foreign_corp_key_weight100 + Annotated.VT_foreign_corp_key_weight100 + Annotated.company_phone_weight100 + Annotated.domestic_corp_key_weight100 + Annotated.AL_foreign_corp_key_weight100 + Annotated.FL_foreign_corp_key_weight100 + Annotated.GA_foreign_corp_key_weight100 + Annotated.IL_foreign_corp_key_weight100 + Annotated.IN_foreign_corp_key_weight100 + Annotated.MS_foreign_corp_key_weight100 + Annotated.NH_foreign_corp_key_weight100 + Annotated.NV_foreign_corp_key_weight100 + Annotated.NY_foreign_corp_key_weight100 + Annotated.OR_foreign_corp_key_weight100 + Annotated.RI_foreign_corp_key_weight100 + Annotated.UT_foreign_corp_key_weight100 + Annotated.WA_foreign_corp_key_weight100 + Annotated.WV_foreign_corp_key_weight100 + Annotated.WY_foreign_corp_key_weight100 + Annotated.cnp_name_weight100 + Annotated.company_fein_weight100 + Annotated.company_address_weight100 + Annotated.AK_foreign_corp_key_weight100 + Annotated.CT_foreign_corp_key_weight100 + Annotated.HI_foreign_corp_key_weight100 + Annotated.IA_foreign_corp_key_weight100 + Annotated.LA_foreign_corp_key_weight100 + Annotated.MT_foreign_corp_key_weight100 + Annotated.NE_foreign_corp_key_weight100 + Annotated.VA_foreign_corp_key_weight100 + Annotated.AZ_foreign_corp_key_weight100 + Annotated.TX_foreign_corp_key_weight100 + Annotated.cnp_number_weight100 + Annotated.cnp_btype_weight100 + Annotated.iscorp_weight100 + Annotated.DE_foreign_corp_key_weight100 + Annotated.ID_foreign_corp_key_weight100 + Annotated.OH_foreign_corp_key_weight100 + Annotated.PR_foreign_corp_key_weight100 + Annotated.VI_foreign_corp_key_weight100;
SHARED Linkable := TotalWeight >= 21;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
