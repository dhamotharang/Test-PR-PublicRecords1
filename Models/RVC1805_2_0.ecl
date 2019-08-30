/************************************************************************************
 * RVC1805.2.1                       Version 00                               BY AO *
 * Phillips & Cohen Custom Payment Score for Probate                     07/25/2018 *
 ************************************************************************************
 ************************************************************************************
 * Returns the following fields - RVC1805_2_0, rc1, rc2, rc3, rc4, rc5              *
 *                                                                                  *
 * IMPORTANT NOTES:                                                                 *
 *                                                                                  *
 * THIS MODEL WAS CREATED FOR ACCOUNTS IN PROBATE SO THE IDENTITIES ARE KNOWN TO BE *
 * DECEASED. THEREFORE THIS MODEL DOES NOT INCLUDE THE RISKVIEW EXCEPTION SCORE OF  *
 * 200.                                                                             *
 *                                                                                  *
 * THIS MODEL USES A STANDARD FCRA 4.1 MODELING SHELL. WE DID NOT WANT TO RUN AN    *
 * ADL SHELL AND SKIP TRACE IDENTITIES THAT ARE KNOWN TO BE DECEASED.               *
 *                                                                                  *
 ************************************************************************************
 ************************************************************************************
 * Model Edits:                                                                     *
 *  AO - 07/25/2018 - Initial Release                                               *
 ************************************************************************************
 ************************************************************************************
 * Model Requirements:                                                              *
 *  Fields from FCRA 4.1 Modeling Shell                                             *
 ************************************************************************************
 * ECL Developer: Jack Francis Jr   08/15/2018 *
 * ECL Developer: AT  08/26/2019 *
 ************************************************************************************/

IMPORT ut, Std, RiskWise, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVC1805_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, Boolean isCalifornia = False) := FUNCTION

	MODEL_DEBUG := false;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
          unsigned  seq;
          Integer sysdate;
          String iv_db001_bankruptcy;
          String iv_phnpop_x_nap_summary;
          Integer lien_adl_li_count_pos;
          Integer lien_adl_count_li;
          Integer lien_adl_l2_count_pos;
          Integer lien_adl_count_l2;
          Integer _src_lien_adl_count;
          Integer iv_src_liens_adl_count;
          Integer _src_prop_adl_count;
          Integer iv_avg_lres;
          String iv_bst_own_prop_x_addr_naprop;
          Integer iv_in001_estimated_income;
          Integer iv_iq001_inq_count12;
          Integer prop_adl_p_lseen_pos;
          String prop_adl_lseen_p;
          Integer _prop_adl_lseen_p;
          Integer _src_prop_adl_lseen;
          Integer iv_mos_src_property_adl_lseen;
          Real iv_avg_prop_assess_purch_amt;
          Integer iv_addrs_per_adl;
          string iv_inq_per_addr;
          Integer _gong_did_first_seen;
          Integer iv_mos_since_gong_did_fst_seen;
          Integer iv_prv_addr_avm_auto_val;
          String iv_rec_vehx_level;
          Integer iv_inq_ssns_per_adl;
          Integer iv_src_property_adl_count;
          Integer iv_input_addr_not_most_recent;
          Integer iv_lnames_per_adl;
          Integer prop_adl_count_p;
          Integer prop_adl_p_count_pos;
          Real pr_v01_w;
          Real pr_aa_dist_01;
          String pr_aa_code_01;
          Real pr_v02_w;
          Real pr_aa_dist_02;
          String pr_aa_code_02;
          Real pr_v03_w;
          Real pr_aa_dist_03;
          String pr_aa_code_03;
          Real pr_v04_w;
          Real pr_aa_dist_04;
          String pr_aa_code_04;
          Real pr_v05_w;
          Real pr_aa_dist_05;
          String pr_aa_code_05;
          Real pr_v06_w;
          Real pr_aa_dist_06;
          String pr_aa_code_06;
          Real pr_v07_w;
          Real pr_aa_dist_07;
          String pr_aa_code_07;
          Real pr_v08_w;
          Real pr_aa_dist_08;
          String pr_aa_code_08;
          Real pr_v09_w;
          Real pr_aa_dist_09;
          String pr_aa_code_09;
          Real pr_v10_w;
          Real pr_aa_dist_10;
          String pr_aa_code_10;
          Real pr_v11_w;
          Real pr_aa_dist_11;
          String pr_aa_code_11;
          Real pr_v12_w;
          Real pr_aa_dist_12;
          String pr_aa_code_12;
          Real pr_v13_w;
          Real pr_aa_dist_13;
          String pr_aa_code_13;
          Real pr_v14_w;
          Real pr_aa_dist_14;
          String pr_aa_code_14;
          Real pr_v15_w;
          Real pr_aa_dist_15;
          String pr_aa_code_15;
          Real pr_v16_w;
          Real pr_aa_dist_16;
          String pr_aa_code_16;
          Real pr_v17_w;
          Real pr_aa_dist_17;
          String pr_aa_code_17;
          Real pr_v18_w;
          Real pr_aa_dist_18;
          String pr_aa_code_18;
          Real pr_rcvalue27;
          Real pr_rcvalue9m;
          Real pr_rcvalue9a;
          Real pr_rcvalue9c;
          Real pr_rcvalue36;
          Real pr_rcvalue9f;
          Real pr_rcvalue99;
          Real pr_rcvalue98;
          Real pr_rcvalue9d;
          Real pr_rcvalue9q;
          Real pr_rcvaluepv;
          Real pr_rcvalue80;
          Real pr_rcvalue9r;
          Real pr_rcvalue9w;
          Real pr_rcvalue9v;
          Real pr_lgt;
          String r_rc1;
          String r_rc2;
          String r_rc3;
          String r_rc4;
          String r_rc5;
          String r_rc6;
          String r_rc7;
          String r_rc8;
          String r_rc9;
          String r_rc10;
          String r_rc11;
          String r_rc12;
          String r_rc13;
          String r_rc14;
          String r_rc15;
          String r_rc16;
          String r_rc17;
          String r_rc18;
          String r_rc19;
          Real r_vl1;
          Real r_vl2;
          Real r_vl3;
          Real r_vl4;
          Real r_vl5;
          Real r_vl6;
          Real r_vl7;
          Real r_vl8;
          Real r_vl9;
          Real r_vl10;
          Real r_vl11;
          Real r_vl12;
          Real r_vl13;
          Real r_vl14;
          Real r_vl15;
          Real r_vl16;
          Real r_vl17;
          Real r_vl18;
          Real r_vl19;
          String _rc_inq;
          integer iv_rv5_unscorable;
          Integer base;
          Integer pts;
          Real lgt;
          Integer RVC1805_2_0;
          String rc3;
          String rc4;
          String rc5;
          String rc1;
          String rc2;


			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
  // in_addrpop                       := le.adl_shell_flags.in_addrpop;
  // in_hphnpop                       := le.adl_shell_flags.in_hphnpop;
  // in_ssnpop                        := le.adl_shell_flags.in_ssnpop;
  // in_dobpop                        := le.adl_shell_flags.in_dobpop;
  // adl_addr                         := le.adl_shell_flags.adl_addr;
  // adl_hphn                         := le.adl_shell_flags.adl_hphn;
  // adl_ssn                          := le.adl_shell_flags.adl_ssn;
  // adl_dob                          := le.adl_shell_flags.adl_dob;
  // in_addrpop_found                 := le.adl_shell_flags.in_addrpop_found;
  // in_hphnpop_found                 := le.adl_shell_flags.in_hphnpop_found;

	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_sources_count                := le.header_summary.ver_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	avg_lres                         := le.other_address_info.avg_lres;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	lnames_per_adl                   := le.velocity_counters.lnames_per_adl;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	inq_count12                      := le.acc_logs.inquiries.count12;
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
  inq_peraddr                      := le.acc_logs.inquiryperaddr;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_age                          := le.student.age;
	prof_license_category            := le.professional_license.plcategory;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	estimated_income                 := le.estimated_income;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */
