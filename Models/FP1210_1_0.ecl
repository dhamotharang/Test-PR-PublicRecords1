
import risk_indicators, riskwise, ut;

export FP1210_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

FP_DEBUG := false;

#if(FP_DEBUG)
	layout_debug := record
		boolean iv_add_apt                       ;  // iv_add_apt;
		integer iv_cvi                           ;  // iv_cvi;
		string  iv_decsflag                      ;  // iv_decsflag;
		string  iv_ssn_invalid                   ;  // iv_ssn_invalid;
		string  iv_addrvalflag                   ;  // iv_addrvalflag;
		integer iv_inp_addr_eda_sourced          ;  // iv_inp_addr_eda_sourced;
		string  iv_inp_addr_vacant               ;  // iv_inp_addr_vacant;
		string  iv_inp_addr_mixed_usage          ;  // iv_inp_addr_mixed_usage;
		integer inp_addr_nhood_properties_sum    ;  // inp_addr_nhood_properties_sum;
		integer inp_addr_nhood_mfd_props         ;  // inp_addr_nhood_mfd_props;
		integer iv_inp_addr_nhood_pct_mfd        ;  // iv_inp_addr_nhood_pct_mfd;
		integer iv_dist_inp_addr_to_bst_addr     ;  // iv_dist_inp_addr_to_bst_addr;
		integer iv_ssns_per_sfd_addr             ;  // iv_ssns_per_sfd_addr;
		integer iv_inq_dobs_per_ssn              ;  // iv_inq_dobs_per_ssn;
		integer iv_inq_ssns_per_addr             ;  // iv_inq_ssns_per_addr;
		string  iv_rec_vehx_level                ;  // iv_rec_vehx_level;
		integer iv_attr_arrests_recency          ;  // iv_attr_arrests_recency;
		integer iv_attr_bankruptcy_recency       ;  // iv_attr_bankruptcy_recency;
		integer iv_criminal_count                ;  // iv_criminal_count;
		integer iv_closest_rel_distance          ;  // iv_closest_rel_distance;
		integer iv_rel_felony_count              ;  // iv_rel_felony_count;
		string  iv_ams_college_type              ;  // iv_ams_college_type;
		integer iv_estimated_income              ;  // iv_estimated_income;
		integer sum_dols                         ;  // sum_dols;
		real    pct_offline_dols                 ;  // pct_offline_dols;
		real    pct_retail_dols                  ;  // pct_retail_dols;
		real    pct_online_dols                  ;  // pct_online_dols;
		string  iv_pb_profile                    ;  // iv_pb_profile;
		real    subscore0                        ;  // subscore0;
		real    subscore1                        ;  // subscore1;
		real    subscore2                        ;  // subscore2;
		real    subscore3                        ;  // subscore3;
		real    subscore4                        ;  // subscore4;
		real    subscore5                        ;  // subscore5;
		real    subscore6                        ;  // subscore6;
		real    subscore7                        ;  // subscore7;
		real    subscore8                        ;  // subscore8;
		real    subscore9                        ;  // subscore9;
		real    subscore10                       ;  // subscore10;
		real    subscore11                       ;  // subscore11;
		real    subscore12                       ;  // subscore12;
		real    subscore13                       ;  // subscore13;
		real    subscore14                       ;  // subscore14;
		real    subscore15                       ;  // subscore15;
		real    subscore16                       ;  // subscore16;
		real    subscore17                       ;  // subscore17;
		real    subscore18                       ;  // subscore18;
		real    subscore19                       ;  // subscore19;
		real    subscore20                       ;  // subscore20;
		real    subscore21                       ;  // subscore21;
		real    subscore22                       ;  // subscore22;
		real    subscore23                       ;  // subscore23;
		real    subscore24                       ;  // subscore24;
		real    subscore25                       ;  // subscore25;
		real    rawscore                         ;  // rawscore;
		real    lnoddsscore                      ;  // lnoddsscore;
		real    probscore                        ;  // probscore;
		integer base                             ;  // base;
		integer point                            ;  // point;
		real    odds                             ;  // odds;
		integer fp1210_1                         ;  // fp1210_1;
		models.layout_modelout;
		risk_indicators.Layout_Boca_Shell clam;
	END;
		layout_debug doModel( clam le ) := TRANSFORM
