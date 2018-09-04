/************************************************************************************
 * RVC1805.1.0                       Version 00                               BY AO *
 * Phillips & Cohen Custom Payment Score for Collections                 07/25/2018 *
 ************************************************************************************
 ************************************************************************************
 * Returns the following fields - RVC1805_1_0, rc1, rc2, rc3, rc4, rc5              *
 ************************************************************************************
 ************************************************************************************
 * Model Edits:                                                                     *
 *  AO - 07/25/2018 - Initial Release                                               *
 ************************************************************************************
 ************************************************************************************
 * Model Requirements:                                                              *
 *  Fields from ADL FCRA 4.1 Modeling Shell                                         *
 ************************************************************************************
 * ECL Developer: Jack Francis Jr                                        08/15/2018 *
 ************************************************************************************/

IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators;

EXPORT rvc1805_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, Boolean isCalifornia = False) := FUNCTION

	MODEL_DEBUG := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
      unsigned  seq;
      Integer	 sysdate;
      String	 iv_add_apt;
      String	 iv_criminal_x_felony;
      String	 iv_db001_bankruptcy;
      integer	 iv_attr_bankruptcy_recency;
      integer	 _gong_did_last_seen;
      integer	 iv_mos_since_gong_did_lst_seen;
      Integer	 prop_adl_p_lseen_pos;
      String	 prop_adl_lseen_p;
      Integer	 _prop_adl_lseen_p;
      Integer	 _src_prop_adl_lseen;
      Integer	 iv_mos_src_property_adl_lseen;
      integer	 iv_all_email_domain_isp;
      integer	 iv_avg_lres;
      integer	 iv_ssns_per_sfd_addr;
      integer	 iv_prop_owned_purchase_count;
      integer	 iv_pv001_inp_avm_autoval;
      Integer	 iv_ms001_ssns_per_adl;
      String	 iv_rec_vehx_level;
      Real     co_v01_w;
      Real  	 co_aa_dist_01;
      String	 co_aa_code_01;
      Real  	 co_v02_w;
      Real  	 co_aa_dist_02;
      String	 co_aa_code_02;
      Real  	 co_v03_w;
      Real  	 co_aa_dist_03;
      String	 co_aa_code_03;
      Real  	 co_v04_w;
      Real  	 co_aa_dist_04;
      String	 co_aa_code_04;
      Real  	 co_v05_w;
      Real  	 co_aa_dist_05;
      String	 co_aa_code_05;
      Real  	 co_v06_w;
      Real  	 co_aa_dist_06;
      String	 co_aa_code_06;
      Real  	 co_v07_w;
      Real  	 co_aa_dist_07;
      String	 co_aa_code_07;
      Real  	 co_v08_w;
      Real  	 co_aa_dist_08;
      String	 co_aa_code_08;
      Real  	 co_v09_w;
      Real  	 co_aa_dist_09;
      String	 co_aa_code_09;
      Real  	 co_v10_w;
      Real  	 co_aa_dist_10;
      String	 co_aa_code_10;
      Real  	 co_v11_w;
      Real  	 co_aa_dist_11;
      String	 co_aa_code_11;
      Real  	 co_v12_w;
      Real  	 co_aa_dist_12;
      String	 co_aa_code_12;
      Real  	 co_v13_w;
      Real  	 co_aa_dist_13;
      Real  	 co_rcvalue9k;
      Real  	 co_rcvalue27;
      Real  	 co_rcvaluepv;
      Real  	 co_rcvalue9a;
      Real  	 co_rcvalue9c;
      Real  	 co_rcvalue9f;
      Real  	 co_rcvalue97;
      Real  	 co_rcvaluems;
      Real  	 co_rcvalue9r;
      Real  	 co_rcvalue9w;
      Real  	 co_lgt;
      String	 r_rc1;
      String	 r_rc2;
      String	 r_rc3;
      String	 r_rc4;
      String	 r_rc5;
      String	 r_rc6;
      String	 r_rc7;
      String	 r_rc8;
      String	 r_rc9;
      String	 r_rc10;
      String	 r_rc11;
      String	 r_rc12;
      String	 r_rc13;
      Real	 r_vl1;
      Real	 r_vl2;
      Real	 r_vl3;
      Real	 r_vl4;
      Real	 r_vl5;
      Real	 r_vl6;
      Real	 r_vl7;
      Real	 r_vl8;
      Real	 r_vl9;
      Real	 r_vl10;
      Real	 r_vl11;
      Real	 r_vl12;
      Real	 r_vl13;
      String	 _rc_inq;
      Boolean	 iv_rv5_deceased;
      integer	 iv_rv5_unscorable;
      integer	 base;
      Integer	 pts;
      real     lgt;
      integer	 rvc1805_1_0;
      String	 rc5;
      String	 rc1;
      String	 rc3;
      String	 rc2;
      String	 rc4;


			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	in_hphnpop_found                 := le.adl_shell_flags.in_hphnpop_found;
  // in_hphnpop                    := le.adl_shell_flags.in_hphnpop;
  // in_addrpop_found              := le.adl_shell_flags.in_addrpop_found;
  // in_addrpop                    := le.adl_shell_flags.in_addrpop;
  // in_ssnpop                     := le.adl_shell_flags.in_ssnpop;
  // in_dobpop                     := le.adl_shell_flags.in_dobpop;
  // adl_addr                      := le.adl_shell_flags.adl_addr;
  // adl_hphn                      := le.adl_shell_flags.adl_hphn;
  // adl_ssn                       := le.adl_shell_flags.adl_ssn;
  // adl_dob                       := le.adl_shell_flags.adl_dob;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ssnlength                        := le.input_validation.ssn_length;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
	avg_lres                         := le.other_address_info.avg_lres;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	email_count                      := le.email_summary.email_ct;
	email_domain_isp_count           := le.email_summary.email_domain_isp_ct;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_bankruptcy_count30          := le.bjl.bk_count30;
	attr_bankruptcy_count90          := le.bjl.bk_count90;
	attr_bankruptcy_count180         := le.bjl.bk_count180;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_bankruptcy_count24          := le.bjl.bk_count24;
	attr_bankruptcy_count36          := le.bjl.bk_count36;
	attr_bankruptcy_count60          := le.bjl.bk_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));


iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), '1', '0');

iv_criminal_x_felony := if(not(truedid), '-1 ', trim((STRING)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + '-'+ trim((STRING)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                      => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0     => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');
iv_attr_bankruptcy_recency := map(
    not(truedid)                      => NULL,
    attr_bankruptcy_count30 >0        => 1,
    attr_bankruptcy_count90 >0        => 3,
    attr_bankruptcy_count180 >0       => 6,
    attr_bankruptcy_count12 >0        => 12,
    attr_bankruptcy_count24 >0        => 24,
    attr_bankruptcy_count36 >0        => 36,
    attr_bankruptcy_count60 >0        => 60,
    (rc_bansflag in ['1', '2'])       => 99,
    bankrupt                          => 99,
    contains_i(ver_sources, 'BA') > 0 => 99,
    filing_count > 0                  => 99,
    bk_recent_count > 0               => 99,
                                         0);

_gong_did_last_seen := common.sas_date((string)(gong_did_last_seen));

iv_mos_since_gong_did_lst_seen_1 := if(not(truedid), NULL, NULL);

iv_mos_since_gong_did_lst_seen := if(not(_gong_did_last_seen = NULL), if ((sysdate - _gong_did_last_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_last_seen) / (365.25 / 12))), -1);

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

iv_all_email_domain_isp := if(not(truedid), NULL, (integer)(email_count = email_domain_ISP_count) * min(if(email_count = NULL, -NULL, email_count), 5));

iv_avg_lres := if(not(truedid), NULL, avg_lres);

iv_ssns_per_sfd_addr := map(
    not(add1_pop)    => NULL,
    iv_add_apt = '1' => -1,
                        ssns_per_addr);

iv_prop_owned_purchase_count := if(not(truedid or add1_pop), NULL, property_owned_purchase_count);

iv_pv001_inp_avm_autoval := if(not(add1_pop), NULL, add1_avm_automated_valuation);

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

iv_rec_vehx_level := map(
    not(truedid)                                   => '-1',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => 'W' + (string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3),
                                                      'XX');

co_v01_w := map(
    iv_criminal_x_felony = ''                                                               => 0,
    (iv_criminal_x_felony in ['0-1'])                                                          => 0,
    (iv_criminal_x_felony in ['0-0'])                                                         => 0.348124396893805,
    (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => -0.334558216661938,
                                                                                                 0);

co_aa_code_01_1 := map(
    (iv_criminal_x_felony = '')                                                               => '',
    (iv_criminal_x_felony in ['0-1'])                                                          => '97',
    (iv_criminal_x_felony in ['0-0'])                                                         => '97',
    (iv_criminal_x_felony in ['1-0', '1-1', '2-0', '2-1', '2-2', '3-0', '3-1', '3-2', '3-3']) => '97',
                                                                                                 '97');

co_aa_dist_01 := 0.348124396893805 - co_v01_w;

co_aa_code_01 := if(co_aa_dist_01 = 0, '', co_aa_code_01_1);

co_v02_w := map(
    iv_db001_bankruptcy = ''                                                  => 0,
    (iv_db001_bankruptcy in ['-1'])                                             => 0,
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => 0.336235530940616,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => -0.317128928269346,
                                                                                   0);

co_aa_code_02_1 := map(
    iv_db001_bankruptcy = ''                                                  => '',
    (iv_db001_bankruptcy in ['-1'])                                             => '',
    (iv_db001_bankruptcy in ['0 - No BK', '1 - BK Discharged', '3 - BK Other']) => '9W',
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                               => '9W',
                                                                                   '9W');

co_aa_dist_02 := 0.336235530940616 - co_v02_w;

co_aa_code_02 := if(co_aa_dist_02 = 0, '', co_aa_code_02_1);

co_v03_w := map(
    iv_attr_bankruptcy_recency = NULL  => 0,
    iv_attr_bankruptcy_recency = -1    => 0,
    iv_attr_bankruptcy_recency <= 9    => -0.193438375079065,
    iv_attr_bankruptcy_recency <= 79.5 => 0.0740275690391025,
                                          0.236644094178001);

co_aa_code_03_1 := map(
    iv_attr_bankruptcy_recency = NULL  => '',
    iv_attr_bankruptcy_recency = -1    => '',
    iv_attr_bankruptcy_recency <= 9    => '',
    iv_attr_bankruptcy_recency <= 79.5 => '',
                                          '');

co_aa_dist_03 := 0.236644094178001 - co_v03_w;

co_aa_code_03 := if(co_aa_dist_03 = 0, '', co_aa_code_03_1);

co_v04_w := map(
    in_hphnpop_found = NULL => 0,
    in_hphnpop_found = -1   => 0,
    in_hphnpop_found <= 0.5 => -0.19226880194992,
                               0.19232949361223);

co_aa_code_04_1 := map(
    in_hphnpop_found = NULL => '',
    in_hphnpop_found = -1   => '27',
    in_hphnpop_found <= 0.5 => '27',
                               '27');

co_aa_dist_04 := 0.19232949361223 - co_v04_w;

co_aa_code_04 := if(co_aa_dist_04 = 0, '', co_aa_code_04_1);

co_v05_w := map(
    iv_mos_since_gong_did_lst_seen = NULL  => 0,
    iv_mos_since_gong_did_lst_seen = -1    => -0.0056319653159539,
    iv_mos_since_gong_did_lst_seen <= 3    => 0.244135695591346,
    iv_mos_since_gong_did_lst_seen <= 93.5 => 0.0158296309554997,
                                              -0.267905572010172);

co_aa_code_05_1 := map(
    iv_mos_since_gong_did_lst_seen = NULL  => '',
    iv_mos_since_gong_did_lst_seen = -1    => '9R',
    iv_mos_since_gong_did_lst_seen <= 3    => '9R',
    iv_mos_since_gong_did_lst_seen <= 93.5 => '9R',
                                              '9R');

co_aa_dist_05 := 0.244135695591346 - co_v05_w;

co_aa_code_05 := if(co_aa_dist_05 = 0, '', co_aa_code_05_1);

co_v06_w := map(
    iv_mos_src_property_adl_lseen = NULL  => 0,
    iv_mos_src_property_adl_lseen = -1    => -0.0216147460538224,
    iv_mos_src_property_adl_lseen <= 6.5  => 0.524295663543627,
    iv_mos_src_property_adl_lseen <= 90.5 => 0.10782133117742,
                                             -0.164086360133371);

co_aa_code_06_1 := map(
    iv_mos_src_property_adl_lseen = NULL  => '',
    iv_mos_src_property_adl_lseen = -1    => '9A',
    iv_mos_src_property_adl_lseen <= 6.5  => '9F',
    iv_mos_src_property_adl_lseen <= 90.5 => '9F',
                                             '9F');

co_aa_dist_06 := 0.524295663543627 - co_v06_w;

co_aa_code_06 := if(co_aa_dist_06 = 0, '', co_aa_code_06_1);

co_v07_w := map(
    iv_all_email_domain_isp = NULL => 0,
    iv_all_email_domain_isp = -1   => 0,
    iv_all_email_domain_isp <= 0.5 => -0.175006542888867,
                                      0.181906108502103);

co_aa_code_07_1 := map(
    iv_all_email_domain_isp = NULL => '',
    iv_all_email_domain_isp = -1   => '',
    iv_all_email_domain_isp <= 0.5 => '',
                                      '');

co_aa_dist_07 := 0.181906108502103 - co_v07_w;

co_aa_code_07 := if(co_aa_dist_07 = 0, '', co_aa_code_07_1);

co_v08_w := map(
    iv_avg_lres = NULL   => 0,
    iv_avg_lres = -1     => 0,
    iv_avg_lres <= 25.5  => -0.315849969418153,
    iv_avg_lres <= 76.5  => -0.0589775857023227,
    iv_avg_lres <= 162.5 => 0.0239928623372677,
    iv_avg_lres <= 200.5 => 0.130465907177864,
    iv_avg_lres <= 270.5 => 0.253452806048125,
                            0.402634209067379);

co_aa_code_08_1 := map(
    iv_avg_lres = NULL   => '',
    iv_avg_lres = -1     => '9C',
    iv_avg_lres <= 25.5  => '9C',
    iv_avg_lres <= 76.5  => '9C',
    iv_avg_lres <= 162.5 => '9C',
    iv_avg_lres <= 200.5 => '9C',
    iv_avg_lres <= 270.5 => '9C',
                            '9C');

co_aa_dist_08 := 0.402634209067379 - co_v08_w;

co_aa_code_08 := if(co_aa_dist_08 = 0, '', co_aa_code_08_1);

co_v09_w := map(
    iv_ssns_per_sfd_addr = NULL  => 0,
    iv_ssns_per_sfd_addr = -1    => 0.0710782524561447,
    iv_ssns_per_sfd_addr <= 2.5  => 0.231018541906037,
    iv_ssns_per_sfd_addr <= 7.5  => 0.103084572955295,
    iv_ssns_per_sfd_addr <= 10.5 => 0.0896593210307617,
    iv_ssns_per_sfd_addr <= 12.5 => -0.0872422405844001,
    iv_ssns_per_sfd_addr <= 28.5 => -0.13960245427369,
                                    -0.267355224041506);

co_aa_code_09_1 := map(
    iv_ssns_per_sfd_addr = NULL  => '',
    iv_ssns_per_sfd_addr = -1    => '9K',
    iv_ssns_per_sfd_addr <= 2.5  => '',
    iv_ssns_per_sfd_addr <= 7.5  => '',
    iv_ssns_per_sfd_addr <= 10.5 => '',
    iv_ssns_per_sfd_addr <= 12.5 => '',
    iv_ssns_per_sfd_addr <= 28.5 => '',
                                    '');

co_aa_dist_09 := 0.231018541906037 - co_v09_w;

co_aa_code_09 := if(co_aa_dist_09 = 0, '', co_aa_code_09_1);

co_v10_w := map(
    iv_prop_owned_purchase_count = NULL => 0,
    iv_prop_owned_purchase_count = -1   => 0,
    iv_prop_owned_purchase_count <= 0.5 => -0.127640837114157,
                                           0.131408945621136);

co_aa_code_10_1 := map(
    iv_prop_owned_purchase_count = NULL => '',
    iv_prop_owned_purchase_count = -1   => '9A',
    iv_prop_owned_purchase_count <= 0.5 => '9A',
                                           '9A');

co_aa_dist_10 := 0.131408945621136 - co_v10_w;

co_aa_code_10 := if(co_aa_dist_10 = 0, '', co_aa_code_10_1);

co_v11_w := map(
    iv_pv001_inp_avm_autoval = NULL    => 0,
    iv_pv001_inp_avm_autoval = -1      => 0,
    iv_pv001_inp_avm_autoval <= 0      => 0,
    iv_pv001_inp_avm_autoval <= 183175 => -0.13791548947097,
    iv_pv001_inp_avm_autoval <= 247716 => 0.0911341797571892,
                                          0.202999252787701);

co_aa_code_11_1 := map(
    iv_pv001_inp_avm_autoval = NULL    => '',
    iv_pv001_inp_avm_autoval = -1      => 'PV',
    iv_pv001_inp_avm_autoval <= 0      => 'PV',
    iv_pv001_inp_avm_autoval <= 183175 => 'PV',
    iv_pv001_inp_avm_autoval <= 247716 => 'PV',
                                          'PV');

co_aa_dist_11 := 0.202999252787701 - co_v11_w;

co_aa_code_11 := if(co_aa_dist_11 = 0, '', co_aa_code_11_1);

co_v12_w := map(
    iv_ms001_ssns_per_adl = NULL => 0,
    iv_ms001_ssns_per_adl = -1   => 0,
    iv_ms001_ssns_per_adl <= 1.5 => 0.107084838087477,
    iv_ms001_ssns_per_adl <= 2.5 => -0.0750279661037746,
                                    -0.11658280326394);

co_aa_code_12_1 := map(
    iv_ms001_ssns_per_adl = NULL => '',
    iv_ms001_ssns_per_adl = -1   => 'MS',
    iv_ms001_ssns_per_adl <= 1.5 => 'MS',
    iv_ms001_ssns_per_adl <= 2.5 => 'MS',
                                    'MS');

co_aa_dist_12 := 0.107084838087477 - co_v12_w;

co_aa_code_12 := if(co_aa_dist_12 = 0, '', co_aa_code_12_1);

co_v13_w := map(
    iv_rec_vehx_level = ''                          => 0,
    (iv_rec_vehx_level in ['-1'])                   => 0,
    (iv_rec_vehx_level in ['AO', 'W1', 'W2', 'W3']) => 0.106809803383392,
    (iv_rec_vehx_level in ['XX'])                   => -0.0836215784371346,
                                                       0);

co_aa_dist_13 := 0.106809803383392 - co_v13_w;

co_rcvalue9k := (integer)(co_aa_code_01 = '9K') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9K') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9K') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9K') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9K') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9K') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9K') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9K') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9K') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9K') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9K') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9K') * co_aa_dist_12;

