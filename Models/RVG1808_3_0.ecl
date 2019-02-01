IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std,riskview;

EXPORT RVG1808_3_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION


	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	MODEL_DEBUG        := FALSE;
	// MODEL_DEBUG        := TRUE;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
                    unsigned4 seq;
                   // string firstname; string lastname; string ssn;
			
                    integer sysdate                         ;// := sysdate;
                   string willingnessreason  ;//
                   string stabilityreason;
                   real subjectwillingnessindex   ;//:= le.subjectwillingnessindex ;
                   string SubjectWillingnessPrimaryFactor  ;// :=  le.SubjectWillingnessPrimaryFactor;
                   real subjectstabilityindex   ;//:=  le.subjectstabilityindex;
                   string SubjectStabilityPrimaryFactor  ;//   :=  le.SubjectStabilityPrimaryFactor;
                   real subjectrecordtimeoldest    ;// :=  le.subjectrecordtimeoldest;   
                   real criminalfelonycount     ;// :=  le.criminalfelonycount;   
                   real inquiryshortterm12month  ;// := le.inquiryshortterm12month ;
                   real addronfilecount      ;// :=  le.addronfilecount;
                   real evictioncount        ;// :=  le.evictioncount;
                   real assetpropevercount    ;//:= le.assetpropevercount ;  
                   real inquirytelcom12month   ;//:= le.inquirytelcom12month ; 
                   real criminalnonfelonycount    ;// := le.criminalnonfelonycount ; 
                   real assetpropcurrenttaxtotal    ;//:= le.assetpropcurrenttaxtotal ;
                   real subjectactivityindex12month   ;//:= le.subjectactivityindex12month ;
                   real addrprevioustimeoldest    ;//:=  le.addrprevioustimeoldest;
                   real inquirybanking12month    ;// :=  le.inquirybanking12month;
                   real addrlastmoveecontrajectoryindex ;//  := le.addrlastmoveecontrajectoryindex ;   
                   real addrinputsubjectowned   ;//:=  le.addrinputsubjectowned;
                   real businessassociation    ;// :=  le.businessassociation;
                   real SSNDeceased      ;// :=  le.SSNDeceased;
                   real SubjectDeceased  ;// :=  le.SubjectDeceased;
                   real confirmationsubjectfound  ;// := le.confirmationsubjectfound ; 
                    
                    real   onyx_rv5attr_nc_v01_w           ;// := onyx_rv5attr_nc_v01_w;
                    real   onyx_rv5attr_nc_aa_dist_01       ;//:= onyx_rv5attr_nc_aa_dist_01;
                    string   onyx_rv5attr_nc_aa_code_01      ;//:= onyx_rv5attr_nc_aa_code_01;
                    real   onyx_rv5attr_nc_v02_w           ;// := onyx_rv5attr_nc_v02_w;
                    real   onyx_rv5attr_nc_aa_dist_02       ;//:= onyx_rv5attr_nc_aa_dist_02;
                    string   onyx_rv5attr_nc_aa_code_02      ;// := onyx_rv5attr_nc_aa_code_02;
                    real   onyx_rv5attr_nc_v03_w            ;//:= onyx_rv5attr_nc_v03_w;
                    real   onyx_rv5attr_nc_aa_dist_03      ;// := onyx_rv5attr_nc_aa_dist_03;
                    string   onyx_rv5attr_nc_aa_code_03      ;// := onyx_rv5attr_nc_aa_code_03;
                    real   onyx_rv5attr_nc_v04_w            ;//:= onyx_rv5attr_nc_v04_w;
                    real   onyx_rv5attr_nc_aa_dist_04       ;//:= onyx_rv5attr_nc_aa_dist_04;
                    string   onyx_rv5attr_nc_aa_code_04       ;//:= onyx_rv5attr_nc_aa_code_04;
                    real   onyx_rv5attr_nc_v05_w            ;//:= onyx_rv5attr_nc_v05_w;
                    real   onyx_rv5attr_nc_aa_dist_05       ;//:= onyx_rv5attr_nc_aa_dist_05;
                    string   onyx_rv5attr_nc_aa_code_05      ;// := onyx_rv5attr_nc_aa_code_05;
                    real   onyx_rv5attr_nc_v06_w           ;// := onyx_rv5attr_nc_v06_w;
                    real   onyx_rv5attr_nc_aa_dist_06      ;// := onyx_rv5attr_nc_aa_dist_06;
                    string   onyx_rv5attr_nc_aa_code_06      ;// := onyx_rv5attr_nc_aa_code_06;
                    real   onyx_rv5attr_nc_v07_w            ;//:= onyx_rv5attr_nc_v07_w;
                    real   onyx_rv5attr_nc_aa_dist_07       ;//:= onyx_rv5attr_nc_aa_dist_07;
                    string   onyx_rv5attr_nc_aa_code_07       ;//:= onyx_rv5attr_nc_aa_code_07;
                    real   onyx_rv5attr_nc_v08_w           ;// := onyx_rv5attr_nc_v08_w;
                    real   onyx_rv5attr_nc_aa_dist_08      ;// := onyx_rv5attr_nc_aa_dist_08;
                    string   onyx_rv5attr_nc_aa_code_08       ;//:= onyx_rv5attr_nc_aa_code_08;
                    real   onyx_rv5attr_nc_v09_w           ;// := onyx_rv5attr_nc_v09_w;
                    real   onyx_rv5attr_nc_aa_dist_09      ;// := onyx_rv5attr_nc_aa_dist_09;
                    string   onyx_rv5attr_nc_aa_code_09      ;// := onyx_rv5attr_nc_aa_code_09;
                    real   onyx_rv5attr_nc_v10_w           ;// := onyx_rv5attr_nc_v10_w;
                    real   onyx_rv5attr_nc_aa_dist_10      ;// := onyx_rv5attr_nc_aa_dist_10;
                    string   onyx_rv5attr_nc_aa_code_10       ;//:= onyx_rv5attr_nc_aa_code_10;
                    real   onyx_rv5attr_nc_v11_w            ;//:= onyx_rv5attr_nc_v11_w;
                    real   onyx_rv5attr_nc_aa_dist_11       ;//:= onyx_rv5attr_nc_aa_dist_11;
                    
                    string    onyx_rv5attr_nc_aa_code_11       ;       // onyx_rv5attr_nc_aa_code_11;	
                    real    onyx_rv5attr_nc_v12_w            ;       // onyx_rv5attr_nc_v12_w;	
                    real    onyx_rv5attr_nc_aa_dist_12       ;       // onyx_rv5attr_nc_aa_dist_12;	
                    string    onyx_rv5attr_nc_aa_code_12       ;       // onyx_rv5attr_nc_aa_code_12;	
                    real    onyx_rv5attr_nc_v13_w            ;       // onyx_rv5attr_nc_v13_w;	
                    real    onyx_rv5attr_nc_aa_dist_13       ;       // onyx_rv5attr_nc_aa_dist_13;	
                    string    onyx_rv5attr_nc_aa_code_13       ;       // onyx_rv5attr_nc_aa_code_13;	
                    real    onyx_rv5attr_nc_v14_w            ;       // onyx_rv5attr_nc_v14_w;	
                    real    onyx_rv5attr_nc_aa_dist_14       ;       // onyx_rv5attr_nc_aa_dist_14;	
                    string    onyx_rv5attr_nc_aa_code_14       ;       // onyx_rv5attr_nc_aa_code_14;	
                    real    onyx_rv5attr_nc_v15_w            ;       // onyx_rv5attr_nc_v15_w;	
                    real    onyx_rv5attr_nc_aa_dist_15       ;       // onyx_rv5attr_nc_aa_dist_15;	
                    string    onyx_rv5attr_nc_aa_code_15       ;       // onyx_rv5attr_nc_aa_code_15;	
                    real    onyx_rv5attr_nc_v16_w            ;       // onyx_rv5attr_nc_v16_w;	
                    real    onyx_rv5attr_nc_aa_dist_16       ;       // onyx_rv5attr_nc_aa_dist_16;	
                    string    onyx_rv5attr_nc_aa_code_16       ;       // onyx_rv5attr_nc_aa_code_16;	
                    real    onyx_rv5attr_nc_v17_w            ;       // onyx_rv5attr_nc_v17_w;	
                    real    onyx_rv5attr_nc_aa_dist_17       ;       // onyx_rv5attr_nc_aa_dist_17;	
                    string    onyx_rv5attr_nc_aa_code_17       ;       // onyx_rv5attr_nc_aa_code_17;	
                    real    onyx_rv5attr_nc_rcvaluea46       ;       // onyx_rv5attr_nc_rcvaluea46;	
                    real    onyx_rv5attr_nc_rcvaluec10       ;       // onyx_rv5attr_nc_rcvaluec10;	
                    real    onyx_rv5attr_nc_rcvaluec12       ;       // onyx_rv5attr_nc_rcvaluec12;	
                    real    onyx_rv5attr_nc_rcvalued32       ;       // onyx_rv5attr_nc_rcvalued32;	
                    real    onyx_rv5attr_nc_rcvaluea45       ;       // onyx_rv5attr_nc_rcvaluea45;	
                    real    onyx_rv5attr_nc_rcvaluec13       ;       // onyx_rv5attr_nc_rcvaluec13;	
                    real    onyx_rv5attr_nc_rcvalued30       ;       // onyx_rv5attr_nc_rcvalued30;	
                    real    onyx_rv5attr_nc_rcvaluei60       ;       // onyx_rv5attr_nc_rcvaluei60;	
                    real    onyx_rv5attr_nc_rcvalued33       ;       // onyx_rv5attr_nc_rcvalued33;	
                    real    onyx_rv5attr_nc_rcvaluea44       ;       // onyx_rv5attr_nc_rcvaluea44;	
                    real    onyx_rv5attr_nc_rcvaluec14       ;       // onyx_rv5attr_nc_rcvaluec14;	
                    real    onyx_rv5attr_nc_lgt              ;       // onyx_rv5attr_nc_lgt;	
                    string    _rc_inq                          ;       // _rc_inq;	
                    Integer    base                             ;       // base;	
                    Integer    pts                              ;       // pts;	
                    real    odds                             ;       // odds;	
                    integer    rvg1808_3_0                      ;       // rvg1808_3_0;	
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
	// seq                              := le.seq;
	// ssn := le.shell_input.ssn;
	// firstname := le.shell_input.fname;
	// lastname := le.shell_input.lname;
	