NULL := -999999999;

string zero_fill(string src_string, integer len) := function
		return ('00000' + src_string)[length(src_string) + 5 - len + 1..];
	end;
INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                               => '-1               ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_phnpop_x_nap_summary := map(
    not(hphnpop or addrpop) => '-1 ',
    hphnpop                 => (string)(nap_summary + 100),
                               zero_fill((string)nap_summary, 3)); 
                               
lien_adl_li_count_pos := Models.Common.findw_cpp(ver_sources, 'LI' , ', ', 'E');

lien_adl_count_li := if(lien_adl_li_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_li_count_pos, ','));

lien_adl_l2_count_pos := Models.Common.findw_cpp(ver_sources, 'L2' , ', ', 'E');

lien_adl_count_l2 := if(lien_adl_l2_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, lien_adl_l2_count_pos, ','));

_src_lien_adl_count := max(lien_adl_count_li, lien_adl_count_l2, (real)0);

iv_src_liens_adl_count := map(
    not(truedid)               => NULL,
    _src_lien_adl_count = NULL => -1,
                                  _src_lien_adl_count);

iv_avg_lres := if(not(truedid), NULL, avg_lres);


iv_bst_own_prop_x_addr_naprop_c8 :=__common__( if(property_owned_total > 0, (string)(add1_naprop + 10), zero_fill((string)add1_naprop, 2)));


iv_bst_own_prop_x_addr_naprop_c9 :=__common__( if(property_owned_total > 0, (string)(add2_naprop + 10), zero_fill((string)add2_naprop, 2)));

iv_bst_own_prop_x_addr_naprop := map(
    not(truedid)     => '-1',
    add1_isbestmatch => (STRING)iv_bst_own_prop_x_addr_naprop_c8,
                        (STRING)iv_bst_own_prop_x_addr_naprop_c9);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

iv_iq001_inq_count12 := if(not(truedid), NULL, inq_count12);

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

iv_avg_prop_assess_purch_amt := map(
    not(truedid or add1_pop)          => NULL,
    property_owned_assessed_count > 0 => property_owned_assessed_total / property_owned_assessed_count,
                                         -1);

iv_addrs_per_adl := if(not(truedid), NULL, addrs_per_adl);

_gong_did_first_seen := common.sas_date((string)(gong_did_first_seen));

