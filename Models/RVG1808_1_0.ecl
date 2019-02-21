IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVG1808_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION


	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	MODEL_DEBUG        := FALSE;
	// MODEL_DEBUG        := TRUE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
                    unsigned4 seq;            
                    integer sysdate                         ;// := sysdate;
                    string willingnessreason  ;//
                    string abilityreason;
                    real subjectwillingnessindex   ;//:= le.subjectwillingnessindex ;
                    string SubjectWillingnessPrimaryFactor  ;// :=  le.SubjectWillingnessPrimaryFactor;
                    real addronfilecount      ;
                    real subjectrecordtimeoldest    ;
                    real lienjudgmenttimenewest          ; 
                    real bankruptcystatus               ; 
                    real bankruptcycount                  ; 
                    real subjectabilityindex   ;//:=  le.subjectstabilityindex;
                    string SubjectabilityPrimaryFactor  ;//   :=  le.SubjectStabilityPrimaryFactor;
                    real assetpropcurrenttaxtotal ; 
                    real assetpropevercount    ;//:= le.assetpropevercount ;  
                    real addrcurrentavmvalue     ;    
                    real inquiryshortterm12month  ;// := le.inquiryshortterm12month ;
                    real inquiryauto12month  ;// := le.inquiryauto12month ;
                    real SSNDeceased      ;// :=  le.SSNDeceased;
                    real SubjectDeceased  ;// :=  le.SubjectDeceased;
                    real confirmationsubjectfound  ;// := le.confirmationsubjectfound ; 
                    real   onyx_rv5attr_lg_v01_w           ;// := onyx_rv5attr_lg_v01_w;
                    real   onyx_rv5attr_lg_aa_dist_01       ;//:= onyx_rv5attr_lg_aa_dist_01;
                    string   onyx_rv5attr_lg_aa_code_01      ;//:= onyx_rv5attr_lg_aa_code_01;
                    real   onyx_rv5attr_lg_v02_w           ;// := onyx_rv5attr_lg_v02_w;
                    real   onyx_rv5attr_lg_aa_dist_02       ;//:= onyx_rv5attr_lg_aa_dist_02;
                    string   onyx_rv5attr_lg_aa_code_02      ;// := onyx_rv5attr_lg_aa_code_02;
                    real   onyx_rv5attr_lg_v03_w            ;//:= onyx_rv5attr_lg_v03_w;
                    real   onyx_rv5attr_lg_aa_dist_03      ;// := onyx_rv5attr_lg_aa_dist_03;
                    string   onyx_rv5attr_lg_aa_code_03      ;// := onyx_rv5attr_lg_aa_code_03;
                    real   onyx_rv5attr_lg_v04_w            ;//:= onyx_rv5attr_lg_v04_w;
                    real   onyx_rv5attr_lg_aa_dist_04       ;//:= onyx_rv5attr_lg_aa_dist_04;
                    string   onyx_rv5attr_lg_aa_code_04       ;//:= onyx_rv5attr_lg_aa_code_04;
                    real   onyx_rv5attr_lg_v05_w            ;//:= onyx_rv5attr_lg_v05_w;
                    real   onyx_rv5attr_lg_aa_dist_05       ;//:= onyx_rv5attr_lg_aa_dist_05;
                    string   onyx_rv5attr_lg_aa_code_05      ;// := onyx_rv5attr_lg_aa_code_05;
                    real   onyx_rv5attr_lg_v06_w           ;// := onyx_rv5attr_lg_v06_w;
                    real   onyx_rv5attr_lg_aa_dist_06      ;// := onyx_rv5attr_lg_aa_dist_06;
                    string   onyx_rv5attr_lg_aa_code_06      ;// := onyx_rv5attr_lg_aa_code_06;
                    real   onyx_rv5attr_lg_v07_w            ;//:= onyx_rv5attr_lg_v07_w;
                    real   onyx_rv5attr_lg_aa_dist_07       ;//:= onyx_rv5attr_lg_aa_dist_07;
                    string   onyx_rv5attr_lg_aa_code_07       ;//:= onyx_rv5attr_lg_aa_code_07;
                    real   onyx_rv5attr_lg_v08_w           ;// := onyx_rv5attr_lg_v08_w;
                    real   onyx_rv5attr_lg_aa_dist_08      ;// := onyx_rv5attr_lg_aa_dist_08;
                    string   onyx_rv5attr_lg_aa_code_08       ;//:= onyx_rv5attr_lg_aa_code_08;
                    real   onyx_rv5attr_lg_v09_w           ;// := onyx_rv5attr_lg_v09_w;
                    real   onyx_rv5attr_lg_aa_dist_09      ;// := onyx_rv5attr_lg_aa_dist_09;
                    string   onyx_rv5attr_lg_aa_code_09      ;// := onyx_rv5attr_lg_aa_code_09;
                    real   onyx_rv5attr_lg_v10_w           ;// := onyx_rv5attr_lg_v10_w;
                    real   onyx_rv5attr_lg_aa_dist_10      ;// := onyx_rv5attr_lg_aa_dist_10;
                    string   onyx_rv5attr_lg_aa_code_10       ;//:= onyx_rv5attr_lg_aa_code_10;
                    real   onyx_rv5attr_lg_v11_w            ;//:= onyx_rv5attr_lg_v11_w;
                    real   onyx_rv5attr_lg_aa_dist_11       ;//:= onyx_rv5attr_lg_aa_dist_11;
                    string    onyx_rv5attr_lg_aa_code_11       ;       // onyx_rv5attr_lg_aa_code_11;	
                    real    onyx_rv5attr_lg_v12_w            ;       // onyx_rv5attr_lg_v12_w;	
                    real    onyx_rv5attr_lg_aa_dist_12       ;       // onyx_rv5attr_lg_aa_dist_12;	
                    string    onyx_rv5attr_lg_aa_code_12       ;       // onyx_rv5attr_lg_aa_code_12;	  
                    real    onyx_rv5attr_lg_rcvalued31        ;
                    real    onyx_rv5attr_lg_rcvalued34       ; 
                    real    onyx_rv5attr_lg_rcvaluec10       ;
                    real    onyx_rv5attr_lg_rcvaluea46       ;       // onyx_rv5attr_lg_rcvaluea46;	
                    real    onyx_rv5attr_lg_rcvaluea45       ; 
                    real    onyx_rv5attr_lg_rcvaluei60       ;
                    real    onyx_rv5attr_lg_rcvaluec14       ; 
                    real    onyx_rv5attr_lg_lgt              ;       // onyx_rv5attr_lg_lgt;	
                    string   r_rc1                            ;
                    string   r_rc2                           ;
                    string   r_rc3                            ;
                    string   r_rc4                            ;
                    string   r_rc5                            ;
                    string   r_rc6                            ;
                    string   r_rc7                           ;
                    string   r_rc8                            ;
                    string   r_rc9                            ;
                    string   r_rc10                          ;
                    string   r_rc11                           ;
                    string   r_rc12                          ;
                    string   r_rc13                           ;
                    string   r_rc14                           ;
                    string   r_rc15                          ;
                    string   r_rc16                           ;
                    string   r_rc17                           ;
                    string   r_rc18                           ;
                    real   r_vl1                            ;
                    real   r_vl2                            ;
                    real   r_vl3                            ;
                    real   r_vl4                            ;
                    real   r_vl5                           ;
                    real   r_vl6                            ;
                    real   r_vl7                            ;
                    real   r_vl8                            ;
                    real   r_vl9                           ;
                    real   r_vl10                           ;
                    real   r_vl11                           ;
                    real   r_vl12                           ;
                    real   r_vl13                           ;
                    real   r_vl14                           ;
                    real   r_vl15                           ;
                    real   r_vl16                           ;
                    real   r_vl17                           ;
                    real   r_vl18                           ; 
                    string    _rc_inq                          ;       // _rc_inq;	
                    Integer    base                             ;       // base;	
                    Integer    pts                              ;       // pts;	
                    real    odds                             ;       // odds;	
                    integer    rvg1808_1_0                      ;       // rvg1808_1_0;	
                    string    rc1                              ;       // rc1;	
                    string    rc3                              ;       // rc3;	
                    string    rc5                              ;       // rc5;	
                    string    rc2                              ;       // rc2;	
                    string    rc4                              ;       // rc4;	

			Risk_Indicators.Layout_Boca_Shell clam;
			
		END;
		
		// Layout_Debug doModel(clam le) := TRANSFORM
	// #else
		// Models.Layout_ModelOut doModel(clam le) := TRANSFORM
	// #end

		Layout_Debug doModel(attributes le, clam rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(attributes le, clam rt) := TRANSFORM
	#end


	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */

	
                  // SELF.seq     := le.seq;
	
		              // self.sysdate                          := sysdate;
                  inquiryshortterm12month   :=  (real)le.inquiryshortterm12month ;
                  subjectwillingnessindex   := (real)le.subjectwillingnessindex ;
                  SubjectWillingnessPrimaryFactor   :=  le.SubjectWillingnessPrimaryFactor;
                  subjectabilityindex   :=  (real)le.subjectabilityindex;
                  SubjectabilityPrimaryFactor     :=  le.SubjectabilityPrimaryFactor;
                  subjectrecordtimeoldest     :=  (real)le.subjectrecordtimeoldest;   
                  lienjudgmenttimenewest          :=  (real)le.lienjudgmenttimenewest; 
                  bankruptcystatus                :=  (real)le.bankruptcystatus; 
                  bankruptcycount                   :=  (real)le.bankruptcycount; 
                  addronfilecount       :=  (real)le.addronfilecount;
                  assetpropcurrenttaxtotal    := (real)le.assetpropcurrenttaxtotal ;
                  assetpropevercount                := (real)le.assetpropevercount ;  
                  addrcurrentavmvalue                := (real)le.addrcurrentavmvalue ;
                  inquiryauto12month                  := (real)le.inquiryauto12month ; 
                  SSNDeceased      :=  (real)le.SSNDeceased;
                  SubjectDeceased  :=  (real)le.SubjectDeceased;
                  confirmationsubjectfound := (real)le.confirmationsubjectfound;
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

//willingnessreason := if(not((SubjectWillingnessPrimaryFactor in ['-1', '0'])) and not(SubjectWillingnessPrimaryFactor = NULL), SubjectWillingnessPrimaryFactor, NULL);
willingnessreason := if(not((SubjectWillingnessPrimaryFactor in ['-1', '0'])) and not(SubjectWillingnessPrimaryFactor = ''), SubjectWillingnessPrimaryFactor, '');


//stabilityreason := if(not((SubjectAbilityPrimaryFactor in ['-1', '0'])) and not(SubjectAbilityPrimaryFactor = NULL), SubjectAbilityPrimaryFactor, NULL);
abilityreason := if(not((SubjectabilityPrimaryFactor in ['-1', '0'])) and not(SubjectabilityPrimaryFactor = ''), SubjectabilityPrimaryFactor, '');

onyx_rv5attr_lg_v01_w := map(
    inquiryshortterm12month = NULL => 0,
    inquiryshortterm12month = -1   => 0,
    inquiryshortterm12month <= 0.5 => -0.48588174236697,
                                      0.492781993375514);

onyx_rv5attr_lg_aa_code_01_1 := map(
    inquiryshortterm12month = NULL => '',
    inquiryshortterm12month = -1   => '',
    inquiryshortterm12month <= 0.5 => '',
                                      'I60');

onyx_rv5attr_lg_aa_dist_01 := -0.48588174236697 - onyx_rv5attr_lg_v01_w;

onyx_rv5attr_lg_aa_code_01 := if(onyx_rv5attr_lg_aa_dist_01 = 0, '', onyx_rv5attr_lg_aa_code_01_1);

onyx_rv5attr_lg_v02_w := map(
    subjectwillingnessindex = NULL => 0,
    subjectwillingnessindex = -1   => 0.0674094472712861,
    subjectwillingnessindex <= 1.5 => 0.389963802782054,
    subjectwillingnessindex <= 2.5 => 0.157967707876169,
    subjectwillingnessindex <= 4.5 => -0.028600879893781,
    subjectwillingnessindex <= 6.5 => -0.126775137080202,
                                      -0.233591501436918);

onyx_rv5attr_lg_aa_code_02_1 := map(
    subjectwillingnessindex = NULL => '',
    subjectwillingnessindex = -1   => '',
    subjectwillingnessindex <= 1.5 => willingnessreason,
    subjectwillingnessindex <= 2.5 => willingnessreason,
    subjectwillingnessindex <= 4.5 => willingnessreason,
    subjectwillingnessindex <= 6.5 => willingnessreason,
                                      '');

onyx_rv5attr_lg_aa_dist_02 := -0.233591501436918 - onyx_rv5attr_lg_v02_w;

//onyx_rv5attr_lg_aa_code_02 := if(onyx_rv5attr_lg_aa_dist_02 = 0, NULL, onyx_rv5attr_lg_aa_code_02_1);
onyx_rv5attr_lg_aa_code_02 := if(onyx_rv5attr_lg_aa_dist_02 = 0, '', onyx_rv5attr_lg_aa_code_02_1);



onyx_rv5attr_lg_v03_w := map(
    addronfilecount = NULL  => 0,
    addronfilecount = -1    => 0,
    addronfilecount <= 1.5  => -0.279178855051068,
    addronfilecount <= 2.5  => -0.209166133627853,
    addronfilecount <= 3.5  => -0.075190967560216,
    addronfilecount <= 4.5  => 0.0470075813228781,
    addronfilecount <= 5.5  => 0.11044679207802,
    addronfilecount <= 7.5  => 0.214568645901061,
    addronfilecount <= 11.5 => 0.333980822614526,
                               0.416337244997208);

onyx_rv5attr_lg_aa_code_03_1 := map(
    addronfilecount = NULL  => '',
    addronfilecount = -1    => '',
    addronfilecount <= 1.5  => 'C14',
    addronfilecount <= 2.5  => 'C14',
    addronfilecount <= 3.5  => 'C14',
    addronfilecount <= 4.5  => 'C14',
    addronfilecount <= 5.5  => 'C14',
    addronfilecount <= 7.5  => 'C14',
    addronfilecount <= 11.5 => 'C14',
                               'C14');

onyx_rv5attr_lg_aa_dist_03 := -0.279178855051068 - onyx_rv5attr_lg_v03_w;

onyx_rv5attr_lg_aa_code_03 := if(onyx_rv5attr_lg_aa_dist_03 = 0, '', onyx_rv5attr_lg_aa_code_03_1);

onyx_rv5attr_lg_v04_w := map(
    subjectrecordtimeoldest = NULL   => 0,
    subjectrecordtimeoldest = -1     => 0.0164869230105262,
    subjectrecordtimeoldest <= 214.5 => 0.282392834676748,
    subjectrecordtimeoldest <= 331.5 => 0.164906317717297,
    subjectrecordtimeoldest <= 355.5 => 0.0364141149736376,
    subjectrecordtimeoldest <= 360.5 => 0.0211218896795536,
    subjectrecordtimeoldest <= 420.5 => -0.0330794119850485,
                                        -0.304389948168032);

onyx_rv5attr_lg_aa_code_04_1 := map(
    subjectrecordtimeoldest = NULL   => '',
    subjectrecordtimeoldest = -1     => '',
    subjectrecordtimeoldest <= 214.5 => 'C10',
    subjectrecordtimeoldest <= 331.5 => 'C10',
    subjectrecordtimeoldest <= 355.5 => 'C10',
    subjectrecordtimeoldest <= 360.5 => 'C10',
    subjectrecordtimeoldest <= 420.5 => 'C10',
                                        '');

onyx_rv5attr_lg_aa_dist_04 := -0.304389948168032 - onyx_rv5attr_lg_v04_w;

onyx_rv5attr_lg_aa_code_04 := if(onyx_rv5attr_lg_aa_dist_04 = 0, '', onyx_rv5attr_lg_aa_code_04_1);

onyx_rv5attr_lg_v05_w := map(
    lienjudgmenttimenewest = NULL  => 0,
    lienjudgmenttimenewest = -1    => -0.161975376759887,
    lienjudgmenttimenewest <= 2.5  => 0.497741021750845,
    lienjudgmenttimenewest <= 6.5  => 0.318400476740216,
    lienjudgmenttimenewest <= 13.5 => 0.253839289371283,
    lienjudgmenttimenewest <= 62.5 => 0.197748522450687,
                                      -0.0163309774343569);

onyx_rv5attr_lg_aa_code_05 := map(
    lienjudgmenttimenewest = NULL  => '',
    lienjudgmenttimenewest = -1    => '',
    lienjudgmenttimenewest <= 2.5  => 'D34',
    lienjudgmenttimenewest <= 6.5  => 'D34',
    lienjudgmenttimenewest <= 13.5 => 'D34',
    lienjudgmenttimenewest <= 62.5 => 'D34',
                                      'D34');

onyx_rv5attr_lg_aa_dist_05 := -0.0163309774343569 - onyx_rv5attr_lg_v05_w;

onyx_rv5attr_lg_v06_w := map(
    bankruptcystatus = NULL => 0,
    bankruptcystatus = -1   => 0.455870186263531,
    bankruptcystatus <= 0.5 => -0.130529567993596,
    bankruptcystatus <= 1.5 => 0.0205866027831747,
                               0.557623311142949);

onyx_rv5attr_lg_aa_code_06_1 := map(
    bankruptcystatus = NULL => '',
    bankruptcystatus = -1   => '',
    bankruptcystatus <= 0.5 => '',
    bankruptcystatus <= 1.5 => 'D31',
                               'D31');

onyx_rv5attr_lg_aa_dist_06 := -0.130529567993596 - onyx_rv5attr_lg_v06_w;

onyx_rv5attr_lg_aa_code_06 := if(onyx_rv5attr_lg_aa_dist_06 = 0, '', onyx_rv5attr_lg_aa_code_06_1);

onyx_rv5attr_lg_v07_w := map(
    bankruptcycount = NULL => 0,
    bankruptcycount = -1   => 0,
    bankruptcycount <= 0.5 => -0.129798728976696,
    bankruptcycount <= 1.5 => 0.0985161365876992,
                              0.43893277287186);

onyx_rv5attr_lg_aa_code_07_1 := map(
    bankruptcycount = NULL => '',
    bankruptcycount = -1   => '',
    bankruptcycount <= 0.5 => '',
    bankruptcycount <= 1.5 => 'D31',
                              'D31');

onyx_rv5attr_lg_aa_dist_07 := -0.129798728976696 - onyx_rv5attr_lg_v07_w;

onyx_rv5attr_lg_aa_code_07 := if(onyx_rv5attr_lg_aa_dist_07 = 0, '', onyx_rv5attr_lg_aa_code_07_1);

onyx_rv5attr_lg_v08_w := map(
    subjectabilityindex = NULL => 0,
    subjectabilityindex = -1   => 0.0678392647574549,
    subjectabilityindex <= 2.5 => 0.152762456793729,
    subjectabilityindex <= 4.5 => 0.0348394743160066,
    subjectabilityindex <= 5.5 => -0.0696980332598707,
    subjectabilityindex <= 6.5 => -0.102301822775936,
                                  -0.114795385738996);

onyx_rv5attr_lg_aa_code_08_1 := map(
    subjectabilityindex = NULL => '',
    subjectabilityindex = -1   => '',
    subjectabilityindex <= 2.5 => abilityreason,
    subjectabilityindex <= 4.5 => abilityreason,
    subjectabilityindex <= 5.5 => abilityreason,
    subjectabilityindex <= 6.5 => abilityreason,
                                  '');

onyx_rv5attr_lg_aa_dist_08 := -0.114795385738996 - onyx_rv5attr_lg_v08_w;

onyx_rv5attr_lg_aa_code_08 := if(onyx_rv5attr_lg_aa_dist_08 = 0, '', onyx_rv5attr_lg_aa_code_08_1);

onyx_rv5attr_lg_v09_w := map(
    assetpropcurrenttaxtotal = NULL      => 0,
    assetpropcurrenttaxtotal = -1        => 0.0641587337177468,
    assetpropcurrenttaxtotal <= 0        => 0.157597769259414,
    assetpropcurrenttaxtotal <= 5330.5   => 0.184452396386902,
    assetpropcurrenttaxtotal <= 13182.5  => 0.109357527292289,
    assetpropcurrenttaxtotal <= 27666.5  => 0.0548058194909371,
    assetpropcurrenttaxtotal <= 74500.5  => -0.0444857398150792,
    assetpropcurrenttaxtotal <= 122317.5 => -0.105534825706219,
    assetpropcurrenttaxtotal <= 433303   => -0.146158207710886,
                                            -0.190369248854248);

onyx_rv5attr_lg_aa_code_09_1 := map(
    assetpropcurrenttaxtotal = NULL      => '',
    assetpropcurrenttaxtotal = -1        => '',
    assetpropcurrenttaxtotal <= 0        => 'A46',
    assetpropcurrenttaxtotal <= 5330.5   => 'A46',
    assetpropcurrenttaxtotal <= 13182.5  => 'A46',
    assetpropcurrenttaxtotal <= 27666.5  => 'A46',
    assetpropcurrenttaxtotal <= 74500.5  => 'A46',
    assetpropcurrenttaxtotal <= 122317.5 => 'A46',
    assetpropcurrenttaxtotal <= 433303   => 'A46',
                                            '');

onyx_rv5attr_lg_aa_dist_09 := -0.190369248854248 - onyx_rv5attr_lg_v09_w;

onyx_rv5attr_lg_aa_code_09 := if(onyx_rv5attr_lg_aa_dist_09 = 0, '', onyx_rv5attr_lg_aa_code_09_1);

onyx_rv5attr_lg_v10_w := map(
    assetpropevercount = NULL => 0,
    assetpropevercount = -1   => 0,
    assetpropevercount <= 0.5 => 0.116872517748325,
    assetpropevercount <= 1.5 => 0.0250780976205689,
    assetpropevercount <= 2.5 => -0.0489271654447092,
    assetpropevercount <= 3.5 => -0.0966277527677607,
    assetpropevercount <= 4.5 => -0.181318832386882,
    assetpropevercount <= 6.5 => -0.248191006442514,
                                 -0.347308135785836);

onyx_rv5attr_lg_aa_code_10_1 := map(
    assetpropevercount = NULL => '',
    assetpropevercount = -1   => '',
    assetpropevercount <= 0.5 => 'A45',
    assetpropevercount <= 1.5 => 'A45',
    assetpropevercount <= 2.5 => 'A45',
    assetpropevercount <= 3.5 => 'A45',
    assetpropevercount <= 4.5 => 'A45',
    assetpropevercount <= 6.5 => 'A45',
                                 '');

onyx_rv5attr_lg_aa_dist_10 := -0.347308135785836 - onyx_rv5attr_lg_v10_w;

onyx_rv5attr_lg_aa_code_10 := if(onyx_rv5attr_lg_aa_dist_10 = 0, '', onyx_rv5attr_lg_aa_code_10_1);

onyx_rv5attr_lg_v11_w := map(
    addrcurrentavmvalue = NULL      => 0,
    addrcurrentavmvalue = -1        => 0.0316761159060616,
    addrcurrentavmvalue <= 9879     => 0.720745371253566,
    addrcurrentavmvalue <= 15161.5  => 0.329728931077153,
    addrcurrentavmvalue <= 37657.5  => 0.158425326235111,
    addrcurrentavmvalue <= 78507.5  => 0.0623395993975059,
    addrcurrentavmvalue <= 142497.5 => 0.0152992957137237,
    addrcurrentavmvalue <= 182013.5 => -0.0378270306374896,
                                       -0.110195541629846);

onyx_rv5attr_lg_aa_code_11_1 := map(
    addrcurrentavmvalue = NULL      => '',
    addrcurrentavmvalue = -1        => '',
    addrcurrentavmvalue <= 9879     => 'A46',
    addrcurrentavmvalue <= 15161.5  => 'A46',
    addrcurrentavmvalue <= 37657.5  => 'A46',
    addrcurrentavmvalue <= 78507.5  => 'A46',
    addrcurrentavmvalue <= 142497.5 => 'A46',
    addrcurrentavmvalue <= 182013.5 => 'A46',
                                       '');

onyx_rv5attr_lg_aa_dist_11 := -0.110195541629846 - onyx_rv5attr_lg_v11_w;

onyx_rv5attr_lg_aa_code_11 := if(onyx_rv5attr_lg_aa_dist_11 = 0, '', onyx_rv5attr_lg_aa_code_11_1);

onyx_rv5attr_lg_v12_w := map(
    inquiryauto12month = NULL => 0,
    inquiryauto12month = -1   => 0,
    inquiryauto12month <= 0.5 => -0.0533260537429568,
                                 0.0600338698625145);

onyx_rv5attr_lg_aa_code_12_1 := map(
    inquiryauto12month = NULL => '',
    inquiryauto12month = -1   => '',
    inquiryauto12month <= 0.5 => '',
                                 'I60');

onyx_rv5attr_lg_aa_dist_12 := -0.0533260537429568 - onyx_rv5attr_lg_v12_w;

onyx_rv5attr_lg_aa_code_12 := if(onyx_rv5attr_lg_aa_dist_12 = 0, '', onyx_rv5attr_lg_aa_code_12_1);

onyx_rv5attr_lg_rcvalued31 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'D31') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'D31') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'D31') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'D31') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'D31') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'D31') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'D31') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'D31') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'D31') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'D31') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'D31') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'D31') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvalued34 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'D34') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'D34') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'D34') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'D34') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'D34') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'D34') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'D34') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'D34') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'D34') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'D34') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'D34') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'D34') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvaluec10 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'C10') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'C10') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'C10') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'C10') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'C10') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'C10') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'C10') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'C10') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'C10') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'C10') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'C10') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'C10') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvaluea46 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'A46') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'A46') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'A46') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'A46') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'A46') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'A46') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'A46') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'A46') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'A46') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'A46') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'A46') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'A46') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvaluea45 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'A45') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'A45') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'A45') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'A45') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'A45') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'A45') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'A45') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'A45') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'A45') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'A45') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'A45') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'A45') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvaluei60 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'I60') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'I60') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'I60') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'I60') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'I60') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'I60') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'I60') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'I60') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'I60') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'I60') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'I60') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'I60') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_rcvaluec14 := (integer)(onyx_rv5attr_lg_aa_code_01 = 'C14') * onyx_rv5attr_lg_aa_dist_01 +
    (integer)(onyx_rv5attr_lg_aa_code_02 = 'C14') * onyx_rv5attr_lg_aa_dist_02 +
    (integer)(onyx_rv5attr_lg_aa_code_03 = 'C14') * onyx_rv5attr_lg_aa_dist_03 +
    (integer)(onyx_rv5attr_lg_aa_code_04 = 'C14') * onyx_rv5attr_lg_aa_dist_04 +
    (integer)(onyx_rv5attr_lg_aa_code_05 = 'C14') * onyx_rv5attr_lg_aa_dist_05 +
    (integer)(onyx_rv5attr_lg_aa_code_06 = 'C14') * onyx_rv5attr_lg_aa_dist_06 +
    (integer)(onyx_rv5attr_lg_aa_code_07 = 'C14') * onyx_rv5attr_lg_aa_dist_07 +
    (integer)(onyx_rv5attr_lg_aa_code_08 = 'C14') * onyx_rv5attr_lg_aa_dist_08 +
    (integer)(onyx_rv5attr_lg_aa_code_09 = 'C14') * onyx_rv5attr_lg_aa_dist_09 +
    (integer)(onyx_rv5attr_lg_aa_code_10 = 'C14') * onyx_rv5attr_lg_aa_dist_10 +
    (integer)(onyx_rv5attr_lg_aa_code_11 = 'C14') * onyx_rv5attr_lg_aa_dist_11 +
    (integer)(onyx_rv5attr_lg_aa_code_12 = 'C14') * onyx_rv5attr_lg_aa_dist_12;

