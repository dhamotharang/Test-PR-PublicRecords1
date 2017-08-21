IMPORT ut,SALT26;
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT26.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'alpha','number','upper');
EXPORT FieldTypeNum(SALT26.StrType fn) := CASE(fn,'alpha' => 1,'number' => 2,'upper' => 3,0);
 
EXPORT MakeFT_alpha(SALT26.StrType s0) := FUNCTION
  s1 := SALT26.stringtouppercase(s0); // Force to upper case
  s2 := SALT26.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s2;
END;
EXPORT InValidFT_alpha(SALT26.StrType s) := WHICH(SALT26.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT26.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT26.HygieneErrors.NotCaps,SALT26.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT26.HygieneErrors.Good);
 
EXPORT MakeFT_number(SALT26.StrType s0) := FUNCTION
  s1 := SALT26.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_number(SALT26.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT26.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_number(UNSIGNED1 wh) := CHOOSE(wh,SALT26.HygieneErrors.NotInChars('0123456789'),SALT26.HygieneErrors.Good);
 
EXPORT MakeFT_upper(SALT26.StrType s0) := FUNCTION
  s1 := SALT26.stringtouppercase(s0); // Force to upper case
  RETURN  s1;
END;
EXPORT InValidFT_upper(SALT26.StrType s) := WHICH(SALT26.stringtouppercase(s)<>s);
EXPORT InValidMessageFT_upper(UNSIGNED1 wh) := CHOOSE(wh,SALT26.HygieneErrors.NotCaps,SALT26.HygieneErrors.Good);
 
EXPORT SALT26.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'cnp_number','prim_range','prim_name','st','active_enterprise_number','MN_foreign_corp_key','NJ_foreign_corp_key','active_duns_number','hist_enterprise_number','hist_duns_number','ebr_file_number','AR_foreign_corp_key','CA_foreign_corp_key','CO_foreign_corp_key','DC_foreign_corp_key','KS_foreign_corp_key','KY_foreign_corp_key','MA_foreign_corp_key','MD_foreign_corp_key','ME_foreign_corp_key','MI_foreign_corp_key','MO_foreign_corp_key','NC_foreign_corp_key','ND_foreign_corp_key','NM_foreign_corp_key','OK_foreign_corp_key','PA_foreign_corp_key','SC_foreign_corp_key','SD_foreign_corp_key','TN_foreign_corp_key','VT_foreign_corp_key','company_phone','domestic_corp_key','AL_foreign_corp_key','FL_foreign_corp_key','GA_foreign_corp_key','IL_foreign_corp_key','IN_foreign_corp_key','MS_foreign_corp_key','NH_foreign_corp_key','NV_foreign_corp_key','NY_foreign_corp_key','OR_foreign_corp_key','RI_foreign_corp_key','UT_foreign_corp_key','company_fein','cnp_name','company_address','AK_foreign_corp_key','CT_foreign_corp_key','HI_foreign_corp_key','IA_foreign_corp_key','LA_foreign_corp_key','MT_foreign_corp_key','NE_foreign_corp_key','VA_foreign_corp_key','AZ_foreign_corp_key','TX_foreign_corp_key','company_addr1','zip','company_csz','sec_range','v_city_name','cnp_btype','iscorp','cnp_lowv','cnp_translated','cnp_classid','company_foreign_domestic','company_bdid','cnp_hasnumber','company_name','dt_first_seen','dt_last_seen','DE_foreign_corp_key','ID_foreign_corp_key','OH_foreign_corp_key','PR_foreign_corp_key','VI_foreign_corp_key','WA_foreign_corp_key','WI_foreign_corp_key','WV_foreign_corp_key','WY_foreign_corp_key');
EXPORT FieldNum(SALT26.StrType fn) := CASE(fn,'cnp_number' => 1,'prim_range' => 2,'prim_name' => 3,'st' => 4,'active_enterprise_number' => 5,'MN_foreign_corp_key' => 6,'NJ_foreign_corp_key' => 7,'active_duns_number' => 8,'hist_enterprise_number' => 9,'hist_duns_number' => 10,'ebr_file_number' => 11,'AR_foreign_corp_key' => 12,'CA_foreign_corp_key' => 13,'CO_foreign_corp_key' => 14,'DC_foreign_corp_key' => 15,'KS_foreign_corp_key' => 16,'KY_foreign_corp_key' => 17,'MA_foreign_corp_key' => 18,'MD_foreign_corp_key' => 19,'ME_foreign_corp_key' => 20,'MI_foreign_corp_key' => 21,'MO_foreign_corp_key' => 22,'NC_foreign_corp_key' => 23,'ND_foreign_corp_key' => 24,'NM_foreign_corp_key' => 25,'OK_foreign_corp_key' => 26,'PA_foreign_corp_key' => 27,'SC_foreign_corp_key' => 28,'SD_foreign_corp_key' => 29,'TN_foreign_corp_key' => 30,'VT_foreign_corp_key' => 31,'company_phone' => 32,'domestic_corp_key' => 33,'AL_foreign_corp_key' => 34,'FL_foreign_corp_key' => 35,'GA_foreign_corp_key' => 36,'IL_foreign_corp_key' => 37,'IN_foreign_corp_key' => 38,'MS_foreign_corp_key' => 39,'NH_foreign_corp_key' => 40,'NV_foreign_corp_key' => 41,'NY_foreign_corp_key' => 42,'OR_foreign_corp_key' => 43,'RI_foreign_corp_key' => 44,'UT_foreign_corp_key' => 45,'company_fein' => 46,'cnp_name' => 47,'company_address' => 48,'AK_foreign_corp_key' => 49,'CT_foreign_corp_key' => 50,'HI_foreign_corp_key' => 51,'IA_foreign_corp_key' => 52,'LA_foreign_corp_key' => 53,'MT_foreign_corp_key' => 54,'NE_foreign_corp_key' => 55,'VA_foreign_corp_key' => 56,'AZ_foreign_corp_key' => 57,'TX_foreign_corp_key' => 58,'company_addr1' => 59,'zip' => 60,'company_csz' => 61,'sec_range' => 62,'v_city_name' => 63,'cnp_btype' => 64,'iscorp' => 65,'cnp_lowv' => 66,'cnp_translated' => 67,'cnp_classid' => 68,'company_foreign_domestic' => 69,'company_bdid' => 70,'cnp_hasnumber' => 71,'company_name' => 72,'dt_first_seen' => 73,'dt_last_seen' => 74,'DE_foreign_corp_key' => 75,'ID_foreign_corp_key' => 76,'OH_foreign_corp_key' => 77,'PR_foreign_corp_key' => 78,'VI_foreign_corp_key' => 79,'WA_foreign_corp_key' => 80,'WI_foreign_corp_key' => 81,'WV_foreign_corp_key' => 82,'WY_foreign_corp_key' => 83,0);
 