iv_mos_since_gong_did_fst_seen := map(
    not(truedid)                     => NULL,
    not(_gong_did_first_seen = NULL) => if ((sysdate - _gong_did_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)), roundup((sysdate - _gong_did_first_seen) / (365.25 / 12))),
                                        -1);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_rec_vehx_level := map(
    not(truedid)                                   => '-1',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((STRING)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
                                                      'XX');

iv_inq_ssns_per_adl := if(not(truedid), NULL, inq_ssnsperadl);

iv_input_addr_not_most_recent := if(not(truedid), -1, (integer)rc_input_addr_not_most_recent);

iv_lnames_per_adl := if(not(truedid), NULL, lnames_per_adl);

iv_inq_per_addr := if(not(add1_pop), NULL, inq_peraddr);

prop_adl_p_count_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_count_p := if(prop_adl_p_count_pos = 0, NULL, (integer)Models.Common.getw(ver_sources_count, prop_adl_p_count_pos, ','));

_src_prop_adl_count := max(prop_adl_count_p, (real)0);

iv_src_property_adl_count := map(
    not(truedid)               => NULL,
    _src_prop_adl_count = NULL => -1,
                                  _src_prop_adl_count);

pr_v01_w := map(
    iv_db001_bankruptcy = (STRING)NULL                                     => 0,
    (iv_db001_bankruptcy in ['-1'])                                => 0,
    (iv_db001_bankruptcy in ['0 - No BK'])                         => 0.532875823525413,
    (iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => -0.538362103231024,
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                  => -0.872827827219129,
                                                                      0);

pr_aa_code_01_1 := map(
    iv_db001_bankruptcy = (STRING)NULL                                     => '',
    (iv_db001_bankruptcy in ['-1'])                                => '',
    (iv_db001_bankruptcy in ['0 - No BK'])                         => '9W',
    (iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other']) => '9W',
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])                  => '9W',
                                                                      '9W');

pr_aa_dist_01 := 0.532875823525413 - pr_v01_w;

pr_aa_code_01 := if(pr_aa_dist_01 = 0, '', pr_aa_code_01_1);

pr_v02_w := map(
    iv_phnpop_x_nap_summary = (STRING)NULL                                          => 0,
    (iv_phnpop_x_nap_summary in ['-1'])                                     => 0,
    (iv_phnpop_x_nap_summary in ['000', '003', '005', '008'])               => -0.460923464571853,
    (iv_phnpop_x_nap_summary in ['100'])                                    => 0.1630074173855,
    (iv_phnpop_x_nap_summary in ['101', '103', '104', '105', '106'])        => 0.29080459599449,
    (iv_phnpop_x_nap_summary in ['107', '108', '109', '110', '111', '112']) => 0.414504903481762,
                                                                               0);

pr_aa_code_02_1 := map(
    iv_phnpop_x_nap_summary = (STRING)NULL                                          => '',
    (iv_phnpop_x_nap_summary in ['-1'])                                     => '',
    (iv_phnpop_x_nap_summary in ['000', '003', '005', '008'])               => '80',
    (iv_phnpop_x_nap_summary in ['100'])                                    => '27',
    (iv_phnpop_x_nap_summary in ['101', '103', '104', '105', '106'])        => '27',
    (iv_phnpop_x_nap_summary in ['107', '108', '109', '110', '111', '112']) => '27',
                                                                               '27');

pr_aa_dist_02 := 0.414504903481762 - pr_v02_w;

pr_aa_code_02 := if(pr_aa_dist_02 = 0, '', pr_aa_code_02_1);

pr_v03_w := map(
    iv_src_liens_adl_count = NULL => 0,
    iv_src_liens_adl_count = -1   => 0,
    iv_src_liens_adl_count <= 0.5 => 0.401355927324539,
                                     -0.476496641604834);

pr_aa_code_03_1 := map(
    iv_src_liens_adl_count = NULL => '',
    iv_src_liens_adl_count = -1   => '',
    iv_src_liens_adl_count <= 0.5 => '98',
                                     '98');

pr_aa_dist_03 := 0.401355927324539 - pr_v03_w;

pr_aa_code_03 := if(pr_aa_dist_03 = 0, '', pr_aa_code_03_1);

pr_v04_w := map(
    iv_avg_lres = NULL   => 0,
    iv_avg_lres = -1     => 0,
    iv_avg_lres <= 64.5  => -0.42535345714486,
    iv_avg_lres <= 78.5  => -0.305823903980823,
    iv_avg_lres <= 104.5 => -0.190327216300318,
    iv_avg_lres <= 142.5 => -0.0704941437875574,
    iv_avg_lres <= 184.5 => 0.0261033568917136,
    iv_avg_lres <= 213.5 => 0.121269796786007,
    iv_avg_lres <= 280.5 => 0.283056160362662,
                            0.399900074673182);

pr_aa_code_04_1 := map(
    iv_avg_lres = NULL   => '',
    iv_avg_lres = -1     => '9C',
    iv_avg_lres <= 64.5  => '9C',
    iv_avg_lres <= 78.5  => '9C',
    iv_avg_lres <= 104.5 => '9C',
    iv_avg_lres <= 142.5 => '9C',
    iv_avg_lres <= 184.5 => '9C',
    iv_avg_lres <= 213.5 => '9C',
    iv_avg_lres <= 280.5 => '9C',
                            '9C');

pr_aa_dist_04 := 0.399900074673182 - pr_v04_w;

pr_aa_code_04 := if(pr_aa_dist_04 = 0, '', pr_aa_code_04_1);

pr_v05_w := map(
    iv_in001_estimated_income = NULL    => 0,
    iv_in001_estimated_income = -1      => 0,
    iv_in001_estimated_income <= 0      => -0.225882352249119,
    iv_in001_estimated_income <= 32500  => -0.157801572603298,
    iv_in001_estimated_income <= 35500  => -0.0769262955201202,
    iv_in001_estimated_income <= 37500  => -0.0543124096761274,
    iv_in001_estimated_income <= 42500  => -0.0298385344841242,
    iv_in001_estimated_income <= 84500  => 0.0396401573594357,
    iv_in001_estimated_income <= 105500 => 0.386416966286984,
                                           0.533699421639451);

pr_aa_code_05_1 := map(
    iv_in001_estimated_income = NULL    => '',
    iv_in001_estimated_income = -1      => '',
    iv_in001_estimated_income <= 0      => '9M',
    iv_in001_estimated_income <= 32500  => '9M',
    iv_in001_estimated_income <= 35500  => '9M',
    iv_in001_estimated_income <= 37500  => '9M',
    iv_in001_estimated_income <= 42500  => '9M',
    iv_in001_estimated_income <= 84500  => '9M',
    iv_in001_estimated_income <= 105500 => '9M',
                                           '9M');

pr_aa_dist_05 := 0.533699421639451 - pr_v05_w;

pr_aa_code_05 := if(pr_aa_dist_05 = 0, '', pr_aa_code_05_1);

pr_v06_w := map(
    iv_bst_own_prop_x_addr_naprop = (String)NULL                              => 0,
    (iv_bst_own_prop_x_addr_naprop in ['-1'])                         => 0,
    (iv_bst_own_prop_x_addr_naprop in ['00'])                         => -0.15814623850514,
    (iv_bst_own_prop_x_addr_naprop in ['01'])                         => -0.314923255020376,
    (iv_bst_own_prop_x_addr_naprop in ['02', '03'])                   => -0.0467207845445412,
    (iv_bst_own_prop_x_addr_naprop in ['04', '10', '11', '12', '13']) => 0.0669687262465346,
    (iv_bst_own_prop_x_addr_naprop in ['14'])                         => 0.216988146268781,
                                                                         0);

pr_aa_code_06_1 := map(
    iv_bst_own_prop_x_addr_naprop = (String)NULL                              => '',
    (iv_bst_own_prop_x_addr_naprop in ['-1'])                         => '',
    (iv_bst_own_prop_x_addr_naprop in ['00'])                         => '9A',
    (iv_bst_own_prop_x_addr_naprop in ['01'])                         => '9A',
    (iv_bst_own_prop_x_addr_naprop in ['02', '03'])                   => '9A',
    (iv_bst_own_prop_x_addr_naprop in ['04', '10', '11', '12', '13']) => '36',
    (iv_bst_own_prop_x_addr_naprop in ['14'])                         => '36',
                                                                         '36');

pr_aa_dist_06 := 0.216988146268781 - pr_v06_w;

pr_aa_code_06 := if(pr_aa_dist_06 = 0, '', pr_aa_code_06_1);

pr_v07_w := map(
    iv_mos_src_property_adl_lseen = NULL  => 0,
    iv_mos_src_property_adl_lseen = -1    => -0.190748939516534,
    iv_mos_src_property_adl_lseen <= 8.5  => 0.21479786633955,
    iv_mos_src_property_adl_lseen <= 26.5 => 0.126289372774268,
    iv_mos_src_property_adl_lseen <= 64.5 => 0.089218504124946,
    iv_mos_src_property_adl_lseen <= 78.5 => 0.0260241850397308,
    iv_mos_src_property_adl_lseen <= 92.5 => -0.00849701509091417,
                                             -0.0567138793181413);

pr_aa_code_07_1 := map(
    iv_mos_src_property_adl_lseen = NULL  => '',
    iv_mos_src_property_adl_lseen = -1    => '9A',
    iv_mos_src_property_adl_lseen <= 8.5  => '9F',
    iv_mos_src_property_adl_lseen <= 26.5 => '9F',
    iv_mos_src_property_adl_lseen <= 64.5 => '9F',
    iv_mos_src_property_adl_lseen <= 78.5 => '9F',
    iv_mos_src_property_adl_lseen <= 92.5 => '9F',
                                             '9F');

pr_aa_dist_07 := 0.21479786633955 - pr_v07_w;

pr_aa_code_07 := if(pr_aa_dist_07 = 0, '', pr_aa_code_07_1);

pr_v08_w := map(
    iv_inq_per_addr = NULL => 0,
    iv_inq_per_addr = -1   => 0,
    iv_inq_per_addr <= 0.5 => 0.163656793820406,
    iv_inq_per_addr <= 3.5 => -0.215359877468145,
                              -0.43511390579968);

pr_aa_code_08_1 := map(
    iv_inq_per_addr = NULL => '',
    iv_inq_per_addr = -1   => '9Q',
    iv_inq_per_addr <= 0.5 => '9Q',
    iv_inq_per_addr <= 3.5 => '9Q',
                              '9Q');

pr_aa_dist_08 := 0.163656793820406 - pr_v08_w;

pr_aa_code_08 := if(pr_aa_dist_08 = 0, '', pr_aa_code_08_1);

pr_v09_w := map(
    iv_addrs_per_adl = NULL  => 0,
    iv_addrs_per_adl = -1    => 0,
    iv_addrs_per_adl <= 1.5  => 0.297923664618421,
    iv_addrs_per_adl <= 3.5  => 0.245737786880149,
    iv_addrs_per_adl <= 4.5  => 0.107103405590356,
    iv_addrs_per_adl <= 5.5  => 0.0271187424159102,
    iv_addrs_per_adl <= 8.5  => -0.0234418905460414,
    iv_addrs_per_adl <= 9.5  => -0.0614648993371279,
    iv_addrs_per_adl <= 17.5 => -0.171775507257462,
                                -0.398544016760631);

pr_aa_code_09_1 := map(
    iv_addrs_per_adl = NULL  => '',
    iv_addrs_per_adl = -1    => '9D',
    iv_addrs_per_adl <= 1.5  => '9D',
    iv_addrs_per_adl <= 3.5  => '9D',
    iv_addrs_per_adl <= 4.5  => '9D',
    iv_addrs_per_adl <= 5.5  => '9D',
    iv_addrs_per_adl <= 8.5  => '9D',
    iv_addrs_per_adl <= 9.5  => '9D',
    iv_addrs_per_adl <= 17.5 => '9D',
                                '9D');

pr_aa_dist_09 := 0.297923664618421 - pr_v09_w;

pr_aa_code_09 := if(pr_aa_dist_09 = 0, '', pr_aa_code_09_1);

pr_v10_w := map(
    iv_avg_prop_assess_purch_amt = NULL              => 0,
    iv_avg_prop_assess_purch_amt = -1                => 0,
    iv_avg_prop_assess_purch_amt <= 30965.8333333333 => -0.500706711280354,
    iv_avg_prop_assess_purch_amt <= 106482.5         => -0.188513257775024,
    iv_avg_prop_assess_purch_amt <= 133075.75        => 0.049756052339838,
                                                        0.204122389798817);

pr_aa_code_10_1 := map(
    iv_avg_prop_assess_purch_amt = NULL              => '',
    iv_avg_prop_assess_purch_amt = -1                => '9A',
    iv_avg_prop_assess_purch_amt <= 30965.8333333333 => 'PV',
    iv_avg_prop_assess_purch_amt <= 106482.5         => 'PV',
    iv_avg_prop_assess_purch_amt <= 133075.75        => 'PV',
                                                        'PV');

pr_aa_dist_10 := 0.204122389798817 - pr_v10_w;

pr_aa_code_10 := if(pr_aa_dist_10 = 0, '', pr_aa_code_10_1);

pr_v11_w := map(
    iv_iq001_inq_count12 = NULL => 0,
    iv_iq001_inq_count12 = -1   => 0,
    iv_iq001_inq_count12 <= 0.5 => 0.149802995809747,
    iv_iq001_inq_count12 <= 1.5 => -0.115034639273072,
                                   -0.363332460968312);

pr_aa_code_11_1 := map(
    iv_iq001_inq_count12 = NULL => '',
    iv_iq001_inq_count12 = -1   => '9Q',
    iv_iq001_inq_count12 <= 0.5 => '9Q',
    iv_iq001_inq_count12 <= 1.5 => '9Q',
                                   '9Q');

pr_aa_dist_11 := 0.149802995809747 - pr_v11_w;

pr_aa_code_11 := if(pr_aa_dist_11 = 0, '', pr_aa_code_11_1);

pr_v12_w := map(
    iv_mos_since_gong_did_fst_seen = NULL   => 0,
    iv_mos_since_gong_did_fst_seen = -1     => -0.0991725317958002,
    iv_mos_since_gong_did_fst_seen <= 107.5 => -0.172491583351049,
    iv_mos_since_gong_did_fst_seen <= 205.5 => 0.0871513727000322,
    iv_mos_since_gong_did_fst_seen <= 207.5 => 0.412051900070383,
                                               0.619730341815681);

pr_aa_code_12_1 := map(
    iv_mos_since_gong_did_fst_seen = NULL   => '',
    iv_mos_since_gong_did_fst_seen = -1     => '9R',
    iv_mos_since_gong_did_fst_seen <= 107.5 => '9R',
    iv_mos_since_gong_did_fst_seen <= 205.5 => '9R',
    iv_mos_since_gong_did_fst_seen <= 207.5 => '9R',
                                               '9R');

pr_aa_dist_12 := 0.619730341815681 - pr_v12_w;

pr_aa_code_12 := if(pr_aa_dist_12 = 0, '', pr_aa_code_12_1);

pr_v13_w := map(
    iv_rec_vehx_level = (String)NULL                              => 0,
    (iv_rec_vehx_level in ['-1'])                         => 0,
    (iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => -0.00562177519304683,
    (iv_rec_vehx_level in ['XX'])                         => -0.133102972046686,
                                                             0);

pr_aa_code_13_1 := map(
    iv_rec_vehx_level = (String)NULL                              => '',
    (iv_rec_vehx_level in ['-1'])                         => '',
    (iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => '',
    (iv_rec_vehx_level in ['XX'])                         => '',
                                                             '');

pr_aa_dist_13 := 0 - pr_v13_w;

pr_aa_code_13 := if(pr_aa_dist_13 = 0, '', pr_aa_code_13_1);

pr_v14_w := map(
    iv_prv_addr_avm_auto_val = NULL      => 0,
    iv_prv_addr_avm_auto_val = -1        => 0,
    iv_prv_addr_avm_auto_val <= 113742.5 => -0.112009400865291,
    iv_prv_addr_avm_auto_val <= 137544.5 => -0.101713827694093,
    iv_prv_addr_avm_auto_val <= 675183.5 => 0.0751700594903301,
                                            0.294180995088591);

pr_aa_code_14_1 := map(
    iv_prv_addr_avm_auto_val = NULL      => '',
    iv_prv_addr_avm_auto_val = -1        => '9V',
    iv_prv_addr_avm_auto_val <= 113742.5 => '9V',
    iv_prv_addr_avm_auto_val <= 137544.5 => '9V',
    iv_prv_addr_avm_auto_val <= 675183.5 => '9V',
                                            '9V');

pr_aa_dist_14 := 0.294180995088591 - pr_v14_w;

pr_aa_code_14 := if(pr_aa_dist_14 = 0, '', pr_aa_code_14_1);

pr_v15_w := map(
    iv_inq_ssns_per_adl = NULL => 0,
    iv_inq_ssns_per_adl = -1   => 0,
    iv_inq_ssns_per_adl <= 0.5 => 0.146878430035023,
    iv_inq_ssns_per_adl <= 1.5 => -0.0176963087685786,
                                  -0.463672814077517);

pr_aa_code_15_1 := map(
    iv_inq_ssns_per_adl = NULL => '',
    iv_inq_ssns_per_adl = -1   => '9Q',
    iv_inq_ssns_per_adl <= 0.5 => '9Q',
    iv_inq_ssns_per_adl <= 1.5 => '9Q',
                                  '9Q');

pr_aa_dist_15 := 0.146878430035023 - pr_v15_w;

pr_aa_code_15 := if(pr_aa_dist_15 = 0, '', pr_aa_code_15_1);

pr_v16_w := map(
    iv_input_addr_not_most_recent = NULL      => 0,
    (iv_input_addr_not_most_recent = -1) => 0,
    (iv_input_addr_not_most_recent = 0)  => 0.110273880371717,
    (iv_input_addr_not_most_recent = 1)  => -0.141206327914049,
                                                 0);

pr_aa_code_16_1 := map(
    iv_input_addr_not_most_recent = NULL      => '',
    (iv_input_addr_not_most_recent = -1) => '99',
    (iv_input_addr_not_most_recent = 0)  => '99',
    (iv_input_addr_not_most_recent = 1)  => '99',
                                                 '99');

pr_aa_dist_16 := 0.110273880371717 - pr_v16_w;

pr_aa_code_16 := if(pr_aa_dist_16 = 0, '', pr_aa_code_16_1);

pr_v17_w := map(
    iv_lnames_per_adl = NULL => 0,
    iv_lnames_per_adl = -1   => 0,
    iv_lnames_per_adl <= 1.5 => 0.0843645730408038,
    iv_lnames_per_adl <= 2.5 => 0.0305588853735407,
    iv_lnames_per_adl <= 3.5 => -0.0784586297753108,
    iv_lnames_per_adl <= 4.5 => -0.131556474212466,
                                -0.339812712941437);

pr_aa_code_17_1 := map(
    iv_lnames_per_adl = NULL => '',
    iv_lnames_per_adl = -1   => '',
    iv_lnames_per_adl <= 1.5 => '',
    iv_lnames_per_adl <= 2.5 => '',
    iv_lnames_per_adl <= 3.5 => '',
    iv_lnames_per_adl <= 4.5 => '',
                                '');

pr_aa_dist_17 := 0.0843645730408038 - pr_v17_w;

pr_aa_code_17 := if(pr_aa_dist_17 = 0, '', pr_aa_code_17_1);

pr_v18_w := map(
    iv_src_property_adl_count = NULL => 0,
    iv_src_property_adl_count = -1   => 0,
    iv_src_property_adl_count <= 0.5 => -0.201099014470446,
    iv_src_property_adl_count <= 6.5 => 0.0212067828605403,
                                        0.316716917644956);

pr_aa_code_18_1 := map(
    iv_src_property_adl_count = NULL => '',
    iv_src_property_adl_count = -1   => '36',
    iv_src_property_adl_count <= 0.5 => '36',
    iv_src_property_adl_count <= 6.5 => '36',
                                        '36');

pr_aa_dist_18 := 0.316716917644956 - pr_v18_w;

pr_aa_code_18 := if(pr_aa_dist_18 = 0, '', pr_aa_code_18_1);

pr_rcvalue9a := (integer)(pr_aa_code_01 = '9A') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9A') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9A') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9A') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9A') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9A') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9A') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9A') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9A') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9A') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9A') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9A') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9A') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9A') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9A') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9A') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9A') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9A') * pr_aa_dist_18;

