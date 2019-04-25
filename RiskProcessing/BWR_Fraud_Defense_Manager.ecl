#workunit('name', 'Fraud Defense Manager');

IMPORT Gateway, iesp, RiskWise, Risk_Indicators, Suspicious_Fraud_LN, UT;

/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 or -1 to run all.                                             *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 * enableNetAcuity: TRUE = NetAcuity Gateway ON, FALSE = OFF          *
 * enableDeltabase: TRUE = Deltabase Search ON, FALSE = OFF.  The     *
 *    deltabase is only useful in realtime transactions, so if you    *
 *    have an archive date != 999999, this script WILL TURN THE       *
 *    DELTABASE SEARCH OFF.                                           *
 * eyeball: Number of records shown in the "sample" outputs.          *
 ******************************************************************** */
 
 recordsToRun := 0;
 
 threads := 2;
 
 // roxieIP := RiskWise.shortcuts.Dev194; // Development Roxie 194
 // roxieIP := RiskWise.shortcuts.D4; // Development Roxie - One Way #4
 // roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging 128 Roxie
 roxieIP := RiskWise.shortcuts.prod_batch_analytics_roxie; // Production Batch Roxie
 
 inputFile := ut.foreign_dataland + 'bpahl::out::inquiry_acclogs::inquiry_test::identity_fraud::internal_w20140227-151602';
 
 outputFile := '~bpahl::out::Fraud_Defense_Manager_Results';
 
 enableNetAcuity := FALSE; // THERE ARE COSTS ASSOCIATED WITH THIS GATEWAY
 
 enableDeltabase := FALSE; // This Gateway is free, but will slow down query performance.  Don't use unless you need Inquiries within the past 1-2 days.
 
 eyeball := 100;
 
/* ********************************************************************
 *              MAIN SCRIPT CODE - READING INPUT FILE                 *
 ******************************************************************** */
prii_layout := RECORD
	STRING AccountNumber := '';
	STRING FirstName := '';
	STRING MiddleName := '';
	STRING LastName := '';
	STRING StreetAddress := '';
	STRING City := '';
	STRING State := '';
	STRING Zip5 := '';
	STRING Phone10 := '';
	STRING SSN := '';
	STRING DateOfBirth := '';
	STRING DLNumber := '';
	STRING DLState := '';
	STRING Email := '';
	STRING IPAddress := '';
END;

inputData := IF(recordsToRun > 0, CHOOSEN(DATASET(inputFile, prii_layout, CSV(HEADING(single), QUOTE('"'))), recordsToRun),
																	DATASET(inputFile, prii_layout, CSV(HEADING(single), QUOTE('"'))));

OUTPUT(CHOOSEN(inputData, eyeball), NAMED('Sample_Raw_Input'));

/* ********************************************************************
 *          MAIN SCRIPT CODE - CONVERTING TO SOAPCALL LAYOUT          *
 ******************************************************************** */
soapcall_layout := RECORD
	DATASET(iesp.FraudDefenseManager.t_FraudDefenseManagerRequest) FraudDefenseManagerReportRequest;
	DATASET(Gateway.Layouts.Config) Gateways;
	UNSIGNED3 HistoryDateYYYYMM;
END;

iesp.FraudDefenseManager.t_FraudDefenseManagerRequest intoPII(prii_layout le) := TRANSFORM
	SELF.User := PROJECT(le, TRANSFORM(iesp.share.t_User, 
		SELF.GLBPurpose	:= (STRING)1;
		SELF.DLPurpose	:= (STRING)1;
		SELF.DataRestrictionMask := Risk_Indicators.iid_constants.default_dataRestriction;
		SELF.TestDataEnabled	:= FALSE;
		SELF := []));

	SELF.SearchBy := PROJECT(le, TRANSFORM(iesp.frauddefensemanager.t_FraudDefenseManagerSearchBy,
		SELF.Name := DATASET([{'', LEFT.FirstName, LEFT.MiddleName, LEFT.LastName, '', ''}], iesp.share.t_Name)[1];
		SELF.Address := DATASET([{'', '', '', '', '', '', '', LEFT.StreetAddress, '', LEFT.City, LEFT.State, LEFT.Zip5[1..5], '', '', '', ''}], iesp.share.t_Address)[1];
		SELF.DOB := DATASET([{(INTEGER)LEFT.DateOfBirth[1..4], (INTEGER)LEFT.DateOfBirth[5..6], (INTEGER)LEFT.DateOfBirth[7..8]}], iesp.share.t_Date)[1];
		SELF.SSN := LEFT.SSN;
		SELF.Phone := LEFT.Phone10;
		SELF.IPAddress := LEFT.IPAddress;
		SELF.Email := LEFT.Email;
		SELF.DriverLicenseNumber := LEFT.DLNumber;
		SELF.DriverLicenseState := LEFT.DLState;
		SELF.DeviceID := '';
		SELF := []));

	SELF := [];
