import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

bs_with_ip := record
	// unsigned3 historydate := 999999;
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;	

// export FP31310_2_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION
export FP31310_2_0( dataset(bs_with_ip) clam,  integer1 num_reasons, string5 RetailZip_in, String LoadAmount_in) := FUNCTION

FP_DEBUG := false;
	
#if(FP_DEBUG)
	Layout_Debug := RECORD
	/* Model Input Variables */
	String LoadAmount;
	String RetailZip;
	INTEGER mobile_ip;
	REAL dist_conn_mail_ip;
	REAL dist_conn_retail_mail;
	String iproutingmethod;
	INTEGER sysdate;
	BOOLEAN iv_pots_phone;
	BOOLEAN iv_add_apt;
	INTEGER _reported_dob;
	INTEGER reported_age;
	INTEGER iv_combined_age;
	INTEGER iv_inq_per_ssn;
	INTEGER nf_fp_srchaddrsrchcount;
	INTEGER iv_va060_dist_add_in_bst;
	INTEGER nf_fp_srchaddrsrchcountmo;
	STRING nf_add1_util_infrastructure;
	INTEGER iv_hist_addr_match;
	INTEGER iv_inq_banking_recency;
	BOOLEAN ver_phn_inf;
	BOOLEAN ver_phn_nap;
	INTEGER inf_phn_ver_lvl;
	INTEGER nap_phn_ver_lvl;
	STRING iv_nap_phn_ver_x_inf_phn_ver;
	INTEGER nf_closest_rel_distance;
	INTEGER nf_fp_srchssnsrchcountmo;
	INTEGER nf_fp_srchphonesrchcount;
	REAL rpc_subscore0;
	REAL rpc_subscore1;
	REAL rpc_subscore2;
	REAL rpc_subscore3;
	REAL rpc_subscore4;
	REAL rpc_subscore5;
	REAL rpc_subscore6;
	REAL rpc_subscore7;
	REAL rpc_subscore8;
	REAL rpc_subscore9;
	REAL rpc_subscore10;
	REAL rpc_subscore11;
	REAL rpc_subscore12;
	REAL rpc_subscore13;
	REAL rpc_rawscore;
	REAL rpc_lnoddsscore;
	INTEGER iv_addr_non_phn_src_ct;
	INTEGER nf_bst_addr_nhood_pct_sfd;
	INTEGER iv_inq_ssns_per_adl;
	INTEGER sum_dols;
	REAL pct_offline_dols;
	REAL pct_retail_dols;
	REAL pct_online_dols;
	STRING iv_pb_profile;
	INTEGER nf_fp_srchfraudsrchcount;
	INTEGER nf_fp_srchfraudsrchcountmo;
	INTEGER nf_fp_corraddrnamecount;
	INTEGER nf_fp_addrchangevaluediff;
	REAL rwc_subscore0;
	REAL rwc_subscore1;
	REAL rwc_subscore2;
	REAL rwc_subscore3;
	REAL rwc_subscore4;
	REAL rwc_subscore5;
	REAL rwc_subscore6;
	REAL rwc_subscore7;
	REAL rwc_subscore8;
	REAL rwc_subscore9;
	REAL rwc_subscore10;
	REAL rwc_subscore11;
	REAL rwc_subscore12;
	REAL rwc_subscore13;
	REAL rwc_subscore14;
	REAL rwc_subscore15;
	REAL rwc_subscore16;
	REAL rwc_subscore17;
	REAL rwc_subscore18;
	REAL rwc_rawscore;
	REAL rwc_lnoddsscore;
	INTEGER _rc_ssnhighissue;
	INTEGER iv_age_at_high_issue;
	INTEGER iv_addr_lres_12mo_count;
	INTEGER iv_max_ids_per_sfd_addr_c6;
	INTEGER iv_inq_banking_count12;
	INTEGER iv_inq_ssns_per_addr;
	INTEGER nf_average_rel_distance;
	INTEGER nf_fp_corrrisktype;
	INTEGER nf_fp_corrssnaddrcount;
	REAL onc_subscore0;
	REAL onc_subscore1;
	REAL onc_subscore2;
	REAL onc_subscore3;
	REAL onc_subscore4;
	REAL onc_subscore5;
	REAL onc_subscore6;
	REAL onc_subscore7;
	REAL onc_subscore8;
	REAL onc_subscore9;
	REAL onc_subscore10;
	REAL onc_subscore11;
	REAL onc_subscore12;
	REAL onc_subscore13;
	REAL onc_subscore14;
	REAL onc_subscore15;
	REAL onc_subscore16;
	REAL onc_rawscore;
	REAL onc_lnoddsscore;
	STRING segment;
	REAL _fp31310_2_0;
	INTEGER base;
	INTEGER pts;
	REAL logit;
	INTEGER fp31310_2_0;
		
	models.layout_modelout;
	// risk_indicators.Layout_Boca_Shell clam;
	bs_with_ip clam;
END;
		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end

