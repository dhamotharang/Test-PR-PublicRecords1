#workunit('name', 'RiskWiseMainBC1O_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140303';
EndDate := '20140305';

AccountIDs := ['101130']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

Login_ID := ''; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records with this LoginID.
// LoginID := 'FUSA00002'; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records with this LoginID.

Trib_Code := ''; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records wtih this TribCode.
// TribCode := 'BNK4'; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records wtih this TribCode.

eyeball := 100;

outputFile := '~bpahl::out::RiskWiseMainBC1O_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINBC1O'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainBC1O>', '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainBC1O>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Yesterday_Logs_1'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	
	SELF._LoginId            := TRIM(XMLTEXT('_LoginId'));
	SELF.TribCode            := TRIM(XMLTEXT('tribcode'));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.LastName            := TRIM(XMLTEXT('last'));
	SELF.Address             := TRIM(XMLTEXT('addr'));
	SELF.City                := TRIM(XMLTEXT('city'));
	SELF.State               := TRIM(XMLTEXT('state'));
	SELF.Zip                 := Risk_Reporting.Common.ParseZIP(TRIM(XMLTEXT('zip')));
	SELF.SSN                 := Risk_Reporting.Common.ParseSSN(TRIM(XMLTEXT('socs')));
	SELF.DateOfBirth         := TRIM(XMLTEXT('dob'));
	SELF.HomePhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('hphone'));
	SELF.WorkPhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('wphone'));
	SELF.Income              := TRIM(XMLTEXT('income'));
	SELF.CompanyName			   := TRIM(XMLTEXT('cmpy'));
	SELF.CompanyAddress	     := TRIM(XMLTEXT('cmpyaddr'));
	SELF.CompanyCity			   := TRIM(XMLTEXT('cmpycity'));
	SELF.CompanyState		     := TRIM(XMLTEXT('cmpystate'));
	SELF.CompanyZIP			     := TRIM(XMLTEXT('cmpyzip'));
	SELF.FEIN						     := TRIM(XMLTEXT('fin'));
	
	SELF := [];
END;
parsedInput_1 := DISTRIBUTE(PARSE(Logs_1, inputxml, parseInput(), XML('RiskWise.RiskWiseMainBC1O')), HASH64(TransactionID));
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_Parsed_Input_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);

// new xml tags
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainBC1ORequest>', '<RiskWise.RiskWiseMainBC1ORequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainBC1O><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainBC1O>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Yesterday_Logs_2'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout parseInput_2 () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	
	SELF._LoginId            := TRIM(XMLTEXT('_LoginId'));
	SELF.TribCode            := TRIM(XMLTEXT('tribcode'));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.LastName            := TRIM(XMLTEXT('last'));
	SELF.Address             := TRIM(XMLTEXT('addr'));
	SELF.City                := TRIM(XMLTEXT('city'));
	SELF.State               := TRIM(XMLTEXT('state'));
	SELF.Zip                 := Risk_Reporting.Common.ParseZIP(TRIM(XMLTEXT('zip')));
	SELF.SSN                 := Risk_Reporting.Common.ParseSSN(TRIM(XMLTEXT('socs')));
	SELF.DateOfBirth         := TRIM(XMLTEXT('dob'));
	SELF.HomePhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('hphone'));
	SELF.WorkPhone           := Risk_Reporting.Common.ParsePhone(XMLTEXT('wphone'));
	SELF.Income              := TRIM(XMLTEXT('income'));
	SELF.CompanyName			   := TRIM(XMLTEXT('cmpy'));
	SELF.CompanyAddress	     := TRIM(XMLTEXT('cmpyaddr'));
	SELF.CompanyCity			   := TRIM(XMLTEXT('cmpycity'));
	SELF.CompanyState		     := TRIM(XMLTEXT('cmpystate'));
	SELF.CompanyZIP			     := TRIM(XMLTEXT('cmpyzip'));
	SELF.FEIN						     := TRIM(XMLTEXT('fin'));
	
	SELF := [];
END;
parsedInput_2 := DISTRIBUTE(PARSE(Logs_2, inputxml, parseInput_2(), XML('RiskWise.RiskWiseMainBC1O')), HASH64(TransactionID));

OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_parsedInput_2'));
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22;
Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together

	SELF.RiskWiseID                := TRIM(XMLTEXT('Dataset[1]/Row[1]/riskwiseid'));
	SELF.FirstCount                := TRIM(XMLTEXT('Dataset[1]/Row[1]/firstcount'));
	SELF.LastCount                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/lastcount'));
	SELF.AddrCount                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrcount'));
	SELF.PhoneCount                := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonecount'));
	SELF.SSNCount                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/socscount'));
	SELF.SSNVerLevel               := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsverlevel'));
	SELF.DOBCount                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/dobcount'));
	SELF.DriverLicenseCount        := TRIM(XMLTEXT('Dataset[1]/Row[1]/drlccount'));
	SELF.CompanyCount              := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpycount'));
	SELF.CompanyAddressCount       := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyaddrcount'));
	SELF.CompanyPhoneCount         := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyphonecount'));
	SELF.FEINCount                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/fincount'));
	SELF.EmailCount                := TRIM(XMLTEXT('Dataset[1]/Row[1]/emailcount'));
	SELF.VerFirstName              := TRIM(XMLTEXT('Dataset[1]/Row[1]/verfirst'));
	SELF.VerLastName               := TRIM(XMLTEXT('Dataset[1]/Row[1]/verlast'));
	SELF.VerAddress                := TRIM(XMLTEXT('Dataset[1]/Row[1]/veraddr'));
	SELF.VerCity                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercity'));
	SELF.VerState                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/verstate'));
	SELF.VerZIP                    := TRIM(XMLTEXT('Dataset[1]/Row[1]/verzip'));
	SELF.VerHomePhone              := TRIM(XMLTEXT('Dataset[1]/Row[1]/verhphone'));
	SELF.VerSSN                    := TRIM(XMLTEXT('Dataset[1]/Row[1]/versocs'));
	SELF.VerDriverLicense          := TRIM(XMLTEXT('Dataset[1]/Row[1]/verdrlc'));
	SELF.VerDateOfBirth            := TRIM(XMLTEXT('Dataset[1]/Row[1]/verdob'));
	SELF.VerCompanyName            := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpy'));
	SELF.VerCompanyAddress         := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpyaddr'));
	SELF.VerCompanyCity            := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpycity'));
	SELF.VerCompanyState           := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpystate'));
	SELF.VerCompanyZIP             := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpyzip'));
	SELF.VerCompanyPhone           := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpyphone'));
	SELF.VerCompanyFEIN            := TRIM(XMLTEXT('Dataset[1]/Row[1]/verfin'));
	SELF.Numelever                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/numelever'));
	SELF.NumSource                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/numsource'));
	SELF.NumCompanyelever          := TRIM(XMLTEXT('Dataset[1]/Row[1]/numcmpyelever'));
	SELF.NumCompanySource          := TRIM(XMLTEXT('Dataset[1]/Row[1]/numcmpysource'));
	SELF.FirstScore                := TRIM(XMLTEXT('Dataset[1]/Row[1]/firstscore'));
	SELF.LastScore                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/lastscore'));
	SELF.CompanyScore              := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyscore'));
	SELF.AddressScore              := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrscore'));
	SELF.PhoneScore                := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonescore'));
	SELF.SSNScore                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/socscore'));
	SELF.DateOfBirthScore          := TRIM(XMLTEXT('Dataset[1]/Row[1]/dobscore'));
	SELF.DriverLicenseScore        := TRIM(XMLTEXT('Dataset[1]/Row[1]/drlcscore'));
	SELF.CompanyScore2             := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyscore2'));
	SELF.CompanyAddressScore       := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyaddrscore'));
	SELF.CompanyPhoneScore         := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyphonescore'));
	SELF.FEINScore                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/finscore'));
	SELF.EmailScore                := TRIM(XMLTEXT('Dataset[1]/Row[1]/emailscore'));
	SELF.WPhoneName                := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonename'));
	SELF.WPhoneAddress             := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphoneaddr'));
	SELF.WPhoneCity                := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonecity'));
	SELF.WPhoneState               := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonestate'));
	SELF.WPhoneZIP                 := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonezip'));
	SELF.SSNMiskeyFlag             := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsmiskeyflag'));
	SELF.PhoneMiskeyFlag           := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonemiskeyflag'));
	SELF.AddressMiskeyFlag         := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrmiskeyflag'));
	SELF.IDTheftFlag               := TRIM(XMLTEXT('Dataset[1]/Row[1]/idtheftflag'));
	SELF.HomePhoneTypeFlag         := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphonetypeflag'));
	SELF.HomePhoneSrvc             := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphonesrvc'));
	SELF.HomePhone2AddressTypeFlag := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphone2addrtypeflag'));
	SELF.HomePhone2TypeFlag        := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphone2typeflag'));
	SELF.WPhoneTypeFlag            := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonetypeflag'));
	SELF.WPhoneSrvc                := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonesrvc'));
	SELF.AreaCodeSplitFlag         := TRIM(XMLTEXT('Dataset[1]/Row[1]/areacodesplitflag'));
	SELF.AltAreaCode               := TRIM(XMLTEXT('Dataset[1]/Row[1]/altareacode'));
	SELF.PhoneZIPFlag              := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonezipflag'));
	SELF.SSNDateOfBirth            := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsdob'));
	SELF.HighRiskPhoneFlag         := TRIM(XMLTEXT('Dataset[1]/Row[1]/hhriskphoneflag'));
	SELF.HighRiskCompany           := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskcmpy'));
	SELF.SICCode                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/sic'));
	SELF.ZIPClassFlag              := TRIM(XMLTEXT('Dataset[1]/Row[1]/zipclassflag'));
	SELF.ZIPName                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/zipname'));
	SELF.MedianIncome              := TRIM(XMLTEXT('Dataset[1]/Row[1]/medincome'));
	SELF.AddressRiskFlag           := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrriskflag'));
	SELF.BansFlag                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/bansflag'));
	SELF.BansDateFiled             := TRIM(XMLTEXT('Dataset[1]/Row[1]/bansdatefiled'));
	SELF.AddrValFlag               := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrvalflag'));
	SELF.AddressReason             := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrreason'));
	SELF.LowIssue                  := TRIM(XMLTEXT('Dataset[1]/Row[1]/lowissue'));
	SELF.DwellTypeFlag             := TRIM(XMLTEXT('Dataset[1]/Row[1]/dwelltypeflag'));
	SELF.PhoneDissFlag             := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonedissflag'));
	SELF.EcoVariables              := TRIM(XMLTEXT('Dataset[1]/Row[1]/ecovariables'));
	SELF.TCIFull                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/tcifull'));
	SELF.TCILast                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/tcilast'));
	SELF.TCIAddr                   := TRIM(XMLTEXT('Dataset[1]/Row[1]/tciaddr'));
	
	SELF := [];