pr_rcvalue27 := (integer)(pr_aa_code_01 = '27') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '27') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '27') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '27') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '27') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '27') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '27') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '27') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '27') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '27') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '27') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '27') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '27') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '27') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '27') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '27') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '27') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '27') * pr_aa_dist_18;

pr_rcvalue98 := (integer)(pr_aa_code_01 = '98') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '98') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '98') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '98') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '98') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '98') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '98') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '98') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '98') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '98') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '98') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '98') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '98') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '98') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '98') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '98') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '98') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '98') * pr_aa_dist_18;

pr_rcvalue9q := (integer)(pr_aa_code_01 = '9Q') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9Q') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9Q') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9Q') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9Q') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9Q') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9Q') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9Q') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9Q') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9Q') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9Q') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9Q') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9Q') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9Q') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9Q') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9Q') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9Q') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9Q') * pr_aa_dist_18;

pr_rcvalue80 := (integer)(pr_aa_code_01 = '80') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '80') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '80') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '80') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '80') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '80') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '80') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '80') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '80') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '80') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '80') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '80') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '80') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '80') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '80') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '80') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '80') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '80') * pr_aa_dist_18;

pr_rcvalue9r := (integer)(pr_aa_code_01 = '9R') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9R') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9R') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9R') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9R') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9R') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9R') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9R') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9R') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9R') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9R') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9R') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9R') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9R') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9R') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9R') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9R') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9R') * pr_aa_dist_18;

