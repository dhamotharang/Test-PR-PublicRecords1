//Axcess Financial - custom Fraudpoint model

import risk_indicators, riskwise, ut, easi, std;

blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];

export FP1310_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam,  integer1 num_reasons) := FUNCTION

FP_DEBUG := false;
	
	#if(FP_DEBUG)
		Layout_Debug := RECORD
		/* Model Input Variables */
			integer sysdate                         ;          
			string iv_db001_bankruptcy              ;           
			integer _in_dob                         ;           
			real yr_in_dob                       ;           
			integer yr_in_dob_int                   ;           
			integer age_estimate                    ;           
			integer iv_ag001_age                    ;           
			integer bureau_addr_tn_count_pos        ;           
			boolean bureau_addr_count_tn            ;           
			integer bureau_addr_ts_count_pos        ;           
			boolean bureau_addr_count_ts            ;           
			integer bureau_addr_tu_count_pos        ;           
			boolean bureau_addr_count_tu            ;           
			integer bureau_addr_en_count_pos        ;           
			boolean bureau_addr_count_en            ;           
			integer bureau_addr_eq_count_pos        ;           
			boolean bureau_addr_count_eq            ;           
			integer _src_bureau_addr_count          ;           
			integer iv_src_bureau_addr_count        ;           
			integer iv_bst_addr_assessed_total_val  ;           
			integer iv_inq_highriskcredit_recency   ;           
			integer iv_inq_communications_recency   ;           
			integer iv_inq_adls_per_addr            ;           
			boolean ver_phn_inf                     ;           
			boolean ver_phn_nap                     ;           
			integer inf_phn_ver_lvl                 ;           
			integer nap_phn_ver_lvl                 ;           
			string iv_nap_phn_ver_x_inf_phn_ver    	;           
			integer iv_eviction_count               ;           
			string iv_criminal_x_felony            	;           
			integer iv_pb_total_orders              ;           
			string nf_fp_varrisktype              	;          
			integer nf_fp_assocsuspicousidcount    	;           
			string nf_fp_divrisktype                ;           
			integer nf_fp_curraddrcartheftindex      ;           
			real subscore0                       		;           
			real subscore1                       		;           
			real subscore2                       		;           
			real subscore3                       		;           
			real subscore4                       		;           
			real subscore5                       		;           
			real subscore6                       		;           
			real subscore7                       		;           
			real subscore8                       		;           
			real subscore9                       		;           
			real subscore10                      		;           
			real subscore11                      		;           
			real subscore12                      		;           
			real subscore13                      		;           
			real subscore14                      		;           
			real subscore15                      		;           
			real rawscore                        		;           
			real lnoddsscore                     		;           
			real probscore                       		;           
			integer base                         		;           
			integer pts                          		;           
			real odds                            		;           
			integer fp1310_1_0                   		;                                 
		
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
		END;
		layout_debug doModel( clam le, easi.Key_Easi_Census ri ) :=  TRANSFORM
#else
		models.layout_modelout doModel( clam le, easi.Key_Easi_Census ri  ) := TRANSFORM
#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	c_unemp                          := ri.unemp;
	truedid                          := le.truedid;
	in_dob                           := le.shell_input.dob;
	nap_summary                      := le.iid.nap_summary;
	rc_bansflag                      := le.iid.bansflag;
	ver_sources                      := le.header_summary.ver_sources;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_assessed_total_value        := le.address_verification.input_address_information.assessed_total_value;
	add1_pop                         := le.addrpop;
	add2_assessed_total_value        := le.address_verification.address_history_1.assessed_total_value;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_highriskcredit_count01       := le.acc_logs.highriskcredit.count01;
	inq_highriskcredit_count03       := le.acc_logs.highriskcredit.count03;
	inq_highriskcredit_count06       := le.acc_logs.highriskcredit.count06;
	inq_highriskcredit_count12       := le.acc_logs.highriskcredit.count12;
	inq_highriskcredit_count24       := le.acc_logs.highriskcredit.count24;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	inq_communications_count01       := le.acc_logs.communications.count01;
	inq_communications_count03       := le.acc_logs.communications.count03;
	inq_communications_count06       := le.acc_logs.communications.count06;
	inq_communications_count12       := le.acc_logs.communications.count12;
	inq_communications_count24       := le.acc_logs.communications.count24;
	inq_adlsperaddr                  := le.acc_logs.inquiryadlsperaddr;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_eviction_count              := le.bjl.eviction_count;
	fp_varrisktype                   := le.fdattributesv2.variationrisklevel;
	fp_assocsuspicousidcount         := le.fdattributesv2.assocsuspicousidentitiescount;
	fp_divrisktype                   := le.fdattributesv2.divrisklevel;
	fp_curraddrcartheftindex         := le.fdattributesv2.curraddrcartheftindex;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	inferred_age                     := le.inferred_age;

