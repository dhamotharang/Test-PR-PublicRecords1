IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVG1808_2_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION


	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	MODEL_DEBUG        := FALSE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
                    unsigned4 seq;            
                    integer sysdate                         ;// := sysdate;
                    string willingnessreason                ;
                    real criminalnonfelonycount;
                    real evictioncount;                  
                    real subjectwillingnessindex   ;//:= le.subjectwillingnessindex ;
                    string SubjectWillingnessPrimaryFactor  ;// :=  le.SubjectWillingnessPrimaryFactor;
                    real addrcurrentavmratio60monthprior;
                    real subjectrecordtimeoldest    ;
                    real sourcenonderogcount ;
                    real inquirybanking12month ;
                    real addrinputsubjectowned ;
                    real criminalfelonycount ;
                    real addrcurrenttimeoldest ;
                    real SSNDeceased      ;// :=  le.SSNDeceased;
                    real SubjectDeceased  ;// :=  le.SubjectDeceased;
                    real confirmationsubjectfound  ;// := le.confirmationsubjectfound ; 
                    Real    onyx_rv5attr_og_v01_w           ;   // := onyx_rv5attr_og_v01_w;
                    Real    onyx_rv5attr_og_aa_dist_01       ;   //:= onyx_rv5attr_og_aa_dist_01;
                    string    onyx_rv5attr_og_aa_code_01      ;   // := onyx_rv5attr_og_aa_code_01;
                    Real    onyx_rv5attr_og_v02_w           ;   // := onyx_rv5attr_og_v02_w;
                    Real    onyx_rv5attr_og_aa_dist_02      ;   // := onyx_rv5attr_og_aa_dist_02;
                    string    onyx_rv5attr_og_aa_code_02      ;   // := onyx_rv5attr_og_aa_code_02;
                    Real    onyx_rv5attr_og_v03_w           ;   // := onyx_rv5attr_og_v03_w;
                    Real    onyx_rv5attr_og_aa_dist_03      ;   // := onyx_rv5attr_og_aa_dist_03;
                    string    onyx_rv5attr_og_aa_code_03      ;   // := onyx_rv5attr_og_aa_code_03;
                    Real    onyx_rv5attr_og_v04_w           ;   // := onyx_rv5attr_og_v04_w;
                    Real    onyx_rv5attr_og_aa_dist_04       ;   //:= onyx_rv5attr_og_aa_dist_04;
                    string    onyx_rv5attr_og_aa_code_04       ;   //:= onyx_rv5attr_og_aa_code_04;
                    Real    onyx_rv5attr_og_v05_w           ;   // := onyx_rv5attr_og_v05_w;
                    Real    onyx_rv5attr_og_aa_dist_05       ;   //:= onyx_rv5attr_og_aa_dist_05;
                    string    onyx_rv5attr_og_aa_code_05       ;   //:= onyx_rv5attr_og_aa_code_05;
                    Real    onyx_rv5attr_og_v06_w            ;   //:= onyx_rv5attr_og_v06_w;
                    Real    onyx_rv5attr_og_aa_dist_06       ;   //:= onyx_rv5attr_og_aa_dist_06;
                    string    onyx_rv5attr_og_aa_code_06      ;   // := onyx_rv5attr_og_aa_code_06;
                    Real    onyx_rv5attr_og_v07_w           ;   // := onyx_rv5attr_og_v07_w;
                    Real    onyx_rv5attr_og_aa_dist_07       ;   //:= onyx_rv5attr_og_aa_dist_07;
                    string    onyx_rv5attr_og_aa_code_07      ;   // := onyx_rv5attr_og_aa_code_07;
                    Real    onyx_rv5attr_og_v08_w           ;   // := onyx_rv5attr_og_v08_w;
                    Real    onyx_rv5attr_og_aa_dist_08      ;   // := onyx_rv5attr_og_aa_dist_08;
                    string    onyx_rv5attr_og_aa_code_08      ;   // := onyx_rv5attr_og_aa_code_08;
                    Real    onyx_rv5attr_og_v09_w           ;   // := onyx_rv5attr_og_v09_w;
                    Real    onyx_rv5attr_og_aa_dist_09      ;   // := onyx_rv5attr_og_aa_dist_09;
                    string    onyx_rv5attr_og_aa_code_09     ;   //  := onyx_rv5attr_og_aa_code_09;
                    Real    onyx_rv5attr_og_v10_w          ;   //  := onyx_rv5attr_og_v10_w;
                    Real    onyx_rv5attr_og_aa_dist_10     ;   //  := onyx_rv5attr_og_aa_dist_10;
                    string    onyx_rv5attr_og_aa_code_10      ;   // := onyx_rv5attr_og_aa_code_10;
                    Real    onyx_rv5attr_og_rcvalued32     ;   //  := onyx_rv5attr_og_rcvalued32;
                    Real    onyx_rv5attr_og_rcvaluec10     ;   //  := onyx_rv5attr_og_rcvaluec10;
                    Real    onyx_rv5attr_og_rcvalued33     ;   //  := onyx_rv5attr_og_rcvalued33;
                    Real    onyx_rv5attr_og_rcvaluea47     ;   //  := onyx_rv5attr_og_rcvaluea47;
                    Real    onyx_rv5attr_og_rcvaluec13     ;   //  := onyx_rv5attr_og_rcvaluec13;
                    Real    onyx_rv5attr_og_rcvaluei60     ;   //  := onyx_rv5attr_og_rcvaluei60;
                    Real    onyx_rv5attr_og_rcvaluea44     ;   //  := onyx_rv5attr_og_rcvaluea44;
                    Real    onyx_rv5attr_og_rcvaluec12        ;   //  onyx_rv5attr_og_rcvaluec12;
                    Real    onyx_rv5attr_og_lgt               ;   //  onyx_rv5attr_og_lgt;
                    string  r_rc1                             ;   //  r_rc1;
                    string  r_rc2                             ;   //  r_rc2;
                    string  r_rc3                             ;   //  r_rc3;
                    string  r_rc4                             ;   //  r_rc4;
                    string  r_rc5                             ;   //  r_rc5;
                    string  r_rc6                             ;   //  r_rc6;
                    string  r_rc7                             ;   //  r_rc7;
                    string  r_rc8                             ;   //  r_rc8;
                    string  r_rc9                             ;   //  r_rc9;
                    string  r_rc10                            ;   //  r_rc10;
                    real  r_vl1                             ;   //  r_vl1;
                    real   r_vl2                             ;   //  r_vl2;
                    real   r_vl3                             ;   //  r_vl3;
                    real  r_vl4                             ;   //  r_vl4;
                    real  r_vl5                             ;   //  r_vl5;
                    real  r_vl6                             ;   //  r_vl6;
                    real  r_vl7                             ;   //  r_vl7;
                    real  r_vl8                             ;   //  r_vl8;
                    real  r_vl9                             ;   //  r_vl9;
                    real  r_vl10                            ;   //  r_vl10;
                    string _rc_inq                           ;   //  _rc_inq;
                    integer base                              ;   //  base;
                    Integer pts                               ;   //  pts;
                    real odds                              ;   //  odds;
                    integer  rvg1808_2_0                       ;   //  rvg1808_2_0;
                    string  rc3                               ;   //  rc3;
                    string  rc4                               ;   //  rc4;
                    string  rc2                               ;   //  rc2;
                    string  rc5                               ;   //  rc5;
                    string  rc1                               ;   //  rc1;

			Risk_Indicators.Layout_Boca_Shell clam;
			
		END;
		

		Layout_Debug doModel(attributes le, clam rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(attributes le, clam rt) := TRANSFORM
	#end


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */

	
                  // SELF.seq     := le.seq;
	
		              // self.sysdate                          := sysdate;

                   
                    criminalnonfelonycount               :=  (real)le.criminalnonfelonycount ;
                    evictioncount                        :=  (real)le.evictioncount  ;                  
                    subjectwillingnessindex              :=  (real)le.subjectwillingnessindex;//:= le.subjectwillingnessindex ;
                    SubjectWillingnessPrimaryFactor      :=  le.SubjectWillingnessPrimaryFactor ;// :=  le.SubjectWillingnessPrimaryFactor;
                    addrcurrentavmratio60monthprior      :=  (real)le.addrcurrentavmratio60monthprior;
                    subjectrecordtimeoldest              :=  (real)le.subjectrecordtimeoldest;
                    sourcenonderogcount                  :=  (real)le.sourcenonderogcount;
                    inquirybanking12month                :=  (real)le.inquirybanking12month ;
                    addrinputsubjectowned                :=  (real)le.addrinputsubjectowned ;
                    criminalfelonycount                  :=  (real)le.criminalfelonycount ;
                    addrcurrenttimeoldest                :=  (real)le.addrcurrenttimeoldest ;      
                    SSNDeceased                          :=  (real)le.SSNDeceased;// :=  le.SSNDeceased;
                    SubjectDeceased                      :=  (real)le.SubjectDeceased ;// :=  le.SubjectDeceased;
                    confirmationsubjectfound             :=  (real)le.confirmationsubjectfound  ;// := le.confirmationsubjectfound ; 
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;


willingnessreason := if(not((SubjectWillingnessPrimaryFactor in ['-1', '0'])) and not(SubjectWillingnessPrimaryFactor = ''), SubjectWillingnessPrimaryFactor, '');



onyx_rv5attr_og_v01_w := map(
    criminalnonfelonycount = NULL => 0,
    criminalnonfelonycount = -1   => 0,
    criminalnonfelonycount <= 0.5 => -0.405539982583864,
    criminalnonfelonycount <= 1.5 => -0.0726625424220895,
                                     0.951533191181465);

onyx_rv5attr_og_aa_code_01_1 := map(
    criminalnonfelonycount = NULL => '',
    criminalnonfelonycount = -1   => '',
    criminalnonfelonycount <= 0.5 => '',
    criminalnonfelonycount <= 1.5 => 'D32',
                                     'D32');

onyx_rv5attr_og_aa_dist_01 := -0.405539982583864 - onyx_rv5attr_og_v01_w;

onyx_rv5attr_og_aa_code_01 := if(onyx_rv5attr_og_aa_dist_01 = 0, '', onyx_rv5attr_og_aa_code_01_1);

onyx_rv5attr_og_v02_w := map(
    evictioncount = NULL => 0,
    evictioncount = -1   => 0,
    evictioncount <= 0.5 => -0.32742783972825,
    evictioncount <= 1.5 => 0.315279510630752,
                            0.760445793259312);

onyx_rv5attr_og_aa_code_02_1 := map(
    evictioncount = NULL => '',
    evictioncount = -1   => '',
    evictioncount <= 0.5 => '',
    evictioncount <= 1.5 => 'D33',
                            'D33');

onyx_rv5attr_og_aa_dist_02 := -0.32742783972825 - onyx_rv5attr_og_v02_w;

//onyx_rv5attr_og_aa_code_02 := if(onyx_rv5attr_og_aa_dist_02 = 0, '', onyx_rv5attr_og_aa_code_02_1);
onyx_rv5attr_og_aa_code_02 := if(onyx_rv5attr_og_aa_dist_02 = 0, '', onyx_rv5attr_og_aa_code_02_1);

onyx_rv5attr_og_v03_w := map(
    subjectwillingnessindex = NULL => 0,
    subjectwillingnessindex = -1   => 0.341349287671251,
    subjectwillingnessindex <= 1.5 => 0.247235972038594,
    subjectwillingnessindex <= 3.5 => 0.041601596079895,
    subjectwillingnessindex <= 6.5 => -0.0374946379485475,
    subjectwillingnessindex <= 7.5 => -0.232525983181255,
                                      -0.44157510524279);

onyx_rv5attr_og_aa_code_03_1 := map(
    subjectwillingnessindex = NULL => '',
    subjectwillingnessindex = -1   => '',
    subjectwillingnessindex <= 1.5 => willingnessreason,
    subjectwillingnessindex <= 3.5 => willingnessreason,
    subjectwillingnessindex <= 6.5 => willingnessreason,
    subjectwillingnessindex <= 7.5 => willingnessreason,
                                      '');

onyx_rv5attr_og_aa_dist_03 := -0.44157510524279 - onyx_rv5attr_og_v03_w;

//onyx_rv5attr_og_aa_code_03 := if(onyx_rv5attr_og_aa_dist_03 = 0, NULL, onyx_rv5attr_og_aa_code_03_1);
onyx_rv5attr_og_aa_code_03 := if(onyx_rv5attr_og_aa_dist_03 = 0, '', onyx_rv5attr_og_aa_code_03_1);

onyx_rv5attr_og_v04_w := map(
    addrcurrentavmratio60monthprior = NULL   => 0,
    addrcurrentavmratio60monthprior = 0      => 0,
    addrcurrentavmratio60monthprior = -1     => -0.110465796361565,
    addrcurrentavmratio60monthprior <= 0.505 => 0.523124548415435,
    addrcurrentavmratio60monthprior <= 0.875 => 0.389216661817632,
    addrcurrentavmratio60monthprior <= 1.025 => 0.149140313915064,
    addrcurrentavmratio60monthprior <= 1.085 => 0.0426875778570948,
    addrcurrentavmratio60monthprior <= 2.385 => -0.0595053794312074,
                                                -0.411491271549947);

onyx_rv5attr_og_aa_code_04_1 := map(
    addrcurrentavmratio60monthprior = NULL   => '',
    addrcurrentavmratio60monthprior = 0      => '',
    addrcurrentavmratio60monthprior = -1     => 'A47',
    addrcurrentavmratio60monthprior <= 0.505 => 'A47',
    addrcurrentavmratio60monthprior <= 0.875 => 'A47',
    addrcurrentavmratio60monthprior <= 1.025 => 'A47',
    addrcurrentavmratio60monthprior <= 1.085 => 'A47',
    addrcurrentavmratio60monthprior <= 2.385 => 'A47',
                                                '');

onyx_rv5attr_og_aa_dist_04 := -0.411491271549947 - onyx_rv5attr_og_v04_w;

onyx_rv5attr_og_aa_code_04 := if(onyx_rv5attr_og_aa_dist_04 = 0, '', onyx_rv5attr_og_aa_code_04_1);

onyx_rv5attr_og_v05_w := map(
    subjectrecordtimeoldest = NULL   => 0,
    subjectrecordtimeoldest = -1     => 0.684829546110377,
    subjectrecordtimeoldest <= 246.5 => 0.177331820150222,
    subjectrecordtimeoldest <= 273.5 => 0.0842846814772332,
    subjectrecordtimeoldest <= 297.5 => -0.0289582020014601,
    subjectrecordtimeoldest <= 434.5 => -0.163111782564515,
                                        -0.330932289173103);

onyx_rv5attr_og_aa_code_05_1 := map(
    subjectrecordtimeoldest = NULL   => '',
    subjectrecordtimeoldest = -1     => '',
    subjectrecordtimeoldest <= 246.5 => 'C10',
    subjectrecordtimeoldest <= 273.5 => 'C10',
    subjectrecordtimeoldest <= 297.5 => 'C10',
    subjectrecordtimeoldest <= 434.5 => 'C10',
                                        '');

onyx_rv5attr_og_aa_dist_05 := -0.330932289173103 - onyx_rv5attr_og_v05_w;

onyx_rv5attr_og_aa_code_05 := if(onyx_rv5attr_og_aa_dist_05 = 0, '', onyx_rv5attr_og_aa_code_05_1);

onyx_rv5attr_og_v06_w := map(
    sourcenonderogcount = NULL => 0,
    sourcenonderogcount = -1   => 0,
    sourcenonderogcount <= 2.5 => 0.170649550448755,
    sourcenonderogcount <= 3.5 => -0.0165943420929668,
    sourcenonderogcount <= 4.5 => -0.0934823647913669,
                                  -0.542375031769121);

onyx_rv5attr_og_aa_code_06_1 := map(
    sourcenonderogcount = NULL => '',
    sourcenonderogcount = -1   => '',
    sourcenonderogcount <= 2.5 => 'C12',
    sourcenonderogcount <= 3.5 => 'C12',
    sourcenonderogcount <= 4.5 => 'C12',
                                  '');

onyx_rv5attr_og_aa_dist_06 := -0.542375031769121 - onyx_rv5attr_og_v06_w;

onyx_rv5attr_og_aa_code_06 := if(onyx_rv5attr_og_aa_dist_06 = 0, '', onyx_rv5attr_og_aa_code_06_1);

onyx_rv5attr_og_v07_w := map(
    inquirybanking12month = NULL => 0,
    inquirybanking12month = -1   => 0,
    inquirybanking12month <= 0.5 => -0.120802682810751,
                                    0.145839678994887);

onyx_rv5attr_og_aa_code_07_1 := map(
    inquirybanking12month = NULL => '',
    inquirybanking12month = -1   => '',
    inquirybanking12month <= 0.5 => '',
                                    'I60');

onyx_rv5attr_og_aa_dist_07 := -0.120802682810751 - onyx_rv5attr_og_v07_w;

onyx_rv5attr_og_aa_code_07 := if(onyx_rv5attr_og_aa_dist_07 = 0, '', onyx_rv5attr_og_aa_code_07_1);

onyx_rv5attr_og_v08_w := map(
    addrinputsubjectowned = NULL => 0,
    addrinputsubjectowned = -1   => 0.147794562482795,
    addrinputsubjectowned <= 0.5 => 0.0581946667484819,
                                    -0.174497425496552);

onyx_rv5attr_og_aa_code_08_1 := map(
    addrinputsubjectowned = NULL => '',
    addrinputsubjectowned = -1   => '',
    addrinputsubjectowned <= 0.5 => 'A44',
                                    '');

onyx_rv5attr_og_aa_dist_08 := -0.174497425496552 - onyx_rv5attr_og_v08_w;

onyx_rv5attr_og_aa_code_08 := if(onyx_rv5attr_og_aa_dist_08 = 0, '', onyx_rv5attr_og_aa_code_08_1);

onyx_rv5attr_og_v09_w := map(
    criminalfelonycount = NULL => 0,
    criminalfelonycount = -1   => 0,
    criminalfelonycount <= 0   => 0.105453159314349,
                                  0.54063261829917);

onyx_rv5attr_og_aa_code_09_1 := map(
    criminalfelonycount = NULL => '',
    criminalfelonycount = -1   => '',
    criminalfelonycount <= 0   => '',
                                  'D32');

onyx_rv5attr_og_aa_dist_09 := 0.105453159314349 - onyx_rv5attr_og_v09_w;

onyx_rv5attr_og_aa_code_09 := if(onyx_rv5attr_og_aa_dist_09 = 0, '', onyx_rv5attr_og_aa_code_09_1);

onyx_rv5attr_og_v10_w := map(
    addrcurrenttimeoldest = NULL  => 0,
    addrcurrenttimeoldest = -1    => -0.290875055731487,
    addrcurrenttimeoldest <= 8.5  => 0.223444768231341,
    addrcurrenttimeoldest <= 9.5  => 0.0655723097061774,
    addrcurrenttimeoldest <= 99.5 => 0.0232513819652818,
                                     -0.0952965749342708);

onyx_rv5attr_og_aa_code_10_1 := map(
    addrcurrenttimeoldest = NULL  => '',
    addrcurrenttimeoldest = -1    => '',
    addrcurrenttimeoldest <= 8.5  => 'C13',
    addrcurrenttimeoldest <= 9.5  => 'C13',
    addrcurrenttimeoldest <= 99.5 => 'C13',
                                     '');

onyx_rv5attr_og_aa_dist_10 := -0.0952965749342708 - onyx_rv5attr_og_v10_w;

onyx_rv5attr_og_aa_code_10 := if(onyx_rv5attr_og_aa_dist_10 = 0, '', onyx_rv5attr_og_aa_code_10_1);

onyx_rv5attr_og_rcvalued32 := (integer)(onyx_rv5attr_og_aa_code_01 = 'D32') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'D32') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'D32') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'D32') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'D32') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'D32') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'D32') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'D32') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'D32') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'D32') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluec10 := (integer)(onyx_rv5attr_og_aa_code_01 = 'C10') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'C10') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'C10') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'C10') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'C10') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'C10') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'C10') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'C10') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'C10') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'C10') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvalued33 := (integer)(onyx_rv5attr_og_aa_code_01 = 'D33') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'D33') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'D33') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'D33') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'D33') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'D33') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'D33') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'D33') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'D33') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'D33') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluea47 := (integer)(onyx_rv5attr_og_aa_code_01 = 'A47') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'A47') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'A47') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'A47') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'A47') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'A47') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'A47') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'A47') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'A47') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'A47') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluec13 := (integer)(onyx_rv5attr_og_aa_code_01 = 'C13') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'C13') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'C13') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'C13') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'C13') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'C13') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'C13') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'C13') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'C13') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'C13') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluei60 := (integer)(onyx_rv5attr_og_aa_code_01 = 'I60') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'I60') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'I60') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'I60') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'I60') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'I60') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'I60') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'I60') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'I60') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'I60') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluea44 := (integer)(onyx_rv5attr_og_aa_code_01 = 'A44') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'A44') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'A44') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'A44') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'A44') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'A44') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'A44') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'A44') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'A44') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'A44') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_rcvaluec12 := (integer)(onyx_rv5attr_og_aa_code_01 = 'C12') * onyx_rv5attr_og_aa_dist_01 +
    (integer)(onyx_rv5attr_og_aa_code_02 = 'C12') * onyx_rv5attr_og_aa_dist_02 +
    (integer)(onyx_rv5attr_og_aa_code_03 = 'C12') * onyx_rv5attr_og_aa_dist_03 +
    (integer)(onyx_rv5attr_og_aa_code_04 = 'C12') * onyx_rv5attr_og_aa_dist_04 +
    (integer)(onyx_rv5attr_og_aa_code_05 = 'C12') * onyx_rv5attr_og_aa_dist_05 +
    (integer)(onyx_rv5attr_og_aa_code_06 = 'C12') * onyx_rv5attr_og_aa_dist_06 +
    (integer)(onyx_rv5attr_og_aa_code_07 = 'C12') * onyx_rv5attr_og_aa_dist_07 +
    (integer)(onyx_rv5attr_og_aa_code_08 = 'C12') * onyx_rv5attr_og_aa_dist_08 +
    (integer)(onyx_rv5attr_og_aa_code_09 = 'C12') * onyx_rv5attr_og_aa_dist_09 +
    (integer)(onyx_rv5attr_og_aa_code_10 = 'C12') * onyx_rv5attr_og_aa_dist_10;

