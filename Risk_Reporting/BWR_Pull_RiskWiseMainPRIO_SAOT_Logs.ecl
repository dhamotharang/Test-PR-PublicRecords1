#workunit('name', 'RiskWiseMainPRIO_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140302';
EndDate := '20140305';

AccountIDs := ['101130']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

Login_ID := ''; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records with this LoginID.
// LoginID := 'FUSA00002'; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records with this LoginID.

Trib_Code := ''; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records wtih this TribCode.
// TribCode := 'PI02'; // Set to blank to include all records for the above Account ID, otherwise this will filter to only include records wtih this TribCode.

eyeball := 100;

outputFile := '~bpahl::out::RiskWiseMainPRIO_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
LogsRaw_1 := IF(AccountIDs[1] != '', DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINPRIO'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))),
																	 DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKWISE.RISKWISEMAINPRIO'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs))));


// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs_1 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainPRIO>', '<RiskWise.RiskWiseMainPRIO><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainPRIO><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainPRIO>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_1, eyeball), NAMED('Sample_Yesterday_Logs_1'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout parseInput () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together

	SELF._LoginId            := TRIM(XMLTEXT('_LoginId'));
	SELF.TribCode            := TRIM(XMLTEXT('tribcode'));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.MiddleName					 := TRIM(XMLTEXT('middleini'));
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
	
	SELF := [];
END;
parsedInput_1 := PARSE(Logs_1, inputxml, parseInput(), XML('RiskWise.RiskWiseMainPRIO'));
OUTPUT(CHOOSEN(parsedInput_1, eyeball), NAMED('Sample_Parsed_Input_1'));
LOGS_11 := JOIN(DISTRIBUTE(parsedInput_1, HASH64(TransactionID)), DISTRIBUTE(Logs_1, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);

//new xml tags
Logs_2 := PROJECT(LogsRaw_1, TRANSFORM({RECORDOF(LogsRaw_1), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
																		SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskWise.RiskWiseMainPRIORequest>', '<RiskWise.RiskWiseMainPRIORequest><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>');
																		SELF.outputxml := '<RiskWise.RiskWiseMainPRIO><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>' + LEFT.outputxml + '</RiskWise.RiskWiseMainPRIO>';
																		SELF.TransactionID := LEFT.Transaction_ID;
																		SELF.AccountID := LEFT.customer_id;
																		SELF.TransactionDate := LEFT.DateTime[1..8];
																		SELF := LEFT));
																												
OUTPUT(CHOOSEN(Logs_2, eyeball), NAMED('Sample_Yesterday_Logs_2'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout parseInput_2 () := TRANSFORM
	SELF.TransactionID				:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together

	SELF._LoginId            := TRIM(XMLTEXT('_LoginId'));
	SELF.TribCode            := TRIM(XMLTEXT('tribcode'));
	SELF.DataRestrictionMask := TRIM(XMLTEXT('DataRestrictionMask'));
	SELF.Account             := TRIM(XMLTEXT('account'));
	SELF.FirstName           := TRIM(XMLTEXT('first'));
	SELF.MiddleName					 := TRIM(XMLTEXT('middleini'));
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
	
	SELF := [];
END;
parsedInput_2 := PARSE(Logs_2, inputxml, parseInput(), XML('RiskWise.RiskWiseMainPRIORequest'));

OUTPUT(CHOOSEN(parsedInput_2, eyeball), NAMED('Sample_Parsed_Input_2'));
LOGS_22 := JOIN(DISTRIBUTE(parsedInput_2, HASH64(TransactionID)), DISTRIBUTE(Logs_2, HASH64(TransactionID)),
	LEFT.TransactionID = RIGHT.TransactionID,
	TRANSFORM(RIGHT), ATMOST(RiskWise.max_atmost), LOCAL);
Logs := Logs_11 + LOGS_22;

Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout parseOutput () := TRANSFORM
	SELF.TransactionID     := TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together

	SELF.RiskWiseID        := TRIM(XMLTEXT('Dataset[1]/Row[1]/riskwiseid'));
	SELF.hriskphoneflag    := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskphoneflag'));
	SELF.phonevalflag      := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonevalflag'));
	SELF.phonezipflag      := TRIM(XMLTEXT('Dataset[1]/Row[1]/phonezipflag'));
	SELF.hriskaddrflag     := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskaddrflag'));
	SELF.decsflag          := TRIM(XMLTEXT('Dataset[1]/Row[1]/decsflag'));
	SELF.socsdobflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsdobflag'));
	SELF.socsvalflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsvalflag'));
	SELF.drlcvalflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/drlcvalflag'));
	SELF.frdriskscore      := TRIM(XMLTEXT('Dataset[1]/Row[1]/frdriskscore'));
	SELF.areacodesplitflag := TRIM(XMLTEXT('Dataset[1]/Row[1]/areacodesplitflag'));
	SELF.altareacode       := TRIM(XMLTEXT('Dataset[1]/Row[1]/altareacode'));
	SELF.splitdate         := TRIM(XMLTEXT('Dataset[1]/Row[1]/splitdate'));
	SELF.addrvalflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrvalflag'));
	SELF.dwelltypeflag     := TRIM(XMLTEXT('Dataset[1]/Row[1]/dwelltypeflag'));
	SELF.cassaddr          := TRIM(XMLTEXT('Dataset[1]/Row[1]/cassaddr'));
	SELF.casscity          := TRIM(XMLTEXT('Dataset[1]/Row[1]/casscity'));
	SELF.cassstate         := TRIM(XMLTEXT('Dataset[1]/Row[1]/cassstate'));
	SELF.casszip           := TRIM(XMLTEXT('Dataset[1]/Row[1]/casszip'));
	SELF.bansflag          := TRIM(XMLTEXT('Dataset[1]/Row[1]/bansflag'));
	SELF.coaalertflag      := TRIM(XMLTEXT('Dataset[1]/Row[1]/coaalertflag'));
	SELF.coafirst          := TRIM(XMLTEXT('Dataset[1]/Row[1]/coafirst'));
	SELF.coalast           := TRIM(XMLTEXT('Dataset[1]/Row[1]/coalast'));
	SELF.coaaddr           := TRIM(XMLTEXT('Dataset[1]/Row[1]/coaaddr'));
	SELF.coacity           := TRIM(XMLTEXT('Dataset[1]/Row[1]/coacity'));
	SELF.coastate          := TRIM(XMLTEXT('Dataset[1]/Row[1]/coastate'));
	SELF.coazip            := TRIM(XMLTEXT('Dataset[1]/Row[1]/coazip'));
	SELF.idtheftflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/idtheftflag'));
	SELF.aptscanflag       := TRIM(XMLTEXT('Dataset[1]/Row[1]/aptscanflag'));
	SELF.addrhistoryflag   := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrhistoryflag'));
	SELF.firstcount        := TRIM(XMLTEXT('Dataset[1]/Row[1]/firstcount'));
	SELF.lastcount         := TRIM(XMLTEXT('Dataset[1]/Row[1]/lastcount'));
	SELF.formerlastcount   := TRIM(XMLTEXT('Dataset[1]/Row[1]/formerlastcount'));
	SELF.addrcount         := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrcount'));
	SELF.hphonecount       := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphonecount'));
	SELF.wphonecount       := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonecount'));
	SELF.socscount         := TRIM(XMLTEXT('Dataset[1]/Row[1]/socscount'));
	SELF.socsverlevel      := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsverlevel'));
	SELF.dobcount          := TRIM(XMLTEXT('Dataset[1]/Row[1]/dobcount'));
	SELF.drlccount         := TRIM(XMLTEXT('Dataset[1]/Row[1]/drlccount'));
	SELF.emailcount        := TRIM(XMLTEXT('Dataset[1]/Row[1]/emailcount'));
	SELF.numelever         := TRIM(XMLTEXT('Dataset[1]/Row[1]/numelever'));
	SELF.numsource         := TRIM(XMLTEXT('Dataset[1]/Row[1]/numsource'));
	SELF.verfirst          := TRIM(XMLTEXT('Dataset[1]/Row[1]/verfirst'));
	SELF.verlast           := TRIM(XMLTEXT('Dataset[1]/Row[1]/verlast'));
	SELF.vercmpy           := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercmpy'));
	SELF.veraddr           := TRIM(XMLTEXT('Dataset[1]/Row[1]/veraddr'));
	SELF.vercity           := TRIM(XMLTEXT('Dataset[1]/Row[1]/vercity'));
	SELF.verstate          := TRIM(XMLTEXT('Dataset[1]/Row[1]/verstate'));
	SELF.verzip            := TRIM(XMLTEXT('Dataset[1]/Row[1]/verzip'));
	SELF.verhphone         := TRIM(XMLTEXT('Dataset[1]/Row[1]/verhphone'));
	SELF.verwphone         := TRIM(XMLTEXT('Dataset[1]/Row[1]/verwphone'));
	SELF.verSSN            := TRIM(XMLTEXT('Dataset[1]/Row[1]/versocs'));
	SELF.verdob            := TRIM(XMLTEXT('Dataset[1]/Row[1]/verdob'));
	SELF.verdrlc           := TRIM(XMLTEXT('Dataset[1]/Row[1]/verdrlc'));
	SELF.veremail          := TRIM(XMLTEXT('Dataset[1]/Row[1]/veremail'));
	SELF.firstscore        := TRIM(XMLTEXT('Dataset[1]/Row[1]/firstscore'));
	SELF.lastscore         := TRIM(XMLTEXT('Dataset[1]/Row[1]/lastscore'));
	SELF.cmpyscore         := TRIM(XMLTEXT('Dataset[1]/Row[1]/cmpyscore'));
	SELF.addrscore         := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrscore'));
	SELF.hphonescore       := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphonescore'));
	SELF.wphonescore       := TRIM(XMLTEXT('Dataset[1]/Row[1]/wphonescore'));
	SELF.ssnscore          := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsscore'));
	SELF.dobscore          := TRIM(XMLTEXT('Dataset[1]/Row[1]/dobscore'));
	SELF.dlnmscore         := TRIM(XMLTEXT('Dataset[1]/Row[1]/dlnmscore'));
	SELF.emailscore        := TRIM(XMLTEXT('Dataset[1]/Row[1]/emailscore'));
	SELF.SSNMiskeyFlag     := TRIM(XMLTEXT('Dataset[1]/Row[1]/socsmiskeyflag'));
	SELF.hphonemiskeyflag  := TRIM(XMLTEXT('Dataset[1]/Row[1]/hphonemiskeyflag'));
	SELF.addrmiskeyflag    := TRIM(XMLTEXT('Dataset[1]/Row[1]/addrmiskeyflag'));
	SELF.hriskcmpy         := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskcmpy'));
	SELF.hrisksic          := TRIM(XMLTEXT('Dataset[1]/Row[1]/hrisksic'));
	SELF.hriskphone        := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskphone'));
	SELF.hriskaddr         := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskaddr'));
	SELF.hriskcity         := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskcity'));
	SELF.hriskstate        := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskstate'));
	SELF.hriskzip          := TRIM(XMLTEXT('Dataset[1]/Row[1]/hriskzip'));
	SELF.disthphoneaddr    := TRIM(XMLTEXT('Dataset[1]/Row[1]/disthphoneaddr'));
	SELF.disthphonewphone  := TRIM(XMLTEXT('Dataset[1]/Row[1]/disthphonewphone'));
	SELF.distwphoneaddr    := TRIM(XMLTEXT('Dataset[1]/Row[1]/distwphoneaddr'));
	SELF.estincome         := TRIM(XMLTEXT('Dataset[1]/Row[1]/estincome'));
	SELF.numfraud          := TRIM(XMLTEXT('Dataset[1]/Row[1]/numfraud'));
	SELF.firstname_out     := TRIM(XMLTEXT('Dataset[1]/Row[1]/first'));
	SELF.lastname_out      := TRIM(XMLTEXT('Dataset[1]/Row[1]/last'));
	SELF.Addr_out          := TRIM(XMLTEXT('Dataset[1]/Row[1]/addr'));
	SELF.City_out          := TRIM(XMLTEXT('Dataset[1]/Row[1]/city'));
	SELF.State_out         := TRIM(XMLTEXT('Dataset[1]/Row[1]/state'));
	SELF.Zip_out           := TRIM(XMLTEXT('Dataset[1]/Row[1]/zip'));
	SELF.firstname2_out    := TRIM(XMLTEXT('Dataset[1]/Row[1]/first2'));
	SELF.lastname2_out     := TRIM(XMLTEXT('Dataset[1]/Row[1]/last2'));
	SELF.addr2_out         := TRIM(XMLTEXT('Dataset[1]/Row[1]/addr2'));
	SELF.City2_out         := TRIM(XMLTEXT('Dataset[1]/Row[1]/city2'));
	SELF.State2_out        := TRIM(XMLTEXT('Dataset[1]/Row[1]/state2'));
	SELF.Zip2_out          := TRIM(XMLTEXT('Dataset[1]/Row[1]/zip2'));

	SELF := [];
END;
parsedOutputTemp_1 := PARSE(Logs_11, outputxml, parseOutput(), XML('RiskWise.RiskWiseMainPRIO'));
parsedOutputTemp_2 := PARSE(Logs_22, outputxml, parseOutput(), XML('RiskWise.RiskWiseMainPRIO'));
parsedOutput := parsedOutputTemp_1 + parsedOutputTemp_2;

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout combineParsedRecords(Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout le, Risk_Reporting.Layouts.Parsed_RiskWiseMainPRIO_Layout ri) := TRANSFORM
	SELF.RiskWiseID        := ri.RiskWiseID       ;
	SELF.hriskphoneflag    := ri.hriskphoneflag   ;
	SELF.phonevalflag      := ri.phonevalflag     ;
	SELF.phonezipflag      := ri.phonezipflag     ;
	SELF.hriskaddrflag     := ri.hriskaddrflag    ;
	SELF.decsflag          := ri.decsflag         ;
	SELF.socsdobflag       := ri.socsdobflag      ;
	SELF.socsvalflag       := ri.socsvalflag      ;
	SELF.drlcvalflag       := ri.drlcvalflag      ;
	SELF.frdriskscore      := ri.frdriskscore     ;
	SELF.areacodesplitflag := ri.areacodesplitflag;
	SELF.altareacode       := ri.altareacode      ;
	SELF.splitdate         := ri.splitdate        ;
	SELF.addrvalflag       := ri.addrvalflag      ;
	SELF.dwelltypeflag     := ri.dwelltypeflag    ;
	SELF.cassaddr          := ri.cassaddr         ;
	SELF.casscity          := ri.casscity         ;
	SELF.cassstate         := ri.cassstate        ;
	SELF.casszip           := ri.casszip          ;
	SELF.bansflag          := ri.bansflag         ;
	SELF.coaalertflag      := ri.coaalertflag     ;
	SELF.coafirst          := ri.coafirst         ;
	SELF.coalast           := ri.coalast          ;
	SELF.coaaddr           := ri.coaaddr          ;
	SELF.coacity           := ri.coacity          ;
	SELF.coastate          := ri.coastate         ;
	SELF.coazip            := ri.coazip           ;
	SELF.idtheftflag       := ri.idtheftflag      ;
	SELF.aptscanflag       := ri.aptscanflag      ;
	SELF.addrhistoryflag   := ri.addrhistoryflag  ;
	SELF.firstcount        := ri.firstcount       ;
	SELF.lastcount         := ri.lastcount        ;
	SELF.formerlastcount   := ri.formerlastcount  ;
	SELF.addrcount         := ri.addrcount        ;
	SELF.hphonecount       := ri.hphonecount      ;
	SELF.wphonecount       := ri.wphonecount      ;
	SELF.socscount         := ri.socscount        ;
	SELF.socsverlevel      := ri.socsverlevel     ;
	SELF.dobcount          := ri.dobcount         ;
	SELF.drlccount         := ri.drlccount        ;
	SELF.emailcount        := ri.emailcount       ;
	SELF.numelever         := ri.numelever        ;
	SELF.numsource         := ri.numsource        ;
	SELF.verfirst          := ri.verfirst         ;
	SELF.verlast           := ri.verlast          ;
	SELF.vercmpy           := ri.vercmpy          ;
	SELF.veraddr           := ri.veraddr          ;
	SELF.vercity           := ri.vercity          ;
	SELF.verstate          := ri.verstate         ;
	SELF.verzip            := ri.verzip           ;
	SELF.verhphone         := ri.verhphone        ;
	SELF.verwphone         := ri.verwphone        ;
	SELF.verSSN            := ri.verSSN           ;
	SELF.verdob            := ri.verdob           ;
	SELF.verdrlc           := ri.verdrlc          ;
	SELF.veremail          := ri.veremail         ;
	SELF.firstscore        := ri.firstscore       ;
	SELF.lastscore         := ri.lastscore        ;
	SELF.cmpyscore         := ri.cmpyscore        ;
	SELF.addrscore         := ri.addrscore        ;
	SELF.hphonescore       := ri.hphonescore      ;
	SELF.wphonescore       := ri.wphonescore      ;
	SELF.ssnscore          := ri.ssnscore         ;
	SELF.dobscore          := ri.dobscore         ;
	SELF.dlnmscore         := ri.dlnmscore        ;
	SELF.emailscore        := ri.emailscore       ;
	SELF.SSNMiskeyFlag     := ri.SSNMiskeyFlag    ;
	SELF.hphonemiskeyflag  := ri.hphonemiskeyflag ;
	SELF.addrmiskeyflag    := ri.addrmiskeyflag   ;
	SELF.hriskcmpy         := ri.hriskcmpy        ;
	SELF.hrisksic          := ri.hrisksic         ;
	SELF.hriskphone        := ri.hriskphone       ;
	SELF.hriskaddr         := ri.hriskaddr        ;
	SELF.hriskcity         := ri.hriskcity        ;
	SELF.hriskstate        := ri.hriskstate       ;
	SELF.hriskzip          := ri.hriskzip         ;
	SELF.disthphoneaddr    := ri.disthphoneaddr   ;
	SELF.disthphonewphone  := ri.disthphonewphone ;
	SELF.distwphoneaddr    := ri.distwphoneaddr   ;
	SELF.estincome         := ri.estincome        ;
	SELF.numfraud          := ri.numfraud         ;
	SELF.firstname_out     := ri.firstname_out    ;
	SELF.lastname_out      := ri.lastname_out     ;
	SELF.Addr_out          := ri.Addr_out         ;
	SELF.City_out          := ri.City_out         ;
	SELF.State_out         := ri.State_out        ;
	SELF.Zip_out           := ri.Zip_out          ;
	SELF.firstname2_out    := ri.firstname2_out   ;
	SELF.lastname2_out     := ri.lastname2_out    ;
	SELF.addr2_out         := ri.addr2_out        ;
	SELF.City2_out         := ri.City2_out        ;
	SELF.State2_out        := ri.State2_out       ;
	SELF.Zip2_out          := ri.Zip2_out         ;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecordsTemp_in :=parsedInput_1+parsedInput_2;

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