/* ***********************************************************
*                    Generated ECL                          *
************************************************************** */

NULL := -999999999;


INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

iv_db001_bankruptcy := map(
    not(truedid or (integer) ssnlength > 0)          => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])  => '1 - BK Discharged',
    (disposition in ['Dismissed'])                   => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt or contains_i(ver_sources, 'BA') > 0 or 
			filing_count > 0 or bk_recent_count > 0 			 => '3 - BK Other     ',
																										  	'0 - No BK        ');
																											
_in_dob := common.sas_date((string)(in_dob)) ;

//yr_in_dob := if(in_dob = NULL, -1, (sysdate - _in_dob) / 365.25);
yr_in_dob :=   map(
								in_dob = ''  => -1, 
								in_dob = '0' => 0, 
								(sysdate - _in_dob) / 365.25);   


yr_in_dob_int :=  if (yr_in_dob >= 0, roundup(yr_in_dob), truncate(yr_in_dob));

age_estimate := map(
    yr_in_dob_int > 0 => yr_in_dob_int,
    inferred_age > 0  => inferred_age,
                         -1);

iv_ag001_age := if(not(truedid or dobpop), NULL, min(62, if(age_estimate = NULL, -NULL, age_estimate)));

bureau_addr_tn_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

bureau_addr_count_tn := if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ','));

bureau_addr_ts_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

bureau_addr_count_ts := if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ','));

bureau_addr_tu_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

bureau_addr_count_tu := if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ','));

bureau_addr_en_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

bureau_addr_count_en := if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ','));

bureau_addr_eq_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

bureau_addr_count_eq := if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ','));

_src_bureau_addr_count := max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0);

iv_src_bureau_addr_count := map(
    not(truedid)                  => NULL,
    _src_bureau_addr_count = NULL => -1,
                                     _src_bureau_addr_count);

iv_bst_addr_assessed_total_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_assessed_total_value,
                        add2_assessed_total_value);

iv_inq_highriskcredit_recency := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 >0 => 1,
    inq_highRiskCredit_count03 >0 => 3,
    inq_highRiskCredit_count06 >0 => 6,
    inq_highRiskCredit_count12 >0 => 12,
    inq_highRiskCredit_count24 >0 => 24,
    inq_highRiskCredit_count >0   => 99,
                                  0);

iv_inq_communications_recency := map(
    not(truedid)               => NULL,
    inq_communications_count01 >0 => 1,
    inq_communications_count03 >0 => 3,
    inq_communications_count06 >0 => 6,
    inq_communications_count12 >0 => 12,
    inq_communications_count24 >0 => 24,
    inq_communications_count >0  => 99,
                                  0);

iv_inq_adls_per_addr := if(not(add1_pop), NULL, inq_adlsperaddr);

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
    trim((string) nap_phn_ver_lvl, LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string) inf_phn_ver_lvl, LEFT, RIGHT));

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

iv_criminal_x_felony :=   if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + 
											'-' + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_pb_total_orders := map(
    not(truedid)           => NULL,
    pb_total_orders = ''   => -1,
    (integer) pb_total_orders);

nf_fp_varrisktype := if(not(truedid) or (string)fp_varrisktype = '', '', trim((string)fp_varrisktype, LEFT)) ;
nf_fp_assocsuspicousidcount := if(not(truedid), NULL, (integer)fp_assocsuspicousidcount) ;
nf_fp_divrisktype := if(not(truedid), '', trim((string)fp_divrisktype, LEFT)) ;
nf_fp_curraddrcartheftindex := if(not(truedid), NULL, (integer)fp_curraddrcartheftindex) ;

subscore0 := map(
    NULL < iv_inq_communications_recency AND iv_inq_communications_recency < 1 => 0.282362,
    1 <= iv_inq_communications_recency AND iv_inq_communications_recency < 12  => -0.799062,
    12 <= iv_inq_communications_recency AND iv_inq_communications_recency < 24 => -0.343733,
    24 <= iv_inq_communications_recency AND iv_inq_communications_recency < 99 => -0.242491,
    99 <= iv_inq_communications_recency                                        => -0.042672,
                                                                                  -0.000000);

