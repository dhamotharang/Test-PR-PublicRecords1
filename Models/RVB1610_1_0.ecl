IMPORT ut, Std, RiskWise, Riskview, RiskWiseFCRA, Risk_Indicators, riskview;

EXPORT RVB1610_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := False;
	
  isPreScreenPurpose := False;

	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	    Integer  seq;
      Integer	 sysdate;
			String	addrinputownershipindex;
      String	lienjudgmentseverityindex;
      String	educationattendance;
			String	inquirynonshortterm12month;
			String	shorttermloanrequest;
			String	addrchangecount24month;
			String	criminalnonfelonycount;
			String	assetpropevercount;
			String	ssnsubjectcount;
			String	addronfilecount;
			String	criminalfelonycount;
			String  inquiryshortterm12month;
      Integer	 rv_s66_adlperssn_count;
      Integer	 rv_l79_adls_per_addr_c6;
      Integer	 addrinputownershipindex_2;
      Real	 u_subscore0;
      Real	 u_subscore1;
      Real	 u_subscore2;
      Real	 u_subscore3;
      Real	 u_subscore4;
      Real	 u_subscore5;
      Real	 u_subscore6;
      Real	 u_subscore7;
      Real	 u_subscore8;
      Real	 u_subscore9;
      Real	 u_subscore10;
      Real	 u_subscore11;
      Real	 u_subscore12;
      Real	 u_subscore13;
      Real	 u_rawscore;
      Real	 u_lnoddsscore;
      Real	 u_probscore;
      String	 u_aacd_0;
      Real	 u_dist_0;
      String	 u_aacd_1;
      Real	 u_dist_1;
      String	 u_aacd_2;
      Real	 u_dist_2;
      String	 u_aacd_3;
      Real	 u_dist_3;
      String	 u_aacd_4;
      Real	 u_dist_4;
      String	 u_aacd_5;
      Real	 u_dist_5;
      String	 u_aacd_6;
      Real	 u_dist_6;
      String	 u_aacd_7;
      Real	 u_dist_7;
      String	 u_aacd_8;
      Real	 u_dist_8;
      String	 u_aacd_9;
      Real	 u_dist_9;
      String	 u_aacd_10;
      Real	 u_dist_10;
      String	 u_aacd_11;
      Real	 u_dist_11;
      String	 u_aacd_12;
      Real	 u_dist_12;
      String	 u_aacd_13;
      Real	 u_dist_13;
      Real	 u_rcvaluel79;
      Real	 u_rcvaluec21;
      Real	 u_rcvalued34;
      Real	 u_rcvalued32;
      Real	 u_rcvalues66;
      Real	 u_rcvaluea45;
      Real	 u_rcvaluei60;
      Real	 u_rcvaluea42;
      Real	 u_rcvaluee55;
      Real	 u_rcvaluec12;
      Real	 u_rcvaluec14;
      Integer	 base;
      Real	 odds;
      Integer	 point;
      Boolean	 iv_rv5_deceased;
      String	 iv_rv5_unscorable;
      Integer	 rvb1610_1_0;
      String	 u_rc1;
      String	 u_rc2;
      String	 u_rc3;
      String	 u_rc4;
      Real	 u_vl1;
      Real	 u_vl2;
      Real	 u_vl3;
      Real	 u_vl4;
      String	 _rc_inq;
      String	 rc1;
      String	 rc2;
      String	 rc3;
      String	 rc4;
      String	 rc5;


     Risk_Indicators.Layout_Boca_Shell clam;
     END;
			
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */

attrtemp := riskview.get_attributes_v5(clam, isPreScreenPurpose);
attr := attrtemp[1];
	 
	addrinputownershipindex          := attr.addrinputownershipindex;
	lienjudgmentseverityindex        := attr.lienjudgmentseverityindex;
	educationattendance              := attr.educationattendance;
	inquirynonshortterm12month       := attr.inquirynonshortterm12month;
	shorttermloanrequest             := attr.shorttermloanrequest;
	addrchangecount24month           := attr.addrchangecount24month;
	criminalnonfelonycount           := attr.criminalnonfelonycount;
	assetpropevercount               := attr.assetpropevercount;
	ssnsubjectcount                  := attr.ssnsubjectcount;
	addronfilecount                  := attr.addronfilecount;
	criminalfelonycount              := attr.criminalfelonycount;
	inquiryshortterm12month          := attr.inquiryshortterm12month;
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_decsflag                      := le.iid.decsflag;
	ver_sources                      := le.header_summary.ver_sources;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	adls_per_ssn                     := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	infutor_nap                      := le.infutor_phone.infutor_nap;


	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */


NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

sysdate := common.sas_date(if(le.historydate=999999, (string8)Std.Date.Today(), (string6)le.historydate+'01'));

rv_s66_adlperssn_count := map(
    not(ssnlength > '0') => NULL,
    adls_per_ssn = 0   => 1,
         min(if(adls_per_ssn = NULL, -NULL, adls_per_ssn), 999));

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

addrinputownershipindex_2 := map(
    addrinputownershipindex = '-1' and add_input_naprop = 3 => 3,
    addrinputownershipindex = '-1' and add_input_naprop = 4 => 4,
          (Integer)addrinputownershipindex);

u_subscore0 := map(
    (lienjudgmentseverityindex in ['-1'])            => 0,
    (lienjudgmentseverityindex in ['0'])             => 0.125834,
    (lienjudgmentseverityindex in ['1', '2', '3', '4', '5']) => -0.413403,
    (lienjudgmentseverityindex in ['6'])             => -0.826976,
                    0);

u_subscore1 := map(
    (educationattendance in ['-1']) => 0,
    (educationattendance in ['0'])  => -0.080407,
    (educationattendance in ['1'])  => 0.908236,
                    0);

u_subscore2 := map(
    (inquirynonshortterm12month in ['-1']) => 0,
    (inquirynonshortterm12month in ['0'])  => 0.076571,
    (inquirynonshortterm12month in ['1'])  => -0.507929,
          0);

u_subscore3 := map(
    (shorttermloanrequest in ['-1']) => 0,
    (shorttermloanrequest in ['0'])  => 0.041551,
    (shorttermloanrequest in ['1'])  => -0.551494,
                     0);
u_subscore4 := map(
    NULL < (Integer)addrchangecount24month AND (Integer)addrchangecount24month < 0 => 0,
    0 <= (Integer)addrchangecount24month AND (Integer)addrchangecount24month < 1   => 0.128423,
    1 <= (Integer)addrchangecount24month                                  => -0.117188,
                                                                    0);

u_subscore5 := map(
    NULL < (Integer)criminalnonfelonycount AND (Integer)criminalnonfelonycount < 0 => 0,
    0 <= (Integer)criminalnonfelonycount AND (Integer)criminalnonfelonycount < 1   => 0.022785,
    1 <= (Integer)criminalnonfelonycount                                  => -0.491478,
                                                                    0);

u_subscore6 := map(
    NULL < (Integer)assetpropevercount AND (Integer)assetpropevercount < 0 => 0,
    0 <= (Integer)assetpropevercount AND (Integer)assetpropevercount < 1   => -0.035847,
    1 <= (Integer)assetpropevercount AND (Integer)assetpropevercount < 3   => 0.192057,
    3 <= (Integer)assetpropevercount                              => 0.581805,
                                                            0);

