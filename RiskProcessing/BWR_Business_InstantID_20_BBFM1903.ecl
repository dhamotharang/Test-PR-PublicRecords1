#WORKUNIT('name','Business InstantID 20 with BBFM1903_1_0 Model');
#OPTION ('hthorMemoryLimit', 1000);
#OPTION('OUTPUTLIMIT', 2000); 

IMPORT Data_Services, IESP, Risk_Indicators, RiskWise, UT;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 * 0 to run all.                                                      *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
 
recordsToRun := 0;
eyeball      := 10;
threads      := 30;

roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie;  // Roxie Batch Production
// roxieIP := RiskWise.shortcuts.prod_batch_neutral;       // Production
// roxieIP := RiskWise.shortcuts.Dev156;                   // Development Roxie 156

inputFile := Data_Services.foreign_prod + 'rbao::in::huntington_8778_415_bus_r1_in.csv';
outputFile := '~rbao::out::htt_BIID2_BBFM1903_905_cur_' + ThorLib.wuid();

includeSBFE := FALSE;		// Just return SBA attributes without SBFE attributes	

// includeExperian := FALSE; // By default, Experian data is not allowed
includeExperian := TRUE; // Override the Experian data restriction and include Experian in results 

// Universally Set the History Date for ALL records. Set to 0 to use the History Date located on each record of the input file or 999999 for real time processing
histDateYYYYMM := 0;
histDate       := 0;

dataRestrictionMask_val := '00000000000000000000';      // No restriction
dataPermissionMask_val  := '00000000000000000000';      // SBFE Not included: All 0's
// dataPermissionMask_val := '00000000000100000000'; 			// For SBFE: '00000000000100000000' (pos 12 = '1')

DPPAPurpose_val := '3';
GLBPurpose_val := '1';

marketingMode := 0; // This product is not being run for marketing, allow all normal sources

// Uncomment the attribute groups below that you wish to have returned
AttributesRequested := DATASET([], iesp.share.t_StringArrayItem);
// Uncomment the models below that you wish to have returned
ModelsRequested := DATASET([{'BBFM1903_1_0'}], iesp.share.t_StringArrayItem);  // all non-sbfe small business attribute
// ModelsRequested := DATASET([{''}], iesp.share.t_STRINGArrayItem);  // all non-sbfe small business attribute


/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
inFileLayout := RECORD
  STRING Account ;
  STRING	CompanyName;
  STRING	AlternateCompanyName;
  STRING	bus_addr;
  STRING	bus_city;
  STRING	bus_state;
  STRING	bus_zip;
  STRING	BusinessPhone;
  STRING	TaxIdNumber;
  STRING	BusinessIPAddress;
  STRING	FirstName;    
  STRING	RepresentativeMiddleName ;
  STRING	LastName;
  STRING	RepresentativeNameSuffix ; 
  STRING	StreetAddress;
  STRING	City;
  STRING	State;
  STRING	Zip;
  STRING	SSN;
  STRING	DateOfBirth;
  STRING	RepresentativeAge;
  STRING	RepresentativeDLNumber;
  STRING	RepresentativeDLState;
  STRING	HomePhone;
  STRING	RepresentativeEmailAddress;
  STRING	RepresentativeFormerLastName; 
  INTEGER history;
END;

inCSVFile:= IF(RecordsToRun <= 0, 
                DATASET(inputFile, inFileLayout, CSV(HEADING(single),QUOTE('"'))),
                CHOOSEN(DATASET(inputFile, inFileLayout, CSV(HEADING(single),QUOTE('"'))), RecordsToRun));

OUTPUT(CHOOSEN(inCSVFile, eyeball), NAMED('Sample_Raw_Input_File'));
OUTPUT(COUNT(inCSVFile), NAMED('Total_Raw_Input_Records'));


