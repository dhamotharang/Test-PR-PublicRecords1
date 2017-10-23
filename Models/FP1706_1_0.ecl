import Std, risk_indicators, riskwise, riskwisefcra, ut, easi, Models;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1706_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam,
                  integer1 num_reasons)
									 := FUNCTION
									
	//	FP_DEBUG := True;
		FP_DEBUG := False;
		
		isFCRA := False;

	#if(FP_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
Integer seq;
integer sysdate;
Integer	 banko_flag;
string	 rv_p85_phn_risk_level;
Integer	 nf_add_dist_input_to_curr;
Integer	 _in_dob;
Real	   yr_in_dob;
Integer	 yr_in_dob_int;
Integer	 rv_comb_age;
Integer	 rv_l80_inp_avm_autoval;
Integer	 nf_inq_dob_ver_count;
Integer	 nf_phone_ver_insurance;
Integer	 iv_c13_avg_lres;
Boolean	 mortgage_present;
string	 mortgage_type;
string	 iv_curr_add_mortgage_type;
Integer	 br_first_seen_char;
Integer	 _br_first_seen;
Integer	 rv_mos_since_br_first_seen;
Real	 nf_add_curr_mobility_index;
Real	 nf_hh_pct_property_owners;
Integer	 nf_hh_tot_derog;
Integer	 nf_average_rel_income;
Integer	 nf_average_rel_distance;
Real	 nf_pct_rel_prop_owned;
Real nf_pct_rel_prop_sold;
string	 nf_fp_addrchangeecontrajindex;
real 	 bfp_v01_w;
Real	 bfp_v02_w;
Real	 bfp_v03_w;
Real	 bfp_v04_w;
Real	 bfp_v05_w;
Real	 bfp_v06_w;
Real	 bfp_v07_w;
Real	 bfp_v08_w;
Real	 bfp_v09_w;
Real	 bfp_v10_w;
Real	 bfp_v11_w;
Real	 bfp_v12_w;
Real	 bfp_v13_w;
Real	 bfp_v14_w;
Real	 bfp_v15_w;
Real	 bfp_v16_w;
Real	 bfp_v17_w;
Real	 bfp_v18_w;
Real	 bfp_lgt;
Integer	 base;
Integer	 pts;
Real	 lgt;
Integer	 fp1706_1_0;

	
	
			models.layouts.layout_fp1109;
			Risk_Indicators.Layout_Boca_Shell clam;
			END;
			
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layouts.layout_fp1109 doModel( clam le ) := TRANSFORM
		
  #end	

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	addrpop                          := le.input_validation.address;
	hphnpop                          := le.input_validation.homephone;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_pop                    := le.addrPop;
	add_dist_input_to_curr           := le.address_verification.distance_in_2_h1;
	add_curr_mortgage_date           := le.address_verification.address_history_1.mortgage_date;
	add_curr_mortgage_type           := le.address_verification.address_history_1.mortgage_type;
	add_curr_occupants_1yr           := le.addr_risk_summary2.occupants_1yr;
	add_curr_turnover_1yr_in         := le.addr_risk_summary2.turnover_1yr_in;
	add_curr_turnover_1yr_out        := le.addr_risk_summary2.turnover_1yr_out;
	add_curr_pop                     := le.addrPop2;
	avg_lres                         := le.other_address_info.avg_lres;
	phone_ver_insurance              := le.insurance_phones_summary.Insurance_Phone_Verification;
	inq_dob_ver_count                := le.acc_logs.inquiry_dob_ver_ct;
	inq_banko_am_first_seen          := le.acc_logs.am_first_seen_date;
	inq_banko_cm_last_seen           := le.acc_logs.cm_last_seen_date;
	inq_banko_om_first_seen          := le.acc_logs.om_first_seen_date;
	inq_banko_om_last_seen           := le.acc_logs.om_last_seen_date;
	br_first_seen                    := le.employment.first_seen_date;
	fp_addrchangeecontrajindex       := le.fdattributesv2.addrchangeecontrajectoryindex;
	hh_members_ct                    := le.hhid_summary.hh_members_ct;
	hh_property_owners_ct            := le.hhid_summary.hh_property_owners_ct;
	hh_tot_derog                     := le.hhid_summary.hh_tot_derog;
	rel_count                        := le.relatives.relative_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.relatives.relative_within500miles_count;
	rel_withinother_count            := le.relatives.relative_withinother_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	rel_incomeunder50_count          := le.relatives.relative_incomeunder50_count;
	rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	inferred_age                     := le.inferred_age;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (string)ut.getdate, (string6)le.historydate+'01'));