u_subscore7 := map(
    NULL < (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 0 => 0,
    0 <= (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 1   => -0.43295,
    1 <= (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 2   => 0.024255,
    2 <= (Integer)ssnsubjectcount                           => -0.078443,
                                                      0);

u_subscore8 := map(
    (addrinputownershipindex_2 in [-1])   => 0,
    (addrinputownershipindex_2 in [0])    => -0.078838,
    (addrinputownershipindex_2 in [1])    => -0.039277,
    (addrinputownershipindex_2 in [2])    => 0.005234,
    (addrinputownershipindex_2 in [3, 4]) => 0.179544,
                                             0);

u_subscore9 := map(
    NULL < (Integer)addronfilecount AND (Integer)addronfilecount < 0 => 0,
    0 <= (Integer)addronfilecount AND (Integer)addronfilecount < 1   => 0,
    1 <= (Integer)addronfilecount AND (Integer)addronfilecount < 2   => 0.134255,
    2 <= (Integer)addronfilecount AND (Integer)addronfilecount < 3   => -0.039644,
    3 <= (Integer)addronfilecount                           => -0.069054,
                                                      0);

u_subscore10 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.06102,
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => -0.094295,
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => -0.127053,
    4 <= rv_l79_adls_per_addr_c6                                   => -0.185437,
                                                                      0);

u_subscore11 := map(
    NULL < (Integer)criminalfelonycount AND (Integer)criminalfelonycount < 0 => 0,
    0 <= (Integer)criminalfelonycount AND (Integer)criminalfelonycount < 1   => 0.00958,
    1 <= (Integer)criminalfelonycount                               => -0.699013,
                                                              0);

u_subscore12 := map(
    (inquiryshortterm12month in ['-1']) => 0,
    (inquiryshortterm12month in ['0'])  => 0.006888,
    (inquiryshortterm12month in ['1'])  => -0.396479,
                                         0);

u_subscore13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 0.026004,
    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => -0.036935,
    3 <= rv_s66_adlperssn_count                                  => -0.082785,
                                                                    0);


u_rawscore := u_subscore0 +
    u_subscore1 +
    u_subscore2 +
    u_subscore3 +
    u_subscore4 +
    u_subscore5 +
    u_subscore6 +
    u_subscore7 +
    u_subscore8 +
    u_subscore9 +
    u_subscore10 +
    u_subscore11 +
    u_subscore12 +
    u_subscore13;

u_lnoddsscore := u_rawscore + 1.986810;

u_probscore := exp(u_lnoddsscore) / (1 + exp(u_lnoddsscore));

u_aacd_0 := map(
    (lienjudgmentseverityindex in ['-1'])            => '',
    (lienjudgmentseverityindex in ['0'])             => 'D34',
    (lienjudgmentseverityindex in ['1', '2', '3', '4', '5']) => 'D34',
    (lienjudgmentseverityindex in ['6'])             => 'D34',
                    '');

u_dist_0 := u_subscore0 - 0.125834;

u_aacd_1 := map(
    (educationattendance in ['-1']) => 'C12',
    (educationattendance in ['0'])  => 'E55',
    (educationattendance in ['1'])  => 'E55',
                    '');

u_dist_1 := u_subscore1 - 0.908236;

u_aacd_2 := map(
    (inquirynonshortterm12month in ['-1']) => '',
    (inquirynonshortterm12month in ['0'])  => 'I60',
    (inquirynonshortterm12month in ['1'])  => 'I60',
          '');

u_dist_2 := u_subscore2 - 0.076571;

u_aacd_3 := map(
    (shorttermloanrequest in ['-1']) => '',
    (shorttermloanrequest in ['0'])  => 'C21',
    (shorttermloanrequest in ['1'])  => 'C21',
                     '');

u_dist_3 := u_subscore3 - 0.041551;

u_aacd_4 := map(
    NULL < (Integer)addrchangecount24month AND (Integer)addrchangecount24month < 0 => '',
    0 <= (Integer)addrchangecount24month AND (Integer)addrchangecount24month < 1   => 'C14',
    1 <= (Integer)addrchangecount24month                 => 'C14',
                 '');

u_dist_4 := u_subscore4 - 0.128423;

u_aacd_5 := map(
    NULL < (Integer)criminalnonfelonycount AND (Integer)criminalnonfelonycount < 0 => '',
    0 <= (Integer)criminalnonfelonycount AND (Integer)criminalnonfelonycount < 1   => 'D32',
    1 <= (Integer)criminalnonfelonycount                 => 'D32',
                 '');

u_dist_5 := u_subscore5 - 0.022785;

u_aacd_6 := map(
    NULL < (Integer)assetpropevercount AND (Integer)assetpropevercount < 0 => '',
    0 <= (Integer)assetpropevercount AND (Integer)assetpropevercount < 1   => 'A45',
    1 <= (Integer)assetpropevercount AND (Integer)assetpropevercount < 3   => 'A45',
    3 <= (Integer)assetpropevercount             => 'A45',
         '');

u_dist_6 := u_subscore6 - 0.581805;

u_aacd_7 := map(
    NULL < (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 0 => '',
    0 <= (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 1   => 'S66',
    1 <= (Integer)ssnsubjectcount AND (Integer)ssnsubjectcount < 2   => 'S66',
    2 <= (Integer)ssnsubjectcount          => 'S66',
                    '');

u_dist_7 := u_subscore7 - 0.024255;

u_aacd_8 := map(
    (addrinputownershipindex_2 in [-1])   => '',
    (addrinputownershipindex_2 in [0])    => 'A42',
    (addrinputownershipindex_2 in [1])    => 'A42',
    (addrinputownershipindex_2 in [2])    => 'A42',
    (addrinputownershipindex_2 in [3, 4]) => 'A42',
           '');

u_dist_8 := u_subscore8 - 0.179544;

u_aacd_9 := map(
    NULL < (Integer)addronfilecount AND (Integer)addronfilecount < 0 => '',
    0 <= (Integer)addronfilecount AND (Integer)addronfilecount < 1   => 'C14',
    1 <= (Integer)addronfilecount AND (Integer)addronfilecount < 2   => 'C14',
    2 <= (Integer)addronfilecount AND (Integer)addronfilecount < 3   => 'C14',
    3 <= (Integer)addronfilecount          => 'C14',
                    '');

u_dist_9 := u_subscore9 - 0.134255;

u_aacd_10 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => 'L79',
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => 'L79',
    4 <= rv_l79_adls_per_addr_c6                  => 'L79',
                   '');

u_dist_10 := u_subscore10 - 0.06102;

u_aacd_11 := map(
    NULL < (Integer)criminalfelonycount AND (Integer)criminalfelonycount < 0 => '',
    0 <= (Integer)criminalfelonycount AND (Integer)criminalfelonycount < 1   => 'D32',
    1 <= (Integer)criminalfelonycount              => 'D32',
           '');

u_dist_11 := u_subscore11 - 0.00958;

u_aacd_12 := map(
    (inquiryshortterm12month in ['-1']) => '',
    (inquiryshortterm12month in ['0'])  => 'I60',
    (inquiryshortterm12month in ['1'])  => 'I60',
       '');

u_dist_12 := u_subscore12 - 0.006888;

u_aacd_13 := map(
    NULL < rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 2 => 'S66',
    2 <= rv_s66_adlperssn_count AND rv_s66_adlperssn_count < 3   => 'S66',
    3 <= rv_s66_adlperssn_count                 => 'S66',
                 '');

u_dist_13 := u_subscore13 - 0.026004;

u_rcvaluel79 := (integer)(u_aacd_0 = 'L79') * u_dist_0 +
    (integer)(u_aacd_1 = 'L79') * u_dist_1 +
    (integer)(u_aacd_2 = 'L79') * u_dist_2 +
    (integer)(u_aacd_3 = 'L79') * u_dist_3 +
    (integer)(u_aacd_4 = 'L79') * u_dist_4 +
    (integer)(u_aacd_5 = 'L79') * u_dist_5 +
    (integer)(u_aacd_6 = 'L79') * u_dist_6 +
    (integer)(u_aacd_7 = 'L79') * u_dist_7 +
    (integer)(u_aacd_8 = 'L79') * u_dist_8 +
    (integer)(u_aacd_9 = 'L79') * u_dist_9 +
    (integer)(u_aacd_10 = 'L79') * u_dist_10 +
    (integer)(u_aacd_11 = 'L79') * u_dist_11 +
    (integer)(u_aacd_12 = 'L79') * u_dist_12 +
    (integer)(u_aacd_13 = 'L79') * u_dist_13;

u_rcvaluec21 := (integer)(u_aacd_0 = 'C21') * u_dist_0 +
    (integer)(u_aacd_1 = 'C21') * u_dist_1 +
    (integer)(u_aacd_2 = 'C21') * u_dist_2 +
    (integer)(u_aacd_3 = 'C21') * u_dist_3 +
    (integer)(u_aacd_4 = 'C21') * u_dist_4 +
    (integer)(u_aacd_5 = 'C21') * u_dist_5 +
    (integer)(u_aacd_6 = 'C21') * u_dist_6 +
    (integer)(u_aacd_7 = 'C21') * u_dist_7 +
    (integer)(u_aacd_8 = 'C21') * u_dist_8 +
    (integer)(u_aacd_9 = 'C21') * u_dist_9 +
    (integer)(u_aacd_10 = 'C21') * u_dist_10 +
    (integer)(u_aacd_11 = 'C21') * u_dist_11 +
    (integer)(u_aacd_12 = 'C21') * u_dist_12 +
    (integer)(u_aacd_13 = 'C21') * u_dist_13;

u_rcvalued34 := (integer)(u_aacd_0 = 'D34') * u_dist_0 +
    (integer)(u_aacd_1 = 'D34') * u_dist_1 +
    (integer)(u_aacd_2 = 'D34') * u_dist_2 +
    (integer)(u_aacd_3 = 'D34') * u_dist_3 +
    (integer)(u_aacd_4 = 'D34') * u_dist_4 +
    (integer)(u_aacd_5 = 'D34') * u_dist_5 +
    (integer)(u_aacd_6 = 'D34') * u_dist_6 +
    (integer)(u_aacd_7 = 'D34') * u_dist_7 +
    (integer)(u_aacd_8 = 'D34') * u_dist_8 +
    (integer)(u_aacd_9 = 'D34') * u_dist_9 +
    (integer)(u_aacd_10 = 'D34') * u_dist_10 +
    (integer)(u_aacd_11 = 'D34') * u_dist_11 +
    (integer)(u_aacd_12 = 'D34') * u_dist_12 +
    (integer)(u_aacd_13 = 'D34') * u_dist_13;

u_rcvalued32 := (integer)(u_aacd_0 = 'D32') * u_dist_0 +
    (integer)(u_aacd_1 = 'D32') * u_dist_1 +
    (integer)(u_aacd_2 = 'D32') * u_dist_2 +
    (integer)(u_aacd_3 = 'D32') * u_dist_3 +
    (integer)(u_aacd_4 = 'D32') * u_dist_4 +
    (integer)(u_aacd_5 = 'D32') * u_dist_5 +
    (integer)(u_aacd_6 = 'D32') * u_dist_6 +
    (integer)(u_aacd_7 = 'D32') * u_dist_7 +
    (integer)(u_aacd_8 = 'D32') * u_dist_8 +
    (integer)(u_aacd_9 = 'D32') * u_dist_9 +
    (integer)(u_aacd_10 = 'D32') * u_dist_10 +
    (integer)(u_aacd_11 = 'D32') * u_dist_11 +
    (integer)(u_aacd_12 = 'D32') * u_dist_12 +
    (integer)(u_aacd_13 = 'D32') * u_dist_13;

u_rcvalues66 := (integer)(u_aacd_0 = 'S66') * u_dist_0 +
    (integer)(u_aacd_1 = 'S66') * u_dist_1 +
    (integer)(u_aacd_2 = 'S66') * u_dist_2 +
    (integer)(u_aacd_3 = 'S66') * u_dist_3 +
    (integer)(u_aacd_4 = 'S66') * u_dist_4 +
    (integer)(u_aacd_5 = 'S66') * u_dist_5 +
    (integer)(u_aacd_6 = 'S66') * u_dist_6 +
    (integer)(u_aacd_7 = 'S66') * u_dist_7 +
    (integer)(u_aacd_8 = 'S66') * u_dist_8 +
    (integer)(u_aacd_9 = 'S66') * u_dist_9 +
    (integer)(u_aacd_10 = 'S66') * u_dist_10 +
    (integer)(u_aacd_11 = 'S66') * u_dist_11 +
    (integer)(u_aacd_12 = 'S66') * u_dist_12 +
    (integer)(u_aacd_13 = 'S66') * u_dist_13;

u_rcvaluea45 := (integer)(u_aacd_0 = 'A45') * u_dist_0 +
    (integer)(u_aacd_1 = 'A45') * u_dist_1 +
    (integer)(u_aacd_2 = 'A45') * u_dist_2 +
    (integer)(u_aacd_3 = 'A45') * u_dist_3 +
    (integer)(u_aacd_4 = 'A45') * u_dist_4 +
    (integer)(u_aacd_5 = 'A45') * u_dist_5 +
    (integer)(u_aacd_6 = 'A45') * u_dist_6 +
    (integer)(u_aacd_7 = 'A45') * u_dist_7 +
    (integer)(u_aacd_8 = 'A45') * u_dist_8 +
    (integer)(u_aacd_9 = 'A45') * u_dist_9 +
    (integer)(u_aacd_10 = 'A45') * u_dist_10 +
    (integer)(u_aacd_11 = 'A45') * u_dist_11 +
    (integer)(u_aacd_12 = 'A45') * u_dist_12 +
    (integer)(u_aacd_13 = 'A45') * u_dist_13;

u_rcvaluei60 := (integer)(u_aacd_0 = 'I60') * u_dist_0 +
    (integer)(u_aacd_1 = 'I60') * u_dist_1 +
    (integer)(u_aacd_2 = 'I60') * u_dist_2 +
    (integer)(u_aacd_3 = 'I60') * u_dist_3 +
    (integer)(u_aacd_4 = 'I60') * u_dist_4 +
    (integer)(u_aacd_5 = 'I60') * u_dist_5 +
    (integer)(u_aacd_6 = 'I60') * u_dist_6 +
    (integer)(u_aacd_7 = 'I60') * u_dist_7 +
    (integer)(u_aacd_8 = 'I60') * u_dist_8 +
    (integer)(u_aacd_9 = 'I60') * u_dist_9 +
    (integer)(u_aacd_10 = 'I60') * u_dist_10 +
    (integer)(u_aacd_11 = 'I60') * u_dist_11 +
    (integer)(u_aacd_12 = 'I60') * u_dist_12 +
    (integer)(u_aacd_13 = 'I60') * u_dist_13;

u_rcvaluea42 := (integer)(u_aacd_0 = 'A42') * u_dist_0 +
    (integer)(u_aacd_1 = 'A42') * u_dist_1 +
    (integer)(u_aacd_2 = 'A42') * u_dist_2 +
    (integer)(u_aacd_3 = 'A42') * u_dist_3 +
    (integer)(u_aacd_4 = 'A42') * u_dist_4 +
    (integer)(u_aacd_5 = 'A42') * u_dist_5 +
    (integer)(u_aacd_6 = 'A42') * u_dist_6 +
    (integer)(u_aacd_7 = 'A42') * u_dist_7 +
    (integer)(u_aacd_8 = 'A42') * u_dist_8 +
    (integer)(u_aacd_9 = 'A42') * u_dist_9 +
    (integer)(u_aacd_10 = 'A42') * u_dist_10 +
    (integer)(u_aacd_11 = 'A42') * u_dist_11 +
    (integer)(u_aacd_12 = 'A42') * u_dist_12 +
    (integer)(u_aacd_13 = 'A42') * u_dist_13;

u_rcvaluee55 := (integer)(u_aacd_0 = 'E55') * u_dist_0 +
    (integer)(u_aacd_1 = 'E55') * u_dist_1 +
    (integer)(u_aacd_2 = 'E55') * u_dist_2 +
    (integer)(u_aacd_3 = 'E55') * u_dist_3 +
    (integer)(u_aacd_4 = 'E55') * u_dist_4 +
    (integer)(u_aacd_5 = 'E55') * u_dist_5 +
    (integer)(u_aacd_6 = 'E55') * u_dist_6 +
    (integer)(u_aacd_7 = 'E55') * u_dist_7 +
    (integer)(u_aacd_8 = 'E55') * u_dist_8 +
    (integer)(u_aacd_9 = 'E55') * u_dist_9 +
    (integer)(u_aacd_10 = 'E55') * u_dist_10 +
    (integer)(u_aacd_11 = 'E55') * u_dist_11 +
    (integer)(u_aacd_12 = 'E55') * u_dist_12 +
    (integer)(u_aacd_13 = 'E55') * u_dist_13;

u_rcvaluec12 := (integer)(u_aacd_0 = 'C12') * u_dist_0 +
    (integer)(u_aacd_1 = 'C12') * u_dist_1 +
    (integer)(u_aacd_2 = 'C12') * u_dist_2 +
    (integer)(u_aacd_3 = 'C12') * u_dist_3 +
    (integer)(u_aacd_4 = 'C12') * u_dist_4 +
    (integer)(u_aacd_5 = 'C12') * u_dist_5 +
    (integer)(u_aacd_6 = 'C12') * u_dist_6 +
    (integer)(u_aacd_7 = 'C12') * u_dist_7 +
    (integer)(u_aacd_8 = 'C12') * u_dist_8 +
    (integer)(u_aacd_9 = 'C12') * u_dist_9 +
    (integer)(u_aacd_10 = 'C12') * u_dist_10 +
    (integer)(u_aacd_11 = 'C12') * u_dist_11 +
    (integer)(u_aacd_12 = 'C12') * u_dist_12 +
    (integer)(u_aacd_13 = 'C12') * u_dist_13;

u_rcvaluec14 := (integer)(u_aacd_0 = 'C14') * u_dist_0 +
    (integer)(u_aacd_1 = 'C14') * u_dist_1 +
    (integer)(u_aacd_2 = 'C14') * u_dist_2 +
    (integer)(u_aacd_3 = 'C14') * u_dist_3 +
    (integer)(u_aacd_4 = 'C14') * u_dist_4 +
    (integer)(u_aacd_5 = 'C14') * u_dist_5 +
    (integer)(u_aacd_6 = 'C14') * u_dist_6 +
    (integer)(u_aacd_7 = 'C14') * u_dist_7 +
    (integer)(u_aacd_8 = 'C14') * u_dist_8 +
    (integer)(u_aacd_9 = 'C14') * u_dist_9 +
    (integer)(u_aacd_10 = 'C14') * u_dist_10 +
    (integer)(u_aacd_11 = 'C14') * u_dist_11 +
    (integer)(u_aacd_12 = 'C14') * u_dist_12 +
    (integer)(u_aacd_13 = 'C14') * u_dist_13;

base := 735;

odds := (1 - 0.0968) / 0.0968;

point := 57;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',') > 0 or (Integer)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',') > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