subjectwillingnessindex   := (real)le.subjectwillingnessindex ;
SubjectWillingnessPrimaryFactor   :=  le.SubjectWillingnessPrimaryFactor;
subjectstabilityindex   :=  (real)le.subjectstabilityindex;
SubjectStabilityPrimaryFactor     :=  le.SubjectStabilityPrimaryFactor;
subjectrecordtimeoldest     :=  (real) le.subjectrecordtimeoldest;   
criminalfelonycount      :=  (real)le.criminalfelonycount;   
inquiryshortterm12month   := (real)le.inquiryshortterm12month ;
addronfilecount       :=  (real)le.addronfilecount;
evictioncount         :=  (real)le.evictioncount;
assetpropevercount    := (real)le.assetpropevercount ;  
inquirytelcom12month   := (real)le.inquirytelcom12month ; 
criminalnonfelonycount     := (real)le.criminalnonfelonycount ; 
assetpropcurrenttaxtotal    := (real)le.assetpropcurrenttaxtotal ;
subjectactivityindex12month   := (real)le.subjectactivityindex12month ;
addrprevioustimeoldest    :=  (real)le.addrprevioustimeoldest;
inquirybanking12month     :=  (real)le.inquirybanking12month;
addrlastmoveecontrajectoryindex  := (real)le.addrlastmoveecontrajectoryindex ;   
addrinputsubjectowned   :=  (real)le.addrinputsubjectowned;
businessassociation     :=  (real)le.businessassociation;
SSNDeceased       :=  (real)le.SSNDeceased;
SubjectDeceased   :=  (real)le.SubjectDeceased;
confirmationsubjectfound   := (real)le.confirmationsubjectfound ; 
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

// willingnessreason := if(not((SubjectWillingnessPrimaryFactor in ['-1', '0'])) and not(SubjectWillingnessPrimaryFactor = NULL), SubjectWillingnessPrimaryFactor, NULL);
willingnessreason := if(not((SubjectWillingnessPrimaryFactor in ['-1', '0'])) and not(SubjectWillingnessPrimaryFactor = ''), SubjectWillingnessPrimaryFactor, '');

// stabilityreason := if(not((SubjectStabilityPrimaryFactor in ['-1', '0'])) and not(SubjectStabilityPrimaryFactor = NULL), SubjectStabilityPrimaryFactor, NULL);
stabilityreason := if(not((SubjectStabilityPrimaryFactor in ['-1', '0'])) and not(SubjectStabilityPrimaryFactor = ''), SubjectStabilityPrimaryFactor, '');

// onyx_rv5attr_nc_v01_w := map(
    // subjectrecordtimeoldest = NULL   => 0,
    // subjectrecordtimeoldest = -1     => 0.786930852400131,
    // subjectrecordtimeoldest <= 52.5  => 1.38498453688738,
    // subjectrecordtimeoldest <= 138.5 => 1.02807892083314,
    // subjectrecordtimeoldest <= 175.5 => 0.803469276187952,
    // subjectrecordtimeoldest <= 237.5 => 0.6361498453103,
    // subjectrecordtimeoldest <= 285.5 => 0.328923811260713,
    // subjectrecordtimeoldest <= 313.5 => 0.114547662338132,
    // subjectrecordtimeoldest <= 358.5 => -0.11078443416865,
                                        // -0.345738919077074);
onyx_rv5attr_nc_v01_w := map(
    subjectrecordtimeoldest = NULL   => 0,
    subjectrecordtimeoldest = -1     => 0.786930852400131,
    subjectrecordtimeoldest <= 52.5  => 1.38498453688738,
    subjectrecordtimeoldest <= 138.5 => 1.02807892083314,
   subjectrecordtimeoldest <= 175.5 => 0.803469276187952,
    subjectrecordtimeoldest <= 237.5 => 0.6361498453103,
    subjectrecordtimeoldest <= 285.5 => 0.328923811260713,
    subjectrecordtimeoldest <= 313.5 => 0.114547662338132,
    subjectrecordtimeoldest <= 358.5 => -0.11078443416865,
                                        -0.345738919077074);