inputFileLayout := RECORD
  STRING AccountNumber;
  STRING CompanyName;
  STRING AlternateCompanyName;
  STRING Addr;
  STRING City;
  STRING State;
  STRING Zip;
  STRING BusinessPhone;
  STRING TaxIdNumber;
  STRING BusinessIPAddress;
  STRING RepresentativeFirstName;
  STRING RepresentativeMiddleName;
  STRING RepresentativeLastName;
  STRING RepresentativeNameSuffix;
  STRING RepresentativeAddr;
  STRING RepresentativeCity;
  STRING RepresentativeState;
  STRING RepresentativeZip;
  STRING RepresentativeSSN;
  STRING RepresentativeDOB;
  STRING RepresentativeAge;
  STRING RepresentativeDLNumber;
  STRING RepresentativeDLState;
  STRING RepresentativeHomePhone;
  STRING RepresentativeEmailAddress;
  STRING RepresentativeFormerLastName;
  INTEGER HistoryDate; //Business Shell 2.1 accepts YYYYMM, YYYMMDD, and YYYYMMDDTTTT dates. historyDate can be in any of these forms.
  UNSIGNED6 PowID;
  UNSIGNED6 ProxID;
  UNSIGNED6 SeleID;
  UNSIGNED6 OrgID;
  UNSIGNED6 UltID;
  STRING SIC_Code;
  STRING NAIC_Code;
  STRING DEC_MONTH;
END;

f := PROJECT(inCSVFile, 
	TRANSFORM(inputFileLayout,
    SELF.AccountNumber := LEFT.account;
    SELF.CompanyName := LEFT.CompanyName;
    SELF.Addr := LEFT.bus_addr;	
    SELF.City := LEFT.bus_city;
    SELF.State := LEFT.bus_state;	
    SELF.Zip := LEFT.bus_zip;
    SELF.BusinessPhone := LEFT.BusinessPhone;	
    SELF.TaxIdNumber := LEFT.TaxIdNumber;
    SELF.RepresentativeFirstName := LEFT.firstname;
    SELF.RepresentativeMiddleName := LEFT.RepresentativeMiddleName;
    SELF.RepresentativeLastName := LEFT.lastname;
    SELF.RepresentativeNameSuffix := LEFT.RepresentativeNameSuffix;
    SELF.RepresentativeAddr := LEFT.streetaddress;	
    SELF.RepresentativeCity := LEFT.city;	
    SELF.RepresentativeState := LEFT.state;	
    SELF.RepresentativeZip := LEFT.Zip;	
    SELF.RepresentativeHomePhone := LEFT.homephone;	
    SELF.RepresentativeSSN := LEFT.ssn;	
    SELF.RepresentativeAge := LEFT.RepresentativeAge;
    SELF.RepresentativeDLNumber := LEFT.RepresentativeDLNumber;
    SELF.RepresentativeDLState := LEFT.RepresentativeDLState;
    SELF.HistoryDate := LEFT.history;
    SELF.RepresentativeDOB := LEFT.DateOfBirth;
    SELF :=[];
	)
);

soapLayout := RECORD
  STRING Seq; // Forcing this into the layout so that we have something to join the attribute results by to get the account number back
  STRING AccountNumber;
  DATASET(iesp.businessinstantid20.t_BusinessInstantID20Request) BusinessInstantID20Request;
  DATASET(Risk_Indicators.Layout_Gateways_In) Gateways;
  DATASET(iesp.Share.t_STRINGArrayItem) Watchlists_Requested;
  BOOLEAN ReturnDetailedRoyalties;
  UNSIGNED3 HistoryDateYYYYMM;
  UNSIGNED6 HistoryDate;
  UNSIGNED1 OFAC_Version;
  UNSIGNED1 LinkSearchLevel;
  UNSIGNED1 MarketingMode;
  STRING50 AllowedSources;
  REAL Global_Watchlist_Threshold;
  BOOLEAN DisableBusinessShellLogging;
END;

