EXPORT getStabilityIndex(grouped dataset(riskview.layouts.attributes_internal_layout) ds_in ) := function

// mydebug := record
	// real subScore0; real subscore1; real subscore2; real subscore3; real subscore4; real subscore5; //real subscore6; real subscore7; real subScore8;
	// riskview.layouts.attributes_internal_layout;
// end;

riskview.layouts.attributes_internal_layout add_stability(ds_in le) := transform
// mydebug add_stability(ds_in le) := transform

NULL := -999999999;

SubjectDeceased := (integer)le.SubjectDeceased;
ConfirmationSubjectFound := (integer)le.ConfirmationSubjectFound;
SourceVoterRegistration := (integer)le.SourceVoterRegistration;
SSNDeceased := (integer)le.SSNDeceased;
AddrOnFileCorrectional := (integer)le.AddrOnFileCorrectional;
AddrInputLengthOfRes := (integer)le.AddrInputLengthOfRes;
AddrInputMatchIndex := (integer)le.AddrInputMatchIndex;
AddrInputPhoneService := (integer)le.AddrInputPhoneService;
AddrChangeCount03Month := (integer)le.AddrChangeCount03Month;
AddrChangeCount06Month := (integer)le.AddrChangeCount06Month;
AddrChangeCount12Month := (integer)le.AddrChangeCount12Month;
AddrChangeCount24Month := (integer)le.AddrChangeCount24Month;
AddrChangeCount60Month := (integer)le.AddrChangeCount60Month;


subscore0 := map(
    NULL < SourceVoterRegistration AND SourceVoterRegistration < 0 => 0.000000,
    0 <= SourceVoterRegistration AND SourceVoterRegistration < 1   => -0.004361,
    1 <= SourceVoterRegistration                                   => 0.006250,
                                                                      0.000000);

rcvaluec12_1 := 0.006250 - subScore0 ;

subscore1 := map(
    NULL < AddrOnFileCorrectional AND AddrOnFileCorrectional < 0 => -0.000000,
    0 <= AddrOnFileCorrectional AND AddrOnFileCorrectional < 1   => 0.000803,
    1 <= AddrOnFileCorrectional                                  => -0.711779,
                                                                    0.000000);

rcvaluec19_1 := 0.000803 - subScore1;

subscore2 := map(
    NULL < AddrInputLengthOfRes AND AddrInputLengthOfRes < 1   => -0.156869,
    1 <= AddrInputLengthOfRes AND AddrInputLengthOfRes < 101   => -0.017235,
    101 <= AddrInputLengthOfRes AND AddrInputLengthOfRes < 111 => -0.020644,
    111 <= AddrInputLengthOfRes AND AddrInputLengthOfRes < 121 => -0.009004,
    121 <= AddrInputLengthOfRes                                => 0.163424,
                                                                  -0.000000);

rcvaluec13_1 := 0.163424 - subScore2;

subscore3 := map(
    NULL < AddrInputMatchIndex AND AddrInputMatchIndex < 0 => 0.000000,
    0 <= AddrInputMatchIndex AND AddrInputMatchIndex < 1   => -0.078831,
    1 <= AddrInputMatchIndex AND AddrInputMatchIndex < 2   => -0.240503,
    2 <= AddrInputMatchIndex                               => 0.068245,
                                                              0.000000);

rcvaluef04_1 := 0.068245 - subScore3;


subscore4 := map(
    NULL < AddrInputPhoneService AND AddrInputPhoneService < 0 => -0.000000,
    0 <= AddrInputPhoneService AND AddrInputPhoneService < 1   => -0.089112,
    1 <= AddrInputPhoneService                                   => 0.181185,
                                                                      -0.000000);

rcvaluel78_1 := 0.181185 - subScore4;

