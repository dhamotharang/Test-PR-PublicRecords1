IMPORT Models, Risk_Indicators, RiskWise, RiskView, UT, Std;

EXPORT RVA1809_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION


	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	MODEL_DEBUG        := false;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
                    unsigned4 seq;            
                    integer sysdate                         ;// := sysdate;
                   Real addrchangecount60month          ;//:=(real)le.addrchangecount60month;  
                   Real subjectrecordtimeoldest        ; //:=(real)le.subjectrecordtimeoldest;
                   Real addrinputavmratio12monthprior   ;//:=(real)le.AddrInputAVMRatio12MonthPrior;
                   Real inquiryauto12month              ;//:=(real)le.inquiryauto12month;
                   Real evictioncount                   ;//:=(real)le.evictioncount;  
                   Real addronfilecount                 ;//:=(real)le.addronfilecount;
                   Real assetindex                      ;//:=(real)le.assetindex;
                   Real addrinputownershipindex         ;//:=(real)le.addrinputownershipindex;
                   Real subjectactivityindex03month     ;//:=(real)le.SubjectActivityIndex03Month;
                   Real addrinputavmratio60monthprior   ;//:=(real)le.addrinputavmratio60monthprior ;
                   Real confirmationinputdob            ;//:=(real)le.confirmationinputdob ;  
                   Real addrcurrentavmvalue             ;//:=(real)le.addrcurrentavmvalue;
                   Real addrinputsubjectcount           ;//:=(real)le.confirmationinputdob ; 
                   Real addrlastmovetaxratiodiff        ;//:=(real)le.confirmationinputdob ;
                   Real SSNDeceased                     ;//:=(real)le.ssndeceased;
                   Real SubjectDeceased                 ;//:=(real)le.SubjectDeceased ;
                   Real confirmationsubjectfound       ; //:=(real)le.confirmationsubjectfound; 
                   string assetindexprimaryfactor         ;//:=le.assetindexprimaryfactor; 
                    
                    string      assetreason                      ;
                    //real	      evictioncount                    ;  
                    real      cja_bad_v3_v01_w                 ; // := := cja_bad_v3_v01_w;
                    real      cja_bad_v3_aa_dist_01            ; // := := cja_bad_v3_aa_dist_01;
                    string      cja_bad_v3_aa_code_01            ; // := := cja_bad_v3_aa_code_01;
                    real      cja_bad_v3_v02_w                 ; // := := cja_bad_v3_v02_w;
                    real      cja_bad_v3_aa_dist_02            ; // := := cja_bad_v3_aa_dist_02;
                    string      cja_bad_v3_aa_code_02            ; // := := cja_bad_v3_aa_code_02;
                    real      cja_bad_v3_v03_w                 ; // := := cja_bad_v3_v03_w;
                    real      cja_bad_v3_aa_dist_03            ; // := := cja_bad_v3_aa_dist_03;
                    string      cja_bad_v3_aa_code_03            ; // := := cja_bad_v3_aa_code_03;
                    real      cja_bad_v3_v04_w                 ; // := := cja_bad_v3_v04_w;
                    real      cja_bad_v3_aa_dist_04            ; // := := cja_bad_v3_aa_dist_04;
                    string      cja_bad_v3_aa_code_04            ; // := := cja_bad_v3_aa_code_04;
                    real      cja_bad_v3_v05_w                 ; // := := cja_bad_v3_v05_w;
                    real      cja_bad_v3_aa_dist_05            ; // := := cja_bad_v3_aa_dist_05;
                    string      cja_bad_v3_aa_code_05            ; // := := cja_bad_v3_aa_code_05;
                    real      cja_bad_v3_v06_w                 ; // := := cja_bad_v3_v06_w;
                    real      cja_bad_v3_aa_dist_06            ; // := := cja_bad_v3_aa_dist_06;
                    string      cja_bad_v3_aa_code_06            ; // := := cja_bad_v3_aa_code_06;
                    real      cja_bad_v3_v07_w                 ; // := := cja_bad_v3_v07_w;
                    real      cja_bad_v3_aa_dist_07            ; // := := cja_bad_v3_aa_dist_07;
                    string      cja_bad_v3_aa_code_07            ; // := := cja_bad_v3_aa_code_07;
                    real      cja_bad_v3_v08_w                 ; // := := cja_bad_v3_v08_w;
                    real      cja_bad_v3_aa_dist_08            ; // := := cja_bad_v3_aa_dist_08;
                    string      cja_bad_v3_aa_code_08            ; // := := cja_bad_v3_aa_code_08;
                    real      cja_bad_v3_v09_w                 ; // := := cja_bad_v3_v09_w;
                    real      cja_bad_v3_aa_dist_09            ; // := := cja_bad_v3_aa_dist_09;
                    string      cja_bad_v3_aa_code_09            ; // := := cja_bad_v3_aa_code_09;
                    real      cja_bad_v3_v10_w                 ; // := := cja_bad_v3_v10_w;
                    real      cja_bad_v3_aa_dist_10            ; // := := cja_bad_v3_aa_dist_10;
                    string      cja_bad_v3_aa_code_10            ; // := := cja_bad_v3_aa_code_10;
                    real      cja_bad_v3_v11_w                 ; // := := cja_bad_v3_v11_w;
                    real      cja_bad_v3_aa_dist_11            ; // := := cja_bad_v3_aa_dist_11;
                    string      cja_bad_v3_aa_code_11            ; // := := cja_bad_v3_aa_code_11;
                    real      cja_bad_v3_v12_w                 ; // := := cja_bad_v3_v12_w;
                    real      cja_bad_v3_aa_dist_12            ; // := := cja_bad_v3_aa_dist_12;
                    string      cja_bad_v3_aa_code_12            ; // := := cja_bad_v3_aa_code_12;
                    real      cja_bad_v3_v13_w                 ; // := := cja_bad_v3_v13_w;
                    real      cja_bad_v3_aa_dist_13            ; // := := cja_bad_v3_aa_dist_13;
                    string      cja_bad_v3_aa_code_13            ; // := := cja_bad_v3_aa_code_13;
                    real      cja_bad_v3_v14_w                 ; // := := cja_bad_v3_v14_w;
                    real      cja_bad_v3_aa_dist_14            ; // := := cja_bad_v3_aa_dist_14;
                    string      cja_bad_v3_aa_code_14            ; // := := cja_bad_v3_aa_code_14;
                    real      cja_bad_v3_rcvaluec14            ; // := := cja_bad_v3_rcvaluec14;
                    real      cja_bad_v3_rcvaluei60            ; // := := cja_bad_v3_rcvaluei60;
                    real      cja_bad_v3_rcvaluea51            ; // := := cja_bad_v3_rcvaluea51;
                    real      cja_bad_v3_rcvaluea40            ; // := := cja_bad_v3_rcvaluea40;
                    real      cja_bad_v3_rcvaluea50            ; // := := cja_bad_v3_rcvaluea50;
                    real      cja_bad_v3_rcvaluea46            ; // := := cja_bad_v3_rcvaluea46;
                    real      cja_bad_v3_rcvaluea42            ; // := := cja_bad_v3_rcvaluea42;
                    real      cja_bad_v3_rcvaluec10            ; // := := cja_bad_v3_rcvaluec10;
                    real      cja_bad_v3_rcvaluec12            ; // := := cja_bad_v3_rcvaluec12;
                    real      cja_bad_v3_rcvaluec13            ; // := := cja_bad_v3_rcvaluec13;
                    real      cja_bad_v3_rcvalued30            ; // := := cja_bad_v3_rcvalued30;
                    real      cja_bad_v3_rcvaluea41            ; // := := cja_bad_v3_rcvaluea41;
                    real      cja_bad_v3_rcvaluel80            ; // := := cja_bad_v3_rcvaluel80;
                    real      cja_bad_v3_rcvaluef00            ; // := := cja_bad_v3_rcvaluef00;
                    real      cja_bad_v3_rcvaluel79            ; // := := cja_bad_v3_rcvaluel79;
                    real      cja_bad_v3_rcvaluea47            ; // := := cja_bad_v3_rcvaluea47;
                    real      cja_bad_v3_rcvalued33            ; // := := cja_bad_v3_rcvalued33;
                    real      cja_bad_v3_lgt                   ; // := := cja_bad_v3_lgt;
                    string      r_rc1                            ; // := := r_rc1;
                    string      r_rc2                            ; // := := r_rc2;
                    string      r_rc3                            ; // := := r_rc3;
                    string      r_rc4                            ; // := := r_rc4;
                    string      r_rc5                            ; // := := r_rc5;
                    string      r_rc6                            ; // := := r_rc6;
                    string      r_rc7                            ; // := := r_rc7;
                    string      r_rc8                            ; // := := r_rc8;
                    string      r_rc9                            ; // := := r_rc9;
                    string      r_rc10                           ; // := := r_rc10;
                    string      r_rc11                           ; // := := r_rc11;
                    string      r_rc12                           ; // := := r_rc12;
                    string      r_rc13                           ; // := := r_rc13;
                    string      r_rc14                           ; // := := r_rc14;
                    string      r_rc15                           ; // := := r_rc15;
                    string      r_rc16                           ; // := := r_rc16;
                    string      r_rc17                           ; // := := r_rc17;
                    real      r_vl1                            ; // := := r_vl1;
                    real      r_vl2                            ; // := := r_vl2;
                    real      r_vl3                            ; // := := r_vl3;
                    real      r_vl4                            ; // := := r_vl4;
                    real      r_vl5                            ; // := := r_vl5;
                    real      r_vl6                            ; // := := r_vl6;
                    real      r_vl7                            ; // := := r_vl7;
                    real      r_vl8                            ; // := := r_vl8;
                    real      r_vl9                            ; // := := r_vl9;
                    real      r_vl10                           ; // := := r_vl10;
                    real      r_vl11                           ; // := := r_vl11;
                    real      r_vl12                           ; // := := r_vl12;
                    real      r_vl13                           ; // := := r_vl13;
                    real      r_vl14                           ; // := := r_vl14;
                    real      r_vl15                           ; // := := r_vl15;
                    real      r_vl16                           ; // := := r_vl16;
                    real      r_vl17                           ; // := := r_vl17;
                    string      _rc_inq                          ; // := := _rc_inq;
                    integer      base                             ; // := := base;
                    integer      pts                              ; // := := pts;
                    real      odds                             ; // := := odds;
                    integer      rva1809_1_0                      ; // := := rva1809_1_0;
                    string      rc1                              ; // := := rc1;
                    string      rc2                              ; // := := rc2;
                    string      rc3                              ; // := := rc3;
                    string      rc4                              ; // := := rc4;
                    string      rc5                              ; // := := rc5;


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

                   
              addrchangecount60month          :=(real)le.addrchangecount60month;  
              subjectrecordtimeoldest         :=(real)le.subjectrecordtimeoldest;
              addrinputavmratio12monthprior   :=(real)le.AddrInputAVMRatio12MonthPrior;
              inquiryauto12month              :=(real)le.inquiryauto12month;
              evictioncount                   :=(real)le.evictioncount;  
              addronfilecount                 :=(real)le.addronfilecount;
              assetindex                      :=(real)le.assetindex;
              addrinputownershipindex         :=(real)le.addrinputownershipindex;
              subjectactivityindex03month     :=(real)le.SubjectActivityIndex03Month;
              addrinputavmratio60monthprior   :=(real)le.addrinputavmratio60monthprior ;
              confirmationinputdob            :=(real)le.confirmationinputdob ;  
              addrcurrentavmvalue             :=(real)le.addrcurrentavmvalue;
              addrinputsubjectcount           :=(real)le.confirmationinputdob ; 
              addrlastmovetaxratiodiff        :=(real)le.confirmationinputdob ;
              SSNDeceased                     :=(real)le.ssndeceased;
              SubjectDeceased                 :=(real)le.SubjectDeceased ;
              confirmationsubjectfound        :=(real)le.confirmationsubjectfound; 
              assetindexprimaryfactor         :=le.assetindexprimaryfactor; 
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

