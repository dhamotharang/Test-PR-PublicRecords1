#workunit('name', 'Business_Instant_ID_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140304';
EndDate := '20140305';

AccountIDs := ['1488800']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

eyeball := 100;

outputFile := '~bpahl::out::Business_InstantID_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['BUSINESSINSTANTID'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<BusinessInstantID>', '<BusinessInstantID><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<BusinessInstantID>' + LEFT.outputxml + '</BusinessInstantID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_1 , eyeball), NAMED('Sample_Yesterday_Logs_1'));

Risk_Reporting.Layouts.Parsed_BusinessIID_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.CompanyName					:= TRIM(XMLTEXT('SearchBy/CompanyName'));
	SELF.CompanyAddress				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/CompanyAddress/StreetAddress1'), XMLTEXT('SearchBy/CompanyAddress/StreetAddress2'));
	SELF.CompanyCity					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/City'));
	SELF.CompanyState					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/State'));
	SELF.CompanyZIP						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/CompanyAddress/Zip5'));
	SELF.FEIN									:= TRIM(XMLTEXT('SearchBy/FEIN'));
	SELF.CompanyPhone10				:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/CompanyPhone'));
	SELF.RepFirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/First'));
	SELF.RepLastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/Last'));
	SELF.RepSSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRepresentative/SSN'));
	SELF.RepDOB								:= Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Year'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Month'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Day'));
	SELF.RepAddress						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress1'), XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress2'));
	SELF.RepCity							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/City'));
	SELF.RepState							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/State'));
	SELF.RepZip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/Zip5'));
	SELF.RepDL								:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseNumber'));
	SELF.RepDLState						:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseState'));
	SELF.RepPhone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRepresentative/Phone10'));
	
	SELF := [];
END;
parsedInput_1 := DISTRIBUTE(PARSE(Logs_1, inputxml, parseInput(), XML('BusinessInstantID')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_Parsed_Input_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);

//new xml tags for request
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<BusinessInstantIDRequest>', '<BusinessInstantIDRequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<BusinessInstantID>' + LEFT.outputxml + '</BusinessInstantID>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Yesterday_Logs_2'));

Risk_Reporting.Layouts.Parsed_BusinessIID_Layout parseInput_2 () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.EndUserCompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.CompanyName					:= TRIM(XMLTEXT('SearchBy/CompanyName'));
	SELF.CompanyAddress				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/CompanyAddress/StreetAddress1'), XMLTEXT('SearchBy/CompanyAddress/StreetAddress2'));
	SELF.CompanyCity					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/City'));
	SELF.CompanyState					:= TRIM(XMLTEXT('SearchBy/CompanyAddress/State'));
	SELF.CompanyZIP						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/CompanyAddress/Zip5'));
	SELF.FEIN									:= TRIM(XMLTEXT('SearchBy/FEIN'));
	SELF.CompanyPhone10				:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/CompanyPhone'));
	SELF.RepFirstName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/First'));
	SELF.RepLastName					:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Name/Last'));
	SELF.RepSSN								:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/AuthorizedRepresentative/SSN'));
	SELF.RepDOB								:= Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Year'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Month'), XMLTEXT('SearchBy/AuthorizedRepresentative/DOB/Day'));
	SELF.RepAddress						:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress1'), XMLTEXT('SearchBy/AuthorizedRepresentative/Address/StreetAddress2'));
	SELF.RepCity							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/City'));
	SELF.RepState							:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/State'));
	SELF.RepZip								:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/AuthorizedRepresentative/Address/Zip5'));
	SELF.RepDL								:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseNumber'));
	SELF.RepDLState						:= TRIM(XMLTEXT('SearchBy/AuthorizedRepresentative/DriverLicenseState'));
	SELF.RepPhone10						:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/AuthorizedRepresentative/Phone10'));
	
	SELF := [];