co_rcvalue27 := (integer)(co_aa_code_01 = '27') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '27') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '27') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '27') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '27') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '27') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '27') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '27') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '27') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '27') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '27') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '27') * co_aa_dist_12;

co_rcvaluepv := (integer)(co_aa_code_01 = 'PV') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = 'PV') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = 'PV') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = 'PV') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = 'PV') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = 'PV') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = 'PV') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = 'PV') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = 'PV') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = 'PV') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = 'PV') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = 'PV') * co_aa_dist_12;

co_rcvalue9a := (integer)(co_aa_code_01 = '9A') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9A') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9A') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9A') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9A') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9A') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9A') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9A') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9A') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9A') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9A') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9A') * co_aa_dist_12;

co_rcvalue9c := (integer)(co_aa_code_01 = '9C') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9C') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9C') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9C') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9C') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9C') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9C') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9C') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9C') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9C') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9C') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9C') * co_aa_dist_12;

co_rcvalue9f := (integer)(co_aa_code_01 = '9F') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9F') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9F') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9F') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9F') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9F') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9F') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9F') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9F') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9F') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9F') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9F') * co_aa_dist_12;

co_rcvalue97 := (integer)(co_aa_code_01 = '97') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '97') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '97') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '97') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '97') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '97') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '97') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '97') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '97') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '97') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '97') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '97') * co_aa_dist_12;

