import Models, Risk_Indicators, ut, std, riskview;


EXPORT getSourceProfile (GROUPED DATASET (Layout_Boca_Shell) clam, boolean isFCRA) := FUNCTION;

layout_debug := record
	decimal6_1 hdr_source_profile; 
	integer hdr_source_profile_index;
	// string account; 
	boolean truedid; 
	integer nas_summary; 
	integer nap_summary; 
	string ver_sources; 
	// string ver_sources_nas; 
	string ver_sources_first_seen; 
	// string ver_sources_last_seen; 
	// string ver_sources_count; 
	integer add_input_naprop; 
	integer infutor_nap; 
	integer email_count; 
	string archive_date; 
	unsigned sysdate; 
end;

Layout_Boca_Shell  GetSrcProfile(clam le) := TRANSFORM
// Layout_debug GetSrcProfile(clam le) := TRANSFORM

NULL := -999999999;

sysdate := models.common.sas_date(if(le.historydate=999999, (string)Std.Date.Today(), (string6)le.historydate+'01'));

Add_Input_NAProp := le.address_verification.input_address_information.naprop; 
truedid := le.truedid;
nas_summary                      := le.iid.nas_summary;
nap_summary                      := le.iid.nap_summary;
ver_sources                      := le.header_summary.ver_sources;
ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
infutor_nap                      := le.infutor_phone.infutor_nap;
email_count                      := le.email_summary.email_ct;
	
ver_src_am_pos := Models.Common.findw_cpp(ver_sources, 'AM' , '  ,', 'ie');

ver_src_fdate_am := if(ver_src_am_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_am_pos), '0');

ver_src_fdate_am2 := models.common.sas_date((string)(ver_src_fdate_am));

mth_ver_src_fdate_am := if(min(sysdate, ver_src_fdate_am2) = NULL, NULL, (sysdate - ver_src_fdate_am2) / 30.5);

ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');

ver_src_fdate_ar := if(ver_src_ar_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ar_pos), '0');

ver_src_fdate_ar2 := models.common.sas_date((string)(ver_src_fdate_ar));

mth_ver_src_fdate_ar := if(min(sysdate, ver_src_fdate_ar2) = NULL, NULL, (sysdate - ver_src_fdate_ar2) / 30.5);

ver_src_cg_pos := Models.Common.findw_cpp(ver_sources, 'CG' , '  ,', 'ie');

ver_src_fdate_cg := if(ver_src_cg_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_cg_pos), '0');

ver_src_fdate_cg2 := models.common.sas_date((string)(ver_src_fdate_cg));

mth_ver_src_fdate_cg := if(min(sysdate, ver_src_fdate_cg2) = NULL, NULL, (sysdate - ver_src_fdate_cg2) / 30.5);

ver_src_da_pos := Models.Common.findw_cpp(ver_sources, 'DA' , '  ,', 'ie');

ver_src_fdate_da := if(ver_src_da_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_da_pos), '0');

ver_src_fdate_da2 := models.common.sas_date((string)(ver_src_fdate_da));

mth_ver_src_fdate_da := if(min(sysdate, ver_src_fdate_da2) = NULL, NULL, (sysdate - ver_src_fdate_da2) / 30.5);

ver_src_eb_pos := Models.Common.findw_cpp(ver_sources, 'EB' , '  ,', 'ie');

ver_src_fdate_eb := if(ver_src_eb_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eb_pos), '0');

ver_src_fdate_eb2 := models.common.sas_date((string)(ver_src_fdate_eb));

mth_ver_src_fdate_eb := if(min(sysdate, ver_src_fdate_eb2) = NULL, NULL, (sysdate - ver_src_fdate_eb2) / 30.5);

ver_src_e1_pos := Models.Common.findw_cpp(ver_sources, 'E1' , '  ,', 'ie');

ver_src_fdate_e1 := if(ver_src_e1_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e1_pos), '0');

ver_src_fdate_e12 := models.common.sas_date((string)(ver_src_fdate_e1));

mth_ver_src_fdate_e1 := if(min(sysdate, ver_src_fdate_e12) = NULL, NULL, (sysdate - ver_src_fdate_e12) / 30.5);

ver_src_e2_pos := Models.Common.findw_cpp(ver_sources, 'E2' , '  ,', 'ie');

ver_src_fdate_e2 := if(ver_src_e2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e2_pos), '0');

ver_src_fdate_e22 := models.common.sas_date((string)(ver_src_fdate_e2));

mth_ver_src_fdate_e2 := if(min(sysdate, ver_src_fdate_e22) = NULL, NULL, (sysdate - ver_src_fdate_e22) / 30.5);

ver_src_e3_pos := Models.Common.findw_cpp(ver_sources, 'E3' , '  ,', 'ie');

ver_src_fdate_e3 := if(ver_src_e3_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_e3_pos), '0');

ver_src_fdate_e32 := models.common.sas_date((string)(ver_src_fdate_e3));

mth_ver_src_fdate_e3 := if(min(sysdate, ver_src_fdate_e32) = NULL, NULL, (sysdate - ver_src_fdate_e32) / 30.5);

ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');

ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');

ver_src_fdate_eq2 := models.common.sas_date((string)(ver_src_fdate_eq));

mth_ver_src_fdate_eq := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, (sysdate - ver_src_fdate_eq2) / 30.5);

ver_src_pl_pos := Models.Common.findw_cpp(ver_sources, 'PL' , '  ,', 'ie');

ver_src_fdate_pl := if(ver_src_pl_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_pl_pos), '0');

ver_src_fdate_pl2 := models.common.sas_date((string)(ver_src_fdate_pl));

mth_ver_src_fdate_pl := if(min(sysdate, ver_src_fdate_pl2) = NULL, NULL, (sysdate - ver_src_fdate_pl2) / 30.5);

ver_src_vo_pos := Models.Common.findw_cpp(ver_sources, 'VO' , '  ,', 'ie');

ver_src_fdate_vo := if(ver_src_vo_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_vo_pos), '0');

ver_src_fdate_vo2 := models.common.sas_date((string)(ver_src_fdate_vo));

mth_ver_src_fdate_vo := if(min(sysdate, ver_src_fdate_vo2) = NULL, NULL, (sysdate - ver_src_fdate_vo2) / 30.5);

ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');

ver_src_fdate_w := if(ver_src_w_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_w_pos), '0');

ver_src_fdate_w2 := models.common.sas_date((string)(ver_src_fdate_w));

mth_ver_src_fdate_w := if(min(sysdate, ver_src_fdate_w2) = NULL, NULL, (sysdate - ver_src_fdate_w2) / 30.5);

pk_infutor_hit := infutor_nap >= 2;

pk_mth_ver_src_fdate_eq3 := map(
    mth_ver_src_fdate_eq = NULL => 18,
    mth_ver_src_fdate_eq <= 18  => 18,
    mth_ver_src_fdate_eq <= 24  => 24,
    mth_ver_src_fdate_eq <= 36  => 36,
    mth_ver_src_fdate_eq <= 48  => 48,
    mth_ver_src_fdate_eq <= 60  => 60,
    mth_ver_src_fdate_eq <= 84  => 84,
    mth_ver_src_fdate_eq <= 120 => 120,
    mth_ver_src_fdate_eq <= 168 => 168,
    mth_ver_src_fdate_eq <= 204 => 204,
    mth_ver_src_fdate_eq <= 228 => 228,
    mth_ver_src_fdate_eq <= 252 => 252,
    mth_ver_src_fdate_eq <= 306 => 306,
                                   307);

pk_mth_ver_src_fdate_vo := map(
    mth_ver_src_fdate_vo = NULL => -1,
    mth_ver_src_fdate_vo <= 36  => 36,
    mth_ver_src_fdate_vo <= 60  => 60,
                                   61);

pk_mth_ver_src_fdate_ar := map(
    mth_ver_src_fdate_ar = NULL => NULL,
    mth_ver_src_fdate_ar > 360  => 360,
                                   mth_ver_src_fdate_ar);

pk_mth_ver_src_fdate_eb := map(
    mth_ver_src_fdate_eb = NULL => NULL,
    mth_ver_src_fdate_eb > 360  => 360,
                                   mth_ver_src_fdate_eb);

pk_mth_ver_src_fdate_w := map(
    mth_ver_src_fdate_w = NULL => NULL,
    mth_ver_src_fdate_w > 360  => 360,
                                  mth_ver_src_fdate_w);

pk_mth_ver_src_fdate_e1 := map(
    mth_ver_src_fdate_e1 = NULL => NULL,
    mth_ver_src_fdate_e1 > 360  => 360,
                                   mth_ver_src_fdate_e1);

pk_mth_ver_src_fdate_e2 := map(
    mth_ver_src_fdate_e2 = NULL => NULL,
    mth_ver_src_fdate_e2 > 360  => 360,
                                   mth_ver_src_fdate_e2);

pk_mth_ver_src_fdate_e3 := map(
    mth_ver_src_fdate_e3 = NULL => NULL,
    mth_ver_src_fdate_e3 > 360  => 360,
                                   mth_ver_src_fdate_e3);

pk_mth_ver_src_fdate_pl := map(
    mth_ver_src_fdate_pl = NULL => NULL,
    mth_ver_src_fdate_pl > 360  => 360,
                                   mth_ver_src_fdate_pl);

pk_mth_ver_src_fdate_da := map(
    mth_ver_src_fdate_da = NULL => NULL,
    mth_ver_src_fdate_da > 360  => 360,
                                   mth_ver_src_fdate_da);

pk_mth_ver_src_fdate_am := map(
    mth_ver_src_fdate_am = NULL => NULL,
    mth_ver_src_fdate_am > 360  => 360,
                                   mth_ver_src_fdate_am);

pk_mth_ver_src_fdate_cg := map(
    mth_ver_src_fdate_cg = NULL => NULL,
    mth_ver_src_fdate_cg > 360  => 360,
                                   mth_ver_src_fdate_cg);

fdate_assets := max(pk_mth_ver_src_fdate_ar, pk_mth_ver_src_fdate_eb, pk_mth_ver_src_fdate_w);

pk_fdate_assets := map(
    fdate_assets = NULL => -1,
    fdate_assets <= 60  => 60,
                           61);

fdate_license := max(pk_mth_ver_src_fdate_e1, pk_mth_ver_src_fdate_e2, pk_mth_ver_src_fdate_e3, pk_mth_ver_src_fdate_pl, pk_mth_ver_src_fdate_da, pk_mth_ver_src_fdate_am, pk_mth_ver_src_fdate_cg);

pk_fdate_license := map(
    fdate_license = NULL => -1,
    fdate_license <= 36  => 36,
                            37);

pk_email_count := min(3, if(email_count = NULL, -NULL, email_count));

pk_cons_dir_count := if(max(pk_email_count, (integer)pk_infutor_hit) = NULL, NULL, sum(if(pk_email_count = NULL, 0, pk_email_count), (integer)pk_infutor_hit));

pk_mth_ver_src_fdate_eq3_m := map(
    pk_mth_ver_src_fdate_eq3 = 18  => 0.1855581832,
    pk_mth_ver_src_fdate_eq3 = 24  => 0.1710984779,
    pk_mth_ver_src_fdate_eq3 = 36  => 0.154875717,
    pk_mth_ver_src_fdate_eq3 = 48  => 0.1367494824,
    pk_mth_ver_src_fdate_eq3 = 60  => 0.1258278146,
    pk_mth_ver_src_fdate_eq3 = 84  => 0.1116038882,
    pk_mth_ver_src_fdate_eq3 = 120 => 0.1033544403,
    pk_mth_ver_src_fdate_eq3 = 168 => 0.0942032431,
    pk_mth_ver_src_fdate_eq3 = 204 => 0.0822380543,
    pk_mth_ver_src_fdate_eq3 = 228 => 0.0653159303,
    pk_mth_ver_src_fdate_eq3 = 252 => 0.0551146167,
    pk_mth_ver_src_fdate_eq3 = 306 => 0.0411861128,
    pk_mth_ver_src_fdate_eq3 = 307 => 0.027014652,
                                      0.0902859785);

pk_mth_ver_src_fdate_vo_m := map(
    pk_mth_ver_src_fdate_vo = -1 => 0.0983086907,
    pk_mth_ver_src_fdate_vo = 36 => 0.0781569598,
    pk_mth_ver_src_fdate_vo = 60 => 0.0668205564,
    pk_mth_ver_src_fdate_vo = 61 => 0.045984456,
                                    0.0902859785);

pk_fdate_assets_m := map(
    pk_fdate_assets = -1 => 0.0937239119,
    pk_fdate_assets = 60 => 0.0463576159,
    pk_fdate_assets = 61 => 0.0309086938,
                            0.0902859785);

pk_fdate_license_m := map(
    pk_fdate_license = -1 => 0.0944229276,
    pk_fdate_license = 36 => 0.066888481,
    pk_fdate_license = 37 => 0.0462336348,
                             0.0902859785);

pk_cons_dir_count_m := map(
    pk_cons_dir_count = 0 => 0.0827759453,
    pk_cons_dir_count = 1 => 0.0946710814,
    pk_cons_dir_count = 2 => 0.1051242468,
    pk_cons_dir_count = 3 => 0.1179995391,
    pk_cons_dir_count = 4 => 0.1291254125,
                             0.0902859785);

source_mod_s1w0a1eq1e40_1 := -6.673510346 +
    pk_mth_ver_src_fdate_eq3_m * 10.405255935 +
    pk_mth_ver_src_fdate_vo_m * 5.566191354 +
    pk_fdate_assets_m * 9.1610739452 +
    pk_fdate_license_m * 7.4481576679 +
    pk_cons_dir_count_m * 14.102618074;

source_mod_s1w0a1eq1e40 := exp(source_mod_s1w0a1eq1e40_1) / (1 + exp(source_mod_s1w0a1eq1e40_1));

source_profile1 := if(not( truedid ), -1, max(0, (100 - 500 * source_mod_s1w0a1eq1e40)) );
source_profile := (decimal4_1)source_profile1;

source_profile_index := map(
    not(truedid)                                                                         => -1,
    isFCRA and riskview.Constants.NoScore(NAS_Summary,NAP_Summary, Add_Input_NAProp, le.truedid) => 0,
    NAS_Summary <= 4 AND NAP_Summary <= 4 AND Infutor_NAP <= 4 AND Add_Input_NAProp <= 3 => 0,
    source_profile <= 9                                                                  => 1,
    source_profile <= 36                                                                 => 2,
    source_profile <= 50                                                                 => 3,
    source_profile <= 56                                                                 => 4,
    source_profile <= 69                                                                 => 5,
    source_profile <= 72                                                                 => 6,
    source_profile <= 76                                                                 => 7,
    source_profile <= 79                                                                 => 8,
                                                                                            9);																																														
self.source_profile := source_profile;
self.source_profile_index := source_profile_index;


/*
	self.hdr_source_profile := source_profile;
	self.hdr_source_profile_index := source_profile_index; 
	
	self.truedid := truedid; 
	self.nas_summary := nas_summary;
	self.nap_summary := nap_summary; 
	self.ver_sources := ver_sources; 
	// self.ver_sources_nas := ver_sources_nas;
	self.ver_sources_first_seen := ver_sources_first_seen;
	// self.ver_sources_last_seen := ver_sources_last_seen; 
	// self.ver_sources_count := ver_sources_count; 
	self.add_input_naprop := add_input_naprop; 
	self.infutor_nap := infutor_nap; 
	self.email_count := email_count; 
	self.archive_date := (string)le.historydate;
	self.sysdate := sysdate;
	// self.sysyear := sysyear;	
*/
	
	self :=  le;
														
END;

SrcProfileOut := project(clam, GetSrcProfile(left));


RETURN SrcProfileOut;

END;
