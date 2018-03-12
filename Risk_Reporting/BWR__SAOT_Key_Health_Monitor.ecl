#workunit('name', 'SAOT_Key_Health_Monitor');

// #option('allowedClusters', 'thor400_20,thor400_44,thor400_60'); // This workunit can run on these clusters
// #option('AllowAutoQueueSwitch', TRUE); // If the current queue is full, use an available cluster from above

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

// Pull logs for the past year to do our rolling Average on
EndDate := ut.GetDate;
BeginDateTemp := ut.date_math(EndDate, -365);
BeginDate := IF(BeginDateTemp >= '20130512', BeginDateTemp, '20130512'); // Tracking didn't fully start until this date, eliminate the "test" days before this date.

eyeball := 100;

/* ***********************************************************************************************
 *************************************************************************************************
 *                 GATHER NON FCRA SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                     *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

LogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['INSTANTID', 'FRAUDPOINT', 'PREMISEASSOCIATION', 'VERIFICATIONOFOCCUPANCY'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs)));

Logs := DISTRIBUTE(PROJECT(LogsRaw, TRANSFORM({STRING8 TransactionDate, STRING50 ProductName},
					SELF.TransactionDate := LEFT.DateTime[1..8];
					SELF.ProductName := StringLib.StringToUpperCase(TRIM(LEFT.Product)))), HASH64(TransactionDate));
				
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Non_FCRA_Logs'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                   GATHER FCRA SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                       *
 *************************************************************************************************
 *********************************************************************************************** */

FCRALogFile := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID;

FCRALogsRaw := DISTRIBUTE(PULL(FCRALogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['RISKVIEW', 'RISKVIEWATTRIBUTES', 'RISKVIEW2'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs)));

FCRALogs := DISTRIBUTE(PROJECT(FCRALogsRaw, TRANSFORM({STRING8 TransactionDate, STRING50 ProductName},
					SELF.TransactionDate := LEFT.DateTime[1..8];
					SELF.ProductName := StringLib.StringToUpperCase(TRIM(LEFT.Product)))), HASH64(TransactionDate));
				
OUTPUT(CHOOSEN(FCRALogs, eyeball), NAMED('Sample_FCRA_Logs'));

/* ***********************************************************************************************
 *************************************************************************************************
 *            FIGURE OUT HOW OLD THE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS ARE               *
 *************************************************************************************************
 *********************************************************************************************** */
TodaysDate := EndDate;

NewestLogs := TOPN(Logs, 1, -TransactionDate);
OUTPUT(NewestLogs, NAMED('Newest_Log'));
NewestLogDate := NewestLogs[1].TransactionDate;
LogAge := UT.DaysApart(TodaysDate, NewestLogDate);
OUTPUT(LogAge, NAMED('Non_FCRA_Age'));

NewestFCRALogs := TOPN(FCRALogs, 1, -TransactionDate);
OUTPUT(NewestFCRALogs, NAMED('Newest_FCRA_Log'));
NewestFCRALogDate := NewestFCRALogs[1].TransactionDate;
FCRALogAge := UT.DaysApart(TodaysDate, NewestFCRALogDate);
OUTPUT(FCRALogAge, NAMED('FCRA_Age'));

onSchedule := 4; // Number of days behind today that is still 'on schedule'

recordCounts := TABLE(Logs, {STRING50 Product := ProductName, STRING8 TransactionDate := TransactionDate[1..8], UNSIGNED8 RecordCount := COUNT(GROUP)}, ProductName, TransactionDate[1..8]);
FCRArecordCounts := TABLE(FCRALogs, {STRING50 Product := ProductName, STRING8 TransactionDate := TransactionDate[1..8], UNSIGNED8 RecordCount := COUNT(GROUP)}, ProductName, TransactionDate[1..8]);

recentRecordCounts := SORT(recordCounts (TransactionDate >= ut.date_math(TodaysDate, -60)), Product, TransactionDate, -RecordCount);
FCRArecentRecordCounts := SORT(FCRArecordCounts (TransactionDate >= ut.date_math(TodaysDate, -60)), Product, TransactionDate, -RecordCount);