/* ***********************************************************
 *             Model Input Variable Assignments              *
 ************************************************************* */
 NULL := __common__( -999999999 ) ;
 
	// ipaddr                           := le.ip.ipaddr;
	ipconnection                     := le.ip.ipconnection;
	loadamount                       := if(trim(loadamount_in)='', null, (Real)LoadAmount_in);
	retailzip                        := if(trim(retailzip_in) in ['', '#N/A'] , '', RetailZip_in);
	dist_retail_mail                 := ut.zip_Dist(RetailZip, le.bs.Shell_Input.z5);
	dist_mail_ip                     := ut.LL_Dist((Real)le.ip.latitude, (Real)le.ip.longitude, (Real)le.bs.Shell_Input.lat, (Real)le.bs.Shell_Input.long);
	c_fammar_p                       := ri.FAMMAR_P;
	c_easiqlife                      := ri.EASIQLIFE;
	c_born_usa                       := ri.born_usa;
	c_unempl                         := ri.unempl;
	c_med_hval                       := ri.med_hval;
	iproutingmethod                  := le.ip.iproutingmethod;
	ipaddress                        := le.bs.shell_input.ip_address;
	truedid                          := le.bs.truedid;
	out_unit_desig                   := le.bs.shell_input.unit_desig;
	out_sec_range                    := le.bs.shell_input.sec_range;
	out_addr_type                    := le.bs.shell_input.addr_type;
	nap_summary                      := le.bs.iid.nap_summary;
	rc_ssnhighissue                  := le.bs.iid.soclhighissue;
	rc_dwelltype                     := le.bs.iid.dwelltype;
	rc_addrcount                     := le.bs.iid.addrcount;
	addrpop                          := le.bs.input_validation.address;
	ssnlength                        := le.bs.input_validation.ssn_length;
	dobpop                           := le.bs.input_validation.dateofbirth;
	hphnpop                          := le.bs.input_validation.homephone;
	age                              := le.bs.name_verification.age;
	util_add1_type_list              := le.bs.utility.utili_addr1_type;
	add1_isbestmatch                 := le.bs.address_verification.input_address_information.isbestmatch;
	add1_nhood_business_count        := le.bs.addr_risk_summary.n_business_count;
	add1_nhood_sfd_count             := le.bs.addr_risk_summary.n_sfd_count;
	add1_nhood_mfd_count             := le.bs.addr_risk_summary.n_mfd_count;
	add1_pop                         := le.bs.addrpop;
	dist_a1toa2                      := le.bs.address_verification.distance_in_2_h1;
	add2_nhood_business_count        := le.bs.addr_risk_summary2.n_business_count;
	add2_nhood_sfd_count             := le.bs.addr_risk_summary2.n_sfd_count;
	add2_nhood_mfd_count             := le.bs.addr_risk_summary2.n_mfd_count;
	addr_lres_12mo_count             := le.bs.address_history_summary.lres_12mo_count;
	hist_addr_match                  := le.bs.address_history_summary.hist_addr_match;
	telcordia_type                   := le.bs.phone_verification.telcordia_type;
	adls_per_addr_c6                 := le.bs.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.bs.velocity_counters.ssns_per_addr_created_6months;
	inq_banking_count                := le.bs.acc_logs.banking.counttotal;
	inq_banking_count01              := le.bs.acc_logs.banking.count01;
	inq_banking_count03              := le.bs.acc_logs.banking.count03;
	inq_banking_count06              := le.bs.acc_logs.banking.count06;
	inq_banking_count12              := le.bs.acc_logs.banking.count12;
	inq_banking_count24              := le.bs.acc_logs.banking.count24;
	inq_ssnsperadl                   := le.bs.acc_logs.inquiryssnsperadl;
	inq_perssn                       := le.bs.acc_logs.inquiryperssn;
	inq_ssnsperaddr                  := le.bs.acc_logs.inquiryssnsperaddr;
	pb_number_of_sources             := le.bs.ibehavior.number_of_sources;
	pb_offline_dollars               := le.bs.ibehavior.offline_dollars;
	pb_online_dollars                := le.bs.ibehavior.online_dollars;
	pb_retail_dollars                := le.bs.ibehavior.retail_dollars;
	infutor_nap                      := le.bs.infutor_phone.infutor_nap;
	fp_srchfraudsrchcount            := le.bs.fdattributesv2.searchfraudsearchcount;
	fp_srchfraudsrchcountmo          := le.bs.fdattributesv2.searchfraudsearchcountmonth;
	fp_corrrisktype                  := le.bs.fdattributesv2.correlationrisklevel;
	fp_corrssnaddrcount              := le.bs.fdattributesv2.correlationssnaddrcount;
	fp_corraddrnamecount             := le.bs.fdattributesv2.correlationaddrnamecount;
	fp_srchssnsrchcountmo            := le.bs.fdattributesv2.searchssnsearchcountmonth;
	fp_srchaddrsrchcount             := le.bs.fdattributesv2.searchaddrsearchcount;
	fp_srchaddrsrchcountmo           := le.bs.fdattributesv2.searchaddrsearchcountmonth;
	fp_srchphonesrchcount            := le.bs.fdattributesv2.searchphonesearchcount;
	fp_addrchangevaluediff           := le.bs.fdattributesv2.addrchangevaluediff;
	rel_count                        := le.bs.relatives.relative_count;
	rel_within25miles_count          := le.bs.relatives.relative_within25miles_count;
	rel_within100miles_count         := le.bs.relatives.relative_within100miles_count;
	rel_within500miles_count         := le.bs.relatives.relative_within500miles_count;
	rel_withinother_count            := le.bs.relatives.relative_withinother_count;
	ams_age                          := le.bs.student.age;
	input_dob_age                    := le.bs.shell_input.age;
	inferred_age                     := le.bs.inferred_age;
	reported_dob                     := le.bs.reported_dob;


/* ***********************************************************
*                    Generated ECL                          *
************************************************************** */


INTEGER contains_i( string haystack, string needle ) := __common__( (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0) ) ;

in_ip_address_1 := __common__( if(((String)IPAddress in ['', 'NULL', '#N/A']), '', (String)IPAddress) ) ;

mobile_ip := __common__( if(in_ip_address_1 = '', -1, (Integer)(ipconnection in ['mobile', 'wireless'])) ) ;

dist_conn_mail_ip := __common__( if((Real)dist_mail_ip = Null, Null, if(mobile_ip = 1, (Real)dist_mail_ip + 100000, (Real)dist_mail_ip)) ) ;

dist_conn_retail_mail := __common__( if((Real)dist_retail_mail = Null, Null, if(mobile_ip = 1, (Real)dist_retail_mail + 100000, (Real)dist_retail_mail)) ) ;

sysdate := __common__( common.sas_date(if(le.bs.historydate=999999, (STRING)Std.Date.Today(), (string6)le.bs.historydate+'01')) ) ;

iv_pots_phone := __common__( (telcordia_type in ['00', '50', '51', '52', '54']) ) ;

iv_add_apt := __common__( StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ' ) ;

_reported_dob := __common__( common.sas_date((string)(reported_dob)) ) ;

reported_age := __common__( if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25)) ) ;

iv_combined_age := __common__( map(
    not(truedid or dobpop)      => NULL,
    (Integer)age > 0            => age,
    (Integer)input_dob_age > 0  => (Integer)input_dob_age,
    (Integer)inferred_age > 0   => (Integer)inferred_age,
    (Integer)reported_age > 0   => (Integer)reported_age,
    (Integer)ams_age > 0        => (Integer)ams_age,
								   -1) ) ;

iv_inq_per_ssn := __common__( if(not((Integer)ssnlength > 0), NULL, inq_perssn) ) ;

nf_fp_srchaddrsrchcount := __common__( if(not(truedid), NULL, (Integer)fp_srchaddrsrchcount) ) ;

iv_va060_dist_add_in_bst := __common__( map(
    not(truedid)       => NULL,
    add1_isbestmatch   => 0,
    dist_a1toa2 = 9999 => NULL,
                          dist_a1toa2) ) ;

nf_fp_srchaddrsrchcountmo := __common__( if(not(truedid), NULL, (Integer)fp_srchaddrsrchcountmo) ) ;

