import risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1509_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons,
									boolean isFCRA=false) := FUNCTION
	
	FP_DEBUG := false;

	#if(FP_DEBUG)
    layout_debug := record
real           sysdate                                      ;
string         rv_s65_ssn_deceased                          ;
string         rv_s65_ssn_prior_dob                         ;
string         rv_s65_ssn_invalid                           ;
real           bureau_adl_eq_fseen_pos                      ;
string         bureau_adl_fseen_eq                          ;
real           _bureau_adl_fseen_eq                         ;
real           bureau_adl_en_fseen_pos                      ;
string         bureau_adl_fseen_en                          ;
real           _bureau_adl_fseen_en                         ;
real           bureau_adl_ts_fseen_pos                      ;
string         bureau_adl_fseen_ts                          ;
real           _bureau_adl_fseen_ts                         ;
real           bureau_adl_tu_fseen_pos                      ;
string         bureau_adl_fseen_tu                          ;
real           _bureau_adl_fseen_tu                         ;
real           bureau_adl_tn_fseen_pos                      ;
string         bureau_adl_fseen_tn                          ;
real           _bureau_adl_fseen_tn                         ;
real           _src_bureau_adl_fseen_all                    ;
real           nf_m_bureau_adl_fs_all                       ;
real           rv_c14_addrs_15yr                            ;
string         rv_prop_owner_history                        ;
real           rv_a50_pb_average_dollars                    ;
string         nf_phone_ver_experian                        ;
real           iv_in001_estimated_income                    ;
real           nf_hh_lienholders                            ;
real           nf_hh_college_attendees                      ;
real           nf_rel_count                                 ;
real           nf_closest_rel_criminal                      ;
string         nf_fp_validationrisktype                     ;
real           nf_fp_corrphonelastnamecount                 ;
real           _subscore0                                   ;
real           _subscore1                                   ;
real           _subscore2                                   ;
real           _subscore3                                   ;
real           _subscore4                                   ;
real           _subscore5                                   ;
real           _subscore6                                   ;
real           _subscore7                                   ;
real           _subscore8                                   ;
real           _subscore9                                   ;
real           _subscore10                                  ;
real           _subscore11                                  ;
real           _rawscore                                    ;
real           _lnoddsscore                                 ;
real           _probscore                                   ;
real           base                                         ;
real           odds                                         ;
real           point                                        ;
real           fp1509_1_0                                   ;
				models.layout_modelout;
				risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri ) := TRANSFORM
  #end

		truedid                          := le.truedid;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_hrisksic                      := le.iid.hrisksic;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	phone_ver_experian               := le.Experian_Phone_Verification;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	pb_average_dollars               := le.ibehavior.average_amount_per_order;
	fp_validationrisktype            := le.fdattributesv2.validationrisklevel;
	fp_corrphonelastnamecount        := le.fdattributesv2.correlationphonelastnamecount;
	hh_lienholders                   := le.hhid_summary.hh_lienholders;
	hh_college_attendees             := le.hhid_summary.hh_college_attendees;
	rel_count                        := le.relatives.relative_count;
	crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
	crim_rel_within100miles          := le.relatives.criminal_relative_within100miles;
	crim_rel_within500miles          := le.relatives.criminal_relative_within500miles;
	crim_rel_withinother             := le.relatives.criminal_relative_withinother;
	estimated_income                 := le.estimated_income;

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

rv_s65_ssn_deceased := map(
    not(truedid or (integer)ssnlength > 0)                                          => ' ',
    (integer)rc_decsflag = 1                                                        => '1',
    rc_ssndod != 0                                                                  => '1',
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0          => '2',
    (integer)rc_decsflag = 0                                                        => '0',
                                                                              ' ');

rv_s65_ssn_prior_dob := map(
    not((integer)ssnlength > 0 and dobpop)            => ' ',
    (integer)rc_ssndobflag = 1 or (integer)rc_pwssndobflag = 1 => '1',
    (integer)rc_ssndobflag = 0 or (integer)rc_pwssndobflag = 0 => '0',
                                                ' ');

rv_s65_ssn_invalid := map(
    not((integer)ssnlength > 0)                                                                                 => ' ',
    (integer)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => '1',
    (integer)rc_ssnvalflag = 0 or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => '0',
                                                                                                          ' ');

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

bureau_adl_en_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EN' , ',', 'E');

bureau_adl_fseen_en := if(bureau_adl_en_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_en_fseen_pos, ','));

_bureau_adl_fseen_en := common.sas_date((string)(bureau_adl_fseen_en));

bureau_adl_ts_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TS' , ',', 'E');

bureau_adl_fseen_ts := if(bureau_adl_ts_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_ts_fseen_pos, ','));

_bureau_adl_fseen_ts := common.sas_date((string)(bureau_adl_fseen_ts));

bureau_adl_tu_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TU' , ',', 'E');

bureau_adl_fseen_tu := if(bureau_adl_tu_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tu_fseen_pos, ','));

_bureau_adl_fseen_tu := common.sas_date((string)(bureau_adl_fseen_tu));

bureau_adl_tn_fseen_pos := Models.Common.findw_cpp(ver_sources, 'TN' , ',', 'E');

bureau_adl_fseen_tn := if(bureau_adl_tn_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_tn_fseen_pos, ','));

_bureau_adl_fseen_tn := common.sas_date((string)(bureau_adl_fseen_tn));

_src_bureau_adl_fseen_all := min(if(_bureau_adl_fseen_tn = NULL, -NULL, _bureau_adl_fseen_tn), if(_bureau_adl_fseen_ts = NULL, -NULL, _bureau_adl_fseen_ts), if(_bureau_adl_fseen_tu = NULL, -NULL, _bureau_adl_fseen_tu), if(_bureau_adl_fseen_en = NULL, -NULL, _bureau_adl_fseen_en), if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

nf_m_bureau_adl_fs_all := map(
    not(truedid)                       => NULL,
    _src_bureau_adl_fseen_all = 999999 => -1,
                                          if ((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen_all) / (365.25 / 12))));

rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

rv_prop_owner_history := map(
    not(truedid)                                                                     => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or property_owned_total > 0          => 'CURRENT',
    add_prev_naprop = 4 or Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E') > 0 => 'HISTORICAL',
                                                                                        'NEVER');

rv_a50_pb_average_dollars := map(
    not(truedid)              => NULL,
    pb_average_dollars = '' => -1,
                                 (integer)pb_average_dollars);

nf_phone_ver_experian := if(not(truedid), '', trim(phone_ver_experian, LEFT));

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

nf_hh_lienholders := if(not(truedid), NULL, min(if(hh_lienholders = NULL, -NULL, hh_lienholders), 999));

nf_hh_college_attendees := if(not(truedid), NULL, min(if(hh_college_attendees = NULL, -NULL, hh_college_attendees), 999));

nf_rel_count := if(not(truedid), NULL, min(if(rel_count = NULL, -NULL, rel_count), 999));

nf_closest_rel_criminal := map(
    not(truedid)                => NULL,
    rel_count = 0               => -1,
    crim_rel_within25miles > 0  => 25,
    crim_rel_within100miles > 0 => 100,
    crim_rel_within500miles > 0 => 500,
    crim_rel_withinOther > 0    => 1000,
                                   0);

nf_fp_validationrisktype := map(
    not(truedid)                 => '',
    fp_validationrisktype = ''   => '',
                                    fp_validationrisktype);

nf_fp_corrphonelastnamecount := if(not(truedid), NULL, min(if(fp_corrphonelastnamecount = '', -NULL, (integer)fp_corrphonelastnamecount), 999));

_subscore0 := map(
    NULL < nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 1   => 0,
    1 <= nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 185   => 0.812923,
    185 <= nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 245 => 0.525363,
    245 <= nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 309 => -0.151666,
    309 <= nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 327 => -0.375931,
    327 <= nf_m_bureau_adl_fs_all AND nf_m_bureau_adl_fs_all < 397 => -0.570733,
    397 <= nf_m_bureau_adl_fs_all                                  => -0.91339,
                                                                      0);

_subscore1 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 19999   => 0,
    19999 <= iv_in001_estimated_income AND iv_in001_estimated_income < 36000 => 0.522791,
    36000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 42000 => 0.209815,
    42000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 63000 => 0.116764,
    63000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 83000 => -0.121733,
    83000 <= iv_in001_estimated_income AND iv_in001_estimated_income < 95000 => -0.383303,
    95000 <= iv_in001_estimated_income                                       => -0.830399,
                                                                                0);

_subscore2 := map(
    (nf_phone_ver_experian in [' '])  => 0,
    (nf_phone_ver_experian in ['-1']) => 0,
    (nf_phone_ver_experian in ['0'])  => -0.301578,
    (nf_phone_ver_experian in ['1'])  => 0.787893,
                                         0);

_subscore3 := map(
    (rv_prop_owner_history in [' '])          => 0,
    (rv_prop_owner_history in ['CURRENT'])    => -0.259452,
    (rv_prop_owner_history in ['HISTORICAL']) => 0.215388,
    (rv_prop_owner_history in ['NEVER'])      => 0.603501,
                                                 0);

_subscore4 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => -0.456902,
    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => -0.333651,
    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 4   => 0.200065,
    4 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 7   => 0.308408,
    7 <= rv_c14_addrs_15yr                             => 0.51722,
                                                          0);

_subscore5 := map(
    NULL < nf_hh_lienholders AND nf_hh_lienholders < 1 => -0.285615,
    1 <= nf_hh_lienholders AND nf_hh_lienholders < 2   => 0.184192,
    2 <= nf_hh_lienholders                             => 0.551887,
                                                          0);

_subscore6 := map(
    NULL < nf_fp_corrphonelastnamecount AND nf_fp_corrphonelastnamecount < 1 => -0.152589,
    1 <= nf_fp_corrphonelastnamecount                                        => 0.526302,
                                                                                0);

_subscore7 := map(
    NULL < nf_hh_college_attendees AND nf_hh_college_attendees < 1 => 0.1252,
    1 <= nf_hh_college_attendees AND nf_hh_college_attendees < 2   => -0.129424,
    2 <= nf_hh_college_attendees                                   => -0.981003,
                                                                      0);

_subscore8 := map(
    NULL < nf_rel_count AND nf_rel_count < 7 => -0.287695,
    7 <= nf_rel_count AND nf_rel_count < 12  => -0.033484,
    12 <= nf_rel_count AND nf_rel_count < 17 => 0.031548,
    17 <= nf_rel_count                       => 0.435623,
                                                0);

_subscore9 := map(
    (nf_fp_validationrisktype in [' '])                                          => 0,
    (nf_fp_validationrisktype in ['1'])                                          => 0.106473,
    (nf_fp_validationrisktype in ['2', '3', '4', '5', '6', '7', '8', '9', '10']) => -0.337282,
                                                                                    0);

_subscore10 := map(
    NULL < rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 0 => 0,
    0 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 16  => 0.481248,
    16 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 46 => 0.122868,
    46 <= rv_a50_pb_average_dollars AND rv_a50_pb_average_dollars < 95 => -0.035559,
    95 <= rv_a50_pb_average_dollars                                    => -0.3362,
                                                                          0);

_subscore11 := map(
    NULL < nf_closest_rel_criminal AND nf_closest_rel_criminal < 0   => 0,
    0 <= nf_closest_rel_criminal AND nf_closest_rel_criminal < 25    => -0.07171,
    25 <= nf_closest_rel_criminal AND nf_closest_rel_criminal < 100  => 0.138494,
    100 <= nf_closest_rel_criminal AND nf_closest_rel_criminal < 500 => 0.092163,
    500 <= nf_closest_rel_criminal                                   => -0.320703,
                                                                        0);

_rawscore := _subscore0 +
    _subscore1 +
    _subscore2 +
    _subscore3 +
    _subscore4 +
    _subscore5 +
    _subscore6 +
    _subscore7 +
    _subscore8 +
    _subscore9 +
    _subscore10 +
    _subscore11;

_lnoddsscore := _rawscore + 0.424195;

_probscore := exp(_lnoddsscore) / (1 + exp(_lnoddsscore));

base := 530;

odds := (1 - 0.3938) / 0.3938;

point := 40;