END;

soapcall_layout intoSOAP(prii_layout le) := TRANSFORM
	SELF.FraudDefenseManagerReportRequest := PROJECT(le, intoPII(LEFT));
	SELF.Gateways := PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := IF(EnableNetAcuity, 'netacuity', ''); SELF.URL := IF(EnableNetAcuity, 'http://rw_score_dev:Password01@rwgatewaycert.sc.seisint.com:7726/WsGateway/?ver_=1.93', ''); SELF := [])) +
									 PROJECT(ut.ds_oneRecord, TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := IF(EnableDeltabase, 'delta_inquiry', ''); SELF.URL := IF(EnableDeltabase, 'http://rw_score_dev:Password01@10.176.68.151:7909/WsDeltaBase/preparedsql', ''); SELF := []));
	SELF.HistoryDateYYYYMM := 999999; // Set to 999999 for Realtime, YYYYMM for Archive runs
END;

soapInput := PROJECT(inputData, intoSOAP(LEFT));

OUTPUT(CHOOSEN(soapInput, eyeball), NAMED('Sample_SOAP_Input'));

/* ********************************************************************
 *             MAIN SCRIPT CODE - GET THE SOAPCALL RESULTS            *
 ******************************************************************** */
xlayout := RECORD
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing
	iesp.frauddefensemanager.t_FraudDefenseManagerResponse;
	STRING200 errorcode := '';
END;

xlayout myFail(soapcall_layout le) := TRANSFORM
	SELF.errorcode := FAILCODE + ' ' + FAILMESSAGE;
	SELF := le;
	
	SELF := [];
END;

soapResults := SOAPCALL(soapInput, 
										roxieIP, 
										'Suspicious_Fraud_LN.Fraud_Defense_Manager_Service', 
										{soapInput}, 
										DATASET(xlayout), 
										PARALLEL(threads),
										onFail(myFail(LEFT)));
										
OUTPUT(CHOOSEN(soapResults (TRIM(errorcode) = ''), eyeball), NAMED('Sample_SOAP_Results'));
OUTPUT(CHOOSEN(soapResults (TRIM(errorcode) <> ''), eyeball), NAMED('Sample_SOAP_Errors'));

OUTPUT(COUNT(soapInput), NAMED('Total_Input_Records'));
OUTPUT(COUNT(soapResults (TRIM(errorcode) = '')), NAMED('Total_Good_Output_Records'));
OUTPUT(COUNT(soapResults (TRIM(errorcode) <> '')), NAMED('Total_Failed_Output_Records'));

OUTPUT((STRING)AVE(soapResults, time_ms) + ' milliseconds', NAMED('Average_Transaction_Time'));

/* ********************************************************************
 *       MAIN SCRIPT CODE - CONVERT ESDL LAYOUT TO FLAT LAYOUT        *
 ******************************************************************** */
FlatLayout := RECORD
	iesp.frauddefensemanager.t_FraudDefenseManagerSearchBy InputEcho;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_SSN_Batch SSNReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_Address_Batch AddressReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_Email_Batch EmailReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_IPAddress_Batch IPAddressReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_Name_Batch NameReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_Phone_Batch PhoneReturn;
	Suspicious_Fraud_LN.layouts.Layout_Suspicious_Combination_Batch CombinationReturn;
END;