banko_flag := __common__(map(
    not(truedid)                => NULL,
    (string)inq_banko_cm_last_seen   != ''   => 1,
    (string)inq_banko_om_first_seen  != '' => 3,
    (string)inq_banko_om_last_seen   != ''   => 6,
    (string)inq_banko_am_first_seen  != ''  => 12,
                               0));

rv_p85_phn_risk_level := map(
    not(hphnpop)                                                                                    => '',
   (string)rc_hriskphoneflag = '6' or rc_hphonetypeflag = '5' or rc_hphonevalflag = '3' or rc_addrcommflag = '' => 'HIGH RISK',
   (string)rc_phonevalflag = '0' or rc_hphonevalflag = '0' or rc_phonetype = '5'                                 => 'INVALID',
   (string)rc_hriskphoneflag = '5' or trim(trim(nap_status, LEFT), LEFT, RIGHT) = 'D'                        => 'DISCONNECTED',
   (string)rc_pwphonezipflag = '4'                                                                           => 'NOT ISSUED',
                                                                                                       'NONE');

nf_add_dist_input_to_curr := map(
    not(add_curr_pop and add_input_pop) => NULL,
    add_input_isbestmatch               => -1,
                                           min(9999, if(add_dist_input_to_curr = NULL, -NULL, add_dist_input_to_curr)));

_in_dob := common.sas_date((string)(in_dob));

yr_in_dob := if(_in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);

yr_in_dob_int := if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

rv_comb_age := map(
    yr_in_dob_int > 0            => yr_in_dob_int,
    inferred_age > 0 and truedid => inferred_age,
                                    NULL);

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

nf_inq_dob_ver_count := if(not(truedid), NULL, inq_dob_ver_count);

//nf_phone_ver_insurance := if(not(truedid), NULL, (integer)phone_ver_insurance);
nf_phone_ver_insurance := __common__( if(not(truedid), NULL, (Integer)trim(phone_ver_insurance, LEFT)));

iv_c13_avg_lres := if(not(truedid), NULL, min(if(avg_lres = NULL, -NULL, avg_lres), 999));

mortgage_type := if(truedid and add_curr_pop, (string10)add_curr_mortgage_type, '');

mortgage_present := __common__(if(truedid and add_curr_pop, not((add_curr_mortgage_date in [0, NULL])), False));

iv_curr_add_mortgage_type := map(
    not(truedid and add_curr_pop)                         => '',
    (mortgage_type in ['CNV', 'N'])                       => 'CONVENTIONAL   ',
    (mortgage_type in ['FHA', 'G', 'VA'])                 => 'GOVERNMENT     ',
    (mortgage_type in ['1', 'D'])                         => 'PIGGYBACK      ',
    (mortgage_type in ['2', 'E', 'R', 'C'])               => 'EQUITY LOAN    ',
    (mortgage_type in ['I', 'K', 'O', 'LHM', 'T', 'SBA']) => 'COMMERCIAL     ',
    (mortgage_type in ['H', 'J'])                         => 'HIGH-RISK      ',
    (mortgage_type in ['PMM', 'PP', 'S', 'L'])            => 'NON-TRADITIONAL',
    (mortgage_type in ['U'])                              => 'UNKNOWN        ',
    not(mortgage_type = '')                             => 'OTHER          ',
    mortgage_present                                      => 'UNKNOWN        ',
                                                             'NO MORTGAGE');

br_first_seen_char := br_first_seen;

_br_first_seen := common.sas_date((string)(br_first_seen_char));

