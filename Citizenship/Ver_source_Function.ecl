﻿IMPORT Models, Citizenship;

EXPORT Ver_source_Function(boolean BureauOnly, STRING ver_sources, STRING ver_sources_first_seen, STRING ver_sources_NAS) := FUNCTION
//========================================================================================
     NULL := -999999999;
     AK_SOURCE := 'AK'; 
     AM_SOURCE := 'AM';
     AR_SOURCE := 'AR';
     COMMA     := '  ,';
     MODIFIER  := 'ie';
     CHAR0     := '0';  
     //***Other constants will be converted in next release***//

     ver_src_ak_pos    := Models.Common.findw_cpp(ver_sources, AK_SOURCE , COMMA, MODIFIER);
     _ver_src_fdate_ak := if(ver_src_ak_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ak_pos), CHAR0);
     ver_src_fdate_ak  := Models.common.sas_date((    STRING)(_ver_src_fdate_ak));

     ver_src_am_pos    := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');
     _ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');
     ver_src_fdate_am  := Models.common.sas_date((    STRING)(_ver_src_fdate_am));

     ver_src_ar_pos    := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');
     _ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');
     ver_src_fdate_ar  := Models.common.sas_date((    STRING)(_ver_src_fdate_ar));

     ver_src_ba_pos    := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');
     _ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');
     ver_src_fdate_ba  := Models.common.sas_date((    STRING)(_ver_src_fdate_ba));

     ver_src_cg_pos    := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');
     _ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');
     ver_src_fdate_cg  := Models.common.sas_date((    STRING)(_ver_src_fdate_cg));

 //*** Source CO ***
    ver_src_co_pos    := Models.Common.findw_cpp(ver_sources, 'CO' , '  ,', 'ie');
    _ver_src_fdate_co := if(ver_src_co_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_co_pos), '0');
    ver_src_fdate_co  := Models.common.sas_date((    STRING)(_ver_src_fdate_co));