FlatLayout flattenESDL(soapResults le) := TRANSFORM
	SELF.InputEcho := le.InputEcho;
	
	SELF.SSNReturn.SSN_Hit := le.SSNReturn.Hit;
	SELF.SSNReturn.SSN_Message := le.SSNReturn.HitResponse;
	SELF.SSNReturn.Data_Source := le.SSNReturn.DataSource;
	SSNRiskCodes := SORT(le.SSNReturn.RiskIndicators, RiskCode);
	SELF.SSNReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(SSNRiskCodes, RiskCode, ',');
	SELF.SSNReturn.DateFirstSeenInFile := IF(le.SSNReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.SSNReturn.DateFirstSeenInFile.Year + INTFORMAT(le.SSNReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.SSNReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.SSNReturn.InquiryCount := le.SSNReturn.InquiryCount;
	SELF.SSNReturn.InquiryCountHour := le.SSNReturn.InquiryCountHour;
	SELF.SSNReturn.InquiryCountDay := le.SSNReturn.InquiryCountToday;
	SELF.SSNReturn.InquiryCountWeek := le.SSNReturn.InquiryCountWeek;
	SELF.SSNReturn.InquiryCountMonth := le.SSNReturn.InquiryCountMonth;
	SELF.SSNReturn.InquiryCountYear := le.SSNReturn.InquiryCountYear;
	
	SELF.AddressReturn.Address_Hit := le.AddressReturn.Hit;
	SELF.AddressReturn.Address_Message := le.AddressReturn.HitResponse;
	SELF.AddressReturn.Data_Source := le.AddressReturn.DataSource;
	USPIS := SORT(le.AddressReturn.USPISHotListRecords, DateAdded);
	// SELF.AddressReturn.USPISHotListDateAdded := Suspicious_Fraud_LN.Common.convertDelimited(USPIS, DateAdded, ',');
	// SELF.AddressReturn.USPISHotListReason := Suspicious_Fraud_LN.Common.convertDelimited(USPIS, Reason, ',');
	AddressRiskCodes := SORT(le.AddressReturn.RiskIndicators, RiskCode);
	SELF.AddressReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(AddressRiskCodes, RiskCode, ',');
	SELF.AddressReturn.DateFirstSeenInFile := IF(le.AddressReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.AddressReturn.DateFirstSeenInFile.Year + INTFORMAT(le.AddressReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.AddressReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.AddressReturn.InquiryCount := le.AddressReturn.InquiryCount;
	SELF.AddressReturn.InquiryCountHour := le.AddressReturn.InquiryCountHour;
	SELF.AddressReturn.InquiryCountDay := le.AddressReturn.InquiryCountToday;
	SELF.AddressReturn.InquiryCountWeek := le.AddressReturn.InquiryCountWeek;
	SELF.AddressReturn.InquiryCountMonth := le.AddressReturn.InquiryCountMonth;
	SELF.AddressReturn.InquiryCountYear := le.AddressReturn.InquiryCountYear;
	
	SELF.EmailReturn.Email_Hit := le.EmailReturn.Hit;
	SELF.EmailReturn.Email_Message := le.EmailReturn.HitResponse;
	SELF.EmailReturn.Data_Source := le.EmailReturn.DataSource;
	EmailRiskCodes := SORT(le.EmailReturn.RiskIndicators, RiskCode);
	SELF.EmailReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(EmailRiskCodes, RiskCode, ',');
	SELF.EmailReturn.DateFirstSeenInFile := IF(le.EmailReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.EmailReturn.DateFirstSeenInFile.Year + INTFORMAT(le.EmailReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.EmailReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.EmailReturn.InquiryCount := le.EmailReturn.InquiryCount;
	SELF.EmailReturn.InquiryCountHour := le.EmailReturn.InquiryCountHour;
	SELF.EmailReturn.InquiryCountDay := le.EmailReturn.InquiryCountToday;
	SELF.EmailReturn.InquiryCountWeek := le.EmailReturn.InquiryCountWeek;
	SELF.EmailReturn.InquiryCountMonth := le.EmailReturn.InquiryCountMonth;
	SELF.EmailReturn.InquiryCountYear := le.EmailReturn.InquiryCountYear;
	
	SELF.IPAddressReturn.IPAddress_Hit := le.IPAddressReturn.Hit;
	SELF.IPAddressReturn.IPAddress_Message := le.IPAddressReturn.HitResponse;
	SELF.IPAddressReturn.Data_Source := le.IPAddressReturn.DataSource;
	IPAddressRiskCodes := SORT(le.IPAddressReturn.RiskIndicators, RiskCode);
	SELF.IPAddressReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(IPAddressRiskCodes, RiskCode, ',');
	SELF.IPAddressReturn.DateFirstSeenInFile := IF(le.IPAddressReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.IPAddressReturn.DateFirstSeenInFile.Year + INTFORMAT(le.IPAddressReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.IPAddressReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.IPAddressReturn.InquiryCount := le.IPAddressReturn.InquiryCount;
	SELF.IPAddressReturn.InquiryCountHour := le.IPAddressReturn.InquiryCountHour;
	SELF.IPAddressReturn.InquiryCountDay := le.IPAddressReturn.InquiryCountToday;
	SELF.IPAddressReturn.InquiryCountWeek := le.IPAddressReturn.InquiryCountWeek;
	SELF.IPAddressReturn.InquiryCountMonth := le.IPAddressReturn.InquiryCountMonth;
	SELF.IPAddressReturn.InquiryCountYear := le.IPAddressReturn.InquiryCountYear;
	
	SELF.NameReturn.Name_Hit := le.NameReturn.Hit;
	SELF.NameReturn.Name_Message := le.NameReturn.HitResponse;
	SELF.NameReturn.Data_Source := le.NameReturn.DataSource;
	NameRiskCodes := SORT(le.NameReturn.RiskIndicators, RiskCode);
	SELF.NameReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(NameRiskCodes, RiskCode, ',');
	SELF.NameReturn.DateFirstSeenInFile := IF(le.NameReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.NameReturn.DateFirstSeenInFile.Year + INTFORMAT(le.NameReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.NameReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.NameReturn.InquiryCount := le.NameReturn.InquiryCount;
	SELF.NameReturn.InquiryCountHour := le.NameReturn.InquiryCountHour;
	SELF.NameReturn.InquiryCountDay := le.NameReturn.InquiryCountToday;
	SELF.NameReturn.InquiryCountWeek := le.NameReturn.InquiryCountWeek;
	SELF.NameReturn.InquiryCountMonth := le.NameReturn.InquiryCountMonth;
	SELF.NameReturn.InquiryCountYear := le.NameReturn.InquiryCountYear;
	
	SELF.PhoneReturn.Phone_Hit := le.PhoneReturn.Hit;
	SELF.PhoneReturn.Phone_Message := le.PhoneReturn.HitResponse;
	SELF.PhoneReturn.Data_Source := le.PhoneReturn.DataSource;
	PhoneRiskCodes := SORT(le.PhoneReturn.RiskIndicators, RiskCode);
	SELF.PhoneReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(PhoneRiskCodes, RiskCode, ',');
	SELF.PhoneReturn.DateFirstSeenInFile := IF(le.PhoneReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.PhoneReturn.DateFirstSeenInFile.Year + INTFORMAT(le.PhoneReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.PhoneReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.PhoneReturn.InquiryCount := le.PhoneReturn.InquiryCount;
	SELF.PhoneReturn.InquiryCountHour := le.PhoneReturn.InquiryCountHour;
	SELF.PhoneReturn.InquiryCountDay := le.PhoneReturn.InquiryCountToday;
	SELF.PhoneReturn.InquiryCountWeek := le.PhoneReturn.InquiryCountWeek;
	SELF.PhoneReturn.InquiryCountMonth := le.PhoneReturn.InquiryCountMonth;
	SELF.PhoneReturn.InquiryCountYear := le.PhoneReturn.InquiryCountYear;
	
	SELF.CombinationReturn.Combination_Search_Hit := le.CombinationReturn.Hit;
	SELF.CombinationReturn.Combination_Search_Message := le.CombinationReturn.HitResponse;
	SELF.CombinationReturn.Data_Source := le.CombinationReturn.DataSource;
	CombinationRiskCodes := SORT(le.CombinationReturn.RiskIndicators, RiskCode);
	SELF.CombinationReturn.SuspiciousRiskCodes := Suspicious_Fraud_LN.Common.convertDelimited(CombinationRiskCodes, RiskCode, ',');
	SELF.CombinationReturn.DateFirstSeenInFile := IF(le.CombinationReturn.DateFirstSeenInFile.Year = 0, '', (STRING)le.CombinationReturn.DateFirstSeenInFile.Year + INTFORMAT(le.CombinationReturn.DateFirstSeenInFile.Month, 2, 1) + INTFORMAT(le.CombinationReturn.DateFirstSeenInFile.Day, 2, 1));
	SELF.CombinationReturn.InquiryCount := le.CombinationReturn.InquiryCount;
	SELF.CombinationReturn.InquiryCountHour := le.CombinationReturn.InquiryCountHour;
	SELF.CombinationReturn.InquiryCountDay := le.CombinationReturn.InquiryCountToday;
	SELF.CombinationReturn.InquiryCountWeek := le.CombinationReturn.InquiryCountWeek;
	SELF.CombinationReturn.InquiryCountMonth := le.CombinationReturn.InquiryCountMonth;
	SELF.CombinationReturn.InquiryCountYear := le.CombinationReturn.InquiryCountYear;
	
	SELF := le;
	SELF := [];
END;
flattened := PROJECT(soapResults (TRIM(errorcode) = ''), flattenESDL(LEFT));

OUTPUT(CHOOSEN(flattened, eyeball), NAMED('Sample_Flattend_Layout'));
OUTPUT(COUNT(flattened), NAMED('Total_Flattened_Records'));

OUTPUT(flattened,, outputFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE);