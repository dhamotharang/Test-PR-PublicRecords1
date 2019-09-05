import Std, risk_indicators, riskwise, riskwisefcra, ut, Models, Riskview;

EXPORT RVA1904_1_0(GROUPED dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION
         
	// first run the clam through riskview attributes as this model was built from attributes
    attributes := RiskView.get_attributes_v5(clam, isPrescreen);
    
    MODEL_DEBUG := False;

                   
#if(MODEL_DEBUG)
Layout_Debug := RECORD
INTEGER criminalfelonycount;
INTEGER criminalnonfelonycount12month;
INTEGER criminalnonfelonycount;
INTEGER addrinputmatchindex;
INTEGER evictioncount12month;
INTEGER evictioncount;
REAL bankruptcydismissed24month;
REAL inquiryshortterm12month;
REAL criminalfelonytimenewest;
REAL addrprevioustimeoldest;
REAL assetpropevercount;
REAL subjectage;
REAL addronfilecount;
REAL inquirynonshortterm12month;
REAL addrcurrentavmvalue;
REAL derogtimenewest;
REAL assetpersonal;
REAL inquirybanking12month;
REAL sourcenonderogcount12month;
REAL businessassociation;
REAL addrinputavmvalue;
REAL addrinputproblems;
REAL assetproppurchasecount12month;
REAL addrcurrentavmratio60monthprior;
REAL addrcurrentsubjectowned;
REAL assetpropcurrenttaxtotal;
REAL profliccount;
REAL inquiryauto12month;
REAL inquirytelcom12month;
REAL addrinputavmvalue12month;
REAL addrinputlengthofres;
BOOLEAN truedid;
INTEGER rc_ssndod;
INTEGER rc_decsflag;
STRING ver_sources;
INTEGER add_input_naprop;
INTEGER property_owned_total;
INTEGER stl_inq_count24;
INTEGER attr_eviction_count;
INTEGER bk_dismissed_recent_count;
INTEGER bk_dismissed_historical_count;
INTEGER liens_recent_unrel_count;
INTEGER liens_historical_unrel_count;
INTEGER liens_recent_rel_count;
INTEGER liens_historical_rel_count;
INTEGER liens_unrel_cj_ct;
INTEGER liens_rel_cj_ct;
INTEGER liens_unrel_ft_ct;
INTEGER liens_rel_ft_ct;
INTEGER liens_unrel_fc_ct;
INTEGER liens_rel_fc_ct;
INTEGER liens_unrel_lt_ct;
INTEGER liens_rel_lt_ct;
INTEGER liens_unrel_o_ct;
INTEGER liens_rel_o_ct;
INTEGER liens_unrel_ot_ct;
INTEGER liens_rel_ot_ct;
INTEGER liens_unrel_sc_ct;
INTEGER liens_rel_sc_ct;
INTEGER liens_unrel_st_ct;
INTEGER liens_rel_st_ct;
INTEGER criminal_count;
INTEGER felony_count;
INTEGER ca_criminal_index;
INTEGER ca_inputaddrmatchesprevious;
INTEGER ca_eviction_index;
INTEGER tot_liens;
INTEGER tot_liens_w_type;
INTEGER has_derog;
INTEGER segment_recreate;
REAL derog_v01_w;
STRING derog_aa_code_01_1;
REAL derog_aa_dist_01;
STRING derog_aa_code_01;
REAL derog_v02_w;
STRING derog_aa_code_02_1;
REAL derog_aa_dist_02;
STRING derog_aa_code_02;
REAL derog_v03_w;
STRING derog_aa_code_03_1;
REAL derog_aa_dist_03;
STRING derog_aa_code_03;
REAL derog_v04_w;
STRING derog_aa_code_04_1;
REAL derog_aa_dist_04;
STRING derog_aa_code_04;
REAL derog_v05_w;
STRING derog_aa_code_05_1;
REAL derog_aa_dist_05;
STRING derog_aa_code_05;
REAL derog_v06_w;
STRING derog_aa_code_06_1;
REAL derog_aa_dist_06;
STRING derog_aa_code_06;
REAL derog_v07_w;
STRING derog_aa_code_07_1;
REAL derog_aa_dist_07;
STRING derog_aa_code_07;
REAL derog_v08_w;
STRING derog_aa_code_08_1;
REAL derog_aa_dist_08;
STRING derog_aa_code_08;
REAL derog_v09_w;
STRING derog_aa_code_09_1;
REAL derog_aa_dist_09;
STRING derog_aa_code_09;
REAL derog_v10_w;
STRING derog_aa_code_10_1;
REAL derog_aa_dist_10;
STRING derog_aa_code_10;
REAL derog_v11_w;
STRING derog_aa_code_11_1;
REAL derog_aa_dist_11;
STRING derog_aa_code_11;
REAL derog_v12_w;
STRING derog_aa_code_12_1;
REAL derog_aa_dist_12;
STRING derog_aa_code_12;
REAL derog_v13_w;
STRING derog_aa_code_13_1;
REAL derog_aa_dist_13;
STRING derog_aa_code_13;
REAL derog_v14_w;
STRING derog_aa_code_14_1;
REAL derog_aa_dist_14;
STRING derog_aa_code_14;
REAL derog_v15_w;
STRING derog_aa_code_15_1;
REAL derog_aa_dist_15;
STRING derog_aa_code_15;
REAL derog_v16_w;
STRING derog_aa_code_16_1;
REAL derog_aa_dist_16;
STRING derog_aa_code_16;
REAL derog_v17_w;
STRING derog_aa_code_17_1;
REAL derog_aa_dist_17;
STRING derog_aa_code_17;
REAL derog_rcvalued31;
REAL derog_rcvaluef03;
REAL derog_rcvalued32;
REAL derog_rcvaluec24;
REAL derog_rcvaluea45;
REAL derog_rcvaluec12;
REAL derog_rcvaluea47;
REAL derog_rcvaluei60;
REAL derog_rcvaluee57;
REAL derog_rcvaluea40;
REAL derog_rcvaluec27;
REAL derog_rcvaluec14;
REAL derog_rcvalued33;
REAL derog_lgt;
STRING r_derog_rc1;
STRING r_derog_rc2;
STRING r_derog_rc3;
STRING r_derog_rc4;
STRING r_derog_rc5;
STRING r_derog_rc6;
STRING r_derog_rc7;
STRING r_derog_rc8;
STRING r_derog_rc9;
STRING r_derog_rc10;
STRING r_derog_rc11;
STRING r_derog_rc12;
STRING r_derog_rc13;
STRING r_derog_rc14;
STRING r_derog_rc15;
STRING r_derog_rc16;
STRING r_derog_rc17;
REAL r_derog_vl1;
REAL r_derog_vl2;
REAL r_derog_vl3;
REAL r_derog_vl4;
REAL r_derog_vl5;
REAL r_derog_vl6;
REAL r_derog_vl7;
REAL r_derog_vl8;
REAL r_derog_vl9;
REAL r_derog_vl10;
REAL r_derog_vl11;
REAL r_derog_vl12;
REAL r_derog_vl13;
REAL r_derog_vl14;
REAL r_derog_vl15;
REAL r_derog_vl16;
REAL r_derog_vl17;
STRING derog_rc1_2;
STRING derog_rc2_2;
STRING derog_rc3_2;
STRING derog_rc4_2;
STRING _rc_inq_2;
STRING derog_rc3_c1413;
STRING derog_rc1_c1413;
STRING derog_rc2_c1413;
STRING derog_rc5_c1413;
STRING derog_rc1_1;
STRING derog_rc2_1;
STRING derog_rc3_1;
STRING derog_rc5;
STRING derog_rc4;
STRING derog_rc3;
STRING derog_rc2;
STRING derog_rc1;
BOOLEAN iv_rv5_deceased_2;
INTEGER iv_rv5_unscorable_2;
INTEGER base_2;
INTEGER pts_2;
REAL derog_odds;
INTEGER derog_score;
REAL owner_v01_w;
STRING owner_aa_code_01_1;
REAL owner_aa_dist_01;
STRING owner_aa_code_01;
REAL owner_v02_w;
STRING owner_aa_code_02_1;
REAL owner_aa_dist_02;
STRING owner_aa_code_02;
REAL owner_v03_w;
STRING owner_aa_code_03_1;
REAL owner_aa_dist_03;
STRING owner_aa_code_03;
REAL owner_v04_w;
STRING owner_aa_code_04_1;
REAL owner_aa_dist_04;
STRING owner_aa_code_04;
REAL owner_v05_w;
STRING owner_aa_code_05_1;
REAL owner_aa_dist_05;
STRING owner_aa_code_05;
REAL owner_v06_w;
STRING owner_aa_code_06_1;
REAL owner_aa_dist_06;
STRING owner_aa_code_06;
REAL owner_v07_w;
STRING owner_aa_code_07_1;
REAL owner_aa_dist_07;
STRING owner_aa_code_07;
REAL owner_v08_w;
STRING owner_aa_code_08_1;
REAL owner_aa_dist_08;
STRING owner_aa_code_08;
REAL owner_v09_w;
STRING owner_aa_code_09_1;
REAL owner_aa_dist_09;
STRING owner_aa_code_09;
REAL owner_v10_w;
STRING owner_aa_code_10_1;
REAL owner_aa_dist_10;
STRING owner_aa_code_10;
REAL owner_v11_w;
STRING owner_aa_code_11_1;
REAL owner_aa_dist_11;
STRING owner_aa_code_11;
REAL owner_v12_w;
STRING owner_aa_code_12_1;
REAL owner_aa_dist_12;
STRING owner_aa_code_12;
REAL owner_v13_w;
STRING owner_aa_code_13_1;
REAL owner_aa_dist_13;
STRING owner_aa_code_13;
REAL owner_v14_w;
STRING owner_aa_code_14_1;
REAL owner_aa_dist_14;
STRING owner_aa_code_14;
REAL owner_rcvaluel80;
REAL owner_rcvaluec24;
REAL owner_rcvaluea45;
REAL owner_rcvaluec12;
REAL owner_rcvaluea47;
REAL owner_rcvaluef01;
REAL owner_rcvaluel71;
REAL owner_rcvaluei60;
REAL owner_rcvaluea49;
REAL owner_rcvaluel70;
REAL owner_rcvaluec14;
REAL owner_rcvaluea44;
REAL owner_rcvaluee57;
REAL owner_lgt;
STRING r_owner_rc1;
STRING r_owner_rc2;
STRING r_owner_rc3;
STRING r_owner_rc4;
STRING r_owner_rc5;
STRING r_owner_rc6;
STRING r_owner_rc7;
STRING r_owner_rc8;
STRING r_owner_rc9;
STRING r_owner_rc10;
STRING r_owner_rc11;
STRING r_owner_rc12;
STRING r_owner_rc13;
STRING r_owner_rc14;
REAL r_owner_vl1;
REAL r_owner_vl2;
REAL r_owner_vl3;
REAL r_owner_vl4;
REAL r_owner_vl5;
REAL r_owner_vl6;
REAL r_owner_vl7;
REAL r_owner_vl8;
REAL r_owner_vl9;
REAL r_owner_vl10;
REAL r_owner_vl11;
REAL r_owner_vl12;
REAL r_owner_vl13;
REAL r_owner_vl14;
STRING owner_rc1_1;
STRING owner_rc2_1;
STRING owner_rc3_1;
STRING owner_rc4_1;
STRING _rc_inq_1;
STRING owner_rc5_c1461;
STRING owner_rc4_c1461;
STRING owner_rc2_c1461;
STRING owner_rc1_c1461;
STRING owner_rc3_c1461;
STRING owner_rc5;
STRING owner_rc4;
STRING owner_rc1;
STRING owner_rc2;
STRING owner_rc3;
BOOLEAN iv_rv5_deceased_1;
INTEGER iv_rv5_unscorable_1;
INTEGER base_1;
INTEGER pts_1;
REAL owner_odds;
INTEGER owner_score;
REAL other_v01_w;
STRING other_aa_code_01_1;
REAL other_aa_dist_01;
STRING other_aa_code_01;
REAL other_v02_w;
STRING other_aa_code_02_1;
REAL other_aa_dist_02;
STRING other_aa_code_02;
REAL other_v03_w;
STRING other_aa_code_03_1;
REAL other_aa_dist_03;
STRING other_aa_code_03;
REAL other_v04_w;
STRING other_aa_code_04_1;
REAL other_aa_dist_04;
STRING other_aa_code_04;
REAL other_v05_w;
STRING other_aa_code_05_1;
REAL other_aa_dist_05;
STRING other_aa_code_05;
REAL other_v06_w;
STRING other_aa_code_06_1;
REAL other_aa_dist_06;
STRING other_aa_code_06;
REAL other_v07_w;
STRING other_aa_code_07_1;
REAL other_aa_dist_07;
STRING other_aa_code_07;
REAL other_v08_w;
STRING other_aa_code_08_1;
REAL other_aa_dist_08;
STRING other_aa_code_08;
REAL other_v09_w;
STRING other_aa_code_09_1;
REAL other_aa_dist_09;
STRING other_aa_code_09;
REAL other_v10_w;
STRING other_aa_code_10_1;
REAL other_aa_dist_10;
STRING other_aa_code_10;
REAL other_v11_w;
STRING other_aa_code_11_1;
REAL other_aa_dist_11;
STRING other_aa_code_11;
REAL other_v12_w;
STRING other_aa_code_12_1;
REAL other_aa_dist_12;
STRING other_aa_code_12;
REAL other_v13_w;
STRING other_aa_code_13_1;
REAL other_aa_dist_13;
STRING other_aa_code_13;
REAL other_v14_w;
STRING other_aa_code_14_1;
REAL other_aa_dist_14;
STRING other_aa_code_14;
REAL other_rcvaluef03;
REAL other_rcvaluel80;
REAL other_rcvaluec13;
REAL other_rcvaluec24;
REAL other_rcvaluec12;
REAL other_rcvaluea47;
REAL other_rcvaluel71;
REAL other_rcvaluei60;
REAL other_rcvaluel70;
REAL other_rcvaluec27;
REAL other_rcvaluec14;
REAL other_rcvaluee57;
REAL other_lgt;
STRING r_other_rc1;
STRING r_other_rc2;
STRING r_other_rc3;
STRING r_other_rc4;
STRING r_other_rc5;
STRING r_other_rc6;
STRING r_other_rc7;
STRING r_other_rc8;
STRING r_other_rc9;
STRING r_other_rc10;
STRING r_other_rc11;
STRING r_other_rc12;
STRING r_other_rc13;
STRING r_other_rc14;
REAL r_other_vl1;
REAL r_other_vl2;
REAL r_other_vl3;
REAL r_other_vl4;
REAL r_other_vl5;
REAL r_other_vl6;
REAL r_other_vl7;
REAL r_other_vl8;
REAL r_other_vl9;
REAL r_other_vl10;
REAL r_other_vl11;
REAL r_other_vl12;
REAL r_other_vl13;
REAL r_other_vl14;
STRING other_rc1_2;
STRING other_rc2_1;
STRING other_rc3_1;
STRING other_rc4_1;
STRING _rc_inq;
STRING other_rc3_c1509;
STRING other_rc5_c1509;
STRING other_rc1_c1509;
STRING other_rc4_c1509;
STRING other_rc2_c1509;
STRING other_rc4;
STRING other_rc2;
STRING other_rc5;
STRING other_rc1_1;
STRING other_rc3;
STRING other_rc1;
BOOLEAN iv_rv5_deceased;
INTEGER iv_rv5_unscorable;
INTEGER base;
INTEGER pts;
REAL other_odds;
INTEGER other_score;
INTEGER RVA1904_1_0;
STRING rc5;
STRING rc1;
STRING rc4;
STRING rc3;
STRING rc2;
    
	Risk_Indicators.Layout_Boca_Shell clam;
  
    END;
    
    layout_debug doModel( clam le, attributes rt ) := TRANSFORM
  #else
    Layout_ModelOut doModel( clam le, attributes rt ) := TRANSFORM
  #end	
  
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	criminalfelonycount              := (INTEGER)rt.criminalfelonycount;
	criminalnonfelonycount12month    := (INTEGER)rt.criminalnonfelonycount12month;
	criminalnonfelonycount           := (INTEGER)rt.criminalnonfelonycount;
	addrinputmatchindex              := (INTEGER)rt.addrinputmatchindex;
	evictioncount12month             := (INTEGER)rt.evictioncount12month;
	evictioncount                    := (INTEGER)rt.evictioncount;
	bankruptcydismissed24month       := (REAL)rt.bankruptcydismissed24month;
	inquiryshortterm12month          := (REAL)rt.inquiryshortterm12month;
	criminalfelonytimenewest         := (REAL)rt.criminalfelonytimenewest;
	addrprevioustimeoldest           := (REAL)rt.addrprevioustimeoldest;
	assetpropevercount               := (REAL)rt.assetpropevercount;
	subjectage                       := (REAL)rt.subjectage;
	addronfilecount                  := (REAL)rt.addronfilecount;
	inquirynonshortterm12month       := (REAL)rt.inquirynonshortterm12month;
	addrcurrentavmvalue              := (REAL)rt.addrcurrentavmvalue;
	derogtimenewest                  := (REAL)rt.derogtimenewest;
	assetpersonal                    := (REAL)rt.assetpersonal;
	inquirybanking12month            := (REAL)rt.inquirybanking12month;
	sourcenonderogcount12month       := (REAL)rt.sourcenonderogcount12month;
	businessassociation              := (REAL)rt.businessassociation;
	addrinputavmvalue                := (REAL)rt.addrinputavmvalue;
	addrinputproblems                := (REAL)rt.addrinputproblems;
	assetproppurchasecount12month    := (REAL)rt.assetproppurchasecount12month;
	addrcurrentavmratio60monthprior  := (REAL)rt.addrcurrentavmratio60monthprior;
	addrcurrentsubjectowned          := (REAL)rt.addrcurrentsubjectowned;
	assetpropcurrenttaxtotal         := (REAL)rt.assetpropcurrenttaxtotal;
	profliccount                     := (REAL)rt.profliccount;
	inquiryauto12month               := (REAL)rt.inquiryauto12month;
	inquirytelcom12month             := (REAL)rt.inquirytelcom12month;
	addrinputavmvalue12month         := (REAL)rt.addrinputavmvalue12month;
	addrinputlengthofres             := (REAL)rt.addrinputlengthofres;
	truedid                          := le.truedid;
	rc_ssndod                        := (INTEGER)le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := (INTEGER)le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	stl_inq_count24                  := le.impulse.count24;
	attr_eviction_count              := le.bjl.eviction_count;
	bk_dismissed_recent_count        := le.bjl.bk_dismissed_recent_count;
	bk_dismissed_historical_count    := le.bjl.bk_dismissed_historical_count;
	liens_recent_unrel_count         := le.bjl.liens_recent_unreleased_count;
	liens_historical_unrel_count     := le.bjl.liens_historical_unreleased_count;
	liens_recent_rel_count           := le.bjl.liens_recent_released_count;
	liens_historical_rel_count       := le.bjl.liens_historical_released_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
	liens_unrel_fc_ct                := le.liens.liens_unreleased_foreclosure.count;
	liens_rel_fc_ct                  := le.liens.liens_released_foreclosure.count;
	liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
	liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_unrel_st_ct                := le.liens.liens_unreleased_suits.count;
	liens_rel_st_ct                  := le.liens.liens_released_suits.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
  
  
    /* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */
   NULL := -999999999;

  BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
  
ca_criminal_index := map(
    criminalfelonycount = NULL        => NULL,
    criminalfelonycount = -1          => -1,
    criminalfelonycount > 0           => 4,
    criminalnonfelonycount12month > 0 => 3,
    criminalnonfelonycount > 0        => 2,
                                         1);

ca_inputaddrmatchesprevious := map(
    addrinputmatchindex = NULL => NULL,
    addrinputmatchindex = -1   => -1,
    addrinputmatchindex = 1    => 1,
                                  0);

ca_eviction_index := map(
    evictioncount12month = NULL => NULL,
    evictioncount12month = -1   => -1,
    evictioncount12month > 0    => 3,
    evictioncount > 1           => 2,
    evictioncount = 1           => 1,
                                   0);

tot_liens := if(max(liens_historical_unrel_count, liens_recent_unrel_count, liens_recent_rel_count, liens_historical_rel_count) = NULL, NULL, sum(if(liens_historical_unrel_count = NULL, 0, liens_historical_unrel_count), if(liens_recent_unrel_count = NULL, 0, liens_recent_unrel_count), if(liens_recent_rel_count = NULL, 0, liens_recent_rel_count), if(liens_historical_rel_count = NULL, 0, liens_historical_rel_count)));

tot_liens_w_type := if(max(liens_unrel_LT_ct, liens_rel_LT_ct, liens_unrel_SC_ct, liens_rel_SC_ct, liens_unrel_CJ_ct, liens_rel_CJ_ct, liens_unrel_FT_ct, liens_rel_FT_ct, liens_unrel_OT_ct, liens_rel_OT_ct, liens_unrel_ST_ct, liens_rel_ST_ct, liens_unrel_FC_ct, liens_rel_FC_ct, liens_unrel_O_ct, liens_rel_O_ct) = NULL, NULL, sum(if(liens_unrel_LT_ct = NULL, 0, liens_unrel_LT_ct), if(liens_rel_LT_ct = NULL, 0, liens_rel_LT_ct), if(liens_unrel_SC_ct = NULL, 0, liens_unrel_SC_ct), if(liens_rel_SC_ct = NULL, 0, liens_rel_SC_ct), if(liens_unrel_CJ_ct = NULL, 0, liens_unrel_CJ_ct), if(liens_rel_CJ_ct = NULL, 0, liens_rel_CJ_ct), if(liens_unrel_FT_ct = NULL, 0, liens_unrel_FT_ct), if(liens_rel_FT_ct = NULL, 0, liens_rel_FT_ct), if(liens_unrel_OT_ct = NULL, 0, liens_unrel_OT_ct), if(liens_rel_OT_ct = NULL, 0, liens_rel_OT_ct), if(liens_unrel_ST_ct = NULL, 0, liens_unrel_ST_ct), if(liens_rel_ST_ct = NULL, 0, liens_rel_ST_ct), if(liens_unrel_FC_ct = NULL, 0, liens_unrel_FC_ct), if(liens_rel_FC_ct = NULL, 0, liens_rel_FC_ct), if(liens_unrel_O_ct = NULL, 0, liens_unrel_O_ct), if(liens_rel_O_ct = NULL, 0, liens_rel_O_ct)));

has_derog := if(felony_count > 0 or criminal_count > 0 or stl_inq_count24 > 0 or attr_eviction_count > 0 or liens_unrel_CJ_ct > 0 or liens_rel_CJ_ct > 0 or liens_unrel_SC_ct > 0 or liens_rel_SC_ct > 0 or liens_unrel_FC_ct > 0 or liens_rel_FC_ct > 0 or liens_unrel_O_ct > 0 or liens_rel_O_ct > 0 or tot_liens - tot_liens_w_type > 0 or bk_dismissed_recent_count > 0 or bk_dismissed_historical_count > 0, 1, 0);

segment_recreate := map(
    truedid = false                                     => 0,
    has_derog  > 0                                      => 2,
    add_input_naprop = 4 or property_owned_total > 0 => 3,
                                                        4);

derog_v01_w := map(
    bankruptcydismissed24month = NULL => 0,
    bankruptcydismissed24month = -1   => 0,
    bankruptcydismissed24month <= 0.5 => -0.233575949840379,
                                         0.273064234055051);

derog_aa_code_01_1 := map(
    bankruptcydismissed24month = NULL => '',
    bankruptcydismissed24month = -1   => 'C12',
    bankruptcydismissed24month <= 0.5 => '',
                                         'D31');

derog_aa_dist_01 := -0.233575949840379 - derog_v01_w;

derog_aa_code_01 := if(derog_aa_dist_01 = 0, '', derog_aa_code_01_1);

derog_v02_w := map(
    inquiryshortterm12month = NULL => 0,
    inquiryshortterm12month = -1   => 0,
    inquiryshortterm12month <= 0.5 => -0.168502438960338,
                                      0.175025478199652);

derog_aa_code_02_1 := map(
    inquiryshortterm12month = NULL => '',
    inquiryshortterm12month = -1   => 'C12',
    inquiryshortterm12month <= 0.5 => '',
                                      'I60');

derog_aa_dist_02 := -0.168502438960338 - derog_v02_w;

derog_aa_code_02 := if(derog_aa_dist_02 = 0, '', derog_aa_code_02_1);

derog_v03_w := map(
    criminalfelonytimenewest = NULL  => 0,
    criminalfelonytimenewest = -1    => -0.14901834014665,
    criminalfelonytimenewest <= 27.5 => 0.444194603954993,
                                        0.0478505975999433);

derog_aa_code_03_1 := map(
    criminalfelonytimenewest = NULL  => '',
    criminalfelonytimenewest = -1    => '',
    criminalfelonytimenewest <= 27.5 => 'D32',
                                        'D32');

derog_aa_dist_03 := 0.0478505975999433 - derog_v03_w;

derog_aa_code_03 := if(derog_aa_dist_03 = 0, '', derog_aa_code_03_1);

derog_v04_w := map(
    ca_eviction_index = NULL => 0,
    ca_eviction_index = -1   => 0,
    ca_eviction_index <= 0.5 => -0.136965667661503,
    ca_eviction_index <= 2.5 => 0.0643717847515387,
                                0.335711622254715);

derog_aa_code_04_1 := map(
    ca_eviction_index = NULL => '',
    ca_eviction_index = -1   => 'C12',
    ca_eviction_index <= 0.5 => '',
    ca_eviction_index <= 2.5 => 'D33',
                                'D33');

derog_aa_dist_04 := -0.136965667661503 - derog_v04_w;

derog_aa_code_04 := if(derog_aa_dist_04 = 0, '', derog_aa_code_04_1);

derog_v05_w := map(
    ca_inputaddrmatchesprevious = NULL => 0,
    ca_inputaddrmatchesprevious = -1   => 0,
    ca_inputaddrmatchesprevious <= 0.5 => -0.144552713583127,
                                          0.150892375489312);

derog_aa_code_05_1 := map(
    ca_inputaddrmatchesprevious = NULL => '',
    ca_inputaddrmatchesprevious = -1   => 'C12',
    ca_inputaddrmatchesprevious <= 0.5 => '',
                                          'F03');

derog_aa_dist_05 := -0.144552713583127 - derog_v05_w;

derog_aa_code_05 := if(derog_aa_dist_05 = 0, '', derog_aa_code_05_1);

derog_v06_w := map(
    addrprevioustimeoldest = NULL   => 0,
    addrprevioustimeoldest = -1     => 0,
    addrprevioustimeoldest <= 5.5   => 0.325241592822613,
    addrprevioustimeoldest <= 23.5  => 0.186467588844169,
    addrprevioustimeoldest <= 57.5  => 0.0219774807021137,
    addrprevioustimeoldest <= 197.5 => -0.111705552137057,
                                       -0.143651285956619);

derog_aa_code_06_1 := map(
    addrprevioustimeoldest = NULL   => '',
    addrprevioustimeoldest = -1     => 'C12',
    addrprevioustimeoldest <= 5.5   => 'C24',
    addrprevioustimeoldest <= 23.5  => 'C24',
    addrprevioustimeoldest <= 57.5  => 'C24',
    addrprevioustimeoldest <= 197.5 => 'C24',
                                       '');

derog_aa_dist_06 := -0.143651285956619 - derog_v06_w;

derog_aa_code_06 := if(derog_aa_dist_06 = 0, '', derog_aa_code_06_1);

derog_v07_w := map(
    assetpropevercount = NULL => 0,
    assetpropevercount = -1   => 0,
    assetpropevercount <= 0.5 => 0.140487217987626,
    assetpropevercount <= 1.5 => -0.0696844000961591,
                                 -0.189630208872811);

derog_aa_code_07_1 := map(
    assetpropevercount = NULL => '',
    assetpropevercount = -1   => 'C12',
    assetpropevercount <= 0.5 => 'A45',
    assetpropevercount <= 1.5 => 'A45',
                                 '');

derog_aa_dist_07 := -0.189630208872811 - derog_v07_w;

derog_aa_code_07 := if(derog_aa_dist_07 = 0, '', derog_aa_code_07_1);

derog_v08_w := map(
    subjectage = NULL  => 0,
    subjectage = -1    => -0.0267394275762709,
    subjectage <= 31.5 => 0.204474804681371,
    subjectage <= 42.5 => 0.0334156816707935,
                          -0.14070204156658);

derog_aa_code_08_1 := map(
    subjectage = NULL  => '',
    subjectage = -1    => 'C12',
    subjectage <= 31.5 => 'C27',
    subjectage <= 42.5 => 'C27',
                          '');

derog_aa_dist_08 := -0.14070204156658 - derog_v08_w;

derog_aa_code_08 := if(derog_aa_dist_08 = 0, '', derog_aa_code_08_1);

derog_v09_w := map(
    addronfilecount = NULL  => 0,
    addronfilecount = -1    => 0,
    addronfilecount <= 3.5  => -0.141088321136707,
    addronfilecount <= 7.5  => -0.0619786026876685,
    addronfilecount <= 15.5 => 0.0993320262695345,
                               0.361361900391319);

derog_aa_code_09_1 := map(
    addronfilecount = NULL  => '',
    addronfilecount = -1    => 'C12',
    addronfilecount <= 3.5  => '',
    addronfilecount <= 7.5  => 'C14',
    addronfilecount <= 15.5 => 'C14',
                               'C14');

derog_aa_dist_09 := -0.141088321136707 - derog_v09_w;

derog_aa_code_09 := if(derog_aa_dist_09 = 0, '', derog_aa_code_09_1);

derog_v10_w := map(
    inquirynonshortterm12month = NULL => 0,
    inquirynonshortterm12month = -1   => 0,
    inquirynonshortterm12month <= 0.5 => -0.1158518277953,
                                         0.118479691848571);

derog_aa_code_10_1 := map(
    inquirynonshortterm12month = NULL => '',
    inquirynonshortterm12month = -1   => 'C12',
    inquirynonshortterm12month <= 0.5 => '',
                                         'I60');

derog_aa_dist_10 := -0.1158518277953 - derog_v10_w;

derog_aa_code_10 := if(derog_aa_dist_10 = 0, '', derog_aa_code_10_1);

derog_v11_w := map(
    addrcurrentavmvalue = NULL     => 0,
    addrcurrentavmvalue = -1       => 0.0115790947401084,
    addrcurrentavmvalue <= 31011   => 0.297360389864029,
    addrcurrentavmvalue <= 68357.5 => 0.160502103462781,
    addrcurrentavmvalue <= 121999  => 0.0380589665340709,
    addrcurrentavmvalue <= 171377  => -0.0061970189479525,
                                      -0.152700103028899);

derog_aa_code_11_1 := map(
    addrcurrentavmvalue = NULL     => '',
    addrcurrentavmvalue = -1       => 'C12',
    addrcurrentavmvalue <= 31011   => 'A47',
    addrcurrentavmvalue <= 68357.5 => 'A47',
    addrcurrentavmvalue <= 121999  => 'A47',
    addrcurrentavmvalue <= 171377  => 'A47',
                                      '');

derog_aa_dist_11 := -0.152700103028899 - derog_v11_w;

derog_aa_code_11 := if(derog_aa_dist_11 = 0, '', derog_aa_code_11_1);

derog_v12_w := map(
    derogtimenewest = NULL  => 0,
    derogtimenewest = -1    => 0,
    derogtimenewest <= 4.5  => 0.160011633998967,
    derogtimenewest <= 19.5 => 0.0827317089208592,
    derogtimenewest <= 53.5 => -0.00805644917450333,
                               -0.160836259758556);

derog_aa_code_12_1 := map(
    derogtimenewest = NULL  => '',
    derogtimenewest = -1    => 'C12',
    derogtimenewest <= 4.5  => '',
    derogtimenewest <= 19.5 => '',
    derogtimenewest <= 53.5 => '',
                               '');

derog_aa_dist_12 := -0.160836259758556 - derog_v12_w;

derog_aa_code_12 := if(derog_aa_dist_12 = 0, '', derog_aa_code_12_1);

derog_v13_w := map(
    ca_criminal_index = NULL => 0,
    ca_criminal_index = -1   => 0,
    ca_criminal_index <= 1.5 => -0.102808305777568,
    ca_criminal_index <= 2.5 => 0.0538627960882078,
                                0.143751528195307);

derog_aa_code_13_1 := map(
    ca_criminal_index = NULL => '',
    ca_criminal_index = -1   => 'C12',
    ca_criminal_index <= 1.5 => '',
    ca_criminal_index <= 2.5 => 'D32',
                                'D32');

derog_aa_dist_13 := -0.102808305777568 - derog_v13_w;

derog_aa_code_13 := if(derog_aa_dist_13 = 0, '', derog_aa_code_13_1);

derog_v14_w := map(
    assetpersonal = NULL => 0,
    assetpersonal = -1   => 0,
    assetpersonal <= 0.5 => 0.107794774329743,
                            -0.0829527918169285);

derog_aa_code_14_1 := map(
    assetpersonal = NULL => '',
    assetpersonal = -1   => 'C12',
    assetpersonal <= 0.5 => 'A40',
                            '');

derog_aa_dist_14 := -0.0829527918169285 - derog_v14_w;

derog_aa_code_14 := if(derog_aa_dist_14 = 0, '', derog_aa_code_14_1);

derog_v15_w := map(
    inquirybanking12month = NULL => 0,
    inquirybanking12month = -1   => 0,
    inquirybanking12month <= 0.5 => -0.0926145008020997,
                                    0.0960999816215276);

derog_aa_code_15_1 := map(
    inquirybanking12month = NULL => '',
    inquirybanking12month = -1   => 'C12',
    inquirybanking12month <= 0.5 => '',
                                    'I60');

derog_aa_dist_15 := -0.0926145008020997 - derog_v15_w;

derog_aa_code_15 := if(derog_aa_dist_15 = 0, '', derog_aa_code_15_1);

derog_v16_w := map(
    sourcenonderogcount12month = NULL => 0,
    sourcenonderogcount12month = -1   => 0,
    sourcenonderogcount12month <= 1.5 => 0.0894677418986535,
    sourcenonderogcount12month <= 2.5 => -0.0558371639547254,
                                         -0.168302133300183);

derog_aa_code_16_1 := map(
    sourcenonderogcount12month = NULL => '',
    sourcenonderogcount12month = -1   => 'C12',
    sourcenonderogcount12month <= 1.5 => 'C12',
    sourcenonderogcount12month <= 2.5 => 'C12',
                                         '');

derog_aa_dist_16 := -0.168302133300183 - derog_v16_w;

derog_aa_code_16 := if(derog_aa_dist_16 = 0, '', derog_aa_code_16_1);

derog_v17_w := map(
    businessassociation = NULL => 0,
    businessassociation = -1   => 0,
    businessassociation <= 0.5 => 0.057842034077936,
                                  -0.0522333064343003);

derog_aa_code_17_1 := map(
    businessassociation = NULL => '',
    businessassociation = -1   => 'C12',
    businessassociation <= 0.5 => 'E57',
                                  '');

derog_aa_dist_17 := -0.0522333064343003 - derog_v17_w;

derog_aa_code_17 := if(derog_aa_dist_17 = 0, '', derog_aa_code_17_1);

derog_rcvalued31 := (integer)(derog_aa_code_01 = 'D31') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'D31') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'D31') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'D31') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'D31') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'D31') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'D31') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'D31') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'D31') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'D31') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'D31') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'D31') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'D31') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'D31') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'D31') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'D31') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'D31') * derog_aa_dist_17;

derog_rcvaluef03 := (integer)(derog_aa_code_01 = 'F03') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'F03') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'F03') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'F03') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'F03') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'F03') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'F03') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'F03') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'F03') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'F03') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'F03') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'F03') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'F03') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'F03') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'F03') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'F03') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'F03') * derog_aa_dist_17;

derog_rcvalued32 := (integer)(derog_aa_code_01 = 'D32') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'D32') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'D32') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'D32') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'D32') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'D32') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'D32') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'D32') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'D32') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'D32') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'D32') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'D32') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'D32') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'D32') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'D32') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'D32') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'D32') * derog_aa_dist_17;

derog_rcvaluec24 := (integer)(derog_aa_code_01 = 'C24') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'C24') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'C24') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'C24') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'C24') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'C24') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'C24') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'C24') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'C24') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'C24') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'C24') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'C24') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'C24') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'C24') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'C24') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'C24') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'C24') * derog_aa_dist_17;

derog_rcvaluea45 := (integer)(derog_aa_code_01 = 'A45') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'A45') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'A45') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'A45') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'A45') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'A45') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'A45') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'A45') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'A45') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'A45') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'A45') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'A45') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'A45') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'A45') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'A45') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'A45') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'A45') * derog_aa_dist_17;

derog_rcvaluec12 := (integer)(derog_aa_code_01 = 'C12') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'C12') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'C12') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'C12') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'C12') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'C12') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'C12') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'C12') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'C12') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'C12') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'C12') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'C12') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'C12') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'C12') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'C12') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'C12') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'C12') * derog_aa_dist_17;

derog_rcvaluea47 := (integer)(derog_aa_code_01 = 'A47') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'A47') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'A47') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'A47') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'A47') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'A47') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'A47') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'A47') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'A47') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'A47') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'A47') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'A47') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'A47') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'A47') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'A47') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'A47') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'A47') * derog_aa_dist_17;

derog_rcvaluei60 := (integer)(derog_aa_code_01 = 'I60') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'I60') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'I60') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'I60') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'I60') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'I60') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'I60') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'I60') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'I60') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'I60') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'I60') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'I60') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'I60') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'I60') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'I60') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'I60') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'I60') * derog_aa_dist_17;

derog_rcvaluee57 := (integer)(derog_aa_code_01 = 'E57') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'E57') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'E57') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'E57') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'E57') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'E57') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'E57') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'E57') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'E57') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'E57') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'E57') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'E57') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'E57') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'E57') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'E57') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'E57') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'E57') * derog_aa_dist_17;

derog_rcvaluea40 := (integer)(derog_aa_code_01 = 'A40') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'A40') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'A40') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'A40') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'A40') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'A40') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'A40') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'A40') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'A40') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'A40') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'A40') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'A40') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'A40') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'A40') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'A40') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'A40') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'A40') * derog_aa_dist_17;

derog_rcvaluec27 := (integer)(derog_aa_code_01 = 'C27') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'C27') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'C27') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'C27') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'C27') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'C27') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'C27') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'C27') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'C27') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'C27') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'C27') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'C27') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'C27') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'C27') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'C27') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'C27') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'C27') * derog_aa_dist_17;

derog_rcvaluec14 := (integer)(derog_aa_code_01 = 'C14') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'C14') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'C14') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'C14') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'C14') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'C14') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'C14') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'C14') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'C14') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'C14') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'C14') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'C14') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'C14') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'C14') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'C14') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'C14') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'C14') * derog_aa_dist_17;

derog_rcvalued33 := (integer)(derog_aa_code_01 = 'D33') * derog_aa_dist_01 +
    (integer)(derog_aa_code_02 = 'D33') * derog_aa_dist_02 +
    (integer)(derog_aa_code_03 = 'D33') * derog_aa_dist_03 +
    (integer)(derog_aa_code_04 = 'D33') * derog_aa_dist_04 +
    (integer)(derog_aa_code_05 = 'D33') * derog_aa_dist_05 +
    (integer)(derog_aa_code_06 = 'D33') * derog_aa_dist_06 +
    (integer)(derog_aa_code_07 = 'D33') * derog_aa_dist_07 +
    (integer)(derog_aa_code_08 = 'D33') * derog_aa_dist_08 +
    (integer)(derog_aa_code_09 = 'D33') * derog_aa_dist_09 +
    (integer)(derog_aa_code_10 = 'D33') * derog_aa_dist_10 +
    (integer)(derog_aa_code_11 = 'D33') * derog_aa_dist_11 +
    (integer)(derog_aa_code_12 = 'D33') * derog_aa_dist_12 +
    (integer)(derog_aa_code_13 = 'D33') * derog_aa_dist_13 +
    (integer)(derog_aa_code_14 = 'D33') * derog_aa_dist_14 +
    (integer)(derog_aa_code_15 = 'D33') * derog_aa_dist_15 +
    (integer)(derog_aa_code_16 = 'D33') * derog_aa_dist_16 +
    (integer)(derog_aa_code_17 = 'D33') * derog_aa_dist_17;