onyx_rv5attr_lg_lgt := -1.27661189916796 +
    onyx_rv5attr_lg_V01_w +
    onyx_rv5attr_lg_V02_w +
    onyx_rv5attr_lg_V03_w +
    onyx_rv5attr_lg_V04_w +
    onyx_rv5attr_lg_V05_w +
    onyx_rv5attr_lg_V06_w +
    onyx_rv5attr_lg_V07_w +
    onyx_rv5attr_lg_V08_w +
    onyx_rv5attr_lg_V09_w +
    onyx_rv5attr_lg_V10_w +
    onyx_rv5attr_lg_V11_w +
    onyx_rv5attr_lg_V12_w;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

//*************************************************************************************//
rc_dataset_onyx_rv5attr_lg_1 := DATASET([
    {'D31', onyx_rv5attr_lg_rcvalueD31},
    {'D34', onyx_rv5attr_lg_rcvalueD34},
    {'C10', onyx_rv5attr_lg_rcvalueC10},
    {'A46', onyx_rv5attr_lg_rcvalueA46},
    {'A45', onyx_rv5attr_lg_rcvalueA45},
    {'I60', onyx_rv5attr_lg_rcvalueI60},
    {'C14', onyx_rv5attr_lg_rcvalueC14}
    ], ds_layout)(value < 0);