rv_mos_since_br_first_seen := map(
    not(truedid)          => NULL,
    _br_first_seen = NULL => -1,
                             min(if(if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _br_first_seen) / (365.25 / 12) >= 0, truncate((sysdate - _br_first_seen) / (365.25 / 12)), roundup((sysdate - _br_first_seen) / (365.25 / 12)))), 999));

nf_add_curr_mobility_index := map(
    not(addrpop)                => NULL,
    add_curr_occupants_1yr <= 0 => -1,
                                   round(if(max(add_curr_turnover_1yr_in, add_curr_turnover_1yr_out) = NULL, NULL, sum(if(add_curr_turnover_1yr_in = NULL, 0, add_curr_turnover_1yr_in), if(add_curr_turnover_1yr_out = NULL, 0, add_curr_turnover_1yr_out))) / add_curr_occupants_1yr/0.1)*0.1);

nf_hh_pct_property_owners := map(
    not(truedid)      => NULL,
    hh_members_ct = 0 => -1,
                         hh_property_owners_ct / hh_members_ct);

nf_hh_tot_derog := if(not(truedid), NULL, min(if(hh_tot_derog = NULL, -NULL, hh_tot_derog), 999));

nf_average_rel_income := map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 => -1,
    if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     if (if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))) >= 0, truncate(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count)))), roundup(if(max(rel_incomeunder25_count * 25, rel_incomeunder50_count * 50, rel_incomeunder75_count * 75, rel_incomeunder100_count * 100, rel_incomeover100_count * 125) = NULL, NULL, sum(if(rel_incomeunder25_count * 25 = NULL, 0, rel_incomeunder25_count * 25), if(rel_incomeunder50_count * 50 = NULL, 0, rel_incomeunder50_count * 50), if(rel_incomeunder75_count * 75 = NULL, 0, rel_incomeunder75_count * 75), if(rel_incomeunder100_count * 100 = NULL, 0, rel_incomeunder100_count * 100), if(rel_incomeover100_count * 125 = NULL, 0, rel_incomeover100_count * 125))) / if(max(rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count, rel_incomeunder100_count, rel_incomeover100_count) = NULL, NULL, sum(if(rel_incomeunder25_count = NULL, 0, rel_incomeunder25_count), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count), if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count))))) * 1000);

nf_average_rel_distance := map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))))));

nf_pct_rel_prop_owned := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_prop_owned_count / rel_count);

nf_pct_rel_prop_sold := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_prop_sold_count / rel_count);

nf_fp_addrchangeecontrajindex := if(not(truedid), NULL, (integer)fp_addrchangeecontrajindex);
// nf_fp_addrchangeecontrajindex :=__common__( if(not(truedid) , '  ', trim((string)fp_addrchangeecontrajindex, LEFT)));

bfp_v01_w := map(
    rv_p85_phn_risk_level = ''                            => 0,
    (rv_p85_phn_risk_level in ['DISCONNECTED', 'HIGH RISK']) => 0.538887168632419,
    (rv_p85_phn_risk_level in ['INVALID'])                   => 0.934145130672143,
    (rv_p85_phn_risk_level in ['NONE'])                      => -0.0645061366148978,
                                                                0);

bfp_v02_w := map(
    nf_add_dist_input_to_curr = NULL   => 0,
    nf_add_dist_input_to_curr = -1     => -0.0208018506955358,
    nf_add_dist_input_to_curr <= 6.5   => -0.217070507691715,
    nf_add_dist_input_to_curr <= 13.5  => -0.0763270927915628,
    nf_add_dist_input_to_curr <= 21.5  => 0.060833424560581,
    nf_add_dist_input_to_curr <= 53.5  => 0.153646212546292,
    nf_add_dist_input_to_curr <= 141.5 => 0.252016538516469,
    nf_add_dist_input_to_curr <= 420   => 0.266018349278286,
    nf_add_dist_input_to_curr <= 576   => 0.514757768380462,
    nf_add_dist_input_to_curr <= 947.5 => 0.62361650352424,
    nf_add_dist_input_to_curr <= 1283  => 0.67022789540006,
                                          0.931308092206529);