derog_lgt := -0.891753600775727 +
    derog_v01_w +
    derog_v02_w +
    derog_v03_w +
    derog_v04_w +
    derog_v05_w +
    derog_v06_w +
    derog_v07_w +
    derog_v08_w +
    derog_v09_w +
    derog_v10_w +
    derog_v11_w +
    derog_v12_w +
    derog_v13_w +
    derog_v14_w +
    derog_v15_w +
    derog_v16_w +
    derog_v17_w;

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_derog := DATASET([
    {'D31', derog_rcvalueD31},
    {'F03', derog_rcvalueF03},
    {'D32', derog_rcvalueD32},
    {'C24', derog_rcvalueC24},
    {'A45', derog_rcvalueA45},
    {'C12', derog_rcvalueC12},
    {'A47', derog_rcvalueA47},
    {'I60', derog_rcvalueI60},
    {'E57', derog_rcvalueE57},
    {'A40', derog_rcvalueA40},
    {'C27', derog_rcvalueC27},
    {'C14', derog_rcvalueC14},
    {'D33', derog_rcvalueD33}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_derog_sorted := sort(rc_dataset_derog, rc_dataset_derog.value);

r_derog_rc1 := rc_dataset_derog_sorted[1].rc;
r_derog_rc2 := rc_dataset_derog_sorted[2].rc;
r_derog_rc3 := rc_dataset_derog_sorted[3].rc;
r_derog_rc4 := rc_dataset_derog_sorted[4].rc;
r_derog_rc5 := rc_dataset_derog_sorted[5].rc;
r_derog_rc6 := rc_dataset_derog_sorted[6].rc;
r_derog_rc7 := rc_dataset_derog_sorted[7].rc;
r_derog_rc8 := rc_dataset_derog_sorted[8].rc;
r_derog_rc9 := rc_dataset_derog_sorted[9].rc;
r_derog_rc10 := rc_dataset_derog_sorted[10].rc;
r_derog_rc11 := rc_dataset_derog_sorted[11].rc;
r_derog_rc12 := rc_dataset_derog_sorted[12].rc;
r_derog_rc13 := rc_dataset_derog_sorted[13].rc;
r_derog_rc14 := rc_dataset_derog_sorted[14].rc;
r_derog_rc15 := rc_dataset_derog_sorted[15].rc;
r_derog_rc16 := rc_dataset_derog_sorted[16].rc;
r_derog_rc17 := rc_dataset_derog_sorted[17].rc;


r_derog_vl1 := rc_dataset_derog_sorted[1].value;
r_derog_vl2 := rc_dataset_derog_sorted[2].value;
r_derog_vl3 := rc_dataset_derog_sorted[3].value;
r_derog_vl4 := rc_dataset_derog_sorted[4].value;
r_derog_vl5 := rc_dataset_derog_sorted[5].value;
r_derog_vl6 := rc_dataset_derog_sorted[6].value;
r_derog_vl7 := rc_dataset_derog_sorted[7].value;
r_derog_vl8 := rc_dataset_derog_sorted[8].value;
r_derog_vl9 := rc_dataset_derog_sorted[9].value;
r_derog_vl10 := rc_dataset_derog_sorted[10].value;
r_derog_vl11 := rc_dataset_derog_sorted[11].value;
r_derog_vl12 := rc_dataset_derog_sorted[12].value;
r_derog_vl13 := rc_dataset_derog_sorted[13].value;
r_derog_vl14 := rc_dataset_derog_sorted[14].value;
r_derog_vl15 := rc_dataset_derog_sorted[15].value;
r_derog_vl16 := rc_dataset_derog_sorted[16].value;
r_derog_vl17 := rc_dataset_derog_sorted[17].value;
//*************************************************************************************//

derog_rc1_2 := r_derog_rc1;

derog_rc2_2 := r_derog_rc2;

derog_rc3_2 := r_derog_rc3;

derog_rc4_2 := r_derog_rc4;

_rc_inq_2 := if(r_derog_rc1 = 'I60' or r_derog_rc2 = 'I60' or r_derog_rc3 = 'I60' or r_derog_rc4 = 'I60' or r_derog_rc5 = 'I60' or r_derog_rc6 = 'I60' or r_derog_rc7 = 'I60' or r_derog_rc8 = 'I60' or r_derog_rc9 = 'I60' or r_derog_rc10 = 'I60' or r_derog_rc11 = 'I60' or r_derog_rc12 = 'I60' or r_derog_rc13 = 'I60' or r_derog_rc14 = 'I60' or r_derog_rc15 = 'I60' or r_derog_rc16 = 'I60' or r_derog_rc17 = 'I60', 'I60', '');

derog_rc3_c1413 := map(
    trim(derog_rc1_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc2_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc3_2, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(derog_rc4_2, LEFT, RIGHT) = '' => '',
                                           '');

derog_rc1_c1413 := map(
    trim(derog_rc1_2, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(derog_rc2_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc3_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc4_2, LEFT, RIGHT) = '' => '',
                                           '');

derog_rc2_c1413 := map(
    trim(derog_rc1_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc2_2, LEFT, RIGHT) = '' => _rc_inq_2,
    trim(derog_rc3_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc4_2, LEFT, RIGHT) = '' => '',
                                           '');

derog_rc5_c1413 := map(
    trim(derog_rc1_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc2_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc3_2, LEFT, RIGHT) = '' => '',
    trim(derog_rc4_2, LEFT, RIGHT) = '' => '',
                                           _rc_inq_2);

derog_rc1_1 := if(derog_rc1_c1413 != '' and not((derog_rc1_2 in ['I60', 'I61', 'I62'])) and not((derog_rc2_2 in ['I60', 'I61', 'I62'])) and not((derog_rc3_2 in ['I60', 'I61', 'I62'])) and not((derog_rc4_2 in ['I60', 'I61', 'I62'])), derog_rc1_c1413, derog_rc1_2);

derog_rc2_1 := if(derog_rc2_c1413 != '' and not((derog_rc1_2 in ['I60', 'I61', 'I62'])) and not((derog_rc2_2 in ['I60', 'I61', 'I62'])) and not((derog_rc3_2 in ['I60', 'I61', 'I62'])) and not((derog_rc4_2 in ['I60', 'I61', 'I62'])), derog_rc2_c1413, derog_rc2_2);

derog_rc3_1 := if(derog_rc3_c1413 != '' and not((derog_rc1_2 in ['I60', 'I61', 'I62'])) and not((derog_rc2_2 in ['I60', 'I61', 'I62'])) and not((derog_rc3_2 in ['I60', 'I61', 'I62'])) and not((derog_rc4_2 in ['I60', 'I61', 'I62'])), derog_rc3_c1413, derog_rc3_2);

derog_rc5 := if(derog_rc5_c1413 != '' and not((derog_rc1_2 in ['I60', 'I61', 'I62'])) and not((derog_rc2_2 in ['I60', 'I61', 'I62'])) and not((derog_rc3_2 in ['I60', 'I61', 'I62'])) and not((derog_rc4_2 in ['I60', 'I61', 'I62'])), derog_rc5_c1413, '');

derog_rc4 := derog_rc3_1;

derog_rc3 := derog_rc2_1;

derog_rc2 := derog_rc1_1;

derog_rc1 := if(derog_rc1_c1413 = '', 'D30', '');

iv_rv5_deceased_2 := rc_decsflag = 1 or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable_2 := if(truedid = false, 1, 0);

base_2 := 680;

pts_2 := -50;

derog_odds := 0.1403;

derog_score := map(
    iv_rv5_deceased_2   => 200,
    iv_rv5_unscorable_2 = 1 => 222,
                               min(if(max(round(pts_2 * (derog_lgt - ln(derog_odds)) / ln(2) + base_2), 501) = NULL, -NULL, max(round(pts_2 * (derog_lgt - ln(derog_odds)) / ln(2) + base_2), 501)), 900));
 
owner_v01_w := map(
    inquiryshortterm12month = NULL => 0,
    inquiryshortterm12month = -1   => 0,
    inquiryshortterm12month <= 0.5 => -0.340152147339584,
                                      0.342324982353597);

owner_aa_code_01_1 := map(
    inquiryshortterm12month = NULL => '',
    inquiryshortterm12month = -1   => 'C12',
    inquiryshortterm12month <= 0.5 => '',
                                      'I60');

owner_aa_dist_01 := -0.340152147339584 - owner_v01_w;

owner_aa_code_01 := if(owner_aa_dist_01 = 0, '', owner_aa_code_01_1);

owner_v02_w := map(
    inquirynonshortterm12month = NULL => 0,
    inquirynonshortterm12month = -1   => 0,
    inquirynonshortterm12month <= 0.5 => -0.183418370596378,
                                         0.183636128726838);

owner_aa_code_02_1 := map(
    inquirynonshortterm12month = NULL => '',
    inquirynonshortterm12month = -1   => 'C12',
    inquirynonshortterm12month <= 0.5 => '',
                                         'I60');

owner_aa_dist_02 := -0.183418370596378 - owner_v02_w;

owner_aa_code_02 := if(owner_aa_dist_02 = 0, '', owner_aa_code_02_1);

owner_v03_w := map(
    addrinputavmvalue = NULL      => 0,
    addrinputavmvalue = -1        => 0.088209018339767,
    addrinputavmvalue <= 23335    => 0.345174363397581,
    addrinputavmvalue <= 60443.5  => 0.26326704368824,
    addrinputavmvalue <= 100475   => 0.128971005249061,
    addrinputavmvalue <= 172651.5 => 0.0353563854192943,
    addrinputavmvalue <= 195543.5 => -0.142736478249252,
    addrinputavmvalue <= 355665.5 => -0.194197104253258,
                                     -0.257530479439671);

owner_aa_code_03_1 := map(
    addrinputavmvalue = NULL      => '',
    addrinputavmvalue = -1        => 'C12',
    addrinputavmvalue <= 23335    => 'L80',
    addrinputavmvalue <= 60443.5  => 'L80',
    addrinputavmvalue <= 100475   => 'L80',
    addrinputavmvalue <= 172651.5 => 'L80',
    addrinputavmvalue <= 195543.5 => 'L80',
    addrinputavmvalue <= 355665.5 => 'L80',
                                     '');

owner_aa_dist_03 := -0.257530479439671 - owner_v03_w;

owner_aa_code_03 := if(owner_aa_dist_03 = 0, '', owner_aa_code_03_1);

owner_v04_w := map(
    addrinputproblems = NULL => 0,
    addrinputproblems = -1   => 0,
    addrinputproblems <= 0.5 => -0.154425401437846,
                                0.178778851922773);

owner_aa_code_04_1 := map(
    addrinputproblems = NULL => '',
    addrinputproblems = -1   => 'C12',
    addrinputproblems <= 0.5 => '',
    addrinputproblems = 1    => 'L71',
    addrinputproblems = 2    => 'L70',
                                'L71');

owner_aa_dist_04 := -0.154425401437846 - owner_v04_w;

owner_aa_code_04 := if(owner_aa_dist_04 = 0, '', owner_aa_code_04_1);

owner_v05_w := map(
    assetproppurchasecount12month = NULL => 0,
    assetproppurchasecount12month = -1   => 0,
    assetproppurchasecount12month <= 0.5 => 0.152907865135979,
                                            -0.151950420958297);

owner_aa_code_05_1 := map(
    assetproppurchasecount12month = NULL => '',
    assetproppurchasecount12month = -1   => 'C12',
    assetproppurchasecount12month <= 0.5 => 'C12',
                                            '');

owner_aa_dist_05 := -0.151950420958297 - owner_v05_w;

owner_aa_code_05 := if(owner_aa_dist_05 = 0, '', owner_aa_code_05_1);

owner_v06_w := map(
    addrprevioustimeoldest = NULL   => 0,
    addrprevioustimeoldest = -1     => 0,
    addrprevioustimeoldest <= 8.5   => 0.417459691605549,
    addrprevioustimeoldest <= 23.5  => 0.287670750825057,
    addrprevioustimeoldest <= 45.5  => 0.0625724467565375,
    addrprevioustimeoldest <= 127.5 => -0.0133117377267449,
                                       -0.0840500761747636);

owner_aa_code_06_1 := map(
    addrprevioustimeoldest = NULL   => '',
    addrprevioustimeoldest = -1     => 'C12',
    addrprevioustimeoldest <= 8.5   => 'C24',
    addrprevioustimeoldest <= 23.5  => 'C24',
    addrprevioustimeoldest <= 45.5  => 'C24',
    addrprevioustimeoldest <= 127.5 => 'C24',
                                       '');

owner_aa_dist_06 := -0.0840500761747636 - owner_v06_w;

owner_aa_code_06 := if(owner_aa_dist_06 = 0, '', owner_aa_code_06_1);

owner_v07_w := map(
    inquirybanking12month = NULL => 0,
    inquirybanking12month = -1   => 0,
    inquirybanking12month <= 0.5 => -0.11909847353202,
                                    0.119778310262914);

owner_aa_code_07_1 := map(
    inquirybanking12month = NULL => '',
    inquirybanking12month = -1   => 'C12',
    inquirybanking12month <= 0.5 => '',
                                    'I60');

owner_aa_dist_07 := -0.11909847353202 - owner_v07_w;

owner_aa_code_07 := if(owner_aa_dist_07 = 0, '', owner_aa_code_07_1);

owner_v08_w := map(
    addronfilecount = NULL => 0,
    addronfilecount = -1   => 0,
    addronfilecount <= 4.5 => -0.117135501102045,
    addronfilecount <= 6.5 => 0.00603688448574838,
                              0.127565054948487);

owner_aa_code_08_1 := map(
    addronfilecount = NULL => '',
    addronfilecount = -1   => 'C12',
    addronfilecount <= 4.5 => '',
    addronfilecount <= 6.5 => 'C14',
                              'C14');

owner_aa_dist_08 := -0.117135501102045 - owner_v08_w;

owner_aa_code_08 := if(owner_aa_dist_08 = 0, '', owner_aa_code_08_1);

owner_v09_w := map(
    addrcurrentavmratio60monthprior = NULL   => 0,
    addrcurrentavmratio60monthprior = -1     => 0.0518952753151357,
    addrcurrentavmratio60monthprior <= 1.145 => 0.136884772081629,
    addrcurrentavmratio60monthprior <= 1.185 => -0.000642567782744574,
                                                -0.127470960873308);

owner_aa_code_09_1 := map(
    addrcurrentavmratio60monthprior = NULL   => '',
    addrcurrentavmratio60monthprior = -1     => 'C12',
    addrcurrentavmratio60monthprior < 1      => 'A49',
    addrcurrentavmratio60monthprior <= 1.185 => 'A47',
                                                '');

owner_aa_dist_09 := -0.127470960873308 - owner_v09_w;

owner_aa_code_09 := if(owner_aa_dist_09 = 0, '', owner_aa_code_09_1);

owner_v10_w := map(
    addrinputmatchindex = NULL => 0,
    addrinputmatchindex = -1   => 0,
    addrinputmatchindex <= 1.5 => 0.0972381571703908,
                                  -0.0947032365036009);

owner_aa_code_10_1 := map(
    addrinputmatchindex = NULL => '',
    addrinputmatchindex = -1   => 'C12',
    addrinputmatchindex <= 1.5 => 'F01',
                                  '');

owner_aa_dist_10 := -0.0947032365036009 - owner_v10_w;

owner_aa_code_10 := if(owner_aa_dist_10 = 0, '', owner_aa_code_10_1);

owner_v11_w := map(
    addrcurrentsubjectowned = NULL => 0,
    addrcurrentsubjectowned = -1   => 0,
    addrcurrentsubjectowned <= 0.5 => 0.14188232048926,
                                      -0.0399874417015612);

owner_aa_code_11_1 := map(
    addrcurrentsubjectowned = NULL => '',
    addrcurrentsubjectowned = -1   => 'C12',
    addrcurrentsubjectowned <= 0.5 => 'A44',
                                      '');

owner_aa_dist_11 := -0.0399874417015612 - owner_v11_w;

owner_aa_code_11 := if(owner_aa_dist_11 = 0, '', owner_aa_code_11_1);

owner_v12_w := map(
    assetpropcurrenttaxtotal = NULL      => 0,
    assetpropcurrenttaxtotal = -1        => 0.046157636157909,
    assetpropcurrenttaxtotal <= 9070     => 0.140937606976711,
    assetpropcurrenttaxtotal <= 132716   => 0.0206882988687749,
    assetpropcurrenttaxtotal <= 182703.5 => -0.0484324435241029,
                                            -0.11528917557099);

owner_aa_code_12_1 := map(
    assetpropcurrenttaxtotal = NULL      => '',
    assetpropcurrenttaxtotal = -1        => 'C12',
    assetpropcurrenttaxtotal <= 9070     => 'A47',
    assetpropcurrenttaxtotal <= 132716   => 'A47',
    assetpropcurrenttaxtotal <= 182703.5 => 'A47',
                                            '');

owner_aa_dist_12 := -0.11528917557099 - owner_v12_w;

owner_aa_code_12 := if(owner_aa_dist_12 = 0, '', owner_aa_code_12_1);

owner_v13_w := map(
    profliccount = NULL => 0,
    profliccount = -1   => 0,
    profliccount <= 0.5 => 0.0889875544853334,
                           -0.0866467964912809);

owner_aa_code_13_1 := map(
    profliccount = NULL => '',
    profliccount = -1   => 'C12',
    profliccount <= 0.5 => 'E57',
                           '');

owner_aa_dist_13 := -0.0866467964912809 - owner_v13_w;

owner_aa_code_13 := if(owner_aa_dist_13 = 0, '', owner_aa_code_13_1);

owner_v14_w := map(
    assetpropevercount = NULL => 0,
    assetpropevercount = -1   => 0,
    assetpropevercount <= 1.5 => 0.0683143627403424,
    assetpropevercount <= 3.5 => -0.013222578198195,
                                 -0.215971515079539);

owner_aa_code_14_1 := map(
    assetpropevercount = NULL => '',
    assetpropevercount = -1   => 'C12',
    assetpropevercount <= 1.5 => 'A45',
    assetpropevercount <= 3.5 => 'A45',
                                 '');

owner_aa_dist_14 := -0.215971515079539 - owner_v14_w;

owner_aa_code_14 := if(owner_aa_dist_14 = 0, '', owner_aa_code_14_1);

owner_rcvaluel80 := (integer)(owner_aa_code_01 = 'L80') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'L80') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'L80') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'L80') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'L80') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'L80') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'L80') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'L80') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'L80') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'L80') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'L80') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'L80') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'L80') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'L80') * owner_aa_dist_14;

owner_rcvaluec24 := (integer)(owner_aa_code_01 = 'C24') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'C24') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'C24') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'C24') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'C24') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'C24') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'C24') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'C24') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'C24') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'C24') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'C24') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'C24') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'C24') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'C24') * owner_aa_dist_14;

owner_rcvaluea45 := (integer)(owner_aa_code_01 = 'A45') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'A45') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'A45') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'A45') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'A45') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'A45') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'A45') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'A45') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'A45') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'A45') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'A45') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'A45') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'A45') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'A45') * owner_aa_dist_14;

owner_rcvaluec12 := (integer)(owner_aa_code_01 = 'C12') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'C12') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'C12') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'C12') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'C12') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'C12') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'C12') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'C12') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'C12') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'C12') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'C12') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'C12') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'C12') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'C12') * owner_aa_dist_14;

owner_rcvaluea47 := (integer)(owner_aa_code_01 = 'A47') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'A47') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'A47') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'A47') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'A47') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'A47') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'A47') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'A47') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'A47') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'A47') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'A47') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'A47') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'A47') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'A47') * owner_aa_dist_14;

owner_rcvaluef01 := (integer)(owner_aa_code_01 = 'F01') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'F01') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'F01') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'F01') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'F01') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'F01') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'F01') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'F01') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'F01') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'F01') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'F01') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'F01') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'F01') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'F01') * owner_aa_dist_14;

owner_rcvaluel71 := (integer)(owner_aa_code_01 = 'L71') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'L71') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'L71') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'L71') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'L71') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'L71') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'L71') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'L71') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'L71') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'L71') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'L71') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'L71') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'L71') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'L71') * owner_aa_dist_14;

owner_rcvaluei60 := (integer)(owner_aa_code_01 = 'I60') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'I60') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'I60') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'I60') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'I60') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'I60') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'I60') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'I60') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'I60') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'I60') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'I60') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'I60') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'I60') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'I60') * owner_aa_dist_14;

owner_rcvaluea49 := (integer)(owner_aa_code_01 = 'A49') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'A49') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'A49') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'A49') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'A49') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'A49') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'A49') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'A49') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'A49') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'A49') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'A49') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'A49') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'A49') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'A49') * owner_aa_dist_14;

owner_rcvaluel70 := (integer)(owner_aa_code_01 = 'L70') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'L70') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'L70') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'L70') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'L70') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'L70') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'L70') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'L70') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'L70') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'L70') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'L70') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'L70') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'L70') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'L70') * owner_aa_dist_14;

