IMPORT Models, Citizenship, MDR;

EXPORT Ver_source_Function(boolean BureauOnly, STRING ver_sources, STRING ver_sources_first_seen) := FUNCTION
//========================================================================================
     NULL := -999999999;
     COMMA     := '  ,';
     MODIFIER  := 'ie';
     CHAR0     := '0';  
   

   //***Pick up the first seen date for each source reporting data***//
   
   //*** AK ***
     ver_src_ak_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_AK_Perm_Fund , COMMA, MODIFIER);
     _ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), CHAR0);
     ver_src_fdate_ak  := Models.common.sas_date((    STRING)(_ver_src_fdate_ak));
   
   //*** AM ***
     ver_src_am_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Airmen , COMMA, MODIFIER);
     _ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), CHAR0);
     ver_src_fdate_am  := Models.common.sas_date((    STRING)(_ver_src_fdate_am));
   
   //*** AR ***
     ver_src_ar_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Aircrafts , COMMA, MODIFIER);
     _ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), CHAR0);
     ver_src_fdate_ar  := Models.common.sas_date((    STRING)(_ver_src_fdate_ar));
   
   //*** BA ***
     ver_src_ba_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Bankruptcy , COMMA, MODIFIER);
     _ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), CHAR0);
     ver_src_fdate_ba  := Models.common.sas_date((    STRING)(_ver_src_fdate_ba));

   //*** CG ***
     ver_src_cg_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_US_Coastguard , COMMA, MODIFIER);
     _ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), CHAR0);
     ver_src_fdate_cg  := Models.common.sas_date((    STRING)(_ver_src_fdate_cg));

 //*** CO ***
    ver_src_co_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_FCRA_Corrections_record , COMMA, MODIFIER);
    _ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), CHAR0);
    ver_src_fdate_co  := Models.common.sas_date((    STRING)(_ver_src_fdate_co));
    
 //*** CY ***
    ver_src_cy_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Certegy , COMMA, MODIFIER);
    _ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), CHAR0);
    ver_src_fdate_cy  := Models.common.sas_date((    STRING)(_ver_src_fdate_cy));
 
 //*** DA ***
    ver_src_da_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_DEA , COMMA, MODIFIER);
    _ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), CHAR0);
    ver_src_fdate_da  := Models.common.sas_date((    STRING)(_ver_src_fdate_da));
 
 //*** D  ***
   ver_src_d_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Dunn_Bradstreet , COMMA, MODIFIER);
   _ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), CHAR0);
   ver_src_fdate_d  := Models.common.sas_date((    STRING)(_ver_src_fdate_d));

 //*** DL ***
   ver_src_dl_pos    := Models.Common.findw_cpp(ver_sources, 'DL' , COMMA, MODIFIER);
   _ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), CHAR0);
   ver_src_fdate_dl  := Models.common.sas_date((    STRING)(_ver_src_fdate_dl));

 //*** DS ***
   ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Death_State , COMMA, MODIFIER);
   _ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), CHAR0);
   ver_src_fdate_ds := Models.common.sas_date((    STRING)(_ver_src_fdate_ds));

 //*** DE ***
   ver_src_de_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Death_Master , COMMA, MODIFIER);
   _ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), CHAR0);
   ver_src_fdate_de  := Models.common.sas_date((    STRING)(_ver_src_fdate_de));

 //*** EB ***
   ver_src_eb_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Boat , COMMA, MODIFIER);
   _ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), CHAR0);
   ver_src_fdate_eb  := Models.common.sas_date((    STRING)(_ver_src_fdate_eb));

 //*** EM ***
   ver_src_em_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Master , COMMA, MODIFIER);
   _ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), CHAR0);
   ver_src_fdate_em  := Models.common.sas_date((    STRING)(_ver_src_fdate_em));

 //*** E1 *** 
   ver_src_e1_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Hunt , COMMA, MODIFIER);
   _ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), CHAR0);
   ver_src_fdate_e1  := Models.common.sas_date((    STRING)(_ver_src_fdate_e1));

 //*** E2 ***
   ver_src_e2_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Fish , COMMA, MODIFIER);
   _ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), CHAR0);
   ver_src_fdate_e2  := Models.common.sas_date((    STRING)(_ver_src_fdate_e2));
 
 //*** E3 ***
   ver_src_e3_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_CCW , COMMA, MODIFIER);
   _ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), CHAR0);
   ver_src_fdate_e3  := Models.common.sas_date((    STRING)(_ver_src_fdate_e3));
 
 //*** E4 ***
   ver_src_e4_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_EMerge_Cens , COMMA, MODIFIER);
   _ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), CHAR0);
   ver_src_fdate_e4  := Models.common.sas_date((    STRING)(_ver_src_fdate_e4));
 
 //*** EN ***
   ver_src_en_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Experian_Credit_Header , COMMA, MODIFIER);
   _ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), CHAR0);
   ver_src_fdate_en  := Models.common.sas_date((    STRING)(_ver_src_fdate_en));
 
 //*** EQ ***
   ver_src_eq_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Equifax , COMMA, MODIFIER);
   _ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), CHAR0);
   ver_src_fdate_eq  := Models.common.sas_date((    STRING)(_ver_src_fdate_eq));

 //*** FE ***
   ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Federal_Explosives , COMMA, MODIFIER);
   _ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), CHAR0);
   ver_src_fdate_fe := Models.common.sas_date((    STRING)(_ver_src_fdate_fe));
 
 //*** FF ***
   ver_src_ff_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Federal_Firearms , COMMA, MODIFIER);
   _ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), CHAR0);
   ver_src_fdate_ff  := Models.common.sas_date((    STRING)(_ver_src_fdate_ff));

 //*** FR ***
  ver_src_fr_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Foreclosures , COMMA, MODIFIER);
   _ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), CHAR0);
   ver_src_fdate_fr  := Models.common.sas_date((    STRING)(_ver_src_fdate_fr));

 //*** L2 ***
   ver_src_l2_pos    := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Liens_v2 , COMMA, MODIFIER);
   _ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), CHAR0);
   ver_src_fdate_l2  := Models.common.sas_date((    STRING)(_ver_src_fdate_l2));

 //*** LI ***
   ver_src_li_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Liens , COMMA, MODIFIER);
   _ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), CHAR0);
   ver_src_fdate_li := Models.common.sas_date((    STRING)(_ver_src_fdate_li));
 
 //*** MW ***
   ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_MS_Worker_Comp , COMMA, MODIFIER);
   _ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), CHAR0);
   ver_src_fdate_mw := Models.common.sas_date((    STRING)(_ver_src_fdate_mw));
 
 //*** NT ***
   ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Foreclosures_Delinquent , COMMA, MODIFIER);
   _ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), CHAR0);
   ver_src_fdate_nt := Models.common.sas_date((    STRING)(_ver_src_fdate_nt));

 //*** P  ***   
   ver_src_p_pos := Models.Common.findw_cpp(ver_sources, Citizenship.Constants.P_SOURCE , COMMA, MODIFIER);
   _ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), CHAR0);
   ver_src_fdate_p := Models.common.sas_date((    STRING)(_ver_src_fdate_p));
 
 //*** PL ***
   ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Professional_License , COMMA, MODIFIER);
   _ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), CHAR0);
   ver_src_fdate_pl := Models.common.sas_date((    STRING)(_ver_src_fdate_pl));
 
 //*** TN ***
   ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TU_CreditHeader , COMMA, MODIFIER);
   _ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), CHAR0);
   ver_src_fdate_tn := Models.common.sas_date((    STRING)(_ver_src_fdate_tn));
 
 //*** TS ***
   ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TUCS_Ptrack , COMMA, MODIFIER);
   _ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), CHAR0);
   ver_src_fdate_ts := Models.common.sas_date((    STRING)(_ver_src_fdate_ts));
 
 //*** TU ***
   ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_TransUnion , COMMA, MODIFIER);
   _ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), CHAR0);
   ver_src_fdate_tu := Models.common.sas_date((    STRING)(_ver_src_fdate_tu));
 
 //*** SL ***
   ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_American_Students_List , COMMA, MODIFIER);
   _ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), CHAR0);
   ver_src_fdate_sl := Models.common.sas_date((    STRING)(_ver_src_fdate_sl));
 
 //*** V ***
   ver_src_v_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Vickers , COMMA, MODIFIER);
   _ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), CHAR0);
   ver_src_fdate_v := Models.common.sas_date((    STRING)(_ver_src_fdate_v));
 
 //*** VO ***
   ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Voters_v2 , COMMA, MODIFIER);
   _ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), CHAR0);
   ver_src_fdate_vo := Models.common.sas_date((    STRING)(_ver_src_fdate_vo));
 
 //*** W  ***
   ver_src_w_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Whois_domains , COMMA, MODIFIER);
   _ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), CHAR0);
   ver_src_fdate_w := Models.common.sas_date((    STRING)(_ver_src_fdate_w));
 
 //*** WP ***   
   ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, MDR.SourceTools.src_Targus_White_pages , COMMA, MODIFIER);
   _ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), CHAR0);
   ver_src_fdate_wp := Models.common.sas_date((    STRING)(_ver_src_fdate_wp));
   
   