bfp_v03_w := map(
    rv_comb_age = NULL  => 0,
    rv_comb_age = -1    => 0,
    rv_comb_age <= 31.5 => -0.459738407244961,
    rv_comb_age <= 34.5 => -0.418459045544624,
    rv_comb_age <= 36.5 => -0.326158361242579,
    rv_comb_age <= 39.5 => -0.263344965937859,
    rv_comb_age <= 41.5 => -0.176887228569966,
    rv_comb_age <= 47.5 => -0.00393928585546713,
    rv_comb_age <= 58.5 => 0.236170167477662,
    rv_comb_age <= 65.5 => 0.551084181241352,
    rv_comb_age <= 77.5 => 0.901139333714079,
                           1.43353897177625);

bfp_v04_w := map(
    rv_l80_inp_avm_autoval = NULL      => 0,
    rv_l80_inp_avm_autoval = -1        => 0,
    rv_l80_inp_avm_autoval <= 103146.5 => -0.0690932722591369,
    rv_l80_inp_avm_autoval <= 148922.5 => -0.0434848499125266,
    rv_l80_inp_avm_autoval <= 183613.5 => 0.0609100187465395,
    rv_l80_inp_avm_autoval <= 224307   => 0.108441382088817,
    rv_l80_inp_avm_autoval <= 241268.5 => 0.146648249773466,
    rv_l80_inp_avm_autoval <= 318621   => 0.209201800126431,
    rv_l80_inp_avm_autoval <= 453672   => 0.310618889564978,
    rv_l80_inp_avm_autoval <= 565461   => 0.418436859154554,
                                          0.449785245662118);

bfp_v05_w := map(
    nf_inq_dob_ver_count = NULL              => 0,
    nf_inq_dob_ver_count = -1                => 0,
    nf_inq_dob_ver_count <= 0.5              => 0.414769462620408,
    nf_inq_dob_ver_count <= 1.5              => 0.374230551650879,
    nf_inq_dob_ver_count <= 2.5              => 0.330934389734909,
    nf_inq_dob_ver_count <= 3.5              => 0.160323704696273,
    nf_inq_dob_ver_count <= 4.5              => 0.139769277787434,
    nf_inq_dob_ver_count <= 6.5              => 0.00881639309069751,
    nf_inq_dob_ver_count <= 8.5              => -0.214419267577194,
    nf_inq_dob_ver_count <= 12               => -0.337820874443044,
    nf_inq_dob_ver_count <= 16               => -0.480370987976578,
    nf_inq_dob_ver_count <= 181.600000000003 => -0.724168119889294,
                                                0.381509512759693);

bfp_v06_w := map(
    banko_flag = NULL => 0,
    banko_flag = -1   => 0,
    banko_flag <= 0.5 => 0.066153313766676,
                         -0.0885617138331061);

bfp_v07_w := map(
    nf_phone_ver_insurance = NULL => 0,
    nf_phone_ver_insurance = -1   => 0,
    nf_phone_ver_insurance <= 0.5 => 0.0372704002733996,
    nf_phone_ver_insurance <= 2   => 0.0258270504015576,
    nf_phone_ver_insurance <= 3.5 => -0.00303507649569574,
                                     -0.0255332293669218);

bfp_v08_w := map(
    iv_c13_avg_lres = NULL   => 0,
    iv_c13_avg_lres = -1     => 0,
    iv_c13_avg_lres <= 30.5  => -0.207776053678562,
    iv_c13_avg_lres <= 52.5  => -0.133071737527361,
    iv_c13_avg_lres <= 66.5  => -0.109034269893387,
    iv_c13_avg_lres <= 77.5  => -0.0446401545348786,
    iv_c13_avg_lres <= 88.5  => -0.01207746329964,
    iv_c13_avg_lres <= 101.5 => 0.0351795426387404,
    iv_c13_avg_lres <= 129.5 => 0.117017167419098,
    iv_c13_avg_lres <= 158.5 => 0.213289640909212,
    iv_c13_avg_lres <= 230.5 => 0.307620882707924,
                                0.462136287295314);