#else
		models.layout_modelout doModel( clam le ) := TRANSFORM
#end
truedid                          := le.truedid;
out_unit_desig                   := le.shell_input.unit_desig;
out_sec_range                    := le.shell_input.sec_range;
out_addr_type                    := le.shell_input.addr_type;
cvi                              := le.iid.cvi;
rc_decsflag                      := le.iid.decsflag;
rc_ssnvalflag                    := le.iid.socsvalflag;
rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
rc_addrvalflag                   := le.iid.addrvalflag;
rc_dwelltype                     := le.iid.dwelltype;
rc_bansflag                      := le.iid.bansflag;
ver_sources                      := le.header_summary.ver_sources;
addrpop                          := le.input_validation.address;
ssnlength                        := le.input_validation.ssn_length;
hphnpop                          := le.input_validation.homephone;
add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;	
add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;				
add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
add1_nhood_business_count        := le.addr_risk_summary.n_business_count;				
add1_nhood_sfd_count             := le.addr_risk_summary.n_sfd_count;							
add1_nhood_mfd_count             := le.addr_risk_summary.n_mfd_count;							
add1_pop                         := le.addrpop;																		
dist_a1toa2                      := le.address_verification.distance_in_2_h1;
inputssncharflag                 := le.SSN_Verification.validation.inputsocscharflag;
ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
inq_dobsperssn                   := le.acc_logs.inquirydobsperssn;
inq_ssnsperaddr                  := le.acc_logs.inquiryssnsperaddr;
pb_number_of_sources             := le.ibehavior.number_of_sources;
pb_offline_dollars               := (integer)le.ibehavior.offline_dollars;
pb_online_dollars                := (integer)le.ibehavior.online_dollars;
pb_retail_dollars                := (integer)le.ibehavior.retail_dollars;
attr_num_aircraft 							 := le.aircraft.aircraft_count;
attr_arrests                     := le.bjl.arrests_count;
attr_arrests30                   := le.bjl.arrests_count30;
attr_arrests90                   := le.bjl.arrests_count90;
attr_arrests180                  := le.bjl.arrests_count180;
attr_arrests12                   := le.bjl.arrests_count12;
attr_arrests24                   := le.bjl.arrests_count24;
attr_arrests36                   := le.bjl.arrests_count36;
attr_arrests60                   := le.bjl.arrests_count60;
attr_bankruptcy_count30          := le.bjl.bk_count30;
attr_bankruptcy_count90          := le.bjl.bk_count90;
attr_bankruptcy_count180         := le.bjl.bk_count180;
attr_bankruptcy_count12          := le.bjl.bk_count12;
attr_bankruptcy_count24          := le.bjl.bk_count24;
attr_bankruptcy_count36          := le.bjl.bk_count36;
attr_bankruptcy_count60          := le.bjl.bk_count60;
fp_srchunvrfdaddrcount           := (integer)le.fdattributesv2.searchunverifiedaddrcountyear;
fp_srchunvrfddobcount            := (integer)le.fdattributesv2.searchunverifieddobcountyear;
fp_corrssnnamecount              := (integer)le.fdattributesv2.correlationssnnamecount;
fp_corrssnaddrcount              := (integer)le.fdattributesv2.correlationssnaddrcount;
fp_curraddrmedianincome          := (integer)le.fdattributesv2.curraddrmedianincome;
bankrupt                         := le.bjl.bankrupt;
filing_count                     := le.bjl.filing_count;
bk_recent_count                  := le.bjl.bk_recent_count;
criminal_count                   := le.bjl.criminal_count;
rel_count                        := le.relatives.relative_count;
rel_felony_count                 := le.relatives.relative_felony_count;
rel_within25miles_count          := le.relatives.relative_within25miles_count;
rel_within100miles_count         := le.relatives.relative_within100miles_count;
rel_within500miles_count         := le.relatives.relative_within500miles_count;
rel_withinother_count            := le.relatives.relative_withinother_count;
watercraft_count                 := le.watercraft.watercraft_count;
ams_college_type                 := le.student.college_type;
estimated_income                 := le.estimated_income;