rc_dataset_onyx_rv5attr_lg_2 := DATASET([
    {onyx_rv5attr_lg_aa_code_02,onyx_rv5attr_lg_aa_dist_02}
    ], ds_layout)(value < 0);

rc_dataset_upd_1 := if (onyx_rv5attr_lg_aa_code_02 not in 
                  ['','D31','D34', 'C10', 'A46', 
                   'A45', 'I60', 'C14'],
                  rc_dataset_onyx_rv5attr_lg_1 + rc_dataset_onyx_rv5attr_lg_2,rc_dataset_onyx_rv5attr_lg_1 );

rc_dataset_onyx_rv5attr_lg_3 := DATASET([
    {onyx_rv5attr_lg_aa_code_08,onyx_rv5attr_lg_aa_dist_08}
    ], ds_layout)(value < 0);


rc_dataset_onyx_rv5attr_lg := if (onyx_rv5attr_lg_aa_code_08 not in 
                  ['','D31','D34', 'C10', 'A46', 
                   'A45', 'I60', 'C14'],
                  rc_dataset_upd_1 + rc_dataset_onyx_rv5attr_lg_3,rc_dataset_upd_1 );






//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_onyx_rv5attr_lg_sorted := sort(rc_dataset_onyx_rv5attr_lg, rc_dataset_onyx_rv5attr_lg.value);