//Individual field level validation
 
EXPORT Make_cnp_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_number(UNSIGNED1 wh) := '';
EXPORT Make_prim_range(SALT26.StrType s0) := s0;
 
EXPORT InValid_prim_range(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
EXPORT Make_prim_name(SALT26.StrType s0) := s0;
 
EXPORT InValid_prim_name(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
EXPORT Make_st(SALT26.StrType s0) := MakeFT_alpha(s0);
 
EXPORT InValid_st(SALT26.StrType s) := InValidFT_alpha(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_alpha(wh);
EXPORT Make_active_enterprise_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_active_enterprise_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_active_enterprise_number(UNSIGNED1 wh) := '';
EXPORT Make_MN_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MN_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MN_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NJ_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NJ_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NJ_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_active_duns_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_active_duns_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_active_duns_number(UNSIGNED1 wh) := '';
EXPORT Make_hist_enterprise_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_hist_enterprise_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_hist_enterprise_number(UNSIGNED1 wh) := '';
EXPORT Make_hist_duns_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_hist_duns_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_hist_duns_number(UNSIGNED1 wh) := '';
EXPORT Make_ebr_file_number(SALT26.StrType s0) := s0;
 
EXPORT InValid_ebr_file_number(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_ebr_file_number(UNSIGNED1 wh) := '';
EXPORT Make_AR_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_AR_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_AR_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_CA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_CA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_CA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_CO_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_CO_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_CO_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_DC_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_DC_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_DC_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_KS_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_KS_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_KS_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_KY_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_KY_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_KY_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MD_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MD_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MD_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_ME_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_ME_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_ME_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MI_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MI_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MI_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MO_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MO_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MO_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NC_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NC_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NC_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_ND_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_ND_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_ND_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NM_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NM_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NM_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_OK_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_OK_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_OK_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_PA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_PA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_PA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_SC_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_SC_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_SC_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_SD_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_SD_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_SD_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_TN_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_TN_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_TN_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_VT_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_VT_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_VT_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_company_phone(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_phone(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_phone(UNSIGNED1 wh) := '';
EXPORT Make_domestic_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_domestic_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_domestic_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_AL_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_AL_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_AL_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_FL_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_FL_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_FL_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_GA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_GA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_GA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_IL_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_IL_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_IL_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_IN_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_IN_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_IN_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MS_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MS_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MS_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NH_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NH_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NH_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NV_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NV_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NV_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NY_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NY_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NY_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_OR_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_OR_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_OR_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_RI_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_RI_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_RI_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_UT_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_UT_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_UT_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_company_fein(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_fein(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_fein(UNSIGNED1 wh) := '';
EXPORT Make_cnp_name(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_name(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_name(UNSIGNED1 wh) := '';
EXPORT Make_company_address(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_address(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_address(UNSIGNED1 wh) := '';
EXPORT Make_AK_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_AK_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_AK_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_CT_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_CT_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_CT_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_HI_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_HI_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_HI_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_IA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_IA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_IA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_LA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_LA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_LA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_MT_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_MT_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_MT_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_NE_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_NE_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_NE_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_VA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_VA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_VA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_AZ_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_AZ_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_AZ_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_TX_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_TX_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_TX_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_company_addr1(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_addr1(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_addr1(UNSIGNED1 wh) := '';
EXPORT Make_zip(SALT26.StrType s0) := MakeFT_number(s0);
 
EXPORT InValid_zip(SALT26.StrType s) := InValidFT_number(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_number(wh);
EXPORT Make_company_csz(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_csz(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_csz(UNSIGNED1 wh) := '';
EXPORT Make_sec_range(SALT26.StrType s0) := s0;
 
EXPORT InValid_sec_range(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
EXPORT Make_v_city_name(SALT26.StrType s0) := s0;
 
EXPORT InValid_v_city_name(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
EXPORT Make_cnp_btype(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_btype(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_btype(UNSIGNED1 wh) := '';
EXPORT Make_iscorp(SALT26.StrType s0) := s0;
 
EXPORT InValid_iscorp(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_iscorp(UNSIGNED1 wh) := '';
EXPORT Make_cnp_lowv(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_lowv(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_lowv(UNSIGNED1 wh) := '';
EXPORT Make_cnp_translated(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_translated(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_translated(UNSIGNED1 wh) := '';
EXPORT Make_cnp_classid(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_classid(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_classid(UNSIGNED1 wh) := '';
EXPORT Make_company_foreign_domestic(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_foreign_domestic(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_foreign_domestic(UNSIGNED1 wh) := '';
EXPORT Make_company_bdid(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_bdid(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_bdid(UNSIGNED1 wh) := '';
EXPORT Make_cnp_hasnumber(SALT26.StrType s0) := s0;
 
EXPORT InValid_cnp_hasnumber(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_cnp_hasnumber(UNSIGNED1 wh) := '';
EXPORT Make_company_name(SALT26.StrType s0) := s0;
 
EXPORT InValid_company_name(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := '';
EXPORT Make_dt_first_seen(SALT26.StrType s0) := s0;
 
EXPORT InValid_dt_first_seen(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
EXPORT Make_dt_last_seen(SALT26.StrType s0) := s0;
 
EXPORT InValid_dt_last_seen(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
EXPORT Make_DE_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_DE_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_DE_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_ID_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_ID_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_ID_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_OH_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_OH_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_OH_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_PR_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_PR_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_PR_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_VI_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_VI_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_VI_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_WA_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_WA_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_WA_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_WI_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_WI_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_WI_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_WV_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_WV_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_WV_foreign_corp_key(UNSIGNED1 wh) := '';
EXPORT Make_WY_foreign_corp_key(SALT26.StrType s0) := s0;
 
EXPORT InValid_WY_foreign_corp_key(SALT26.StrType s) := FALSE;
EXPORT InValidMessage_WY_foreign_corp_key(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT26,BIPV2_ProxID_dev3;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_cnp_number;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_active_enterprise_number;
    BOOLEAN Diff_MN_foreign_corp_key;
    BOOLEAN Diff_NJ_foreign_corp_key;
    BOOLEAN Diff_active_duns_number;
    BOOLEAN Diff_hist_enterprise_number;
    BOOLEAN Diff_hist_duns_number;
    BOOLEAN Diff_ebr_file_number;
    BOOLEAN Diff_AR_foreign_corp_key;
    BOOLEAN Diff_CA_foreign_corp_key;
    BOOLEAN Diff_CO_foreign_corp_key;
    BOOLEAN Diff_DC_foreign_corp_key;
    BOOLEAN Diff_KS_foreign_corp_key;
    BOOLEAN Diff_KY_foreign_corp_key;
    BOOLEAN Diff_MA_foreign_corp_key;
    BOOLEAN Diff_MD_foreign_corp_key;
    BOOLEAN Diff_ME_foreign_corp_key;
    BOOLEAN Diff_MI_foreign_corp_key;
    BOOLEAN Diff_MO_foreign_corp_key;
    BOOLEAN Diff_NC_foreign_corp_key;
    BOOLEAN Diff_ND_foreign_corp_key;
    BOOLEAN Diff_NM_foreign_corp_key;
    BOOLEAN Diff_OK_foreign_corp_key;
    BOOLEAN Diff_PA_foreign_corp_key;
    BOOLEAN Diff_SC_foreign_corp_key;
    BOOLEAN Diff_SD_foreign_corp_key;
    BOOLEAN Diff_TN_foreign_corp_key;
    BOOLEAN Diff_VT_foreign_corp_key;
    BOOLEAN Diff_company_phone;
    BOOLEAN Diff_domestic_corp_key;
    BOOLEAN Diff_AL_foreign_corp_key;
    BOOLEAN Diff_FL_foreign_corp_key;
    BOOLEAN Diff_GA_foreign_corp_key;
    BOOLEAN Diff_IL_foreign_corp_key;
    BOOLEAN Diff_IN_foreign_corp_key;
    BOOLEAN Diff_MS_foreign_corp_key;
    BOOLEAN Diff_NH_foreign_corp_key;
    BOOLEAN Diff_NV_foreign_corp_key;
    BOOLEAN Diff_NY_foreign_corp_key;
    BOOLEAN Diff_OR_foreign_corp_key;
    BOOLEAN Diff_RI_foreign_corp_key;
    BOOLEAN Diff_UT_foreign_corp_key;
    BOOLEAN Diff_company_fein;
    BOOLEAN Diff_cnp_name;
    BOOLEAN Diff_AK_foreign_corp_key;
    BOOLEAN Diff_CT_foreign_corp_key;
    BOOLEAN Diff_HI_foreign_corp_key;
    BOOLEAN Diff_IA_foreign_corp_key;
    BOOLEAN Diff_LA_foreign_corp_key;
    BOOLEAN Diff_MT_foreign_corp_key;
    BOOLEAN Diff_NE_foreign_corp_key;
    BOOLEAN Diff_VA_foreign_corp_key;
    BOOLEAN Diff_AZ_foreign_corp_key;
    BOOLEAN Diff_TX_foreign_corp_key;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_cnp_btype;
    BOOLEAN Diff_iscorp;
    BOOLEAN Diff_cnp_lowv;
    BOOLEAN Diff_cnp_translated;
    BOOLEAN Diff_cnp_classid;
    BOOLEAN Diff_company_foreign_domestic;
    BOOLEAN Diff_company_bdid;
    BOOLEAN Diff_cnp_hasnumber;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_DE_foreign_corp_key;
    BOOLEAN Diff_ID_foreign_corp_key;
    BOOLEAN Diff_OH_foreign_corp_key;
    BOOLEAN Diff_PR_foreign_corp_key;
    BOOLEAN Diff_VI_foreign_corp_key;
    BOOLEAN Diff_WA_foreign_corp_key;
    BOOLEAN Diff_WI_foreign_corp_key;
    BOOLEAN Diff_WV_foreign_corp_key;
    BOOLEAN Diff_WY_foreign_corp_key;
    UNSIGNED Num_Diffs;
    SALT26.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_cnp_number := le.cnp_number <> ri.cnp_number;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_active_enterprise_number := le.active_enterprise_number <> ri.active_enterprise_number;
    SELF.Diff_MN_foreign_corp_key := le.MN_foreign_corp_key <> ri.MN_foreign_corp_key;
    SELF.Diff_NJ_foreign_corp_key := le.NJ_foreign_corp_key <> ri.NJ_foreign_corp_key;
    SELF.Diff_active_duns_number := le.active_duns_number <> ri.active_duns_number;
    SELF.Diff_hist_enterprise_number := le.hist_enterprise_number <> ri.hist_enterprise_number;
    SELF.Diff_hist_duns_number := le.hist_duns_number <> ri.hist_duns_number;
    SELF.Diff_ebr_file_number := le.ebr_file_number <> ri.ebr_file_number;
    SELF.Diff_AR_foreign_corp_key := le.AR_foreign_corp_key <> ri.AR_foreign_corp_key;
    SELF.Diff_CA_foreign_corp_key := le.CA_foreign_corp_key <> ri.CA_foreign_corp_key;
    SELF.Diff_CO_foreign_corp_key := le.CO_foreign_corp_key <> ri.CO_foreign_corp_key;
    SELF.Diff_DC_foreign_corp_key := le.DC_foreign_corp_key <> ri.DC_foreign_corp_key;
    SELF.Diff_KS_foreign_corp_key := le.KS_foreign_corp_key <> ri.KS_foreign_corp_key;
    SELF.Diff_KY_foreign_corp_key := le.KY_foreign_corp_key <> ri.KY_foreign_corp_key;
    SELF.Diff_MA_foreign_corp_key := le.MA_foreign_corp_key <> ri.MA_foreign_corp_key;
    SELF.Diff_MD_foreign_corp_key := le.MD_foreign_corp_key <> ri.MD_foreign_corp_key;
    SELF.Diff_ME_foreign_corp_key := le.ME_foreign_corp_key <> ri.ME_foreign_corp_key;
    SELF.Diff_MI_foreign_corp_key := le.MI_foreign_corp_key <> ri.MI_foreign_corp_key;
    SELF.Diff_MO_foreign_corp_key := le.MO_foreign_corp_key <> ri.MO_foreign_corp_key;
    SELF.Diff_NC_foreign_corp_key := le.NC_foreign_corp_key <> ri.NC_foreign_corp_key;
    SELF.Diff_ND_foreign_corp_key := le.ND_foreign_corp_key <> ri.ND_foreign_corp_key;
    SELF.Diff_NM_foreign_corp_key := le.NM_foreign_corp_key <> ri.NM_foreign_corp_key;
    SELF.Diff_OK_foreign_corp_key := le.OK_foreign_corp_key <> ri.OK_foreign_corp_key;
    SELF.Diff_PA_foreign_corp_key := le.PA_foreign_corp_key <> ri.PA_foreign_corp_key;
    SELF.Diff_SC_foreign_corp_key := le.SC_foreign_corp_key <> ri.SC_foreign_corp_key;
    SELF.Diff_SD_foreign_corp_key := le.SD_foreign_corp_key <> ri.SD_foreign_corp_key;
    SELF.Diff_TN_foreign_corp_key := le.TN_foreign_corp_key <> ri.TN_foreign_corp_key;
    SELF.Diff_VT_foreign_corp_key := le.VT_foreign_corp_key <> ri.VT_foreign_corp_key;
    SELF.Diff_company_phone := le.company_phone <> ri.company_phone;
    SELF.Diff_domestic_corp_key := le.domestic_corp_key <> ri.domestic_corp_key;
    SELF.Diff_AL_foreign_corp_key := le.AL_foreign_corp_key <> ri.AL_foreign_corp_key;
    SELF.Diff_FL_foreign_corp_key := le.FL_foreign_corp_key <> ri.FL_foreign_corp_key;
    SELF.Diff_GA_foreign_corp_key := le.GA_foreign_corp_key <> ri.GA_foreign_corp_key;
    SELF.Diff_IL_foreign_corp_key := le.IL_foreign_corp_key <> ri.IL_foreign_corp_key;
    SELF.Diff_IN_foreign_corp_key := le.IN_foreign_corp_key <> ri.IN_foreign_corp_key;
    SELF.Diff_MS_foreign_corp_key := le.MS_foreign_corp_key <> ri.MS_foreign_corp_key;
    SELF.Diff_NH_foreign_corp_key := le.NH_foreign_corp_key <> ri.NH_foreign_corp_key;
    SELF.Diff_NV_foreign_corp_key := le.NV_foreign_corp_key <> ri.NV_foreign_corp_key;
    SELF.Diff_NY_foreign_corp_key := le.NY_foreign_corp_key <> ri.NY_foreign_corp_key;
    SELF.Diff_OR_foreign_corp_key := le.OR_foreign_corp_key <> ri.OR_foreign_corp_key;
    SELF.Diff_RI_foreign_corp_key := le.RI_foreign_corp_key <> ri.RI_foreign_corp_key;
    SELF.Diff_UT_foreign_corp_key := le.UT_foreign_corp_key <> ri.UT_foreign_corp_key;
    SELF.Diff_company_fein := le.company_fein <> ri.company_fein;
    SELF.Diff_cnp_name := le.cnp_name <> ri.cnp_name;
    SELF.Diff_AK_foreign_corp_key := le.AK_foreign_corp_key <> ri.AK_foreign_corp_key;
    SELF.Diff_CT_foreign_corp_key := le.CT_foreign_corp_key <> ri.CT_foreign_corp_key;
    SELF.Diff_HI_foreign_corp_key := le.HI_foreign_corp_key <> ri.HI_foreign_corp_key;
    SELF.Diff_IA_foreign_corp_key := le.IA_foreign_corp_key <> ri.IA_foreign_corp_key;
    SELF.Diff_LA_foreign_corp_key := le.LA_foreign_corp_key <> ri.LA_foreign_corp_key;
    SELF.Diff_MT_foreign_corp_key := le.MT_foreign_corp_key <> ri.MT_foreign_corp_key;
    SELF.Diff_NE_foreign_corp_key := le.NE_foreign_corp_key <> ri.NE_foreign_corp_key;
    SELF.Diff_VA_foreign_corp_key := le.VA_foreign_corp_key <> ri.VA_foreign_corp_key;
    SELF.Diff_AZ_foreign_corp_key := le.AZ_foreign_corp_key <> ri.AZ_foreign_corp_key;
    SELF.Diff_TX_foreign_corp_key := le.TX_foreign_corp_key <> ri.TX_foreign_corp_key;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_cnp_btype := le.cnp_btype <> ri.cnp_btype;
    SELF.Diff_iscorp := le.iscorp <> ri.iscorp;
    SELF.Diff_cnp_lowv := le.cnp_lowv <> ri.cnp_lowv;
    SELF.Diff_cnp_translated := le.cnp_translated <> ri.cnp_translated;
    SELF.Diff_cnp_classid := le.cnp_classid <> ri.cnp_classid;
    SELF.Diff_company_foreign_domestic := le.company_foreign_domestic <> ri.company_foreign_domestic;
    SELF.Diff_company_bdid := le.company_bdid <> ri.company_bdid;
    SELF.Diff_cnp_hasnumber := le.cnp_hasnumber <> ri.cnp_hasnumber;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_DE_foreign_corp_key := le.DE_foreign_corp_key <> ri.DE_foreign_corp_key;
    SELF.Diff_ID_foreign_corp_key := le.ID_foreign_corp_key <> ri.ID_foreign_corp_key;
    SELF.Diff_OH_foreign_corp_key := le.OH_foreign_corp_key <> ri.OH_foreign_corp_key;
    SELF.Diff_PR_foreign_corp_key := le.PR_foreign_corp_key <> ri.PR_foreign_corp_key;
    SELF.Diff_VI_foreign_corp_key := le.VI_foreign_corp_key <> ri.VI_foreign_corp_key;
    SELF.Diff_WA_foreign_corp_key := le.WA_foreign_corp_key <> ri.WA_foreign_corp_key;
    SELF.Diff_WI_foreign_corp_key := le.WI_foreign_corp_key <> ri.WI_foreign_corp_key;
    SELF.Diff_WV_foreign_corp_key := le.WV_foreign_corp_key <> ri.WV_foreign_corp_key;
    SELF.Diff_WY_foreign_corp_key := le.WY_foreign_corp_key <> ri.WY_foreign_corp_key;
    SELF.Val := (SALT26.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_cnp_number,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_active_enterprise_number,1,0)+ IF( SELF.Diff_MN_foreign_corp_key,1,0)+ IF( SELF.Diff_NJ_foreign_corp_key,1,0)+ IF( SELF.Diff_active_duns_number,1,0)+ IF( SELF.Diff_hist_enterprise_number,1,0)+ IF( SELF.Diff_hist_duns_number,1,0)+ IF( SELF.Diff_ebr_file_number,1,0)+ IF( SELF.Diff_AR_foreign_corp_key,1,0)+ IF( SELF.Diff_CA_foreign_corp_key,1,0)+ IF( SELF.Diff_CO_foreign_corp_key,1,0)+ IF( SELF.Diff_DC_foreign_corp_key,1,0)+ IF( SELF.Diff_KS_foreign_corp_key,1,0)+ IF( SELF.Diff_KY_foreign_corp_key,1,0)+ IF( SELF.Diff_MA_foreign_corp_key,1,0)+ IF( SELF.Diff_MD_foreign_corp_key,1,0)+ IF( SELF.Diff_ME_foreign_corp_key,1,0)+ IF( SELF.Diff_MI_foreign_corp_key,1,0)+ IF( SELF.Diff_MO_foreign_corp_key,1,0)+ IF( SELF.Diff_NC_foreign_corp_key,1,0)+ IF( SELF.Diff_ND_foreign_corp_key,1,0)+ IF( SELF.Diff_NM_foreign_corp_key,1,0)+ IF( SELF.Diff_OK_foreign_corp_key,1,0)+ IF( SELF.Diff_PA_foreign_corp_key,1,0)+ IF( SELF.Diff_SC_foreign_corp_key,1,0)+ IF( SELF.Diff_SD_foreign_corp_key,1,0)+ IF( SELF.Diff_TN_foreign_corp_key,1,0)+ IF( SELF.Diff_VT_foreign_corp_key,1,0)+ IF( SELF.Diff_company_phone,1,0)+ IF( SELF.Diff_domestic_corp_key,1,0)+ IF( SELF.Diff_AL_foreign_corp_key,1,0)+ IF( SELF.Diff_FL_foreign_corp_key,1,0)+ IF( SELF.Diff_GA_foreign_corp_key,1,0)+ IF( SELF.Diff_IL_foreign_corp_key,1,0)+ IF( SELF.Diff_IN_foreign_corp_key,1,0)+ IF( SELF.Diff_MS_foreign_corp_key,1,0)+ IF( SELF.Diff_NH_foreign_corp_key,1,0)+ IF( SELF.Diff_NV_foreign_corp_key,1,0)+ IF( SELF.Diff_NY_foreign_corp_key,1,0)+ IF( SELF.Diff_OR_foreign_corp_key,1,0)+ IF( SELF.Diff_RI_foreign_corp_key,1,0)+ IF( SELF.Diff_UT_foreign_corp_key,1,0)+ IF( SELF.Diff_company_fein,1,0)+ IF( SELF.Diff_cnp_name,1,0)+ IF( SELF.Diff_AK_foreign_corp_key,1,0)+ IF( SELF.Diff_CT_foreign_corp_key,1,0)+ IF( SELF.Diff_HI_foreign_corp_key,1,0)+ IF( SELF.Diff_IA_foreign_corp_key,1,0)+ IF( SELF.Diff_LA_foreign_corp_key,1,0)+ IF( SELF.Diff_MT_foreign_corp_key,1,0)+ IF( SELF.Diff_NE_foreign_corp_key,1,0)+ IF( SELF.Diff_VA_foreign_corp_key,1,0)+ IF( SELF.Diff_AZ_foreign_corp_key,1,0)+ IF( SELF.Diff_TX_foreign_corp_key,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_cnp_btype,1,0)+ IF( SELF.Diff_iscorp,1,0)+ IF( SELF.Diff_cnp_lowv,1,0)+ IF( SELF.Diff_cnp_translated,1,0)+ IF( SELF.Diff_cnp_classid,1,0)+ IF( SELF.Diff_company_foreign_domestic,1,0)+ IF( SELF.Diff_company_bdid,1,0)+ IF( SELF.Diff_cnp_hasnumber,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_DE_foreign_corp_key,1,0)+ IF( SELF.Diff_ID_foreign_corp_key,1,0)+ IF( SELF.Diff_OH_foreign_corp_key,1,0)+ IF( SELF.Diff_PR_foreign_corp_key,1,0)+ IF( SELF.Diff_VI_foreign_corp_key,1,0)+ IF( SELF.Diff_WA_foreign_corp_key,1,0)+ IF( SELF.Diff_WI_foreign_corp_key,1,0)+ IF( SELF.Diff_WV_foreign_corp_key,1,0)+ IF( SELF.Diff_WY_foreign_corp_key,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_cnp_number := COUNT(GROUP,%Closest%.Diff_cnp_number);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_active_enterprise_number := COUNT(GROUP,%Closest%.Diff_active_enterprise_number);
    Count_Diff_MN_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MN_foreign_corp_key);
    Count_Diff_NJ_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NJ_foreign_corp_key);
    Count_Diff_active_duns_number := COUNT(GROUP,%Closest%.Diff_active_duns_number);
    Count_Diff_hist_enterprise_number := COUNT(GROUP,%Closest%.Diff_hist_enterprise_number);
    Count_Diff_hist_duns_number := COUNT(GROUP,%Closest%.Diff_hist_duns_number);
    Count_Diff_ebr_file_number := COUNT(GROUP,%Closest%.Diff_ebr_file_number);
    Count_Diff_AR_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_AR_foreign_corp_key);
    Count_Diff_CA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_CA_foreign_corp_key);
    Count_Diff_CO_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_CO_foreign_corp_key);
    Count_Diff_DC_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_DC_foreign_corp_key);
    Count_Diff_KS_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_KS_foreign_corp_key);
    Count_Diff_KY_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_KY_foreign_corp_key);
    Count_Diff_MA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MA_foreign_corp_key);
    Count_Diff_MD_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MD_foreign_corp_key);
    Count_Diff_ME_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_ME_foreign_corp_key);
    Count_Diff_MI_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MI_foreign_corp_key);
    Count_Diff_MO_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MO_foreign_corp_key);
    Count_Diff_NC_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NC_foreign_corp_key);
    Count_Diff_ND_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_ND_foreign_corp_key);
    Count_Diff_NM_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NM_foreign_corp_key);
    Count_Diff_OK_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_OK_foreign_corp_key);
    Count_Diff_PA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_PA_foreign_corp_key);
    Count_Diff_SC_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_SC_foreign_corp_key);
    Count_Diff_SD_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_SD_foreign_corp_key);
    Count_Diff_TN_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_TN_foreign_corp_key);
    Count_Diff_VT_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_VT_foreign_corp_key);
    Count_Diff_company_phone := COUNT(GROUP,%Closest%.Diff_company_phone);
    Count_Diff_domestic_corp_key := COUNT(GROUP,%Closest%.Diff_domestic_corp_key);
    Count_Diff_AL_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_AL_foreign_corp_key);
    Count_Diff_FL_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_FL_foreign_corp_key);
    Count_Diff_GA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_GA_foreign_corp_key);
    Count_Diff_IL_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_IL_foreign_corp_key);
    Count_Diff_IN_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_IN_foreign_corp_key);
    Count_Diff_MS_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MS_foreign_corp_key);
    Count_Diff_NH_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NH_foreign_corp_key);
    Count_Diff_NV_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NV_foreign_corp_key);
    Count_Diff_NY_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NY_foreign_corp_key);
    Count_Diff_OR_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_OR_foreign_corp_key);
    Count_Diff_RI_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_RI_foreign_corp_key);
    Count_Diff_UT_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_UT_foreign_corp_key);
    Count_Diff_company_fein := COUNT(GROUP,%Closest%.Diff_company_fein);
    Count_Diff_cnp_name := COUNT(GROUP,%Closest%.Diff_cnp_name);
    Count_Diff_AK_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_AK_foreign_corp_key);
    Count_Diff_CT_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_CT_foreign_corp_key);
    Count_Diff_HI_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_HI_foreign_corp_key);
    Count_Diff_IA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_IA_foreign_corp_key);
    Count_Diff_LA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_LA_foreign_corp_key);
    Count_Diff_MT_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_MT_foreign_corp_key);
    Count_Diff_NE_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_NE_foreign_corp_key);
    Count_Diff_VA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_VA_foreign_corp_key);
    Count_Diff_AZ_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_AZ_foreign_corp_key);
    Count_Diff_TX_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_TX_foreign_corp_key);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_cnp_btype := COUNT(GROUP,%Closest%.Diff_cnp_btype);
    Count_Diff_iscorp := COUNT(GROUP,%Closest%.Diff_iscorp);
    Count_Diff_cnp_lowv := COUNT(GROUP,%Closest%.Diff_cnp_lowv);
    Count_Diff_cnp_translated := COUNT(GROUP,%Closest%.Diff_cnp_translated);
    Count_Diff_cnp_classid := COUNT(GROUP,%Closest%.Diff_cnp_classid);
    Count_Diff_company_foreign_domestic := COUNT(GROUP,%Closest%.Diff_company_foreign_domestic);
    Count_Diff_company_bdid := COUNT(GROUP,%Closest%.Diff_company_bdid);
    Count_Diff_cnp_hasnumber := COUNT(GROUP,%Closest%.Diff_cnp_hasnumber);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_DE_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_DE_foreign_corp_key);
    Count_Diff_ID_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_ID_foreign_corp_key);
    Count_Diff_OH_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_OH_foreign_corp_key);
    Count_Diff_PR_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_PR_foreign_corp_key);
    Count_Diff_VI_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_VI_foreign_corp_key);
    Count_Diff_WA_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_WA_foreign_corp_key);
    Count_Diff_WI_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_WI_foreign_corp_key);
    Count_Diff_WV_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_WV_foreign_corp_key);
    Count_Diff_WY_foreign_corp_key := COUNT(GROUP,%Closest%.Diff_WY_foreign_corp_key);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
end;