assetreason := if(not((assetindexPrimaryFactor in ['-1', '0'])) and not(assetindexPrimaryFactor = ''), assetindexPrimaryFactor, '');

cja_bad_v3_v01_w := map(
    addrchangecount60month = NULL => 0,
    addrchangecount60month = -1   => 0,
    addrchangecount60month <= 0   => 0.0204994398954909,
    addrchangecount60month <= 2.5 => -0.18157052719678,
    addrchangecount60month <= 3.5 => 0.0907029214893339,
                                     0.217903066827815);

cja_bad_v3_aa_code_01_1 := map(
    addrchangecount60month = NULL => '',
    addrchangecount60month = -1   => 'C12',
    addrchangecount60month <= 0   => 'C12',
    addrchangecount60month <= 2.5 => '',
    addrchangecount60month <= 3.5 => 'C14',
                                     'C14');

cja_bad_v3_aa_dist_01 := -0.18157052719678 - cja_bad_v3_v01_w;

cja_bad_v3_aa_code_01 := if(cja_bad_v3_aa_dist_01 = 0, '', cja_bad_v3_aa_code_01_1);

cja_bad_v3_v02_w := map(
    subjectrecordtimeoldest = NULL   => 0,
    subjectrecordtimeoldest = -1     => 0,
    subjectrecordtimeoldest <= 32    => 0.256942755697339,
    subjectrecordtimeoldest <= 171.5 => 0.0998628265121072,
    subjectrecordtimeoldest <= 294.5 => 0.0215835601857292,
                                        -0.252993780789985);

