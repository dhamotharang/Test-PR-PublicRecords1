import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVG1404_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVG_DEBUG := False;
  
  #if(RVG_DEBUG)
    layout_debug := record
		Integer sysdate                     ;
		String iv_db001_bankruptcy          ;
		Boolean email_src_im                ;
		Integer iv_ds001_impulse_count      ;
		Integer _header_first_seen          ;
		Integer iv_sr001_m_hdr_fs           ;
		Integer iv_inp_addr_source_count    ;
		String iv_bst_own_prop_x_addr_naprop;
		Integer iv_addrs_5yr                ;
		Integer iv_max_ids_per_addr_c6      ;
		Boolean ver_phn_inf                 ;
		Boolean ver_phn_nap                 ;
		Integer inf_phn_ver_lvl             ;
		Integer nap_phn_ver_lvl             ;
		String iv_nap_phn_ver_x_inf_phn_ver ;
		Integer iv_eviction_count    ;
		Integer iv_liens_unrel_sc_ct ;
		Integer iv_criminal_count    ;
		String iv_prof_license_flag  ;
		Integer iv_pb_total_orders   ;
		Real subscore0          ;
		Real subscore1          ;
		Real subscore2          ;
		Real subscore3          ;
		Real subscore4          ;
		Real subscore5          ;
		Real subscore6          ;
		Real subscore7          ;
		Real subscore8          ;
		Real subscore9          ;
		Real subscore10         ;
		Real subscore11         ;
		Real subscore12         ;
		Real rawscore           ;
		Real lnoddsscore        ;
		Real probscore          ;
		Integer base            ;
		Real odds               ;
		Integer pts             ;
		Boolean ssn_deceased    ;
		Boolean iv_riskview_222s;
		Integer rvg1404_1       ;
		Boolean glrc97          ;
		Boolean glrc98          ;
		Boolean srcprop         ;
		Boolean glrc9a          ;
		Boolean glrc9b          ;
		Boolean glrc9d          ;
		Boolean glrc9e          ;
		Boolean glrc9h          ;
		Boolean glrc9j          ;
		Boolean glrc9o          ;
		Boolean glrc9w          ;
		// Boolean glrc9y          ;
		Boolean glrcev          ;
		Real glrcbl             ;
		Real rcvalue97_1        ;
		Real rcvalue97          ;
		Real rcvalue98_1        ;
		Real rcvalue98          ;
		Real rcvalue9a_1        ;
		Real rcvalue9a          ;
		Real rcvalue9b_1        ;
		Real rcvalue9b          ;
		Real rcvalue9d_1        ;
		Real rcvalue9d          ;
		Real rcvalue9e_1        ;
		Real rcvalue9e          ;
		Real rcvalue9h_1        ;
		Real rcvalue9h          ;
		Real rcvalue9j_1        ;
		Real rcvalue9j          ;
		Real rcvalue9o_1        ;
		Real rcvalue9o          ;
		Real rcvalue9w_1        ;
		Real rcvalue9w          ;
		// Real rcvalue9y_1        ;
		// Real rcvalue9y          ;
		Real rcvalueev_1        ;
		Real rcvalueev          ;
		String rc1              ;
		String rc2              ;
		String rc3              ;
		String rc4              ;
		String rc5              ;
		models.layout_modelout;
		risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
  
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	header_first_seen                := le.ssn_verification.header_first_seen;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	impulse_count                    := le.impulse.count;
	email_source_list                := le.email_summary.email_source_list;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	prof_license_flag                := le.professional_license.professional_license_flag;


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_db001_bankruptcy := map(
    not(truedid or (Integer)ssnlength > 0)                                                                                               => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                                      => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                                       => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or (Integer)bankrupt = 1 or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                            '0 - No BK        ');

email_src_im := Models.Common.findw_cpp(email_source_list, 'IM' , ', ', 'E') > 0;

iv_ds001_impulse_count := map(
    not(truedid)                                    => NULL,
    impulse_count = 0 and (Integer)email_src_im > 0 => 1,
                                                       impulse_count);

