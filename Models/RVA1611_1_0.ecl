IMPORT ut, Std, RiskWise, Riskview, RiskWiseFCRA, Risk_Indicators;

EXPORT RVA1611_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, boolean isPrescreen) := FUNCTION

	// first run the clam through riskview attributes as this model was built from attributes
	attributes := RiskView.get_attributes_v5(clam, isPrescreen);
	
	MODEL_DEBUG := False;
	
	#if(MODEL_DEBUG)
	Layout_Debug := RECORD
	
	/* Model Intermediate Variables */
	//STRING NULL;
	 Integer seq;
	 Integer sysdate;
	 String	subjectrecordtimeoldest;          
   String	lienjudgmentcount;                
   String	ssndeceased;                      
   String	confirmationsubjectfound;         
   String	addronfilecount;                  
   String	subjectabilityprimaryfactor;      
   String	inquirytelcom12month;             
   String	inquiryshortterm12month;          
   String	inquiryauto12month;               
   String	evictioncount;                    
   String	criminalfelonycount;              
   String	bankruptcystatus;                 
   String	criminalnonfelonycount;           
   String	profliccount;                     
   String	educationprogramattended;         
   String	businessassociation;              
   String	sourcenonderogcount;              
   String	sourcenonderogcount06month;       
   String	addrinputdwelltype;               
   String	addrinputtaxmarketvalue;          
   String	addrcurrentdwelltype;             
   String	addrcurrenttaxmarketvalue;        
   Integer	inputtaxmarket;                   
   String	addrinputcountyratio;             
   String	addrcurrentcountyratio;           
   String	subjectabilityindex;              
   String	addrinputtimeoldest;              
   String	ssnsubjectcount;                  
   String	phoneinputsubjectcount;           
   String	sourcecredheadertimeoldest;       
   String	addrinputphonecount;              
   String	addrcurrentavmvalue60month;       
   String	addronfilecollege;                
   String	 rv5_attr_unscoreable;
   String	 iv_subjectabilityprimaryfactor;
   Integer	 ca_m2_inquiryindex;
   Integer	 ca_m2_derogseverityindex;
   Integer	 ca_m2_occupation;
   Integer	 ca_m2_nonderogindex06month;
   Integer	 currenttaxmarket;
   Integer	 iv_inputcurrtaxmarketvaluesfdmax;
   Integer	 currentcountyratio;
   Decimal6_2	 iv_inputcurrctyratiosfdavg;
   Real	 tn_subscore0;
   Real	 tn_subscore1;
   Real	 tn_subscore2;
   Real	 tn_subscore3;
   Real	 tn_subscore4;
   Real	 tn_subscore5;
   Real	 tn_subscore6;
   Real	 tn_subscore7;
   Real	 tn_subscore8;
   Real	 tn_subscore9;
   Real	 tn_subscore10;
   Real	 tn_subscore11;
   Real	 tn_subscore12;
   Real	 tn_subscore13;
   Real	 tn_subscore14;
   Real	 tn_rawscore;
   Real	 tn_lnoddsscore;
   Real	 tn_probscore;
   Integer	 base;
   Integer	 pdo;
   Real	 odds;
   Integer	 rva1611_1_0;
   String	 tn_aacd_0;
   Real	 tn_dist_0;
   String	 tn_aacd_1;
   Real	 tn_dist_1;
   String	 tn_aacd_2;
   Real	 tn_dist_2;
   String	 tn_aacd_3;
   Real	 tn_dist_3;
   String	 tn_aacd_4;
   Real	 tn_dist_4;
   String	 tn_aacd_5;
   Real	 tn_dist_5;
   String	 tn_aacd_6;
   Real	 tn_dist_6;
   String	 tn_aacd_7;
   Real	 tn_dist_7;
   String	 tn_aacd_8;
   Real	 tn_dist_8;
   String	 tn_aacd_9;
   Real	 tn_dist_9;
   String	 tn_aacd_10;
   Real	 tn_dist_10;
   String	 tn_aacd_11;
   Real	 tn_dist_11;
   String	 tn_aacd_12;
   Real	 tn_dist_12;
   String	 tn_aacd_13;
   Real	 tn_dist_13;
   String	 tn_aacd_14;
   Real	 tn_dist_14;
   Real	 tn_rcvaluep89;
   Real	 tn_rcvaluel79;
   Real	 tn_rcvaluec20;
   Real	 tn_rcvaluel80;
   Real	 tn_rcvaluel77;
   Real	 tn_rcvalued30;
   Real	 tn_rcvaluea46;
   Real	 tn_rcvaluea47;
   Real	 tn_rcvaluei60;
   Real	 tn_rcvaluep85;
   Real	 tn_rcvaluec13;
   Real	 tn_rcvaluec12;
   Real	 tn_rcvalues65;
   Real	 tn_rcvalues66;
   Real	 tn_rcvaluec14;
   String	 _rc_inq;
   String	 tn_rc1;
   String	 tn_rc2;
   String	 tn_rc3;
   String	 tn_rc4;
   Real	 tn_vl1;
   Real	 tn_vl2;
   Real	 tn_vl3;
   Real	 tn_vl4;
   String	 rc1;
   String	 rc2;
   String	 rc3;
   String	 rc4;
   String	 rc5;

		Risk_Indicators.Layout_Boca_Shell clam;
	END;
			
		Layout_Debug doModel(attributes le, clam rt) := TRANSFORM
	#else
		Layout_ModelOut doModel(attributes le, clam rt) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	 
	subjectrecordtimeoldest          := le.SubjectRecordTimeOldest;
	lienjudgmentcount                := le.lienjudgmentcount;
	ssndeceased                      := le.ssndeceased;
	confirmationsubjectfound         := le.confirmationsubjectfound;
	addronfilecount                  := le.addronfilecount;
	subjectabilityprimaryfactor      := le.subjectabilityprimaryfactor;
	inquirytelcom12month             := le.inquirytelcom12month;
	inquiryshortterm12month          := le.inquiryshortterm12month;
	inquiryauto12month               := le.inquiryauto12month;
	evictioncount                    := le.evictioncount;
	criminalfelonycount              := le.criminalfelonycount;
	bankruptcystatus                 := le.bankruptcystatus;
	criminalnonfelonycount           := le.criminalnonfelonycount;
	profliccount                     := le.profliccount;
	educationprogramattended         := le.educationprogramattended;
	businessassociation              := le.businessassociation;
	sourcenonderogcount              := le.sourcenonderogcount;
	sourcenonderogcount06month       := le.sourcenonderogcount06month;
	addrinputdwelltype               := le.addrinputdwelltype;
	addrinputtaxmarketvalue          := le.addrinputtaxmarketvalue;
	addrcurrentdwelltype             := le.addrcurrentdwelltype;
	addrcurrenttaxmarketvalue        := le.addrcurrenttaxmarketvalue;
	//inputtaxmarket                   := le.AddrInputTaxMarketValue;
	addrinputcountyratio             := le.addrinputcountyratio;
	addrcurrentcountyratio           := le.addrcurrentcountyratio;
	subjectabilityindex              := le.subjectabilityindex;
	addrinputtimeoldest              := le.addrinputtimeoldest;
	ssnsubjectcount                  := le.ssnsubjectcount;
	phoneinputsubjectcount           := le.phoneinputsubjectcount;
	sourcecredheadertimeoldest       := le.sourcecredheadertimeoldest;
	addrinputphonecount              := le.addrinputphonecount;
	addrcurrentavmvalue60month       := le.addrcurrentavmvalue60month;
	addronfilecollege                := le.addronfilecollege;

	/* ***********************************************************
	 *   Generated ECL         *
	 ************************************************************* */

