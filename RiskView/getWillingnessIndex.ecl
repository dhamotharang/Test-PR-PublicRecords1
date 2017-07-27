EXPORT getWillingnessIndex(grouped dataset(riskview.layouts.attributes_internal_layout) ds_in ) := function


// mydebug := record
	// real subScore0; real subscore1; real subscore2; real subscore3; real subscore4; real subscore5; real subscore6; 
	// integer inq_lvl;
	// riskview.layouts.attributes_internal_layout;
// end;

// mydebug add_willingness(ds_in le) := transform
riskview.layouts.attributes_internal_layout add_willingness(ds_in le) := transform

NULL := -999999999;

SubjectDeceased := (integer)le.SubjectDeceased;
ConfirmationSubjectFound := (integer)le.ConfirmationSubjectFound;
SourceNonDerogProfileIndex := (integer)le.SourceNonDerogProfileIndex;
SourceNonDerogCount03Month := (integer)le.SourceNonDerogCount03Month;
CriminalFelonyCount := (integer)le.CriminalFelonyCount;
CriminalNonFelonyCount := (integer)le.CriminalNonFelonyCount;
EvictionTimeNewest := (integer)le.EvictionTimeNewest;
LienJudgmentCount := (integer)le.LienJudgmentCount;
LienJudgmentCount12Month := (integer)le.LienJudgmentCount12Month;
ShortTermLoanRequest := (integer)le.ShortTermLoanRequest;
ShortTermLoanRequest12Month := (integer)le.ShortTermLoanRequest12Month;
InquiryAutoCount12Month := (integer)le.InquiryAuto12Month;
InquiryBankingCount12Month := (integer)le.InquiryBanking12Month;
InquiryTelcomCount12Month := (integer)le.InquiryTelcom12Month;
InquiryNonShortTermCount12Month := (integer)le.InquiryNonShortTerm12Month;
InquiryShortTermCount12Month := (integer)le.InquiryShortTerm12Month;
InquiryCollectionsCount12Month := (integer)le.InquiryCollections12Month;
SSNDeceased := (integer)le.SSNDeceased;

subscore0 := map(
    NULL < SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 0 => -0.000000,
    0 <= SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 1   => -0.252492,
    1 <= SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 5   => -0.084835,
    5 <= SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 6   => -0.058991,
    6 <= SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 7   => 0.063234,
    7 <= SourceNonDerogProfileIndex AND SourceNonDerogProfileIndex < 8   => 0.128152,
    8 <= SourceNonDerogProfileIndex 																		  => 0.197441,
                                                                            -0.000000);

rcvaluec12_1 := 0.197441 - subscore0;

subscore1 := map(
    NULL < SourceNonDerogCount03Month AND SourceNonDerogCount03Month < 0 => 0.000000,
    0 <= SourceNonDerogCount03Month AND SourceNonDerogCount03Month < 2   => -0.119467,
    2 <= SourceNonDerogCount03Month AND SourceNonDerogCount03Month < 3   => 0.106021,
    3 <= SourceNonDerogCount03Month                                      => 0.419634,
                                                                            0.000000);

rcvaluec12_2 := 0.419634 - subscore1;

subscore2 := map(
    NULL < EvictionTimeNewest AND EvictionTimeNewest < 1 => 0.053149,
    1 <= EvictionTimeNewest AND EvictionTimeNewest < 22  => -1.209278,
    22 <= EvictionTimeNewest AND EvictionTimeNewest < 45  => -0.852782,
    45 <= EvictionTimeNewest AND EvictionTimeNewest < 49  => -0.769531,
    49 <= EvictionTimeNewest                             => -0.623584,
                                                            0.000000);

rcvalued33_1 := 0.053149 - subscore2;

lien_lvl := map(
    LienJudgmentCount = -1        => -1,
    LienJudgmentCount = 0         => 1,
    LienJudgmentCount12Month >= 3 => 5,
    LienJudgmentCount12Month > 0  => 4,
    LienJudgmentCount >= 3        => 3,
                                     2);

subscore3 := map(
    NULL < lien_lvl AND lien_lvl < 1 => -0.000000,
    1 <= lien_lvl AND lien_lvl < 2   => 0.096211,
    2 <= lien_lvl AND lien_lvl < 3   => -0.519974,
    3 <= lien_lvl AND lien_lvl < 4   => -0.655765,
    4 <= lien_lvl AND lien_lvl < 5   => -0.839192,
    5 <= lien_lvl                    => -0.956563,
                                        -0.000000);

rcvalued34_1 := 0.096211 - subscore3;