END;
parsedInput_2 := DISTRIBUTE(PARSE(Logs_2, inputxml, parseInput_2(), XML('BusinessInstantIDRequest')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_Parsed_Input_2'));

LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22; //since the rawlog_1 has all the records, we only want the records with the correct XML tags we could link them to

Risk_Reporting.Layouts.Parsed_BusinessIID_Layout parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
												 
	SELF.AuthorizedRepresentativeRelationshipToCompany := TRIM(XMLTEXT('Result/AuthorizedRepresentativeRelationshipToCompany'));
	SELF.DistHomePhoneToBusinessAddress := TRIM(XMLTEXT('Result/DistHomePhoneToBusinessAddress'));
	SELF.DistHomeAddressToBusinessPhone := TRIM(XMLTEXT('Result/DistHomeAddressToBusinessPhone'));
	SELF.DistHomePhoneToBusinessPhone := TRIM(XMLTEXT('Result/DistHomePhoneToBusinessPhone'));
	SELF.DistHomePhoneToHomeAddress := TRIM(XMLTEXT('Result/DistHomePhoneToHomeAddress'));
	SELF.DistBusinessPhoneToBusinessAddress := TRIM(XMLTEXT('Result/DistBusinessPhoneToBusinessAddress'));
	
	SELF.CompanyNameAddressPhoneIndicator := TRIM(XMLTEXT('Result/CompanyResults/NameAddressPhoneIndicator'));
	SELF.CompanyNameAddressFEINIndicator := TRIM(XMLTEXT('Result/CompanyResults/NameAddressFEINIndicator'));
	SELF.CompanyNameAddressSSNIndicator := TRIM(XMLTEXT('Result/CompanyResults/NameAddressSSNIndicator'));
	SELF.CompanyBusinessVerificationIndicator := TRIM(XMLTEXT('Result/CompanyResults/BusinessVerificationIndicator'));
	SELF.CompanyPhoneType := TRIM(XMLTEXT('Result/CompanyResults/PhoneType'));
	SELF.CompanyBankruptcyCount := TRIM(XMLTEXT('Result/CompanyResults/BankruptcyCount'));
	SELF.CompanyBusinessId := TRIM(XMLTEXT('Result/CompanyResults/BusinessId'));
	SELF.CompanyVerificationCompanyName := TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/CompanyName'));
	SELF.CompanyVerificationState := TRIM(XMLTEXT('Result/CompanyResults/VerificationIndicators/State'));
	SELF.CompanyVerifiedCompanyName := TRIM(XMLTEXT('Result/CompanyResults/VerifiedInput/CompanyName'));
	SELF.CompanyVerifiedState := TRIM(XMLTEXT('Result/CompanyResults/VerifiedInput/Address/State'));
	SELF.CompanyRC1		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.CompanyRC2		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.CompanyRC3		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.CompanyRC4		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.CompanyRC5		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.CompanyRC6		:= TRIM(XMLTEXT('Result/CompanyResults/RiskIndicators/RiskIndicator[6]/RiskCode'));
	
	SELF.RepNameAddressSSNSummary := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/NameAddressSSNSummary'));
	SELF.RepNameAddressPhoneSummary := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/NameAddressPhoneSummary'));
	SELF.RepComprehensiveVerificationIndex := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/ComprehensiveVerificationIndex'));
	SELF.RepAreaCodeSplitFlag := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/AreaCodeSplitFlag'));
	SELF.RepSSNInfoValid := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/Valid'));
	SELF.RepSSNInfoIssuedLocation := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedLocation'));
	SELF.RepSSNInfoIssuedStartDate := Risk_Reporting.Common.ParseDate(XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedStartDate/Year'), XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedStartDate/Month'), XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedStartDate/Day'));
	SELF.RepSSNInfoIssuedEndDate := Risk_Reporting.Common.ParseDate(XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedEndDate/Year'), XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedEndDate/Month'), XMLTEXT('Result/AuthorizedRepresentativeResults/SSNInfo/IssuedEndDate/Day'));
	SELF.RepFollowupAction1 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[1]/Action'));
	SELF.RepFollowupAction2 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[2]/Action'));
	SELF.RepFollowupAction3 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[3]/Action'));
	SELF.RepFollowupAction4 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[4]/Action'));
	SELF.RepFollowupAction5 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[5]/Action'));
	SELF.RepFollowupAction6 := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/FollowupActions/FollowupAction[6]/Action'));
	SELF.RepVerifiedSSN := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/SSN'));
	SELF.RepVerifiedAddress := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Address/StreetAddress1'));
	SELF.RepVerifiedCity := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Address/City'));
	SELF.RepVerifiedState := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Address/State'));
	SELF.RepVerifiedZIP := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Address/Zip5'));
	SELF.RepVerifiedFirstName := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Name/First'));
	SELF.RepVerifiedLastName := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerifiedInput/Name/Last'));
	SELF.RepVerificationName := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerificationIndicators/Name'));
	SELF.RepVerificationAddress := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerificationIndicators/Address'));
	SELF.RepVerificationSSN := TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/VerificationIndicators/SSN'));
	SELF.RepRC1				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[1]/RiskCode'));
	SELF.RepRC2				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[2]/RiskCode'));
	SELF.RepRC3				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[3]/RiskCode'));
	SELF.RepRC4				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[4]/RiskCode'));
	SELF.RepRC5				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[5]/RiskCode'));
	SELF.RepRC6				:= TRIM(XMLTEXT('Result/AuthorizedRepresentativeResults/RiskIndicators/RiskIndicator[6]/RiskCode'));

	SELF.Model1Name		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
	SELF.Model1Score	:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value'));
	SELF.Model1Type		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	SELF.Model1RC1		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.Model1RC2		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.Model1RC3		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.Model1RC4		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.Model1RC5		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.Model1RC6		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.Model2Name		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
	SELF.Model2Score	:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/Value'));
	SELF.Model2Type		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/Type'));
	SELF.Model2RC1		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.Model2RC2		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.Model2RC3		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.Model2RC4		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.Model2RC5		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.Model2RC6		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[2]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));
	SELF.Model3Name		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Name'));
	SELF.Model3Score	:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/Value'));
	SELF.Model3Type		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/Type'));
	SELF.Model3RC1		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[1]/RiskCode'));
	SELF.Model3RC2		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[2]/RiskCode'));
	SELF.Model3RC3		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[3]/RiskCode'));
	SELF.Model3RC4		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[4]/RiskCode'));
	SELF.Model3RC5		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[5]/RiskCode'));
	SELF.Model3RC6		:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[3]/RiskIndicators[1]/RiskIndicator[6]/RiskCode'));

	SELF := [];