cja_bad_v3_aa_code_02_1 := map(
    subjectrecordtimeoldest = NULL   => 'C12',
    subjectrecordtimeoldest = -1     => '',
    subjectrecordtimeoldest <= 32    => 'C10',
    subjectrecordtimeoldest <= 171.5 => 'C10',
    subjectrecordtimeoldest <= 294.5 => 'C10',
                                        '');

cja_bad_v3_aa_dist_02 := -0.252993780789985 - cja_bad_v3_v02_w;

cja_bad_v3_aa_code_02 := if(cja_bad_v3_aa_dist_02 = 0, '', cja_bad_v3_aa_code_02_1);

cja_bad_v3_v03_w := map(
    addrinputavmratio12monthprior = NULL   => 0,
    addrinputavmratio12monthprior = -1     => 0,
    addrinputavmratio12monthprior <= 1.055 => -0.20730069078141,
    addrinputavmratio12monthprior <= 1.115 => -0.0993553249495253,
    addrinputavmratio12monthprior <= 1.295 => 0.00528321660420689,
                                              0.282770412504292);

cja_bad_v3_aa_code_03_1 := map(
    addrinputavmratio12monthprior = NULL   => '',
    addrinputavmratio12monthprior = -1     => 'C12',
    addrinputavmratio12monthprior <= 1.055 => '',
    addrinputavmratio12monthprior <= 1.115 => 'C12',
    addrinputavmratio12monthprior <= 1.295 => 'C12',
                                              'C12');

cja_bad_v3_aa_dist_03 := -0.20730069078141 - cja_bad_v3_v03_w;

cja_bad_v3_aa_code_03 := if(cja_bad_v3_aa_dist_03 = 0, '', cja_bad_v3_aa_code_03_1);

cja_bad_v3_v04_w := map(
    inquiryauto12month = NULL => 0,
    inquiryauto12month = -1   => 0,
    inquiryauto12month <= 0.5 => -0.163805308366612,
                                 0.163383129915022);

cja_bad_v3_aa_code_04_1 := map(
    inquiryauto12month = NULL => '',
    inquiryauto12month = -1   => 'C12',
    inquiryauto12month <= 0.5 => '',
                                 'I60');

cja_bad_v3_aa_dist_04 := -0.163805308366612 - cja_bad_v3_v04_w;

cja_bad_v3_aa_code_04 := if(cja_bad_v3_aa_dist_04 = 0, '', cja_bad_v3_aa_code_04_1);

cja_bad_v3_v05_w := map(
    evictioncount = NULL => 0,
    evictioncount = -1   => 0,
    evictioncount <= 0.5 => -0.156381189945694,
                            0.156884840604108);

cja_bad_v3_aa_code_05_1 := map(
    evictioncount = NULL => '',
    evictioncount = -1   => 'C12',
    evictioncount <= 0.5 => '',
                            'D33');