onyx_rv5attr_og_lgt := -1.10207179999171 +
    onyx_rv5attr_og_V01_w +
    onyx_rv5attr_og_V02_w +
    onyx_rv5attr_og_V03_w +
    onyx_rv5attr_og_V04_w +
    onyx_rv5attr_og_V05_w +
    onyx_rv5attr_og_V06_w +
    onyx_rv5attr_og_V07_w +
    onyx_rv5attr_og_V08_w +
    onyx_rv5attr_og_V09_w +
    onyx_rv5attr_og_V10_w;






//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_onyx_rv5attr_og_1 := DATASET([
    {'D32', onyx_rv5attr_og_rcvalueD32},
    {'C10', onyx_rv5attr_og_rcvalueC10},
    {'D33', onyx_rv5attr_og_rcvalueD33},
    {'A47', onyx_rv5attr_og_rcvalueA47},
    {'C13', onyx_rv5attr_og_rcvalueC13},
    {'I60', onyx_rv5attr_og_rcvalueI60},
    {'A44', onyx_rv5attr_og_rcvalueA44},
    {'C12', onyx_rv5attr_og_rcvalueC12}
    ], ds_layout)(value < 0);


rc_dataset_onyx_rv5attr_og := DATASET([
    {onyx_rv5attr_og_aa_code_03,onyx_rv5attr_og_aa_dist_03}
    ], ds_layout)(value < 0);