co_rcvaluems := (integer)(co_aa_code_01 = 'MS') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = 'MS') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = 'MS') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = 'MS') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = 'MS') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = 'MS') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = 'MS') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = 'MS') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = 'MS') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = 'MS') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = 'MS') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = 'MS') * co_aa_dist_12;

co_rcvalue9r := (integer)(co_aa_code_01 = '9R') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9R') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9R') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9R') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9R') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9R') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9R') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9R') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9R') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9R') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9R') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9R') * co_aa_dist_12;

co_rcvalue9w := (integer)(co_aa_code_01 = '9W') * co_aa_dist_01 +
    (integer)(co_aa_code_02 = '9W') * co_aa_dist_02 +
    (integer)(co_aa_code_03 = '9W') * co_aa_dist_03 +
    (integer)(co_aa_code_04 = '9W') * co_aa_dist_04 +
    (integer)(co_aa_code_05 = '9W') * co_aa_dist_05 +
    (integer)(co_aa_code_06 = '9W') * co_aa_dist_06 +
    (integer)(co_aa_code_07 = '9W') * co_aa_dist_07 +
    (integer)(co_aa_code_08 = '9W') * co_aa_dist_08 +
    (integer)(co_aa_code_09 = '9W') * co_aa_dist_09 +
    (integer)(co_aa_code_10 = '9W') * co_aa_dist_10 +
    (integer)(co_aa_code_11 = '9W') * co_aa_dist_11 +
    (integer)(co_aa_code_12 = '9W') * co_aa_dist_12;