owner_rcvaluec14 := (integer)(owner_aa_code_01 = 'C14') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'C14') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'C14') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'C14') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'C14') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'C14') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'C14') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'C14') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'C14') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'C14') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'C14') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'C14') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'C14') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'C14') * owner_aa_dist_14;

owner_rcvaluea44 := (integer)(owner_aa_code_01 = 'A44') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'A44') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'A44') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'A44') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'A44') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'A44') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'A44') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'A44') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'A44') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'A44') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'A44') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'A44') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'A44') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'A44') * owner_aa_dist_14;

owner_rcvaluee57 := (integer)(owner_aa_code_01 = 'E57') * owner_aa_dist_01 +
    (integer)(owner_aa_code_02 = 'E57') * owner_aa_dist_02 +
    (integer)(owner_aa_code_03 = 'E57') * owner_aa_dist_03 +
    (integer)(owner_aa_code_04 = 'E57') * owner_aa_dist_04 +
    (integer)(owner_aa_code_05 = 'E57') * owner_aa_dist_05 +
    (integer)(owner_aa_code_06 = 'E57') * owner_aa_dist_06 +
    (integer)(owner_aa_code_07 = 'E57') * owner_aa_dist_07 +
    (integer)(owner_aa_code_08 = 'E57') * owner_aa_dist_08 +
    (integer)(owner_aa_code_09 = 'E57') * owner_aa_dist_09 +
    (integer)(owner_aa_code_10 = 'E57') * owner_aa_dist_10 +
    (integer)(owner_aa_code_11 = 'E57') * owner_aa_dist_11 +
    (integer)(owner_aa_code_12 = 'E57') * owner_aa_dist_12 +
    (integer)(owner_aa_code_13 = 'E57') * owner_aa_dist_13 +
    (integer)(owner_aa_code_14 = 'E57') * owner_aa_dist_14;

owner_lgt := -2.1437930230797 +
    owner_v01_w +
    owner_v02_w +
    owner_v03_w +
    owner_v04_w +
    owner_v05_w +
    owner_v06_w +
    owner_v07_w +
    owner_v08_w +
    owner_v09_w +
    owner_v10_w +
    owner_v11_w +
    owner_v12_w +
    owner_v13_w +
    owner_v14_w;

//*************************************************************************************//
rc_dataset_owner := DATASET([
    {'L80', owner_rcvalueL80},
    {'C24', owner_rcvalueC24},
    {'A45', owner_rcvalueA45},
    {'C12', owner_rcvalueC12},
    {'A47', owner_rcvalueA47},
    {'F01', owner_rcvalueF01},
    {'L71', owner_rcvalueL71},
    {'I60', owner_rcvalueI60},
    {'A49', owner_rcvalueA49},
    {'L70', owner_rcvalueL70},
    {'C14', owner_rcvalueC14},
    {'A44', owner_rcvalueA44},
    {'E57', owner_rcvalueE57}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_owner_sorted := sort(rc_dataset_owner, rc_dataset_owner.value);

r_owner_rc1 := rc_dataset_owner_sorted[1].rc;
r_owner_rc2 := rc_dataset_owner_sorted[2].rc;
r_owner_rc3 := rc_dataset_owner_sorted[3].rc;
r_owner_rc4 := rc_dataset_owner_sorted[4].rc;
r_owner_rc5 := rc_dataset_owner_sorted[5].rc;
r_owner_rc6 := rc_dataset_owner_sorted[6].rc;
r_owner_rc7 := rc_dataset_owner_sorted[7].rc;
r_owner_rc8 := rc_dataset_owner_sorted[8].rc;
r_owner_rc9 := rc_dataset_owner_sorted[9].rc;
r_owner_rc10 := rc_dataset_owner_sorted[10].rc;
r_owner_rc11 := rc_dataset_owner_sorted[11].rc;
r_owner_rc12 := rc_dataset_owner_sorted[12].rc;
r_owner_rc13 := rc_dataset_owner_sorted[13].rc;
r_owner_rc14 := rc_dataset_owner_sorted[14].rc;


r_owner_vl1 := rc_dataset_owner_sorted[1].value;
r_owner_vl2 := rc_dataset_owner_sorted[2].value;
r_owner_vl3 := rc_dataset_owner_sorted[3].value;
r_owner_vl4 := rc_dataset_owner_sorted[4].value;
r_owner_vl5 := rc_dataset_owner_sorted[5].value;
r_owner_vl6 := rc_dataset_owner_sorted[6].value;
r_owner_vl7 := rc_dataset_owner_sorted[7].value;
r_owner_vl8 := rc_dataset_owner_sorted[8].value;
r_owner_vl9 := rc_dataset_owner_sorted[9].value;
r_owner_vl10 := rc_dataset_owner_sorted[10].value;
r_owner_vl11 := rc_dataset_owner_sorted[11].value;
r_owner_vl12 := rc_dataset_owner_sorted[12].value;
r_owner_vl13 := rc_dataset_owner_sorted[13].value;
r_owner_vl14 := rc_dataset_owner_sorted[14].value;
//*************************************************************************************//

owner_rc1_1 := r_owner_rc1;

owner_rc2_1 := r_owner_rc2;

owner_rc3_1 := r_owner_rc3;

owner_rc4_1 := r_owner_rc4;

_rc_inq_1 := if(r_owner_rc1 = 'I60' or r_owner_rc2 = 'I60' or r_owner_rc3 = 'I60' or r_owner_rc4 = 'I60' or r_owner_rc5 = 'I60' or r_owner_rc6 = 'I60' or r_owner_rc7 = 'I60' or r_owner_rc8 = 'I60' or r_owner_rc9 = 'I60' or r_owner_rc10 = 'I60' or r_owner_rc11 = 'I60' or r_owner_rc12 = 'I60' or r_owner_rc13 = 'I60' or r_owner_rc14 = 'I60', 'I60', '');

owner_rc5_c1461 := map(
    trim(owner_rc1_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc2_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc3_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc4_1, LEFT, RIGHT) = '' => '',
                                           _rc_inq_1);

owner_rc4_c1461 := map(
    trim(owner_rc1_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc2_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc3_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc4_1, LEFT, RIGHT) = '' => _rc_inq_1,
                                           '');

owner_rc2_c1461 := map(
    trim(owner_rc1_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc2_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(owner_rc3_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');

owner_rc1_c1461 := map(
    trim(owner_rc1_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(owner_rc2_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc3_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');

owner_rc3_c1461 := map(
    trim(owner_rc1_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc2_1, LEFT, RIGHT) = '' => '',
    trim(owner_rc3_1, LEFT, RIGHT) = '' => _rc_inq_1,
    trim(owner_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');


owner_rc5 := if(not((owner_rc1_1 in ['I60', 'I61', 'I62'])) and not((owner_rc2_1 in ['I60', 'I61', 'I62'])) and not((owner_rc3_1 in ['I60', 'I61', 'I62'])) and not((owner_rc4_1 in ['I60', 'I61', 'I62'])), owner_rc5_c1461, '');

owner_rc4 := if(owner_rc4_c1461 != '' and owner_rc1_1 not in ['I60', 'I61', 'I62'] and owner_rc2_1 not in ['I60', 'I61', 'I62'] and owner_rc3_1 not in ['I60', 'I61', 'I62'] and owner_rc4_1 not in ['I60', 'I61', 'I62'], owner_rc4_c1461, owner_rc4_1);

owner_rc1 := if(owner_rc1_c1461 != '' and not((owner_rc1_1 in ['I60', 'I61', 'I62'])) and not((owner_rc2_1 in ['I60', 'I61', 'I62'])) and not((owner_rc3_1 in ['I60', 'I61', 'I62'])) and not((owner_rc4_1 in ['I60', 'I61', 'I62'])), owner_rc1_c1461, owner_rc1_1);

owner_rc2 := if(owner_rc2_c1461 != '' and not((owner_rc1_1 in ['I60', 'I61', 'I62'])) and not((owner_rc2_1 in ['I60', 'I61', 'I62'])) and not((owner_rc3_1 in ['I60', 'I61', 'I62'])) and not((owner_rc4_1 in ['I60', 'I61', 'I62'])), owner_rc2_c1461, owner_rc2_1);

owner_rc3 := if(owner_rc3_c1461 != '' and not((owner_rc1_1 in ['I60', 'I61', 'I62'])) and not((owner_rc2_1 in ['I60', 'I61', 'I62'])) and not((owner_rc3_1 in ['I60', 'I61', 'I62'])) and not((owner_rc4_1 in ['I60', 'I61', 'I62'])), owner_rc3_c1461, owner_rc3_1);

iv_rv5_deceased_1 := rc_decsflag = 1 or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable_1 := if(truedid = false, 1, 0);

base_1 := 680;

pts_1 := -50;

owner_odds := 0.1403;

owner_score := map(
    iv_rv5_deceased_1   => 200,
    iv_rv5_unscorable_1 = 1 => 222,
                               min(if(max(round(pts_1 * (owner_lgt - ln(owner_odds)) / ln(2) + base_1), 501) = NULL, -NULL, max(round(pts_1 * (owner_lgt - ln(owner_odds)) / ln(2) + base_1), 501)), 900));

other_v01_w := map(
    inquiryshortterm12month = NULL => 0,
    inquiryshortterm12month = -1   => 0,
    inquiryshortterm12month <= 0.5 => -0.260593413873094,
                                      0.240417881077901);

other_aa_code_01_1 := map(
    inquiryshortterm12month = NULL => '',
    inquiryshortterm12month = -1   => 'C12',
    inquiryshortterm12month <= 0.5 => '',
                                      'I60');

other_aa_dist_01 := -0.260593413873094 - other_v01_w;

other_aa_code_01 := if(other_aa_dist_01 = 0, '', other_aa_code_01_1);

other_v02_w := map(
    addrinputproblems = NULL => 0,
    addrinputproblems = -1   => 0,
    addrinputproblems <= 1.5 => -0.227230387085267,
                                0.190451899992623);

other_aa_code_02_1 := map(
    addrinputproblems = NULL => '',
    addrinputproblems = -1   => 'C12',
    addrinputproblems <= 1.5 => '',
    addrinputproblems = 2    => 'L70',
                                'L71');

other_aa_dist_02 := -0.227230387085267 - other_v02_w;

other_aa_code_02 := if(other_aa_dist_02 = 0, '', other_aa_code_02_1);

other_v03_w := map(
    subjectage = NULL  => 0,
    subjectage = -1    => 0,
    subjectage <= 22.5 => 0.468259309395299,
    subjectage <= 34.5 => 0.316757647071948,
    subjectage <= 44.5 => 0.121414296974054,
                          -0.0338398702256288);

other_aa_code_03_1 := map(
    subjectage = NULL  => '',
    subjectage = -1    => 'C12',
    subjectage <= 22.5 => 'C27',
    subjectage <= 34.5 => 'C27',
    subjectage <= 44.5 => 'C27',
                          '');

other_aa_dist_03 := -0.0338398702256288 - other_v03_w;

other_aa_code_03 := if(other_aa_dist_03 = 0, '', other_aa_code_03_1);

other_v04_w := map(
    ca_inputaddrmatchesprevious = NULL => 0,
    ca_inputaddrmatchesprevious = -1   => 0,
    ca_inputaddrmatchesprevious <= 0.5 => -0.212168844562017,
                                          0.201895190018225);

other_aa_code_04_1 := map(
    ca_inputaddrmatchesprevious = NULL => '',
    ca_inputaddrmatchesprevious = -1   => 'C12',
    ca_inputaddrmatchesprevious <= 0.5 => '',
                                          'F03');

other_aa_dist_04 := -0.212168844562017 - other_v04_w;

other_aa_code_04 := if(other_aa_dist_04 = 0, '', other_aa_code_04_1);

other_v05_w := map(
    inquiryauto12month = NULL => 0,
    inquiryauto12month = -1   => 0,
    inquiryauto12month <= 0.5 => -0.150113451388937,
                                 0.141482718875509);

other_aa_code_05_1 := map(
    inquiryauto12month = NULL => '',
    inquiryauto12month = -1   => 'C12',
    inquiryauto12month <= 0.5 => '',
                                 'I60');

other_aa_dist_05 := -0.150113451388937 - other_v05_w;

other_aa_code_05 := if(other_aa_dist_05 = 0, '', other_aa_code_05_1);

other_v06_w := map(
    inquirybanking12month = NULL => 0,
    inquirybanking12month = -1   => 0,
    inquirybanking12month <= 0.5 => -0.147394055318278,
                                    0.135195144246576);

other_aa_code_06_1 := map(
    inquirybanking12month = NULL => '',
    inquirybanking12month = -1   => 'C12',
    inquirybanking12month <= 0.5 => '',
                                    'I60');

other_aa_dist_06 := -0.147394055318278 - other_v06_w;

other_aa_code_06 := if(other_aa_dist_06 = 0, '', other_aa_code_06_1);

other_v07_w := map(
    inquirytelcom12month = NULL => 0,
    inquirytelcom12month = -1   => 0,
    inquirytelcom12month <= 0.5 => -0.145823743594324,
                                   0.128650320470616);

other_aa_code_07_1 := map(
    inquirytelcom12month = NULL => '',
    inquirytelcom12month = -1   => 'C12',
    inquirytelcom12month <= 0.5 => '',
                                   'I60');

other_aa_dist_07 := -0.145823743594324 - other_v07_w;

other_aa_code_07 := if(other_aa_dist_07 = 0, '', other_aa_code_07_1);

other_v08_w := map(
    addronfilecount = NULL => 0,
    addronfilecount = -1   => 0,
    addronfilecount <= 1.5 => -0.151853896817072,
    addronfilecount <= 2.5 => -0.102872735362863,
    addronfilecount <= 4.5 => -0.00966417183233539,
    addronfilecount <= 6.5 => 0.0684013996729407,
    addronfilecount <= 9.5 => 0.116169955718138,
                              0.25782027870252);

other_aa_code_08_1 := map(
    addronfilecount = NULL => '',
    addronfilecount = -1   => 'C12',
    addronfilecount <= 1.5 => '',
    addronfilecount <= 2.5 => 'C14',
    addronfilecount <= 4.5 => 'C14',
    addronfilecount <= 6.5 => 'C14',
    addronfilecount <= 9.5 => 'C14',
                              'C14');

other_aa_dist_08 := -0.151853896817072 - other_v08_w;

other_aa_code_08 := if(other_aa_dist_08 = 0, '', other_aa_code_08_1);

other_v09_w := map(
    addrinputavmvalue12month = NULL      => 0,
    addrinputavmvalue12month = -1        => 0.00191985876519125,
    addrinputavmvalue12month <= 53135.5  => 0.268204815917234,
    addrinputavmvalue12month <= 74165    => 0.164188200991363,
    addrinputavmvalue12month <= 110988   => 0.0287081742494587,
    addrinputavmvalue12month <= 267990.5 => -0.0408638160749186,
                                            -0.16074715875802);

other_aa_code_09_1 := map(
    addrinputavmvalue12month = NULL      => '',
    addrinputavmvalue12month = -1        => 'C12',
    addrinputavmvalue12month <= 53135.5  => 'L80',
    addrinputavmvalue12month <= 74165    => 'L80',
    addrinputavmvalue12month <= 110988   => 'L80',
    addrinputavmvalue12month <= 267990.5 => 'L80',
                                            '');

other_aa_dist_09 := -0.16074715875802 - other_v09_w;

other_aa_code_09 := if(other_aa_dist_09 = 0, '', other_aa_code_09_1);

other_v10_w := map(
    profliccount = NULL => 0,
    profliccount = -1   => 0,
    profliccount <= 0   => 0.0888253669207023,
                           -0.18786939358981);

other_aa_code_10_1 := map(
    profliccount = NULL => '',
    profliccount = -1   => 'C12',
    profliccount <= 0   => 'E57',
                           '');

other_aa_dist_10 := -0.18786939358981 - other_v10_w;

other_aa_code_10 := if(other_aa_dist_10 = 0, '', other_aa_code_10_1);

other_v11_w := map(
    addrcurrentavmvalue = NULL      => 0,
    addrcurrentavmvalue = -1        => -0.00533471709484115,
    addrcurrentavmvalue <= 50223.5  => 0.248346145095894,
    addrcurrentavmvalue <= 87023    => 0.0738832813503374,
    addrcurrentavmvalue <= 201360.5 => 0.0302867419762546,
    addrcurrentavmvalue <= 351825.5 => -0.0495642116755143,
    addrcurrentavmvalue <= 506720   => -0.107099579325458,
                                       -0.242874309381563);

other_aa_code_11_1 := map(
    addrcurrentavmvalue = NULL      => '',
    addrcurrentavmvalue = -1        => 'C12',
    addrcurrentavmvalue <= 50223.5  => 'A47',
    addrcurrentavmvalue <= 87023    => 'A47',
    addrcurrentavmvalue <= 201360.5 => 'A47',
    addrcurrentavmvalue <= 351825.5 => 'A47',
    addrcurrentavmvalue <= 506720   => 'A47',
                                       '');

other_aa_dist_11 := -0.242874309381563 - other_v11_w;

other_aa_code_11 := if(other_aa_dist_11 = 0, '', other_aa_code_11_1);

other_v12_w := map(
    addrprevioustimeoldest = NULL  => 0,
    addrprevioustimeoldest = -1    => 0.0190089918285418,
    addrprevioustimeoldest <= 3.5  => 0.273841090249569,
    addrprevioustimeoldest <= 13.5 => 0.0887889593848838,
    addrprevioustimeoldest <= 34.5 => 0.0286842377731982,
    addrprevioustimeoldest <= 73.5 => -0.0332595478848044,
                                      -0.0848367578932029);

other_aa_code_12_1 := map(
    addrprevioustimeoldest = NULL  => '',
    addrprevioustimeoldest = -1    => 'C12',
    addrprevioustimeoldest <= 3.5  => 'C24',
    addrprevioustimeoldest <= 13.5 => 'C24',
    addrprevioustimeoldest <= 34.5 => 'C24',
    addrprevioustimeoldest <= 73.5 => 'C24',
                                      '');

other_aa_dist_12 := -0.0848367578932029 - other_v12_w;

other_aa_code_12 := if(other_aa_dist_12 = 0, '', other_aa_code_12_1);

other_v13_w := map(
    addrinputlengthofres = NULL  => 0,
    addrinputlengthofres = -1    => -0.00613628914202087,
    addrinputlengthofres <= 2.5  => 0.194937384911309,
    addrinputlengthofres <= 28.5 => 0.038587541473836,
    addrinputlengthofres <= 46.5 => -0.0153624164383805,
    addrinputlengthofres <= 83.5 => -0.0618832579904968,
                                    -0.101247230510884);

other_aa_code_13_1 := map(
    addrinputlengthofres = NULL  => '',
    addrinputlengthofres = -1    => 'C12',
    addrinputlengthofres <= 2.5  => 'C13',
    addrinputlengthofres <= 28.5 => 'C13',
    addrinputlengthofres <= 46.5 => 'C13',
    addrinputlengthofres <= 83.5 => 'C13',
                                    '');

other_aa_dist_13 := -0.101247230510884 - other_v13_w;

other_aa_code_13 := if(other_aa_dist_13 = 0, '', other_aa_code_13_1);

other_v14_w := map(
    businessassociation = NULL => 0,
    businessassociation = -1   => 0,
    businessassociation <= 0.5 => 0.0664010212871832,
                                  -0.0871536177008683);

other_aa_code_14_1 := map(
    businessassociation = NULL => '',
    businessassociation = -1   => 'C12',
    businessassociation <= 0.5 => 'E57',
                                  '');

other_aa_dist_14 := -0.0871536177008683 - other_v14_w;

other_aa_code_14 := if(other_aa_dist_14 = 0, '', other_aa_code_14_1);

other_rcvaluef03 := (integer)(other_aa_code_01 = 'F03') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'F03') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'F03') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'F03') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'F03') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'F03') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'F03') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'F03') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'F03') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'F03') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'F03') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'F03') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'F03') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'F03') * other_aa_dist_14;