NULL := -999999999;

INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

iv_add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

iv_cvi := if(not(truedid or (integer)ssnlength > 0) and not(hphnpop or addrpop), NULL, cvi);

iv_decsflag := map(
    not(truedid or (integer)ssnlength > 0)                                          => '            ',
    rc_decsflag = '1'                                                        => 'SSN Deceased',
    contains_i(ver_sources, 'DE') > 0 or contains_i(ver_sources, 'DS') > 0 => 'Src Deceased',
    rc_decsflag = '0'                                                        => 'Not Deceased',
                                                                              '            ');

iv_ssn_invalid := map(
    not((integer)ssnlength > 0)                                                                                 => '       ',
    rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']) or (inputssncharflag in ['1', '2', '3']) => 'Invalid',
    rc_ssnvalflag = '0' or (rc_pwssnvalflag in ['0', '4', '5']) or (inputssncharflag in ['0', '4', '5']) => 'Valid  ',
                                                                                                          '       ');

iv_addrvalflag := map(
    not(add1_pop)         => '  ',
    rc_addrvalflag = '' 	=> '-1',
                             rc_addrvalflag);

iv_inp_addr_eda_sourced := if(not(add1_pop), null, (integer)add1_eda_sourced);

iv_inp_addr_vacant := map(
    not(add1_pop)                    => '  ',
    add1_advo_address_vacancy = '' 	 => '-1',
                                        add1_advo_address_vacancy);

iv_inp_addr_mixed_usage := map(
    not(add1_pop)                        => '  ',
    add1_advo_mixed_address_usage = ''	 => '-1',
                                            add1_advo_mixed_address_usage);

inp_addr_nhood_properties_sum := if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count)));

inp_addr_nhood_mfd_props := add1_nhood_mfd_count;

iv_inp_addr_nhood_pct_mfd := map(
    not(add1_pop)                     => NULL,
    inp_addr_nhood_properties_sum > 0 => if (inp_addr_nhood_mfd_props / inp_addr_nhood_properties_sum * 10 >= 0, roundup(inp_addr_nhood_mfd_props / inp_addr_nhood_properties_sum * 10), truncate(inp_addr_nhood_mfd_props / inp_addr_nhood_properties_sum * 10)) * 10,
                                         -1);

iv_dist_inp_addr_to_bst_addr := map(
    not(truedid)     => NULL,
    add1_isbestmatch => 0,
                        dist_a1toa2);

iv_ssns_per_sfd_addr := map(
    not(add1_pop) => NULL,
    iv_add_apt    => -1,
                     ssns_per_addr);

iv_inq_dobs_per_ssn := if(not((integer)ssnlength > 0), NULL, inq_dobsperssn);

iv_inq_ssns_per_addr := if(not(add1_pop), NULL, inq_ssnsperaddr);

min_wc := min(if(watercraft_count = null, 0, watercraft_count), 3);  //kwh - This is not an original IV, but added to simplify the next statement

iv_rec_vehx_level := map(
    not(truedid)                                   => '  ',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string)min_wc, LEFT, RIGHT),
                                                      'XX');

iv_attr_arrests_recency := map(
    not(truedid)     		=> NULL,
    attr_arrests30  >0 	=> 1,
    attr_arrests90  >0  => 3,
    attr_arrests180 >0  => 6,
    attr_arrests12  >0  => 12,
    attr_arrests24  >0  => 24,
    attr_arrests36  >0  => 36,
    attr_arrests60  >0  => 60,
    attr_arrests 		>0	=> 99,
													 0);

iv_attr_bankruptcy_recency := map(
    not(truedid)                      => NULL,
    attr_bankruptcy_count30    >0       => 1,
    attr_bankruptcy_count90    >0       => 3,
    attr_bankruptcy_count180   >0       => 6,
    attr_bankruptcy_count12    >0       => 12,
    attr_bankruptcy_count24    >0       => 24,
    attr_bankruptcy_count36    >0       => 36,
    attr_bankruptcy_count60    >0       => 60,
    (rc_bansflag in ['1', '2'])       	=> 99,
    bankrupt                          	=> 99,
    contains_i(ver_sources, 'BA') > 0 	=> 99,
    filing_count > 0                  	=> 99,
    bk_recent_count > 0               	=> 99,
																					 0);

iv_criminal_count := if(not(truedid), NULL, criminal_count);

iv_closest_rel_distance := map(
    not(truedid)                 => NULL,
    rel_count = 0                => -1,
    rel_within25miles_count > 0  => 25,
    rel_within100miles_count > 0 => 100,
    rel_within500miles_count > 0 => 500,
    rel_withinOther_count > 0    => 1000,
                                    0);

iv_rel_felony_count := map(
    not(truedid)  => NULL,
    rel_count = 0 => -1,
                     rel_felony_count);

iv_ams_college_type := map(
    not(truedid)            => '  ',
    ams_college_type = '' => '-1',
                               ams_college_type);

iv_estimated_income := if(not(truedid), NULL, estimated_income);

sum_dols := if(max(pb_offline_dollars, pb_online_dollars, pb_retail_dollars) = NULL, NULL, sum(if(pb_offline_dollars = NULL, 0, pb_offline_dollars), if(pb_online_dollars = NULL, 0, pb_online_dollars), if(pb_retail_dollars = NULL, 0, pb_retail_dollars)));

pct_offline_dols := if(sum_dols > 0, pb_offline_dollars / sum_dols, -1);

pct_retail_dols := if(sum_dols > 0, pb_retail_dollars / sum_dols, -1);

pct_online_dols := if(sum_dols > 0, pb_online_dollars / sum_dols, -1);

iv_pb_profile := map(
    not(truedid)                				=> '                 ',
    (integer)pb_number_of_sources = 0  	=> '0 No Purch Data  ',
    pct_offline_dols > .50      				=> '1 Offline Shopper',
    pct_online_dols > .50       				=> '2 Online Shopper ',
    pct_retail_dols > .50       				=> '3 Retail Shopper ',
																					 '4 Other');

subscore0 := map(
    NULL < fp_corrssnaddrcount AND fp_corrssnaddrcount < 0 => 0.000000,
    0 <= fp_corrssnaddrcount AND fp_corrssnaddrcount < 1   => -0.323829,
    1 <= fp_corrssnaddrcount AND fp_corrssnaddrcount < 2   => 0.403219,
    2 <= fp_corrssnaddrcount AND fp_corrssnaddrcount < 3   => 0.424471,
    3 <= fp_corrssnaddrcount AND fp_corrssnaddrcount < 4   => 0.517214,
    4 <= fp_corrssnaddrcount AND fp_corrssnaddrcount < 5   => 0.555343,
    5 <= fp_corrssnaddrcount                               => 0.787064,
                                                              0.000000);

subscore1 := map(
    (iv_closest_rel_distance in [-1])        => -0.000000,
    (iv_closest_rel_distance in [25])        => 0.175525,
    (iv_closest_rel_distance in [100])       => -0.410867,
    (iv_closest_rel_distance in [500, 1000]) => -0.768071,
                                                -0.000000);

subscore2 := map(
    NULL < fp_srchunvrfdaddrcount AND fp_srchunvrfdaddrcount < 1 => 0.184322,
    1 <= fp_srchunvrfdaddrcount AND fp_srchunvrfdaddrcount < 2   => -0.453735,
    2 <= fp_srchunvrfdaddrcount AND fp_srchunvrfdaddrcount < 3   => -0.665994,
    3 <= fp_srchunvrfdaddrcount                                  => -1.049018,
                                                                    0.000000);

subscore3 := map(
    NULL < iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 3 => 0.114285,
    3 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 4   => -0.203106,
    4 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 5   => -0.323805,
    5 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 7   => -0.497142,
    7 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 8   => -0.613860,
    8 <= iv_inq_ssns_per_addr                                => -0.845391,
                                                                0.000000);