co_lgt := -3.70456229534048 +
    co_v01_w +
    co_v02_w +
    co_v03_w +
    co_v04_w +
    co_v05_w +
    co_v06_w +
    co_v07_w +
    co_v08_w +
    co_v09_w +
    co_v10_w +
    co_v11_w +
    co_v12_w +
    co_v13_w;

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_r := DATASET([
    {'9K', co_rcvalue9K},
    {'27', co_rcvalue27},
    {'PV', co_rcvaluePV},
    {'9A', co_rcvalue9A},
    {'9C', co_rcvalue9C},
    {'9F', co_rcvalue9F},
    {'97', co_rcvalue97},
    {'MS', co_rcvalueMS},
    {'9R', co_rcvalue9R},
    {'9W', co_rcvalue9W}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_r_sorted := sort(rc_dataset_r, -rc_dataset_r.value);

r_rc1 := rc_dataset_r_sorted[1].rc;
r_rc2 := rc_dataset_r_sorted[2].rc;
r_rc3 := rc_dataset_r_sorted[3].rc;
r_rc4 := rc_dataset_r_sorted[4].rc;
r_rc5 := rc_dataset_r_sorted[5].rc;
r_rc6 := rc_dataset_r_sorted[6].rc;
r_rc7 := rc_dataset_r_sorted[7].rc;
r_rc8 := rc_dataset_r_sorted[8].rc;
r_rc9 := rc_dataset_r_sorted[9].rc;
r_rc10 := rc_dataset_r_sorted[10].rc;
// r_rc11 := rc_dataset_r_sorted[11].rc;
// r_rc12 := rc_dataset_r_sorted[12].rc;
// r_rc13 := rc_dataset_r_sorted[13].rc;

r_vl1 := rc_dataset_r_sorted[1].value;
r_vl2 := rc_dataset_r_sorted[2].value;
r_vl3 := rc_dataset_r_sorted[3].value;
r_vl4 := rc_dataset_r_sorted[4].value;
r_vl5 := rc_dataset_r_sorted[5].value;
r_vl6 := rc_dataset_r_sorted[6].value;
r_vl7 := rc_dataset_r_sorted[7].value;
r_vl8 := rc_dataset_r_sorted[8].value;
r_vl9 := rc_dataset_r_sorted[9].value;
r_vl10 := rc_dataset_r_sorted[10].value;
// r_vl11 := rc_dataset_r_sorted[11].value;
// r_vl12 := rc_dataset_r_sorted[12].value;
// r_vl13 := rc_dataset_r_sorted[13].value;
//*************************************************************************************//

rc1_2 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = '9Q' or r_rc2 = '9Q' or r_rc3 = '9Q' or r_rc4 = '9Q' or r_rc5 = '9Q' or r_rc6 = '9Q' or r_rc7 = '9Q' or r_rc8 = '9Q' or r_rc9 = '9Q' or r_rc10 = '9Q', '9Q', '');

rc4_c56 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,'');