bfp_v09_w := map(
    iv_curr_add_mortgage_type = ''                   => 0,
    (iv_curr_add_mortgage_type in ['CONVENTIONAL'])    => 0.325828921546121,
    (iv_curr_add_mortgage_type in ['GOVERNMENT'])      => 0.0809670007947254,
    (iv_curr_add_mortgage_type in ['NO MORTGAGE'])     => -0.116350087460509,
    (iv_curr_add_mortgage_type in ['NON-TRADITIONAL']) => 0.0865912093587715,
    (iv_curr_add_mortgage_type in ['UNKNOWN'])         => 0.21706730208507,
                                                          0);

bfp_v10_w := map(
    rv_mos_since_br_first_seen = NULL   => 0,
    rv_mos_since_br_first_seen = -1     => -0.0213706554234803,
    rv_mos_since_br_first_seen <= 33.5  => 0.0271884344974802,
    rv_mos_since_br_first_seen <= 68.5  => 0.0643958871850965,
    rv_mos_since_br_first_seen <= 114.5 => 0.0897541158532651,
    rv_mos_since_br_first_seen <= 146.5 => 0.115246661793034,
    rv_mos_since_br_first_seen <= 190.5 => 0.131366792957837,
    rv_mos_since_br_first_seen <= 279.5 => 0.162486346905638,
                                           0.198771975457779);

bfp_v11_w := map(
    nf_add_curr_mobility_index = NULL  => 0,
    nf_add_curr_mobility_index = -1    => 0.0496845837408175,
    nf_add_curr_mobility_index <= 0.25 => 0.0687864891080348,
    nf_add_curr_mobility_index <= 0.35 => -0.0231982161754988,
                                          -0.0398007034263772);

bfp_v12_w := map(
    nf_hh_pct_property_owners = NULL           => 0,
    nf_hh_pct_property_owners = -1             => 0,
    nf_hh_pct_property_owners <= 0.18875       => -0.384236350177487,
    nf_hh_pct_property_owners <= 0.30384615385 => -0.109765015397088,
    nf_hh_pct_property_owners <= 0.3693181818  => 0.0956211772031948,
    nf_hh_pct_property_owners <= 0.5634920635  => 0.214774744384292,
    nf_hh_pct_property_owners <= 0.64583333335 => 0.443087858527661,
                                                  0.480876265105146);

bfp_v13_w := map(
    nf_hh_tot_derog = NULL => 0,
    nf_hh_tot_derog = -1   => 0,
    nf_hh_tot_derog <= 0.5 => 0.185018099338913,
    nf_hh_tot_derog <= 1.5 => -0.00505255614245717,
    nf_hh_tot_derog <= 2.5 => -0.0623530792191897,
    nf_hh_tot_derog <= 3.5 => -0.083071301248535,
    nf_hh_tot_derog <= 5.5 => -0.145219096613504,
                              -0.223149378892054);

bfp_v14_w := map(
    nf_average_rel_income = NULL    => 0,
    nf_average_rel_income = -1      => 0.0344069459376685,
    nf_average_rel_income <= 49500  => -0.655818691785407,
    nf_average_rel_income <= 54500  => -0.428509562784333,
    nf_average_rel_income <= 56500  => -0.291289998235114,
    nf_average_rel_income <= 59500  => -0.196443512052447,
    nf_average_rel_income <= 62500  => -0.0459453814455369,
    nf_average_rel_income <= 65500  => 0.0103427879085265,
    nf_average_rel_income <= 77500  => 0.241892627146828,
    nf_average_rel_income <= 88500  => 0.629013246940939,
    nf_average_rel_income <= 100500 => 0.999547342592846,
                                       1.32351922481102);