subscore1 := map(
    NULL < iv_ag001_age AND iv_ag001_age < 33 => -0.268044,
    33 <= iv_ag001_age AND iv_ag001_age < 44  => -0.068072,
    44 <= iv_ag001_age AND iv_ag001_age < 56  => 0.383413,
    56 <= iv_ag001_age                        => 0.511534,
                                                 -0.000000);

subscore2 := map(
    (iv_db001_bankruptcy in ['2 - BK Dismissed'])  => -0.324582,
    (iv_db001_bankruptcy in ['0 - No BK'])         => -0.120404,
    (iv_db001_bankruptcy in ['3 - BK Other'])      => 0.381532,
    (iv_db001_bankruptcy in ['1 - BK Discharged']) => 0.605423,
                                                      0.000000);

subscore3 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.241582,
    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 3   => -0.378757,
    3 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 4   => -0.139497,
    4 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 5   => 0.017145,
    5 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 7   => 0.053373,
    7 <= iv_src_bureau_addr_count                                    => 0.291547,
                                                                        0.000000);

subscore4 := map(
    NULL < iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 1 => 0.208835,
    1 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 2   => 0.048388,
    2 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 3   => -0.123854,
    3 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 4   => -0.164462,
    4 <= iv_inq_adls_per_addr AND iv_inq_adls_per_addr < 5   => -0.379277,
    5 <= iv_inq_adls_per_addr                                => -0.690575,
                                                                0.000000);

subscore5 := map(
    NULL < iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 1         => -0.004658,
    1 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 6187        => -0.594550,
    6187 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 27009    => -0.005219,
    27009 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 44590   => 0.026669,
    44590 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 66200   => 0.227353,
    66200 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 100000  => 0.506318,
    100000 <= iv_bst_addr_assessed_total_val AND iv_bst_addr_assessed_total_val < 305400 => 0.074532,
    305400 <= iv_bst_addr_assessed_total_val                                             => -0.174678,
                                                                                            -0.000000);

subscore6 := map(
    NULL < iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 1 => 0.210268,
    1 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 3   => -0.521255,
    3 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 12  => -0.243587,
    12 <= iv_inq_highriskcredit_recency AND iv_inq_highriskcredit_recency < 24 => -0.098014,
    24 <= iv_inq_highriskcredit_recency                                        => -0.095078,
                                                                                  -0.000000);

subscore7 := map(
    NULL < iv_pb_total_orders AND iv_pb_total_orders < 1 => -0.177412,
    1 <= iv_pb_total_orders                              => 0.211352,
                                                            0.000000);

subscore8 := map(
    NULL < nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 2 => 0.104005,
    2 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 5   => 0.209749,
    5 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 9   => 0.060160,
    9 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 12  => -0.124633,
    12 <= nf_fp_assocsuspicousidcount AND nf_fp_assocsuspicousidcount < 20 => -0.301487,
    20 <= nf_fp_assocsuspicousidcount                                      => -0.338165,
                                                                              -0.000000);

subscore9 := map(
    (nf_fp_varrisktype in [' '])           => 0.000000,
    (nf_fp_varrisktype in ['-1'])          => 0.000000,
    (nf_fp_varrisktype in ['1', '2', '3']) => 0.102616,
    (nf_fp_varrisktype in ['4', '5', '6']) => -0.240023,
    (nf_fp_varrisktype in ['7', '8', '9']) => -0.604565,
                                              0.000000);

subscore10 := map(
    NULL < nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 0   => 0.000000,
    0 <= nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 92    => 0.168975,
    92 <= nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 143  => 0.066924,
    143 <= nf_fp_curraddrcartheftindex AND nf_fp_curraddrcartheftindex < 185 => -0.059954,
    185 <= nf_fp_curraddrcartheftindex                                       => -0.439423,
                                                                                0.000000);

subscore11 := map(
    (iv_criminal_x_felony in [' '])                 => -0.000000,
    (iv_criminal_x_felony in ['0-0'])               => 0.107534,
    (iv_criminal_x_felony in ['1-0', '2-0', '3-0']) => -0.093508,
    (iv_criminal_x_felony in ['1-1', '2-1', '3-1']) => -0.515120,
    (iv_criminal_x_felony in ['2-2', '3-2', '3-3']) => -0.657654,
                                                       -0.000000);

subscore12 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '1-0', '1-1', '2-0', '2-1']) => -0.102225,
    (iv_nap_phn_ver_x_inf_phn_ver in ['1-3', '3-1', '3-3'])                      => -0.018792,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                    => 0.051655,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-3', '2-3'])                             => 0.443495,
                                                                                    -0.000000);