nf_add1_util_infrastructure := __common__( map(
    not(add1_pop)                            => ' ',
    contains_i(util_add1_type_list, '1') > 0 => '1',
                                                '0') ) ;

iv_hist_addr_match := __common__( map(
    not(truedid)            => NULL,
    hist_addr_match = -9999 => -1,
                               hist_addr_match) ) ;

iv_inq_banking_recency := __common__( map(
    not(truedid)        => NULL,
    (boolean)inq_banking_count01 => 1,
    (boolean)inq_banking_count03 => 3,
    (boolean)inq_banking_count06 => 6,
    (boolean)inq_banking_count12 => 12,
    (boolean)inq_banking_count24 => 24,
    (boolean)inq_banking_count   => 99,
									0) ) ;

ver_phn_inf := __common__( (infutor_nap in [4, 6, 7, 9, 10, 11, 12]) ) ;

ver_phn_nap := __common__( (nap_summary in [4, 6, 7, 9, 10, 11, 12]) ) ;

inf_phn_ver_lvl := __common__( map(
    ver_phn_inf     => 3,
    infutor_nap = 1 => 1,
    infutor_nap = 0 => 0,
                       2) ) ;

nap_phn_ver_lvl := __common__( map(
    ver_phn_nap     => 3,
    nap_summary = 1 => 1,
    nap_summary = 0 => 0,
                       2) ) ;

iv_nap_phn_ver_x_inf_phn_ver := __common__( map(
    not(addrpop or hphnpop) => '   ',
    not(hphnpop)            => ' -1',
                               trim((String)nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((String)inf_phn_ver_lvl, LEFT, RIGHT)) ) ;

nf_closest_rel_distance := __common__( map(
    not(truedid)                 => NULL,
    rel_count = 0                => -1,
    rel_within25miles_count > 0  => 25,
    rel_within100miles_count > 0 => 100,
    rel_within500miles_count > 0 => 500,
    rel_withinOther_count > 0    => 1000,
                                    0) ) ;

nf_fp_srchssnsrchcountmo := __common__( if(not(truedid), NULL, (Integer)fp_srchssnsrchcountmo) ) ;

nf_fp_srchphonesrchcount := __common__( if(not(truedid), NULL, (Integer)fp_srchphonesrchcount) ) ;

rpc_subscore0 := __common__( map(
    c_fammar_p != '' and NULL < (Real)c_fammar_p AND (Real)c_fammar_p < 44  => -0.356349,
    44 <= (Real)c_fammar_p AND (Real)c_fammar_p < 77.2                      => -0.054711,
    77.2 <= (Real)c_fammar_p                                                => 0.291823,
                                                                               0) ) ;

rpc_subscore1 := __common__( map(
    c_easiqlife != '' and NULL < (Integer)c_easiqlife AND (Integer)c_easiqlife < 111 => 0.211295,
    111 <= (Integer)c_easiqlife AND (Integer)c_easiqlife < 139                       => -0.02847,
    139 <= (Integer)c_easiqlife                                                      => -0.253957,
                                                                                        0) ) ;

rpc_subscore2 := __common__( map(
	LoadAmount = Null                       => 0,
    NULL < LoadAmount AND LoadAmount < 20   => -1.19545,
    20 <= LoadAmount AND LoadAmount < 20.29 => -0.852143,
    20.29 <= LoadAmount                     => 0.971668,
                                               0) ) ;

rpc_subscore3 := __common__( map(
    NULL < iv_combined_age AND iv_combined_age < 66 => 0.048882,
    66 <= iv_combined_age                           => -0.942375,
                                                       0) ) ;

rpc_subscore4 := __common__( map(
    (nf_add1_util_infrastructure in ['0']) => 0.046771,
    (nf_add1_util_infrastructure in ['1']) => -0.377603,
                                              0) ) ;

rpc_subscore5 := __common__( map(
    NULL < iv_hist_addr_match AND iv_hist_addr_match < 0 => 0,
    0 <= iv_hist_addr_match AND iv_hist_addr_match < 1   => -0.175575,
    1 <= iv_hist_addr_match AND iv_hist_addr_match < 7   => 0.130953,
    7 <= iv_hist_addr_match AND iv_hist_addr_match < 12  => -0.156045,
    12 <= iv_hist_addr_match                             => -0.768488,
                                                            0) ) ;

rpc_subscore6 := __common__( map(
    NULL < iv_inq_banking_recency AND iv_inq_banking_recency < 1 => 0.200068,
    1 <= iv_inq_banking_recency AND iv_inq_banking_recency < 12  => -0.303501,
    12 <= iv_inq_banking_recency AND iv_inq_banking_recency < 24 => 0.102561,
    24 <= iv_inq_banking_recency AND iv_inq_banking_recency < 99 => 0.172259,
    99 <= iv_inq_banking_recency                                 => 0.104049,
                                                                    0) ) ;

rpc_subscore7 := __common__( map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.275487,
    1 <= iv_inq_per_ssn AND iv_inq_per_ssn < 2   => 0.047269,
    2 <= iv_inq_per_ssn AND iv_inq_per_ssn < 5   => 0.025966,
    5 <= iv_inq_per_ssn AND iv_inq_per_ssn < 7   => -0.015737,
    7 <= iv_inq_per_ssn AND iv_inq_per_ssn < 10  => -0.184718,
    10 <= iv_inq_per_ssn AND iv_inq_per_ssn < 30 => -0.360763,
    30 <= iv_inq_per_ssn                         => -0.846816,
                                                    0) ) ;

rpc_subscore8 := __common__( map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['-1'])                                     => 0.278377,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-1', '1-1', '2-1'])                      => -0.248385,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '1-0', '2-0'])                      => -0.046891,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '1-3', '2-3', '3-0', '3-1', '3-3']) => 0.111641,
                                                                                    0) ) ;

rpc_subscore9 := __common__( map(
    NULL < nf_closest_rel_distance AND nf_closest_rel_distance < 100 => 0.026067,
    100 <= nf_closest_rel_distance                                   => -0.210524,
                                                                        0) ) ;

rpc_subscore10 := __common__( map(
    NULL < nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo < 1 => 0.135497,
    1 <= nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo < 2   => -0.024192,
    2 <= nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo < 3   => -0.043278,
    3 <= nf_fp_srchssnsrchcountmo AND nf_fp_srchssnsrchcountmo < 4   => -0.624801,
    4 <= nf_fp_srchssnsrchcountmo                                    => -1.241138,
                                                                        0) ) ;