bfp_v15_w := map(
    nf_average_rel_distance = NULL   => 0,
    nf_average_rel_distance = -1     => 0.0232705142608536,
    nf_average_rel_distance <= 133.5 => -0.135152184325122,
    nf_average_rel_distance <= 152.5 => -0.106075486933915,
    nf_average_rel_distance <= 182.5 => -0.0674225808925426,
    nf_average_rel_distance <= 234.5 => -0.013116248243622,
    nf_average_rel_distance <= 257.5 => 0.0332561422498283,
    nf_average_rel_distance <= 339   => 0.0556391479067213,
    nf_average_rel_distance <= 511.5 => 0.107955250405523,
    nf_average_rel_distance <= 830.5 => 0.244965358129045,
    nf_average_rel_distance <= 965.5 => 0.378744425137038,
                                        0.693965713656601);

bfp_v16_w := map(
    nf_pct_rel_prop_owned = NULL           => 0,
    nf_pct_rel_prop_owned = -1             => 0.0252724275847967,
    nf_pct_rel_prop_owned <= 0.16515151515 => -0.392475789651219,
    nf_pct_rel_prop_owned <= 0.2474489796  => -0.354832597093394,
    nf_pct_rel_prop_owned <= 0.3304597701  => -0.354656634556333,
    nf_pct_rel_prop_owned <= 0.4962686567  => -0.14096895170271,
    nf_pct_rel_prop_owned <= 0.5976190476  => 0.0679821868560851,
    nf_pct_rel_prop_owned <= 0.6582156611  => 0.138664946073504,
    nf_pct_rel_prop_owned <= 0.71240601505 => 0.224588708144656,
    nf_pct_rel_prop_owned <= 0.79772727275 => 0.28039828644792,
    nf_pct_rel_prop_owned <= 0.9875        => 0.340933296887335,
                                              0.511327542929843);

bfp_v17_w := map(
    nf_pct_rel_prop_sold = NULL           => 0,
    nf_pct_rel_prop_sold = -1             => 0.00782475763679923,
    nf_pct_rel_prop_sold <= 0.1195238095  => -0.0649222330463077,
    nf_pct_rel_prop_sold <= 0.16530054645 => -0.0373971303928323,
    nf_pct_rel_prop_sold <= 0.19836065575 => 0.00477870221032912,
    nf_pct_rel_prop_sold <= 0.21884700665 => 0.0101099968262874,
    nf_pct_rel_prop_sold <= 0.2472222222  => 0.032032203518696,
    nf_pct_rel_prop_sold <= 0.28348214285 => 0.0514053256319509,
    nf_pct_rel_prop_sold <= 0.3294573643  => 0.0704649006102443,
    nf_pct_rel_prop_sold <= 0.37354651165 => 0.103679529897183,
    nf_pct_rel_prop_sold <= 0.57738095235 => 0.151132550285989,
                                             0.207022726851703);

bfp_v18_w := map(
    nf_fp_addrchangeecontrajindex = NULL => 0,
    nf_fp_addrchangeecontrajindex = -1   => -0.0335064331908073,
    nf_fp_addrchangeecontrajindex <= 1.5 => -0.169539333766495,
    nf_fp_addrchangeecontrajindex <= 2.5 => -0.0559971315273276,
    nf_fp_addrchangeecontrajindex <= 3.5 => 0.0821320779489543,
    nf_fp_addrchangeecontrajindex <= 4.5 => 0.255071595144183,
    nf_fp_addrchangeecontrajindex <= 5.5 => 0.386916119768208,
                                            0.459712784402882);

bfp_lgt := -1.77171344268313 +
    bfp_v01_w +
    bfp_v02_w +
    bfp_v03_w +
    bfp_v04_w +
    bfp_v05_w +
    bfp_v06_w +
    bfp_v07_w +
    bfp_v08_w +
    bfp_v09_w +
    bfp_v10_w +
    bfp_v11_w +
    bfp_v12_w +
    bfp_v13_w +
    bfp_v14_w +
    bfp_v15_w +
    bfp_v16_w +
    bfp_v17_w +
    bfp_v18_w;

base := 875;

pts := 45;

lgt := -ln((242956 - 1561) / 1561);