END;
parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('BusinessInstantID'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('BusinessInstantID'));
parsedOutput := parsedOutputTemp_1 + parsedOutputTemp_2;
OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_BusinessIID_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_BusinessIID_Layout le, Risk_Reporting.Layouts.Parsed_BusinessIID_Layout ri) := TRANSFORM
	SELF.AuthorizedRepresentativeRelationshipToCompany := ri.AuthorizedRepresentativeRelationshipToCompany;
	SELF.DistHomePhoneToBusinessAddress                := ri.DistHomePhoneToBusinessAddress               ;
	SELF.DistHomeAddressToBusinessPhone                := ri.DistHomeAddressToBusinessPhone               ;
	SELF.DistHomePhoneToBusinessPhone                  := ri.DistHomePhoneToBusinessPhone                 ;
	SELF.DistHomePhoneToHomeAddress                    := ri.DistHomePhoneToHomeAddress                   ;
	SELF.DistBusinessPhoneToBusinessAddress            := ri.DistBusinessPhoneToBusinessAddress           ;
	SELF.CompanyNameAddressPhoneIndicator              := ri.CompanyNameAddressPhoneIndicator             ;
	SELF.CompanyNameAddressFEINIndicator               := ri.CompanyNameAddressFEINIndicator              ;
	SELF.CompanyNameAddressSSNIndicator                := ri.CompanyNameAddressSSNIndicator               ;
	SELF.CompanyBusinessVerificationIndicator          := ri.CompanyBusinessVerificationIndicator         ;
	SELF.CompanyPhoneType                              := ri.CompanyPhoneType                             ;
	SELF.CompanyBankruptcyCount                        := ri.CompanyBankruptcyCount                       ;
	SELF.CompanyBusinessId                             := ri.CompanyBusinessId                            ;
	SELF.CompanyVerificationCompanyName                := ri.CompanyVerificationCompanyName               ;
	SELF.CompanyVerificationState                      := ri.CompanyVerificationState                     ;
	SELF.CompanyVerifiedCompanyName                    := ri.CompanyVerifiedCompanyName                   ;
	SELF.CompanyVerifiedState                          := ri.CompanyVerifiedState                         ;
	SELF.CompanyRC1		                                 := ri.CompanyRC1		                                ;
	SELF.CompanyRC2		                                 := ri.CompanyRC2		                                ;
	SELF.CompanyRC3		                                 := ri.CompanyRC3		                                ;
	SELF.CompanyRC4		                                 := ri.CompanyRC4		                                ;
	SELF.CompanyRC5		                                 := ri.CompanyRC5		                                ;
	SELF.CompanyRC6		                                 := ri.CompanyRC6		                                ;
	SELF.RepNameAddressSSNSummary                      := ri.RepNameAddressSSNSummary                     ;
	SELF.RepNameAddressPhoneSummary                    := ri.RepNameAddressPhoneSummary                   ;
	SELF.RepComprehensiveVerificationIndex             := ri.RepComprehensiveVerificationIndex            ;
	SELF.RepAreaCodeSplitFlag                          := ri.RepAreaCodeSplitFlag                         ;
	SELF.RepSSNInfoValid                               := ri.RepSSNInfoValid                              ;
	SELF.RepSSNInfoIssuedLocation                      := ri.RepSSNInfoIssuedLocation                     ;
	SELF.RepSSNInfoIssuedStartDate                     := ri.RepSSNInfoIssuedStartDate                    ;
	SELF.RepSSNInfoIssuedEndDate                       := ri.RepSSNInfoIssuedEndDate                      ;
	SELF.RepFollowupAction1                            := ri.RepFollowupAction1                           ;
	SELF.RepFollowupAction2                            := ri.RepFollowupAction2                           ;
	SELF.RepFollowupAction3                            := ri.RepFollowupAction3                           ;
	SELF.RepFollowupAction4                            := ri.RepFollowupAction4                           ;
	SELF.RepFollowupAction5                            := ri.RepFollowupAction5                           ;
	SELF.RepFollowupAction6                            := ri.RepFollowupAction6                           ;
	SELF.RepVerifiedSSN                                := ri.RepVerifiedSSN                               ;
	SELF.RepVerifiedAddress                            := ri.RepVerifiedAddress                           ;
	SELF.RepVerifiedCity                               := ri.RepVerifiedCity                              ;
	SELF.RepVerifiedState                              := ri.RepVerifiedState                             ;
	SELF.RepVerifiedZIP                                := ri.RepVerifiedZIP                               ;
	SELF.RepVerifiedFirstName                          := ri.RepVerifiedFirstName                         ;
	SELF.RepVerifiedLastName                           := ri.RepVerifiedLastName                          ;
	SELF.RepVerificationName                           := ri.RepVerificationName                          ;
	SELF.RepVerificationAddress                        := ri.RepVerificationAddress                       ;
	SELF.RepVerificationSSN                            := ri.RepVerificationSSN                           ;
	SELF.RepRC1				                                 := ri.RepRC1				                                ;
	SELF.RepRC2				                                 := ri.RepRC2				                                ;
	SELF.RepRC3				                                 := ri.RepRC3				                                ;
	SELF.RepRC4				                                 := ri.RepRC4				                                ;
	SELF.RepRC5				                                 := ri.RepRC5				                                ;
	SELF.RepRC6				                                 := ri.RepRC6				                                ;
	SELF.Model1Name		                                 := ri.Model1Name		                                ;
	SELF.Model1Score		                               := ri.Model1Score		                              ;
	SELF.Model1Type		                                 := ri.Model1Type		                                ;
	SELF.Model1RC1			                               := ri.Model1RC1			                              ;
	SELF.Model1RC2			                               := ri.Model1RC2			                              ;
	SELF.Model1RC3			                               := ri.Model1RC3			                              ;
	SELF.Model1RC4			                               := ri.Model1RC4			                              ;
	SELF.Model1RC5			                               := ri.Model1RC5			                              ;
	SELF.Model1RC6			                               := ri.Model1RC6			                              ;
	SELF.Model2Name		                                 := ri.Model2Name		                                ;
	SELF.Model2Score		                               := ri.Model2Score		                              ;
	SELF.Model2Type		                                 := ri.Model2Type		                                ;
	SELF.Model2RC1			                               := ri.Model2RC1			                              ;
	SELF.Model2RC2			                               := ri.Model2RC2			                              ;
	SELF.Model2RC3			                               := ri.Model2RC3			                              ;
	SELF.Model2RC4			                               := ri.Model2RC4			                              ;
	SELF.Model2RC5			                               := ri.Model2RC5			                              ;
	SELF.Model2RC6			                               := ri.Model2RC6			                              ;
	SELF.Model3Name		                                 := ri.Model3Name		                                ;
	SELF.Model3Score		                               := ri.Model3Score		                              ;
	SELF.Model3Type		                                 := ri.Model3Type		                                ;
	SELF.Model3RC1			                               := ri.Model3RC1			                              ;
	SELF.Model3RC2			                               := ri.Model3RC2			                              ;
	SELF.Model3RC3			                               := ri.Model3RC3			                              ;
	SELF.Model3RC4			                               := ri.Model3RC4			                              ;
	SELF.Model3RC5			                               := ri.Model3RC5			                              ;
	SELF.Model3RC6			                               := ri.Model3RC6			                              ;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp_in := parsedInput_1+parsedInput_2;
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedRecordsTemp_in, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));

OUTPUT(COUNT(parsedRecords), NAMED('Total_Final_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
// table(finalRecords(AccountID = '1488800' and TransactionDate between BeginDate and enddate), {TransactionDate,  cnt := count(group)}, TransactionDate,  few);
  
/* ***********************************************************************************************
 *************************************************************************************************
 *             MODIFY EVERYTHING BELOW AS NEEDED TO PERFORM SAOT ANALYSIS                        *
 *************************************************************************************************
 *********************************************************************************************** */