rpc_subscore11 := __common__( map(
    NULL < nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 4 => 0.194069,
    4 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 6   => 0.014324,
    6 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 9   => 0.021784,
    9 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 18  => -0.090206,
    18 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 21 => -0.026682,
    21 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 36 => -0.392823,
    36 <= nf_fp_srchaddrsrchcount                                  => -0.481655,
                                                                      0) ) ;

rpc_subscore12 := __common__( map(
    NULL < nf_fp_srchphonesrchcount AND nf_fp_srchphonesrchcount < 4 => 0.025525,
    4 <= nf_fp_srchphonesrchcount AND nf_fp_srchphonesrchcount < 7   => 0.073079,
    7 <= nf_fp_srchphonesrchcount AND nf_fp_srchphonesrchcount < 11  => 0.08351,
    11 <= nf_fp_srchphonesrchcount AND nf_fp_srchphonesrchcount < 18 => -0.407862,
    18 <= nf_fp_srchphonesrchcount                                   => -0.397277,
                                                                        0) ) ;

rpc_subscore13 := __common__( map(
    NULL < dist_conn_retail_mail AND dist_conn_retail_mail < 52.46    => 0.229787,
    52.46 <= dist_conn_retail_mail AND dist_conn_retail_mail < 211.74 => -0.450533,
    211.74 <= dist_conn_retail_mail                                   => -0.795202,
                                                                         0) ) ;

rpc_rawscore := __common__( rpc_subscore0 +
    rpc_subscore1 +
    rpc_subscore2 +
    rpc_subscore3 +
    rpc_subscore4 +
    rpc_subscore5 +
    rpc_subscore6 +
    rpc_subscore7 +
    rpc_subscore8 +
    rpc_subscore9 +
    rpc_subscore10 +
    rpc_subscore11 +
    rpc_subscore12 +
    rpc_subscore13 ) ;

rpc_lnoddsscore := __common__( rpc_rawscore + 3.850388 ) ;

iv_addr_non_phn_src_ct := __common__( if(not(truedid) and add1_pop, NULL, rc_addrcount) ) ;

bst_addr_nhood_properties_sum_c32_b1 := __common__( if(max(add1_nhood_business_count, add1_nhood_sfd_count, add1_nhood_mfd_count) = NULL, NULL, sum(if(add1_nhood_business_count = NULL, 0, add1_nhood_business_count), if(add1_nhood_sfd_count = NULL, 0, add1_nhood_sfd_count), if(add1_nhood_mfd_count = NULL, 0, add1_nhood_mfd_count))) ) ;

bst_addr_nhood_sfd_props_c32_b1 := __common__( add1_nhood_sfd_count ) ;

nf_bst_addr_nhood_pct_sfd_c33 := __common__( map(
    not(truedid)                             => NULL,
    bst_addr_nhood_properties_sum_c32_b1 > 0 => if (bst_addr_nhood_sfd_props_c32_b1 / bst_addr_nhood_properties_sum_c32_b1 * 10 >= 0, roundup(bst_addr_nhood_sfd_props_c32_b1 / bst_addr_nhood_properties_sum_c32_b1 * 10), truncate(bst_addr_nhood_sfd_props_c32_b1 / bst_addr_nhood_properties_sum_c32_b1 * 10)) * 10,
                                                -1) ) ;

bst_addr_nhood_properties_sum_c32_b2 := __common__( if(max(add2_nhood_business_count, add2_nhood_sfd_count, add2_nhood_mfd_count) = NULL, NULL, sum(if(add2_nhood_business_count = NULL, 0, add2_nhood_business_count), if(add2_nhood_sfd_count = NULL, 0, add2_nhood_sfd_count), if(add2_nhood_mfd_count = NULL, 0, add2_nhood_mfd_count))) ) ;

bst_addr_nhood_sfd_props_c32_b2 := __common__( add2_nhood_sfd_count ) ;

nf_bst_addr_nhood_pct_sfd_c34 := __common__( map(
    not(truedid)                             => NULL,
    bst_addr_nhood_properties_sum_c32_b2 > 0 => if (bst_addr_nhood_sfd_props_c32_b2 / bst_addr_nhood_properties_sum_c32_b2 * 10 >= 0, roundup(bst_addr_nhood_sfd_props_c32_b2 / bst_addr_nhood_properties_sum_c32_b2 * 10), truncate(bst_addr_nhood_sfd_props_c32_b2 / bst_addr_nhood_properties_sum_c32_b2 * 10)) * 10,
                                                -1) ) ;

nf_bst_addr_nhood_pct_sfd := __common__( if(add1_isbestmatch, nf_bst_addr_nhood_pct_sfd_c33, nf_bst_addr_nhood_pct_sfd_c34) ) ;

iv_inq_ssns_per_adl := __common__( if(not(truedid), NULL, inq_ssnsperadl) ) ;

sum_dols := __common__( if(pb_offline_dollars = '' and pb_online_dollars = '' and pb_retail_dollars = '', NULL,
            if(max((Integer)pb_offline_dollars, (Integer)pb_online_dollars, (Integer)pb_retail_dollars) = NULL, NULL,
			   sum(if((Integer)pb_offline_dollars = NULL, 0, (Integer)pb_offline_dollars),
			       if((Integer)pb_online_dollars = NULL, 0, (Integer)pb_online_dollars),
			       if((Integer)pb_retail_dollars = NULL, 0, (Integer)pb_retail_dollars)))) ) ;

pct_offline_dols := __common__( if(sum_dols > 0, (Real)pb_offline_dollars / sum_dols, -1) ) ;

pct_retail_dols := __common__( if(sum_dols > 0, (Real)pb_retail_dollars / sum_dols, -1) ) ;

pct_online_dols := __common__( if(sum_dols > 0, (Real)pb_online_dollars / sum_dols, -1) ) ;

iv_pb_profile := __common__( map(
    not(truedid)              => '                 ',
    pb_number_of_sources = '' => '0 No Purch Data  ',
    pct_offline_dols > .50    => '1 Offline Shopper',
    pct_online_dols > .50     => '2 Online Shopper ',
    pct_retail_dols > .50     => '3 Retail Shopper ',
                                 '4 Other') ) ;

nf_fp_srchfraudsrchcount := __common__( if(not(truedid), NULL, (Integer)fp_srchfraudsrchcount) ) ;

nf_fp_srchfraudsrchcountmo := __common__( if(not(truedid), NULL, (Integer)fp_srchfraudsrchcountmo) ) ;

nf_fp_corraddrnamecount := __common__( if(not(truedid), NULL, (Integer)fp_corraddrnamecount) ) ;

nf_fp_addrchangevaluediff := __common__( if(not(truedid), NULL, (Integer)fp_addrchangevaluediff) ) ;