_header_first_seen := common.sas_date((string)(header_first_seen));

iv_sr001_m_hdr_fs := map(
    not(truedid)                   => NULL,
    not(_header_first_seen = NULL) => if ((sysdate - _header_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _header_first_seen) / (365.25 / 12)), roundup((sysdate - _header_first_seen) / (365.25 / 12))),
                                      -1);

iv_inp_addr_source_count := if(not(add1_pop), NULL, add1_source_count);

//iv_bst_own_prop_x_addr_naprop_c6 := if(property_owned_total > 0, put(add1_naprop + 10, 2.), put(add1_naprop, z2.));
iv_bst_own_prop_x_addr_naprop_c6 := if(property_owned_total > 0, Intformat((INTEGER)add1_naprop + 10, 2, 1)[1..2], Intformat((Integer)add1_naprop, 2, 1)[1..2]);

//iv_bst_own_prop_x_addr_naprop_c7 := if(property_owned_total > 0, put(add2_naprop + 10, 2.), put(add2_naprop, z2.));
iv_bst_own_prop_x_addr_naprop_c7 := if(property_owned_total > 0, Intformat((INTEGER)add2_naprop + 10, 2, 1)[1..2], Intformat((Integer)add2_naprop, 2, 1)[1..2]);

iv_bst_own_prop_x_addr_naprop := map(
    not(truedid)     => '  ',
    add1_isbestmatch => iv_bst_own_prop_x_addr_naprop_c6,
                        iv_bst_own_prop_x_addr_naprop_c7);

iv_addrs_5yr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             addrs_5yr);

iv_max_ids_per_addr_c6 := if(not(add1_pop), NULL, max(adls_per_addr_c6, ssns_per_addr_c6));

ver_phn_inf := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

ver_phn_nap := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

inf_phn_ver_lvl := map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2);

nap_phn_ver_lvl := map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2);

iv_nap_phn_ver_x_inf_phn_ver := map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((String)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((String)inf_phn_ver_lvl, LEFT, RIGHT));

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_liens_unrel_sc_ct := if(not(truedid), NULL, liens_unrel_SC_ct);

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_prof_license_flag := if(not(truedid), ' ', if(prof_license_flag, '1', '0'));

iv_pb_total_orders := map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                            (Integer)pb_total_orders);

subscore0 := map(
    NULL < iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 122 => -0.492048,
    122 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 184 => -0.246842,
    184 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 217 => -0.074034,
    217 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 250 => 0.071573,
    250 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 296 => 0.205918,
    296 <= iv_sr001_m_hdr_fs AND iv_sr001_m_hdr_fs < 349 => 0.376065,
    349 <= iv_sr001_m_hdr_fs                             => 0.659079,
                                                            -0.000000);

subscore1 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.112433,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => 0.063347,
    2 <= iv_pb_total_orders AND iv_pb_total_orders < 4   => 0.126334,
    4 <= iv_pb_total_orders                              => 0.295692,
                                                            0.000000);

subscore2 := map(
    NULL < iv_addrs_5yr AND iv_addrs_5yr < 0 => -0.000000,
    0 <= iv_addrs_5yr AND iv_addrs_5yr < 1   => 0.295027,
    1 <= iv_addrs_5yr AND iv_addrs_5yr < 2   => 0.140701,
    2 <= iv_addrs_5yr AND iv_addrs_5yr < 3   => 0.109586,
    3 <= iv_addrs_5yr AND iv_addrs_5yr < 4   => 0.029629,
    4 <= iv_addrs_5yr AND iv_addrs_5yr < 5   => -0.073058,
    5 <= iv_addrs_5yr AND iv_addrs_5yr < 6   => -0.218321,
    6 <= iv_addrs_5yr AND iv_addrs_5yr < 7   => -0.275608,
    7 <= iv_addrs_5yr AND iv_addrs_5yr < 8   => -0.339954,
    8 <= iv_addrs_5yr                        => -0.505924,
                                                -0.000000);