rc_dataset_upd_1 := if (onyx_rv5attr_og_aa_code_03 not in 
                  ['','D32','C10', 'D33', 'A47', 
                   'C13', 'I60', 'A44','C12'],
                  rc_dataset_onyx_rv5attr_og_1 + rc_dataset_onyx_rv5attr_og,rc_dataset_onyx_rv5attr_og_1 );





//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_onyx_rv5attr_og_sorted := sort(rc_dataset_upd_1, rc_dataset_upd_1.value);

r_rc1 := rc_dataset_onyx_rv5attr_og_sorted[1].rc;
r_rc2 := rc_dataset_onyx_rv5attr_og_sorted[2].rc;
r_rc3 := rc_dataset_onyx_rv5attr_og_sorted[3].rc;
r_rc4 := rc_dataset_onyx_rv5attr_og_sorted[4].rc;
r_rc5 := rc_dataset_onyx_rv5attr_og_sorted[5].rc;
r_rc6 := rc_dataset_onyx_rv5attr_og_sorted[6].rc;
r_rc7 := rc_dataset_onyx_rv5attr_og_sorted[7].rc;
r_rc8 := rc_dataset_onyx_rv5attr_og_sorted[8].rc;
r_rc9 := rc_dataset_onyx_rv5attr_og_sorted[9].rc;
r_rc10 := rc_dataset_onyx_rv5attr_og_sorted[10].rc;