rwc_subscore0 := __common__( map(
    c_fammar_p != '' and NULL < (Real)c_fammar_p AND (Real)c_fammar_p < 34.2 => -0.524289,
    34.2 <= (Real)c_fammar_p                                                 => 0.041187,
                                                                                0) ) ;

rwc_subscore1 := __common__( map(
    c_born_usa != '' and NULL < (Integer)c_born_usa AND (Integer)c_born_usa < 23 => -0.45176,
    23 <= (Integer)c_born_usa AND (Integer)c_born_usa < 52                       => -0.18871,
    52 <= (Integer)c_born_usa AND (Integer)c_born_usa < 89                       => -0.041066,
    89 <= (Integer)c_born_usa                                                    => 0.161078,
                                                                                    0) ) ;

rwc_subscore2 := __common__( map(
    c_unempl != '' and NULL < (Integer)c_unempl AND (Integer)c_unempl < 102 => 0.195266,
    102 <= (Integer)c_unempl AND (Integer)c_unempl < 130                    => -0.053317,
    130 <= (Integer)c_unempl AND (Integer)c_unempl < 181                    => -0.208943,
    181 <= (Integer)c_unempl                                                => -0.24906,
                                                                               0) ) ;

rwc_subscore3 := __common__( map(
	LoadAmount = Null                                   => 0,
    NULL < LoadAmount AND LoadAmount < 20   => -1.905609,
    20 <= LoadAmount AND LoadAmount < 20.14 => -0.70422,
    20.14 <= LoadAmount                           => 1.274215,
                                                           0) ) ;

rwc_subscore4 := __common__( map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 13  => 0.192094,
    13 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 105  => -0.195672,
    105 <= iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 635 => -0.474815,
    635 <= iv_va060_dist_add_in_bst                                    => -0.866602,
                                                                          0) ) ;

rwc_subscore5 := __common__( map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.12404,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => -0.286936,
    2 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 4   => -0.062617,
    4 <= iv_addr_non_phn_src_ct                                  => 0.345137,
                                                                    0) ) ;

rwc_subscore6 := __common__( map(
    NULL < iv_combined_age AND iv_combined_age < 44 => 0.361167,
    44 <= iv_combined_age AND iv_combined_age < 53  => -0.028563,
    53 <= iv_combined_age AND iv_combined_age < 63  => -0.310135,
    63 <= iv_combined_age                           => -1.756293,
                                                       0) ) ;

rwc_subscore7 := __common__( map(
    NULL < nf_bst_addr_nhood_pct_sfd AND nf_bst_addr_nhood_pct_sfd < 100 => -0.131779,
    100 <= nf_bst_addr_nhood_pct_sfd                                     => 0.234646,
                                                                            0) ) ;

rwc_subscore8 := __common__( map(
    NULL < iv_inq_ssns_per_adl AND iv_inq_ssns_per_adl < 1 => -0.06663,
    1 <= iv_inq_ssns_per_adl AND iv_inq_ssns_per_adl < 2   => 0.10387,
    2 <= iv_inq_ssns_per_adl                               => -0.085965,
                                                              0) ) ;

rwc_subscore9 := __common__( map(
    NULL < iv_inq_per_ssn AND iv_inq_per_ssn < 1 => 0.536529,
    1 <= iv_inq_per_ssn AND iv_inq_per_ssn < 3   => -0.013349,
    3 <= iv_inq_per_ssn AND iv_inq_per_ssn < 5   => -0.030663,
    5 <= iv_inq_per_ssn                          => -0.662377,
                                                    0) ) ;

rwc_subscore10 := __common__( map(
    (iv_pb_profile in ['0 No Purch Data'])              => -0.078383,
    (iv_pb_profile in ['1 Offline Shopper', '4 Other']) => -0.159409,
    (iv_pb_profile in ['2 Online Shopper'])             => 0.189612,
    (iv_pb_profile in ['3 Retail Shopper'])             => 0.428528,
                                                           0) ) ;

rwc_subscore11 := __common__( map(
    NULL < nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 3 => 0.157368,
    3 <= nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 5   => -0.114128,
    5 <= nf_fp_srchfraudsrchcount AND nf_fp_srchfraudsrchcount < 15  => -0.017407,
    15 <= nf_fp_srchfraudsrchcount                                   => -0.398893,
                                                                        0) ) ;

rwc_subscore12 := __common__( map(
    NULL < nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo < 1 => 0.018318,
    1 <= nf_fp_srchfraudsrchcountmo AND nf_fp_srchfraudsrchcountmo < 2   => 0.37595,
    2 <= nf_fp_srchfraudsrchcountmo                                      => -0.502397,
                                                                            0) ) ;

rwc_subscore13 := __common__( map(
    NULL < nf_fp_corraddrnamecount AND nf_fp_corraddrnamecount < 1 => -0.3829,
    1 <= nf_fp_corraddrnamecount                                   => 0.14858,
                                                                      0) ) ;

rwc_subscore14 := __common__( map(
    NULL < nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 6 => 0.219626,
    6 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 8   => -0.068245,
    8 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 14  => -0.218384,
    14 <= nf_fp_srchaddrsrchcount AND nf_fp_srchaddrsrchcount < 24 => -0.505403,
    24 <= nf_fp_srchaddrsrchcount                                  => -0.75245,
                                                                      0) ) ;

rwc_subscore15 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 1 => 0.079368,
    1 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 2   => -0.058136,
    2 <= nf_fp_srchaddrsrchcountmo                                     => -0.278828,
                                                                          0) ) ;

rwc_subscore16 := __common__( map(
    NULL < nf_fp_addrchangevaluediff AND nf_fp_addrchangevaluediff < -113148    => -0.468697,
    -113148 <= nf_fp_addrchangevaluediff AND nf_fp_addrchangevaluediff < -67314 => -0.648761,
    -67314 <= nf_fp_addrchangevaluediff                                         => 0.092546,
                                                                                   0) ) ;

rwc_subscore17 := __common__( map(
    // (Real)dist_mail_ip = 0                                    => 0.000000,
    NULL < (Real)dist_mail_ip AND (Real)dist_mail_ip < 216    => 0.194571,
    216 <= (Real)dist_mail_ip AND (Real)dist_mail_ip < 674.58 => -0.010642,
    674.58 <= (Real)dist_mail_ip                              => -0.530693,
                                                                 0) ) ;

rwc_subscore18 := __common__( map(
    NULL < dist_conn_retail_mail AND dist_conn_retail_mail < 28.36    => 0.31597,
    28.36 <= dist_conn_retail_mail AND dist_conn_retail_mail < 110.43 => -0.223989,
    110.43 <= dist_conn_retail_mail                                   => -0.44143,
                                                                         0) ) ;