fp1509_1_0_4 := min(if(max(round(point * (_lnoddsscore - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(point * (_lnoddsscore - ln(odds)) / ln(2) + base), 300)), 999);

fp1509_1_0_3 := if(rv_s65_ssn_deceased = '1' or rv_s65_ssn_deceased = '2', min(if(fp1509_1_0_4 = NULL, -NULL, fp1509_1_0_4), 300), fp1509_1_0_4);

fp1509_1_0_2 := if(rv_s65_ssn_prior_dob = '1', min(if(fp1509_1_0_3 = NULL, -NULL, fp1509_1_0_3), 300), fp1509_1_0_3);

fp1509_1_0_1 := if((integer)rc_hrisksic = 2225, min(if(fp1509_1_0_2 = NULL, -NULL, fp1509_1_0_2), 300), fp1509_1_0_2);

fp1509_1_0 := if(rv_s65_ssn_invalid = '1', min(if(fp1509_1_0_1 = NULL, -NULL, fp1509_1_0_1), 300), fp1509_1_0_1);


//Intermediate variables

#if(FP_DEBUG)
	                  self.clam															:= le;
                    self.sysdate                          := sysdate;
                    self.rv_s65_ssn_deceased              := rv_s65_ssn_deceased;
                    self.rv_s65_ssn_prior_dob             := rv_s65_ssn_prior_dob;
                    self.rv_s65_ssn_invalid               := rv_s65_ssn_invalid;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self.bureau_adl_en_fseen_pos          := bureau_adl_en_fseen_pos;
                    self.bureau_adl_fseen_en              := bureau_adl_fseen_en;
                    self._bureau_adl_fseen_en             := _bureau_adl_fseen_en;
                    self.bureau_adl_ts_fseen_pos          := bureau_adl_ts_fseen_pos;
                    self.bureau_adl_fseen_ts              := bureau_adl_fseen_ts;
                    self._bureau_adl_fseen_ts             := _bureau_adl_fseen_ts;
                    self.bureau_adl_tu_fseen_pos          := bureau_adl_tu_fseen_pos;
                    self.bureau_adl_fseen_tu              := bureau_adl_fseen_tu;
                    self._bureau_adl_fseen_tu             := _bureau_adl_fseen_tu;
                    self.bureau_adl_tn_fseen_pos          := bureau_adl_tn_fseen_pos;
                    self.bureau_adl_fseen_tn              := bureau_adl_fseen_tn;
                    self._bureau_adl_fseen_tn             := _bureau_adl_fseen_tn;
                    self._src_bureau_adl_fseen_all        := _src_bureau_adl_fseen_all;
                    self.nf_m_bureau_adl_fs_all           := nf_m_bureau_adl_fs_all;
                    self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
                    self.rv_prop_owner_history            := rv_prop_owner_history;
                    self.rv_a50_pb_average_dollars        := rv_a50_pb_average_dollars;
                    self.nf_phone_ver_experian            := nf_phone_ver_experian;
                    self.iv_in001_estimated_income        := iv_in001_estimated_income;
                    self.nf_hh_lienholders                := nf_hh_lienholders;
                    self.nf_hh_college_attendees          := nf_hh_college_attendees;
                    self.nf_rel_count                     := nf_rel_count;
                    self.nf_closest_rel_criminal          := nf_closest_rel_criminal;
                    self.nf_fp_validationrisktype         := nf_fp_validationrisktype;
                    self.nf_fp_corrphonelastnamecount     := nf_fp_corrphonelastnamecount;
                    self._subscore0                       := _subscore0;
                    self._subscore1                       := _subscore1;
                    self._subscore2                       := _subscore2;
                    self._subscore3                       := _subscore3;
                    self._subscore4                       := _subscore4;
                    self._subscore5                       := _subscore5;
                    self._subscore6                       := _subscore6;
                    self._subscore7                       := _subscore7;
                    self._subscore8                       := _subscore8;
                    self._subscore9                       := _subscore9;
                    self._subscore10                      := _subscore10;
                    self._subscore11                      := _subscore11;
                    self._rawscore                        := _rawscore;
                    self._lnoddsscore                     := _lnoddsscore;
                    self._probscore                       := _probscore;
                    self.base                             := base;
                    self.odds                             := odds;
                    self.point                            := point;
                    self.fp1509_1_0                       := fp1509_1_0;

#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1509_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1509_1_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.shell_input.st<>''
		and left.shell_input.county <>''
		and left.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;