onyx_rv5attr_nc_aa_code_01_1 := map(
    subjectrecordtimeoldest = NULL   => '',
    subjectrecordtimeoldest = -1     => '',
    subjectrecordtimeoldest <= 52.5  => 'C10',
    subjectrecordtimeoldest <= 138.5 => 'C10',
    subjectrecordtimeoldest <= 175.5 => 'C10',
    subjectrecordtimeoldest <= 237.5 => 'C10',
    subjectrecordtimeoldest <= 285.5 => 'C10',
    subjectrecordtimeoldest <= 313.5 => 'C10',
    subjectrecordtimeoldest <= 358.5 => 'C10',
                                        '');

onyx_rv5attr_nc_aa_dist_01 := -0.345738919077074 - onyx_rv5attr_nc_v01_w;

onyx_rv5attr_nc_aa_code_01 := if(onyx_rv5attr_nc_aa_dist_01 = 0, '', onyx_rv5attr_nc_aa_code_01_1);

onyx_rv5attr_nc_v02_w := map(
    subjectwillingnessindex = NULL => 0,
    subjectwillingnessindex = -1   => 0.471903902862701,
    subjectwillingnessindex <= 1.5 => 0.565335460172581,
    subjectwillingnessindex <= 2.5 => 0.281672627228421,
    subjectwillingnessindex <= 3.5 => 0.0238951850738809,
    subjectwillingnessindex <= 4.5 => -0.0862366654858097,
    subjectwillingnessindex <= 6.5 => -0.151438630123306,
                                      -0.336032454633304);

onyx_rv5attr_nc_aa_code_02_1 := map(
    subjectwillingnessindex = NULL => '',
    subjectwillingnessindex = -1   => '',
    subjectwillingnessindex <= 1.5 => willingnessreason,
    subjectwillingnessindex <= 2.5 => willingnessreason,
    subjectwillingnessindex <= 3.5 => willingnessreason,
    subjectwillingnessindex <= 4.5 => willingnessreason,
    subjectwillingnessindex <= 6.5 => willingnessreason,
                                      '');

onyx_rv5attr_nc_aa_dist_02 := -0.336032454633304 - onyx_rv5attr_nc_v02_w;

//onyx_rv5attr_nc_aa_code_02 := if(onyx_rv5attr_nc_aa_dist_02 = 0, NULL, onyx_rv5attr_nc_aa_code_02_1);
onyx_rv5attr_nc_aa_code_02 := if(onyx_rv5attr_nc_aa_dist_02 = 0, '', onyx_rv5attr_nc_aa_code_02_1);

onyx_rv5attr_nc_v03_w := map(
    criminalfelonycount = NULL => 0,
    criminalfelonycount = -1   => 0,
    criminalfelonycount <= 0.5 => -0.410593477701863,
    criminalfelonycount <= 1.5 => 0.511646837868305,
                                  0.814155776403658);

onyx_rv5attr_nc_aa_code_03_1 := map(
    criminalfelonycount = NULL => '',
    criminalfelonycount = -1   => '',
    criminalfelonycount <= 0.5 => '',
    criminalfelonycount <= 1.5 => 'D32',
                                  'D32');

onyx_rv5attr_nc_aa_dist_03 := -0.410593477701863 - onyx_rv5attr_nc_v03_w;

onyx_rv5attr_nc_aa_code_03 := if(onyx_rv5attr_nc_aa_dist_03 = 0, '', onyx_rv5attr_nc_aa_code_03_1);

onyx_rv5attr_nc_v04_w := map(
    inquiryshortterm12month = NULL => 0,
    inquiryshortterm12month = -1   => 0,
    inquiryshortterm12month <= 0.5 => -0.368718903523014,
                                      0.38012612441498);

onyx_rv5attr_nc_aa_code_04_1 := map(
    inquiryshortterm12month = NULL => '',
    inquiryshortterm12month = -1   => '',
    inquiryshortterm12month <= 0.5 => '',
                                      'I60');

onyx_rv5attr_nc_aa_dist_04 := -0.368718903523014 - onyx_rv5attr_nc_v04_w;

onyx_rv5attr_nc_aa_code_04 := if(onyx_rv5attr_nc_aa_dist_04 = 0, '', onyx_rv5attr_nc_aa_code_04_1);

onyx_rv5attr_nc_v05_w := map(
    addronfilecount = NULL  => 0,
    addronfilecount = -1    => 0,
    addronfilecount <= 1.5  => -0.306068683706931,
    addronfilecount <= 2.5  => -0.189082670516197,
    addronfilecount <= 3.5  => -0.0938194301735139,
    addronfilecount <= 4.5  => -0.0182437889842869,
    addronfilecount <= 5.5  => 0.103220370297121,
    addronfilecount <= 7.5  => 0.199645612180335,
    addronfilecount <= 8.5  => 0.312723884851062,
    addronfilecount <= 13.5 => 0.434205690007361,
                               0.712293327149332);

onyx_rv5attr_nc_aa_code_05_1 := map(
    addronfilecount = NULL  => '',
    addronfilecount = -1    => '',
    addronfilecount <= 1.5  => '',
    addronfilecount <= 2.5  => 'C14',
    addronfilecount <= 3.5  => 'C14',
    addronfilecount <= 4.5  => 'C14',
    addronfilecount <= 5.5  => 'C14',
    addronfilecount <= 7.5  => 'C14',
    addronfilecount <= 8.5  => 'C14',
    addronfilecount <= 13.5 => 'C14',
                               'C14');

onyx_rv5attr_nc_aa_dist_05 := -0.306068683706931 - onyx_rv5attr_nc_v05_w;

onyx_rv5attr_nc_aa_code_05 := if(onyx_rv5attr_nc_aa_dist_05 = 0, '', onyx_rv5attr_nc_aa_code_05_1);

onyx_rv5attr_nc_v06_w := map(
    evictioncount = NULL => 0,
    evictioncount = -1   => 0,
    evictioncount <= 0.5 => -0.335769866554557,
    evictioncount <= 1.5 => 0.3065157227423,
                            0.72797070668018);

onyx_rv5attr_nc_aa_code_06_1 := map(
    evictioncount = NULL => '',
    evictioncount = -1   => '',
    evictioncount <= 0.5 => '',
    evictioncount <= 1.5 => 'D33',
                            'D33');

onyx_rv5attr_nc_aa_dist_06 := -0.335769866554557 - onyx_rv5attr_nc_v06_w;

onyx_rv5attr_nc_aa_code_06 := if(onyx_rv5attr_nc_aa_dist_06 = 0, '', onyx_rv5attr_nc_aa_code_06_1);