sysdate := models.common.sas_date(if(rt.historydate=999999, (STRING8)Std.Date.Today(), (string6)rt.historydate+'01'));

NULL := -999999999;

rv5_attr_unscoreable := map(
    subjectrecordtimeoldest = '' or lienjudgmentcount = ''    => '0 MISSING',
    (integer)ssndeceased = 1             => '1 SSN DEC',
    (integer)confirmationsubjectfound = 0 or (integer)addronfilecount = -1 or (integer)lienjudgmentcount = -1 => '2 UNSCORE',
                  '3 SCORE  ');

iv_subjectabilityprimaryfactor := map(
    (subjectabilityprimaryfactor in ['0', '-1'])    => '   ',
    (subjectabilityprimaryfactor in ['E55', 'E56']) => 'C12',
                     subjectabilityprimaryfactor);

ca_m2_inquiryindex := map(
    (integer)inquirytelcom12month = 1 or (integer)inquiryshortterm12month = 1 => 3,
    (integer)inquiryauto12month = 1                 => 2,
            1);

ca_m2_derogseverityindex := map(
    (integer)evictioncount > 1 or (integer)criminalfelonycount > 0 or (integer)bankruptcystatus = 2 => 4,
    (integer)evictioncount > 0 or (integer)criminalnonfelonycount > 1     => 3,
    (integer)criminalnonfelonycount > 0 or (integer)lienjudgmentcount > 0                  => 2,
                         1);

ca_m2_occupation := map(
    (integer)profliccount > 0 or (integer)educationprogramattended > 1 => 4,
    (integer)businessassociation > 0         => 3,
    (integer)educationprogramattended > 0    => 2,
                      1);

ca_m2_nonderogindex06month := map(
    (integer)sourcenonderogcount = -1           => -1,
    (integer)sourcenonderogcount06month > 2 and (integer)sourcenonderogcount > 2 or (integer)sourcenonderogcount > 4 => 5,
    (integer)sourcenonderogcount06month < 3 and (integer)sourcenonderogcount = 4           => 4,
    (integer)sourcenonderogcount06month < 3 and (integer)sourcenonderogcount = 3           => 3,
    (integer)sourcenonderogcount06month < 3 and (integer)sourcenonderogcount = 2           => 2,
                         1);

currenttaxmarket := map(
    (addrcurrentdwelltype in ['-1']) or ((integer)addrcurrenttaxmarketvalue in [-1]) => -1,
    not((addrcurrentdwelltype in ['S']))                   => -9999,
                            (Integer)addrcurrenttaxmarketvalue);
		inputtaxmarket := map(
		(addrinputdwelltype in ['-1']) or (addrinputtaxmarketvalue in ['-1'])  => -1,                                                                                                                                                                                                                                                                                                                                                                                                                     
   not(( addrinputdwelltype in ['S']))                             => -9999,                                                                                                                                                                                                                                                                                                                                                                                                                  
                                                                   (Integer)addrinputtaxmarketvalue);