recentRecordCountsPlus := PROJECT(recentRecordCounts, TRANSFORM({RECORDOF(LEFT), STRING emailText}, SELF := LEFT; SELF := []));
FCRArecentRecordCountsPlus := PROJECT(FCRArecentRecordCounts, TRANSFORM({RECORDOF(LEFT), STRING emailText}, SELF := LEFT; SELF := []));

generateEmailText := SORT(ITERATE(recentRecordCountsPlus, TRANSFORM(RECORDOF(LEFT), 
	SELF.emailText := LEFT.emailText + RIGHT.Product + '\t| ' + RIGHT.TransactionDate + '\t| ' + RIGHT.RecordCount + ' Total Records\n'; 
	SELF := RIGHT)), -LENGTH(TRIM(emailText)));
generateFCRAEmailText := SORT(ITERATE(FCRArecentRecordCountsPlus, TRANSFORM(RECORDOF(LEFT), 
	SELF.emailText := LEFT.emailText + RIGHT.Product + '\t| ' + RIGHT.TransactionDate + '\t| ' + RIGHT.RecordCount + ' Total Records\n'; 
	SELF := RIGHT)), -LENGTH(TRIM(emailText)));
	
OUTPUT(recordCounts, NAMED('recordCounts'));
OUTPUT(FCRArecordCounts, NAMED('FCRArecordCounts'));
OUTPUT(recentRecordCounts, NAMED('recentRecordCounts'));
OUTPUT(FCRArecentRecordCounts, NAMED('FCRArecentRecordCounts'));
OUTPUT(recentRecordCountsPlus, NAMED('recentRecordCountsPlus'));
OUTPUT(FCRArecentRecordCountsPlus, NAMED('FCRArecentRecordCountsPlus'));
OUTPUT(generateEmailText, NAMED('generateEmailText'));
OUTPUT(generateFCRAEmailText, NAMED('generateFCRAEmailText'));

emailBody :=
'SAOT Key Health Monitor' + '\n' +
'====================\n' +
'Report Run Date: ' + TodaysDate + '\n\n' +
'Non-FCRA Key Latest Data Date: ' + NewestLogDate + ' ' +
'--> ' + LogAge + ' Days Old (' + IF((INTEGER)LogAge <= onSchedule, 'On Schedule', (STRING)((INTEGER)LogAge - onSchedule) + ' Days Behind') + ')\n\n' +
'FCRA Key Latest Data Date: ' + NewestFCRALogDate + ' ' +
'--> ' + FCRALogAge + ' Days Old (' + IF((INTEGER)FCRALogAge <= onSchedule, 'On Schedule', (STRING)((INTEGER)FCRALogAge - onSchedule) + ' Days Behind') + ')\n\n' +
'\n\n' +
'Non-FCRA Key Record Counts Per Product:\n' +
'==================================\n' +
generateEmailText[1].emailText +
'\n\n' +
'FCRA Key Record Counts Per Product:\n' +
'==============================\n' +
generateFCRAEmailText[1].emailText +
'\n\n' +
'Workunit ' + StringLib.StringToUpperCase(ThorLib.wuid()) + '\n  http://10.173.84.202:8010/?inner=../WsWorkunits/WUInfo?Wuid=' + StringLib.StringToUpperCase(ThorLib.wuid());

OUTPUT(emailBody, NAMED('E_Mail_Body'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                                         SEND THE EMAIL                                        *
 *************************************************************************************************
 *********************************************************************************************** */

subject := MAP((INTEGER)LogAge > onSchedule AND (INTEGER)FCRALogAge > onSchedule	=> '**ALERT** Data Delay Both Non-FCRA and FCRA Keys - SAOT Key Health Monitor',
							 (INTEGER)LogAge > onSchedule 														 					=> '**ALERT** Data Delay Non-FCRA Key - SAOT Key Health Monitor',
							 (INTEGER)FCRALogAge > onSchedule 												 					=> '**ALERT** Data Delay FCRA Key - SAOT Key Health Monitor',
																																											'SAOT Key Health Monitor');

FileServices.SendEmail(IF((INTEGER)LogAge > onSchedule OR (INTEGER)FCRALogAge > onSchedule, Risk_Reporting.Constants.emailSAOTHealthReportsTo, 'Brenton.Pahl@lexisnexis.com'), 
																		subject,
																		emailBody,
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');		