subscore13 := map(
		c_unemp = ''																			 		 => 0.000000,
		(real) c_unemp <= 0																		 => 0.100037,
		0    <=  (real) c_unemp AND (real) c_unemp < 3.5  		 => 0.100037,
		3.5  <=  (real) c_unemp AND (real) c_unemp < 6.6 	 		 => 0.094855,
		6.6  <=  (real) c_unemp AND (real) c_unemp < 13.4	 		 => -0.114293,
    13.4 <=  (real) c_unemp                   				 		 => -0.762696,
																															 0.000000);
subscore14 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.060386,
    1 <= iv_eviction_count                             => -0.244793,
                                                          0.000000);

subscore15 := map(
    (nf_fp_divrisktype in [' '])           => 0.000000,
    (nf_fp_divrisktype in ['1'])           => 0.038369,
    (nf_fp_divrisktype in ['2', '3'])      => 0.037300,
    (nf_fp_divrisktype in ['4', '5', '6']) => -0.244525,
    (nf_fp_divrisktype in ['7', '8', '9']) => -0.670651,
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
    subscore12 +
    subscore13 +
    subscore14 +
    subscore15;

lnoddsscore := rawscore + 1.961214;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

base := 700;

pts := 50;

odds := (1 - .1205) / .1205;

fp1310_1_0 := min(if(max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300) = NULL, -NULL, max(round(pts * (ln(probscore / (1 - probscore)) - ln(odds)) / ln(2) + base), 300)), 999);


#if(FP_DEBUG)
		/* Model Input Variables */
	self.clam															:= le;
	 self.sysdate                          := sysdate;
	 self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
	 self._in_dob                          := _in_dob;
	 self.yr_in_dob                        := yr_in_dob;
	 self.yr_in_dob_int                    := yr_in_dob_int;
	 self.age_estimate                     := age_estimate;
	 self.iv_ag001_age                     := iv_ag001_age;
	 self.bureau_addr_tn_count_pos         := bureau_addr_tn_count_pos;
	 self.bureau_addr_count_tn             := bureau_addr_count_tn;
	 self.bureau_addr_ts_count_pos         := bureau_addr_ts_count_pos;
	 self.bureau_addr_count_ts             := bureau_addr_count_ts;
	 self.bureau_addr_tu_count_pos         := bureau_addr_tu_count_pos;
	 self.bureau_addr_count_tu             := bureau_addr_count_tu;
	 self.bureau_addr_en_count_pos         := bureau_addr_en_count_pos;
	 self.bureau_addr_count_en             := bureau_addr_count_en;
	 self.bureau_addr_eq_count_pos         := bureau_addr_eq_count_pos;
	 self.bureau_addr_count_eq             := bureau_addr_count_eq;
	 self._src_bureau_addr_count           := _src_bureau_addr_count;
	 self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
	 self.iv_bst_addr_assessed_total_val   := iv_bst_addr_assessed_total_val;
	 self.iv_inq_highriskcredit_recency    := iv_inq_highriskcredit_recency;
	 self.iv_inq_communications_recency    := iv_inq_communications_recency;
	 self.iv_inq_adls_per_addr             := iv_inq_adls_per_addr;
	 self.ver_phn_inf                      := ver_phn_inf;
	 self.ver_phn_nap                      := ver_phn_nap;
	 self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
	 self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
	 self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
	 self.iv_eviction_count                := iv_eviction_count;
	 self.iv_criminal_x_felony             := iv_criminal_x_felony;
	 self.iv_pb_total_orders               := iv_pb_total_orders;
	 self.nf_fp_varrisktype                := nf_fp_varrisktype;
	 self.nf_fp_assocsuspicousidcount      := nf_fp_assocsuspicousidcount;
	 self.nf_fp_divrisktype                := nf_fp_divrisktype;
	 self.nf_fp_curraddrcartheftindex      := nf_fp_curraddrcartheftindex;
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
	 self.rawscore                         := rawscore;
	 self.lnoddsscore                      := lnoddsscore;
	 self.probscore                        := probscore;
	 self.base                             := base;
	 self.pts                              := pts;
	 self.odds                             := odds;
	 self.fp1310_1_0                       := fp1310_1_0;
#end
	self.seq := le.seq;
	ritmp :=  Models.fraudpoint_reasons(le, blank_ip, num_reasons );
	reasons := Models.Common.checkFraudPointRC34(FP1310_1_0, ritmp, num_reasons);
	self.ri := reasons;
	self.score := (string)fp1310_1_0;
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