iv_inputcurrtaxmarketvaluesfdmax := max((integer)inputtaxmarket, currenttaxmarket);
//iv_inputcurrtaxmarketvaluesfdmax := if (max((integer)inputtaxmarket, currenttaxmarket)= 0, -9999, max((integer)inputtaxmarket, currenttaxmarket));

currentcountyratio := map(
    (addrcurrentdwelltype in ['-1']) or ((integer)addrcurrentcountyratio in [-1]) => -1,
    not((addrcurrentdwelltype in ['S']))                => -9999,
                         (Real)addrcurrentcountyratio);

Inputcountyratio := map(
	(addrinputdwelltype in ['-1']) or ((integer)addrinputcountyratio in [-1]) => -1,
not ((addrinputdwelltype in ['S'])) => -9999,
										(Real)addrinputcountyratio);

iv_inputcurrctyratiosfdavg := if(inputcountyratio > 0 and (Real)currentcountyratio > 0, roundup((inputcountyratio + currentcountyratio) / 2/0.01)*0.01, inputcountyratio);

tn_subscore0 := map(
    (ca_m2_inquiryindex in [1]) => 0.327385,
    (ca_m2_inquiryindex in [2]) => -0.730039,
    (ca_m2_inquiryindex in [3]) => -0.953786,
                  0);

tn_subscore1 := map(
    '' < addronfilecount AND (integer)addronfilecount < 2 => 0.256253,
    2 <= (integer)addronfilecount AND (integer)addronfilecount < 3   => 0.00113,
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => -0.238463,
    5 <= (integer)addronfilecount          => -0.347981,
                    0);

tn_subscore2 := map(
    NULL < iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < -1    => 0.026658,
    -1 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0      => 0.043276,
    0 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.01    => 0.044399,
    0.01 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.35 => -0.493054,
    0.35 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.76 => -0.312445,
    0.76 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 1.27 => -0.081208,
    1.27 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 1.97 => 0.337426,
    1.97 <= iv_inputcurrctyratiosfdavg                      => 0.527862,
            0);

tn_subscore3 := map(
    '' < subjectabilityindex AND (integer)subjectabilityindex < 3 => -0.114122,
    3 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 4   => 0.00656,
    4 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 6   => 0.221596,
    6 <= (integer)subjectabilityindex              => 0.431578,
           0);

tn_subscore4 := map(
    (ca_m2_derogseverityindex in [1]) => 0.050572,
    (ca_m2_derogseverityindex in [2]) => -0.406416,
    (ca_m2_derogseverityindex in [3]) => -0.416004,
    (ca_m2_derogseverityindex in [4]) => -1.065,
       0);

tn_subscore5 := map(
    (ca_m2_occupation in [1]) => -0.067348,
    (ca_m2_occupation in [2]) => 0.01085,
    (ca_m2_occupation in [3]) => 0.387998,
    (ca_m2_occupation in [4]) => 0.641148,
                0);

tn_subscore6 := map(
    (ca_m2_nonderogindex06month in [1]) => -0.13239,
    (ca_m2_nonderogindex06month in [2]) => -0.019702,
    (ca_m2_nonderogindex06month in [3]) => 0.221569,
    (ca_m2_nonderogindex06month in [4]) => 0.495813,
    (ca_m2_nonderogindex06month in [5]) => 0.613648,
         0);

tn_subscore7 := map(
    '' < addrinputtimeoldest AND (integer)addrinputtimeoldest < 1 => -0.218222,
    1 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 6   => -0.077214,
    6 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 183 => 0.070498,
    183 <= (integer)addrinputtimeoldest            => 0.466418,
           0);

tn_subscore8 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 0,
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => -0.623047,
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 0.042778,
    2 <= (integer)ssnsubjectcount          => -0.273006,
                    0);

tn_subscore9 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => 0,
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => -0.057793,
    1 <= (integer)phoneinputsubjectcount                 => 0.401651,
                 0);

tn_subscore10 := map(
    NULL < iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < -1        => 0.19086,
    -1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 0          => -0.130245,
    0 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 1           => -0.031783,
    1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 58820       => -0.478334,
    58820 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 101200  => -0.234159,
    101200 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 180500 => 0.405534,
    180500 <= iv_inputcurrtaxmarketvaluesfdmax             => 0.519858,
                            0);

tn_subscore11 := map(
    '' < sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 1  => 0,
    1 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 17   => -0.236683,
    17 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 26  => -0.12908,
    26 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 41  => -0.056769,
    41 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 300 => 0.093231,
    300 <= (integer)sourcecredheadertimeoldest                    => 0.240365,
                          0);

tn_subscore12 := map(
    '' < addrinputphonecount AND (integer)addrinputphonecount < 0 => 0,
    0 <= (integer)addrinputphonecount AND (integer)addrinputphonecount < 2   => 0.045681,
    2 <= (integer)addrinputphonecount AND (integer)addrinputphonecount < 4   => -0.215197,
    4 <= (integer)addrinputphonecount              => -0.464884,
           0);

tn_subscore13 := map(
    '' < addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 1         => 0.010766,
    1 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 52613       => -0.685132,
    52613 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 76588   => -0.268369,
    76588 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 117977  => -0.054356,
    117977 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 289319 => 0.061397,
    289319 <= (integer)addrcurrentavmvalue60month       => 0.140952,
                0);