onyx_rv5attr_nc_v07_w := map(
    assetpropevercount = NULL => 0,
    assetpropevercount = -1   => 0,
    assetpropevercount <= 0.5 => 0.370685362701466,
    assetpropevercount <= 1.5 => -0.107163330430964,
    assetpropevercount <= 2.5 => -0.150744003524438,
                                 -0.243857205193945);

onyx_rv5attr_nc_aa_code_07_1 := map(
    assetpropevercount = NULL => '',
    assetpropevercount = -1   => '',
    assetpropevercount <= 0.5 => 'A45',
    assetpropevercount <= 1.5 => 'A45',
    assetpropevercount <= 2.5 => 'A45',
                                 '');

onyx_rv5attr_nc_aa_dist_07 := -0.243857205193945 - onyx_rv5attr_nc_v07_w;

onyx_rv5attr_nc_aa_code_07 := if(onyx_rv5attr_nc_aa_dist_07 = 0, '', onyx_rv5attr_nc_aa_code_07_1);

onyx_rv5attr_nc_v08_w := map(
    inquirytelcom12month = NULL => 0,
    inquirytelcom12month = -1   => 0,
    inquirytelcom12month <= 0.5 => -0.330662472780258,
                                   0.374923027901208);

onyx_rv5attr_nc_aa_code_08_1 := map(
    inquirytelcom12month = NULL => '',
    inquirytelcom12month = -1   => '',
    inquirytelcom12month <= 0.5 => '',
                                   'I60');

onyx_rv5attr_nc_aa_dist_08 := -0.330662472780258 - onyx_rv5attr_nc_v08_w;

onyx_rv5attr_nc_aa_code_08 := if(onyx_rv5attr_nc_aa_dist_08 = 0, '', onyx_rv5attr_nc_aa_code_08_1);

onyx_rv5attr_nc_v09_w := map(
    subjectstabilityindex = NULL => 0,
    subjectstabilityindex = -1   => 0.471959718842967,
    subjectstabilityindex <= 4.5 => 0.271583239265371,
    subjectstabilityindex <= 5.5 => 0.0624006785439125,
    subjectstabilityindex <= 7.5 => -0.0621420711734914,
                                    -0.251325735970816);

onyx_rv5attr_nc_aa_code_09_1 := map(
    subjectstabilityindex = NULL => '',
    subjectstabilityindex = -1   => '',
    subjectstabilityindex <= 4.5 => stabilityreason,
    subjectstabilityindex <= 5.5 => stabilityreason,
    subjectstabilityindex <= 7.5 => stabilityreason,
                                    '');

onyx_rv5attr_nc_aa_dist_09 := -0.251325735970816 - onyx_rv5attr_nc_v09_w;

//onyx_rv5attr_nc_aa_code_09 := if(onyx_rv5attr_nc_aa_dist_09 = 0, NULL, onyx_rv5attr_nc_aa_code_09_1);
onyx_rv5attr_nc_aa_code_09 := if(onyx_rv5attr_nc_aa_dist_09 = 0, '', onyx_rv5attr_nc_aa_code_09_1);

onyx_rv5attr_nc_v10_w := map(
    criminalnonfelonycount = NULL => 0,
    criminalnonfelonycount = -1   => 0,
    criminalnonfelonycount <= 0.5 => -0.251512729317939,
    criminalnonfelonycount <= 1.5 => 0.210377174019166,
    criminalnonfelonycount <= 2.5 => 0.282482170231474,
    criminalnonfelonycount <= 3.5 => 0.350087302699866,
                                     0.808214172766587);

onyx_rv5attr_nc_aa_code_10_1 := map(
    criminalnonfelonycount = NULL => '',
    criminalnonfelonycount = -1   => '',
    criminalnonfelonycount <= 0.5 => '',
    criminalnonfelonycount <= 1.5 => 'D32',
    criminalnonfelonycount <= 2.5 => 'D32',
    criminalnonfelonycount <= 3.5 => 'D32',
                                     'D32');

onyx_rv5attr_nc_aa_dist_10 := -0.251512729317939 - onyx_rv5attr_nc_v10_w;

onyx_rv5attr_nc_aa_code_10 := if(onyx_rv5attr_nc_aa_dist_10 = 0, '', onyx_rv5attr_nc_aa_code_10_1);

onyx_rv5attr_nc_v11_w := map(
    assetpropcurrenttaxtotal = NULL     => 0,
    assetpropcurrenttaxtotal = -1       => 0.211891938516333,
    assetpropcurrenttaxtotal <= 0       => -0.0288739924200455,
    assetpropcurrenttaxtotal <= 7150.5  => 0.160166678252571,
    assetpropcurrenttaxtotal <= 14001   => -0.00160960601050903,
    assetpropcurrenttaxtotal <= 24720.5 => -0.0865376678821098,
    assetpropcurrenttaxtotal <= 198278  => -0.131628166381112,
                                           -0.158090979709491);

onyx_rv5attr_nc_aa_code_11_1 := map(
    assetpropcurrenttaxtotal = NULL     => '',
    assetpropcurrenttaxtotal = -1       => '',
    assetpropcurrenttaxtotal <= 0       => 'A46',
    assetpropcurrenttaxtotal <= 7150.5  => 'A46',
    assetpropcurrenttaxtotal <= 14001   => 'A46',
    assetpropcurrenttaxtotal <= 24720.5 => 'A46',
    assetpropcurrenttaxtotal <= 198278  => 'A46',
                                           '');

onyx_rv5attr_nc_aa_dist_11 := -0.158090979709491 - onyx_rv5attr_nc_v11_w;

onyx_rv5attr_nc_aa_code_11 := if(onyx_rv5attr_nc_aa_dist_11 = 0, '', onyx_rv5attr_nc_aa_code_11_1);

onyx_rv5attr_nc_v12_w := map(
    subjectactivityindex12month = NULL => 0,
    subjectactivityindex12month = -1   => -0.0438023190752996,
    subjectactivityindex12month <= 2.5 => -0.226336346584629,
    subjectactivityindex12month <= 3.5 => -0.105503793793427,
    subjectactivityindex12month <= 6.5 => 0.190283249464483,
                                          0.249626666588621);

onyx_rv5attr_nc_aa_code_12_1 := map(
    subjectactivityindex12month = NULL => '',
    subjectactivityindex12month = -1   => '',
    subjectactivityindex12month <= 2.5 => '',
    subjectactivityindex12month <= 3.5 => 'C12',
    subjectactivityindex12month <= 5.5 => 'C12',
    subjectactivityindex12month <= 6.5 => 'D30',
                                          'D30');

onyx_rv5attr_nc_aa_dist_12 := -0.226336346584629 - onyx_rv5attr_nc_v12_w;

onyx_rv5attr_nc_aa_code_12 := if(onyx_rv5attr_nc_aa_dist_12 = 0, '', onyx_rv5attr_nc_aa_code_12_1);