//*** Source CY ***
    ver_src_cy_pos    := Models.Common.findw_cpp(ver_sources, 'CY' , '  ,', 'ie');
    _ver_src_fdate_cy := if(ver_src_cy_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cy_pos), '0');
    ver_src_fdate_cy  := Models.common.sas_date((    STRING)(_ver_src_fdate_cy));

    ver_src_da_pos    := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');
    _ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');
    ver_src_fdate_da  := Models.common.sas_date((    STRING)(_ver_src_fdate_da));

   ver_src_d_pos    := Models.Common.findw_cpp(ver_sources, 'D' , '  ,', 'ie');
   _ver_src_fdate_d := if(ver_src_d_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_d_pos), '0');
   ver_src_fdate_d  := Models.common.sas_date((    STRING)(_ver_src_fdate_d));

   ver_src_dl_pos    := Models.Common.findw_cpp(ver_sources, 'DL' , '  ,', 'ie');
   _ver_src_fdate_dl := if(ver_src_dl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_dl_pos), '0');
   ver_src_fdate_dl  := Models.common.sas_date((    STRING)(_ver_src_fdate_dl));

   ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');
   _ver_src_fdate_ds := if(ver_src_ds_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ds_pos), '0');
   ver_src_fdate_ds := Models.common.sas_date((    STRING)(_ver_src_fdate_ds));

   ver_src_de_pos    := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');
   _ver_src_fdate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_de_pos), '0');
   ver_src_fdate_de  := Models.common.sas_date((    STRING)(_ver_src_fdate_de));

   ver_src_eb_pos    := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');
   _ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');
   ver_src_fdate_eb  := Models.common.sas_date((    STRING)(_ver_src_fdate_eb));

   ver_src_em_pos    := Models.Common.findw_cpp(ver_sources, 'EM' , '  ,', 'ie');
   _ver_src_fdate_em := if(ver_src_em_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_em_pos), '0');
   ver_src_fdate_em  := Models.common.sas_date((    STRING)(_ver_src_fdate_em));

   ver_src_e1_pos    := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');
   _ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');
   ver_src_fdate_e1  := Models.common.sas_date((    STRING)(_ver_src_fdate_e1));

   ver_src_e2_pos    := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');
   _ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');
   ver_src_fdate_e2  := Models.common.sas_date((    STRING)(_ver_src_fdate_e2));

   ver_src_e3_pos    := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');
   _ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');
   ver_src_fdate_e3  := Models.common.sas_date((    STRING)(_ver_src_fdate_e3));

   ver_src_e4_pos    := Models.Common.findw_cpp(ver_sources, 'E4' , '  ,', 'ie');
   _ver_src_fdate_e4 := if(ver_src_e4_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e4_pos), '0');
   ver_src_fdate_e4  := Models.common.sas_date((    STRING)(_ver_src_fdate_e4));

   ver_src_en_pos    := Models.Common.findw_cpp(ver_sources, 'EN' , '  ,', 'ie');
   _ver_src_fdate_en := if(ver_src_en_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_en_pos), '0');
   ver_src_fdate_en  := Models.common.sas_date((    STRING)(_ver_src_fdate_en));

   ver_src_eq_pos    := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');
   _ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');
   ver_src_fdate_eq  := Models.common.sas_date((    STRING)(_ver_src_fdate_eq));

   ver_src_fe_pos := Models.Common.findw_cpp(ver_sources, 'FE' , '  ,', 'ie');
   _ver_src_fdate_fe := if(ver_src_fe_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fe_pos), '0');
   ver_src_fdate_fe := Models.common.sas_date((    STRING)(_ver_src_fdate_fe));

   ver_src_ff_pos    := Models.Common.findw_cpp(ver_sources, 'FF' , '  ,', 'ie');
   _ver_src_fdate_ff := if(ver_src_ff_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ff_pos), '0');
   ver_src_fdate_ff  := Models.common.sas_date((    STRING)(_ver_src_fdate_ff));

   ver_src_fr_pos    := Models.Common.findw_cpp(ver_sources, 'FR' , '  ,', 'ie');
   _ver_src_fdate_fr := if(ver_src_fr_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_fr_pos), '0');
   ver_src_fdate_fr  := Models.common.sas_date((    STRING)(_ver_src_fdate_fr));

   ver_src_l2_pos    := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');
   _ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');
   ver_src_fdate_l2  := Models.common.sas_date((    STRING)(_ver_src_fdate_l2));

   ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');
   _ver_src_fdate_li := if(ver_src_li_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_li_pos), '0');
   ver_src_fdate_li := Models.common.sas_date((    STRING)(_ver_src_fdate_li));
   
   ver_src_mw_pos := Models.Common.findw_cpp(ver_sources, 'MW' , '  ,', 'ie');
   _ver_src_fdate_mw := if(ver_src_mw_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_mw_pos), '0');
   ver_src_fdate_mw := Models.common.sas_date((    STRING)(_ver_src_fdate_mw));
   
   ver_src_nt_pos := Models.Common.findw_cpp(ver_sources, 'NT' , '  ,', 'ie');
   _ver_src_fdate_nt := if(ver_src_nt_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_nt_pos), '0');
   ver_src_fdate_nt := Models.common.sas_date((    STRING)(_ver_src_fdate_nt));
   
   ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');
   _ver_src_fdate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_p_pos), '0');
   ver_src_fdate_p := Models.common.sas_date((    STRING)(_ver_src_fdate_p));
   
   ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');
   _ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');
   ver_src_fdate_pl := Models.common.sas_date((    STRING)(_ver_src_fdate_pl));
   
   ver_src_tn_pos := Models.Common.findw_cpp(ver_sources, 'TN' , '  ,', 'ie');
   _ver_src_fdate_tn := if(ver_src_tn_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tn_pos), '0');
   ver_src_fdate_tn := Models.common.sas_date((    STRING)(_ver_src_fdate_tn));
   
   ver_src_ts_pos := Models.Common.findw_cpp(ver_sources, 'TS' , '  ,', 'ie');
   _ver_src_fdate_ts := if(ver_src_ts_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ts_pos), '0');
   ver_src_fdate_ts := Models.common.sas_date((    STRING)(_ver_src_fdate_ts));
   
   ver_src_tu_pos := Models.Common.findw_cpp(ver_sources, 'TU' , '  ,', 'ie');
   _ver_src_fdate_tu := if(ver_src_tu_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_tu_pos), '0');
   ver_src_fdate_tu := Models.common.sas_date((    STRING)(_ver_src_fdate_tu));

   ver_src_sl_pos := Models.Common.findw_cpp(ver_sources, 'SL' , '  ,', 'ie');
   _ver_src_fdate_sl := if(ver_src_sl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_sl_pos), '0');
   ver_src_fdate_sl := Models.common.sas_date((    STRING)(_ver_src_fdate_sl));
   
   ver_src_v_pos := Models.Common.findw_cpp(ver_sources, 'V' , '  ,', 'ie');
   _ver_src_fdate_v := if(ver_src_v_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_v_pos), '0');
   ver_src_fdate_v := Models.common.sas_date((    STRING)(_ver_src_fdate_v));
   
   ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');
   _ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');
   ver_src_fdate_vo := Models.common.sas_date((    STRING)(_ver_src_fdate_vo));
   
   ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');
   _ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');
   ver_src_fdate_w := Models.common.sas_date((    STRING)(_ver_src_fdate_w));
   
   ver_src_wp_pos := Models.Common.findw_cpp(ver_sources, 'WP' , '  ,', 'ie');
   _ver_src_fdate_wp := if(ver_src_wp_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_wp_pos), '0');
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