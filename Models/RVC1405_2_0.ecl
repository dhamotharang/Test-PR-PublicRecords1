import risk_indicators, riskwise, riskwisefcra, ut, riskview;

export RVC1405_2_0( grouped dataset(risk_indicators.Layout_Bocashell_with_Custom) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := False;

	#if(RVC_DEBUG)
		layout_debug := record
			INTEGER sysdate              ;
			Integer slc_num_rpc30        ;
			Integer slc_num_dnc30        ;
			Integer slc_num_outnoans30   ;
			Integer slc_num_regular_pmts ;
			Integer iv_ms001_ssns_per_adl;
			Integer iv_attr_addrs_recency;
			Integer iv_eviction_count    ;
			Integer iv_non_derog_count   ;
			Integer iv_liens_unrel_ft_ct ;
			Integer iv_pb_total_orders   ;
			Real ls_subscore0            ;
			Real ls_subscore1            ;
			Real ls_subscore2            ;
			Real ls_subscore3            ;
			Real ls_subscore4            ;
			Real ls_subscore5            ;
			Real ls_subscore6            ;
			Real ls_subscore7            ;
			Real ls_subscore8            ;
			Real ls_subscore9            ;
			Real ls_rawscore             ;
			Real ls_lnoddsscore          ;
			Real ls_probscore            ;
			Integer base                 ;
			Integer pts                  ;
			Real odds                    ;
			Boolean ssn_deceased         ;
			Boolean iv_riskview_222s     ;
			Integer rvc1405_2_0          ;
			Boolean glrc36               ;
			Boolean glrc98               ;
			Boolean glrc9d               ;
			// Boolean glrc9y               ;
			Boolean glrcms               ;
			Boolean glrcev               ;
			Boolean glrcbl               ;
			Real rcvalue36_1             ;
			Real rcvalue36               ;
			Real rcvalue98_1             ;
			Real rcvalue98               ;
			Real rcvalue9d_1             ;
			Real rcvalue9d               ;
			// Real rcvalue9y_1             ;
			// Real rcvalue9y               ;
			Real rcvaluems_1             ;
			Real rcvaluems               ;
			Real rcvalueev_1             ;
			Real rcvalueev               ;
			String rc1                   ;
			String rc4                   ;
			String rc2                   ;
			String rc3                   ;
			String rc5                   ;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	rpc30                            := le.custom_input1;
	dnc30                            := le.custom_input2;
	outnoans30                       := le.custom_input3;
	num_good_prior                   := le.custom_input4;
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	criminal_count                   := le.bjl.criminal_count;


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

slc_num_rpc30 := If(RPC30 = '', NULL, (Integer)RPC30);

slc_num_dnc30 := If(DNC30 = '', NULL, (Integer)DNC30);

slc_num_outnoans30 := If(OutNoAns30 = '', NULL, (Integer)OutNoAns30);

slc_num_regular_pmts := If(num_good_prior = '', NULL, (Integer)num_good_prior);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_attr_addrs_recency := map(
    not(truedid)               => NULL,
    (Boolean)attr_addrs_last30 => 1,
    (Boolean)attr_addrs_last90 => 3,
    (Boolean)attr_addrs_last12 => 12,
    (Boolean)attr_addrs_last24 => 24,
    (Boolean)attr_addrs_last36 => 36,
    (Boolean)addrs_5yr         => 60,
    (Boolean)addrs_10yr        => 120,
    (Boolean)addrs_15yr        => 180,
    addrs_per_adl > 0          => 999,
                                  0);

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_non_derog_count := if(not(truedid), NULL, attr_num_nonderogs);

iv_liens_unrel_ft_ct := if(not(truedid), NULL, liens_unrel_FT_ct);

iv_pb_total_orders := map(
    not(truedid)           => NULL,
    pb_total_orders = ''   => -1,
                              (Integer)pb_total_orders);

ls_subscore0 := map(
    NULL < slc_num_rpc30 AND slc_num_rpc30 < 1 => -0.176505,
    1 <= slc_num_rpc30 AND slc_num_rpc30 < 2   => 0.100457,
    2 <= slc_num_rpc30 AND slc_num_rpc30 < 4   => 0.21696,
    4 <= slc_num_rpc30                         => 0.375001,
                                                  0);

ls_subscore1 := map(
    NULL < slc_num_regular_pmts AND slc_num_regular_pmts < 1 => -0.266984,
    1 <= slc_num_regular_pmts AND slc_num_regular_pmts < 2   => 0.0059,
    2 <= slc_num_regular_pmts                                => 0.102724,
                                                                0);

ls_subscore2 := map(
    NULL < slc_num_dnc30 AND slc_num_dnc30 < 1 => 0.059298,
    1 <= slc_num_dnc30                         => -0.274778,
                                                  0);

ls_subscore3 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.150151,
    1 <= iv_pb_total_orders AND iv_pb_total_orders < 2   => -0.037448,
    2 <= iv_pb_total_orders AND iv_pb_total_orders < 8   => 0.062649,
    8 <= iv_pb_total_orders                              => 0.171876,
                                                            0);