r_rc1 := rc_dataset_onyx_rv5attr_lg_sorted[1].rc;
r_rc2 := rc_dataset_onyx_rv5attr_lg_sorted[2].rc;
r_rc3 := rc_dataset_onyx_rv5attr_lg_sorted[3].rc;
r_rc4 := rc_dataset_onyx_rv5attr_lg_sorted[4].rc;
r_rc5 := rc_dataset_onyx_rv5attr_lg_sorted[5].rc;
r_rc6 := rc_dataset_onyx_rv5attr_lg_sorted[6].rc;
r_rc7 := rc_dataset_onyx_rv5attr_lg_sorted[7].rc;
r_rc8 := rc_dataset_onyx_rv5attr_lg_sorted[8].rc;
r_rc9 := rc_dataset_onyx_rv5attr_lg_sorted[9].rc;
r_rc10 := rc_dataset_onyx_rv5attr_lg_sorted[10].rc;
r_rc11 := rc_dataset_onyx_rv5attr_lg_sorted[11].rc;
r_rc12 := rc_dataset_onyx_rv5attr_lg_sorted[12].rc;
r_rc13 := rc_dataset_onyx_rv5attr_lg_sorted[13].rc;
r_rc14 := rc_dataset_onyx_rv5attr_lg_sorted[14].rc;
r_rc15 := rc_dataset_onyx_rv5attr_lg_sorted[15].rc;
r_rc16 := rc_dataset_onyx_rv5attr_lg_sorted[16].rc;
r_rc17 := rc_dataset_onyx_rv5attr_lg_sorted[17].rc;
r_rc18 := rc_dataset_onyx_rv5attr_lg_sorted[18].rc;