subscore4 := map(
    NULL < iv_dist_inp_addr_to_bst_addr AND iv_dist_inp_addr_to_bst_addr < 3   => 0.259999,
    3 <= iv_dist_inp_addr_to_bst_addr AND iv_dist_inp_addr_to_bst_addr < 23    => 0.022584,
    23 <= iv_dist_inp_addr_to_bst_addr AND iv_dist_inp_addr_to_bst_addr < 61   => -0.165857,
    61 <= iv_dist_inp_addr_to_bst_addr AND iv_dist_inp_addr_to_bst_addr < 87   => -0.276045,
    87 <= iv_dist_inp_addr_to_bst_addr AND iv_dist_inp_addr_to_bst_addr < 9999 => -0.366275,
    9999 <= iv_dist_inp_addr_to_bst_addr                                       => 0.000000,
                                                                                  0.000000);

subscore5 := map(
    (iv_cvi in [0, 10, 20])  => -0.145821,
    (iv_cvi in [30, 40, 50]) => 0.348943,
                                -0.000000);

subscore6 := map(
    NULL < iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 0 => 0.000000,
    0 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 1   => -0.408037,
    1 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 2   => 0.099423,
    2 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 9   => 0.200824,
    9 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 12  => 0.175200,
    12 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 16 => 0.061935,
    16 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 22 => -0.049628,
    22 <= iv_ssns_per_sfd_addr AND iv_ssns_per_sfd_addr < 34 => -0.118990,
    34 <= iv_ssns_per_sfd_addr                               => -0.149552,
                                                                0.000000);

subscore7 := map(
    (iv_attr_bankruptcy_recency in [1, 3, 6, 12, 24, 36]) => 0.552357,
    (iv_attr_bankruptcy_recency in [60])                  => 0.470188,
    (iv_attr_bankruptcy_recency in [99])                  => 0.181225,
    (iv_attr_bankruptcy_recency in [0])                   => -0.064350,
                                                             0.000000);

subscore8 := map(
    NULL < fp_corrssnnamecount AND fp_corrssnnamecount < 1 => -0.401011,
    1 <= fp_corrssnnamecount AND fp_corrssnnamecount < 5   => -0.010853,
    5 <= fp_corrssnnamecount AND fp_corrssnnamecount < 7   => 0.066748,
    7 <= fp_corrssnnamecount                               => 0.084555,
                                                              -0.000000);

subscore9 := map(
    (iv_pb_profile in ['Other'])                                           => 0.000000,
    (iv_pb_profile in ['0 No Purch Data'])                                 => -0.112322,
    (iv_pb_profile in ['1 Offline Shopper'])                               => 0.066955,
    (iv_pb_profile in ['2 Online Shopper', '3 Retail Shopper', '4 Other']) => 0.244711,
                                                                              0.000000);

subscore10 := map(
    NULL < iv_inq_dobs_per_ssn AND iv_inq_dobs_per_ssn < 1 => 0.108962,
    1 <= iv_inq_dobs_per_ssn AND iv_inq_dobs_per_ssn < 2   => -0.175963,
    2 <= iv_inq_dobs_per_ssn                               => -0.349053,
                                                              0.000000);

subscore11 := map(
    (iv_decsflag in ['Not Deceased'])                 => 0.015407,
    (iv_decsflag in ['Src Deceased', 'SSN Deceased']) => -0.680477,
                                                         -0.000000);

subscore12 := map(
    NULL < iv_criminal_count AND iv_criminal_count < 1 => 0.068031,
    1 <= iv_criminal_count AND iv_criminal_count < 2   => -0.172450,
    2 <= iv_criminal_count AND iv_criminal_count < 3   => -0.244557,
    3 <= iv_criminal_count                             => -0.262877,
                                                          -0.000000);

subscore13 := map(
    NULL < iv_inp_addr_nhood_pct_mfd AND iv_inp_addr_nhood_pct_mfd < 0 => -0.000000,
    0 <= iv_inp_addr_nhood_pct_mfd AND iv_inp_addr_nhood_pct_mfd < 10  => -0.000000,
    10 <= iv_inp_addr_nhood_pct_mfd AND iv_inp_addr_nhood_pct_mfd < 20 => 0.120751,
    20 <= iv_inp_addr_nhood_pct_mfd AND iv_inp_addr_nhood_pct_mfd < 40 => -0.020580,
    40 <= iv_inp_addr_nhood_pct_mfd AND iv_inp_addr_nhood_pct_mfd < 80 => -0.128222,
    80 <= iv_inp_addr_nhood_pct_mfd                                    => -0.256588,
                                                                          -0.000000);