ls_subscore4 := map(
    (iv_attr_addrs_recency in [1, 3])     => -0.233941,
    (iv_attr_addrs_recency in [12])       => -0.113431,
    (iv_attr_addrs_recency in [24, 36])   => -0.011264,
    (iv_attr_addrs_recency in [60, 120])  => 0.049467,
    (iv_attr_addrs_recency in [180, 999]) => 0.086205,
                                             0);

ls_subscore5 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 2 => 0.039221,
    2 <= iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3   => 0.003803,
    3 <= iv_ms001_ssns_per_adl                                 => -0.261668,
                                                                  0);

ls_subscore6 := map(
    NULL < iv_non_derog_count AND iv_non_derog_count < 3 => -0.155365,
    3 <= iv_non_derog_count AND iv_non_derog_count < 5   => 0.026864,
    5 <= iv_non_derog_count                              => 0.191903,
                                                            0);

ls_subscore7 := map(
    NULL < slc_num_outnoans30 AND slc_num_outnoans30 < 1 => 0.014202,
    1 <= slc_num_outnoans30                              => -0.260687,
                                                            0);

ls_subscore8 := map(
    NULL < iv_liens_unrel_ft_ct AND iv_liens_unrel_ft_ct < 1 => 0.006386,
    1 <= iv_liens_unrel_ft_ct                                => -0.119116,
                                                                0);

ls_subscore9 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.017665,
    1 <= iv_eviction_count                             => -0.139815,
                                                          0);

ls_rawscore := ls_subscore0 +
    ls_subscore1 +
    ls_subscore2 +
    ls_subscore3 +
    ls_subscore4 +
    ls_subscore5 +
    ls_subscore6 +
    ls_subscore7 +
    ls_subscore8 +
    ls_subscore9;

ls_lnoddsscore := ls_rawscore + -1.196543;

ls_probscore := exp(ls_lnoddsscore) / (1 + exp(ls_lnoddsscore));

base := 700;

pts := 40;

odds := 0.23 / (1 - 0.23);

ssn_deceased := (Integer)rc_decsflag = 1 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0;

iv_riskview_222s := riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid);

rvc1405_2_0 := map(
    ssn_deceased     => 200,
    iv_riskview_222s => 222,
                        min(if(max(round(pts * (ls_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ls_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));

rc5_2 := '';

glrc36 := attr_num_nonderogs < 5;

glrc98 := liens_unrel_FT_ct > 0;

glrc9d := unique_addr_count > 1;

// glrc9y := pb_total_orders = '';

glrcms := ssns_per_adl > 2;

glrcev := attr_eviction_count > 0;

glrcbl := 0;

rcvalue36_1 := (integer)glrc36 * (0.191903 - ls_subscore6);

rcvalue36 := if(max(rcvalue36_1) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1)));

rcvalue98_1 := (integer)glrc98 * (0.006386 - ls_subscore8);

rcvalue98 := if(max(rcvalue98_1) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1)));

rcvalue9d_1 := (integer)glrc9d * (0.086205 - ls_subscore4);

rcvalue9d := if(max(rcvalue9d_1) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1)));

// rcvalue9y_1 := (integer)glrc9y * (0.171876 - ls_subscore3);

// rcvalue9y := if(max(rcvalue9y_1) = NULL, NULL, sum(if(rcvalue9y_1 = NULL, 0, rcvalue9y_1)));