rwc_rawscore := __common__( rwc_subscore0 +
    rwc_subscore1 +
    rwc_subscore2 +
    rwc_subscore3 +
    rwc_subscore4 +
    rwc_subscore5 +
    rwc_subscore6 +
    rwc_subscore7 +
    rwc_subscore8 +
    rwc_subscore9 +
    rwc_subscore10 +
    rwc_subscore11 +
    rwc_subscore12 +
    rwc_subscore13 +
    rwc_subscore14 +
    rwc_subscore15 +
    rwc_subscore16 +
    rwc_subscore17 +
    rwc_subscore18 ) ;

rwc_lnoddsscore := __common__( rwc_rawscore + 3.638106 ) ;

_rc_ssnhighissue := __common__( if(rc_ssnhighissue = '', NULL, common.sas_date((rc_ssnhighissue))) ) ;

iv_age_at_high_issue := __common__( if(_rc_ssnhighissue = NULL, NULL,
                        if(not(truedid and (Integer)ssnlength > 0 and age > 0), NULL,
						if (age - (sysdate - _rc_ssnhighissue) / 365.25 >= 0, truncate(age - (sysdate - _rc_ssnhighissue) / 365.25), roundup(age - (sysdate - _rc_ssnhighissue) / 365.25)))) ) ;

iv_addr_lres_12mo_count := __common__( map(
    not(truedid)                 => NULL,
    addr_lres_12mo_count = -9999 => -1,
                                    addr_lres_12mo_count) ) ;

iv_max_ids_per_sfd_addr_c6 := __common__( map(
    not(add1_pop)            => NULL,
    (String)iv_add_apt = '1' => -1,
                                max(adls_per_addr_c6, ssns_per_addr_c6)) ) ;

iv_inq_banking_count12 := __common__( if(not(truedid), NULL, inq_banking_count12) ) ;

iv_inq_ssns_per_addr := __common__( if(not(add1_pop), NULL, inq_ssnsperaddr) ) ;

nf_average_rel_distance := __common__( map(
    not(truedid)                                                                                                                                                                                                                                                                                                                                                                                      => NULL,
    rel_count = 0                                                                                                                                                                                                                                                                                                                                                                                     => -1,
    if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) = 0 => 0,
                                                                                                                                                                                                                                                                                                                                                                                                         if (if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count))) >= 0, truncate(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))), roundup(if(max(rel_within25miles_count * 25, rel_within100miles_count * 100, rel_within500miles_count * 500, rel_withinOther_count * 1000) = NULL, NULL, sum(if(rel_within25miles_count * 25 = NULL, 0, rel_within25miles_count * 25), if(rel_within100miles_count * 100 = NULL, 0, rel_within100miles_count * 100), if(rel_within500miles_count * 500 = NULL, 0, rel_within500miles_count * 500), if(rel_withinOther_count * 1000 = NULL, 0, rel_withinOther_count * 1000))) / if(max(rel_within25miles_count, rel_within100miles_count, rel_within500miles_count, rel_withinOther_count) = NULL, NULL, sum(if(rel_within25miles_count = NULL, 0, rel_within25miles_count), if(rel_within100miles_count = NULL, 0, rel_within100miles_count), if(rel_within500miles_count = NULL, 0, rel_within500miles_count), if(rel_withinOther_count = NULL, 0, rel_withinOther_count)))))) ) ;

nf_fp_corrrisktype := __common__( if(not(truedid) or (Integer)fp_corrrisktype = NULL, NULL, (Integer)fp_corrrisktype) ) ;

nf_fp_corrssnaddrcount := __common__( if(not(truedid), NULL, (Integer)fp_corrssnaddrcount) ) ;

onc_subscore0 := __common__( map(
    c_med_hval != '' and NULL < (Integer)c_med_hval AND (Integer)c_med_hval < 91296 => 0.450607,
    91296 <= (Integer)c_med_hval AND (Integer)c_med_hval < 121711                   => 0.069064,
    121711 <= (Integer)c_med_hval AND (Integer)c_med_hval < 172575                  => -0.042495,
    172575 <= (Integer)c_med_hval                                                   => -0.220059,
                                                                                       0) ) ;

onc_subscore1 := __common__( map(
    c_fammar_p != '' and NULL < (Real)c_fammar_p AND (Real)c_fammar_p < 44.5 => -0.488856,
    44.5 <= (Real)c_fammar_p AND (Real)c_fammar_p < 62.5                     => 0.027652,
    62.5 <= (Real)c_fammar_p AND (Real)c_fammar_p < 78.9                     => 0.133962,
    78.9 <= (Real)c_fammar_p                                                 => 0.22872,
                                                                                0) ) ;

onc_subscore2 := __common__( map(
    c_easiqlife != '' and NULL < (Integer)c_easiqlife AND (Integer)c_easiqlife < 133 => 0.129607,
    133 <= (Integer)c_easiqlife                                                      => -0.150347,
                                                                                        0) ) ;

onc_subscore3 := __common__( map(
    c_born_usa != '' and NULL < (Integer)c_born_usa AND (Integer)c_born_usa < 30 => -0.16802,
    30 <= (Integer)c_born_usa AND (Integer)c_born_usa < 47                       => -0.062045,
    47 <= (Integer)c_born_usa AND (Integer)c_born_usa < 78                       => -0.028971,
    78 <= (Integer)c_born_usa AND (Integer)c_born_usa < 117                      => 0.04222,
    117 <= (Integer)c_born_usa                                                   => 0.12075,
                                                                                    0) ) ;

onc_subscore4 := __common__( map(
    c_unempl != '' and NULL < (Integer)c_unempl AND (Integer)c_unempl < 69 => 0.279861,
    69 <= (Integer)c_unempl AND (Integer)c_unempl < 135                    => 0.040313,
    135 <= (Integer)c_unempl AND (Integer)c_unempl < 176                   => -0.067504,
    176 <= (Integer)c_unempl                                               => -0.31978,
                                                                              0) ) ;

onc_subscore5 := __common__( map(
    (iproutingmethod in [' ', '06', '10', '11', '12', '13', '14', '15']) => 0.023553,
    (iproutingmethod in ['02', '16'])                                    => -0.762933,
                                                                            0) ) ;

onc_subscore6 := __common__( map(
    NULL < iv_va060_dist_add_in_bst AND iv_va060_dist_add_in_bst < 18 => 0.155001,
    18 <= iv_va060_dist_add_in_bst                                    => -0.242239,
                                                                         0) ) ;