END;
parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('RiskWise.RiskWiseMainBC1O'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('RiskWise.RiskWiseMainBC1O'));
parsedOutput :=parsedOutputTemp_1 + parsedOutputTemp_2;

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout le, Risk_Reporting.Layouts.Parsed_RiskWiseMainBC1O_Layout ri) := TRANSFORM
	SELF.RiskWiseID                := ri.RiskWiseID               ;
	SELF.FirstCount                := ri.FirstCount               ;
	SELF.LastCount                 := ri.LastCount                ;
	SELF.AddrCount                 := ri.AddrCount                ;
	SELF.PhoneCount                := ri.PhoneCount               ;
	SELF.SSNCount                  := ri.SSNCount                 ;
	SELF.SSNVerLevel               := ri.SSNVerLevel              ;
	SELF.DOBCount                  := ri.DOBCount                 ;
	SELF.DriverLicenseCount        := ri.DriverLicenseCount       ;
	SELF.CompanyCount              := ri.CompanyCount             ;
	SELF.CompanyAddressCount       := ri.CompanyAddressCount      ;
	SELF.CompanyPhoneCount         := ri.CompanyPhoneCount        ;
	SELF.FEINCount                 := ri.FEINCount                ;
	SELF.EmailCount                := ri.EmailCount               ;
	SELF.VerFirstName              := ri.VerFirstName             ;
	SELF.VerLastName               := ri.VerLastName              ;
	SELF.VerAddress                := ri.VerAddress               ;
	SELF.VerCity                   := ri.VerCity                  ;
	SELF.VerState                  := ri.VerState                 ;
	SELF.VerZIP                    := ri.VerZIP                   ;
	SELF.VerHomePhone              := ri.VerHomePhone             ;
	SELF.VerSSN                    := ri.VerSSN                   ;
	SELF.VerDriverLicense          := ri.VerDriverLicense         ;
	SELF.VerDateOfBirth            := ri.VerDateOfBirth           ;
	SELF.VerCompanyName            := ri.VerCompanyName           ;
	SELF.VerCompanyAddress         := ri.VerCompanyAddress        ;
	SELF.VerCompanyCity            := ri.VerCompanyCity           ;
	SELF.VerCompanyState           := ri.VerCompanyState          ;
	SELF.VerCompanyZIP             := ri.VerCompanyZIP            ;
	SELF.VerCompanyPhone           := ri.VerCompanyPhone          ;
	SELF.VerCompanyFEIN            := ri.VerCompanyFEIN           ;
	SELF.Numelever                 := ri.Numelever                ;
	SELF.NumSource                 := ri.NumSource                ;
	SELF.NumCompanyelever          := ri.NumCompanyelever         ;
	SELF.NumCompanySource          := ri.NumCompanySource         ;
	SELF.FirstScore                := ri.FirstScore               ;
	SELF.LastScore                 := ri.LastScore                ;
	SELF.CompanyScore              := ri.CompanyScore             ;
	SELF.AddressScore              := ri.AddressScore             ;
	SELF.PhoneScore                := ri.PhoneScore               ;
	SELF.SSNScore                  := ri.SSNScore                 ;
	SELF.DateOfBirthScore          := ri.DateOfBirthScore         ;
	SELF.DriverLicenseScore        := ri.DriverLicenseScore       ;
	SELF.CompanyScore2             := ri.CompanyScore2            ;
	SELF.CompanyAddressScore       := ri.CompanyAddressScore      ;
	SELF.CompanyPhoneScore         := ri.CompanyPhoneScore        ;
	SELF.FEINScore                 := ri.FEINScore                ;
	SELF.EmailScore                := ri.EmailScore               ;
	SELF.WPhoneName                := ri.WPhoneName               ;
	SELF.WPhoneAddress             := ri.WPhoneAddress            ;
	SELF.WPhoneCity                := ri.WPhoneCity               ;
	SELF.WPhoneState               := ri.WPhoneState              ;
	SELF.WPhoneZIP                 := ri.WPhoneZIP                ;
	SELF.SSNMiskeyFlag             := ri.SSNMiskeyFlag            ;
	SELF.PhoneMiskeyFlag           := ri.PhoneMiskeyFlag          ;
	SELF.AddressMiskeyFlag         := ri.AddressMiskeyFlag        ;
	SELF.IDTheftFlag               := ri.IDTheftFlag              ;
	SELF.HomePhoneTypeFlag         := ri.HomePhoneTypeFlag        ;
	SELF.HomePhoneSrvc             := ri.HomePhoneSrvc            ;
	SELF.HomePhone2AddressTypeFlag := ri.HomePhone2AddressTypeFlag;
	SELF.HomePhone2TypeFlag        := ri.HomePhone2TypeFlag       ;
	SELF.WPhoneTypeFlag            := ri.WPhoneTypeFlag           ;
	SELF.WPhoneSrvc                := ri.WPhoneSrvc               ;
	SELF.AreaCodeSplitFlag         := ri.AreaCodeSplitFlag        ;
	SELF.AltAreaCode               := ri.AltAreaCode              ;
	SELF.PhoneZIPFlag              := ri.PhoneZIPFlag             ;
	SELF.SSNDateOfBirth            := ri.SSNDateOfBirth           ;
	SELF.HighRiskPhoneFlag         := ri.HighRiskPhoneFlag        ;
	SELF.HighRiskCompany           := ri.HighRiskCompany          ;
	SELF.SICCode                   := ri.SICCode                  ;
	SELF.ZIPClassFlag              := ri.ZIPClassFlag             ;
	SELF.ZIPName                   := ri.ZIPName                  ;
	SELF.MedianIncome              := ri.MedianIncome             ;
	SELF.AddressRiskFlag           := ri.AddressRiskFlag          ;
	SELF.BansFlag                  := ri.BansFlag                 ;
	SELF.BansDateFiled             := ri.BansDateFiled            ;
	SELF.AddrValFlag               := ri.AddrValFlag              ;
	SELF.AddressReason             := ri.AddressReason            ;
	SELF.LowIssue                  := ri.LowIssue                 ;
	SELF.DwellTypeFlag             := ri.DwellTypeFlag            ;
	SELF.PhoneDissFlag             := ri.PhoneDissFlag            ;
	SELF.EcoVariables              := ri.EcoVariables             ;
	SELF.TCIFull                   := ri.TCIFull                  ;
	SELF.TCILast                   := ri.TCILast                  ;
	SELF.TCIAddr                   := ri.TCIAddr                  ;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp_in := parsedInput_1+parsedInput_2;

parsedRecordsTemp := JOIN(DISTRIBUTE(parsedRecordsTemp_in, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

parsedRecordsTemp2 := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

parsedRecordsFiltered1 := IF(Login_ID <> '', parsedRecordsTemp2 (_LoginID = Login_ID), parsedRecordsTemp2);

parsedRecordsFiltered2 := IF(Trib_Code <> '', parsedRecordsFiltered1 (TribCode = Trib_Code), parsedRecordsFiltered1);

parsedRecords := parsedRecordsFiltered2;

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));

OUTPUT(COUNT(parsedRecords), NAMED('Total_Final_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(AccountID, TransactionDate, TransactionID)), AccountID, TransactionDate, TransactionID, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
 // table(finalRecords(AccountID = '101130' and TransactionDate between BeginDate and enddate), {TransactionDate,  cnt := count(group)}, TransactionDate,  few);
  
/* ***********************************************************************************************
 *************************************************************************************************
 *             MODIFY EVERYTHING BELOW AS NEEDED TO PERFORM SAOT ANALYSIS                        *
 *************************************************************************************************
 *********************************************************************************************** */