subscore14 := map(
    NULL < fp_curraddrmedianincome AND fp_curraddrmedianincome < 0       => -0.000000,
    0 <= fp_curraddrmedianincome AND fp_curraddrmedianincome < 24434     => -0.244577,
    24434 <= fp_curraddrmedianincome AND fp_curraddrmedianincome < 30667 => -0.161622,
    30667 <= fp_curraddrmedianincome AND fp_curraddrmedianincome < 37292 => -0.107590,
    37292 <= fp_curraddrmedianincome AND fp_curraddrmedianincome < 43891 => 0.021509,
    43891 <= fp_curraddrmedianincome AND fp_curraddrmedianincome < 50893 => 0.061012,
    50893 <= fp_curraddrmedianincome                                     => 0.093607,
                                                                            -0.000000);

subscore15 := map(
    (iv_addrvalflag in ['Other'])  => -0.000000,
    (iv_addrvalflag in ['M', 'N']) => -0.438535,
    (iv_addrvalflag in ['V'])      => 0.032201,
                                      -0.000000);

subscore16 := map(
    NULL < iv_estimated_income AND iv_estimated_income < 19999   => -0.000000,
    19999 <= iv_estimated_income AND iv_estimated_income < 27000 => -0.306587,
    27000 <= iv_estimated_income AND iv_estimated_income < 30000 => -0.155271,
    30000 <= iv_estimated_income AND iv_estimated_income < 34000 => -0.142960,
    34000 <= iv_estimated_income AND iv_estimated_income < 38000 => -0.005344,
    38000 <= iv_estimated_income AND iv_estimated_income < 40000 => 0.016158,
    40000 <= iv_estimated_income AND iv_estimated_income < 43000 => 0.071853,
    43000 <= iv_estimated_income                                 => 0.088179,
                                                                    -0.000000);

subscore17 := map(
    (iv_inp_addr_vacant in ['Other']) => -0.000000,
    (iv_inp_addr_vacant in ['-1'])    => -0.000000,
    (iv_inp_addr_vacant in ['N'])     => 0.020838,
    (iv_inp_addr_vacant in ['Y'])     => -0.680156,
                                         -0.000000);

subscore18 := map(
    NULL < fp_srchunvrfddobcount AND fp_srchunvrfddobcount < 1 => 0.030240,
    1 <= fp_srchunvrfddobcount                                 => -0.259367,
                                                                  0.000000);

subscore19 := map(
    (iv_attr_arrests_recency in [1, 3, 6, 12, 24, 36, 60, 99]) => -0.352636,
    (iv_attr_arrests_recency in [0])                           => 0.020626,
                                                                  -0.000000);

subscore20 := map(
    (iv_ams_college_type in ['Other'])            => 0.000000,
    (iv_ams_college_type in ['-1'])               => -0.018013,
    (iv_ams_college_type in ['P', 'R', 'S', 'U']) => 0.305148,
                                                     0.000000);

subscore21 := map(
    (iv_inp_addr_mixed_usage in ['Other'])             => 0.000000,
    (iv_inp_addr_mixed_usage in ['-1'])                => 0.000000,
    (iv_inp_addr_mixed_usage in ['A'])                 => 0.056757,
    not((iv_inp_addr_mixed_usage in ['A', ' ', '-1'])) => -0.120261,
                                                          0.000000);

subscore22 := map(
    NULL < iv_rel_felony_count AND iv_rel_felony_count < 0 => 0.000000,
    0 <= iv_rel_felony_count AND iv_rel_felony_count < 1   => 0.038224,
    1 <= iv_rel_felony_count AND iv_rel_felony_count < 2   => -0.064283,
    2 <= iv_rel_felony_count                               => -0.100823,
                                                              0.000000);

subscore23 := map(
    (iv_rec_vehx_level in ['Other'])                      => 0.000000,
    (iv_rec_vehx_level in ['AO', 'AW', 'W1', 'W2', 'W3']) => 0.218799,
    (iv_rec_vehx_level in ['XX'])                         => -0.007720,
                                                             0.000000);