subscore3 := map(
    NULL < iv_inp_addr_source_count AND iv_inp_addr_source_count < 1 => -0.148450,
    1 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 3   => 0.047646,
    3 <= iv_inp_addr_source_count AND iv_inp_addr_source_count < 5   => 0.070030,
    5 <= iv_inp_addr_source_count                                    => 0.204891,
                                                                        -0.000000);

subscore4 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.045326,
    1 <= iv_eviction_count                             => -0.315887,
                                                          -0.000000);

subscore5 := map(
    (iv_db001_bankruptcy in ['0 - No BK', '2 - BK Dismissed'])     => -0.027556,
    (iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => 0.280440,
                                                                      0.000000);

subscore6 := map(
    (iv_bst_own_prop_x_addr_naprop in [' '])                          => 0.000000,
    (iv_bst_own_prop_x_addr_naprop in ['01'])                         => -0.127124,
    (iv_bst_own_prop_x_addr_naprop in ['00', '02', '03'])             => 0.011999,
    (iv_bst_own_prop_x_addr_naprop in ['04', '10', '11', '12', '13']) => 0.116324,
    (iv_bst_own_prop_x_addr_naprop in ['14'])                         => 0.124052,
                                                                         0.000000);

subscore7 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                       => 0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-0', '1-1', '1-3'])        => -0.203586,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1'])               => -0.031424,
    (iv_nap_phn_ver_x_inf_phn_ver in ['2-0', '2-1'])               => 0.011353,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3', '3-1', '3-3']) => 0.101630,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                      => 0.112000,
                                                                      0.000000);

subscore8 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.015785,
    1 <= iv_criminal_count                             => -0.363126,
                                                          0.000000);

subscore9 := map(
    NULL < iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 1 => 0.063157,
    1 <= iv_max_ids_per_addr_c6 AND iv_max_ids_per_addr_c6 < 2   => -0.070371,
    2 <= iv_max_ids_per_addr_c6                                  => -0.259775,
                                                                    0.000000);

subscore10 := map(
    NULL < iv_liens_unrel_sc_ct AND iv_liens_unrel_sc_ct < 1 => 0.024292,
    1 <= iv_liens_unrel_sc_ct                                => -0.115470,
                                                                0.000000);

subscore11 := map(
    NULL < iv_ds001_impulse_count AND iv_ds001_impulse_count < 1 => 0.033344,
    1 <= iv_ds001_impulse_count AND iv_ds001_impulse_count < 2   => -0.154737,
    2 <= iv_ds001_impulse_count                                  => -0.489738,
                                                                    0.000000);

subscore12 := map(
    (iv_prof_license_flag in [' ']) => 0.000000,
    (iv_prof_license_flag in ['0']) => -0.005520,
    (iv_prof_license_flag in ['1']) => 0.190594,
                                       0.000000);

rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6 +
    subscore7 +
    subscore8 +
    subscore9 +
    subscore10 +
    subscore11 +
    subscore12;

lnoddsscore := rawscore + 1.616727;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

odds := (1 - 0.167) / 0.167;

pts := 40;

// ssn_deceased := (Integer)rc_decsflag = 1 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;
ssn_deceased := (Integer)rc_decsflag = 1 or indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvg1404_1 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

glrc97 := criminal_count > 0;

glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;

srcprop := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'P', ',');

glrc9a := property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and (Integer)srcprop = 0;

glrc9b := property_owned_total = 0 and (add1_naprop in [0, 1, 2]) and (Integer)srcprop = 1;

glrc9d := addrs_5yr > 2;

glrc9e := (Integer)add1_pop = 1 and add1_source_count < 3;

glrc9h := impulse_count > 0;

glrc9j := (Integer)truedid = 1 and iv_sr001_m_hdr_fs < 264;

glrc9o := (Integer)hphnpop = 1 and (Integer)add1_pop = 1 and (Integer)add1_eda_sourced = 0;

glrc9w := filing_count > 0;

//glrc9y := pb_total_orders = NULL;
// glrc9y := pb_total_orders = '';