pr_rcvalue9m := (integer)(pr_aa_code_01 = '9M') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9M') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9M') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9M') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9M') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9M') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9M') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9M') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9M') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9M') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9M') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9M') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9M') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9M') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9M') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9M') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9M') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9M') * pr_aa_dist_18;

pr_rcvalue36 := (integer)(pr_aa_code_01 = '36') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '36') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '36') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '36') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '36') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '36') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '36') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '36') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '36') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '36') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '36') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '36') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '36') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '36') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '36') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '36') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '36') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '36') * pr_aa_dist_18;

pr_rcvalue9f := (integer)(pr_aa_code_01 = '9F') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9F') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9F') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9F') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9F') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9F') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9F') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9F') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9F') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9F') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9F') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9F') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9F') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9F') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9F') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9F') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9F') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9F') * pr_aa_dist_18;

pr_rcvalue9d := (integer)(pr_aa_code_01 = '9D') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9D') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9D') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9D') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9D') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9D') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9D') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9D') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9D') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9D') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9D') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9D') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9D') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9D') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9D') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9D') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9D') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9D') * pr_aa_dist_18;

pr_rcvalue99 := (integer)(pr_aa_code_01 = '99') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '99') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '99') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '99') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '99') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '99') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '99') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '99') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '99') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '99') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '99') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '99') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '99') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '99') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '99') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '99') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '99') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '99') * pr_aa_dist_18;