r_vl1 := rc_dataset_onyx_rv5attr_lg_sorted[1].value;
r_vl2 := rc_dataset_onyx_rv5attr_lg_sorted[2].value;
r_vl3 := rc_dataset_onyx_rv5attr_lg_sorted[3].value;
r_vl4 := rc_dataset_onyx_rv5attr_lg_sorted[4].value;
r_vl5 := rc_dataset_onyx_rv5attr_lg_sorted[5].value;
r_vl6 := rc_dataset_onyx_rv5attr_lg_sorted[6].value;
r_vl7 := rc_dataset_onyx_rv5attr_lg_sorted[7].value;
r_vl8 := rc_dataset_onyx_rv5attr_lg_sorted[8].value;
r_vl9 := rc_dataset_onyx_rv5attr_lg_sorted[9].value;
r_vl10 := rc_dataset_onyx_rv5attr_lg_sorted[10].value;
r_vl11 := rc_dataset_onyx_rv5attr_lg_sorted[11].value;
r_vl12 := rc_dataset_onyx_rv5attr_lg_sorted[12].value;
r_vl13 := rc_dataset_onyx_rv5attr_lg_sorted[13].value;
r_vl14 := rc_dataset_onyx_rv5attr_lg_sorted[14].value;
r_vl15 := rc_dataset_onyx_rv5attr_lg_sorted[15].value;
r_vl16 := rc_dataset_onyx_rv5attr_lg_sorted[16].value;
r_vl17 := rc_dataset_onyx_rv5attr_lg_sorted[17].value;
r_vl18 := rc_dataset_onyx_rv5attr_lg_sorted[18].value;
//*************************************************************************************//