onyx_rv5attr_nc_v13_w := map(
    addrprevioustimeoldest = NULL   => 0,
    addrprevioustimeoldest = -1     => 0.0618043432316744,
    addrprevioustimeoldest <= 7.5   => 0.382046195670956,
    addrprevioustimeoldest <= 21.5  => 0.245761618763278,
    addrprevioustimeoldest <= 87.5  => 0.195275159084575,
    addrprevioustimeoldest <= 122.5 => 0.0625437516748392,
    addrprevioustimeoldest <= 163.5 => 0.0489619115971494,
    addrprevioustimeoldest <= 260.5 => -0.0602710697684017,
    addrprevioustimeoldest <= 352.5 => -0.151408319511279,
                                       -0.174880895742632);

onyx_rv5attr_nc_aa_code_13_1 := map(
    addrprevioustimeoldest = NULL   => '',
    addrprevioustimeoldest = -1     => '',
    addrprevioustimeoldest <= 7.5   => 'C13',
    addrprevioustimeoldest <= 21.5  => 'C13',
    addrprevioustimeoldest <= 87.5  => 'C13',
    addrprevioustimeoldest <= 122.5 => 'C13',
    addrprevioustimeoldest <= 163.5 => 'C13',
    addrprevioustimeoldest <= 260.5 => 'C13',
    addrprevioustimeoldest <= 352.5 => 'C13',
                                       '');

onyx_rv5attr_nc_aa_dist_13 := -0.174880895742632 - onyx_rv5attr_nc_v13_w;

onyx_rv5attr_nc_aa_code_13 := if(onyx_rv5attr_nc_aa_dist_13 = 0, '', onyx_rv5attr_nc_aa_code_13_1);

onyx_rv5attr_nc_v14_w := map(
    inquirybanking12month = NULL => 0,
    inquirybanking12month = -1   => 0,
    inquirybanking12month <= 0.5 => -0.194527548580233,
                                    0.207297244537452);

onyx_rv5attr_nc_aa_code_14_1 := map(
    inquirybanking12month = NULL => '',
    inquirybanking12month = -1   => '',
    inquirybanking12month <= 0.5 => '',
                                    'I60');

onyx_rv5attr_nc_aa_dist_14 := -0.194527548580233 - onyx_rv5attr_nc_v14_w;

onyx_rv5attr_nc_aa_code_14 := if(onyx_rv5attr_nc_aa_dist_14 = 0, '', onyx_rv5attr_nc_aa_code_14_1);

onyx_rv5attr_nc_v15_w := map(
    addrlastmoveecontrajectoryindex = NULL => 0,
    addrlastmoveecontrajectoryindex = -1   => 0,
    addrlastmoveecontrajectoryindex <= 2.5 => 0.191345063459474,
    addrlastmoveecontrajectoryindex <= 5.5 => 0.0739067397269055,
                                              -0.333902007867194);

onyx_rv5attr_nc_aa_code_15_1 := map(
    addrlastmoveecontrajectoryindex = NULL => '',
    addrlastmoveecontrajectoryindex = -1   => '',
    addrlastmoveecontrajectoryindex <= 2.5 => 'A46',
    addrlastmoveecontrajectoryindex <= 5.5 => 'A46',
                                              '');

onyx_rv5attr_nc_aa_dist_15 := -0.333902007867194 - onyx_rv5attr_nc_v15_w;

onyx_rv5attr_nc_aa_code_15 := if(onyx_rv5attr_nc_aa_dist_15 = 0, '', onyx_rv5attr_nc_aa_code_15_1);

onyx_rv5attr_nc_v16_w := map(
    addrinputsubjectowned = NULL => 0,
    addrinputsubjectowned = -1   => 0.0475709483308393,
    addrinputsubjectowned <= 0.5 => 0.149633473836447,
                                    -0.165289304856989);

onyx_rv5attr_nc_aa_code_16_1 := map(
    addrinputsubjectowned = NULL => '',
    addrinputsubjectowned = -1   => '',
    addrinputsubjectowned <= 0.5 => 'A44',
                                    '');

onyx_rv5attr_nc_aa_dist_16 := -0.165289304856989 - onyx_rv5attr_nc_v16_w;

onyx_rv5attr_nc_aa_code_16 := if(onyx_rv5attr_nc_aa_dist_16 = 0, '', onyx_rv5attr_nc_aa_code_16_1);

onyx_rv5attr_nc_v17_w := map(
    businessassociation = NULL => 0,
    businessassociation = -1   => 0,
    businessassociation <= 0.5 => 0.114440227858475,
                                  -0.110937131645479);

onyx_rv5attr_nc_aa_code_17_1 := map(
    businessassociation = NULL => '',
    businessassociation = -1   => '',
    businessassociation <= 0.5 => 'C12',
                                  '');

onyx_rv5attr_nc_aa_dist_17 := -0.110937131645479 - onyx_rv5attr_nc_v17_w;

onyx_rv5attr_nc_aa_code_17 := if(onyx_rv5attr_nc_aa_dist_17 = 0, '', onyx_rv5attr_nc_aa_code_17_1);

onyx_rv5attr_nc_rcvaluea46 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'A46') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'A46') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'A46') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'A46') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'A46') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'A46') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'A46') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'A46') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'A46') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'A46') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'A46') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'A46') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'A46') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'A46') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'A46') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'A46') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'A46') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluec10 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'C10') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'C10') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'C10') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'C10') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'C10') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'C10') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'C10') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'C10') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'C10') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'C10') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'C10') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'C10') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'C10') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'C10') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'C10') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'C10') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'C10') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluec12 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'C12') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'C12') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'C12') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'C12') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'C12') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'C12') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'C12') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'C12') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'C12') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'C12') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'C12') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'C12') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'C12') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'C12') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'C12') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'C12') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'C12') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvalued32 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'D32') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'D32') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'D32') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'D32') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'D32') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'D32') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'D32') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'D32') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'D32') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'D32') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'D32') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'D32') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'D32') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'D32') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'D32') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'D32') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'D32') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluea45 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'A45') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'A45') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'A45') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'A45') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'A45') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'A45') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'A45') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'A45') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'A45') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'A45') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'A45') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'A45') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'A45') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'A45') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'A45') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'A45') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'A45') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluec13 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'C13') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'C13') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'C13') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'C13') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'C13') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'C13') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'C13') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'C13') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'C13') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'C13') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'C13') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'C13') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'C13') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'C13') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'C13') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'C13') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'C13') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvalued30 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'D30') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'D30') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'D30') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'D30') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'D30') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'D30') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'D30') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'D30') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'D30') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'D30') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'D30') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'D30') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'D30') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'D30') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'D30') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'D30') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'D30') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluei60 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'I60') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'I60') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'I60') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'I60') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'I60') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'I60') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'I60') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'I60') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'I60') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'I60') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'I60') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'I60') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'I60') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'I60') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'I60') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'I60') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'I60') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvalued33 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'D33') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'D33') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'D33') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'D33') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'D33') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'D33') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'D33') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'D33') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'D33') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'D33') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'D33') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'D33') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'D33') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'D33') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'D33') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'D33') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'D33') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluea44 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'A44') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'A44') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'A44') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'A44') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'A44') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'A44') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'A44') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'A44') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'A44') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'A44') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'A44') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'A44') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'A44') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'A44') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'A44') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'A44') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'A44') * onyx_rv5attr_nc_aa_dist_17;

