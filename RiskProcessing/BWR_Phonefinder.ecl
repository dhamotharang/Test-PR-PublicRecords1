/* Notes to modeler:
  * PM (David Wagner) has stated that 2k should generally be an upper
    bound for rec count
  * Product may not be tested using cell/work phone
*/

IMPORT STD, PhoneFinder_Services;

nrecs := 0; // Records to process - 0 to run all.
eyeball := 10; // Records to show in sample output

/* Product Config */

/* ------------------------------------------------------------------- */
/* Must always be specified by consultant */

PFType := 'ULTIMATE'; // Choices: BASIC, ULTIMATE, PREMIUM, PHONERISKASSESSMENT
isPhoneSearch := TRUE;//Option to set type of search. FALSE => PII Search; TRUE => phone search. TRUE to use phone as input
PIIVerification := ''; /* Choices: '', 'NAME', 'LASTNAME', 'NAMEADDRESS'.
                          Treated as '' for values not listed.
                          Also treated as '' if isPhoneSearch = FALSE. In other words,
                            it only has an effect if running a Phone Search
                       */
QSent_Credential_Level := 2; /* 0 = Legal/Gov
                                1 = FinancialNoConsumer
                                2 = FinancialService
                                3 = FirstDataService
                                4 = CorporateMarkets */
/* ------------------------------------------------------------------- */
/* Default False unless otherwise specified by consultant: */

Use_InquirySource := true;
Use_Zumigo := true;  // MNO
/* ------------------------------------------------------------------- */


/* input and output filenames */

InputFile := '~bweiner::in::ecl_in-Lyft9974.csv';
OutputFile := '~bweiner::out::PhoneFinder_'
    + PFType + IF(isPhoneSearch, '_PhoneSearch_', '_PersonSearch_')
    + 'Lyft9974_' + WORKUNIT;


/**************************************************
No changes needed below here in normal processing
***************************************************/

Input_layout := Record
  STRING Account;
  STRING First;
  STRING Middle;
  STRING Last;
  STRING StreetAddress;
  STRING City;
  STRING State;
  STRING Zip;
  STRING HomePhone;
  STRING SSN;
  STRING DateOfBirth;
  STRING WorkPhone;
  STRING Income;
  STRING DLnumber;
  STRING DLstate;
  STRING Balance;
  STRING ChargeOfFd;
  STRING FormerName;
  STRING Email;
  STRING EmployerName;
  STRING HistoryDate;
  STRING LexId; /* QUESTION: is this needed? */
END;


ConfigureDRM(INTEGER qsent, BOOLEAN use_inq) := FUNCTION
    Base_DRM := '0000000040000101000000000000000000000000'; /* Using "Corporate markets; no inq" as base.
                                                               Parameters `qsent` and `use_inq` will *always*
                                                               override the hard-coded bits */
    qsent_mask := ((STRING) qsent)[1];
    inq_mask := IF(use_inq, '0', '1');
    RETURN Base_DRM[1..8] + qsent_mask + Base_DRM[10..15] + inq_mask + Base_DRM[17..];
END;

Input_config := RECORD
	STRING PFType := PFType;
    STRING DRM := ConfigureDRM(QSent_Credential_Level, Use_InquirySource);
    STRING DPM := IF(Use_Zumigo, '110001000000000000001000000000', '110001000000000000000000000000');
    STRING GLBPurpose := 5;
    STRING DLPurpose := 3;
	BOOLEAN VerifyPhoneName := (PIIVerification = 'NAME') AND IsPhoneSearch;
	BOOLEAN VerifyPhoneLastName := (PIIVerification = 'LASTNAME') AND IsPhoneSearch;
	BOOLEAN VerifyPhoneNameAddress := (PIIVerification = 'NAMEADDRESS') AND IsPhoneSearch;
END;

//Input file with requests
dInputReq_all := Choosen(DATASET(InputFile, Input_layout ,CSV(QUOTE('"'))),IF(nrecs>0, nrecs, CHOOSEN:ALL));//name of the file to be processed

//This can be modified as per usecase
dInputReq_toProcess := IF(
    isPhoneSearch,
    dInputReq_all,
    /* Blank out input phone if not a phone search */
    PROJECT(dInputReq_all, TRANSFORM(Input_layout, SELF.HomePhone := ''; SELF := LEFT))
);
output(CHOOSEN(dInputReq_toProcess, eyeball), named('sample_input'));

dInputConfig := DATASET(ROW(Input_Config));

output(count(dInputReq_toProcess), named('n_input'));
output(dInputConfig, named('settings'));

/* PROPOSED CHANGE: We (Tim and Ben) recommend moving some (but not all) of the macro into
    the BWR. For instance, up through the SOAPCALL might be the right balance. So, dSoapRequest
    would get generated in the BWR (here) and then be passed into GetScoringReport (which could still
    return dFormat2Out).
*/
dOutput := PhoneFinder_Services.ScoringReport.GetScoringReport(dInputReq_toProcess, dInputConfig, isPhoneSearch);

output(CHOOSEN(dOutput, eyeball), NAMED('sample_output'));
output(dOutput,,OutputFile + '.csv', CSV(HEADING(SINGLE), QUOTE('"')));

/* NOTE TO SELF: look at IID code (BWR) */