addr_chg_level := map(
    AddrChangeCount60Month = -1                                                               => -1,
    AddrChangeCount60Month = 0                                                                => 1,
    AddrChangeCount60Month >= 10                                                              => 10,
    AddrChangeCount60Month >= 8 or AddrChangeCount24Month >= 6                                => 9,
    AddrChangeCount60Month >= 7 or AddrChangeCount24Month >= 5                                => 8,
    AddrChangeCount06Month >= 4 or AddrChangeCount60Month >= 6                                => 7,
    AddrChangeCount12Month >= 3 or AddrChangeCount24Month >= 4 or AddrChangeCount60Month >= 5 => 6,
    AddrChangeCount60Month >= 4 or AddrChangeCount24Month >= 3                                => 5,
    AddrChangeCount60Month >= 3 or AddrChangeCount24Month >= 2                                => 4,
    AddrChangeCount03Month > 0                                                                => 3,
                                                                                                 2);

subscore5 := map(
    NULL < addr_chg_level AND addr_chg_level < 1 => -0.000000,
    1 <= addr_chg_level AND addr_chg_level < 2   => 0.216821,
    2 <= addr_chg_level AND addr_chg_level < 3   => -0.028037,
    3 <= addr_chg_level AND addr_chg_level < 4   => -0.204781,
    4 <= addr_chg_level AND addr_chg_level < 5   => -0.280706,
    5 <= addr_chg_level AND addr_chg_level < 6   => -0.429965,
    6 <= addr_chg_level AND addr_chg_level < 7   => -0.661156,
    7 <= addr_chg_level AND addr_chg_level < 8   => -0.857725,
    8 <= addr_chg_level AND addr_chg_level < 9   => -0.997162,
    9 <= addr_chg_level AND addr_chg_level < 10  => -1.119851,
    10 <= addr_chg_level                         => -1.661167,
                                                    -0.000000);

rcvaluec14_1 := 0.216821 - subScore5;

rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5;

lnoddsscore := rawscore * 1.000000 + 3.603774;

scaledscore := rawscore * 1.000000 + 3.603774;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

score2 := round(40 * (ln(probscore / (1 - probscore)) - ln(20)) / ln(2) + 700);

subjectstabilityindex1 := if(ConfirmationSubjectFound = 0 or SSNDeceased = 1 or SubjectDeceased = 1, 222, min(900, if(max(501, score2) = NULL, -NULL, max(501, score2))));

subjectstabilityindex := map(
    subjectstabilityindex1 = 222  => -1,
    subjectstabilityindex1 <= 713 => 1,
    subjectstabilityindex1 <= 717 => 2,
    subjectstabilityindex1 <= 729 => 3,
    subjectstabilityindex1 <= 732 => 4,
    subjectstabilityindex1 <= 745 => 5,
    subjectstabilityindex1 <= 747 => 6,
    subjectstabilityindex1 <= 756 => 7,
    subjectstabilityindex1 <= 771 => 8,
                                     9);

rcvaluec14 := rcvaluec14_1;

rcvaluec12 := rcvaluec12_1;

rcvaluec13 := rcvaluec13_1;

rcvaluef04 := rcvaluef04_1;

rcvaluel78 := rcvaluel78_1;

rcvaluec19 := rcvaluec19_1;

ds_layout := {STRING rc, REAL value1};

rc_dataset := DATASET([
    {'C14' , RCValueC14},
    {'C12' , RCValueC12},
    {'C13' , RCValueC13},
    {'F04' , RCValueF04},
    {'L78' , RCValueL78},
    {'C19' , RCValueC19}
    ], ds_layout);

// IMPORTANT NOTE:  Select the primary factor ONLY if its value is > 0.  
sorted_factors := sort(rc_dataset(value1 > 0), -value1);
SubjectStabilityPrimaryFactor := sorted_factors[1].rc;

	self.SubjectStabilityIndex	:= (string)SubjectStabilityIndex;
	
	self.SubjectStabilityPrimaryFactor := map(SubjectStabilityIndex = -1 => '-1',
																						SubjectStabilityPrimaryFactor='' => '0', 
																						SubjectStabilityPrimaryFactor)	;
																			

	// self.subscore0 := subscore0;
	// self.subscore1 := subscore1;
	// self.subscore2 := subscore2;
	// self.subscore3 := subscore3;
	// self.subscore4 := subscore4;
	// self.subscore5 := subscore5;

	
	self := le;

end;

with_stability := project(ds_in, add_stability(left));

return with_stability;

end;