soapLayout TRANSFORM_input_request(f le, UNSIGNED8 ctr) := TRANSFORM
  u := DATASET([TRANSFORM(iesp.share.t_User, 
      SELF.AccountNumber := le.accountnumber; 
      SELF.DLPurpose := DPPAPurpose_val; 
      SELF.GLBPurpose := GLBPurpose_val; 
      SELF.DataRestrictionMask := dataRestrictionMask_val; 
      SELF.DataPermissionMask := dataPermissionMask_val; 
      SELF := [])]);
  o := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20Options, 
      SELF.OverrideExperianRestriction := includeExperian;
      SELF.AttributesVersionRequest := AttributesRequested; 
      SELF.IncludeModels.Names := ModelsRequested; 
            SELF.HistoryDate := IF(histDate = 0, le.HistoryDate, histDate);
      SELF := [])]);
  c := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20Company, 
      SELF.CompanyName := le.CompanyName; 
      SELF.AlternateCompanyName := le.AlternateCompanyName; 
      SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
            SELF.StreetAddress1 := le.Addr;
            SELF.StreetAddress2 := le.accountnumber;
            SELF.City := le.City; 
            SELF.State := le.State; 
            SELF.Zip5 := le.Zip[1..5]; 
            SELF.Zip4 := le.Zip[6..9]; 
            SELF := [])])[1];
      SELF.Phone := le.BusinessPhone;
      SELF.FEIN := le.TaxIdNumber;
      SELF := [])]);
      
  a1 := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20AuthRep, 
      SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
            SELF.First := le.Representativefirstname; 
            SELF.Middle := le.RepresentativeMiddleName; 
            SELF.Last := le.Representativelastname; 
            SELF.Suffix := le.RepresentativeNameSuffix; 
            SELF := [])])[1]; 
      SELF.FormerLastName := le.RepresentativeFormerLastName; 
      SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
            SELF.StreetAddress1 := le.RepresentativeAddr; 
            SELF.City := le.RepresentativeCity; 
            SELF.State := le.RepresentativeState; 
            SELF.Zip5 := le.RepresentativeZip[1..5]; 
            SELF.Zip4 := le.RepresentativeZip[6..9]; 
            SELF := [])])[1];
      SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
            SELF.Year := (INTEGER)le.RepresentativeDOB[1..4];
            SELF.Month := (INTEGER)le.RepresentativeDOB[5..6];
            SELF.Day := (INTEGER)le.RepresentativeDOB[7..8];
            SELF := [])])[1]; 
      SELF.Age := le.RepresentativeAge; 
      SELF.SSN := le.RepresentativeSSN; 
      SELF.Phone := le.RepresentativeHomePhone; 
      SELF.DriverLicenseNumber := le.RepresentativeDLNumber; 
      SELF.DriverLicenseState := le.RepresentativeDLState; 
      SELF := [])]);
      
  a2 := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20AuthRep, 
      SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
            SELF.First := ''; 
            SELF.Middle := ''; 
            SELF.Last := ''; 
            SELF.Suffix := ''; 
            SELF := [])])[1]; 
      SELF.FormerLastName := ''; 
      SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
            SELF.StreetAddress1 := ''; 
            SELF.City := ''; 
            SELF.State := ''; 
            SELF.Zip5 := ''; 
            SELF.Zip4 := ''; 
            SELF := [])])[1];
      SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
            SELF.Year := (INTEGER)'';
            SELF.Month := (INTEGER)'';
            SELF.Day := (INTEGER)'';
            SELF := [])])[1]; 
      SELF.Age := ''; 
      SELF.SSN := ''; 
      SELF.Phone := ''; 
      SELF.DriverLicenseNumber := ''; 
      SELF.DriverLicenseState := ''; 
      SELF := [])]);
  a3 := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20AuthRep, 
      SELF.Name := DATASET([TRANSFORM(iesp.share.t_Name, 
            SELF.First := ''; 
            SELF.Middle := ''; 
            SELF.Last := ''; 
            SELF.Suffix := ''; 
            SELF := [])])[1]; 
      SELF.FormerLastName := ''; 
      SELF.Address := DATASET([TRANSFORM(iesp.share.t_Address, 
            SELF.StreetAddress1 := ''; 
            SELF.City := ''; 
            SELF.State := ''; 
            SELF.Zip5 := ''; 
            SELF.Zip4 := ''; 
            SELF := [])])[1]; 
      SELF.DOB := DATASET([TRANSFORM(iesp.share.t_Date, 
            SELF.Year := (INTEGER)'';
            SELF.Month := (INTEGER)'';
            SELF.Day := (INTEGER)'';
            SELF := [])])[1]; 
      SELF.Age := ''; 
      SELF.SSN := ''; 
      SELF.Phone := ''; 
      SELF.DriverLicenseNumber := ''; 
      SELF.DriverLicenseState := ''; 
      SELF := [])]);
  s := DATASET([TRANSFORM(iesp.businessinstantid20.t_BIID20SearchBy, SELF.Sequence:= (STRING)ctr; 
                                                                                     SELF.Company := c[1]; 
                                                                                     SELF.AuthorizedRep1 := a1[1]; 
                                                                                     SELF.AuthorizedRep2 := a2[1]; 
                                                                                     SELF.AuthorizedRep3 := a3[1]; 
                                                                                     SELF := [])]);
  r := DATASET([TRANSFORM(iesp.businessinstantid20.t_BusinessInstantID20Request, SELF.User := u[1]; SELF.Options := o[1]; SELF.SearchBy := s[1]; SELF := [])]);
  SELF.BusinessInstantID20Request := r[1];

  SELF.HistoryDateYYYYMM := IF(histDateYYYYMM = 0, (INTEGER)((STRING)le.historydate)[1..6], histDateYYYYMM);
  SELF.HistoryDate       := IF(histDate       = 0, le.historydate, histDate); // Input file doesn't have any other history date field besides historydateyyyymm.  

  SELF.OFAC_Version := 3;
  SELF.LinkSearchLevel := 0;
  SELF.MarketingMode := marketingMode;
  SELF.AllowedSources := '';
  SELF.Global_Watchlist_Threshold := 0.84;

  SELF.Seq := (STRING)ctr;
  SELF.AccountNumber := le.accountnumber;
  SELF.DisableBusinessShellLogging := TRUE;  // turn off logging
  SELF := [];