pr_rcvaluepv := (integer)(pr_aa_code_01 = 'PV') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = 'PV') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = 'PV') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = 'PV') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = 'PV') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = 'PV') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = 'PV') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = 'PV') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = 'PV') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = 'PV') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = 'PV') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = 'PV') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = 'PV') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = 'PV') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = 'PV') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = 'PV') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = 'PV') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = 'PV') * pr_aa_dist_18;

pr_rcvalue9v := (integer)(pr_aa_code_01 = '9V') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9V') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9V') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9V') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9V') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9V') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9V') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9V') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9V') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9V') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9V') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9V') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9V') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9V') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9V') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9V') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9V') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9V') * pr_aa_dist_18;

pr_rcvalue9w := (integer)(pr_aa_code_01 = '9W') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9W') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9W') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9W') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9W') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9W') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9W') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9W') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9W') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9W') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9W') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9W') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9W') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9W') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9W') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9W') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9W') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9W') * pr_aa_dist_18;

pr_rcvalue9c := (integer)(pr_aa_code_01 = '9C') * pr_aa_dist_01 +
    (integer)(pr_aa_code_02 = '9C') * pr_aa_dist_02 +
    (integer)(pr_aa_code_03 = '9C') * pr_aa_dist_03 +
    (integer)(pr_aa_code_04 = '9C') * pr_aa_dist_04 +
    (integer)(pr_aa_code_05 = '9C') * pr_aa_dist_05 +
    (integer)(pr_aa_code_06 = '9C') * pr_aa_dist_06 +
    (integer)(pr_aa_code_07 = '9C') * pr_aa_dist_07 +
    (integer)(pr_aa_code_08 = '9C') * pr_aa_dist_08 +
    (integer)(pr_aa_code_09 = '9C') * pr_aa_dist_09 +
    (integer)(pr_aa_code_10 = '9C') * pr_aa_dist_10 +
    (integer)(pr_aa_code_11 = '9C') * pr_aa_dist_11 +
    (integer)(pr_aa_code_12 = '9C') * pr_aa_dist_12 +
    (integer)(pr_aa_code_13 = '9C') * pr_aa_dist_13 +
    (integer)(pr_aa_code_14 = '9C') * pr_aa_dist_14 +
    (integer)(pr_aa_code_15 = '9C') * pr_aa_dist_15 +
    (integer)(pr_aa_code_16 = '9C') * pr_aa_dist_16 +
    (integer)(pr_aa_code_17 = '9C') * pr_aa_dist_17 +
    (integer)(pr_aa_code_18 = '9C') * pr_aa_dist_18;

pr_lgt := -2.71014315492637 +
    pr_v01_w +
    pr_v02_w +
    pr_v03_w +
    pr_v04_w +
    pr_v05_w +
    pr_v06_w +
    pr_v07_w +
    pr_v08_w +
    pr_v09_w +
    pr_v10_w +
    pr_v11_w +
    pr_v12_w +
    pr_v13_w +
    pr_v14_w +
    pr_v15_w +
    pr_v16_w +
    pr_v17_w +
    pr_v18_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_pr := DATASET([
    {'9A', pr_rcvalue9A},
    {'27', pr_rcvalue27},
    {'98', pr_rcvalue98},
    {'9Q', pr_rcvalue9Q},
    {'80', pr_rcvalue80},
    {'9R', pr_rcvalue9R},
    {'9M', pr_rcvalue9M},
    {'36', pr_rcvalue36},
    {'9F', pr_rcvalue9F},
    {'9D', pr_rcvalue9D},
    {'99', pr_rcvalue99},
    {'PV', pr_rcvaluePV},
    {'9V', pr_rcvalue9V},
    {'9W', pr_rcvalue9W},
    {'9C', pr_rcvalue9C}
    ], ds_layout)(value > 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
//rc_dataset_pr_sorted := sort(rc_dataset_pr, rc_dataset_pr.value);
rc_dataset_pr_sorted := sort(rc_dataset_pr, -rc_dataset_pr.value);

r_rc1 := rc_dataset_pr_sorted[1].rc;
r_rc2 := rc_dataset_pr_sorted[2].rc;
r_rc3 := rc_dataset_pr_sorted[3].rc;
r_rc4 := rc_dataset_pr_sorted[4].rc;
r_rc5 := rc_dataset_pr_sorted[5].rc;
r_rc6 := rc_dataset_pr_sorted[6].rc;
r_rc7 := rc_dataset_pr_sorted[7].rc;
r_rc8 := rc_dataset_pr_sorted[8].rc;
r_rc9 := rc_dataset_pr_sorted[9].rc;
r_rc10 := rc_dataset_pr_sorted[10].rc;
r_rc11 := rc_dataset_pr_sorted[11].rc;
r_rc12 := rc_dataset_pr_sorted[12].rc;
r_rc13 := rc_dataset_pr_sorted[13].rc;
r_rc14 := rc_dataset_pr_sorted[14].rc;
r_rc15 := rc_dataset_pr_sorted[15].rc;
r_rc16 := rc_dataset_pr_sorted[16].rc;
r_rc17 := rc_dataset_pr_sorted[17].rc;
r_rc18 := rc_dataset_pr_sorted[18].rc;


r_vl1 := rc_dataset_pr_sorted[1].value;
r_vl2 := rc_dataset_pr_sorted[2].value;
r_vl3 := rc_dataset_pr_sorted[3].value;
r_vl4 := rc_dataset_pr_sorted[4].value;
r_vl5 := rc_dataset_pr_sorted[5].value;
r_vl6 := rc_dataset_pr_sorted[6].value;
r_vl7 := rc_dataset_pr_sorted[7].value;
r_vl8 := rc_dataset_pr_sorted[8].value;
r_vl9 := rc_dataset_pr_sorted[9].value;
r_vl10 := rc_dataset_pr_sorted[10].value;
r_vl11 := rc_dataset_pr_sorted[11].value;
r_vl12 := rc_dataset_pr_sorted[12].value;
r_vl13 := rc_dataset_pr_sorted[13].value;
r_vl14 := rc_dataset_pr_sorted[14].value;
r_vl15 := rc_dataset_pr_sorted[15].value;
r_vl16 := rc_dataset_pr_sorted[16].value;
r_vl17 := rc_dataset_pr_sorted[17].value;
r_vl18 := rc_dataset_pr_sorted[18].value;
//*************************************************************************************//

rc1_2 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := map(
    r_rc1 = '9Q' or r_rc2 = '9Q' or r_rc3 = '9Q' or r_rc4 = '9Q' 
    or r_rc5 = '9Q' or r_rc6 = '9Q' or r_rc7 = '9Q' or r_rc8 = '9Q' 
    or r_rc9 = '9Q' or r_rc10 = '9Q' or r_rc11 = '9Q' or r_rc12 = '9Q' 
    or r_rc13 = '9Q' or r_rc14 = '9Q' or r_rc15 = '9Q' or r_rc16 = '9Q' 
    or r_rc17 = '9Q' or r_rc18 = '9Q' => '9Q',
    r_rc1 = '9P' or r_rc2 = '9P' or r_rc3 = '9P' or r_rc4 = '9P' 
    or r_rc5 = '9P' or r_rc6 = '9P' or r_rc7 = '9P' or r_rc8 = '9P' 
    or r_rc9 = '9P' or r_rc10 = '9P' or r_rc11 = '9P' or r_rc12 = '9P' 
    or r_rc13 = '9P' or r_rc14 = '9P' or r_rc15 = '9P' or r_rc16 = '9P' 
    or r_rc17 = '9P' or r_rc18 = '9P' => '9P',
                                            '');


 rc2_c81 := map(
    //trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    //trim(rc3_2, LEFT, RIGHT) = '' => '',
   // trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     rc2_2);                              

                                     
rc3_c81 := map(
   // trim(rc1_2, LEFT, RIGHT) = '' => '',
   // trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
   // trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     rc3_2);

rc1_c81 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => _rc_inq,
   // trim(rc2_2, LEFT, RIGHT) = '' => '',
    //trim(rc3_2, LEFT, RIGHT) = '' => '',
   // trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     rc1_2);
                                     
 

rc4_c81 := map(
    //trim(rc1_2, LEFT, RIGHT) = '' => '',
    //trim(rc2_2, LEFT, RIGHT) = '' => '',
    //trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     rc4_2);


                                     
rc5_c81 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);                                     
                                     
                                     

rc1_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])),rc1_2, rc1_c81 );

