IMPORT Models, Citizenship, MDR;

EXPORT Ver_source_Function(unsigned4 seq, STRING ver_sources, STRING ver_sources_first_seen, STRING ver_sources_last_seen) := FUNCTION
//==============================================================================================================================
     
     
     NULL      := -999999999;
     COMMA     := '  ,';
     MODIFIER  := 'ie';
     CHAR0     := '0';  
   

   //***Pick up the first seen date for each source reporting data     ***//
   //***Pick up the last seen datef from must the credentialed sources ***//
   
   //*** AK ***
     ver_src_ak_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_AK_Perm_Fund , COMMA, MODIFIER);
     _ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), CHAR0);
     _ver_src_ldate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ak_pos), CHAR0);
     ver_src_fdate_ak  := Models.common.sas_date((STRING)(_ver_src_fdate_ak));
     ver_src_ldate_ak  := Models.common.sas_date((STRING)(_ver_src_ldate_ak));
     ver_src_AK_count  := if(ver_src_ak_pos > 0, 1,0); 
   
   //*** AM ***  CREDENTIALED
     ver_src_am_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Airmen , COMMA, MODIFIER);
     _ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), CHAR0);
     _ver_src_ldate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_am_pos), CHAR0);
     ver_src_fdate_am  := Models.common.sas_date((STRING)(_ver_src_fdate_am));
     ver_src_ldate_am  := Models.common.sas_date((STRING)(_ver_src_ldate_am));
     ver_src_AM_count  := if(ver_src_am_pos > 0, 1, 0);
   
   //*** AR ***  CREDENTIALED 
     ver_src_ar_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Aircrafts , COMMA, MODIFIER);
     _ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), CHAR0);
     _ver_src_ldate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ar_pos), CHAR0);
     ver_src_fdate_ar  := Models.common.sas_date((STRING)(_ver_src_fdate_ar));
     ver_src_ldate_ar  := Models.common.sas_date((STRING)(_ver_src_ldate_ar));
     ver_src_AR_count  := if(ver_src_ar_pos > 0, 1,0); 
   
   //*** BA ***  CREDENTIALED
     ver_src_ba_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Bankruptcy , COMMA, MODIFIER);
     _ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), CHAR0);
     _ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ba_pos), CHAR0);
     ver_src_fdate_ba  := Models.common.sas_date((STRING)(_ver_src_fdate_ba));
     ver_src_ldate_ba  := Models.common.sas_date((STRING)(_ver_src_ldate_ba));
     ver_src_BA_count  := if(ver_src_ba_pos > 0, 1, 0); 

   //*** CG ***  CREDENTIALED
     ver_src_cg_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_US_Coastguard , COMMA, MODIFIER);
     _ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), CHAR0);
     _ver_src_ldate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_cg_pos), CHAR0);
     ver_src_fdate_cg  := Models.common.sas_date((STRING)(_ver_src_fdate_cg));
     ver_src_ldate_cg  := Models.common.sas_date((STRING)(_ver_src_ldate_cg));
     ver_src_cg_count  := if(ver_src_cg_pos > 0, 1, 0);
    
 //*** CO ***
    ver_src_co_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_FCRA_Corrections_record , COMMA, MODIFIER);
    _ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), CHAR0);
    _ver_src_ldate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_co_pos), CHAR0);
    ver_src_fdate_co  := Models.common.sas_date((STRING)(_ver_src_fdate_co));
    ver_src_ldate_co  := Models.common.sas_date((STRING)(_ver_src_ldate_co));
    ver_src_co_count  := if(ver_src_co_pos > 0, 1, 0);
   
 //*** CY ***
    ver_src_cy_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Certegy , COMMA, MODIFIER);
    _ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), CHAR0);
    _ver_src_ldate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_cy_pos), CHAR0);
    ver_src_fdate_cy  := Models.common.sas_date((STRING)(_ver_src_fdate_cy));
    ver_src_ldate_cy  := Models.common.sas_date((STRING)(_ver_src_ldate_cy));
    ver_src_cy_count  := if(ver_src_cy_pos > 0, 1, 0);
 
 //*** DA ***  CREDENTIALED
    ver_src_da_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_DEA , COMMA, MODIFIER);
    _ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), CHAR0);
    _ver_src_ldate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_da_pos), CHAR0);
    ver_src_fdate_da  := Models.common.sas_date((STRING)(_ver_src_fdate_da));
    ver_src_ldate_da  := Models.common.sas_date((STRING)(_ver_src_ldate_da));
    ver_src_DA_count  := if(ver_src_da_pos > 0, 1, 0);
 
 //*** D  ***  CREDENTIALED
   ver_src_d_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Dunn_Bradstreet , COMMA, MODIFIER);
   _ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), CHAR0);
   _ver_src_ldate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_d_pos), CHAR0);
   ver_src_fdate_d  := Models.common.sas_date((STRING)(_ver_src_fdate_d));
   ver_src_ldate_d  := Models.common.sas_date((STRING)(_ver_src_ldate_d));
   ver_src_D_count  := if(ver_src_d_pos > 0, 1, 0);
 
 //*** DL ***  CREDENTIALED
   ver_src_dl_pos    := Models.Common.findw_cpp(ver_sources, Citizenship.Constants.DL_SOURCE , COMMA, MODIFIER);
   _ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), CHAR0);
   _ver_src_ldate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_dl_pos), CHAR0);
   ver_src_fdate_dl  := Models.common.sas_date((STRING)(_ver_src_fdate_dl));
   ver_src_ldate_dl  := Models.common.sas_date((STRING)(_ver_src_ldate_dl));
   ver_src_DL_count  := if(ver_src_dl_pos > 0, 1, 0);
 
 //*** DS ***
   ver_src_ds_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Death_State , COMMA, MODIFIER);
   _ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), CHAR0);
   _ver_src_ldate_ds := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ds_pos), CHAR0);
   ver_src_fdate_ds  := Models.common.sas_date((STRING)(_ver_src_fdate_ds));
   ver_src_ldate_ds  := Models.common.sas_date((STRING)(_ver_src_ldate_ds));
   ver_src_DS_count  := if(ver_src_ds_pos > 0, 1, 0);

 //*** DE ***
   ver_src_de_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Death_Master , COMMA, MODIFIER);
   _ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), CHAR0);
   _ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_de_pos), CHAR0);
   ver_src_fdate_de  := Models.common.sas_date((STRING)(_ver_src_fdate_de));
   ver_src_ldate_de  := Models.common.sas_date((STRING)(_ver_src_ldate_de));
   ver_src_DE_count  := if(ver_src_de_pos > 0, 1, 0);
   
 //*** EB ***  CREDENTIALED
   ver_src_eb_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Boat , COMMA, MODIFIER);
   _ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), CHAR0);
   _ver_src_ldate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_eb_pos), CHAR0);
   ver_src_fdate_eb  := Models.common.sas_date((STRING)(_ver_src_fdate_eb));
   ver_src_ldate_eb  := Models.common.sas_date((STRING)(_ver_src_ldate_eb));
   ver_src_EB_count  := if(ver_src_eb_pos > 0, 1, 0);

 //*** EM ***  
   ver_src_em_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Master , COMMA, MODIFIER);
   _ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), CHAR0);
   _ver_src_ldate_em := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_em_pos), CHAR0);
   ver_src_fdate_em  := Models.common.sas_date((STRING)(_ver_src_fdate_em));
   ver_src_ldate_em  := Models.common.sas_date((STRING)(_ver_src_ldate_em));
   ver_src_EM_count  := if(ver_src_em_pos > 0, 1, 0);

 //*** E1 ***  CREDENTIALED
   ver_src_e1_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Hunt , COMMA, MODIFIER);
   _ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), CHAR0);
   _ver_src_ldate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_e1_pos), CHAR0);
   ver_src_fdate_e1  := Models.common.sas_date((STRING)(_ver_src_fdate_e1));
   ver_src_ldate_e1  := Models.common.sas_date((STRING)(_ver_src_ldate_e1));
   ver_src_E1_count  := if(ver_src_e1_pos > 0, 1, 0);

 //*** E2 ***  CREDENTIALED
   ver_src_e2_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Fish , COMMA, MODIFIER);
   _ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), CHAR0);
   _ver_src_ldate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_e2_pos), CHAR0);
   ver_src_fdate_e2  := Models.common.sas_date((STRING)(_ver_src_fdate_e2));
   ver_src_ldate_e2  := Models.common.sas_date((STRING)(_ver_src_ldate_e2));
   ver_src_E2_count  := if(ver_src_e2_pos > 0, 1, 0);
 
 //*** E3 ***  CREDENTIALED
   ver_src_e3_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_CCW , COMMA, MODIFIER);
   _ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), CHAR0);
   _ver_src_ldate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_e3_pos), CHAR0);
   ver_src_fdate_e3  := Models.common.sas_date((STRING)(_ver_src_fdate_e3));
   ver_src_ldate_e3  := Models.common.sas_date((STRING)(_ver_src_ldate_e3));
   ver_src_E3_count  := if(ver_src_e3_pos > 0, 1, 0);
   
 //*** E4 ***
   ver_src_e4_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Cens , COMMA, MODIFIER);
   _ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), CHAR0);
   _ver_src_ldate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_e4_pos), CHAR0);
   ver_src_fdate_e4  := Models.common.sas_date((STRING)(_ver_src_fdate_e4));
   ver_src_ldate_e4  := Models.common.sas_date((STRING)(_ver_src_ldate_e4));
   ver_src_E4_count  := if(ver_src_e4_pos > 0, 1, 0);
 
 //*** EN ***
   ver_src_en_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Experian_Credit_Header , COMMA, MODIFIER);
   _ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), CHAR0);
   _ver_src_ldate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_en_pos), CHAR0);
   ver_src_fdate_en  := Models.common.sas_date((STRING)(_ver_src_fdate_en));
   ver_src_ldate_en  := Models.common.sas_date((STRING)(_ver_src_ldate_en));
   ver_src_EN_count  := if(ver_src_en_pos > 0, 1, 0);
 
 //*** EQ ***
   ver_src_eq_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Equifax , COMMA, MODIFIER);
   _ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), CHAR0);
   _ver_src_ldate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_eq_pos), CHAR0);
   ver_src_fdate_eq  := Models.common.sas_date((STRING)(_ver_src_fdate_eq));
   ver_src_ldate_eq  := Models.common.sas_date((STRING)(_ver_src_ldate_eq));
   ver_src_EQ_count  := if(ver_src_eq_pos > 0, 1, 0);

 //*** FE ***  CREDENTIALED
   ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Federal_Explosives , COMMA, MODIFIER);
   _ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), CHAR0);
   _ver_src_ldate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_fe_pos), CHAR0);
   ver_src_fdate_fe  := Models.common.sas_date((STRING)(_ver_src_fdate_fe));
   ver_src_ldate_fe  := Models.common.sas_date((STRING)(_ver_src_ldate_fe));
   ver_src_FE_count  := if(ver_src_fe_pos > 0, 1, 0);
 
 //*** FF ***  CREDENTIALED
   ver_src_ff_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Federal_Firearms , COMMA, MODIFIER);
   _ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), CHAR0);
   _ver_src_ldate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ff_pos), CHAR0);
   ver_src_fdate_ff  := Models.common.sas_date((STRING)(_ver_src_fdate_ff));
   ver_src_ldate_ff  := Models.common.sas_date((STRING)(_ver_src_ldate_ff));
   ver_src_ff_count  := if(ver_src_ff_pos > 0, 1, 0);

 //*** FR ***
  ver_src_fr_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Foreclosures , COMMA, MODIFIER);
   _ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), CHAR0);
   _ver_src_ldate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_fr_pos), CHAR0);
   ver_src_fdate_fr  := Models.common.sas_date((STRING)(_ver_src_fdate_fr));
   ver_src_ldate_fr  := Models.common.sas_date((STRING)(_ver_src_ldate_fr));
   ver_src_FR_count  := if(ver_src_fr_pos > 0, 1, 0);

 //*** L2 ***
   ver_src_l2_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Liens_v2 , COMMA, MODIFIER);
   _ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), CHAR0);
   _ver_src_ldate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_l2_pos), CHAR0);
   ver_src_fdate_l2  := Models.common.sas_date((STRING)(_ver_src_fdate_l2));
   ver_src_ldate_l2  := Models.common.sas_date((STRING)(_ver_src_ldate_l2));
   ver_src_L2_count  := if(ver_src_l2_pos > 0, 1, 0);

 //*** LI ***
   ver_src_li_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Liens , COMMA, MODIFIER);
   _ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), CHAR0);
   _ver_src_ldate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_li_pos), CHAR0);
   ver_src_fdate_li  := Models.common.sas_date((STRING)(_ver_src_fdate_li));
   ver_src_ldate_li  := Models.common.sas_date((STRING)(_ver_src_ldate_li));
   ver_src_LI_count  := if(ver_src_li_pos > 0, 1, 0);
 
 //*** MW ***
   ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_MS_Worker_Comp , COMMA, MODIFIER);
   _ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), CHAR0);
   _ver_src_ldate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_mw_pos), CHAR0);
   ver_src_fdate_mw  := Models.common.sas_date((STRING)(_ver_src_fdate_mw));
   ver_src_ldate_mw  := Models.common.sas_date((STRING)(_ver_src_ldate_mw));
   ver_src_MW_count  := if(ver_src_mw_pos > 0, 1, 0);
 
 //*** NT ***
   ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Foreclosures_Delinquent , COMMA, MODIFIER);
   _ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), CHAR0);
   _ver_src_ldate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_nt_pos), CHAR0);
   ver_src_fdate_nt  := Models.common.sas_date((STRING)(_ver_src_fdate_nt));
   ver_src_ldate_nt  := Models.common.sas_date((STRING)(_ver_src_ldate_nt));
   ver_src_NT_count  := if(ver_src_nt_pos > 0, 1, 0);
   
 //*** P  ***  CREDENTIALED  
   ver_src_p_pos := Models.Common.findw_cpp(ver_sources, Citizenship.Constants.P_SOURCE , COMMA, MODIFIER);
   _ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), CHAR0);
   _ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_p_pos), CHAR0);
   ver_src_fdate_p  := Models.common.sas_date((STRING)(_ver_src_fdate_p));
   ver_src_ldate_p  := Models.common.sas_date((STRING)(_ver_src_ldate_p));
   ver_src_p_count  := if(ver_src_p_pos > 0, 1, 0);
 
 //*** PL ***  CREDENTIALED
   ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Professional_License , COMMA, MODIFIER);
   _ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), CHAR0);
   _ver_src_ldate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_pl_pos), CHAR0);
   ver_src_fdate_pl  := Models.common.sas_date((STRING)(_ver_src_fdate_pl));
   ver_src_ldate_pl  := Models.common.sas_date((STRING)(_ver_src_ldate_pl));
   ver_src_PL_count  := if(ver_src_pl_pos > 0, 1, 0);
 
 //*** TN ***
   ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TU_CreditHeader , COMMA, MODIFIER);
   _ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), CHAR0);
   _ver_src_ldate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_tn_pos), CHAR0);
   ver_src_fdate_tn  := Models.common.sas_date((STRING)(_ver_src_fdate_tn));
   ver_src_ldate_tn  := Models.common.sas_date((STRING)(_ver_src_ldate_tn));
   ver_src_TN_count  := if(ver_src_tn_pos > 0, 1, 0);
   
 //*** TS ***
   ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TUCS_Ptrack , COMMA, MODIFIER);
   _ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), CHAR0);
   _ver_src_ldate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_ts_pos), CHAR0);
   ver_src_fdate_ts  := Models.common.sas_date((STRING)(_ver_src_fdate_ts));
   ver_src_ldate_ts  := Models.common.sas_date((STRING)(_ver_src_ldate_ts));
   ver_src_TS_count  := if(ver_src_ts_pos > 0, 1, 0);
 
 //*** TU ***
   ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TransUnion , COMMA, MODIFIER);
   _ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), CHAR0);
   _ver_src_ldate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_tu_pos), CHAR0);
   ver_src_fdate_tu  := Models.common.sas_date((STRING)(_ver_src_fdate_tu));
   ver_src_ldate_tu  := Models.common.sas_date((STRING)(_ver_src_ldate_tu));
   ver_src_TU_count  := if(ver_src_tu_pos > 0, 1, 0);
 
 //*** SL ***  CREDENTIALED
   ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_American_Students_List , COMMA, MODIFIER);
   _ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), CHAR0);
   _ver_src_ldate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_sl_pos), CHAR0);
   ver_src_fdate_sl  := Models.common.sas_date((STRING)(_ver_src_fdate_sl));
   ver_src_ldate_sl  := Models.common.sas_date((STRING)(_ver_src_ldate_sl));
   ver_src_SL_count  := if(ver_src_sl_pos > 0, 1, 0);
 
 //*** V ***  CREDENTIALED
   ver_src_v_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Vickers , COMMA, MODIFIER);
   _ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), CHAR0);
   _ver_src_ldate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_v_pos), CHAR0);
   ver_src_fdate_v  := Models.common.sas_date((STRING)(_ver_src_fdate_v));
   ver_src_ldate_v  := Models.common.sas_date((STRING)(_ver_src_ldate_v));
   ver_src_V_count  := if(ver_src_v_pos > 0, 1, 0);
  
   
 //*** VO ***  CREDENTIALED
   ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Voters_v2 , COMMA, MODIFIER);
   _ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), CHAR0);
   _ver_src_ldate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_vo_pos), CHAR0);
   ver_src_fdate_vo  := Models.common.sas_date((STRING)(_ver_src_fdate_vo));
   ver_src_ldate_vo  := Models.common.sas_date((STRING)(_ver_src_ldate_vo));
   ver_src_VO_count  := if(ver_src_vo_pos > 0, 1, 0);
  
 //*** W  ***  CREDENTIALED
   ver_src_w_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Whois_domains , COMMA, MODIFIER);
   _ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), CHAR0);
   _ver_src_ldate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_w_pos), CHAR0);
   ver_src_fdate_w  := Models.common.sas_date((STRING)(_ver_src_fdate_w));
   ver_src_ldate_w  := Models.common.sas_date((STRING)(_ver_src_ldate_w));
   ver_src_W_count  := if(ver_src_w_pos > 0, 1, 0);
  
 //*** WP ***   
   ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Targus_White_pages , COMMA, MODIFIER);
   _ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), CHAR0);
   _ver_src_ldate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_last_seen,  ver_src_wp_pos), CHAR0);
   ver_src_fdate_wp  := Models.common.sas_date((STRING)(_ver_src_fdate_wp));
   ver_src_ldate_wp  := Models.common.sas_date((STRING)(_ver_src_ldate_wp));
   ver_src_WP_count  := if(ver_src_wp_pos > 0, 1, 0);
   
   //***Extract the earliest header date from all sources defined by the project.
   sum_of_any_sources := ver_src_AK_count +   ver_src_AM_count +   ver_src_AR_count +    ver_src_BA_count +   ver_src_CG_count +   ver_src_CO_count +   ver_src_CY_count +   ver_src_DA_count  +  ver_src_D_count  +   ver_src_DL_count +
                         ver_src_DS_count +   ver_src_DE_count +   ver_src_EB_count +    ver_src_EM_count +   ver_src_E1_count +   ver_src_E2_count +   ver_src_E3_count +   ver_src_E4_count  +  ver_src_EN_count +   ver_src_EQ_count +
                         ver_src_FE_count +   ver_src_FF_count +   ver_src_FR_count +    ver_src_L2_count +   ver_src_LI_count +   ver_src_MW_count +   ver_src_NT_count +   ver_src_P_count   +  ver_src_PL_count +   ver_src_SL_count +
                         ver_src_TN_count +   ver_src_TS_count +   ver_src_TU_count +    ver_src_V_count  +   ver_src_VO_count +   ver_src_W_count  +   ver_src_WP_count; 
                         
  earliest_header_date := if(max(ver_src_fdate_de,  ver_src_fdate_e4, ver_src_fdate_ar, ver_src_fdate_co, 
                                 ver_src_fdate_em,  ver_src_fdate_pl, ver_src_fdate_ds, ver_src_fdate_en, 
                                 ver_src_fdate_mw,  ver_src_fdate_ba, ver_src_fdate_da, ver_src_fdate_vo, 
                                 ver_src_fdate_eq,  ver_src_fdate_cy, ver_src_fdate_dl, ver_src_fdate_tu, 
                                 ver_src_fdate_d,   ver_src_fdate_e1, ver_src_fdate_ts, ver_src_fdate_wp, 
                                 ver_src_fdate_ak,  ver_src_fdate_am, ver_src_fdate_e2, ver_src_fdate_nt, 
                                 ver_src_fdate_fr,  ver_src_fdate_v,  ver_src_fdate_p,  ver_src_fdate_ff, 
                                 ver_src_fdate_cg,  ver_src_fdate_eb, ver_src_fdate_sl, ver_src_fdate_e3, 
                                 ver_src_fdate_l2,  ver_src_fdate_w,  ver_src_fdate_fe, ver_src_fdate_li, 
                                 ver_src_fdate_tn) = NULL, NULL, 
                        min(if(ver_src_fdate_de = NULL, -NULL, ver_src_fdate_de), 
                            if(ver_src_fdate_e4 = NULL, -NULL, ver_src_fdate_e4), 
                            if(ver_src_fdate_ar = NULL, -NULL, ver_src_fdate_ar), 
                            if(ver_src_fdate_co = NULL, -NULL, ver_src_fdate_co), 
                            if(ver_src_fdate_em = NULL, -NULL, ver_src_fdate_em), 
                            if(ver_src_fdate_pl = NULL, -NULL, ver_src_fdate_pl), 
                            if(ver_src_fdate_ds = NULL, -NULL, ver_src_fdate_ds), 
                            if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
                            if(ver_src_fdate_mw = NULL, -NULL, ver_src_fdate_mw), 
                            if(ver_src_fdate_ba = NULL, -NULL, ver_src_fdate_ba), 
                            if(ver_src_fdate_da = NULL, -NULL, ver_src_fdate_da), 
                            if(ver_src_fdate_vo = NULL, -NULL, ver_src_fdate_vo), 
                            if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq), 
                            if(ver_src_fdate_cy = NULL, -NULL, ver_src_fdate_cy), 
                            if(ver_src_fdate_dl = NULL, -NULL, ver_src_fdate_dl), 
                            if(ver_src_fdate_tu = NULL, -NULL, ver_src_fdate_tu), 
                            if(ver_src_fdate_d = NULL, -NULL, ver_src_fdate_d), 
                            if(ver_src_fdate_e1 = NULL, -NULL, ver_src_fdate_e1), 
                            if(ver_src_fdate_ts = NULL, -NULL, ver_src_fdate_ts), 
                            if(ver_src_fdate_wp = NULL, -NULL, ver_src_fdate_wp), 
                            if(ver_src_fdate_ak = NULL, -NULL, ver_src_fdate_ak), 
                            if(ver_src_fdate_am = NULL, -NULL, ver_src_fdate_am), 
                            if(ver_src_fdate_e2 = NULL, -NULL, ver_src_fdate_e2), 
                            if(ver_src_fdate_nt = NULL, -NULL, ver_src_fdate_nt), 
                            if(ver_src_fdate_fr = NULL, -NULL, ver_src_fdate_fr), 
                            if(ver_src_fdate_v = NULL, -NULL, ver_src_fdate_v),
                            if(ver_src_fdate_p = NULL, -NULL, ver_src_fdate_p),
                            if(ver_src_fdate_ff = NULL, -NULL, ver_src_fdate_ff), 
                            if(ver_src_fdate_cg = NULL, -NULL, ver_src_fdate_cg), 
                            if(ver_src_fdate_eb = NULL, -NULL, ver_src_fdate_eb), 
                            if(ver_src_fdate_sl = NULL, -NULL, ver_src_fdate_sl), 
                            if(ver_src_fdate_e3 = NULL, -NULL, ver_src_fdate_e3), 
                            if(ver_src_fdate_l2 = NULL, -NULL, ver_src_fdate_l2), 
                            if(ver_src_fdate_w = NULL, -NULL, ver_src_fdate_w), 
                            if(ver_src_fdate_fe = NULL, -NULL, ver_src_fdate_fe), 
                            if(ver_src_fdate_li = NULL, -NULL, ver_src_fdate_li), 
                            if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn)));
                            
       //***Extract earliest bureau date from these sources
       sum_of_bureau_sources := ver_src_TN_count +   ver_src_EN_count +   ver_src_EQ_count;
       
       earliest_bureau_date  := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, 
                        if(max(ver_src_fdate_tn, 
                               ver_src_fdate_en, 
                               ver_src_fdate_eq) = NULL, NULL, 
                               min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), 
                                   if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
                                   if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));
                                   
      //***Extract last seen date from these credentialed sources                             
      sum_of_credentialed_sources := ver_src_AR_count +    ver_src_AM_count +   ver_src_BA_count +   ver_src_CG_count +   
                                  ver_src_DA_count +    ver_src_D_count  +   ver_src_DL_count +   ver_src_EB_count +
                                  ver_src_E1_count +    ver_src_E2_count +   ver_src_E3_count +   ver_src_FE_count +   
                                  ver_src_FF_count +    ver_src_P_count  +   ver_src_PL_count +   ver_src_SL_count +  
                                  ver_src_V_count  +    ver_src_VO_count +   ver_src_W_count;
                                  
      ldate_credentialed := MAX( ver_src_ldate_AR, ver_src_ldate_AM, ver_src_ldate_BA, ver_src_ldate_CG,
                                 ver_src_ldate_DA, ver_src_ldate_D,  ver_src_ldate_DL, ver_src_ldate_EB,
                                 ver_src_ldate_E1, ver_src_ldate_E2, ver_src_ldate_E3, ver_src_ldate_FE,
                                 ver_src_ldate_FF, ver_src_ldate_P,  ver_src_ldate_PL, ver_src_ldate_SL,
                                 ver_src_ldate_V,  ver_src_ldate_VO, ver_src_ldate_W);


       
   
      //***these dates are returned in the SAS format - the format needed to calcuate age or number days ****//      
      string10 char_SAS_earliest_header_date    := (string)earliest_header_date; 
      string10 char_SAS_earliest_bureau_date    := (string)earliest_bureau_date;
      string10 char_SAS_ldate_credentialed      := (string)ldate_credentialed;  
      string3  char_sum_of_credentialed_sources := (string)sum_of_credentialed_sources;   
      string3 char_sum_of_any_sources           := (string)sum_of_any_sources;   
      string3 char_sum_of_bureau_sources        := (string)sum_of_bureau_sources;   
    
     
     
   //***return a string or a single row of information that was extracted from the Ver Source data***  
    Return char_SAS_earliest_header_date    +          //***position 1  - 10
                                     ','    +   
           char_SAS_earliest_bureau_date    +          //***position 12 - 21
                                     ','    +    
           char_SAS_ldate_credentialed      +          //***position 23 - 32
                                     ','    +    
           char_sum_of_credentialed_sources +          //***position 34 - 36
                                     ','    +
           char_sum_of_bureau_sources       +          //***position 38 - 40
                                     ','    +
           char_sum_of_any_sources          +          //***position 42 - 44
                                     ',END';  
    
    
    
    
 END;   //***End of Function
 
 
 
 //***FOR DEBUGGING ONLY
 // output(ver_src_fdate_ak,   Named ('ver_src_fdate_ak')); 
     // output(ver_src_ak_pos,     Named ('ver_src_ak_pos'));
     // output(ver_src_fdate_eq,   Named ('ver_src_fdate_eq')); 
     // output(ver_src_eq_pos    , Named ('ver_src_eq_pos'));
     //***These are the sources found in the ver source field ***//
     // output(ver_src_AK    ,     Named ('a1ver_src_AK'));
     // output(ver_src_AM    ,     Named ('a2ver_src_AM'));  //***Cred
     // output(ver_src_AR    ,     Named ('a3ver_src_AR'));  //***Cred
     // output(ver_src_BA    ,     Named ('a4ver_src_BA'));  //***Cred
     // output(ver_src_CG    ,     Named ('a5ver_src_CG'));  //***Cred
     // output(ver_src_CO    ,     Named ('a6ver_src_CO'));
     // output(ver_src_CY    ,     Named ('a7ver_src_CY'));
     // output(ver_src_DA    ,     Named ('a8ver_src_DA'));  //***Cred
     // output(ver_src_D     ,     Named ('a9ver_src_D'));   //***Cred
     // output(ver_src_DL    ,     Named ('a10ver_src_DL')); //***Cred
     // output(ver_src_DS    ,     Named ('a11ver_src_DS'));
     // output(ver_src_DE    ,     Named ('a12ver_src_DE'));  
     // output(ver_src_EB    ,     Named ('a13ver_src_EB')); //***Cred
     // output(ver_src_EM    ,     Named ('a14ver_src_EM'));
     // output(ver_src_E1    ,     Named ('a15ver_src_E1'));  //***Cred
     // output(ver_src_E2    ,     Named ('a16ver_src_E2'));  //***Cred
     // output(ver_src_E3    ,     Named ('a17ver_src_E3'));  //***Cred
     // output(ver_src_E4    ,     Named ('a18ver_src_E4'));
     // output(ver_src_EN    ,     Named ('a19ver_src_EN'));
     // output(ver_src_EQ    ,     Named ('a20ver_src_EQ'));
     // output(ver_src_FE    ,     Named ('a21ver_src_FE'));  //***Cred
     // output(ver_src_FF    ,     Named ('a22ver_src_FF'));  //***Cred
     // output(ver_src_FR    ,     Named ('a23ver_src_FR'));
     // output(ver_src_L2    ,     Named ('a24ver_src_L2'));
     // output(ver_src_LI    ,     Named ('a25ver_src_LI'));
     // output(ver_src_MW    ,     Named ('a26ver_src_MW'));
     // output(ver_src_NT    ,     Named ('a27ver_src_NT'));
     // output(ver_src_P     ,     Named ('a28ver_src_P'));   //***Cred
     // output(ver_src_PL    ,     Named ('a29ver_src_PL'));  //***Cred
     // output(ver_src_TN    ,     Named ('a30ver_src_TN'));
     // output(ver_src_TS    ,     Named ('a31ver_src_TS'));
     // output(ver_src_TU    ,     Named ('a32ver_src_TU'));
     // output(ver_src_SL    ,     Named ('a33ver_src_SL'));  //***Cred
     // output(ver_src_V     ,     Named ('a34ver_src_V'));   //***Cred
     // output(ver_src_VO    ,     Named ('a35ver_src_VO'));
     // output(ver_src_W     ,     Named ('a36ver_src_W'));   //***Cred
     // output(ver_src_WP    ,     Named ('a37ver_src_WP'));