tn_subscore14 := map(
    '' < addronfilecollege AND (integer)addronfilecollege < 1 => -0.007589,
    1 <= (integer)addronfilecollege            => 0.828318,
                        0);

tn_rawscore := tn_subscore0 +
    tn_subscore1 +
    tn_subscore2 +
    tn_subscore3 +
    tn_subscore4 +
    tn_subscore5 +
    tn_subscore6 +
    tn_subscore7 +
    tn_subscore8 +
    tn_subscore9 +
    tn_subscore10 +
    tn_subscore11 +
    tn_subscore12 +
    tn_subscore13 +
    tn_subscore14;

tn_lnoddsscore := tn_rawscore + 2.873046;

tn_probscore := exp(tn_lnoddsscore) / (1 + exp(tn_lnoddsscore));

base := 700;

pdo := 40;

odds := (1 - 0.019) / 0.019;

rva1611_1_0 := map(
    (rv5_attr_unscoreable in ['1 SSN DEC']) => 200,
    (rv5_attr_unscoreable in ['2 UNSCORE']) => 222,
             max(min(if(round(pdo * (ln(tn_probscore / (1 - tn_probscore)) - ln(odds)) / ln(2) + base) = NULL, -NULL, round(pdo * (ln(tn_probscore / (1 - tn_probscore)) - ln(odds)) / ln(2) + base)), 900), 501));

tn_aacd_0 := map(
    (ca_m2_inquiryindex in [1]) => 'I60',
    (ca_m2_inquiryindex in [2]) => 'I60',
    (ca_m2_inquiryindex in [3]) => 'I60',
                  '');

tn_dist_0 := tn_subscore0 - 0.327385;

tn_aacd_1 := map(
    '' < addronfilecount AND (integer)addronfilecount < 2 => 'C14',
    2 <= (integer)addronfilecount AND (integer)addronfilecount < 3   => 'C14',
    3 <= (integer)addronfilecount AND (integer)addronfilecount < 5   => 'C14',
    5 <= (integer)addronfilecount          => 'C14',
                    '');

tn_dist_1 := tn_subscore1 - 0.256253;

tn_aacd_2 := map(
    NULL < iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < -1    => 'L77',
    -1 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0      => 'A46',
    0 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.01    => 'A47',
    0.01 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.35 => 'A47',
    0.35 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 0.76 => 'A47',
    0.76 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 1.27 => 'A47',
    1.27 <= iv_inputcurrctyratiosfdavg AND iv_inputcurrctyratiosfdavg < 1.97 => 'A47',
    1.97 <= iv_inputcurrctyratiosfdavg                      => 'A47',
            '');

tn_dist_2 := tn_subscore2 - 0.527862;

tn_aacd_3 := map(
    '' < subjectabilityindex AND (integer)subjectabilityindex < 3 => iv_subjectabilityprimaryfactor,
    3 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 4   => iv_subjectabilityprimaryfactor,
    4 <= (integer)subjectabilityindex AND (integer)subjectabilityindex < 6   => iv_subjectabilityprimaryfactor,
    6 <= (integer)subjectabilityindex              => iv_subjectabilityprimaryfactor,
           iv_subjectabilityprimaryfactor);

tn_dist_3 := tn_subscore3 - 0.431578;

tn_aacd_4 := map(
    (ca_m2_derogseverityindex in [1]) => 'D30',
    (ca_m2_derogseverityindex in [2]) => 'D30',
    (ca_m2_derogseverityindex in [3]) => 'D30',
    (ca_m2_derogseverityindex in [4]) => 'D30',
       '');

tn_dist_4 := tn_subscore4 - 0.050572;

tn_aacd_5 := map(
    (ca_m2_occupation in [1]) => 'C12',
    (ca_m2_occupation in [2]) => 'C12',
    (ca_m2_occupation in [3]) => 'C12',
    (ca_m2_occupation in [4]) => 'C12',
                '');

tn_dist_5 := tn_subscore5 - 0.641148;

tn_aacd_6 := map(
    (ca_m2_nonderogindex06month in [1]) => 'C12',
    (ca_m2_nonderogindex06month in [2]) => 'C12',
    (ca_m2_nonderogindex06month in [3]) => 'C12',
    (ca_m2_nonderogindex06month in [4]) => 'C12',
    (ca_m2_nonderogindex06month in [5]) => 'C12',
         '');

tn_dist_6 := tn_subscore6 - 0.613648;

tn_aacd_7 := map(
    '' < addrinputtimeoldest AND (integer)addrinputtimeoldest < 1 => 'C13',
    1 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 6   => 'C13',
    6 <= (integer)addrinputtimeoldest AND (integer)addrinputtimeoldest < 183 => 'C13',
    183 <= (integer)addrinputtimeoldest            => 'C13',
           '');

tn_dist_7 := tn_subscore7 - 0.466418;

tn_aacd_8 := map(
    '' < ssnsubjectcount AND (integer)ssnsubjectcount < 0 => 'S65',
    0 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 1   => 'S66',
    1 <= (integer)ssnsubjectcount AND (integer)ssnsubjectcount < 2   => 'S66',
    2 <= (integer)ssnsubjectcount          => 'S66',
                    '');

tn_dist_8 := tn_subscore8 - 0.042778;