onc_subscore7 := __common__( map(
    NULL < iv_age_at_high_issue AND iv_age_at_high_issue < 13 => 0.157565,
    13 <= iv_age_at_high_issue AND iv_age_at_high_issue < 16  => 0.047708,
    16 <= iv_age_at_high_issue AND iv_age_at_high_issue < 18  => -0.279859,
    18 <= iv_age_at_high_issue                                => -0.535486,
                                                                 0) ) ;

onc_subscore8 := __common__( map(
    NULL < iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 1 => -0.433634,
    1 <= iv_addr_lres_12mo_count AND iv_addr_lres_12mo_count < 3   => -0.131604,
    3 <= iv_addr_lres_12mo_count                                   => 0.220051,
                                                                      0) ) ;

onc_subscore9 := __common__( map(
    NULL < iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 0 => -0.182599,
    0 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 1   => 0.213763,
    1 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 3   => 0.143068,
    3 <= iv_max_ids_per_sfd_addr_c6 AND iv_max_ids_per_sfd_addr_c6 < 5   => 0.082431,
    5 <= iv_max_ids_per_sfd_addr_c6                                      => -0.523035,
                                                                            0) ) ;

onc_subscore10 := __common__( map(
    NULL < iv_inq_banking_count12 AND iv_inq_banking_count12 < 1 => 0.188761,
    1 <= iv_inq_banking_count12 AND iv_inq_banking_count12 < 4   => 0.00441,
    4 <= iv_inq_banking_count12 AND iv_inq_banking_count12 < 8   => -0.301308,
    8 <= iv_inq_banking_count12                                  => -0.765884,
                                                                    0) ) ;

onc_subscore11 := __common__( map(
    NULL < iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 1 => 0.412963,
    1 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 2   => 0.12446,
    2 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 3   => 0.023074,
    3 <= iv_inq_ssns_per_addr AND iv_inq_ssns_per_addr < 5   => 0.073498,
    5 <= iv_inq_ssns_per_addr                                => -0.476887,
                                                                0) ) ;

onc_subscore12 := __common__( map(
    NULL < nf_average_rel_distance AND nf_average_rel_distance < 25  => 0,
    25 <= nf_average_rel_distance AND nf_average_rel_distance < 314  => 0.148916,
    314 <= nf_average_rel_distance AND nf_average_rel_distance < 561 => -0.00338,
    561 <= nf_average_rel_distance AND nf_average_rel_distance < 895 => -0.206286,
    895 <= nf_average_rel_distance                                   => -0.250535,
                                                                        0) ) ;

onc_subscore13 := __common__( map(
    ((String)nf_fp_corrrisktype in ['1', '2', '3', '4', '5', '6', '7', '8']) => 0.326055,
    ((String)nf_fp_corrrisktype in ['9'])                                    => -0.298653,
                                                                                0) ) ;

onc_subscore14 := __common__( map(
    NULL < nf_fp_corrssnaddrcount AND nf_fp_corrssnaddrcount < 1 => -0.100622,
    1 <= nf_fp_corrssnaddrcount AND nf_fp_corrssnaddrcount < 2   => 0.287151,
    2 <= nf_fp_corrssnaddrcount AND nf_fp_corrssnaddrcount < 5   => 0.02401,
    5 <= nf_fp_corrssnaddrcount                                  => 0.202006,
                                                                    0) ) ;

onc_subscore15 := __common__( map(
    NULL < nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 1 => 0.272737,
    1 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 2   => 0.23376,
    2 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 3   => -0.196824,
    3 <= nf_fp_srchaddrsrchcountmo AND nf_fp_srchaddrsrchcountmo < 4   => -0.718185,
    4 <= nf_fp_srchaddrsrchcountmo                                     => -0.517485,
                                                                          0) ) ;

onc_subscore16 := __common__( map(
    // dist_conn_mail_ip = 0                                   => 0.000000,
    NULL < dist_conn_mail_ip AND dist_conn_mail_ip < 2.77   => 0.100915,
    2.77 <= dist_conn_mail_ip AND dist_conn_mail_ip < 732.1 => 0.085326,
    732.1 <= dist_conn_mail_ip                              => -0.268279,
                                                               0) ) ;

onc_rawscore := __common__( onc_subscore0 +
    onc_subscore1 +
    onc_subscore2 +
    onc_subscore3 +
    onc_subscore4 +
    onc_subscore5 +
    onc_subscore6 +
    onc_subscore7 +
    onc_subscore8 +
    onc_subscore9 +
    onc_subscore10 +
    onc_subscore11 +
    onc_subscore12 +
    onc_subscore13 +
    onc_subscore14 +
    onc_subscore15 +
    onc_subscore16 ) ;

onc_lnoddsscore := __common__( onc_rawscore + 4.320495 ) ;

segment := __common__( map(
    in_ip_address_1 != '' and LoadAmount > 0  => 'RETAIL WEB ACT  ',
	in_ip_address_1 = '' and LoadAmount > 0   => 'RETAIL PHONE ACT',
	in_ip_address_1 != '' and LoadAmount <= 0 => 'ONLINE PRODUCT  ',
    in_ip_address_1 = ''                      => 'RETAIL PHONE ACT',
                                                 'RETAIL WEB ACT  ') ) ;

_fp31310_2_0 := __common__( map(
    segment = 'RETAIL PHONE ACT' => rpc_lnoddsscore,
    segment = 'RETAIL WEB ACT  ' => rwc_lnoddsscore,
                                    onc_lnoddsscore) ) ;

base := __common__( 700 ) ;

pts := __common__( 40 ) ;

logit := __common__( ln(98.2 / 1.8) ) ;

fp31310_2_0 := __common__( min(if(max(round(base + pts * (_fp31310_2_0 - logit) / ln(2)), 300) = NULL, -NULL, max(round(base + pts * (_fp31310_2_0 - logit) / ln(2)), 300)), 999) ) ;