rc5_c56 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc1_c56 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc3_c56 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc2_c56 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc3_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc3_2, rc3_c56);

rc2_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc2_2, rc2_c56);

rc5_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])),    '', rc5_c56);

rc4_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc4_2, rc4_c56);

rc1_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc1_2, rc1_c56);

iv_rv5_deceased := rc_decsflag = '1' or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(NAS_Summary <= 4 and NAP_Summary <= 4 and add1_naprop <= 3 or ~TrueDID, 1, 0);

base := 700;

pts := 40;

lgt := ln(0.0282 / (1 - 0.0282));

rvc1805_1_0 := map(
    iv_rv5_deceased   => 200,
    iv_rv5_unscorable = 1 => 222,
                             round(max((real)501, min(900, if(base + pts * (co_lgt - lgt) / ln(2) = NULL, NULL, base + pts * (co_lgt - lgt) / ln(2))))));

rc3 := map(
    rvc1805_1_0 = 200 => '',
    rvc1805_1_0 = 222 => '',
                         rc3_1);

rc2 := map(
    rvc1805_1_0 = 200 => '',
    rvc1805_1_0 = 222 => '',
                         rc2_1);

rc1 := map(
    rvc1805_1_0 = 200 => '02',
    rvc1805_1_0 = 222 => '9X',
                         rc1_1);