cja_bad_v3_aa_dist_05 := -0.156381189945694 - cja_bad_v3_v05_w;

cja_bad_v3_aa_code_05 := if(cja_bad_v3_aa_dist_05 = 0, '', cja_bad_v3_aa_code_05_1);

cja_bad_v3_v06_w := map(
    addronfilecount = NULL  => 0,
    addronfilecount = -1    => 0,
    addronfilecount <= 8.5  => -0.11965740891212,
    addronfilecount <= 11.5 => -0.0234737283730975,
                               0.291280529788694);

cja_bad_v3_aa_code_06_1 := map(
    addronfilecount = NULL  => '',
    addronfilecount = -1    => 'C12',
    addronfilecount <= 8.5  => '',
    addronfilecount <= 11.5 => 'C14',
                               'C14');

cja_bad_v3_aa_dist_06 := -0.11965740891212 - cja_bad_v3_v06_w;

cja_bad_v3_aa_code_06 := if(cja_bad_v3_aa_dist_06 = 0, '', cja_bad_v3_aa_code_06_1);

cja_bad_v3_v07_w := map(
    assetindex = NULL => 0,
    assetindex = -1   => 0,
    assetindex <= 2.5 => 0.150782572880761,
                         -0.136451339704712);

cja_bad_v3_aa_code_07_1 := map(
    assetindex = NULL => '',
    assetindex = -1   => 'C12',
    assetindex <= 2.5 => assetreason,
                         '');

cja_bad_v3_aa_dist_07 := -0.136451339704712 - cja_bad_v3_v07_w;

cja_bad_v3_aa_code_07 := if(cja_bad_v3_aa_dist_07 = 0, '', cja_bad_v3_aa_code_07_1);

cja_bad_v3_v08_w := map(
    addrinputownershipindex = NULL => 0,
    addrinputownershipindex = -1   => 0,
    addrinputownershipindex <= 0.5 => 0.135368167413722,
                                      -0.136079877608485);

cja_bad_v3_aa_code_08_1 := map(
    addrinputownershipindex = NULL => '',
    addrinputownershipindex = -1   => 'C12',
    addrinputownershipindex <= 0.5 => 'A51',
                                      '');

cja_bad_v3_aa_dist_08 := -0.136079877608485 - cja_bad_v3_v08_w;

cja_bad_v3_aa_code_08 := if(cja_bad_v3_aa_dist_08 = 0, '', cja_bad_v3_aa_code_08_1);

cja_bad_v3_v09_w := map(
    subjectactivityindex03month = NULL => 0,
    subjectactivityindex03month = -1   => 0,
    subjectactivityindex03month <= 3   => -0.104525075266781,
    subjectactivityindex03month <= 4   => -0.0688433754898691,
                                          0.310504628091837);

cja_bad_v3_aa_code_09_1 := map(
    subjectactivityindex03month = NULL => '',
    subjectactivityindex03month = -1   => 'C12',
    subjectactivityindex03month <= 3   => '',
    subjectactivityindex03month <= 5   => 'C12',
                                          'D30');

cja_bad_v3_aa_dist_09 := -0.104525075266781 - cja_bad_v3_v09_w;

cja_bad_v3_aa_code_09 := if(cja_bad_v3_aa_dist_09 = 0, '', cja_bad_v3_aa_code_09_1);

cja_bad_v3_v10_w := map(
    addrinputavmratio60monthprior = NULL   => 0,
    addrinputavmratio60monthprior = -1     => 0,
    addrinputavmratio60monthprior <= 1.025 => 0.123817695057087,
    addrinputavmratio60monthprior <= 1.385 => -0.0972049048248431,
                                              -0.210089538220168);

cja_bad_v3_aa_code_10_1 := map(
    addrinputavmratio60monthprior = NULL   => '',
    addrinputavmratio60monthprior = -1     => 'C12',
    addrinputavmratio60monthprior <= 1.025 => 'L80',
    addrinputavmratio60monthprior <= 1.385 => 'L80',
                                              '');

cja_bad_v3_aa_dist_10 := -0.210089538220168 - cja_bad_v3_v10_w;

cja_bad_v3_aa_code_10 := if(cja_bad_v3_aa_dist_10 = 0, '', cja_bad_v3_aa_code_10_1);

cja_bad_v3_v11_w := map(
    confirmationinputdob = NULL => 0,
    confirmationinputdob = -1   => 0,
    confirmationinputdob <= 5.5 => 0.115143669236062,
                                   -0.121898018884974);

cja_bad_v3_aa_code_11_1 := map(
    confirmationinputdob = NULL => '',
    confirmationinputdob = -1   => 'C12',
    confirmationinputdob <= 5.5 => 'F00',
                                   '');

cja_bad_v3_aa_dist_11 := -0.121898018884974 - cja_bad_v3_v11_w;

cja_bad_v3_aa_code_11 := if(cja_bad_v3_aa_dist_11 = 0, '', cja_bad_v3_aa_code_11_1);

cja_bad_v3_v12_w := map(
    addrcurrentavmvalue = NULL   => 0,
    addrcurrentavmvalue = -1     => 0,
    addrcurrentavmvalue <= 59824 => 0.421054821956067,
                                    -0.0397037598056696);

cja_bad_v3_aa_code_12_1 := map(
    addrcurrentavmvalue = NULL   => '',
    addrcurrentavmvalue = -1     => 'C12',
    addrcurrentavmvalue <= 59824 => 'A47',
                                    '');

cja_bad_v3_aa_dist_12 := -0.0397037598056696 - cja_bad_v3_v12_w;