#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam							  := le;
	self.LoadAmount                       := (String)LoadAmount;
	self.RetailZip                        := RetailZip;
	self.mobile_ip                        := mobile_ip;
	self.dist_conn_mail_ip                := dist_conn_mail_ip;
	self.dist_conn_retail_mail            := dist_conn_retail_mail;
	self.iproutingmethod                  := iproutingmethod;
	self.sysdate                          := sysdate;
	self.iv_pots_phone                    := iv_pots_phone;
	self.iv_add_apt                       := iv_add_apt;
	self._reported_dob                    := _reported_dob;
	self.reported_age                     := reported_age;
	self.iv_combined_age                  := iv_combined_age;
	self.iv_inq_per_ssn                   := iv_inq_per_ssn;
	self.nf_fp_srchaddrsrchcount          := nf_fp_srchaddrsrchcount;
	self.iv_va060_dist_add_in_bst         := iv_va060_dist_add_in_bst;
	self.nf_fp_srchaddrsrchcountmo        := nf_fp_srchaddrsrchcountmo;
	self.nf_add1_util_infrastructure      := nf_add1_util_infrastructure;
	self.iv_hist_addr_match               := iv_hist_addr_match;
	self.iv_inq_banking_recency           := iv_inq_banking_recency;
	self.ver_phn_inf                      := ver_phn_inf;
	self.ver_phn_nap                      := ver_phn_nap;
	self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
	self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
	self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
	self.nf_closest_rel_distance          := nf_closest_rel_distance;
	self.nf_fp_srchssnsrchcountmo         := nf_fp_srchssnsrchcountmo;
	self.nf_fp_srchphonesrchcount         := nf_fp_srchphonesrchcount;
	self.rpc_subscore0                    := rpc_subscore0;
	self.rpc_subscore1                    := rpc_subscore1;
	self.rpc_subscore2                    := rpc_subscore2;
	self.rpc_subscore3                    := rpc_subscore3;
	self.rpc_subscore4                    := rpc_subscore4;
	self.rpc_subscore5                    := rpc_subscore5;
	self.rpc_subscore6                    := rpc_subscore6;
	self.rpc_subscore7                    := rpc_subscore7;
	self.rpc_subscore8                    := rpc_subscore8;
	self.rpc_subscore9                    := rpc_subscore9;
	self.rpc_subscore10                   := rpc_subscore10;
	self.rpc_subscore11                   := rpc_subscore11;
	self.rpc_subscore12                   := rpc_subscore12;
	self.rpc_subscore13                   := rpc_subscore13;
	self.rpc_rawscore                     := rpc_rawscore;
	self.rpc_lnoddsscore                  := rpc_lnoddsscore;
	self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
	self.nf_bst_addr_nhood_pct_sfd        := nf_bst_addr_nhood_pct_sfd;
	self.iv_inq_ssns_per_adl              := iv_inq_ssns_per_adl;
	self.sum_dols                         := sum_dols;
	self.pct_offline_dols                 := pct_offline_dols;
	self.pct_retail_dols                  := pct_retail_dols;
	self.pct_online_dols                  := pct_online_dols;
	self.iv_pb_profile                    := iv_pb_profile;
	self.nf_fp_srchfraudsrchcount         := nf_fp_srchfraudsrchcount;
	self.nf_fp_srchfraudsrchcountmo       := nf_fp_srchfraudsrchcountmo;
	self.nf_fp_corraddrnamecount          := nf_fp_corraddrnamecount;
	self.nf_fp_addrchangevaluediff        := nf_fp_addrchangevaluediff;
	self.rwc_subscore0                    := rwc_subscore0;
	self.rwc_subscore1                    := rwc_subscore1;
	self.rwc_subscore2                    := rwc_subscore2;
	self.rwc_subscore3                    := rwc_subscore3;
	self.rwc_subscore4                    := rwc_subscore4;
	self.rwc_subscore5                    := rwc_subscore5;
	self.rwc_subscore6                    := rwc_subscore6;
	self.rwc_subscore7                    := rwc_subscore7;
	self.rwc_subscore8                    := rwc_subscore8;
	self.rwc_subscore9                    := rwc_subscore9;
	self.rwc_subscore10                   := rwc_subscore10;
	self.rwc_subscore11                   := rwc_subscore11;
	self.rwc_subscore12                   := rwc_subscore12;
	self.rwc_subscore13                   := rwc_subscore13;
	self.rwc_subscore14                   := rwc_subscore14;
	self.rwc_subscore15                   := rwc_subscore15;
	self.rwc_subscore16                   := rwc_subscore16;
	self.rwc_subscore17                   := rwc_subscore17;
	self.rwc_subscore18                   := rwc_subscore18;
	self.rwc_rawscore                     := rwc_rawscore;
	self.rwc_lnoddsscore                  := rwc_lnoddsscore;
	self._rc_ssnhighissue                 := _rc_ssnhighissue;
	self.iv_age_at_high_issue             := iv_age_at_high_issue;
	self.iv_addr_lres_12mo_count          := iv_addr_lres_12mo_count;
	self.iv_max_ids_per_sfd_addr_c6       := iv_max_ids_per_sfd_addr_c6;
	self.iv_inq_banking_count12           := iv_inq_banking_count12;
	self.iv_inq_ssns_per_addr             := iv_inq_ssns_per_addr;
	self.nf_average_rel_distance          := nf_average_rel_distance;
	self.nf_fp_corrrisktype               := nf_fp_corrrisktype;
	self.nf_fp_corrssnaddrcount           := nf_fp_corrssnaddrcount;
	self.onc_subscore0                    := onc_subscore0;
	self.onc_subscore1                    := onc_subscore1;
	self.onc_subscore2                    := onc_subscore2;
	self.onc_subscore3                    := onc_subscore3;
	self.onc_subscore4                    := onc_subscore4;
	self.onc_subscore5                    := onc_subscore5;
	self.onc_subscore6                    := onc_subscore6;
	self.onc_subscore7                    := onc_subscore7;
	self.onc_subscore8                    := onc_subscore8;
	self.onc_subscore9                    := onc_subscore9;
	self.onc_subscore10                   := onc_subscore10;
	self.onc_subscore11                   := onc_subscore11;
	self.onc_subscore12                   := onc_subscore12;
	self.onc_subscore13                   := onc_subscore13;
	self.onc_subscore14                   := onc_subscore14;
	self.onc_subscore15                   := onc_subscore15;
	self.onc_subscore16                   := onc_subscore16;
	self.onc_rawscore                     := onc_rawscore;
	self.onc_lnoddsscore                  := onc_lnoddsscore;
	self.segment                          := segment;
	self._fp31310_2_0                     := _fp31310_2_0;
	self.base                             := base;
	self.pts                              := pts;
	self.logit                            := logit;
	self.fp31310_2_0                      := fp31310_2_0;
#end
	self.seq := le.bs.seq;
	ritmp :=  Models.fraudpoint_reasons(le.bs, le.ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP31310_2_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp31310_2_0;
	self := [];
END;

model :=   join(clam, Easi.Key_Easi_Census,
	left.bs.shell_input.st<>''
		and left.bs.shell_input.county <>''
		and left.bs.shell_input.geo_blk <> ''
		and keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
	doModel(left, right), left outer,
	atmost(RiskWise.max_atmost)
	,keep(1)
);
	return model;
END;