onyx_rv5attr_nc_rcvaluec14 := (integer)(onyx_rv5attr_nc_aa_code_01 = 'C14') * onyx_rv5attr_nc_aa_dist_01 +
    (integer)(onyx_rv5attr_nc_aa_code_02 = 'C14') * onyx_rv5attr_nc_aa_dist_02 +
    (integer)(onyx_rv5attr_nc_aa_code_03 = 'C14') * onyx_rv5attr_nc_aa_dist_03 +
    (integer)(onyx_rv5attr_nc_aa_code_04 = 'C14') * onyx_rv5attr_nc_aa_dist_04 +
    (integer)(onyx_rv5attr_nc_aa_code_05 = 'C14') * onyx_rv5attr_nc_aa_dist_05 +
    (integer)(onyx_rv5attr_nc_aa_code_06 = 'C14') * onyx_rv5attr_nc_aa_dist_06 +
    (integer)(onyx_rv5attr_nc_aa_code_07 = 'C14') * onyx_rv5attr_nc_aa_dist_07 +
    (integer)(onyx_rv5attr_nc_aa_code_08 = 'C14') * onyx_rv5attr_nc_aa_dist_08 +
    (integer)(onyx_rv5attr_nc_aa_code_09 = 'C14') * onyx_rv5attr_nc_aa_dist_09 +
    (integer)(onyx_rv5attr_nc_aa_code_10 = 'C14') * onyx_rv5attr_nc_aa_dist_10 +
    (integer)(onyx_rv5attr_nc_aa_code_11 = 'C14') * onyx_rv5attr_nc_aa_dist_11 +
    (integer)(onyx_rv5attr_nc_aa_code_12 = 'C14') * onyx_rv5attr_nc_aa_dist_12 +
    (integer)(onyx_rv5attr_nc_aa_code_13 = 'C14') * onyx_rv5attr_nc_aa_dist_13 +
    (integer)(onyx_rv5attr_nc_aa_code_14 = 'C14') * onyx_rv5attr_nc_aa_dist_14 +
    (integer)(onyx_rv5attr_nc_aa_code_15 = 'C14') * onyx_rv5attr_nc_aa_dist_15 +
    (integer)(onyx_rv5attr_nc_aa_code_16 = 'C14') * onyx_rv5attr_nc_aa_dist_16 +
    (integer)(onyx_rv5attr_nc_aa_code_17 = 'C14') * onyx_rv5attr_nc_aa_dist_17;

// onyx_rv5attr_nc_lgt := -2.83273386851235 +
    // onyx_rv5attr_nc_V01 +
    // onyx_rv5attr_nc_V02 +
    // onyx_rv5attr_nc_V03 +
    // onyx_rv5attr_nc_V04 +
    // onyx_rv5attr_nc_V05 +
    // onyx_rv5attr_nc_V06 +
    // onyx_rv5attr_nc_V07 +
    // onyx_rv5attr_nc_V08 +
    // onyx_rv5attr_nc_V09 +
    // onyx_rv5attr_nc_V10 +
    // onyx_rv5attr_nc_V11 +
    // onyx_rv5attr_nc_V12 +
    // onyx_rv5attr_nc_V13 +
    // onyx_rv5attr_nc_V14 +
    // onyx_rv5attr_nc_V15 +
    // onyx_rv5attr_nc_V16 +
    // onyx_rv5attr_nc_V17;

onyx_rv5attr_nc_lgt := -2.83273386851235 +
    onyx_rv5attr_nc_V01_w +
    onyx_rv5attr_nc_V02_w +
    onyx_rv5attr_nc_V03_w +
    onyx_rv5attr_nc_V04_w +
    onyx_rv5attr_nc_V05_w +
    onyx_rv5attr_nc_V06_w +
    onyx_rv5attr_nc_V07_w +
    onyx_rv5attr_nc_V08_w +
    onyx_rv5attr_nc_V09_w +
    onyx_rv5attr_nc_V10_w +
    onyx_rv5attr_nc_V11_w +
    onyx_rv5attr_nc_V12_w +
    onyx_rv5attr_nc_V13_w +
    onyx_rv5attr_nc_V14_w +
    onyx_rv5attr_nc_V15_w +
    onyx_rv5attr_nc_V16_w +
    onyx_rv5attr_nc_V17_w;
//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};
 
//*************************************************************************************//
rc_dataset_onyx_rv5attr_nc_1 := DATASET([
    {'A46', onyx_rv5attr_nc_rcvalueA46},
    {'C10', onyx_rv5attr_nc_rcvalueC10},
    {'C12', onyx_rv5attr_nc_rcvalueC12},
    {'D32', onyx_rv5attr_nc_rcvalueD32},
    {'A45', onyx_rv5attr_nc_rcvalueA45},
    {'C13', onyx_rv5attr_nc_rcvalueC13},
    {'D30', onyx_rv5attr_nc_rcvalueD30},
    {'I60', onyx_rv5attr_nc_rcvalueI60},
    {'D33', onyx_rv5attr_nc_rcvalueD33},
    {'A44', onyx_rv5attr_nc_rcvalueA44},
    {'C14', onyx_rv5attr_nc_rcvalueC14}
    ], ds_layout)(value < 0);


rc_dataset_onyx_rv5attr_nc_2 := DATASET([
    {onyx_rv5attr_nc_aa_code_02,onyx_rv5attr_nc_aa_dist_02}
    ], ds_layout)(value < 0);


rc_dataset_upd_1 := if (onyx_rv5attr_nc_aa_code_02 not in 
                  ['','A46','C10', 'C12', 'D32', 
                   'A45', 'C13', 'D30', 'I60', 
                   'D33', 'A44', 'C14'],
                  rc_dataset_onyx_rv5attr_nc_1 + rc_dataset_onyx_rv5attr_nc_2,rc_dataset_onyx_rv5attr_nc_1 );



rc_dataset_onyx_rv5attr_nc_3 := DATASET([
    {onyx_rv5attr_nc_aa_code_09,onyx_rv5attr_nc_aa_dist_09}
    ], ds_layout)(value < 0);


rc_dataset_onyx_rv5attr_nc := if (onyx_rv5attr_nc_aa_code_09 not in 
                  ['','A46','C10', 'C12', 'D32', 
                   'A45', 'C13', 'D30', 'I60', 
                   'D33', 'A44', 'C14'],
                  rc_dataset_upd_1 + rc_dataset_onyx_rv5attr_nc_3,rc_dataset_upd_1 );




//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_onyx_rv5attr_nc_sorted := sort(rc_dataset_onyx_rv5attr_nc, rc_dataset_onyx_rv5attr_nc.value);

r_rc1 := rc_dataset_onyx_rv5attr_nc_sorted[1].rc;
r_rc2 := rc_dataset_onyx_rv5attr_nc_sorted[2].rc;
r_rc3 := rc_dataset_onyx_rv5attr_nc_sorted[3].rc;
r_rc4 := rc_dataset_onyx_rv5attr_nc_sorted[4].rc;
r_rc5 := rc_dataset_onyx_rv5attr_nc_sorted[5].rc;
r_rc6 := rc_dataset_onyx_rv5attr_nc_sorted[6].rc;
r_rc7 := rc_dataset_onyx_rv5attr_nc_sorted[7].rc;
r_rc8 := rc_dataset_onyx_rv5attr_nc_sorted[8].rc;
r_rc9 := rc_dataset_onyx_rv5attr_nc_sorted[9].rc;
r_rc10 := rc_dataset_onyx_rv5attr_nc_sorted[10].rc;
r_rc11 := rc_dataset_onyx_rv5attr_nc_sorted[11].rc;
r_rc12 := rc_dataset_onyx_rv5attr_nc_sorted[12].rc;
r_rc13 := rc_dataset_onyx_rv5attr_nc_sorted[13].rc;
r_rc14 := rc_dataset_onyx_rv5attr_nc_sorted[14].rc;
r_rc15 := rc_dataset_onyx_rv5attr_nc_sorted[15].rc;
r_rc16 := rc_dataset_onyx_rv5attr_nc_sorted[16].rc;
r_rc17 := rc_dataset_onyx_rv5attr_nc_sorted[17].rc;


r_vl1 := rc_dataset_onyx_rv5attr_nc_sorted[1].value;
r_vl2 := rc_dataset_onyx_rv5attr_nc_sorted[2].value;
r_vl3 := rc_dataset_onyx_rv5attr_nc_sorted[3].value;
r_vl4 := rc_dataset_onyx_rv5attr_nc_sorted[4].value;
r_vl5 := rc_dataset_onyx_rv5attr_nc_sorted[5].value;
r_vl6 := rc_dataset_onyx_rv5attr_nc_sorted[6].value;
r_vl7 := rc_dataset_onyx_rv5attr_nc_sorted[7].value;
r_vl8 := rc_dataset_onyx_rv5attr_nc_sorted[8].value;
r_vl9 := rc_dataset_onyx_rv5attr_nc_sorted[9].value;
r_vl10 := rc_dataset_onyx_rv5attr_nc_sorted[10].value;
r_vl11 := rc_dataset_onyx_rv5attr_nc_sorted[11].value;
r_vl12 := rc_dataset_onyx_rv5attr_nc_sorted[12].value;
r_vl13 := rc_dataset_onyx_rv5attr_nc_sorted[13].value;
r_vl14 := rc_dataset_onyx_rv5attr_nc_sorted[14].value;
r_vl15 := rc_dataset_onyx_rv5attr_nc_sorted[15].value;
r_vl16 := rc_dataset_onyx_rv5attr_nc_sorted[16].value;
r_vl17 := rc_dataset_onyx_rv5attr_nc_sorted[17].value;
//*************************************************************************************//

rc1_3 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

_rc_inq := if(r_rc1 = 'I60' or r_rc2 = 'I60' or r_rc3 = 'I60' or r_rc4 = 'I60' or r_rc5 = 'I60' or r_rc6 = 'I60' or r_rc7 = 'I60' or r_rc8 = 'I60' or r_rc9 = 'I60' or r_rc10 = 'I60' or r_rc11 = 'I60', 'I60', '');

rc4_c56 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             '');