other_rcvaluel80 := (integer)(other_aa_code_01 = 'L80') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'L80') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'L80') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'L80') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'L80') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'L80') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'L80') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'L80') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'L80') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'L80') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'L80') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'L80') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'L80') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'L80') * other_aa_dist_14;

other_rcvaluec13 := (integer)(other_aa_code_01 = 'C13') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'C13') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'C13') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'C13') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'C13') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'C13') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'C13') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'C13') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'C13') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'C13') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'C13') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'C13') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'C13') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'C13') * other_aa_dist_14;

other_rcvaluec24 := (integer)(other_aa_code_01 = 'C24') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'C24') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'C24') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'C24') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'C24') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'C24') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'C24') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'C24') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'C24') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'C24') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'C24') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'C24') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'C24') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'C24') * other_aa_dist_14;

other_rcvaluec12 := (integer)(other_aa_code_01 = 'C12') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'C12') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'C12') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'C12') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'C12') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'C12') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'C12') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'C12') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'C12') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'C12') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'C12') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'C12') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'C12') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'C12') * other_aa_dist_14;

other_rcvaluea47 := (integer)(other_aa_code_01 = 'A47') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'A47') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'A47') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'A47') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'A47') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'A47') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'A47') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'A47') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'A47') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'A47') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'A47') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'A47') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'A47') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'A47') * other_aa_dist_14;

other_rcvaluel71 := (integer)(other_aa_code_01 = 'L71') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'L71') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'L71') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'L71') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'L71') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'L71') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'L71') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'L71') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'L71') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'L71') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'L71') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'L71') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'L71') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'L71') * other_aa_dist_14;

other_rcvaluei60 := (integer)(other_aa_code_01 = 'I60') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'I60') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'I60') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'I60') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'I60') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'I60') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'I60') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'I60') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'I60') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'I60') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'I60') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'I60') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'I60') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'I60') * other_aa_dist_14;

other_rcvaluel70 := (integer)(other_aa_code_01 = 'L70') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'L70') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'L70') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'L70') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'L70') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'L70') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'L70') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'L70') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'L70') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'L70') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'L70') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'L70') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'L70') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'L70') * other_aa_dist_14;

other_rcvaluec27 := (integer)(other_aa_code_01 = 'C27') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'C27') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'C27') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'C27') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'C27') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'C27') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'C27') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'C27') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'C27') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'C27') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'C27') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'C27') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'C27') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'C27') * other_aa_dist_14;

other_rcvaluec14 := (integer)(other_aa_code_01 = 'C14') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'C14') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'C14') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'C14') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'C14') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'C14') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'C14') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'C14') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'C14') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'C14') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'C14') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'C14') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'C14') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'C14') * other_aa_dist_14;

other_rcvaluee57 := (integer)(other_aa_code_01 = 'E57') * other_aa_dist_01 +
    (integer)(other_aa_code_02 = 'E57') * other_aa_dist_02 +
    (integer)(other_aa_code_03 = 'E57') * other_aa_dist_03 +
    (integer)(other_aa_code_04 = 'E57') * other_aa_dist_04 +
    (integer)(other_aa_code_05 = 'E57') * other_aa_dist_05 +
    (integer)(other_aa_code_06 = 'E57') * other_aa_dist_06 +
    (integer)(other_aa_code_07 = 'E57') * other_aa_dist_07 +
    (integer)(other_aa_code_08 = 'E57') * other_aa_dist_08 +
    (integer)(other_aa_code_09 = 'E57') * other_aa_dist_09 +
    (integer)(other_aa_code_10 = 'E57') * other_aa_dist_10 +
    (integer)(other_aa_code_11 = 'E57') * other_aa_dist_11 +
    (integer)(other_aa_code_12 = 'E57') * other_aa_dist_12 +
    (integer)(other_aa_code_13 = 'E57') * other_aa_dist_13 +
    (integer)(other_aa_code_14 = 'E57') * other_aa_dist_14;

other_lgt := -1.37899560087086 +
    other_v01_w +
    other_v02_w +
    other_v03_w +
    other_v04_w +
    other_v05_w +
    other_v06_w +
    other_v07_w +
    other_v08_w +
    other_v09_w +
    other_v10_w +
    other_v11_w +
    other_v12_w +
    other_v13_w +
    other_v14_w;