cja_bad_v3_aa_code_12 := if(cja_bad_v3_aa_dist_12 = 0, '', cja_bad_v3_aa_code_12_1);

cja_bad_v3_v13_w := map(
    addrinputsubjectcount = NULL => 0,
    addrinputsubjectcount = -1   => 0,
    addrinputsubjectcount <= 2.5 => -0.130332494242588,
                                    0.149851647439797);

cja_bad_v3_aa_code_13_1 := map(
    addrinputsubjectcount = NULL => '',
    addrinputsubjectcount = -1   => 'C12',
    addrinputsubjectcount <= 2.5 => '',
                                    'L79');

cja_bad_v3_aa_dist_13 := -0.130332494242588 - cja_bad_v3_v13_w;

cja_bad_v3_aa_code_13 := if(cja_bad_v3_aa_dist_13 = 0, '', cja_bad_v3_aa_code_13_1);

cja_bad_v3_v14_w := map(
    addrlastmovetaxratiodiff = NULL => 0,
    addrlastmovetaxratiodiff = -1   => -0.0855620038943135,
                                       0.0945258002235077);

cja_bad_v3_aa_code_14_1 := map(
    addrlastmovetaxratiodiff = NULL => '',
    addrlastmovetaxratiodiff = -1   => '',
                                       'C13');

cja_bad_v3_aa_dist_14 := 0.0945258002235077 - cja_bad_v3_v14_w;

cja_bad_v3_aa_code_14 := if(cja_bad_v3_aa_dist_14 = 0, '', cja_bad_v3_aa_code_14_1);

cja_bad_v3_rcvaluec14 := (integer)(cja_bad_v3_aa_code_01 = 'C14') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'C14') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'C14') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'C14') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'C14') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'C14') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'C14') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'C14') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'C14') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'C14') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'C14') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'C14') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'C14') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'C14') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluei60 := (integer)(cja_bad_v3_aa_code_01 = 'I60') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'I60') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'I60') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'I60') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'I60') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'I60') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'I60') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'I60') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'I60') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'I60') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'I60') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'I60') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'I60') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'I60') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea51 := (integer)(cja_bad_v3_aa_code_01 = 'A51') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A51') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A51') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A51') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A51') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A51') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A51') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A51') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A51') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A51') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A51') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A51') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A51') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A51') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea40 := (integer)(cja_bad_v3_aa_code_01 = 'A40') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A40') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A40') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A40') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A40') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A40') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A40') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A40') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A40') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A40') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A40') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A40') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A40') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A40') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea50 := (integer)(cja_bad_v3_aa_code_01 = 'A50') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A50') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A50') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A50') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A50') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A50') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A50') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A50') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A50') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A50') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A50') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A50') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A50') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A50') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea46 := (integer)(cja_bad_v3_aa_code_01 = 'A46') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A46') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A46') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A46') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A46') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A46') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A46') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A46') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A46') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A46') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A46') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A46') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A46') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A46') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea42 := (integer)(cja_bad_v3_aa_code_01 = 'A42') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A42') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A42') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A42') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A42') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A42') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A42') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A42') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A42') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A42') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A42') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A42') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A42') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A42') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluec10 := (integer)(cja_bad_v3_aa_code_01 = 'C10') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'C10') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'C10') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'C10') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'C10') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'C10') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'C10') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'C10') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'C10') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'C10') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'C10') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'C10') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'C10') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'C10') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluec12 := (integer)(cja_bad_v3_aa_code_01 = 'C12') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'C12') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'C12') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'C12') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'C12') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'C12') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'C12') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'C12') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'C12') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'C12') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'C12') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'C12') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'C12') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'C12') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluec13 := (integer)(cja_bad_v3_aa_code_01 = 'C13') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'C13') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'C13') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'C13') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'C13') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'C13') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'C13') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'C13') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'C13') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'C13') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'C13') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'C13') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'C13') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'C13') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvalued30 := (integer)(cja_bad_v3_aa_code_01 = 'D30') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'D30') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'D30') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'D30') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'D30') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'D30') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'D30') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'D30') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'D30') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'D30') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'D30') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'D30') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'D30') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'D30') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea41 := (integer)(cja_bad_v3_aa_code_01 = 'A41') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A41') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A41') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A41') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A41') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A41') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A41') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A41') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A41') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A41') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A41') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A41') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A41') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A41') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluel80 := (integer)(cja_bad_v3_aa_code_01 = 'L80') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'L80') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'L80') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'L80') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'L80') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'L80') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'L80') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'L80') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'L80') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'L80') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'L80') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'L80') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'L80') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'L80') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluef00 := (integer)(cja_bad_v3_aa_code_01 = 'F00') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'F00') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'F00') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'F00') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'F00') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'F00') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'F00') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'F00') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'F00') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'F00') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'F00') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'F00') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'F00') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'F00') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluel79 := (integer)(cja_bad_v3_aa_code_01 = 'L79') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'L79') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'L79') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'L79') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'L79') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'L79') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'L79') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'L79') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'L79') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'L79') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'L79') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'L79') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'L79') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'L79') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvaluea47 := (integer)(cja_bad_v3_aa_code_01 = 'A47') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'A47') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'A47') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'A47') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'A47') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'A47') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'A47') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'A47') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'A47') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'A47') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'A47') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'A47') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'A47') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'A47') * cja_bad_v3_aa_dist_14;