earliest_header_date := if(max(ver_src_fdate_de, 
                               ver_src_fdate_e4, 
                               ver_src_fdate_ar, 
                               ver_src_fdate_co, 
                               ver_src_fdate_em, 
                               ver_src_fdate_pl, 
                               ver_src_fdate_ds, 
                               ver_src_fdate_en, 
                               ver_src_fdate_mw, 
                               ver_src_fdate_ba, 
                               ver_src_fdate_da, 
                               ver_src_fdate_vo, 
                               ver_src_fdate_eq, 
                               ver_src_fdate_cy, 
                               ver_src_fdate_dl, 
                               ver_src_fdate_tu, 
                               ver_src_fdate_d, 
                               ver_src_fdate_e1, 
                               ver_src_fdate_ts, 
                               ver_src_fdate_wp, 
                               ver_src_fdate_ak, 
                               ver_src_fdate_am, 
                               ver_src_fdate_e2, 
                               ver_src_fdate_nt, 
                               ver_src_fdate_fr, 
                               ver_src_fdate_v, 
                               ver_src_fdate_p, 
                               ver_src_fdate_ff, 
                               ver_src_fdate_cg, 
                               ver_src_fdate_eb, 
                               ver_src_fdate_sl, 
                               ver_src_fdate_e3, 
                               ver_src_fdate_l2, 
                               ver_src_fdate_w, 
                               ver_src_fdate_fe,
                               ver_src_fdate_li, 
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
                            
                            
    earliest_bureau_date := if(ver_src_fdate_tn = NULL and ver_src_fdate_en = NULL and ver_src_fdate_eq = NULL, NULL, 
                        if(max(ver_src_fdate_tn, 
                               ver_src_fdate_en, 
                               ver_src_fdate_eq) = NULL, NULL, 
                               min(if(ver_src_fdate_tn = NULL, -NULL, ver_src_fdate_tn), 
                                   if(ver_src_fdate_en = NULL, -NULL, ver_src_fdate_en), 
                                   if(ver_src_fdate_eq = NULL, -NULL, ver_src_fdate_eq))));
                            
    earliest_date  := if(BureauOnly, earliest_bureau_date, earliest_header_date);                        
                            
    Return (earliest_date);
    
 END;   //***End of Function