rc5 := map(
    rvc1805_1_0 = 200 => '',
    rvc1805_1_0 = 222 => '',
                         rc5_1);

rc4 := map(
    rvc1805_1_0 = 200 => '',
    rvc1805_1_0 = 222 => '',
                         rc4_1);



//*************************************************************************************//
	//     RiskView Version 4.1 Reason Code Overrides 
	//             ECL DEVELOPERS, MAKE SURE ALL RiskView V4.1 MODELS HAVE THIS
	//*************************************************************************************//
	HRILayout := RECORD
		STRING4 HRI := '';
	END;
	
	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
	
	reasonsTemp := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout)(HRI NOT IN ['', '00']);
	reasons := IF(ut.Exists2(reasonsTemp), reasonsTemp, DATASET([{'36'}], HRILayout));
	
	riCorrectionsTemp := PROJECT(RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4), TRANSFORM(HRILayout, SELF.HRI := LEFT.hri)) (HRI NOT IN ['', '00']);

	reasonsOverrides := MAP(
													inCalif           =>	DATASET([{'35'}], HRILayout),
													rvc1805_1_0 = 200 =>	DATASET([{'02'}], HRILayout),
													rvc1805_1_0 = 222 =>	DATASET([{'9X'}], HRILayout),
													rvc1805_1_0 = 900 =>	DATASET([{' '}], HRILayout),
													rvc1805_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
													rvc1805_1_0 BETWEEN 501 AND 720 AND reasons[1].HRI != '9E' AND reasons[2].HRI = ''					 => DATASET([{reasons[1].HRI}, {'9E'}], HRILayout),
																								DATASET([], HRILayout)
													);
	// If we have corrections reason codes, use them, otherwise if we have score overrides use them, else use the normal reason codes
	reasonsFinalTemp := MAP(ut.Exists2(riCorrectionsTemp(trim(hri)<>''))	=> riCorrectionsTemp,
													ut.Exists2(reasonsOverrides(trim(hri)<>''))	=> reasonsOverrides, 
																													 reasons(trim(HRI) <> '')) (trim(HRI) <> '');
																													 
																													 
	zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
	
	reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5); // Keep up to 5 reason codes
	// reasonCodes := CHOOSEN(reasons, 5); // Keep up to 5 reason codes