tn_aacd_9 := map(
    '' < phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 0 => 'P85',
    0 <= (integer)phoneinputsubjectcount AND (integer)phoneinputsubjectcount < 1   => 'P89',
    1 <= (integer)phoneinputsubjectcount                 => 'P89',
                 '');

tn_dist_9 := tn_subscore9 - 0.401651;

tn_aacd_10 := map(
    NULL < iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < -1        => 'L77',
    -1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 0          => 'A46',
    0 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 1           => 'L80',
    1 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 58820       => 'L80',
    58820 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 101200  => 'L80',
    101200 <= iv_inputcurrtaxmarketvaluesfdmax AND iv_inputcurrtaxmarketvaluesfdmax < 180500 => 'L80',
    180500 <= iv_inputcurrtaxmarketvaluesfdmax             => 'L80',
                            '');

tn_dist_10 := tn_subscore10 - 0.519858;

tn_aacd_11 := map(
    '' < sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 1  => 'C12',
    1 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 17   => 'C20',
    17 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 26  => 'C20',
    26 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 41  => 'C20',
    41 <= (integer)sourcecredheadertimeoldest AND (integer)sourcecredheadertimeoldest < 300 => 'C20',
    300 <= (integer)sourcecredheadertimeoldest                    => 'C20',
                          '');

tn_dist_11 := tn_subscore11 - 0.240365;

tn_aacd_12 := map(
    '' < addrinputphonecount AND (integer)addrinputphonecount < 0 => 'L79',
    0 <= (integer)addrinputphonecount AND (integer)addrinputphonecount < 2   => 'L79',
    2 <= (integer)addrinputphonecount AND (integer)addrinputphonecount < 4   => 'L79',
    4 <= (integer)addrinputphonecount              => 'L79',
           '');

tn_dist_12 := tn_subscore12 - 0.045681;

tn_aacd_13 := map(
    '' < addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 1         => 'A47',
    1 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 52613       => 'A47',
    52613 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 76588   => 'A47',
    76588 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 117977  => 'A47',
    117977 <= (integer)addrcurrentavmvalue60month AND (integer)addrcurrentavmvalue60month < 289319 => 'A47',
    289319 <= (integer)addrcurrentavmvalue60month       => 'A47',
                '');

tn_dist_13 := tn_subscore13 - 0.140952;

tn_aacd_14 := map(
    '' < addronfilecollege AND (integer)addronfilecollege < 1 => 'C12',
    1 <= (integer)addronfilecollege            => 'C12',
                        '');

tn_dist_14 := tn_subscore14 - 0.828318;


tn_rcvaluea40 := (integer)(tn_aacd_0 = 'A40') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A40') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A40') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A40') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A40') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A40') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A40') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A40') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A40') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A40') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A40') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A40') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A40') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A40') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A40') * tn_dist_14;
		
tn_rcvaluea41 := (integer)(tn_aacd_0 = 'A41') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A41') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A41') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A41') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A41') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A41') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A41') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A41') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A41') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A41') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A41') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A41') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A41') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A41') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A41') * tn_dist_14;
		
tn_rcvaluea50 := (integer)(tn_aacd_0 = 'A50') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A50') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A50') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A50') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A50') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A50') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A50') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A50') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A50') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A50') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A50') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A50') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A50') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A50') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A50') * tn_dist_14;
		
tn_rcvaluea51 := (integer)(tn_aacd_0 = 'A51') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A51') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A51') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A51') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A51') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A51') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A51') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A51') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A51') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A51') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A51') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A51') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A51') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A51') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A51') * tn_dist_14;
		
tn_rcvaluec10 := (integer)(tn_aacd_0 = 'C10') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'C10') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'C10') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'C10') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'C10') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'C10') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'C10') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'C10') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'C10') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'C10') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'C10') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'C10') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'C10') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'C10') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'C10') * tn_dist_14;
		
tn_rcvalued31 := (integer)(tn_aacd_0 = 'D31') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'D31') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'D31') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'D31') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'D31') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'D31') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'D31') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'D31') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'D31') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'D31') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'D31') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'D31') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'D31') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'D31') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'D31') * tn_dist_14;
		
tn_rcvaluea42 := (integer)(tn_aacd_0 = 'A42') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A42') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A42') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A42') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A42') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A42') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A42') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A42') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A42') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A42') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A42') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A42') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A42') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A42') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A42') * tn_dist_14;
		
tn_rcvalued34 := (integer)(tn_aacd_0 = 'D34') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'D34') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'D34') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'D34') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'D34') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'D34') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'D34') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'D34') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'D34') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'D34') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'D34') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'D34') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'D34') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'D34') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'D34') * tn_dist_14;

tn_rcvaluep89 := (integer)(tn_aacd_0 = 'P89') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'P89') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'P89') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'P89') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'P89') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'P89') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'P89') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'P89') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'P89') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'P89') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'P89') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'P89') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'P89') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'P89') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'P89') * tn_dist_14;

tn_rcvaluel79 := (integer)(tn_aacd_0 = 'L79') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'L79') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'L79') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'L79') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'L79') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'L79') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'L79') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'L79') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'L79') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'L79') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'L79') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'L79') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'L79') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'L79') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'L79') * tn_dist_14;

tn_rcvaluec20 := (integer)(tn_aacd_0 = 'C20') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'C20') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'C20') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'C20') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'C20') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'C20') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'C20') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'C20') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'C20') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'C20') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'C20') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'C20') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'C20') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'C20') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'C20') * tn_dist_14;