rc3_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc3_2, rc3_c81);

rc2_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc2_2, rc2_c81);

rc5_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc5_c81, '');

rc4_1 := if(not((rc1_2 in ['9Q', '9P'])) and not((rc2_2 in ['9Q', '9P'])) and not((rc3_2 in ['9Q', '9P'])) and not((rc4_2 in ['9Q', '9P'])), rc4_2, rc4_c81);




iv_rv5_unscorable := if(riskview.constants.noscore(NAS_Summary,NAP_Summary, add1_naprop, TrueDID), 1, 0);
base := 700;

pts := 40;

lgt := ln(0.1475 / (1 - 0.1475));

RVC1805_2_0 := if(iv_rv5_unscorable =1, 222, round(max((real)501, min(900, if(base + pts * (pr_lgt - lgt) / ln(2) = NULL, -NULL, base + pts * (pr_lgt - lgt) / ln(2))))));

rc1 := map(
    RVC1805_2_0 = 222 => '9X',
    RVC1805_2_0 = 900 => '',
                         rc1_1);

rc3 := map(
    RVC1805_2_0 = 222 => '',
    RVC1805_2_0 = 900 => '',
                         rc3_1);

rc2 := map(
    RVC1805_2_0 = 222 => '',
    RVC1805_2_0 = 900 => '',
                         rc2_1);

rc5 := map(
    RVC1805_2_0 = 222 => '',
    RVC1805_2_0 = 900 => '',
                         rc5_1);