subscore24 := map(
    (iv_ssn_invalid in ['Invalid']) => -0.180791,
    (iv_ssn_invalid in ['Valid'])   => 0.004155,
                                       -0.000000);

subscore25 := map(
    (iv_inp_addr_eda_sourced in [0]) => -0.006585,
    (iv_inp_addr_eda_sourced in [1]) => 0.165219,
                                        -0.000000);

rawscore := sum(
	subscore0,
	subscore1,
	subscore2,
	subscore3,
	subscore4,
	subscore5,
	subscore6,
	subscore7,
	subscore8,
	subscore9,
	subscore10,
	subscore11,
	subscore12,
	subscore13,
	subscore14,
	subscore15,
	subscore16,
	subscore17,
	subscore18,
	subscore19,
	subscore20,
	subscore21,
	subscore22,
	subscore23,
	subscore24,
	subscore25
    );

lnoddsscore := rawscore + 0.808221;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 650;

point := 50;

odds := (1 - 0.296) / 0.296;

fp1210_1 := max(min(if(round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(point * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base)), 999), 300);

//Intermediate variables

#if(FP_DEBUG)
	self.clam															:= le;
	self.iv_add_apt                       := iv_add_apt;
	self.iv_cvi                           := iv_cvi;
	self.iv_decsflag                      := iv_decsflag;
	self.iv_ssn_invalid                   := iv_ssn_invalid;
	self.iv_addrvalflag                   := iv_addrvalflag;
	self.iv_inp_addr_eda_sourced          := iv_inp_addr_eda_sourced;
	self.iv_inp_addr_vacant               := iv_inp_addr_vacant;
	self.iv_inp_addr_mixed_usage          := iv_inp_addr_mixed_usage;
	self.inp_addr_nhood_properties_sum    := inp_addr_nhood_properties_sum;
	self.inp_addr_nhood_mfd_props         := inp_addr_nhood_mfd_props;
	self.iv_inp_addr_nhood_pct_mfd        := iv_inp_addr_nhood_pct_mfd;
	self.iv_dist_inp_addr_to_bst_addr     := iv_dist_inp_addr_to_bst_addr;
	self.iv_ssns_per_sfd_addr             := iv_ssns_per_sfd_addr;
	self.iv_inq_dobs_per_ssn              := iv_inq_dobs_per_ssn;
	self.iv_inq_ssns_per_addr             := iv_inq_ssns_per_addr;
	self.iv_rec_vehx_level                := iv_rec_vehx_level;
	self.iv_attr_arrests_recency          := iv_attr_arrests_recency;
	self.iv_attr_bankruptcy_recency       := iv_attr_bankruptcy_recency;
	self.iv_criminal_count                := iv_criminal_count;
	self.iv_closest_rel_distance          := iv_closest_rel_distance;
	self.iv_rel_felony_count              := iv_rel_felony_count;
	self.iv_ams_college_type              := iv_ams_college_type;
	self.iv_estimated_income              := iv_estimated_income;
	self.sum_dols                         := sum_dols;
	self.pct_offline_dols                 := pct_offline_dols;
	self.pct_retail_dols                  := pct_retail_dols;
	self.pct_online_dols                  := pct_online_dols;
	self.iv_pb_profile                    := iv_pb_profile;
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
	self.subscore13                       := subscore13;
	self.subscore14                       := subscore14;
	self.subscore15                       := subscore15;
	self.subscore16                       := subscore16;
	self.subscore17                       := subscore17;
	self.subscore18                       := subscore18;
	self.subscore19                       := subscore19;
	self.subscore20                       := subscore20;
	self.subscore21                       := subscore21;
	self.subscore22                       := subscore22;
	self.subscore23                       := subscore23;
	self.subscore24                       := subscore24;
	self.subscore25                       := subscore25;
	self.rawscore                         := rawscore;
	self.lnoddsscore                      := lnoddsscore;
	self.probscore                        := probscore;
	self.base                             := base;
	self.point                            := point;
	self.odds                             := odds;
	self.fp1210_1                         := fp1210_1;
#end
	self.seq := le.seq;
	self.score := (string)FP1210_1;
	self := [];
END;

	model := project( clam, doModel(left) );

	return model;
END;