//*************************************************************************************//
rc_dataset_other := DATASET([
    {'F03', other_rcvalueF03},
    {'L80', other_rcvalueL80},
    {'C13', other_rcvalueC13},
    {'C24', other_rcvalueC24},
    {'C12', other_rcvalueC12},
    {'A47', other_rcvalueA47},
    {'L71', other_rcvalueL71},
    {'I60', other_rcvalueI60},
    {'L70', other_rcvalueL70},
    {'C27', other_rcvalueC27},
    {'C14', other_rcvalueC14},
    {'E57', other_rcvalueE57}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_other_sorted := sort(rc_dataset_other, rc_dataset_other.value);

r_other_rc1 := rc_dataset_other_sorted[1].rc;
r_other_rc2 := rc_dataset_other_sorted[2].rc;
r_other_rc3 := rc_dataset_other_sorted[3].rc;
r_other_rc4 := rc_dataset_other_sorted[4].rc;
r_other_rc5 := rc_dataset_other_sorted[5].rc;
r_other_rc6 := rc_dataset_other_sorted[6].rc;
r_other_rc7 := rc_dataset_other_sorted[7].rc;
r_other_rc8 := rc_dataset_other_sorted[8].rc;
r_other_rc9 := rc_dataset_other_sorted[9].rc;
r_other_rc10 := rc_dataset_other_sorted[10].rc;
r_other_rc11 := rc_dataset_other_sorted[11].rc;
r_other_rc12 := rc_dataset_other_sorted[12].rc;
r_other_rc13 := rc_dataset_other_sorted[13].rc;
r_other_rc14 := rc_dataset_other_sorted[14].rc;


r_other_vl1 := rc_dataset_other_sorted[1].value;
r_other_vl2 := rc_dataset_other_sorted[2].value;
r_other_vl3 := rc_dataset_other_sorted[3].value;
r_other_vl4 := rc_dataset_other_sorted[4].value;
r_other_vl5 := rc_dataset_other_sorted[5].value;
r_other_vl6 := rc_dataset_other_sorted[6].value;
r_other_vl7 := rc_dataset_other_sorted[7].value;
r_other_vl8 := rc_dataset_other_sorted[8].value;
r_other_vl9 := rc_dataset_other_sorted[9].value;
r_other_vl10 := rc_dataset_other_sorted[10].value;
r_other_vl11 := rc_dataset_other_sorted[11].value;
r_other_vl12 := rc_dataset_other_sorted[12].value;
r_other_vl13 := rc_dataset_other_sorted[13].value;
r_other_vl14 := rc_dataset_other_sorted[14].value;
//*************************************************************************************//

other_rc1_2 := r_other_rc1;

other_rc2_1 := r_other_rc2;

other_rc3_1 := r_other_rc3;

other_rc4_1 := r_other_rc4;

_rc_inq := if(r_other_rc1 = 'I60' or r_other_rc2 = 'I60' or r_other_rc3 = 'I60' or r_other_rc4 = 'I60' or r_other_rc5 = 'I60' or r_other_rc6 = 'I60' or r_other_rc7 = 'I60' or r_other_rc8 = 'I60' or r_other_rc9 = 'I60' or r_other_rc10 = 'I60' or r_other_rc11 = 'I60' or r_other_rc12 = 'I60' or r_other_rc13 = 'I60' or r_other_rc14 = 'I60', 'I60', '');

other_rc3_c1509 := map(
    trim(other_rc1_2, LEFT, RIGHT) = '' => '',
    trim(other_rc2_1, LEFT, RIGHT) = '' => '',
    trim(other_rc3_1, LEFT, RIGHT) = '' => _rc_inq,
    trim(other_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');

other_rc5_c1509 := map(
    trim(other_rc1_2, LEFT, RIGHT) = '' => '',
    trim(other_rc2_1, LEFT, RIGHT) = '' => '',
    trim(other_rc3_1, LEFT, RIGHT) = '' => '',
    trim(other_rc4_1, LEFT, RIGHT) = '' => '',
                                           _rc_inq);

other_rc1_c1509 := map(
    trim(other_rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(other_rc2_1, LEFT, RIGHT) = '' => '',
    trim(other_rc3_1, LEFT, RIGHT) = '' => '',
    trim(other_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');

other_rc4_c1509 := map(
    trim(other_rc1_2, LEFT, RIGHT) = '' => '',
    trim(other_rc2_1, LEFT, RIGHT) = '' => '',
    trim(other_rc3_1, LEFT, RIGHT) = '' => '',
    trim(other_rc4_1, LEFT, RIGHT) = '' => _rc_inq,
                                           '');

other_rc2_c1509 := map(
    trim(other_rc1_2, LEFT, RIGHT) = '' => '',
    trim(other_rc2_1, LEFT, RIGHT) = '' => _rc_inq,
    trim(other_rc3_1, LEFT, RIGHT) = '' => '',
    trim(other_rc4_1, LEFT, RIGHT) = '' => '',
                                           '');

other_rc4 := if(other_rc4_c1509 != '' and not((other_rc1_2 in ['I60', 'I61', 'I62'])) and not((other_rc2_1 in ['I60', 'I61', 'I62'])) and not((other_rc3_1 in ['I60', 'I61', 'I62'])) and not((other_rc4_1 in ['I60', 'I61', 'I62'])), other_rc4_c1509, other_rc4_1);

other_rc2 := if(other_rc2_c1509 != '' and not((other_rc1_2 in ['I60', 'I61', 'I62'])) and not((other_rc2_1 in ['I60', 'I61', 'I62'])) and not((other_rc3_1 in ['I60', 'I61', 'I62'])) and not((other_rc4_1 in ['I60', 'I61', 'I62'])), other_rc2_c1509, other_rc2_1);

other_rc5 := if(other_rc5_c1509 != '' and not((other_rc1_2 in ['I60', 'I61', 'I62'])) and not((other_rc2_1 in ['I60', 'I61', 'I62'])) and not((other_rc3_1 in ['I60', 'I61', 'I62'])) and not((other_rc4_1 in ['I60', 'I61', 'I62'])), other_rc5_c1509, '');

other_rc1_1 := if(other_rc1_c1509 != '' and not((other_rc1_2 in ['I60', 'I61', 'I62'])) and not((other_rc2_1 in ['I60', 'I61', 'I62'])) and not((other_rc3_1 in ['I60', 'I61', 'I62'])) and not((other_rc4_1 in ['I60', 'I61', 'I62'])), other_rc1_c1509, other_rc1_2);

other_rc3 := if(other_rc3_c1509 != '' and not((other_rc1_2 in ['I60', 'I61', 'I62'])) and not((other_rc2_1 in ['I60', 'I61', 'I62'])) and not((other_rc3_1 in ['I60', 'I61', 'I62'])) and not((other_rc4_1 in ['I60', 'I61', 'I62'])), other_rc3_c1509, other_rc3_1);

other_rc1 := if(other_rc1_1 = '', 'A42', other_rc1_1);

iv_rv5_deceased := rc_decsflag = 1 or rc_ssndod != 0 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',');

iv_rv5_unscorable := if(truedid = false, 1, 0);

base := 680;

pts := -50;

other_odds := 0.1403;

other_score := map(
    iv_rv5_deceased   => 200,
    iv_rv5_unscorable = 1 => 222,
                             min(if(max(round(pts * (other_lgt - ln(other_odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (other_lgt - ln(other_odds)) / ln(2) + base), 501)), 900));

rc5 := map(
    segment_recreate = 0 => '    ',
    segment_recreate = 2 => if(derog_score in [200,222,900], '', derog_rc5),
    segment_recreate = 3 =>  if(owner_score in [200,222,900], '', owner_rc5),
                             if(other_score in [200,222,900], '', other_rc5));

rc1 := map(
    segment_recreate = 0 => '    ',
    segment_recreate = 2 => if(derog_score in [200,222,900], '', derog_rc1),
    segment_recreate = 3 =>  if(owner_score in [200,222,900], '', owner_rc1),
                            if(other_score in [200,222,900], '', other_rc1));

rc4 := map(
    segment_recreate = 0 => '    ',
    segment_recreate = 2 => if(derog_score in [200,222,900], '', derog_rc4),
    segment_recreate = 3 =>  if(owner_score in [200,222,900], '', owner_rc4),
                            if(other_score in [200,222,900], '', other_rc4));

rc3 := map(
    segment_recreate = 0 => '    ',
    segment_recreate = 2 => if(derog_score in [200,222,900], '', derog_rc3),
    segment_recreate = 3 => if(owner_score in [200,222,900], '', owner_rc3),
                            if(other_score in [200,222,900], '', other_rc3));

rc2 := map(
    segment_recreate = 0 => '    ',
    segment_recreate = 2 => if(derog_score in [200,222,900], '', derog_rc2),
    segment_recreate = 3 => if(owner_score in [200,222,900], '', owner_rc2),
                            if(other_score in [200,222,900], '', other_rc2));



rva1904_1_0 := map(
    segment_recreate = 0 => 222,
    segment_recreate = 2 => derog_score,
    segment_recreate = 3 => owner_score,
                            other_score);

//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1904_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1904_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1904_1_0 = 900 => DATASET([{'00'}], HRILayout),
																							 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI NOT IN ['', '00']);
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//
    #if(MODEL_DEBUG)
		/* Model Input Variables */
self.criminalfelonycount  :=  criminalfelonycount;
self.criminalnonfelonycount12month  :=  criminalnonfelonycount12month;
self.criminalnonfelonycount  :=  criminalnonfelonycount;
self.addrinputmatchindex  :=  addrinputmatchindex;
self.evictioncount12month  :=  evictioncount12month;
self.evictioncount  :=  evictioncount;
self.bankruptcydismissed24month  :=  bankruptcydismissed24month;
self.inquiryshortterm12month  :=  inquiryshortterm12month;
self.criminalfelonytimenewest  :=  criminalfelonytimenewest;
self.addrprevioustimeoldest  :=  addrprevioustimeoldest;
self.assetpropevercount  :=  assetpropevercount;
self.subjectage  :=  subjectage;
self.addronfilecount  :=  addronfilecount;
self.inquirynonshortterm12month  :=  inquirynonshortterm12month;
self.addrcurrentavmvalue  :=  addrcurrentavmvalue;
self.derogtimenewest  :=  derogtimenewest;
self.assetpersonal  :=  assetpersonal;
self.inquirybanking12month  :=  inquirybanking12month;
self.sourcenonderogcount12month  :=  sourcenonderogcount12month;
self.businessassociation  :=  businessassociation;
self.addrinputavmvalue  :=  addrinputavmvalue;
self.addrinputproblems  :=  addrinputproblems;
self.assetproppurchasecount12month  :=  assetproppurchasecount12month;
self.addrcurrentavmratio60monthprior  :=  addrcurrentavmratio60monthprior;
self.addrcurrentsubjectowned  :=  addrcurrentsubjectowned;
self.assetpropcurrenttaxtotal  :=  assetpropcurrenttaxtotal;
self.profliccount  :=  profliccount;
self.inquiryauto12month  :=  inquiryauto12month;
self.inquirytelcom12month  :=  inquirytelcom12month;
self.addrinputavmvalue12month  :=  addrinputavmvalue12month;
self.addrinputlengthofres  :=  addrinputlengthofres;
self.truedid  :=  truedid;
self.rc_ssndod  :=  rc_ssndod;
self.rc_decsflag  :=  rc_decsflag;
self.ver_sources  :=  ver_sources;
self.add_input_naprop  :=  add_input_naprop;
self.property_owned_total  :=  property_owned_total;
self.stl_inq_count24  :=  stl_inq_count24;
self.attr_eviction_count  :=  attr_eviction_count;
self.bk_dismissed_recent_count  :=  bk_dismissed_recent_count;
self.bk_dismissed_historical_count  :=  bk_dismissed_historical_count;
self.liens_recent_unrel_count  :=  liens_recent_unrel_count;
self.liens_historical_unrel_count  :=  liens_historical_unrel_count;
self.liens_recent_rel_count  :=  liens_recent_rel_count;
self.liens_historical_rel_count  :=  liens_historical_rel_count;
self.liens_unrel_cj_ct  :=  liens_unrel_cj_ct;
self.liens_rel_cj_ct  :=  liens_rel_cj_ct;
self.liens_unrel_ft_ct  :=  liens_unrel_ft_ct;
self.liens_rel_ft_ct  :=  liens_rel_ft_ct;
self.liens_unrel_fc_ct  :=  liens_unrel_fc_ct;
self.liens_rel_fc_ct  :=  liens_rel_fc_ct;
self.liens_unrel_lt_ct  :=  liens_unrel_lt_ct;
self.liens_rel_lt_ct  :=  liens_rel_lt_ct;
self.liens_unrel_o_ct  :=  liens_unrel_o_ct;
self.liens_rel_o_ct  :=  liens_rel_o_ct;
self.liens_unrel_ot_ct  :=  liens_unrel_ot_ct;
self.liens_rel_ot_ct  :=  liens_rel_ot_ct;
self.liens_unrel_sc_ct  :=  liens_unrel_sc_ct;
self.liens_rel_sc_ct  :=  liens_rel_sc_ct;
self.liens_unrel_st_ct  :=  liens_unrel_st_ct;
self.liens_rel_st_ct  :=  liens_rel_st_ct;
self.criminal_count  :=  criminal_count;
self.felony_count  :=  felony_count;
self.ca_criminal_index  :=  ca_criminal_index;
self.ca_inputaddrmatchesprevious  :=  ca_inputaddrmatchesprevious;
self.ca_eviction_index  :=  ca_eviction_index;
self.tot_liens  :=  tot_liens;
self.tot_liens_w_type  :=  tot_liens_w_type;
self.has_derog  :=  has_derog;
self.segment_recreate  :=  segment_recreate;
self.derog_v01_w  :=  derog_v01_w;
self.derog_aa_code_01_1  :=  derog_aa_code_01_1;
self.derog_aa_dist_01  :=  derog_aa_dist_01;
self.derog_aa_code_01  :=  derog_aa_code_01;
self.derog_v02_w  :=  derog_v02_w;
self.derog_aa_code_02_1  :=  derog_aa_code_02_1;
self.derog_aa_dist_02  :=  derog_aa_dist_02;
self.derog_aa_code_02  :=  derog_aa_code_02;
self.derog_v03_w  :=  derog_v03_w;
self.derog_aa_code_03_1  :=  derog_aa_code_03_1;
self.derog_aa_dist_03  :=  derog_aa_dist_03;
self.derog_aa_code_03  :=  derog_aa_code_03;
self.derog_v04_w  :=  derog_v04_w;
self.derog_aa_code_04_1  :=  derog_aa_code_04_1;
self.derog_aa_dist_04  :=  derog_aa_dist_04;
self.derog_aa_code_04  :=  derog_aa_code_04;
self.derog_v05_w  :=  derog_v05_w;
self.derog_aa_code_05_1  :=  derog_aa_code_05_1;
self.derog_aa_dist_05  :=  derog_aa_dist_05;
self.derog_aa_code_05  :=  derog_aa_code_05;
self.derog_v06_w  :=  derog_v06_w;
self.derog_aa_code_06_1  :=  derog_aa_code_06_1;
self.derog_aa_dist_06  :=  derog_aa_dist_06;
self.derog_aa_code_06  :=  derog_aa_code_06;
self.derog_v07_w  :=  derog_v07_w;
self.derog_aa_code_07_1  :=  derog_aa_code_07_1;
self.derog_aa_dist_07  :=  derog_aa_dist_07;
self.derog_aa_code_07  :=  derog_aa_code_07;
self.derog_v08_w  :=  derog_v08_w;
self.derog_aa_code_08_1  :=  derog_aa_code_08_1;
self.derog_aa_dist_08  :=  derog_aa_dist_08;
self.derog_aa_code_08  :=  derog_aa_code_08;
self.derog_v09_w  :=  derog_v09_w;
self.derog_aa_code_09_1  :=  derog_aa_code_09_1;
self.derog_aa_dist_09  :=  derog_aa_dist_09;
self.derog_aa_code_09  :=  derog_aa_code_09;
self.derog_v10_w  :=  derog_v10_w;
self.derog_aa_code_10_1  :=  derog_aa_code_10_1;
self.derog_aa_dist_10  :=  derog_aa_dist_10;
self.derog_aa_code_10  :=  derog_aa_code_10;
self.derog_v11_w  :=  derog_v11_w;
self.derog_aa_code_11_1  :=  derog_aa_code_11_1;
self.derog_aa_dist_11  :=  derog_aa_dist_11;
self.derog_aa_code_11  :=  derog_aa_code_11;
self.derog_v12_w  :=  derog_v12_w;
self.derog_aa_code_12_1  :=  derog_aa_code_12_1;
self.derog_aa_dist_12  :=  derog_aa_dist_12;
self.derog_aa_code_12  :=  derog_aa_code_12;
self.derog_v13_w  :=  derog_v13_w;
self.derog_aa_code_13_1  :=  derog_aa_code_13_1;
self.derog_aa_dist_13  :=  derog_aa_dist_13;
self.derog_aa_code_13  :=  derog_aa_code_13;
self.derog_v14_w  :=  derog_v14_w;
self.derog_aa_code_14_1  :=  derog_aa_code_14_1;
self.derog_aa_dist_14  :=  derog_aa_dist_14;
self.derog_aa_code_14  :=  derog_aa_code_14;
self.derog_v15_w  :=  derog_v15_w;
self.derog_aa_code_15_1  :=  derog_aa_code_15_1;
self.derog_aa_dist_15  :=  derog_aa_dist_15;
self.derog_aa_code_15  :=  derog_aa_code_15;
self.derog_v16_w  :=  derog_v16_w;
self.derog_aa_code_16_1  :=  derog_aa_code_16_1;
self.derog_aa_dist_16  :=  derog_aa_dist_16;
self.derog_aa_code_16  :=  derog_aa_code_16;
self.derog_v17_w  :=  derog_v17_w;
self.derog_aa_code_17_1  :=  derog_aa_code_17_1;
self.derog_aa_dist_17  :=  derog_aa_dist_17;
self.derog_aa_code_17  :=  derog_aa_code_17;
self.derog_rcvalued31  :=  derog_rcvalued31;
self.derog_rcvaluef03  :=  derog_rcvaluef03;
self.derog_rcvalued32  :=  derog_rcvalued32;
self.derog_rcvaluec24  :=  derog_rcvaluec24;
self.derog_rcvaluea45  :=  derog_rcvaluea45;
self.derog_rcvaluec12  :=  derog_rcvaluec12;
self.derog_rcvaluea47  :=  derog_rcvaluea47;
self.derog_rcvaluei60  :=  derog_rcvaluei60;
self.derog_rcvaluee57  :=  derog_rcvaluee57;
self.derog_rcvaluea40  :=  derog_rcvaluea40;
self.derog_rcvaluec27  :=  derog_rcvaluec27;
self.derog_rcvaluec14  :=  derog_rcvaluec14;
self.derog_rcvalued33  :=  derog_rcvalued33;
self.derog_lgt  :=  derog_lgt;
self.r_derog_rc1  :=  r_derog_rc1;
self.r_derog_rc2  :=  r_derog_rc2;
self.r_derog_rc3  :=  r_derog_rc3;
self.r_derog_rc4  :=  r_derog_rc4;
self.r_derog_rc5  :=  r_derog_rc5;
self.r_derog_rc6  :=  r_derog_rc6;
self.r_derog_rc7  :=  r_derog_rc7;
self.r_derog_rc8  :=  r_derog_rc8;
self.r_derog_rc9  :=  r_derog_rc9;
self.r_derog_rc10  :=  r_derog_rc10;
self.r_derog_rc11  :=  r_derog_rc11;
self.r_derog_rc12  :=  r_derog_rc12;
self.r_derog_rc13  :=  r_derog_rc13;
self.r_derog_rc14  :=  r_derog_rc14;
self.r_derog_rc15  :=  r_derog_rc15;
self.r_derog_rc16  :=  r_derog_rc16;
self.r_derog_rc17  :=  r_derog_rc17;
self.r_derog_vl1  :=  r_derog_vl1;
self.r_derog_vl2  :=  r_derog_vl2;
self.r_derog_vl3  :=  r_derog_vl3;
self.r_derog_vl4  :=  r_derog_vl4;
self.r_derog_vl5  :=  r_derog_vl5;
self.r_derog_vl6  :=  r_derog_vl6;
self.r_derog_vl7  :=  r_derog_vl7;
self.r_derog_vl8  :=  r_derog_vl8;
self.r_derog_vl9  :=  r_derog_vl9;
self.r_derog_vl10  :=  r_derog_vl10;
self.r_derog_vl11  :=  r_derog_vl11;
self.r_derog_vl12  :=  r_derog_vl12;
self.r_derog_vl13  :=  r_derog_vl13;
self.r_derog_vl14  :=  r_derog_vl14;
self.r_derog_vl15  :=  r_derog_vl15;
self.r_derog_vl16  :=  r_derog_vl16;
self.r_derog_vl17  :=  r_derog_vl17;
self.derog_rc1_2  :=  derog_rc1_2;
self.derog_rc2_2  :=  derog_rc2_2;
self.derog_rc3_2  :=  derog_rc3_2;
self.derog_rc4_2  :=  derog_rc4_2;
self._rc_inq_2  :=  _rc_inq_2;
self.derog_rc3_c1413  :=  derog_rc3_c1413;
self.derog_rc1_c1413  :=  derog_rc1_c1413;
self.derog_rc2_c1413  :=  derog_rc2_c1413;
self.derog_rc5_c1413  :=  derog_rc5_c1413;
self.derog_rc1_1  :=  derog_rc1_1;
self.derog_rc2_1  :=  derog_rc2_1;
self.derog_rc3_1  :=  derog_rc3_1;
self.derog_rc5  :=  if(derog_score in [200,222,900], '', derog_rc5);
self.derog_rc4  :=  if(derog_score in [200,222,900], '', derog_rc4);
self.derog_rc3  :=  if(derog_score in [200,222,900], '', derog_rc3);
self.derog_rc2  :=  if(derog_score in [200,222,900], '', derog_rc2);
self.derog_rc1  :=  if(derog_score in [200,222,900], '', derog_rc1);
self.iv_rv5_deceased_2  :=  iv_rv5_deceased_2;
self.iv_rv5_unscorable_2  :=  iv_rv5_unscorable_2;
self.base_2  :=  base_2;
self.pts_2  :=  pts_2;
self.derog_odds  :=  derog_odds;
self.derog_score  :=  derog_score;
self.owner_v01_w  :=  owner_v01_w;
self.owner_aa_code_01_1  :=  owner_aa_code_01_1;
self.owner_aa_dist_01  :=  owner_aa_dist_01;
self.owner_aa_code_01  :=  owner_aa_code_01;
self.owner_v02_w  :=  owner_v02_w;
self.owner_aa_code_02_1  :=  owner_aa_code_02_1;
self.owner_aa_dist_02  :=  owner_aa_dist_02;
self.owner_aa_code_02  :=  owner_aa_code_02;
self.owner_v03_w  :=  owner_v03_w;
self.owner_aa_code_03_1  :=  owner_aa_code_03_1;
self.owner_aa_dist_03  :=  owner_aa_dist_03;
self.owner_aa_code_03  :=  owner_aa_code_03;
self.owner_v04_w  :=  owner_v04_w;
self.owner_aa_code_04_1  :=  owner_aa_code_04_1;
self.owner_aa_dist_04  :=  owner_aa_dist_04;
self.owner_aa_code_04  :=  owner_aa_code_04;
self.owner_v05_w  :=  owner_v05_w;
self.owner_aa_code_05_1  :=  owner_aa_code_05_1;
self.owner_aa_dist_05  :=  owner_aa_dist_05;
self.owner_aa_code_05  :=  owner_aa_code_05;
self.owner_v06_w  :=  owner_v06_w;
self.owner_aa_code_06_1  :=  owner_aa_code_06_1;
self.owner_aa_dist_06  :=  owner_aa_dist_06;
self.owner_aa_code_06  :=  owner_aa_code_06;
self.owner_v07_w  :=  owner_v07_w;
self.owner_aa_code_07_1  :=  owner_aa_code_07_1;
self.owner_aa_dist_07  :=  owner_aa_dist_07;
self.owner_aa_code_07  :=  owner_aa_code_07;
self.owner_v08_w  :=  owner_v08_w;
self.owner_aa_code_08_1  :=  owner_aa_code_08_1;
self.owner_aa_dist_08  :=  owner_aa_dist_08;
self.owner_aa_code_08  :=  owner_aa_code_08;
self.owner_v09_w  :=  owner_v09_w;
self.owner_aa_code_09_1  :=  owner_aa_code_09_1;
self.owner_aa_dist_09  :=  owner_aa_dist_09;
self.owner_aa_code_09  :=  owner_aa_code_09;
self.owner_v10_w  :=  owner_v10_w;
self.owner_aa_code_10_1  :=  owner_aa_code_10_1;
self.owner_aa_dist_10  :=  owner_aa_dist_10;
self.owner_aa_code_10  :=  owner_aa_code_10;
self.owner_v11_w  :=  owner_v11_w;
self.owner_aa_code_11_1  :=  owner_aa_code_11_1;
self.owner_aa_dist_11  :=  owner_aa_dist_11;
self.owner_aa_code_11  :=  owner_aa_code_11;
self.owner_v12_w  :=  owner_v12_w;
self.owner_aa_code_12_1  :=  owner_aa_code_12_1;
self.owner_aa_dist_12  :=  owner_aa_dist_12;
self.owner_aa_code_12  :=  owner_aa_code_12;
self.owner_v13_w  :=  owner_v13_w;
self.owner_aa_code_13_1  :=  owner_aa_code_13_1;
self.owner_aa_dist_13  :=  owner_aa_dist_13;
self.owner_aa_code_13  :=  owner_aa_code_13;
self.owner_v14_w  :=  owner_v14_w;
self.owner_aa_code_14_1  :=  owner_aa_code_14_1;
self.owner_aa_dist_14  :=  owner_aa_dist_14;
self.owner_aa_code_14  :=  owner_aa_code_14;
self.owner_rcvaluel80  :=  owner_rcvaluel80;
self.owner_rcvaluec24  :=  owner_rcvaluec24;
self.owner_rcvaluea45  :=  owner_rcvaluea45;
self.owner_rcvaluec12  :=  owner_rcvaluec12;
self.owner_rcvaluea47  :=  owner_rcvaluea47;
self.owner_rcvaluef01  :=  owner_rcvaluef01;
self.owner_rcvaluel71  :=  owner_rcvaluel71;
self.owner_rcvaluei60  :=  owner_rcvaluei60;
self.owner_rcvaluea49  :=  owner_rcvaluea49;
self.owner_rcvaluel70  :=  owner_rcvaluel70;
self.owner_rcvaluec14  :=  owner_rcvaluec14;
self.owner_rcvaluea44  :=  owner_rcvaluea44;
self.owner_rcvaluee57  :=  owner_rcvaluee57;
self.owner_lgt  :=  owner_lgt;
self.r_owner_rc1  :=  r_owner_rc1;
self.r_owner_rc2  :=  r_owner_rc2;
self.r_owner_rc3  :=  r_owner_rc3;
self.r_owner_rc4  :=  r_owner_rc4;
self.r_owner_rc5  :=  r_owner_rc5;
self.r_owner_rc6  :=  r_owner_rc6;
self.r_owner_rc7  :=  r_owner_rc7;
self.r_owner_rc8  :=  r_owner_rc8;
self.r_owner_rc9  :=  r_owner_rc9;
self.r_owner_rc10  :=  r_owner_rc10;
self.r_owner_rc11  :=  r_owner_rc11;
self.r_owner_rc12  :=  r_owner_rc12;
self.r_owner_rc13  :=  r_owner_rc13;
self.r_owner_rc14  :=  r_owner_rc14;
self.r_owner_vl1  :=  r_owner_vl1;
self.r_owner_vl2  :=  r_owner_vl2;
self.r_owner_vl3  :=  r_owner_vl3;
self.r_owner_vl4  :=  r_owner_vl4;
self.r_owner_vl5  :=  r_owner_vl5;
self.r_owner_vl6  :=  r_owner_vl6;
self.r_owner_vl7  :=  r_owner_vl7;
self.r_owner_vl8  :=  r_owner_vl8;
self.r_owner_vl9  :=  r_owner_vl9;
self.r_owner_vl10  :=  r_owner_vl10;
self.r_owner_vl11  :=  r_owner_vl11;
self.r_owner_vl12  :=  r_owner_vl12;
self.r_owner_vl13  :=  r_owner_vl13;
self.r_owner_vl14  :=  r_owner_vl14;
self.owner_rc1_1  :=  owner_rc1_1;
self.owner_rc2_1  :=  owner_rc2_1;
self.owner_rc3_1  :=  owner_rc3_1;
self.owner_rc4_1  :=  owner_rc4_1;
self._rc_inq_1  :=  _rc_inq_1;
self.owner_rc5_c1461  :=  owner_rc5_c1461;
self.owner_rc4_c1461  :=  owner_rc4_c1461;
self.owner_rc2_c1461  :=  owner_rc2_c1461;
self.owner_rc1_c1461  :=  owner_rc1_c1461;
self.owner_rc3_c1461  :=  owner_rc3_c1461;
self.owner_rc5  :=  if(owner_score in [200,222,900], '', owner_rc5);
self.owner_rc4  :=  if(owner_score in [200,222,900], '', owner_rc4);
self.owner_rc1  :=  if(owner_score in [200,222,900], '', owner_rc1);
self.owner_rc2  :=  if(owner_score in [200,222,900], '', owner_rc2);
self.owner_rc3  :=  if(owner_score in [200,222,900], '', owner_rc3);
self.iv_rv5_deceased_1  :=  iv_rv5_deceased_1;
self.iv_rv5_unscorable_1  :=  iv_rv5_unscorable_1;
self.base_1  :=  base_1;
self.pts_1  :=  pts_1;
self.owner_odds  :=  owner_odds;
self.owner_score  :=  owner_score;
self.other_v01_w  :=  other_v01_w;
self.other_aa_code_01_1  :=  other_aa_code_01_1;
self.other_aa_dist_01  :=  other_aa_dist_01;
self.other_aa_code_01  :=  other_aa_code_01;
self.other_v02_w  :=  other_v02_w;
self.other_aa_code_02_1  :=  other_aa_code_02_1;
self.other_aa_dist_02  :=  other_aa_dist_02;
self.other_aa_code_02  :=  other_aa_code_02;
self.other_v03_w  :=  other_v03_w;
self.other_aa_code_03_1  :=  other_aa_code_03_1;
self.other_aa_dist_03  :=  other_aa_dist_03;
self.other_aa_code_03  :=  other_aa_code_03;
self.other_v04_w  :=  other_v04_w;
self.other_aa_code_04_1  :=  other_aa_code_04_1;
self.other_aa_dist_04  :=  other_aa_dist_04;
self.other_aa_code_04  :=  other_aa_code_04;
self.other_v05_w  :=  other_v05_w;
self.other_aa_code_05_1  :=  other_aa_code_05_1;
self.other_aa_dist_05  :=  other_aa_dist_05;
self.other_aa_code_05  :=  other_aa_code_05;
self.other_v06_w  :=  other_v06_w;
self.other_aa_code_06_1  :=  other_aa_code_06_1;
self.other_aa_dist_06  :=  other_aa_dist_06;
self.other_aa_code_06  :=  other_aa_code_06;
self.other_v07_w  :=  other_v07_w;
self.other_aa_code_07_1  :=  other_aa_code_07_1;
self.other_aa_dist_07  :=  other_aa_dist_07;
self.other_aa_code_07  :=  other_aa_code_07;
self.other_v08_w  :=  other_v08_w;
self.other_aa_code_08_1  :=  other_aa_code_08_1;
self.other_aa_dist_08  :=  other_aa_dist_08;
self.other_aa_code_08  :=  other_aa_code_08;
self.other_v09_w  :=  other_v09_w;
self.other_aa_code_09_1  :=  other_aa_code_09_1;
self.other_aa_dist_09  :=  other_aa_dist_09;
self.other_aa_code_09  :=  other_aa_code_09;
self.other_v10_w  :=  other_v10_w;
self.other_aa_code_10_1  :=  other_aa_code_10_1;
self.other_aa_dist_10  :=  other_aa_dist_10;
self.other_aa_code_10  :=  other_aa_code_10;
self.other_v11_w  :=  other_v11_w;
self.other_aa_code_11_1  :=  other_aa_code_11_1;
self.other_aa_dist_11  :=  other_aa_dist_11;
self.other_aa_code_11  :=  other_aa_code_11;
self.other_v12_w  :=  other_v12_w;
self.other_aa_code_12_1  :=  other_aa_code_12_1;
self.other_aa_dist_12  :=  other_aa_dist_12;
self.other_aa_code_12  :=  other_aa_code_12;
self.other_v13_w  :=  other_v13_w;
self.other_aa_code_13_1  :=  other_aa_code_13_1;
self.other_aa_dist_13  :=  other_aa_dist_13;
self.other_aa_code_13  :=  other_aa_code_13;
self.other_v14_w  :=  other_v14_w;
self.other_aa_code_14_1  :=  other_aa_code_14_1;
self.other_aa_dist_14  :=  other_aa_dist_14;
self.other_aa_code_14  :=  other_aa_code_14;
self.other_rcvaluef03  :=  other_rcvaluef03;
self.other_rcvaluel80  :=  other_rcvaluel80;
self.other_rcvaluec13  :=  other_rcvaluec13;
self.other_rcvaluec24  :=  other_rcvaluec24;
self.other_rcvaluec12  :=  other_rcvaluec12;
self.other_rcvaluea47  :=  other_rcvaluea47;
self.other_rcvaluel71  :=  other_rcvaluel71;
self.other_rcvaluei60  :=  other_rcvaluei60;
self.other_rcvaluel70  :=  other_rcvaluel70;
self.other_rcvaluec27  :=  other_rcvaluec27;
self.other_rcvaluec14  :=  other_rcvaluec14;
self.other_rcvaluee57  :=  other_rcvaluee57;
self.other_lgt  :=  other_lgt;
self.r_other_rc1  :=  r_other_rc1;
self.r_other_rc2  :=  r_other_rc2;
self.r_other_rc3  :=  r_other_rc3;
self.r_other_rc4  :=  r_other_rc4;
self.r_other_rc5  :=  r_other_rc5;
self.r_other_rc6  :=  r_other_rc6;
self.r_other_rc7  :=  r_other_rc7;
self.r_other_rc8  :=  r_other_rc8;
self.r_other_rc9  :=  r_other_rc9;
self.r_other_rc10  :=  r_other_rc10;
self.r_other_rc11  :=  r_other_rc11;
self.r_other_rc12  :=  r_other_rc12;
self.r_other_rc13  :=  r_other_rc13;
self.r_other_rc14  :=  r_other_rc14;
self.r_other_vl1  :=  r_other_vl1;
self.r_other_vl2  :=  r_other_vl2;
self.r_other_vl3  :=  r_other_vl3;
self.r_other_vl4  :=  r_other_vl4;
self.r_other_vl5  :=  r_other_vl5;
self.r_other_vl6  :=  r_other_vl6;
self.r_other_vl7  :=  r_other_vl7;
self.r_other_vl8  :=  r_other_vl8;
self.r_other_vl9  :=  r_other_vl9;
self.r_other_vl10  :=  r_other_vl10;
self.r_other_vl11  :=  r_other_vl11;
self.r_other_vl12  :=  r_other_vl12;
self.r_other_vl13  :=  r_other_vl13;
self.r_other_vl14  :=  r_other_vl14;
self.other_rc1_2  :=  other_rc1_2;
self.other_rc2_1  :=  other_rc2_1;
self.other_rc3_1  :=  other_rc3_1;
self.other_rc4_1  :=  other_rc4_1;
self._rc_inq  :=  _rc_inq;
self.other_rc3_c1509  :=  other_rc3_c1509;
self.other_rc5_c1509  :=  other_rc5_c1509;
self.other_rc1_c1509  :=  other_rc1_c1509;
self.other_rc4_c1509  :=  other_rc4_c1509;
self.other_rc2_c1509  :=  other_rc2_c1509;
self.other_rc4  :=  if(other_score in [200,222,900], '', other_rc4);
self.other_rc2  :=  if(other_score in [200,222,900], '', other_rc2);
self.other_rc5  :=  if(other_score in [200,222,900], '', other_rc5);
self.other_rc1_1  :=  if(other_score in [200,222,900], '', other_rc1_1);
self.other_rc3  :=  if(other_score in [200,222,900], '', other_rc3);
self.other_rc1  :=  if(other_score in [200,222,900], '', other_rc1);
self.iv_rv5_deceased  :=  iv_rv5_deceased;
self.iv_rv5_unscorable  :=  iv_rv5_unscorable;
self.base  :=  base;
self.pts  :=  pts;
self.other_odds  :=  other_odds;
self.other_score  :=  other_score;
self.rc5  :=  rc5;
self.rc1  :=  rc1;
self.rc4  :=  rc4;
self.rc3  :=  rc3;
self.rc2  :=  rc2;
self.RVA1904_1_0 := RVA1904_1_0;
self.clam  :=   le;

#else
	self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
	self.score 	:= (STRING3)RVA1904_1_0;
    self.seq 		:= le.seq;
#end
  
	END;

	model := join(clam, attributes, left.seq=right.seq, doModel(LEFT, right));

	RETURN(model);
  
END;