tn_rcvaluel80 := (integer)(tn_aacd_0 = 'L80') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'L80') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'L80') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'L80') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'L80') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'L80') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'L80') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'L80') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'L80') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'L80') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'L80') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'L80') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'L80') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'L80') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'L80') * tn_dist_14;

tn_rcvaluel77 := (integer)(tn_aacd_0 = 'L77') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'L77') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'L77') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'L77') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'L77') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'L77') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'L77') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'L77') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'L77') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'L77') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'L77') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'L77') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'L77') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'L77') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'L77') * tn_dist_14;

tn_rcvalued30 := (integer)(tn_aacd_0 = 'D30') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'D30') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'D30') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'D30') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'D30') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'D30') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'D30') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'D30') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'D30') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'D30') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'D30') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'D30') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'D30') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'D30') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'D30') * tn_dist_14;

tn_rcvaluea46 := (integer)(tn_aacd_0 = 'A46') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A46') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A46') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A46') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A46') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A46') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A46') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A46') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A46') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A46') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A46') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A46') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A46') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A46') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A46') * tn_dist_14;

tn_rcvaluea47 := (integer)(tn_aacd_0 = 'A47') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'A47') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'A47') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'A47') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'A47') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'A47') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'A47') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'A47') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'A47') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'A47') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'A47') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'A47') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'A47') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'A47') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'A47') * tn_dist_14;

tn_rcvaluei60 := (integer)(tn_aacd_0 = 'I60') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'I60') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'I60') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'I60') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'I60') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'I60') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'I60') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'I60') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'I60') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'I60') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'I60') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'I60') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'I60') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'I60') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'I60') * tn_dist_14;

tn_rcvaluep85 := (integer)(tn_aacd_0 = 'P85') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'P85') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'P85') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'P85') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'P85') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'P85') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'P85') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'P85') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'P85') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'P85') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'P85') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'P85') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'P85') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'P85') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'P85') * tn_dist_14;

tn_rcvaluec13 := (integer)(tn_aacd_0 = 'C13') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'C13') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'C13') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'C13') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'C13') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'C13') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'C13') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'C13') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'C13') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'C13') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'C13') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'C13') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'C13') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'C13') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'C13') * tn_dist_14;

tn_rcvaluec12 := (integer)(tn_aacd_0 = 'C12') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'C12') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'C12') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'C12') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'C12') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'C12') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'C12') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'C12') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'C12') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'C12') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'C12') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'C12') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'C12') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'C12') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'C12') * tn_dist_14;

tn_rcvalues65 := (integer)(tn_aacd_0 = 'S65') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'S65') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'S65') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'S65') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'S65') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'S65') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'S65') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'S65') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'S65') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'S65') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'S65') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'S65') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'S65') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'S65') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'S65') * tn_dist_14;

tn_rcvalues66 := (integer)(tn_aacd_0 = 'S66') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'S66') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'S66') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'S66') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'S66') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'S66') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'S66') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'S66') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'S66') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'S66') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'S66') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'S66') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'S66') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'S66') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'S66') * tn_dist_14;

tn_rcvaluec14 := (integer)(tn_aacd_0 = 'C14') * tn_dist_0 +
    (integer)(tn_aacd_1 = 'C14') * tn_dist_1 +
    (integer)(tn_aacd_2 = 'C14') * tn_dist_2 +
    (integer)(tn_aacd_3 = 'C14') * tn_dist_3 +
    (integer)(tn_aacd_4 = 'C14') * tn_dist_4 +
    (integer)(tn_aacd_5 = 'C14') * tn_dist_5 +
    (integer)(tn_aacd_6 = 'C14') * tn_dist_6 +
    (integer)(tn_aacd_7 = 'C14') * tn_dist_7 +
    (integer)(tn_aacd_8 = 'C14') * tn_dist_8 +
    (integer)(tn_aacd_9 = 'C14') * tn_dist_9 +
    (integer)(tn_aacd_10 = 'C14') * tn_dist_10 +
    (integer)(tn_aacd_11 = 'C14') * tn_dist_11 +
    (integer)(tn_aacd_12 = 'C14') * tn_dist_12 +
    (integer)(tn_aacd_13 = 'C14') * tn_dist_13 +
    (integer)(tn_aacd_14 = 'C14') * tn_dist_14;


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};


 
//*************************************************************************************//
rc_dataset_tn := DATASET([
    {'A40', tn_rcvalueA40},
    {'A41', tn_rcvalueA41},
    {'A50', tn_rcvalueA50},
    {'A51', tn_rcvalueA51},
    {'C10', tn_rcvalueC10},
    {'D31', tn_rcvalueD31},
    {'A42', tn_rcvalueA42},
    {'D34', tn_rcvalueD34},
    {'P89', tn_rcvalueP89},
    {'L79', tn_rcvalueL79},
    {'C20', tn_rcvalueC20},
    {'L80', tn_rcvalueL80},
    {'L77', tn_rcvalueL77},
    {'D30', tn_rcvalueD30},
    {'A46', tn_rcvalueA46},
    {'A47', tn_rcvalueA47},
    {'I60', tn_rcvalueI60},
    {'P85', tn_rcvalueP85},
    {'C13', tn_rcvalueC13},
    {'C12', tn_rcvalueC12},
    {'S65', tn_rcvalueS65},
    {'S66', tn_rcvalueS66},
    {'C14', tn_rcvalueC14}
    ], ds_layout)(value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_tn_sorted := sort(rc_dataset_tn, rc_dataset_tn.value);

tn_rc1 := rc_dataset_tn_sorted[1].rc;
tn_rc2 := rc_dataset_tn_sorted[2].rc;
tn_rc3 := rc_dataset_tn_sorted[3].rc;
tn_rc4 := rc_dataset_tn_sorted[4].rc;

tn_vl1 := rc_dataset_tn_sorted[1].value;
tn_vl2 := rc_dataset_tn_sorted[2].value;
tn_vl3 := rc_dataset_tn_sorted[3].value;
tn_vl4 := rc_dataset_tn_sorted[4].value;
//*************************************************************************************//

rc1_3 := tn_RC1;

rc2_2 := tn_RC2;

rc3_2 := tn_RC3;

rc4_2 := tn_RC4;

rc1_2 := if(trim((string)rc1_3, ALL) = '', 'C10', rc1_3);

_rc_inq := if((integer)inquiryshortterm12month = 1 or (integer)inquirytelcom12month = 1 or (integer)inquiryauto12month = 1, 'I60', '   ');

// rc4_c46 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
           // '');

rc5_c46 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           _rc_inq);