rvb1610_1_0 := map(
    (Integer)iv_rv5_deceased > 0     => 200,
    iv_rv5_unscorable = '1' => 222,
              min(if(max(round(point * (u_lnoddsscore - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(point * (u_lnoddsscore - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_u := DATASET([
    {'L79', u_rcvalueL79},
    {'C21', u_rcvalueC21},
    {'D34', u_rcvalueD34},
    {'D32', u_rcvalueD32},
    {'S66', u_rcvalueS66},
    {'A45', u_rcvalueA45},
    {'I60', u_rcvalueI60},
    {'A42', u_rcvalueA42},
    {'E55', u_rcvalueE55},
    {'C12', u_rcvalueC12},
    {'C14', u_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_u_sorted := sort(rc_dataset_u, rc_dataset_u.value);

u_rc1 := rc_dataset_u_sorted[1].rc;
u_rc2 := rc_dataset_u_sorted[2].rc;
u_rc3 := rc_dataset_u_sorted[3].rc;
u_rc4 := rc_dataset_u_sorted[4].rc;

u_vl1 := rc_dataset_u_sorted[1].value;
u_vl2 := rc_dataset_u_sorted[2].value;
u_vl3 := rc_dataset_u_sorted[3].value;
u_vl4 := rc_dataset_u_sorted[4].value;
//*************************************************************************************//

rc1_2 := u_rc1;

rc2_2 := u_rc2;

rc3_2 := u_rc3;

rc4_2 := u_rc4;

_rc_inq := map(
    (Integer)inquirynonshortterm12month > 0 => 'I60',
    (Integer)inquiryshortterm12month > 0    => 'I60',
                     '');

rc5_c36 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           _rc_inq);

// rc3_c36 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc2_c36 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc1_c36 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc4_c36 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
           // '');

// rc2_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c36, rc2_2);

rc5_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c36, '');

// rc3_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c36, rc3_2);

// rc1_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c36, rc1_2);

// rc4_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c36, rc4_2);

rc2 := if((rvb1610_1_0 in [200, 222]), '', rc2_2);

rc5 := if((rvb1610_1_0 in [200, 222]), '', rc5_1);

rc3 := if((rvb1610_1_0 in [200, 222]), '', rc3_2);

rc1 := if((rvb1610_1_0 in [200, 222]), '', rc1_2);

rc4 := if((rvb1610_1_0 in [200, 222]), '', rc4_2);


//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVB1610_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVB1610_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVB1610_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
   self.seq             := le.seq;
	 self.sysdate         := sysdate;
	 self.addrinputownershipindex := addrinputownershipindex;
   self.lienjudgmentseverityindex  := lienjudgmentseverityindex;
   self.educationattendance := educationattendance;
   self.inquirynonshortterm12month := inquirynonshortterm12month;
   self.shorttermloanrequest := shorttermloanrequest;
   self.addrchangecount24month := addrchangecount24month;
   self.criminalnonfelonycount := criminalnonfelonycount;
   self.assetpropevercount := assetpropevercount;
   self.ssnsubjectcount := ssnsubjectcount;
   self.addronfilecount := addronfilecount;
   self.criminalfelonycount := criminalfelonycount;
	 self.inquiryshortterm12month := inquiryshortterm12month;
   self.rv_s66_adlperssn_count           := rv_s66_adlperssn_count;
   self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
   self.addrinputownershipindex_2        := addrinputownershipindex_2;
   self.u_subscore0     := u_subscore0;
   self.u_subscore1     := u_subscore1;
   self.u_subscore2     := u_subscore2;
   self.u_subscore3     := u_subscore3;
   self.u_subscore4     := u_subscore4;
   self.u_subscore5     := u_subscore5;
   self.u_subscore6     := u_subscore6;
   self.u_subscore7     := u_subscore7;
   self.u_subscore8     := u_subscore8;
   self.u_subscore9     := u_subscore9;
   self.u_subscore10    := u_subscore10;
   self.u_subscore11    := u_subscore11;
   self.u_subscore12    := u_subscore12;
   self.u_subscore13    := u_subscore13;
   self.u_rawscore      := u_rawscore;
   self.u_lnoddsscore   := u_lnoddsscore;
   self.u_probscore     := u_probscore;
   self.u_aacd_0        := u_aacd_0;
   self.u_dist_0        := u_dist_0;
   self.u_aacd_1        := u_aacd_1;
   self.u_dist_1        := u_dist_1;
   self.u_aacd_2        := u_aacd_2;
   self.u_dist_2        := u_dist_2;
   self.u_aacd_3        := u_aacd_3;
   self.u_dist_3        := u_dist_3;
   self.u_aacd_4        := u_aacd_4;
   self.u_dist_4        := u_dist_4;
   self.u_aacd_5        := u_aacd_5;
   self.u_dist_5        := u_dist_5;
   self.u_aacd_6        := u_aacd_6;
   self.u_dist_6        := u_dist_6;
   self.u_aacd_7        := u_aacd_7;
   self.u_dist_7        := u_dist_7;
   self.u_aacd_8        := u_aacd_8;
   self.u_dist_8        := u_dist_8;
   self.u_aacd_9        := u_aacd_9;
   self.u_dist_9        := u_dist_9;
   self.u_aacd_10       := u_aacd_10;
   self.u_dist_10       := u_dist_10;
   self.u_aacd_11       := u_aacd_11;
   self.u_dist_11       := u_dist_11;
   self.u_aacd_12       := u_aacd_12;
   self.u_dist_12       := u_dist_12;
   self.u_aacd_13       := u_aacd_13;
   self.u_dist_13       := u_dist_13;
   self.u_rcvaluel79    := u_rcvaluel79;
   self.u_rcvaluec21    := u_rcvaluec21;
   self.u_rcvalued34    := u_rcvalued34;
   self.u_rcvalued32    := u_rcvalued32;
   self.u_rcvalues66    := u_rcvalues66;
   self.u_rcvaluea45    := u_rcvaluea45;
   self.u_rcvaluei60    := u_rcvaluei60;
   self.u_rcvaluea42    := u_rcvaluea42;
   self.u_rcvaluee55    := u_rcvaluee55;
   self.u_rcvaluec12    := u_rcvaluec12;
   self.u_rcvaluec14    := u_rcvaluec14;
   self.base            := base;
   self.odds            := odds;
   self.point           := point;
   self.iv_rv5_deceased                  := iv_rv5_deceased;
   self.iv_rv5_unscorable                := iv_rv5_unscorable;
   self.rvb1610_1_0     := rvb1610_1_0;
   self.u_rc1           := u_rc1;
   self.u_rc2           := u_rc2;
   self.u_rc3           := u_rc3;
   self.u_rc4           := u_rc4;
   self.u_vl1           := u_vl1;
   self.u_vl2           := u_vl2;
   self.u_vl3           := u_vl3;
   self.u_vl4           := u_vl4;
   self._rc_inq         := _rc_inq;
   self.rc1             := rc1;
   self.rc2             := rc2;
   self.rc3             := rc3;
   self.rc4             := rc4;
   self.rc5             := rc5;


		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)RVB1610_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