cja_bad_v3_rcvalued33 := (integer)(cja_bad_v3_aa_code_01 = 'D33') * cja_bad_v3_aa_dist_01 +
    (integer)(cja_bad_v3_aa_code_02 = 'D33') * cja_bad_v3_aa_dist_02 +
    (integer)(cja_bad_v3_aa_code_03 = 'D33') * cja_bad_v3_aa_dist_03 +
    (integer)(cja_bad_v3_aa_code_04 = 'D33') * cja_bad_v3_aa_dist_04 +
    (integer)(cja_bad_v3_aa_code_05 = 'D33') * cja_bad_v3_aa_dist_05 +
    (integer)(cja_bad_v3_aa_code_06 = 'D33') * cja_bad_v3_aa_dist_06 +
    (integer)(cja_bad_v3_aa_code_07 = 'D33') * cja_bad_v3_aa_dist_07 +
    (integer)(cja_bad_v3_aa_code_08 = 'D33') * cja_bad_v3_aa_dist_08 +
    (integer)(cja_bad_v3_aa_code_09 = 'D33') * cja_bad_v3_aa_dist_09 +
    (integer)(cja_bad_v3_aa_code_10 = 'D33') * cja_bad_v3_aa_dist_10 +
    (integer)(cja_bad_v3_aa_code_11 = 'D33') * cja_bad_v3_aa_dist_11 +
    (integer)(cja_bad_v3_aa_code_12 = 'D33') * cja_bad_v3_aa_dist_12 +
    (integer)(cja_bad_v3_aa_code_13 = 'D33') * cja_bad_v3_aa_dist_13 +
    (integer)(cja_bad_v3_aa_code_14 = 'D33') * cja_bad_v3_aa_dist_14;

cja_bad_v3_lgt := -0.677110789142109 +
    cja_bad_v3_V01_w +
    cja_bad_v3_V02_w +
    cja_bad_v3_V03_w +
    cja_bad_v3_V04_w +
    cja_bad_v3_V05_w +
    cja_bad_v3_V06_w +
    cja_bad_v3_V07_w +
    cja_bad_v3_V08_w +
    cja_bad_v3_V09_w +
    cja_bad_v3_V10_w +
    cja_bad_v3_V11_w +
    cja_bad_v3_V12_w +
    cja_bad_v3_V13_w +
    cja_bad_v3_V14_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_cja_bad_v3_1 := DATASET([
    {'C14', cja_bad_v3_rcvalueC14},
    {'I60', cja_bad_v3_rcvalueI60},
    {'A51', cja_bad_v3_rcvalueA51},
    {'A40', cja_bad_v3_rcvalueA40},
    {'A50', cja_bad_v3_rcvalueA50},
    {'A46', cja_bad_v3_rcvalueA46},
    {'A42', cja_bad_v3_rcvalueA42},
    {'C10', cja_bad_v3_rcvalueC10},
    {'C12', cja_bad_v3_rcvalueC12},
    {'C13', cja_bad_v3_rcvalueC13},
    {'D30', cja_bad_v3_rcvalueD30},
    {'A41', cja_bad_v3_rcvalueA41},
    {'L80', cja_bad_v3_rcvalueL80},
    {'F00', cja_bad_v3_rcvalueF00},
    {'L79', cja_bad_v3_rcvalueL79},
    {'A47', cja_bad_v3_rcvalueA47},
    {'D33', cja_bad_v3_rcvalueD33}
    ], ds_layout)(value < 0);
    
 rc_dataset_cja_bad_v3 := dataset([
        {cja_bad_v3_aa_code_07,cja_bad_v3_aa_dist_07}
        ],ds_layout)(value<0);

 rc_dataset_upd_1 := if( cja_bad_v3_aa_code_07 not in  
 [ '','C14','I60','A51','A40','A50','A46',
 'A42','C10','C12','C13','D30',
 'A41','L80','F00','L79','A47','D33'],
  rc_dataset_cja_bad_v3_1 + rc_dataset_cja_bad_v3,rc_dataset_cja_bad_v3_1);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_cja_bad_v3_sorted := sort(rc_dataset_upd_1, rc_dataset_upd_1.value);

r_rc1 := rc_dataset_cja_bad_v3_sorted[1].rc;
r_rc2 := rc_dataset_cja_bad_v3_sorted[2].rc;
r_rc3 := rc_dataset_cja_bad_v3_sorted[3].rc;
r_rc4 := rc_dataset_cja_bad_v3_sorted[4].rc;
r_rc5 := rc_dataset_cja_bad_v3_sorted[5].rc;
r_rc6 := rc_dataset_cja_bad_v3_sorted[6].rc;
r_rc7 := rc_dataset_cja_bad_v3_sorted[7].rc;
r_rc8 := rc_dataset_cja_bad_v3_sorted[8].rc;
r_rc9 := rc_dataset_cja_bad_v3_sorted[9].rc;
r_rc10 := rc_dataset_cja_bad_v3_sorted[10].rc;
r_rc11 := rc_dataset_cja_bad_v3_sorted[11].rc;
r_rc12 := rc_dataset_cja_bad_v3_sorted[12].rc;
r_rc13 := rc_dataset_cja_bad_v3_sorted[13].rc;
r_rc14 := rc_dataset_cja_bad_v3_sorted[14].rc;
r_rc15 := rc_dataset_cja_bad_v3_sorted[15].rc;
r_rc16 := rc_dataset_cja_bad_v3_sorted[16].rc;
r_rc17 := rc_dataset_cja_bad_v3_sorted[17].rc;