// rc2_c46 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc1_c46 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc3_c46 := map(
    // trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    // trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    // trim((string)rc4_2, LEFT, RIGHT) = '' => '',
           // '');

// rc4_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc4_c46, rc4_2);

rc5_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc5_c46, '');

// rc2_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc2_c46, rc2_2);

// rc1_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc1_c46, rc1_2);

// rc3_1 := if(not((rc1_2 in ['I60'])) and not((rc2_2 in ['I60'])) and not((rc3_2 in ['I60'])) and not((rc4_2 in ['I60'])), rc3_c46, rc3_2);

rc2 := if((rva1611_1_0 in [200, 222]), '', rc2_2);

rc1 := if((rva1611_1_0 in [200, 222]), '', rc1_2);

rc3 := if((rva1611_1_0 in [200, 222]), '', rc3_2);

rc4 := if((rva1611_1_0 in [200, 222]), '', rc4_2);

rc5 := if((rva1611_1_0 in [200, 222]), '', rc5_1);



//*************************************************************************************//
//     RiskView Version 5 Reason Code Overrides 
//             ECL DEVELOPERS, MAKE SURE ALL RiskView V5 MODELS HAVE THIS
//*************************************************************************************//
	
HRILayout := RECORD
	STRING4 HRI := '';
