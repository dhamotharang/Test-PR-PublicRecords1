IMPORT STD, PhoneFinder_Services;

// These options are only for phone searches, at a time only one of these can be set, these are used to verify info found on phone searches with entered PII

// VerifyPhoneName := FALSE;
// VerifyPhoneLastName := FALSE;
// VerifyPhoneNameAddress := FALSE; 

isPhoneSearch := FALSE;//Option to set type of search, PII or phone search

dInputConfig := DATASET([{'ULTIMATE', '00000000000000000000000000000000000', '1111111111111111111111111111111111111111',
                          '3', '5', FALSE, FALSE, FALSE}], PhoneFinder_Services.ScoringReport.Layouts.Input_Config);

// nrecs := 5;
nrecs := CHOOSEN:ALL;

eyeball := 25;//Test sample

Today := STD.Date.today();
    
inputfile := '~Sample::in::thor_pii_phone_test_all-' + Today + '.csv';//Name of input file

outputfile := '~Sample::out::PhoneFinder-' + '-' + Today + '-' + WORKUNIT + '.csv';
    

Input_layout := PhoneFinder_Services.ScoringReport.Layouts.Input_Layout;

//Input file with requests
dsIn_raw := DATASET(inputfile, PhoneFinder_Services.ScoringReport.Layouts.RawInput_Layout, CSV(QUOTE('"')));
// dInputReq_all := DATASET(inputfile, Input_layout ,CSV(QUOTE('"')));
 dInputReq_all := PROJECT(dsIn_raw, Input_layout);

// output(choosen(dInputReq_all, eyeball), named('sample_input'));

//This can be modified as per usecase
dInputReq_toProcess := CHOOSEN(IF(
    isPhoneSearch,
    dInputReq_all,
    /* Blank out input phone if not a phone search */
    PROJECT(dInputReq_all, TRANSFORM(Input_layout, SELF.HomePhone := ''; SELF := LEFT))
), nrecs);


dOutput := PhoneFinder_Services.ScoringReport.GetScoringReport(dInputReq_toProcess, dInputConfig, isPhoneSearch);

output(choosen(dOutput, eyeball), named('sample_output'));

output(dOutput,,outputfile, CSV(HEADING(SINGLE), QUOTE('"')));