END;

businessinstantid20Analytics_input := DISTRIBUTE(PROJECT(f, TRANSFORM_input_request(LEFT, COUNTER)), RANDOM());
OUTPUT(CHOOSEN(businessinstantid20Analytics_input, eyeball), NAMED('businessinstantid20Analytics_input'));

// Now run the SmallBusinessAnalytics attributes
businessinstantid20AnalyticsOUTPUT := RECORD
  UNSIGNED8 time_ms{XPATH('_call_latency_ms')} := 0;  // picks up timing
  iesp.businessinstantid20.t_BIID20Response;
  STRING errorcode;      
END;

//SmallBusinessAnalyticsOUTPUT myFail(soapLayout le) := TRANSFORM
businessinstantid20AnalyticsOUTPUT myFail(soapLayout le) := TRANSFORM
  SELF.ErrorCode := STRINGLib.STRINGFilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
  SELF.Result.InputEcho.Seq := le.Seq;
  SELF := le;
  SELF := [];
END;

businessinstantid20Analytics_attributes := 
                  SOAPCALL(businessinstantid20Analytics_input, 
                  RoxieIP,
                  'BusinessInstantID20_Services.InstantID20_Service', 
                  {businessinstantid20Analytics_input}, 
                  DATASET(businessinstantid20AnalyticsOUTPUT),
                  RETRY(5), TIMEOUT(500),
                  XPATH('BusinessInstantID20_Services.InstantID20_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),				
                  PARALLEL(threads), ONFAIL(myFail(LEFT)));
				
OUTPUT(CHOOSEN(businessinstantid20Analytics_attributes, eyeball), NAMED('Sample_SOAP_Results'));

validResults := businessinstantid20Analytics_attributes (errorcode = '');
failedResults := businessinstantid20Analytics_attributes (errorcode <> '');

OUTPUT(CHOOSEN(validResults, eyeball), NAMED('Sample_Passed_Results'));
OUTPUT(CHOOSEN(failedResults, eyeball), NAMED('Sample_Failed_Results'));

// export t_BIID20Result := record
// unsigned1 NumberValidAuthRepsInput {xpath('NumberValidAuthRepsInput')};
// t_BIID20InputEcho InputEcho {xpath('InputEcho')};
// t_BIID20CompanyResults CompanyResults {xpath('CompanyResults')};
// dataset(t_BIID20AuthorizedRepresentativeResults) AuthorizedRepresentativeResults {xpath('AuthorizedRepresentativeResults/AuthorizedRepresentativeResult'), MAXCOUNT(iesp.constants.BIID.MAXAUTHORIZEDREPS)};
// dataset(iesp.smallbusinessanalytics.t_SBAModelHRI) Models {xpath('Models/Model'), MAXCOUNT(iesp.constants.SBAnalytics.MaxModelCount)};

flatLayout := Record
  STRING Seq;
  UNSIGNED6 HistoryDate;
  iesp.businessinstantid20.t_BIID20Company Company;
  iesp.businessinstantid20.t_BIID20AuthRep AuthorizedRep1;
  iesp.businessinstantid20.t_BIID20AuthRep AuthorizedRep2;
  iesp.businessinstantid20.t_BIID20AuthRep AuthorizedRep3;
  iesp.businessinstantid20.t_BIID20AuthRep AuthorizedRep4;
  iesp.businessinstantid20.t_BIID20AuthRep AuthorizedRep5;
  // iesp.smallbusinessanalytics.t_SBAModelHRI Models;
  STRING30  modelName;
  STRING    modelType;
  INTEGER   modelScore;
  STRING5   RC1;
  STRING150 RC1Desc;
  STRING5   RC2;
  STRING150 RC2Desc;
  STRING5   RC3;
  STRING150 RC3Desc;
  STRING5   RC4;
  STRING150 RC4Desc;
  STRING5   RC5;
  STRING150 RC5Desc;
  STRING5   RC6;
  STRING150 RC6Desc;
END;

flatLayout flatten(businessinstantid20AnalyticsOUTPUT le, businessinstantid20Analytics_input ri) := TRANSFORM
  SELF.seq              := le.Result.InputEcho.Seq;
  SELF.HistoryDate := ri.HistoryDate;
  SELF.Company          := le.Result.InputEcho.Company;
  SELF.AuthorizedRep1   := le.Result.InputEcho.AuthorizedRepresentatives[1];
  SELF.AuthorizedRep2   := le.Result.InputEcho.AuthorizedRepresentatives[2];
  SELF.AuthorizedRep3   := le.Result.InputEcho.AuthorizedRepresentatives[3];
  SELF.AuthorizedRep4   := le.Result.InputEcho.AuthorizedRepresentatives[4];
  SELF.AuthorizedRep5   := le.Result.InputEcho.AuthorizedRepresentatives[5];
  SELF.modelName        := le.Result.Models[1].Name;
  SELF.modelType        := le.Result.Models[1].Scores[1]._Type;
  SELF.modelScore       := le.Result.Models[1].Scores[1].Value;
  SELF.RC1              := le.Result.Models[1].Scores[1].ScoreReasons[1].ReasonCode;
  SELF.RC1Desc          := le.Result.Models[1].Scores[1].ScoreReasons[1].Description;
  SELF.RC2              := le.Result.Models[1].Scores[1].ScoreReasons[2].ReasonCode;
  SELF.RC2Desc          := le.Result.Models[1].Scores[1].ScoreReasons[2].Description;
  SELF.RC3              := le.Result.Models[1].Scores[1].ScoreReasons[3].ReasonCode;
  SELF.RC3Desc          := le.Result.Models[1].Scores[1].ScoreReasons[3].Description;
  SELF.RC4              := le.Result.Models[1].Scores[1].ScoreReasons[4].ReasonCode;
  SELF.RC4Desc          := le.Result.Models[1].Scores[1].ScoreReasons[4].Description;
  SELF.RC5              := le.Result.Models[1].Scores[1].ScoreReasons[5].ReasonCode;
  SELF.RC5Desc          := le.Result.Models[1].Scores[1].ScoreReasons[5].Description;
  SELF.RC6              := le.Result.Models[1].Scores[1].ScoreReasons[6].ReasonCode;
  SELF.RC6Desc          := le.Result.Models[1].Scores[1].ScoreReasons[6].Description;
  SELF := [];
END;

flattenedResults := JOIN(validResults, businessinstantid20Analytics_input, 
                         LEFT.Result.InputEcho.Company.address.StreetAddress2 = RIGHT.AccountNumber,
                         flatten(LEFT, RIGHT));
                  
OUTPUT(CHOOSEN(flattenedResults(modelscore != 0), eyeball), NAMED('flattenedResults'));
OUTPUT(flattenedResults,,outputFile,CSV(HEADING(single), QUOTE('"')), OVERWRITE);