fp1706_1_0 := min(if(max(round(base + pts * (-bfp_lgt + lgt) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (-bfp_lgt + lgt) / ln(2)), 300)), 999);


																																	 
//*************************************************************************************//
//     End Generated ECL Code
//*************************************************************************************//

	#if(FP_DEBUG)
		/* Model Input Variables */
								//		self.seq 															:= le.seq
                    self.sysdate                          := sysdate;
                    self.banko_flag                       := banko_flag;
                    self.rv_p85_phn_risk_level            := rv_p85_phn_risk_level;
                    self.nf_add_dist_input_to_curr        := nf_add_dist_input_to_curr;
                    self._in_dob                          := _in_dob;
                    self.yr_in_dob                        := yr_in_dob;
                    self.yr_in_dob_int                    := yr_in_dob_int;
                    self.rv_comb_age                      := rv_comb_age;
                    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
                    self.nf_inq_dob_ver_count             := nf_inq_dob_ver_count;
                    self.nf_phone_ver_insurance           := nf_phone_ver_insurance;
                    self.iv_c13_avg_lres                  := iv_c13_avg_lres;
                    self.mortgage_present                 := mortgage_present;
                    self.mortgage_type                    := mortgage_type;
                    self.iv_curr_add_mortgage_type        := iv_curr_add_mortgage_type;
                    self.br_first_seen_char               := br_first_seen_char;
                    self._br_first_seen                   := _br_first_seen;
                    self.rv_mos_since_br_first_seen       := rv_mos_since_br_first_seen;
                    self.nf_add_curr_mobility_index       := nf_add_curr_mobility_index;
                    self.nf_hh_pct_property_owners        := nf_hh_pct_property_owners;
                    self.nf_hh_tot_derog                  := nf_hh_tot_derog;
                    self.nf_average_rel_income            := nf_average_rel_income;
                    self.nf_average_rel_distance          := nf_average_rel_distance;
                    self.nf_pct_rel_prop_owned            := nf_pct_rel_prop_owned;
                    self.nf_pct_rel_prop_sold             := nf_pct_rel_prop_sold;
                    self.nf_fp_addrchangeecontrajindex    := (string)nf_fp_addrchangeecontrajindex;
                    self.bfp_v01_w                        := bfp_v01_w;
                    self.bfp_v02_w                        := bfp_v02_w;
                    self.bfp_v03_w                        := bfp_v03_w;
                    self.bfp_v04_w                        := bfp_v04_w;
                    self.bfp_v05_w                        := bfp_v05_w;
                    self.bfp_v06_w                        := bfp_v06_w;
                    self.bfp_v07_w                        := bfp_v07_w;
                    self.bfp_v08_w                        := bfp_v08_w;
                    self.bfp_v09_w                        := bfp_v09_w;
                    self.bfp_v10_w                        := bfp_v10_w;
                    self.bfp_v11_w                        := bfp_v11_w;
                    self.bfp_v12_w                        := bfp_v12_w;
                    self.bfp_v13_w                        := bfp_v13_w;
                    self.bfp_v14_w                        := bfp_v14_w;
                    self.bfp_v15_w                        := bfp_v15_w;
                    self.bfp_v16_w                        := bfp_v16_w;
                    self.bfp_v17_w                        := bfp_v17_w;
                    self.bfp_v18_w                        := bfp_v18_w;
                    self.bfp_lgt                          := bfp_lgt;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.lgt                              := lgt;
                    self.fp1706_1_0                       := fp1706_1_0;
										

	 SELF.clam := le;
#end

	 self.seq := le.seq;
	// self.StolenIdentityIndex := (string) custstolidindex;
	// self.SyntheticIdentityIndex:= (string) custsynthidindex;
	// self.ManipulatedIdentityIndex:= (string) custmanipidindex;
	// self.VulnerableVictimIndex := (string) custvulnvicindex;
	// self.FriendlyFraudIndex                := (string) custfriendfrdindex;
	// self.SuspiciousActivityIndex := (string) custsuspactindex;
   ritmp :=  Models.fraudpoint3_reasons(le, blank_ip, num_reasons);
	 reasons := Models.Common.checkFraudPointRC34(FP1706_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)FP1706_1_0;
	self := [];
	
END;

model :=   project(clam, doModel(left) );
	
	return model;
END;