rcvaluems_1 := (integer)glrcms * (0.039221 - ls_subscore5);

rcvaluems := if(max(rcvaluems_1) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1)));

rcvalueev_1 := (integer)glrcev * (0.017665 - ls_subscore9);

rcvalueev := if(max(rcvalueev_1) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1)));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
rc_dataset := DATASET([
    {'36', RCValue36},
    {'98', RCValue98},
    {'9D', RCValue9D},
    // {'9Y', RCValue9Y},
    {'MS', RCValueMS},
    {'EV', RCValueEV}
    ], ds_layout)(value > 0);

rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := if(rcs_top4[1].rc = '', ROW({'36', NULL}, ds_layout), rcs_top4[1]);
rcs_9p2 := MAP(rcs_9p1.rc != '36' AND rcs_top4[2].rc = '' and 500 < rvc1405_2_0 AND rvc1405_2_0 <= 720 => ROW({'36', NULL}, ds_layout),
               rcs_9p1.rc = '36' AND rcs_top4[2].rc = '' and 500 < rvc1405_2_0 AND rvc1405_2_0 <= 720 => ROW({'9E ', NULL}, ds_layout),
               rcs_top4[2]);
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
	
rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4;

rcs_override := MAP( rvc1405_2_0 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvc1405_2_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     rvc1405_2_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
                     NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
                     rcs_9p);
										 
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 4); // Keep up to 4 reason codes


//Intermediate variables

	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;
		self.slc_num_rpc30                    := slc_num_rpc30;
		self.slc_num_dnc30                    := slc_num_dnc30;
		self.slc_num_outnoans30               := slc_num_outnoans30;
		self.slc_num_regular_pmts             := slc_num_regular_pmts;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.iv_attr_addrs_recency            := iv_attr_addrs_recency;
		self.iv_eviction_count                := iv_eviction_count;
		self.iv_non_derog_count               := iv_non_derog_count;
		self.iv_liens_unrel_ft_ct             := iv_liens_unrel_ft_ct;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.ls_subscore0                     := ls_subscore0;
		self.ls_subscore1                     := ls_subscore1;
		self.ls_subscore2                     := ls_subscore2;
		self.ls_subscore3                     := ls_subscore3;
		self.ls_subscore4                     := ls_subscore4;
		self.ls_subscore5                     := ls_subscore5;
		self.ls_subscore6                     := ls_subscore6;
		self.ls_subscore7                     := ls_subscore7;
		self.ls_subscore8                     := ls_subscore8;
		self.ls_subscore9                     := ls_subscore9;
		self.ls_rawscore                      := ls_rawscore;
		self.ls_lnoddsscore                   := ls_lnoddsscore;
		self.ls_probscore                     := ls_probscore;
		self.base                             := base;
		self.pts                              := pts;
		self.odds                             := odds;
		self.ssn_deceased                     := ssn_deceased;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.rvc1405_2_0                      := rvc1405_2_0;
		self.glrc36                           := glrc36;
		self.glrc98                           := glrc98;
		self.glrc9d                           := glrc9d;
		// self.glrc9y                           := glrc9y;
		self.glrcms                           := glrcms;
		self.glrcev                           := glrcev;
		self.glrcbl                           := glrcbl;
		self.rcvalue36_1                      := rcvalue36_1;
		self.rcvalue36                        := rcvalue36;
		self.rcvalue98_1                      := rcvalue98_1;
		self.rcvalue98                        := rcvalue98;
		self.rcvalue9d_1                      := rcvalue9d_1;
		self.rcvalue9d                        := rcvalue9d;
		// self.rcvalue9y_1                      := rcvalue9y_1;
		// self.rcvalue9y                        := rcvalue9y;
		self.rcvaluems_1                      := rcvaluems_1;
		self.rcvaluems                        := rcvaluems;
		self.rcvalueev_1                      := rcvalueev_1;
		self.rcvalueev                        := rcvalueev;
		self.rc1                              := rcs_override[1].rc;
		self.rc2                              := rcs_override[2].rc;
		self.rc3                              := rcs_override[3].rc;
		self.rc4                              := rcs_override[4].rc;
		self.rc5                              := rcs_override[5].rc;
		#end
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := if(LEFT.hri='', '00', left.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.seq := le.seq;
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1405_2_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;