rc4 := map(
    RVC1805_2_0 = 222 => '',
    RVC1805_2_0 = 900 => '',
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
													RVC1805_2_0 = 200 =>	DATASET([{'02'}], HRILayout),
													RVC1805_2_0 = 222 =>	DATASET([{'9X'}], HRILayout),
													RVC1805_2_0 = 900 =>	DATASET([{' '}], HRILayout),
													RVC1805_2_0 BETWEEN 501 AND 720 AND reasons[1].HRI NOT IN ['', '36'] AND reasons[2].HRI = '' => DATASET([{reasons[1].HRI}, {'36'}], HRILayout),
													RVC1805_2_0 BETWEEN 501 AND 720 AND reasons[1].HRI != '9E' AND reasons[2].HRI = ''					 => DATASET([{reasons[1].HRI}, {'9E'}], HRILayout),
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
                    self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
                    self.iv_phnpop_x_nap_summary          := iv_phnpop_x_nap_summary;
                    self.lien_adl_li_count_pos            := lien_adl_li_count_pos;
                    self.lien_adl_count_li                := lien_adl_count_li;
                    self.lien_adl_l2_count_pos            := lien_adl_l2_count_pos;
                    self.lien_adl_count_l2                := lien_adl_count_l2;
                    self._src_lien_adl_count              := _src_lien_adl_count;
                    self.iv_src_liens_adl_count           := iv_src_liens_adl_count;
                    self._src_prop_adl_count              := _src_prop_adl_count;
                    self.iv_avg_lres                      := iv_avg_lres;
                    self.iv_bst_own_prop_x_addr_naprop    := iv_bst_own_prop_x_addr_naprop;
                    self.iv_in001_estimated_income        := iv_in001_estimated_income;
                    self.iv_iq001_inq_count12             := iv_iq001_inq_count12;
                    self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
                    self.prop_adl_lseen_p                 := prop_adl_lseen_p;
                    self._prop_adl_lseen_p                := _prop_adl_lseen_p;
                    self._src_prop_adl_lseen              := _src_prop_adl_lseen;
                    self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
                    self.iv_avg_prop_assess_purch_amt     := iv_avg_prop_assess_purch_amt;
                    self.iv_addrs_per_adl                 := iv_addrs_per_adl;
                    self.iv_inq_per_addr                  := (string)iv_inq_per_addr;
                    self._gong_did_first_seen             := _gong_did_first_seen;
                    self.iv_mos_since_gong_did_fst_seen   := iv_mos_since_gong_did_fst_seen;
                    self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
                    self.iv_rec_vehx_level                := iv_rec_vehx_level;
                    self.iv_inq_ssns_per_adl              := iv_inq_ssns_per_adl;
                    self.iv_src_property_adl_count        := iv_src_property_adl_count;
                    self.iv_input_addr_not_most_recent    := iv_input_addr_not_most_recent;
                    self.iv_lnames_per_adl                := iv_lnames_per_adl;
                    self.prop_adl_count_p                 := prop_adl_count_p;
                    self.prop_adl_p_count_pos             := prop_adl_p_count_pos;
                    self.pr_v01_w                         := pr_v01_w;
                    self.pr_aa_dist_01                    := pr_aa_dist_01;
                    self.pr_aa_code_01                    := pr_aa_code_01;
                    self.pr_v02_w                         := pr_v02_w;
                    self.pr_aa_dist_02                    := pr_aa_dist_02;
                    self.pr_aa_code_02                    := pr_aa_code_02;
                    self.pr_v03_w                         := pr_v03_w;
                    self.pr_aa_dist_03                    := pr_aa_dist_03;
                    self.pr_aa_code_03                    := pr_aa_code_03;
                    self.pr_v04_w                         := pr_v04_w;
                    self.pr_aa_dist_04                    := pr_aa_dist_04;
                    self.pr_aa_code_04                    := pr_aa_code_04;
                    self.pr_v05_w                         := pr_v05_w;
                    self.pr_aa_dist_05                    := pr_aa_dist_05;
                    self.pr_aa_code_05                    := pr_aa_code_05;
                    self.pr_v06_w                         := pr_v06_w;
                    self.pr_aa_dist_06                    := pr_aa_dist_06;
                    self.pr_aa_code_06                    := pr_aa_code_06;
                    self.pr_v07_w                         := pr_v07_w;
                    self.pr_aa_dist_07                    := pr_aa_dist_07;
                    self.pr_aa_code_07                    := pr_aa_code_07;
                    self.pr_v08_w                         := pr_v08_w;
                    self.pr_aa_dist_08                    := pr_aa_dist_08;
                    self.pr_aa_code_08                    := pr_aa_code_08;
                    self.pr_v09_w                         := pr_v09_w;
                    self.pr_aa_dist_09                    := pr_aa_dist_09;
                    self.pr_aa_code_09                    := pr_aa_code_09;
                    self.pr_v10_w                         := pr_v10_w;
                    self.pr_aa_dist_10                    := pr_aa_dist_10;
                    self.pr_aa_code_10                    := pr_aa_code_10;
                    self.pr_v11_w                         := pr_v11_w;
                    self.pr_aa_dist_11                    := pr_aa_dist_11;
                    self.pr_aa_code_11                    := pr_aa_code_11;
                    self.pr_v12_w                         := pr_v12_w;
                    self.pr_aa_dist_12                    := pr_aa_dist_12;
                    self.pr_aa_code_12                    := pr_aa_code_12;
                    self.pr_v13_w                         := pr_v13_w;
                    self.pr_aa_dist_13                    := pr_aa_dist_13;
                    self.pr_aa_code_13                    := pr_aa_code_13;
                    self.pr_v14_w                         := pr_v14_w;
                    self.pr_aa_dist_14                    := pr_aa_dist_14;
                    self.pr_aa_code_14                    := pr_aa_code_14;
                    self.pr_v15_w                         := pr_v15_w;
                    self.pr_aa_dist_15                    := pr_aa_dist_15;
                    self.pr_aa_code_15                    := pr_aa_code_15;
                    self.pr_v16_w                         := pr_v16_w;
                    self.pr_aa_dist_16                    := pr_aa_dist_16;
                    self.pr_aa_code_16                    := pr_aa_code_16;
                    self.pr_v17_w                         := pr_v17_w;
                    self.pr_aa_dist_17                    := pr_aa_dist_17;
                    self.pr_aa_code_17                    := pr_aa_code_17;
                    self.pr_v18_w                         := pr_v18_w;
                    self.pr_aa_dist_18                    := pr_aa_dist_18;
                    self.pr_aa_code_18                    := pr_aa_code_18;
                    self.pr_rcvalue27                     := pr_rcvalue27;
                    self.pr_rcvalue9m                     := pr_rcvalue9m;
                    self.pr_rcvalue9a                     := pr_rcvalue9a;
                    self.pr_rcvalue9c                     := pr_rcvalue9c;
                    self.pr_rcvalue36                     := pr_rcvalue36;
                    self.pr_rcvalue9f                     := pr_rcvalue9f;
                    self.pr_rcvalue99                     := pr_rcvalue99;
                    self.pr_rcvalue98                     := pr_rcvalue98;
                    self.pr_rcvalue9d                     := pr_rcvalue9d;
                    self.pr_rcvalue9q                     := pr_rcvalue9q;
                    self.pr_rcvaluepv                     := pr_rcvaluepv;
                    self.pr_rcvalue80                     := pr_rcvalue80;
                    self.pr_rcvalue9r                     := pr_rcvalue9r;
                    self.pr_rcvalue9w                     := pr_rcvalue9w;
                    self.pr_rcvalue9v                     := pr_rcvalue9v;
                    self.pr_lgt                           := pr_lgt;
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
                    self.r_rc11                           := r_rc11;
                    self.r_rc12                           := r_rc12;
                    self.r_rc13                           := r_rc13;
                    self.r_rc14                           := r_rc14;
                    self.r_rc15                           := r_rc15;
                    self.r_rc16                           := r_rc16;
                    self.r_rc17                           := r_rc17;
                    self.r_rc18                           := '';
                    self.r_rc19                           := '';
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
                    self.r_vl11                           := r_vl11;
                    self.r_vl12                           := r_vl12;
                    self.r_vl13                           := r_vl13;
                    self.r_vl14                           := r_vl14;
                    self.r_vl15                           := r_vl15;
                    self.r_vl16                           := r_vl16;
                    self.r_vl17                           := r_vl17;
                    self.r_vl18                           := 0;
                    self.r_vl19                           := 0;
                    self._rc_inq                          := _rc_inq;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.RVC1805_2_0                      := RVC1805_2_0;
                    self.rc3                              := rc3;
                    self.rc4                              := rc4;
                    self.rc5                              := rc5;
                    self.rc1                              := rc1;
                    self.rc2                              := rc2;
		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := IF(LEFT.hri = '', '00', LEFT.hri),
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(reasonCodes[1].HRI IN ['91','92','93','94'] => (STRING3)((INTEGER)reasonCodes[1].HRI + 10),
											reasonCodes[1].HRI = '35'										=> '100',
																																		 (STRING)RVC1805_2_0);

		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