r_vl1 := rc_dataset_onyx_rv5attr_og_sorted[1].value;
r_vl2 := rc_dataset_onyx_rv5attr_og_sorted[2].value;
r_vl3 := rc_dataset_onyx_rv5attr_og_sorted[3].value;
r_vl4 := rc_dataset_onyx_rv5attr_og_sorted[4].value;
r_vl5 := rc_dataset_onyx_rv5attr_og_sorted[5].value;
r_vl6 := rc_dataset_onyx_rv5attr_og_sorted[6].value;
r_vl7 := rc_dataset_onyx_rv5attr_og_sorted[7].value;
r_vl8 := rc_dataset_onyx_rv5attr_og_sorted[8].value;
r_vl9 := rc_dataset_onyx_rv5attr_og_sorted[9].value;
r_vl10 := rc_dataset_onyx_rv5attr_og_sorted[10].value;
//*************************************************************************************//


rc1_3 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = 'I60' or r_rc2 = 'I60' or r_rc3 = 'I60' or r_rc4 = 'I60' or r_rc5 = 'I60' or r_rc6 = 'I60' or r_rc7 = 'I60' or r_rc8 = 'I60', 'I60', '');

rc1_c34 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc3_c34 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc2_c34 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc5_c34 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);

rc4_c34 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     '');

rc1_2 := if(rc1_c34 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c34, rc1_3);

rc2_1 := if(rc2_c34 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c34, rc2_2);

rc3_1 := if(rc3_c34 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c34, rc3_2);

rc5_1 := if(rc5_c34 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c34, '');

rc4_1 := if(rc4_c34 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c34, rc4_2);

base := 700;

pts := -40;

odds := 0.207584621813623;

rvg1808_2_0 := map(
    confirmationsubjectfound < 1           => 222,
    SSNDeceased = 1 or SubjectDeceased = 1 => 200,
                                              min(if(max(round(pts * (onyx_rv5attr_og_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (onyx_rv5attr_og_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc1_1 := if(500 < rvg1808_2_0 AND rvg1808_2_0 < 831 and rc1_2 = '', 'C12', rc1_2);

rc5 := if(rvg1808_2_0 >= 831 or rvg1808_2_0 <= 500, '', rc5_1);

rc4 := if(rvg1808_2_0 >= 831 or rvg1808_2_0 <= 500, '', rc4_1);

rc1 := if(rvg1808_2_0 >= 831 or rvg1808_2_0 <= 500, '', rc1_1);

rc2 := if(rvg1808_2_0 >= 831 or rvg1808_2_0 <= 500, '', rc2_1);

rc3 := if(rvg1808_2_0 >= 831 or rvg1808_2_0 <= 500, '', rc3_1);




	//*************************************************************************************//
	//                     RiskView Version 5 - RVG1808_2 Score Overrides
	//*************************************************************************************//
	// Deceased = 200
	// Unscorable = 222
	// Score Range: 501 - 900
	//*************************************************************************************//


//*************************************************************************************//
//                      RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													rvg1808_2_0 = 200 => DATASET([{'00'}], HRILayout),
													rvg1808_2_0 = 222 => DATASET([{'00'}], HRILayout),
													rvg1808_2_0 = 900 => DATASET([{'00'}], HRILayout),
																				 			 DATASET([], HRILayout)
													);
reasons := DATASET([{rc1}, {rc2}, {rc3}, {rc4}, {rc5}], HRILayout);
// If we have score overrides use them, else use the normal reason codes
reasonsFinalTemp := IF(ut.Exists2(reasonsOverrides), 
										reasonsOverrides, 
										reasons) (HRI <> '');
zeros := DATASET([{'00'}, {'00'}, {'00'}, {'00'}, {'00'}], HRILayout);
reasonCodes := CHOOSEN(reasonsFinalTemp & zeros, 5);                             // Keep up to 5 reason codes

//*************************************************************************************//
//                   End RiskView Version 5 Reason Code Overrides
//*************************************************************************************//

	#if(MODEL_DEBUG)
	/* Model Input Variables */	
		 SELF.seq     := le.seq;
		// self.firstname := firstname; self.lastname := lastname; self.ssn := ssn;
		self.sysdate                          := sysdate;
									   self.willingnessreason                := willingnessreason;
                    self.criminalnonfelonycount:= criminalnonfelonycount;
                   self.evictioncount:= evictioncount;                  
                    self.subjectwillingnessindex   := subjectwillingnessindex;//:= le.subjectwillingnessindex := sysdate;
                    self.SubjectWillingnessPrimaryFactor  := SubjectWillingnessPrimaryFactor;// :=  le.SubjectWillingnessPrimaryFactor:= sysdate;
                    self.addrcurrentavmratio60monthprior:= addrcurrentavmratio60monthprior;
                    self.subjectrecordtimeoldest    := subjectrecordtimeoldest;
                    self.sourcenonderogcount := sourcenonderogcount;
                    self.inquirybanking12month := inquirybanking12month;
                    self.addrinputsubjectowned := addrinputsubjectowned;
                    self.criminalfelonycount := criminalfelonycount;
                    self.addrcurrenttimeoldest := addrcurrenttimeoldest;
                    self.SSNDeceased      := SSNDeceased;// :=  le.SSNDeceased:= sysdate;
                    self.SubjectDeceased  := SubjectDeceased;// :=  le.SubjectDeceased:= sysdate;
                    self.confirmationsubjectfound  := confirmationsubjectfound;// := le.confirmationsubjectfound ; 
                    self.onyx_rv5attr_og_v01_w            := onyx_rv5attr_og_v01_w;
                    self.onyx_rv5attr_og_aa_dist_01       := onyx_rv5attr_og_aa_dist_01;
                    self.onyx_rv5attr_og_aa_code_01       := onyx_rv5attr_og_aa_code_01;
                    self.onyx_rv5attr_og_v02_w            := onyx_rv5attr_og_v02_w;
                    self.onyx_rv5attr_og_aa_dist_02       := onyx_rv5attr_og_aa_dist_02;
                    self.onyx_rv5attr_og_aa_code_02       := onyx_rv5attr_og_aa_code_02;
                    self.onyx_rv5attr_og_v03_w            := onyx_rv5attr_og_v03_w;
                    self.onyx_rv5attr_og_aa_dist_03       := onyx_rv5attr_og_aa_dist_03;
                    self.onyx_rv5attr_og_aa_code_03       := onyx_rv5attr_og_aa_code_03;
                    self.onyx_rv5attr_og_v04_w            := onyx_rv5attr_og_v04_w;
                    self.onyx_rv5attr_og_aa_dist_04       := onyx_rv5attr_og_aa_dist_04;
                    self.onyx_rv5attr_og_aa_code_04       := onyx_rv5attr_og_aa_code_04;
                    self.onyx_rv5attr_og_v05_w            := onyx_rv5attr_og_v05_w;
                    self.onyx_rv5attr_og_aa_dist_05       := onyx_rv5attr_og_aa_dist_05;
                    self.onyx_rv5attr_og_aa_code_05       := onyx_rv5attr_og_aa_code_05;
                    self.onyx_rv5attr_og_v06_w            := onyx_rv5attr_og_v06_w;
                    self.onyx_rv5attr_og_aa_dist_06       := onyx_rv5attr_og_aa_dist_06;
                    self.onyx_rv5attr_og_aa_code_06       := onyx_rv5attr_og_aa_code_06;
                    self.onyx_rv5attr_og_v07_w            := onyx_rv5attr_og_v07_w;
                    self.onyx_rv5attr_og_aa_dist_07       := onyx_rv5attr_og_aa_dist_07;
                    self.onyx_rv5attr_og_aa_code_07       := onyx_rv5attr_og_aa_code_07;
                    self.onyx_rv5attr_og_v08_w            := onyx_rv5attr_og_v08_w;
                    self.onyx_rv5attr_og_aa_dist_08       := onyx_rv5attr_og_aa_dist_08;
                    self.onyx_rv5attr_og_aa_code_08       := onyx_rv5attr_og_aa_code_08;
                    self.onyx_rv5attr_og_v09_w            := onyx_rv5attr_og_v09_w;
                    self.onyx_rv5attr_og_aa_dist_09       := onyx_rv5attr_og_aa_dist_09;
                    self.onyx_rv5attr_og_aa_code_09       := onyx_rv5attr_og_aa_code_09;
                    self.onyx_rv5attr_og_v10_w            := onyx_rv5attr_og_v10_w;
                    self.onyx_rv5attr_og_aa_dist_10       := onyx_rv5attr_og_aa_dist_10;
                    self.onyx_rv5attr_og_aa_code_10       := onyx_rv5attr_og_aa_code_10;
                    self.onyx_rv5attr_og_rcvalued32       := onyx_rv5attr_og_rcvalued32;
                    self.onyx_rv5attr_og_rcvaluec10       := onyx_rv5attr_og_rcvaluec10;
                    self.onyx_rv5attr_og_rcvalued33       := onyx_rv5attr_og_rcvalued33;
                    self.onyx_rv5attr_og_rcvaluea47       := onyx_rv5attr_og_rcvaluea47;
                    self.onyx_rv5attr_og_rcvaluec13       := onyx_rv5attr_og_rcvaluec13;
                    self.onyx_rv5attr_og_rcvaluei60       := onyx_rv5attr_og_rcvaluei60;
                    self.onyx_rv5attr_og_rcvaluea44       := onyx_rv5attr_og_rcvaluea44;
                    self.onyx_rv5attr_og_rcvaluec12       := onyx_rv5attr_og_rcvaluec12;
                    self.onyx_rv5attr_og_lgt              := onyx_rv5attr_og_lgt;
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
                    self._rc_inq                          := _rc_inq;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvg1808_2_0                      := rvg1808_2_0;
                    self.rc3                              := rc3;
                    self.rc4                              := rc4;
                    self.rc2                              := rc2;
                    self.rc5                              := rc5;
                    self.rc1                              := rc1;


		SELF.clam := rt;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1808_2_0;
		SELF.seq := le.seq;
	#end
	END;

	
  model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));
	RETURN(model);
END;