r_vl1 := rc_dataset_cja_bad_v3_sorted[1].value;
r_vl2 := rc_dataset_cja_bad_v3_sorted[2].value;
r_vl3 := rc_dataset_cja_bad_v3_sorted[3].value;
r_vl4 := rc_dataset_cja_bad_v3_sorted[4].value;
r_vl5 := rc_dataset_cja_bad_v3_sorted[5].value;
r_vl6 := rc_dataset_cja_bad_v3_sorted[6].value;
r_vl7 := rc_dataset_cja_bad_v3_sorted[7].value;
r_vl8 := rc_dataset_cja_bad_v3_sorted[8].value;
r_vl9 := rc_dataset_cja_bad_v3_sorted[9].value;
r_vl10 := rc_dataset_cja_bad_v3_sorted[10].value;
r_vl11 := rc_dataset_cja_bad_v3_sorted[11].value;
r_vl12 := rc_dataset_cja_bad_v3_sorted[12].value;
r_vl13 := rc_dataset_cja_bad_v3_sorted[13].value;
r_vl14 := rc_dataset_cja_bad_v3_sorted[14].value;
r_vl15 := rc_dataset_cja_bad_v3_sorted[15].value;
r_vl16 := rc_dataset_cja_bad_v3_sorted[16].value;
r_vl17 := rc_dataset_cja_bad_v3_sorted[17].value;
//*************************************************************************************//

rc1_2 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = 'I60' or r_rc2 = 'I60' or r_rc3 = 'I60' or r_rc4 = 'I60' or r_rc5 = 'I60' or r_rc6 = 'I60' or r_rc7 = 'I60' or r_rc8 = 'I60' or r_rc9 = 'I60' or r_rc10 = 'I60' or r_rc11 = 'I60' or r_rc12 = 'I60' or r_rc13 = 'I60' or r_rc14 = 'I60' or r_rc15 = 'I60' or r_rc16 = 'I60' or r_rc17 = 'I60', 'I60', '');

rc2_c46 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc3_c46 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc4_c46 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     '');

rc5_c46 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);