rc1_3 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = 'I60' or r_rc2 = 'I60' or r_rc3 = 'I60' or r_rc4 = 'I60' or r_rc5 = 'I60' or r_rc6 = 'I60' or r_rc7 = 'I60', 'I60', '');

rc4_c40 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                     '');

rc1_c40 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc5_c40 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     _rc_inq);

rc2_c40 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc3_2, LEFT, RIGHT) = '' => '',
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc3_c40 := map(
    trim(rc1_3, LEFT, RIGHT) = '' => '',
    trim(rc2_2, LEFT, RIGHT) = '' => '',
    trim(rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim(rc4_2, LEFT, RIGHT) = '' => '',
                                     '');

rc5_1 := if(rc5_c40 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c40, '');

rc3_1 := if(rc3_c40 != '' and  not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c40, rc3_2);

rc2_1 := if(rc2_c40 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c40, rc2_2);

rc4_1 := if(rc4_c40 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c40, rc4_2);

rc1_2 := if(rc1_c40 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c40, rc1_3);

base := 700;

pts := -40;

odds := 0.15182325106862;

rvg1808_1_0 := map(
    confirmationsubjectfound < 1           => 222,
    SSNDeceased = 1 or SubjectDeceased = 1 => 200,
                                              min(if(max(round(pts * (onyx_rv5attr_lg_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (onyx_rv5attr_lg_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc1_1 := if(500 < rvg1808_1_0 AND rvg1808_1_0 < 812 and rc1_2 = '', 'C12', rc1_2);

rc3 := if(rvg1808_1_0 >= 812 or rvg1808_1_0 <= 500, '', rc3_1);

rc2 := if(rvg1808_1_0 >= 812 or rvg1808_1_0 <= 500, '', rc2_1);

rc5 := if(rvg1808_1_0 >= 812 or rvg1808_1_0 <= 500, '', rc5_1);

rc1 := if(rvg1808_1_0 >= 812 or rvg1808_1_0 <= 500, '', rc1_1);

rc4 := if(rvg1808_1_0 >= 812 or rvg1808_1_0 <= 500, '', rc4_1);


	//*************************************************************************************//
	//                     RiskView Version 5 - RVT1608_2 Score Overrides
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
													rvg1808_1_0 = 200 => DATASET([{'00'}], HRILayout),
													rvg1808_1_0 = 222 => DATASET([{'00'}], HRILayout),
													rvg1808_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
                    self.abilityreason                  := abilityreason;
                    
                  self.subjectwillingnessindex   := subjectwillingnessindex ;
                  self.SubjectWillingnessPrimaryFactor   :=  SubjectWillingnessPrimaryFactor;
                  self.subjectabilityindex   :=  subjectabilityindex;
                  self.SubjectabilityPrimaryFactor     :=  SubjectabilityPrimaryFactor;
                  self.subjectrecordtimeoldest     :=  subjectrecordtimeoldest;   
                  self.lienjudgmenttimenewest          :=  lienjudgmenttimenewest; 
                  self.bankruptcystatus                :=  bankruptcystatus; 
                  self.bankruptcycount                   :=  bankruptcycount; 
                  
                  self.inquiryshortterm12month   := inquiryshortterm12month ;
                  self.addronfilecount       :=  addronfilecount;
                  self.assetpropcurrenttaxtotal    := assetpropcurrenttaxtotal ;
                  self.assetpropevercount                := assetpropevercount ;  
                  self.addrcurrentavmvalue                := addrcurrentavmvalue ;
                  self.inquiryauto12month                  := inquiryauto12month ; 
                  
                  
                  self.SSNDeceased      :=  SSNDeceased;
                  self.SubjectDeceased  :=  SubjectDeceased;
                  self.confirmationsubjectfound :=  confirmationsubjectfound;
                    
                    
                    self.onyx_rv5attr_lg_v01_w            := onyx_rv5attr_lg_v01_w;
                    self.onyx_rv5attr_lg_aa_dist_01       := onyx_rv5attr_lg_aa_dist_01;
                    self.onyx_rv5attr_lg_aa_code_01       := onyx_rv5attr_lg_aa_code_01;
                    self.onyx_rv5attr_lg_v02_w            := onyx_rv5attr_lg_v02_w;
                    self.onyx_rv5attr_lg_aa_dist_02       := onyx_rv5attr_lg_aa_dist_02;
                    self.onyx_rv5attr_lg_aa_code_02       := onyx_rv5attr_lg_aa_code_02;
                    self.onyx_rv5attr_lg_v03_w            := onyx_rv5attr_lg_v03_w;
                    self.onyx_rv5attr_lg_aa_dist_03       := onyx_rv5attr_lg_aa_dist_03;
                    self.onyx_rv5attr_lg_aa_code_03       := onyx_rv5attr_lg_aa_code_03;
                    self.onyx_rv5attr_lg_v04_w            := onyx_rv5attr_lg_v04_w;
                    self.onyx_rv5attr_lg_aa_dist_04       := onyx_rv5attr_lg_aa_dist_04;
                    self.onyx_rv5attr_lg_aa_code_04       := onyx_rv5attr_lg_aa_code_04;
                    self.onyx_rv5attr_lg_v05_w            := onyx_rv5attr_lg_v05_w;
                    self.onyx_rv5attr_lg_aa_code_05       := onyx_rv5attr_lg_aa_code_05;
                    self.onyx_rv5attr_lg_aa_dist_05       := onyx_rv5attr_lg_aa_dist_05;
                    self.onyx_rv5attr_lg_v06_w            := onyx_rv5attr_lg_v06_w;
                    self.onyx_rv5attr_lg_aa_dist_06       := onyx_rv5attr_lg_aa_dist_06;
                    self.onyx_rv5attr_lg_aa_code_06       := onyx_rv5attr_lg_aa_code_06;
                    self.onyx_rv5attr_lg_v07_w            := onyx_rv5attr_lg_v07_w;
                    self.onyx_rv5attr_lg_aa_dist_07       := onyx_rv5attr_lg_aa_dist_07;
                    self.onyx_rv5attr_lg_aa_code_07       := onyx_rv5attr_lg_aa_code_07;
                    self.onyx_rv5attr_lg_v08_w            := onyx_rv5attr_lg_v08_w;
                    self.onyx_rv5attr_lg_aa_dist_08       := onyx_rv5attr_lg_aa_dist_08;
                    self.onyx_rv5attr_lg_aa_code_08       := onyx_rv5attr_lg_aa_code_08;
                    self.onyx_rv5attr_lg_v09_w            := onyx_rv5attr_lg_v09_w;
                    self.onyx_rv5attr_lg_aa_dist_09       := onyx_rv5attr_lg_aa_dist_09;
                    self.onyx_rv5attr_lg_aa_code_09       := onyx_rv5attr_lg_aa_code_09;
                    self.onyx_rv5attr_lg_v10_w            := onyx_rv5attr_lg_v10_w;
                    self.onyx_rv5attr_lg_aa_dist_10       := onyx_rv5attr_lg_aa_dist_10;
                    self.onyx_rv5attr_lg_aa_code_10       := onyx_rv5attr_lg_aa_code_10;
                    self.onyx_rv5attr_lg_v11_w            := onyx_rv5attr_lg_v11_w;
                    self.onyx_rv5attr_lg_aa_dist_11       := onyx_rv5attr_lg_aa_dist_11;
                    self.onyx_rv5attr_lg_aa_code_11       := onyx_rv5attr_lg_aa_code_11;
                    self.onyx_rv5attr_lg_v12_w            := onyx_rv5attr_lg_v12_w;
                    self.onyx_rv5attr_lg_aa_dist_12       := onyx_rv5attr_lg_aa_dist_12;
                    self.onyx_rv5attr_lg_aa_code_12       := onyx_rv5attr_lg_aa_code_12;
                    self.onyx_rv5attr_lg_rcvalued31       := onyx_rv5attr_lg_rcvalued31;
                    self.onyx_rv5attr_lg_rcvalued34       := onyx_rv5attr_lg_rcvalued34;
                    self.onyx_rv5attr_lg_rcvaluec10       := onyx_rv5attr_lg_rcvaluec10;
                    self.onyx_rv5attr_lg_rcvaluea46       := onyx_rv5attr_lg_rcvaluea46;
                    self.onyx_rv5attr_lg_rcvaluea45       := onyx_rv5attr_lg_rcvaluea45;
                    self.onyx_rv5attr_lg_rcvaluei60       := onyx_rv5attr_lg_rcvaluei60;
                    self.onyx_rv5attr_lg_rcvaluec14       := onyx_rv5attr_lg_rcvaluec14;
                    self.onyx_rv5attr_lg_lgt              := onyx_rv5attr_lg_lgt;
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
                    self.r_rc18                           := r_rc18;
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
                    self.r_vl18                           := r_vl18;
                    self._rc_inq                          := _rc_inq;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvg1808_1_0                      := rvg1808_1_0;
                    self.rc1                              := rc1;
                    self.rc3                              := rc3;
                    self.rc5                              := rc5;
                    self.rc2                              := rc2;
                    self.rc4                              := rc4;

		SELF.clam := rt;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1808_1_0;
		SELF.seq := le.seq;
	#end
	END;

	
  model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));
	RETURN(model);
END;