//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
		/* Model Input Variables */
    self.seq                              := le.seq;
    self.sysdate                          := sysdate;
    self.iv_add_apt                       := iv_add_apt;
    self.iv_criminal_x_felony             := iv_criminal_x_felony;
    self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
    self.iv_attr_bankruptcy_recency       := iv_attr_bankruptcy_recency;
    self._gong_did_last_seen              := _gong_did_last_seen;
    self.iv_mos_since_gong_did_lst_seen   := iv_mos_since_gong_did_lst_seen;
    self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
    self.prop_adl_lseen_p                 := prop_adl_lseen_p;
    self._prop_adl_lseen_p                := _prop_adl_lseen_p;
    self._src_prop_adl_lseen              := _src_prop_adl_lseen;
    self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
    self.iv_all_email_domain_isp          := iv_all_email_domain_isp;
    self.iv_avg_lres                      := iv_avg_lres;
    self.iv_ssns_per_sfd_addr             := iv_ssns_per_sfd_addr;
    self.iv_prop_owned_purchase_count     := iv_prop_owned_purchase_count;
    self.iv_pv001_inp_avm_autoval         := iv_pv001_inp_avm_autoval;
    self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
    self.iv_rec_vehx_level                := iv_rec_vehx_level;
    self.co_v01_w                         := co_v01_w;
    self.co_aa_dist_01                    := co_aa_dist_01;
    self.co_aa_code_01                    := co_aa_code_01;
    self.co_v02_w                         := co_v02_w;
    self.co_aa_dist_02                    := co_aa_dist_02;
    self.co_aa_code_02                    := co_aa_code_02;
    self.co_v03_w                         := co_v03_w;
    self.co_aa_dist_03                    := co_aa_dist_03;
    self.co_aa_code_03                    := co_aa_code_03;
    self.co_v04_w                         := co_v04_w;
    self.co_aa_dist_04                    := co_aa_dist_04;
    self.co_aa_code_04                    := co_aa_code_04;
    self.co_v05_w                         := co_v05_w;
    self.co_aa_dist_05                    := co_aa_dist_05;
    self.co_aa_code_05                    := co_aa_code_05;
    self.co_v06_w                         := co_v06_w;
    self.co_aa_dist_06                    := co_aa_dist_06;
    self.co_aa_code_06                    := co_aa_code_06;
    self.co_v07_w                         := co_v07_w;
    self.co_aa_dist_07                    := co_aa_dist_07;
    self.co_aa_code_07                    := co_aa_code_07;
    self.co_v08_w                         := co_v08_w;
    self.co_aa_dist_08                    := co_aa_dist_08;
    self.co_aa_code_08                    := co_aa_code_08;
    self.co_v09_w                         := co_v09_w;
    self.co_aa_dist_09                    := co_aa_dist_09;
    self.co_aa_code_09                    := co_aa_code_09;
    self.co_v10_w                         := co_v10_w;
    self.co_aa_dist_10                    := co_aa_dist_10;
    self.co_aa_code_10                    := co_aa_code_10;
    self.co_v11_w                         := co_v11_w;
    self.co_aa_dist_11                    := co_aa_dist_11;
    self.co_aa_code_11                    := co_aa_code_11;
    self.co_v12_w                         := co_v12_w;
    self.co_aa_dist_12                    := co_aa_dist_12;
    self.co_aa_code_12                    := co_aa_code_12;
    self.co_v13_w                         := co_v13_w;
    self.co_aa_dist_13                    := co_aa_dist_13;
    self.co_rcvalue9k                     := co_rcvalue9k;
    self.co_rcvalue27                     := co_rcvalue27;
    self.co_rcvaluepv                     := co_rcvaluepv;
    self.co_rcvalue9a                     := co_rcvalue9a;
    self.co_rcvalue9c                     := co_rcvalue9c;
    self.co_rcvalue9f                     := co_rcvalue9f;
    self.co_rcvalue97                     := co_rcvalue97;
    self.co_rcvaluems                     := co_rcvaluems;
    self.co_rcvalue9r                     := co_rcvalue9r;
    self.co_rcvalue9w                     := co_rcvalue9w;
    self.co_lgt                           := co_lgt;
    self.r_rc1                            := r_rc1;
    self.r_rc2                            := r_rc2;
    self.r_rc3                            := r_rc3;
    self.r_rc4                            := r_rc4;
    self.r_rc5                            := r_rc5;
    self.r_rc6                            := r_rc6;
    self.r_rc7                            := r_rc7;
    self.r_rc8                            := r_rc8;
    self.r_rc9                            := r_rc9;
    self.r_rc10                           := r_rc10;
    self.r_rc11                           := '';
    self.r_rc12                           := '';
    self.r_rc13                           := '';
    self.r_vl1                            := r_vl1;
    self.r_vl2                            := r_vl2;
    self.r_vl3                            := r_vl3;
    self.r_vl4                            := r_vl4;
    self.r_vl5                            := r_vl5;
    self.r_vl6                            := r_vl6;
    self.r_vl7                            := r_vl7;
    self.r_vl8                            := r_vl8;
    self.r_vl9                            := r_vl9;
    self.r_vl10                           := r_vl10;
    self.r_vl11                           := 0;
    self.r_vl12                           := 0;
    self.r_vl13                           := 0;
    self._rc_inq                          := _rc_inq;
    self.iv_rv5_deceased                  := iv_rv5_deceased;
    self.iv_rv5_unscorable                := iv_rv5_unscorable;
    self.base                             := base;
    self.pts                              := pts;
    self.lgt                              := lgt;
    self.rvc1805_1_0                      := rvc1805_1_0;
    self.rc5                              := rc5;
    self.rc1                              := rc1;
    self.rc3                              := rc3;
    self.rc2                              := rc2;
    self.rc4                              := rc4;
		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)rvc1805_1_0);

		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