rc5_c56 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc3_c56 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc1_c56 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc2_c56 := map(
    trim((string)rc1_3, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

// rc2_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c56, rc2_2);

// rc1_2 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c56, rc1_3);

// rc3_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c56, rc3_2);

// rc4_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c56, rc4_2);

// rc5_1 := if(not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c56, '');


rc2_1 := if(rc2_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c56, rc2_2);

rc1_2 := if(rc1_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c56, rc1_3);

rc3_1 := if(rc3_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c56, rc3_2);

rc4_1 := if(rc4_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c56, rc4_2);

rc5_1 := if( rc5_c56 != '' and not((rc1_3 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c56, '');


base := 700;

pts := -40;

odds := 0.0275895808933628;

rvg1808_3_0 := map(
    SSNDeceased = 1 or SubjectDeceased = 1 => 200,
    confirmationsubjectfound < 1           => 222,
                                              min(if(max(round(pts * (onyx_rv5attr_nc_lgt - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (onyx_rv5attr_nc_lgt - ln(odds)) / ln(2) + base), 501)), 900));

rc1_1 := if(500 < rvg1808_3_0 AND rvg1808_3_0 < 900 and rc1_2 = '', 'C12', rc1_2);

rc4 := if(rvg1808_3_0 >= 900 or rvg1808_3_0 <= 500, '', rc4_1);

rc5 := if(rvg1808_3_0 >= 900 or rvg1808_3_0 <= 500, '', rc5_1);

rc2 := if(rvg1808_3_0 >= 900 or rvg1808_3_0 <= 500, '', rc2_1);

rc3 := if(rvg1808_3_0 >= 900 or rvg1808_3_0 <= 500, '', rc3_1);

rc1 := if(rvg1808_3_0 >= 900 or rvg1808_3_0 <= 500, '', rc1_1);



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
													rvg1808_3_0 = 200 => DATASET([{'00'}], HRILayout),
													rvg1808_3_0 = 222 => DATASET([{'00'}], HRILayout),
													rvg1808_3_0 = 900 => DATASET([{'00'}], HRILayout),
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
                    self.stabilityreason                  := stabilityreason;
                    self.subjectwillingnessindex   := subjectwillingnessindex ;
                   self.SubjectWillingnessPrimaryFactor   :=  SubjectWillingnessPrimaryFactor;
                   self.subjectstabilityindex   :=  subjectstabilityindex;
                   self.SubjectStabilityPrimaryFactor     :=  SubjectStabilityPrimaryFactor;
                   self.subjectrecordtimeoldest     :=  subjectrecordtimeoldest;   
                   self.criminalfelonycount      :=  criminalfelonycount;   
                   self.inquiryshortterm12month   := inquiryshortterm12month ;
                   self.addronfilecount       :=  addronfilecount;
                   self.evictioncount         :=  evictioncount;
                   self.assetpropevercount    := assetpropevercount ;  
                   self.inquirytelcom12month   := inquirytelcom12month ; 
                   self.criminalnonfelonycount     := criminalnonfelonycount ; 
                   self.assetpropcurrenttaxtotal    := assetpropcurrenttaxtotal ;
                   self.subjectactivityindex12month   := subjectactivityindex12month ;
                   self.addrprevioustimeoldest    :=  addrprevioustimeoldest;
                   self.inquirybanking12month     :=  inquirybanking12month;
                   self.addrlastmoveecontrajectoryindex   := addrlastmoveecontrajectoryindex ;   
                   self.addrinputsubjectowned   :=  addrinputsubjectowned;
                   self.businessassociation     :=  businessassociation;
                   self.SSNDeceased      :=  SSNDeceased;
                   self.SubjectDeceased  :=  SubjectDeceased;
                   self.confirmationsubjectfound :=  confirmationsubjectfound;
                    
                    
                    self.onyx_rv5attr_nc_v01_w            := onyx_rv5attr_nc_v01_w;
                    self.onyx_rv5attr_nc_aa_dist_01       := onyx_rv5attr_nc_aa_dist_01;
                    self.onyx_rv5attr_nc_aa_code_01       := onyx_rv5attr_nc_aa_code_01;
                    self.onyx_rv5attr_nc_v02_w            := onyx_rv5attr_nc_v02_w;
                    self.onyx_rv5attr_nc_aa_dist_02       := onyx_rv5attr_nc_aa_dist_02;
                    self.onyx_rv5attr_nc_aa_code_02       := onyx_rv5attr_nc_aa_code_02;
                    self.onyx_rv5attr_nc_v03_w            := onyx_rv5attr_nc_v03_w;
                    self.onyx_rv5attr_nc_aa_dist_03       := onyx_rv5attr_nc_aa_dist_03;
                    self.onyx_rv5attr_nc_aa_code_03       := onyx_rv5attr_nc_aa_code_03;
                    self.onyx_rv5attr_nc_v04_w            := onyx_rv5attr_nc_v04_w;
                    self.onyx_rv5attr_nc_aa_dist_04       := onyx_rv5attr_nc_aa_dist_04;
                    self.onyx_rv5attr_nc_aa_code_04       := onyx_rv5attr_nc_aa_code_04;
                    self.onyx_rv5attr_nc_v05_w            := onyx_rv5attr_nc_v05_w;
                    self.onyx_rv5attr_nc_aa_dist_05       := onyx_rv5attr_nc_aa_dist_05;
                    self.onyx_rv5attr_nc_aa_code_05       := onyx_rv5attr_nc_aa_code_05;
                    self.onyx_rv5attr_nc_v06_w            := onyx_rv5attr_nc_v06_w;
                    self.onyx_rv5attr_nc_aa_dist_06       := onyx_rv5attr_nc_aa_dist_06;
                    self.onyx_rv5attr_nc_aa_code_06       := onyx_rv5attr_nc_aa_code_06;
                    self.onyx_rv5attr_nc_v07_w            := onyx_rv5attr_nc_v07_w;
                    self.onyx_rv5attr_nc_aa_dist_07       := onyx_rv5attr_nc_aa_dist_07;
                    self.onyx_rv5attr_nc_aa_code_07       := onyx_rv5attr_nc_aa_code_07;
                    self.onyx_rv5attr_nc_v08_w            := onyx_rv5attr_nc_v08_w;
                    self.onyx_rv5attr_nc_aa_dist_08       := onyx_rv5attr_nc_aa_dist_08;
                    self.onyx_rv5attr_nc_aa_code_08       := onyx_rv5attr_nc_aa_code_08;
                    self.onyx_rv5attr_nc_v09_w            := onyx_rv5attr_nc_v09_w;
                    self.onyx_rv5attr_nc_aa_dist_09       := onyx_rv5attr_nc_aa_dist_09;
                    self.onyx_rv5attr_nc_aa_code_09       := onyx_rv5attr_nc_aa_code_09;
                    self.onyx_rv5attr_nc_v10_w            := onyx_rv5attr_nc_v10_w;
                    self.onyx_rv5attr_nc_aa_dist_10       := onyx_rv5attr_nc_aa_dist_10;
                    self.onyx_rv5attr_nc_aa_code_10       := onyx_rv5attr_nc_aa_code_10;
                    self.onyx_rv5attr_nc_v11_w            := onyx_rv5attr_nc_v11_w;
                    self.onyx_rv5attr_nc_aa_dist_11       := onyx_rv5attr_nc_aa_dist_11;
                    self.onyx_rv5attr_nc_aa_code_11       := onyx_rv5attr_nc_aa_code_11;
                    self.onyx_rv5attr_nc_v12_w            := onyx_rv5attr_nc_v12_w;
                    self.onyx_rv5attr_nc_aa_dist_12       := onyx_rv5attr_nc_aa_dist_12;
                    self.onyx_rv5attr_nc_aa_code_12       := onyx_rv5attr_nc_aa_code_12;
                    self.onyx_rv5attr_nc_v13_w            := onyx_rv5attr_nc_v13_w;
                    self.onyx_rv5attr_nc_aa_dist_13       := onyx_rv5attr_nc_aa_dist_13;
                    self.onyx_rv5attr_nc_aa_code_13       := onyx_rv5attr_nc_aa_code_13;
                    self.onyx_rv5attr_nc_v14_w            := onyx_rv5attr_nc_v14_w;
                    self.onyx_rv5attr_nc_aa_dist_14       := onyx_rv5attr_nc_aa_dist_14;
                    self.onyx_rv5attr_nc_aa_code_14       := onyx_rv5attr_nc_aa_code_14;
                    self.onyx_rv5attr_nc_v15_w            := onyx_rv5attr_nc_v15_w;
                    self.onyx_rv5attr_nc_aa_dist_15       := onyx_rv5attr_nc_aa_dist_15;
                    self.onyx_rv5attr_nc_aa_code_15       := onyx_rv5attr_nc_aa_code_15;
                    self.onyx_rv5attr_nc_v16_w            := onyx_rv5attr_nc_v16_w;
                    self.onyx_rv5attr_nc_aa_dist_16       := onyx_rv5attr_nc_aa_dist_16;
                    self.onyx_rv5attr_nc_aa_code_16       := onyx_rv5attr_nc_aa_code_16;
                    self.onyx_rv5attr_nc_v17_w            := onyx_rv5attr_nc_v17_w;
                    self.onyx_rv5attr_nc_aa_dist_17       := onyx_rv5attr_nc_aa_dist_17;
                    self.onyx_rv5attr_nc_aa_code_17       := onyx_rv5attr_nc_aa_code_17;
                    self.onyx_rv5attr_nc_rcvaluea46       := onyx_rv5attr_nc_rcvaluea46;
                    self.onyx_rv5attr_nc_rcvaluec10       := onyx_rv5attr_nc_rcvaluec10;
                    self.onyx_rv5attr_nc_rcvaluec12       := onyx_rv5attr_nc_rcvaluec12;
                    self.onyx_rv5attr_nc_rcvalued32       := onyx_rv5attr_nc_rcvalued32;
                    self.onyx_rv5attr_nc_rcvaluea45       := onyx_rv5attr_nc_rcvaluea45;
                    self.onyx_rv5attr_nc_rcvaluec13       := onyx_rv5attr_nc_rcvaluec13;
                    self.onyx_rv5attr_nc_rcvalued30       := onyx_rv5attr_nc_rcvalued30;
                    self.onyx_rv5attr_nc_rcvaluei60       := onyx_rv5attr_nc_rcvaluei60;
                    self.onyx_rv5attr_nc_rcvalued33       := onyx_rv5attr_nc_rcvalued33;
                    self.onyx_rv5attr_nc_rcvaluea44       := onyx_rv5attr_nc_rcvaluea44;
                    self.onyx_rv5attr_nc_rcvaluec14       := onyx_rv5attr_nc_rcvaluec14;
                    self.onyx_rv5attr_nc_lgt              := onyx_rv5attr_nc_lgt;
                    self._rc_inq                          := _rc_inq;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvg1808_3_0                      := rvg1808_3_0;
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
		SELF.score := (STRING3)rvg1808_3_0;
		SELF.seq := le.seq;
	#end
	END;

	
  model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));
	RETURN(model);
END;