inq_lvl := map(
    InquiryCollectionsCount12Month = -1                                                                                                                                                                                  => -1,
    InquiryCollectionsCount12Month = 0 and InquiryShortTermCount12Month = 0 and InquiryNonShortTermCount12Month = 0 and 
					InquiryTelcomCount12Month = 0 and InquiryBankingCount12Month = 0 and InquiryAutoCount12Month = 0 => 1,
    InquiryShortTermCount12Month > 0 => 3,
		2);

subscore4 := map(
    NULL < inq_lvl AND inq_lvl < 1 => 0.000000,
    1 <= inq_lvl AND inq_lvl < 2   => 0.095386,
    2 <= inq_lvl AND inq_lvl < 3   => -0.673407,
    3 <= inq_lvl  							    => -1.325273,
                                      0.000000);

rcvaluei60_1 := 0.095386 - subscore4;

criminal_total := if(CriminalNonFelonyCount = -1, -1, CriminalNonFelonyCount + CriminalFelonyCount);

subscore5 := map(
    NULL < criminal_total AND criminal_total < 0 => -0.000000,
    0 <= criminal_total AND criminal_total < 1   => 0.014431,
    1 <= criminal_total                          => -0.509840,
                                                    0.000000);

rcvalued32_1 := 0.014431 - subscore5;

short_term_loan_lvl := map(
    ShortTermLoanRequest12Month = -1 => -1,
    ShortTermLoanRequest12Month > 0  => 3,
    ShortTermLoanRequest > 0         => 2,
                                        1);

subscore6 := map(
    NULL < short_term_loan_lvl AND short_term_loan_lvl < 1 => -0.000000,
    1 <= short_term_loan_lvl AND short_term_loan_lvl < 2   => 0.090686,
    2 <= short_term_loan_lvl AND short_term_loan_lvl < 3   => -0.607244,
    3 <= short_term_loan_lvl                               => -1.464473,
                                                              -0.000000);

rcvaluec21_1 := 0.090686 - subscore6;

rawscore := subscore0 +
    subscore1 +
    subscore2 +
    subscore3 +
    subscore4 +
    subscore5 +
    subscore6;

lnoddsscore := rawscore * 1.000000 + 3.544878;

scaledscore := rawscore * 1.000000 + 3.544878;

probscore := exp(lnoddsscore) / (1 + exp(lnoddsscore));

score2 := round(40 * (ln(probscore / (1 - probscore)) - ln(20)) / ln(2) + 700);

subjectwillingnessindex1 := if(ConfirmationSubjectFound = 0 or SSNDeceased = 1 or SubjectDeceased = 1, 222, min(900, if(max(501, score2) = NULL, -NULL, max(501, score2))));

subjectwillingnessindex := map(
    subjectwillingnessindex1 = 222  => -1,
    subjectwillingnessindex1 <= 710 => 1,
    subjectwillingnessindex1 <= 740 => 2,
    subjectwillingnessindex1 <= 742 => 3,
    subjectwillingnessindex1 <= 749 => 4,
    subjectwillingnessindex1 <= 753 => 5,
    subjectwillingnessindex1 <= 755 => 6,
    subjectwillingnessindex1 <= 765 => 7,
    subjectwillingnessindex1 <= 769 => 8,
                                       9);

rcvaluec12 := rcvaluec12_1 + rcvaluec12_2;

rcvalued33 := rcvalued33_1;

rcvalued32 := rcvalued32_1;

rcvalued34 := rcvalued34_1;

rcvaluei60 := rcvaluei60_1;

rcvaluec21 := rcvaluec21_1;

ds_layout := {STRING rc, REAL value1};

rc_dataset := DATASET([
    {'C12' , RCValueC12},
    {'D33' , RCValueD33},
    {'D32' , RCValueD32},
    {'D34' , RCValueD34},
    {'I60' , RCValueI60},
    {'C21' , RCValueC21}
    ], ds_layout);

// IMPORTANT NOTE:  Select the primary factor ONLY if its value is > 0.  
sorted_factors :=  sort(rc_dataset(value1 > 0), -value1);
SubjectWillingnessPrimaryFactor := sorted_factors[1].rc;

	self.SubjectWillingnessIndex	:= (string)subjectwillingnessindex;

	self.SubjectWillingnessPrimaryFactor := map(subjectwillingnessindex = -1 => '-1',
																						SubjectWillingnessPrimaryFactor='' => '0', 
																						SubjectWillingnessPrimaryFactor)	;
																						
	// self.subscore0 := subscore0;
	// self.subscore1 := subscore1;
	// self.subscore2 := subscore2;
	// self.subscore3 := subscore3;
	// self.subscore4 := subscore4;
	// self.subscore5 := subscore5;
	// self.subscore6 := subscore6;
	// self.inq_lvl := inq_lvl;
	self := le;

end;

with_willingness := project(ds_in, add_willingness(left));

return with_willingness;

end;