rc1_c46 := map(
    trim(rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

//rc1_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c46, rc1_2);
rc1_1 := if(rc1_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c46, rc1_2);

//rc2_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c46, rc2_2);

rc2_1 := if(rc2_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c46, rc2_2);

// rc3_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c46, rc3_2);
rc3_1 := if(rc3_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c46, rc3_2);


// rc4_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c46, rc4_2);

rc4_1 := if(rc4_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c46, rc4_2);

// rc5_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c46, '');
rc5_1 := if(rc5_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c46, '');

// rc1_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c46, rc1_2);
////rc1_1 := if(rc1_c46 != '' and not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c46, rc1_2);


base := 700;

pts := 40;

odds := 0.287 / (1 - .287);

rva1809_1_0 := map(
    confirmationsubjectfound < 1           => 222,
    SSNDeceased = 1 or SubjectDeceased = 1 => 200,
                                              min(if(max(round(-pts * (cja_bad_v3_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(-pts * (cja_bad_v3_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc4 := if(rva1809_1_0 >= 879 or rva1809_1_0 <= 500, '', rc4_1);

rc5 := if(rva1809_1_0 >= 879 or rva1809_1_0 <= 500, '', rc5_1);

rc1 := if(rva1809_1_0 >= 879 or rva1809_1_0 <= 500, '', rc1_1);

rc3 := if(rva1809_1_0 >= 879 or rva1809_1_0 <= 500, '', rc3_1);

rc2 := if(rva1809_1_0 >= 879 or rva1809_1_0 <= 500, '', rc2_1);




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
													rva1809_1_0 = 200 => DATASET([{'00'}], HRILayout),
													rva1809_1_0 = 222 => DATASET([{'00'}], HRILayout),
													rva1809_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
                    self.sysdate := sysdate;
                    self.addrchangecount60month          :=addrchangecount60month;  
                   self.subjectrecordtimeoldest         :=subjectrecordtimeoldest;
                   self.addrinputavmratio12monthprior   :=AddrInputAVMRatio12MonthPrior;
                   self.inquiryauto12month              :=inquiryauto12month;
                   self.evictioncount                   :=evictioncount;  
                   self.addronfilecount                 :=addronfilecount;
                   self.assetindex                      :=assetindex;
                   self.addrinputownershipindex         :=addrinputownershipindex;
                   self.subjectactivityindex03month     :=SubjectActivityIndex03Month;
                   self.addrinputavmratio60monthprior   :=addrinputavmratio60monthprior ;
                   self.confirmationinputdob            :=confirmationinputdob ;  
                   self.addrcurrentavmvalue             :=addrcurrentavmvalue;
                   self.addrinputsubjectcount           :=confirmationinputdob ; 
                   self.addrlastmovetaxratiodiff        :=confirmationinputdob ;
                   self.SSNDeceased                     :=ssndeceased;
                   self.SubjectDeceased                 :=SubjectDeceased ;
                   self.confirmationsubjectfound        :=confirmationsubjectfound; 
                   self.assetindexprimaryfactor         :=assetindexprimaryfactor; 
									 // self.evictioncount                    :=	evictioncount; 
                    self.assetreason                      := assetreason;
                    self.cja_bad_v3_v01_w                 := cja_bad_v3_v01_w;
                    self.cja_bad_v3_aa_dist_01            := cja_bad_v3_aa_dist_01;
                    self.cja_bad_v3_aa_code_01            := cja_bad_v3_aa_code_01;
                    self.cja_bad_v3_v02_w                 := cja_bad_v3_v02_w;
                    self.cja_bad_v3_aa_dist_02            := cja_bad_v3_aa_dist_02;
                    self.cja_bad_v3_aa_code_02            := cja_bad_v3_aa_code_02;
                    self.cja_bad_v3_v03_w                 := cja_bad_v3_v03_w;
                    self.cja_bad_v3_aa_dist_03            := cja_bad_v3_aa_dist_03;
                    self.cja_bad_v3_aa_code_03            := cja_bad_v3_aa_code_03;
                    self.cja_bad_v3_v04_w                 := cja_bad_v3_v04_w;
                    self.cja_bad_v3_aa_dist_04            := cja_bad_v3_aa_dist_04;
                    self.cja_bad_v3_aa_code_04            := cja_bad_v3_aa_code_04;
                    self.cja_bad_v3_v05_w                 := cja_bad_v3_v05_w;
                    self.cja_bad_v3_aa_dist_05            := cja_bad_v3_aa_dist_05;
                    self.cja_bad_v3_aa_code_05            := cja_bad_v3_aa_code_05;
                    self.cja_bad_v3_v06_w                 := cja_bad_v3_v06_w;
                    self.cja_bad_v3_aa_dist_06            := cja_bad_v3_aa_dist_06;
                    self.cja_bad_v3_aa_code_06            := cja_bad_v3_aa_code_06;
                    self.cja_bad_v3_v07_w                 := cja_bad_v3_v07_w;
                    self.cja_bad_v3_aa_dist_07            := cja_bad_v3_aa_dist_07;
                    self.cja_bad_v3_aa_code_07            := cja_bad_v3_aa_code_07;
                    self.cja_bad_v3_v08_w                 := cja_bad_v3_v08_w;
                    self.cja_bad_v3_aa_dist_08            := cja_bad_v3_aa_dist_08;
                    self.cja_bad_v3_aa_code_08            := cja_bad_v3_aa_code_08;
                    self.cja_bad_v3_v09_w                 := cja_bad_v3_v09_w;
                    self.cja_bad_v3_aa_dist_09            := cja_bad_v3_aa_dist_09;
                    self.cja_bad_v3_aa_code_09            := cja_bad_v3_aa_code_09;
                    self.cja_bad_v3_v10_w                 := cja_bad_v3_v10_w;
                    self.cja_bad_v3_aa_dist_10            := cja_bad_v3_aa_dist_10;
                    self.cja_bad_v3_aa_code_10            := cja_bad_v3_aa_code_10;
                    self.cja_bad_v3_v11_w                 := cja_bad_v3_v11_w;
                    self.cja_bad_v3_aa_dist_11            := cja_bad_v3_aa_dist_11;
                    self.cja_bad_v3_aa_code_11            := cja_bad_v3_aa_code_11;
                    self.cja_bad_v3_v12_w                 := cja_bad_v3_v12_w;
                    self.cja_bad_v3_aa_dist_12            := cja_bad_v3_aa_dist_12;
                    self.cja_bad_v3_aa_code_12            := cja_bad_v3_aa_code_12;
                    self.cja_bad_v3_v13_w                 := cja_bad_v3_v13_w;
                    self.cja_bad_v3_aa_dist_13            := cja_bad_v3_aa_dist_13;
                    self.cja_bad_v3_aa_code_13            := cja_bad_v3_aa_code_13;
                    self.cja_bad_v3_v14_w                 := cja_bad_v3_v14_w;
                    self.cja_bad_v3_aa_dist_14            := cja_bad_v3_aa_dist_14;
                    self.cja_bad_v3_aa_code_14            := cja_bad_v3_aa_code_14;
                    self.cja_bad_v3_rcvaluec14            := cja_bad_v3_rcvaluec14;
                    self.cja_bad_v3_rcvaluei60            := cja_bad_v3_rcvaluei60;
                    self.cja_bad_v3_rcvaluea51            := cja_bad_v3_rcvaluea51;
                    self.cja_bad_v3_rcvaluea40            := cja_bad_v3_rcvaluea40;
                    self.cja_bad_v3_rcvaluea50            := cja_bad_v3_rcvaluea50;
                    self.cja_bad_v3_rcvaluea46            := cja_bad_v3_rcvaluea46;
                    self.cja_bad_v3_rcvaluea42            := cja_bad_v3_rcvaluea42;
                    self.cja_bad_v3_rcvaluec10            := cja_bad_v3_rcvaluec10;
                    self.cja_bad_v3_rcvaluec12            := cja_bad_v3_rcvaluec12;
                    self.cja_bad_v3_rcvaluec13            := cja_bad_v3_rcvaluec13;
                    self.cja_bad_v3_rcvalued30            := cja_bad_v3_rcvalued30;
                    self.cja_bad_v3_rcvaluea41            := cja_bad_v3_rcvaluea41;
                    self.cja_bad_v3_rcvaluel80            := cja_bad_v3_rcvaluel80;
                    self.cja_bad_v3_rcvaluef00            := cja_bad_v3_rcvaluef00;
                    self.cja_bad_v3_rcvaluel79            := cja_bad_v3_rcvaluel79;
                    self.cja_bad_v3_rcvaluea47            := cja_bad_v3_rcvaluea47;
                    self.cja_bad_v3_rcvalued33            := cja_bad_v3_rcvalued33;
                    self.cja_bad_v3_lgt                   := cja_bad_v3_lgt;
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
                    self._rc_inq                          := _rc_inq;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rva1809_1_0                      := rva1809_1_0;
                    self.rc1                              := rc1;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc4                              := rc4;
                    self.rc5                              := rc5;



		SELF.clam := rt;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rva1809_1_0;
		SELF.seq := le.seq;
	#end
	END;

	
  model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));
	RETURN(model);
END;