glrcev := attr_eviction_count > 0;

glrcbl := 0;

rcvalue97_1 := (integer)glrc97 * (0.015785 - subscore8);

rcvalue97 := if(max(rcvalue97_1) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1)));

rcvalue98_1 := (integer)glrc98 * (0.024292 - subscore10);

rcvalue98 := if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9a_1 := (integer)glrc9a * (0.124052 - subscore6);

rcvalue9a := if(max(rcvalue9a_1) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1)));

rcvalue9b_1 := (integer)glrc9b * (0.124052 - subscore6);

rcvalue9b := if(max(rcvalue9b_1) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1)));

rcvalue9d_1 := (integer)glrc9d * (0.295027 - subscore2);

rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

rcvalue9e_1 := (integer)glrc9e * (0.204891 - subscore3);

rcvalue9e := if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));

rcvalue9h_1 := (integer)glrc9h * (0.033344 - subscore11);

rcvalue9h := if(max(rcvalue9h_1) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1)));

rcvalue9j_1 := (integer)glrc9j * (0.659079 - subscore0);

rcvalue9j := if(max(rcvalue9j_1) = NULL, NULL, sum(if(rcvalue9j_1 = NULL, 0, rcvalue9j_1)));

rcvalue9o_1 := (integer)glrc9o * (0.112 - subscore7);

rcvalue9o := if(max(rcvalue9o_1) = NULL, NULL, sum(if(rcvalue9o_1 = NULL, 0, rcvalue9o_1))) / 2;

rcvalue9w_1 := (integer)glrc9w * (0.28044 - subscore5);

rcvalue9w := if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));

// rcvalue9y_1 := (integer)glrc9y * (0.295692 - subscore1);

// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1))) / 4;

rcvalueev_1 := (integer)glrcev * (0.045326 - subscore4);

rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'97', RCValue97},
    {'98', RCValue98},
    {'9A', RCValue9A},
    {'9B', RCValue9B},
    {'9D', RCValue9D},
    {'9E', RCValue9E},
    {'9H', RCValue9H},
    {'9J', RCValue9J},
    {'9O', RCValue9O},
    {'9W', RCValue9W},
    // {'9Y', RCValue9Y},
    {'EV', RCValueEV}
    ], ds_layout)(value > 0);


rcs_top4 := Choosen(sort(rc_dataset, -rc_dataset.value), 4); //Get the top 4 reason codes

	
rcs1_1 := rcs_top4[1];
rcs2_2 := rcs_top4[2];
rcs3   := rcs_top4[3];
rcs4   := rcs_top4[4];

rcs1   := if((rcs1_1.rc = ''), ROW({'36', NULL}, ds_layout), rcs1_1);                                                           //If no codes return 36 as the 1st reason code.
rcs2_1 := if((rcs1.rc != '36' and rcs2_2.rc = '' and 500 < rvg1404_1 AND rvg1404_1 <= 740), ROW({'36', NULL}, ds_layout), rcs2_2); //If only 1 code return 36 as the second one.
rcs2   := if((rcs1.rc = '36' and rcs2_1.rc = '' and 500 < rvg1404_1 AND rvg1404_1 <= 740), ROW({'9F', NULL}, ds_layout), rcs2_1);  //If 36 is the only code return 9F as the second.
	
rcs := rcs1 & rcs2 & rcs3 & rcs4;

rcs_override := MAP( rvg1404_1 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvg1404_1 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     rvg1404_1 = 900 => DATASET([{'  ', NULL}], ds_layout),
										rcs
                   );

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
			(integer)(boolean)le.iid.combo_firstcount + (integer)(boolean)le.iid.combo_lastcount
			+ (integer)(boolean)le.iid.combo_addrcount + (integer)(boolean)le.iid.combo_hphonecount
			+ (integer)(boolean)le.iid.combo_ssncount + (integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif               => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
                                    rcs_final
         );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes

//Intermediate variables
	#if(RVG_DEBUG)
		self.clam                             := le;
		self.sysdate                          := sysdate;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.email_src_im                     := email_src_im;
		self.iv_ds001_impulse_count           := iv_ds001_impulse_count;
		self._header_first_seen               := _header_first_seen;
		self.iv_sr001_m_hdr_fs                := iv_sr001_m_hdr_fs;
		self.iv_inp_addr_source_count         := iv_inp_addr_source_count;
		self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
		self.iv_addrs_5yr                     := iv_addrs_5yr;
		self.iv_max_ids_per_addr_c6           := iv_max_ids_per_addr_c6;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_liens_unrel_sc_ct             := iv_liens_unrel_sc_ct;
		self.iv_criminal_count                := iv_criminal_count;
		self.iv_prof_license_flag             := iv_prof_license_flag;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.subscore0                        := subscore0;
		self.subscore1                        := subscore1;
		self.subscore2                        := subscore2;
		self.subscore3                        := subscore3;
		self.subscore4                        := subscore4;
		self.subscore5                        := subscore5;
		self.subscore6                        := subscore6;
		self.subscore7                        := subscore7;
		self.subscore8                        := subscore8;
		self.subscore9                        := subscore9;
		self.subscore10                       := subscore10;
		self.subscore11                       := subscore11;
		self.subscore12                       := subscore12;
		self.rawscore                         := rawscore;
		self.lnoddsscore                      := lnoddsscore;
		self.probscore                        := probscore;
		self.base                             := base;
		self.odds                             := odds;
		self.pts                              := pts;
		self.ssn_deceased                     := ssn_deceased;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.rvg1404_1                        := rvg1404_1;
		self.glrc97                           := glrc97;
		self.glrc98                           := glrc98;
		self.srcprop                          := srcprop;
		self.glrc9a                           := glrc9a;
		self.glrc9b                           := glrc9b;
		self.glrc9d                           := glrc9d;
		self.glrc9e                           := glrc9e;
		self.glrc9h                           := glrc9h;
		self.glrc9j                           := glrc9j;
		self.glrc9o                           := glrc9o;
		self.glrc9w                           := glrc9w;
		// self.glrc9y                           := glrc9y;
		self.glrcev                           := glrcev;
		self.glrcbl                           := glrcbl;
		self.rcvalue97_1                      := rcvalue97_1;
		self.rcvalue97                        := rcvalue97;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9a_1                      := rcvalue9a_1;
		self.rcvalue9a                        := rcvalue9a;
		self.rcvalue9b_1                      := rcvalue9b_1;
		self.rcvalue9b                        := rcvalue9b;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		self.rcvalue9e_1                      := rcvalue9e_1;
		self.rcvalue9e                        := rcvalue9e;
		self.rcvalue9h_1                      := rcvalue9h_1;
		self.rcvalue9h                        := rcvalue9h;
		self.rcvalue9j_1                      := rcvalue9j_1;
		self.rcvalue9j                        := rcvalue9j;
		self.rcvalue9o_1                      := rcvalue9o_1;
		self.rcvalue9o                        := rcvalue9o;
		self.rcvalue9w_1                      := rcvalue9w_1;
		self.rcvalue9w                        := rcvalue9w;
		// self.rcvalue9y_1                      := rcvalue9y_1;
		// self.rcvalue9y                        := rcvalue9y;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rc1                              := if(reasons[1].hri = '00', '', reasons[1].hri);
		self.rc2                              := if(reasons[2].hri = '00', '', reasons[2].hri);
		self.rc3                              := if(reasons[3].hri = '00', '', reasons[3].hri);
		self.rc4                              := if(reasons[4].hri = '00', '', reasons[4].hri);
		self.rc5                              := if(reasons[5].hri = '00', '', reasons[5].hri);
	#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
									SELF.hri := if(LEFT.hri='', '00', left.hri),
									SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
							));
		self.seq := le.seq;
		
		self.score := MAP(  reasons[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)reasons[1].hri + 10),
							reasons[1].hri = '35'                   => '100',
		                                                               (string3)RVG1404_1 );
END;

		model := project( clam, doModel(left) );

		return model;
END;