END;
reasonsOverrides := MAP(
													// In Version 5 200 and 222 scores will not return reason codes, the will instead return alert codes
													RVA1611_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVA1611_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVA1611_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
	 self.seq															 := le.seq;
	 self.sysdate													 := sysdate;
	 self.subjectrecordtimeoldest	         := subjectrecordtimeoldest;
   self.lienjudgmentcount	               := lienjudgmentcount;
   self.ssndeceased	                     := ssndeceased;
   self.confirmationsubjectfound	       :=	confirmationsubjectfound;
   self.addronfilecount	                 :=	addronfilecount;
   self.subjectabilityprimaryfactor	     :=	subjectabilityprimaryfactor;
   self.inquirytelcom12month	           :=	inquirytelcom12month;
   self.inquiryshortterm12month	         :=	inquiryshortterm12month;
   self.inquiryauto12month	             :=	inquiryauto12month;
   self.evictioncount	                   :=	evictioncount;
   self.criminalfelonycount	             :=	criminalfelonycount;
   self.bankruptcystatus	               :=	bankruptcystatus;
   self.criminalnonfelonycount	         :=	criminalnonfelonycount;
   self.profliccount	                   :=	profliccount;
   self.educationprogramattended	       :=	educationprogramattended;
   self.businessassociation	             :=	businessassociation;
   self.sourcenonderogcount	             :=	sourcenonderogcount;
   self.sourcenonderogcount06month	     :=	sourcenonderogcount06month;
   self.addrinputdwelltype	             :=	addrinputdwelltype;
   self.addrinputtaxmarketvalue	         :=	addrinputtaxmarketvalue;
   self.addrcurrentdwelltype	           :=	addrcurrentdwelltype;
   self.addrcurrenttaxmarketvalue	       :=	addrcurrenttaxmarketvalue;
   self.inputtaxmarket	                 :=	inputtaxmarket;
   self.addrinputcountyratio	           :=	addrinputcountyratio;
   self.addrcurrentcountyratio	         :=	addrcurrentcountyratio;
   self.subjectabilityindex	             :=	subjectabilityindex;
   self.addrinputtimeoldest	             :=	addrinputtimeoldest;
   self.ssnsubjectcount	                 :=	ssnsubjectcount;
   self.phoneinputsubjectcount	         :=	phoneinputsubjectcount;
   self.sourcecredheadertimeoldest	     :=	sourcecredheadertimeoldest;
   self.addrinputphonecount	             :=	addrinputphonecount;
   self.addrcurrentavmvalue60month	     := addrcurrentavmvalue60month;
   self.addronfilecollege	               :=	addronfilecollege;
   self.rv5_attr_unscoreable             := rv5_attr_unscoreable;
   self.iv_subjectabilityprimaryfactor   := iv_subjectabilityprimaryfactor;
   self.ca_m2_inquiryindex               := ca_m2_inquiryindex;
   self.ca_m2_derogseverityindex         := ca_m2_derogseverityindex;
   self.ca_m2_occupation                 := ca_m2_occupation;
   self.ca_m2_nonderogindex06month       := ca_m2_nonderogindex06month;
   self.currenttaxmarket                 := currenttaxmarket;
   self.iv_inputcurrtaxmarketvaluesfdmax := iv_inputcurrtaxmarketvaluesfdmax;
   self.currentcountyratio               := currentcountyratio;
   self.iv_inputcurrctyratiosfdavg       := iv_inputcurrctyratiosfdavg;
   self.tn_subscore0    := tn_subscore0;
   self.tn_subscore1    := tn_subscore1;
   self.tn_subscore2    := tn_subscore2;
   self.tn_subscore3    := tn_subscore3;
   self.tn_subscore4    := tn_subscore4;
   self.tn_subscore5    := tn_subscore5;
   self.tn_subscore6    := tn_subscore6;
   self.tn_subscore7    := tn_subscore7;
   self.tn_subscore8    := tn_subscore8;
   self.tn_subscore9    := tn_subscore9;
   self.tn_subscore10   := tn_subscore10;
   self.tn_subscore11   := tn_subscore11;
   self.tn_subscore12   := tn_subscore12;
   self.tn_subscore13   := tn_subscore13;
   self.tn_subscore14   := tn_subscore14;
   self.tn_rawscore     := tn_rawscore;
   self.tn_lnoddsscore                   := tn_lnoddsscore;
   self.tn_probscore    := tn_probscore;
   self.base            := base;
   self.pdo             := pdo;
   self.odds            := odds;
   self.rva1611_1_0     := rva1611_1_0;
   self.tn_aacd_0       := tn_aacd_0;
   self.tn_dist_0       := tn_dist_0;
   self.tn_aacd_1       := tn_aacd_1;
   self.tn_dist_1       := tn_dist_1;
   self.tn_aacd_2       := tn_aacd_2;
   self.tn_dist_2       := tn_dist_2;
   self.tn_aacd_3       := tn_aacd_3;
   self.tn_dist_3       := tn_dist_3;
   self.tn_aacd_4       := tn_aacd_4;
   self.tn_dist_4       := tn_dist_4;
   self.tn_aacd_5       := tn_aacd_5;
   self.tn_dist_5       := tn_dist_5;
   self.tn_aacd_6       := tn_aacd_6;
   self.tn_dist_6       := tn_dist_6;
   self.tn_aacd_7       := tn_aacd_7;
   self.tn_dist_7       := tn_dist_7;
   self.tn_aacd_8       := tn_aacd_8;
   self.tn_dist_8       := tn_dist_8;
   self.tn_aacd_9       := tn_aacd_9;
   self.tn_dist_9       := tn_dist_9;
   self.tn_aacd_10      := tn_aacd_10;
   self.tn_dist_10      := tn_dist_10;
   self.tn_aacd_11      := tn_aacd_11;
   self.tn_dist_11      := tn_dist_11;
   self.tn_aacd_12      := tn_aacd_12;
   self.tn_dist_12      := tn_dist_12;
   self.tn_aacd_13      := tn_aacd_13;
   self.tn_dist_13      := tn_dist_13;
   self.tn_aacd_14      := tn_aacd_14;
   self.tn_dist_14      := tn_dist_14;
   self.tn_rcvaluep89   := tn_rcvaluep89;
   self.tn_rcvaluel79   := tn_rcvaluel79;
   self.tn_rcvaluec20   := tn_rcvaluec20;
   self.tn_rcvaluel80   := tn_rcvaluel80;
   self.tn_rcvaluel77   := tn_rcvaluel77;
   self.tn_rcvalued30   := tn_rcvalued30;
   self.tn_rcvaluea46   := tn_rcvaluea46;
   self.tn_rcvaluea47   := tn_rcvaluea47;
   self.tn_rcvaluei60   := tn_rcvaluei60;
   self.tn_rcvaluep85   := tn_rcvaluep85;
   self.tn_rcvaluec13   := tn_rcvaluec13;
   self.tn_rcvaluec12   := tn_rcvaluec12;
   self.tn_rcvalues65   := tn_rcvalues65;
   self.tn_rcvalues66   := tn_rcvalues66;
   self.tn_rcvaluec14   := tn_rcvaluec14;
   self._rc_inq         := _rc_inq;
   self.tn_rc1          := tn_rc1;
   self.tn_rc2          := tn_rc2;
   self.tn_rc3          := tn_rc3;
   self.tn_rc4          := tn_rc4;
   self.tn_vl1          := tn_vl1;
   self.tn_vl2          := tn_vl2;
   self.tn_vl3          := tn_vl3;
   self.tn_vl4          := tn_vl4;
	 self.rc1                              := rc1;
	 self.rc2                              := rc2;
	 self.rc3                              := rc3;
	 self.rc4                              := rc4;
	 self.rc5                              := rc5;



		self.clam 														:= rt;
	#else
		self.ri 		:= PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		self.score 	:= (STRING3)rva1611_1_0;
		self.seq 		:= le.seq;
	#end
	END;

	model := join(attributes, clam, left.seq=right.seq, doModel(LEFT, right));

	RETURN(model);
END;
