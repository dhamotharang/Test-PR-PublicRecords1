currentDate := UT.GetDate;
// currentDate := ut.date_math('20120808', 2);

#workunit('name', 'RiskView_Daily_Score_Monitor__' + currentDate);

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

eyeball := 100;
dataLoadDelayDays := 1; // The data is delayed by 1 day, meaning that "yesterdays" data is available tomorrow (2 day delay)

baseFile := '~thor_data400::reports::riskview::score_monitoring_';
// baseFile := '~bpahl::riskview::score_monitoring_';

// Since we are protecting our files, we need to make sure to unlock today's version if it exists (Meaning something screwed up and we want to overwrite)
currentDateFile := baseFile + currentDate + '.csv';

// Lets also go through and prune the old files
SEQUENTIAL(IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -60) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -60) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -60) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -61) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -61) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -61) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -62) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -62) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -62) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -63) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -63) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -63) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -64) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -64) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -64) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -65) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -65) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -65) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -66) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -66) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -66) + '.csv', TRUE))),
IF(STD.File.FileExists(baseFile + ut.date_math(currentDate, -67) + '.csv'), SEQUENTIAL(STD.File.ProtectLogicalFile(baseFile + ut.date_math(currentDate, -67) + '.csv', FALSE), STD.File.DeleteLogicalFile(baseFile + ut.date_math(currentDate, -67) + '.csv', TRUE))));

// Go back a week, we really should never get to this point unless this is the first time running, but just in case we have failsafes for our failsafes.
previous1DaysFile := baseFile + ut.date_math(currentDate, -1) + '.csv';
previous2DaysFile := baseFile + ut.date_math(currentDate, -2) + '.csv';
previous3DaysFile := baseFile + ut.date_math(currentDate, -3) + '.csv';
previous4DaysFile := baseFile + ut.date_math(currentDate, -4) + '.csv';
previous5DaysFile := baseFile + ut.date_math(currentDate, -5) + '.csv';
previous6DaysFile := baseFile + ut.date_math(currentDate, -6) + '.csv';
previous7DaysFile := baseFile + ut.date_math(currentDate, -7) + '.csv';

previous1DaysFileExists := STD.File.FileExists(previous1DaysFile);
previous2DaysFileExists := STD.File.FileExists(previous2DaysFile);
previous3DaysFileExists := STD.File.FileExists(previous3DaysFile);
previous4DaysFileExists := STD.File.FileExists(previous4DaysFile);
previous5DaysFileExists := STD.File.FileExists(previous5DaysFile);
previous6DaysFileExists := STD.File.FileExists(previous6DaysFile);
previous7DaysFileExists := STD.File.FileExists(previous7DaysFile);

previousFilePath := MAP(previous1DaysFileExists => previous1DaysFile,
												previous2DaysFileExists => previous2DaysFile,
												previous3DaysFileExists => previous3DaysFile,
												previous4DaysFileExists => previous4DaysFile,
												previous5DaysFileExists => previous5DaysFile,
												previous6DaysFileExists => previous6DaysFile,
												previous7DaysFileExists => previous7DaysFile,
																										'');
																										
previousReportOffset := MAP(previous1DaysFileExists => -1,
														previous2DaysFileExists => -2,
														previous3DaysFileExists => -3,
														previous4DaysFileExists => -4,
														previous5DaysFileExists => -5,
														previous6DaysFileExists => -6,
														previous7DaysFileExists => -7,
														0);
														
previousReportDate := IF(previousReportOffset = 0, '00000000', ut.date_math(currentDate, previousReportOffset));
																										
OUTPUT('We used ' + IF(previousFilePath != '', previousFilePath, 'FIRST TIME REPORT') + ' as the most recent saved report.  The following files exist, ' +
				IF(previous1DaysFileExists, previous1DaysFile + ', ', '') + 
				IF(previous2DaysFileExists, previous2DaysFile + ', ', '') + 
				IF(previous3DaysFileExists, previous3DaysFile + ', ', '') + 
				IF(previous4DaysFileExists, previous4DaysFile + ', ', '') + 
				IF(previous5DaysFileExists, previous5DaysFile + ', ', '') + 
				IF(previous6DaysFileExists, previous6DaysFile + ', ', '') + 
				IF(previous7DaysFileExists, previous7DaysFile + ', ', ''), NAMED('Existing_Reports'));


LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

// The files are exported from MySQL the following day, which means the data isn't loaded to THOR until 2 days after.
yesterdaysLogsRaw := LogFile (StringLib.StringToUpperCase(TRIM(Product)) = 'RISKVIEW' AND datetime[1..8] = ut.date_math(currentDate, -1 - dataLoadDelayDays));

linerec := {STRING line};

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
yesterdaysLogs := PROJECT(yesterdaysLogsRaw, TRANSFORM(RECORDOF(yesterdaysLogsRaw), 
																												SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<RiskView>', '<RiskView><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
																												SELF.outputxml := '<RiskView>' + LEFT.outputxml + '</RiskView>';
																												SELF := LEFT));
																												
OUTPUT(CHOOSEN(yesterdaysLogs, eyeball), NAMED('Sample_Yesterday_Logs'));

Parsed_Layout := RECORD
	STRING30	TransactionID	:= ''; // Forced into the record so I can join it all together
	STRING30	FirstName			:= '';
	STRING30	LastName			:= '';
	STRING9		SSN						:= '';
	STRING8		DOB						:= '';
	STRING120	Address				:= '';
	STRING25	City					:= '';
	STRING2		State					:= '';
	STRING9		Zip						:= '';
	STRING20	DL						:= '';
	STRING10	HomePhone			:= '';
	STRING10	WorkPhone			:= '';
	STRING15	Model					:= '';
	STRING3		Score					:= '';
	
	STRING5		RC1						:= '';
	STRING5		RC2						:= '';
	STRING5		RC3						:= '';
	STRING5		RC4						:= '';
	STRING5		RC5						:= '';
	STRING5		RC6						:= '';
	STRING5		RC7						:= '';
	STRING5		RC8						:= '';
	STRING5		RC9						:= '';
	STRING5		RC10					:= '';
END;

Parsed_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.SSN						:= TRIM(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + TRIM(XMLTEXT('SearchBy/DOB/Year')) + TRIM(XMLTEXT('SearchBy/DOB/Month')) + TRIM(XMLTEXT('SearchBy/DOB/Day')); // Catch if it is full or parsed into year month day
	SELF.Address				:= TRIM(XMLTEXT('SearchBy/Address/StreetNumber')) + TRIM(XMLTEXT('SearchBy/Address/StreetAddress1')); // Catch if it is full or parsed
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= TRIM(XMLTEXT('SearchBy/Address/Zip5')) + TRIM(XMLTEXT('SearchBy/Address/Zip4'));
	SELF.DL							:= TRIM(XMLTEXT('SearchBy/DriverLicenseNumber'));
	SELF.HomePhone			:= TRIM(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= TRIM(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput := PARSE(yesterdaysLogs, inputxml, parseInput(), XML('RiskView'));

OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));
Parsed_Layout_Temp := RECORD
	Parsed_Layout;
	
	STRING3 Score1 := '';
	STRING3 Score2 := '';
	STRING3 Score3 := '';
	STRING3 Score4 := '';
	STRING3 Score5 := '';
	STRING3 Score6 := '';
	STRING3 Score7 := '';
	STRING3 Score8 := '';
	STRING3 Score9 := '';
	STRING3 Score10 := '';
	
	STRING15 Model1 := '';
	STRING15 Model2 := '';
	STRING15 Model3 := '';
	STRING15 Model4 := '';
	STRING15 Model5 := '';
	STRING15 Model6 := '';
	STRING15 Model7 := '';
	STRING15 Model8 := '';
	STRING15 Model9 := '';
	STRING15 Model10 := '';
	
	STRING5 RC1_1		:= '';
	STRING5 RC1_2		:= '';
	STRING5 RC1_3		:= '';
	STRING5 RC1_4		:= '';
	STRING5 RC1_5		:= '';
	STRING5 RC1_6		:= '';
	STRING5 RC1_7		:= '';
	STRING5 RC1_8		:= '';
	STRING5 RC1_9		:= '';
	STRING5 RC1_10	:= '';
	STRING5 RC2_1		:= '';
	STRING5 RC2_2		:= '';
	STRING5 RC2_3		:= '';
	STRING5 RC2_4		:= '';
	STRING5 RC2_5		:= '';
	STRING5 RC2_6		:= '';
	STRING5 RC2_7		:= '';
	STRING5 RC2_8		:= '';
	STRING5 RC2_9		:= '';
	STRING5 RC2_10	:= '';
	STRING5 RC3_1		:= '';
	STRING5 RC3_2		:= '';
	STRING5 RC3_3		:= '';
	STRING5 RC3_4		:= '';
	STRING5 RC3_5		:= '';
	STRING5 RC3_6		:= '';
	STRING5 RC3_7		:= '';
	STRING5 RC3_8		:= '';
	STRING5 RC3_9		:= '';
	STRING5 RC3_10	:= '';
	STRING5 RC4_1		:= '';
	STRING5 RC4_2		:= '';
	STRING5 RC4_3		:= '';
	STRING5 RC4_4		:= '';
	STRING5 RC4_5		:= '';
	STRING5 RC4_6		:= '';
	STRING5 RC4_7		:= '';
	STRING5 RC4_8		:= '';
	STRING5 RC4_9		:= '';
	STRING5 RC4_10	:= '';
	STRING5 RC5_1		:= '';
	STRING5 RC5_2		:= '';
	STRING5 RC5_3		:= '';
	STRING5 RC5_4		:= '';
	STRING5 RC5_5		:= '';
	STRING5 RC5_6		:= '';
	STRING5 RC5_7		:= '';
	STRING5 RC5_8		:= '';
	STRING5 RC5_9		:= '';
	STRING5 RC5_10	:= '';
	STRING5 RC6_1		:= '';
	STRING5 RC6_2		:= '';
	STRING5 RC6_3		:= '';
	STRING5 RC6_4		:= '';
	STRING5 RC6_5		:= '';
	STRING5 RC6_6		:= '';
	STRING5 RC6_7		:= '';
	STRING5 RC6_8		:= '';
	STRING5 RC6_9		:= '';
	STRING5 RC6_10	:= '';
	STRING5 RC7_1		:= '';
	STRING5 RC7_2		:= '';
	STRING5 RC7_3		:= '';
	STRING5 RC7_4		:= '';
	STRING5 RC7_5		:= '';
	STRING5 RC7_6		:= '';
	STRING5 RC7_7		:= '';
	STRING5 RC7_8		:= '';
	STRING5 RC7_9		:= '';
	STRING5 RC7_10	:= '';
	STRING5 RC8_1		:= '';
	STRING5 RC8_2		:= '';
	STRING5 RC8_3		:= '';
	STRING5 RC8_4		:= '';
	STRING5 RC8_5		:= '';
	STRING5 RC8_6		:= '';
	STRING5 RC8_7		:= '';
	STRING5 RC8_8		:= '';
	STRING5 RC8_9		:= '';
	STRING5 RC8_10	:= '';
	STRING5 RC9_1		:= '';
	STRING5 RC9_2		:= '';
	STRING5 RC9_3		:= '';
	STRING5 RC9_4		:= '';
	STRING5 RC9_5		:= '';
	STRING5 RC9_6		:= '';
	STRING5 RC9_7		:= '';
	STRING5 RC9_8		:= '';
	STRING5 RC9_9		:= '';
	STRING5 RC9_10	:= '';
	STRING5 RC10_1	:= '';
	STRING5 RC10_2	:= '';
	STRING5 RC10_3	:= '';
	STRING5 RC10_4	:= '';
	STRING5 RC10_5	:= '';
	STRING5 RC10_6	:= '';
	STRING5 RC10_7	:= '';
	STRING5 RC10_8	:= '';
	STRING5 RC10_9	:= '';
	STRING5 RC10_10	:= '';
END;

Parsed_Layout_Temp parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	SELF.Score1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Value'));
	SELF.Score2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Value'));
	SELF.Score3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Value'));
	SELF.Score4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Value'));
	SELF.Score5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Value'));
	SELF.Score6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Value'));
	SELF.Score7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/Value'));
	SELF.Score8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/Value'));
	SELF.Score9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/Value'));
	SELF.Score10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/Value'));
	
	SELF.Model1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/Type'));
	SELF.Model2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/Type'));
	SELF.Model3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/Type'));
	SELF.Model4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/Type'));
	SELF.Model5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/Type'));
	SELF.Model6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/Type'));
	SELF.Model7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/Type'));
	SELF.Model8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/Type'));
	SELF.Model9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/Type'));
	SELF.Model10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/Type'));
	
	SELF.RC1_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC1_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC1_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC1_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC1_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC1_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC1_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC1_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC1_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC1_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[1]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC2_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC2_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC2_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC2_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC2_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC2_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC2_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC2_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC2_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC2_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[2]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC3_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC3_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC3_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC3_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC3_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC3_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC3_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC3_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC3_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC3_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[3]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC4_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC4_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC4_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC4_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC4_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC4_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC4_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC4_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC4_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC4_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[4]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC5_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC5_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC5_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC5_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC5_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC5_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC5_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC5_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC5_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC5_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[5]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC6_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC6_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC6_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC6_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC6_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC6_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC6_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC6_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC6_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC6_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[6]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC7_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC7_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC7_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC7_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC7_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC7_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC7_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC7_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC7_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC7_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[7]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC8_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC8_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC8_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC8_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC8_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC8_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC8_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC8_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC8_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC8_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[8]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC9_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC9_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC9_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC9_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC9_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC9_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC9_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC9_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC9_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC9_10					:= TRIM(XMLTEXT('Result/Models[1]/Model[9]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF.RC10_1					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[1]/RiskCode'));
	SELF.RC10_2					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[2]/RiskCode'));
	SELF.RC10_3					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[3]/RiskCode'));
	SELF.RC10_4					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[4]/RiskCode'));
	SELF.RC10_5					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[5]/RiskCode'));
	SELF.RC10_6					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[6]/RiskCode'));
	SELF.RC10_7					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[7]/RiskCode'));
	SELF.RC10_8					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[8]/RiskCode'));
	SELF.RC10_9					:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[9]/RiskCode'));
	SELF.RC10_10				:= TRIM(XMLTEXT('Result/Models[1]/Model[10]/Scores[1]/Score[1]/HighRiskIndicators[1]/HighRiskIndicator[10]/RiskCode'));
	
	SELF := [];
END;
parsedOutputTemp := PARSE(yesterdaysLogs, outputxml, parseOutput(), XML('RiskView'));

OUTPUT(CHOOSEN(parsedOutputTemp, eyeball), NAMED('Sample_Parsed_Output'));

Parsed_Layout normScores(Parsed_Layout_Temp le, UNSIGNED1 t) := TRANSFORM
	SELF.Score := CASE(t,
		1 => le.Score1,
		2 => le.Score2,
		3 => le.Score3,
		4 => le.Score4,
		5 => le.Score5,
		6 => le.Score6,
		7 => le.Score7,
		8 => le.Score8,
		9 => le.Score9,
		10 => le.Score10,
		'');
	SELF.Model := CASE(t,
		1 => le.Model1,
		2 => le.Model2,
		3 => le.Model3,
		4 => le.Model4,
		5 => le.Model5,
		6 => le.Model6,
		7 => le.Model7,
		8 => le.Model8,
		9 => le.Model9,
		10 => le.Model10,
		'');
		
	SELF.RC1 := CASE(t,
		1		=> le.RC1_1,
		2		=> le.RC2_1,
		3		=> le.RC3_1,
		4		=> le.RC4_1,
		5		=> le.RC5_1,
		6		=> le.RC6_1,
		7		=> le.RC7_1,
		8		=> le.RC8_1,
		9		=> le.RC9_1,
		10	=> le.RC10_1,
		'');

	SELF.RC2 := CASE(t,
		1		=> le.RC1_2,
		2		=> le.RC2_2,
		3		=> le.RC3_2,
		4		=> le.RC4_2,
		5		=> le.RC5_2,
		6		=> le.RC6_2,
		7		=> le.RC7_2,
		8		=> le.RC8_2,
		9		=> le.RC9_2,
		10	=> le.RC10_2,
		'');
	
	SELF.RC3 := CASE(t,
		1		=> le.RC1_3,
		2		=> le.RC2_3,
		3		=> le.RC3_3,
		4		=> le.RC4_3,
		5		=> le.RC5_3,
		6		=> le.RC6_3,
		7		=> le.RC7_3,
		8		=> le.RC8_3,
		9		=> le.RC9_3,
		10	=> le.RC10_3,
		'');
		
	SELF.RC4 := CASE(t,
		1		=> le.RC1_4,
		2		=> le.RC2_4,
		3		=> le.RC3_4,
		4		=> le.RC4_4,
		5		=> le.RC5_4,
		6		=> le.RC6_4,
		7		=> le.RC7_4,
		8		=> le.RC8_4,
		9		=> le.RC9_4,
		10	=> le.RC10_4,
		'');
		
	SELF.RC5 := CASE(t,
		1		=> le.RC1_5,
		2		=> le.RC2_5,
		3		=> le.RC3_5,
		4		=> le.RC4_5,
		5		=> le.RC5_5,
		6		=> le.RC6_5,
		7		=> le.RC7_5,
		8		=> le.RC8_5,
		9		=> le.RC9_5,
		10	=> le.RC10_5,
		'');
		
	SELF.RC6 := CASE(t,
		1		=> le.RC1_6,
		2		=> le.RC2_6,
		3		=> le.RC3_6,
		4		=> le.RC4_6,
		5		=> le.RC5_6,
		6		=> le.RC6_6,
		7		=> le.RC7_6,
		8		=> le.RC8_6,
		9		=> le.RC9_6,
		10	=> le.RC10_6,
		'');
		
	SELF.RC7 := CASE(t,
		1		=> le.RC1_7,
		2		=> le.RC2_7,
		3		=> le.RC3_7,
		4		=> le.RC4_7,
		5		=> le.RC5_7,
		6		=> le.RC6_7,
		7		=> le.RC7_7,
		8		=> le.RC8_7,
		9		=> le.RC9_7,
		10	=> le.RC10_7,
		'');
		
	SELF.RC8 := CASE(t,
		1		=> le.RC1_8,
		2		=> le.RC2_8,
		3		=> le.RC3_8,
		4		=> le.RC4_8,
		5		=> le.RC5_8,
		6		=> le.RC6_8,
		7		=> le.RC7_8,
		8		=> le.RC8_8,
		9		=> le.RC9_8,
		10	=> le.RC10_8,
		'');
		
	SELF.RC9 := CASE(t,
		1		=> le.RC1_9,
		2		=> le.RC2_9,
		3		=> le.RC3_9,
		4		=> le.RC4_9,
		5		=> le.RC5_9,
		6		=> le.RC6_9,
		7		=> le.RC7_9,
		8		=> le.RC8_9,
		9		=> le.RC9_9,
		10	=> le.RC10_9,
		'');
		
	SELF.RC10 := CASE(t,
		1		=> le.RC1_10,
		2		=> le.RC2_10,
		3		=> le.RC3_10,
		4		=> le.RC4_10,
		5		=> le.RC5_10,
		6		=> le.RC6_10,
		7		=> le.RC7_10,
		8		=> le.RC8_10,
		9		=> le.RC9_10,
		10	=> le.RC10_10,
		'');
		
	SELF := le;
END;
parsedOutput:= NORMALIZE(parsedOutputTemp, 10, normScores(LEFT, COUNTER));

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Normalized_Output'));

Parsed_Layout combineParsedRecords(Parsed_Layout le, Parsed_Layout ri) := TRANSFORM
	SELF.Score	:= ri.Score;
	SELF.Model	:= ri.Model;
	SELF.RC1		:= ri.RC1;
	SELF.RC2		:= ri.RC2;
	SELF.RC3		:= ri.RC3;
	SELF.RC4		:= ri.RC4;
	SELF.RC5		:= ri.RC5;
	SELF.RC6		:= ri.RC6;
	SELF.RC7		:= ri.RC7;
	SELF.RC8		:= ri.RC8;
	SELF.RC9		:= ri.RC9;
	SELF.RC10		:= ri.RC10;
	
	SELF := le;
END;

// Join the parsed input/output and then filter out the results where no model was requested or where this was an income estimated model and not a true RiskView model
parsedRecords := JOIN(parsedInput, parsedOutput, LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(10), ATMOST(RiskWise.max_atmost)) (TRIM(StringLib.StringToUpperCase(model)[1..6]) NOT IN ['', 'INCOME']);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));

Monitor_Layout := RECORD
	STRING8			Date_Of_Report													:= ''; // This is the date of the records we are running calculations on
	STRING8			Date_Report_Was_Run											:= ''; // This is the date the report was run.  We always have to run the report on the previous day
	UNSIGNED8		Total_Number_Of_Transactions						:= 0;
	UNSIGNED8		Total_Number_Of_Model_Scores						:= 0;
	UNSIGNED8		Number_Of_Unique_Account_IDs_Transacted	:= 0;
	
	// Input Population
	DECIMAL6_3	Percent_First_Name_Populated						:= 0.0;
	DECIMAL6_3	Percent_Last_Name_Populated							:= 0.0;
	DECIMAL6_3	Percent_SSN_Populated										:= 0.0;
	DECIMAL6_3	Percent_DOB_Populated										:= 0.0;
	DECIMAL6_3	Percent_Address_Populated								:= 0.0;
	DECIMAL6_3	Percent_City_Populated									:= 0.0;
	DECIMAL6_3	Percent_State_Populated									:= 0.0;
	DECIMAL6_3	Percent_Zip_Populated										:= 0.0;
	DECIMAL6_3	Percent_DL_Populated										:= 0.0;
	DECIMAL6_3	Percent_Home_Phone_Populated						:= 0.0;
	
	// Score Buckets
	DECIMAL6_3	Percent_Scored_100											:= 0.0;
	DECIMAL6_3	Percent_Scored_101											:= 0.0;
	DECIMAL6_3	Percent_Scored_102											:= 0.0;
	DECIMAL6_3	Percent_Scored_103											:= 0.0;
	DECIMAL6_3	Percent_Scored_104											:= 0.0;
	DECIMAL6_3	Percent_Scored_200											:= 0.0;
	DECIMAL6_3	Percent_Scored_222											:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_501_540					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_541_580					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_581_620					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_621_660					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_661_700					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_701_740					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_741_780					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_781_820					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_821_860					:= 0.0;
	DECIMAL6_3	Percent_Scored_Between_861_900					:= 0.0;
	DECIMAL6_3	Percent_Scored_Above_900								:= 0.0;
	DECIMAL6_3	Percent_Scored_Below_100								:= 0.0;
	
	UNSIGNED2		Average_Score_Excluding_Exceptions			:= 0;
	
	// Reason Code Population
	DECIMAL6_3	Percent_RC_01														:=	0.0;
	DECIMAL6_3	Percent_RC_02														:=	0.0;
	DECIMAL6_3	Percent_RC_03														:=	0.0;
	DECIMAL6_3	Percent_RC_04														:=	0.0;
	DECIMAL6_3	Percent_RC_05														:=	0.0;
	DECIMAL6_3	Percent_RC_06														:=	0.0;
	DECIMAL6_3	Percent_RC_07														:=	0.0;
	DECIMAL6_3	Percent_RC_08														:=	0.0;
	DECIMAL6_3	Percent_RC_09														:=	0.0;
	DECIMAL6_3	Percent_RC_10														:=	0.0;
	DECIMAL6_3	Percent_RC_11														:=	0.0;
	DECIMAL6_3	Percent_RC_12														:=	0.0;
	DECIMAL6_3	Percent_RC_13														:=	0.0;
	DECIMAL6_3	Percent_RC_14														:=	0.0;
	DECIMAL6_3	Percent_RC_15														:=	0.0;
	DECIMAL6_3	Percent_RC_16														:=	0.0;
	DECIMAL6_3	Percent_RC_17														:=	0.0;
	DECIMAL6_3	Percent_RC_19														:=	0.0;
	DECIMAL6_3	Percent_RC_20														:=	0.0;
	DECIMAL6_3	Percent_RC_21														:=	0.0;
	DECIMAL6_3	Percent_RC_22														:=	0.0;
	DECIMAL6_3	Percent_RC_23														:=	0.0;
	DECIMAL6_3	Percent_RC_24														:=	0.0;
	DECIMAL6_3	Percent_RC_25														:=	0.0;
	DECIMAL6_3	Percent_RC_26														:=	0.0;
	DECIMAL6_3	Percent_RC_27														:=	0.0;
	DECIMAL6_3	Percent_RC_28														:=	0.0;
	DECIMAL6_3	Percent_RC_29														:=	0.0;
	DECIMAL6_3	Percent_RC_30														:=	0.0;
	DECIMAL6_3	Percent_RC_31														:=	0.0;
	DECIMAL6_3	Percent_RC_32														:=	0.0;
	DECIMAL6_3	Percent_RC_33														:=	0.0;
	DECIMAL6_3	Percent_RC_34														:=	0.0;
	DECIMAL6_3	Percent_RC_35														:=	0.0;
	DECIMAL6_3	Percent_RC_36														:=	0.0;
	DECIMAL6_3	Percent_RC_37														:=	0.0;
	DECIMAL6_3	Percent_RC_38														:=	0.0;
	DECIMAL6_3	Percent_RC_39														:=	0.0;
	DECIMAL6_3	Percent_RC_40														:=	0.0;
	DECIMAL6_3	Percent_RC_41														:=	0.0;
	DECIMAL6_3	Percent_RC_42														:=	0.0;
	DECIMAL6_3	Percent_RC_43														:=	0.0;
	DECIMAL6_3	Percent_RC_44														:=	0.0;
	DECIMAL6_3	Percent_RC_45														:=	0.0;
	DECIMAL6_3	Percent_RC_46														:=	0.0;
	DECIMAL6_3	Percent_RC_47														:=	0.0;
	DECIMAL6_3	Percent_RC_48														:=	0.0;
	DECIMAL6_3	Percent_RC_49														:=	0.0;
	DECIMAL6_3	Percent_RC_50														:=	0.0;
	DECIMAL6_3	Percent_RC_51														:=	0.0;
	DECIMAL6_3	Percent_RC_52														:=	0.0;
	DECIMAL6_3	Percent_RC_53														:=	0.0;
	DECIMAL6_3	Percent_RC_54														:=	0.0;
	DECIMAL6_3	Percent_RC_55														:=	0.0;
	DECIMAL6_3	Percent_RC_56														:=	0.0;
	DECIMAL6_3	Percent_RC_57														:=	0.0;
	DECIMAL6_3	Percent_RC_58														:=	0.0;
	DECIMAL6_3	Percent_RC_59														:=	0.0;
	DECIMAL6_3	Percent_RC_5Q														:=	0.0;
	DECIMAL6_3	Percent_RC_60														:=	0.0;
	DECIMAL6_3	Percent_RC_61														:=	0.0;
	DECIMAL6_3	Percent_RC_62														:=	0.0;
	DECIMAL6_3	Percent_RC_63														:=	0.0;
	DECIMAL6_3	Percent_RC_64														:=	0.0;
	DECIMAL6_3	Percent_RC_65														:=	0.0;
	DECIMAL6_3	Percent_RC_66														:=	0.0;
	DECIMAL6_3	Percent_RC_67														:=	0.0;
	DECIMAL6_3	Percent_RC_68														:=	0.0;
	DECIMAL6_3	Percent_RC_69														:=	0.0;
	DECIMAL6_3	Percent_RC_70														:=	0.0;
	DECIMAL6_3	Percent_RC_71														:=	0.0;
	DECIMAL6_3	Percent_RC_72														:=	0.0;
	DECIMAL6_3	Percent_RC_73														:=	0.0;
	DECIMAL6_3	Percent_RC_74														:=	0.0;
	DECIMAL6_3	Percent_RC_75														:=	0.0;
	DECIMAL6_3	Percent_RC_76														:=	0.0;
	DECIMAL6_3	Percent_RC_77														:=	0.0;
	DECIMAL6_3	Percent_RC_78														:=	0.0;
	DECIMAL6_3	Percent_RC_79														:=	0.0;
	DECIMAL6_3	Percent_RC_80														:=	0.0;
	DECIMAL6_3	Percent_RC_81														:=	0.0;
	DECIMAL6_3	Percent_RC_82														:=	0.0;
	DECIMAL6_3	Percent_RC_83														:=	0.0;
	DECIMAL6_3	Percent_RC_84														:=	0.0;
	DECIMAL6_3	Percent_RC_85														:=	0.0;
	DECIMAL6_3	Percent_RC_86														:=	0.0;
	DECIMAL6_3	Percent_RC_87														:=	0.0;
	DECIMAL6_3	Percent_RC_88														:=	0.0;
	DECIMAL6_3	Percent_RC_89														:=	0.0;
	DECIMAL6_3	Percent_RC_90														:=	0.0;
	DECIMAL6_3	Percent_RC_91														:=	0.0;
	DECIMAL6_3	Percent_RC_92														:=	0.0;
	DECIMAL6_3	Percent_RC_93														:=	0.0;
	DECIMAL6_3	Percent_RC_94														:=	0.0;
	DECIMAL6_3	Percent_RC_95														:=	0.0;
	DECIMAL6_3	Percent_RC_96														:=	0.0;
	DECIMAL6_3	Percent_RC_97														:=	0.0;
	DECIMAL6_3	Percent_RC_98														:=	0.0;
	DECIMAL6_3	Percent_RC_99														:=	0.0;
	DECIMAL6_3	Percent_RC_9A														:=	0.0;
	DECIMAL6_3	Percent_RC_9B														:=	0.0;
	DECIMAL6_3	Percent_RC_9C														:=	0.0;
	DECIMAL6_3	Percent_RC_9D														:=	0.0;
	DECIMAL6_3	Percent_RC_9E														:=	0.0;
	DECIMAL6_3	Percent_RC_9F														:=	0.0;
	DECIMAL6_3	Percent_RC_9G														:=	0.0;
	DECIMAL6_3	Percent_RC_9H														:=	0.0;
	DECIMAL6_3	Percent_RC_9I														:=	0.0;
	DECIMAL6_3	Percent_RC_9J														:=	0.0;
	DECIMAL6_3	Percent_RC_9K														:=	0.0;
	DECIMAL6_3	Percent_RC_9L														:=	0.0;
	DECIMAL6_3	Percent_RC_9M														:=	0.0;
	DECIMAL6_3	Percent_RC_9N														:=	0.0;
	DECIMAL6_3	Percent_RC_9O														:=	0.0;
	DECIMAL6_3	Percent_RC_9P														:=	0.0;
	DECIMAL6_3	Percent_RC_9Q														:=	0.0;
	DECIMAL6_3	Percent_RC_9R														:=	0.0;
	DECIMAL6_3	Percent_RC_9S														:=	0.0;
	DECIMAL6_3	Percent_RC_9T														:=	0.0;
	DECIMAL6_3	Percent_RC_9U														:=	0.0;
	DECIMAL6_3	Percent_RC_9V														:=	0.0;
	DECIMAL6_3	Percent_RC_9W														:=	0.0;
	DECIMAL6_3	Percent_RC_9X														:=	0.0;
	DECIMAL6_3	Percent_RC_A0														:=	0.0;
	DECIMAL6_3	Percent_RC_A1														:=	0.0;
	DECIMAL6_3	Percent_RC_A2														:=	0.0;
	DECIMAL6_3	Percent_RC_A3														:=	0.0;
	DECIMAL6_3	Percent_RC_A4														:=	0.0;
	DECIMAL6_3	Percent_RC_A5														:=	0.0;
	DECIMAL6_3	Percent_RC_A6														:=	0.0;
	DECIMAL6_3	Percent_RC_A7														:=	0.0;
	DECIMAL6_3	Percent_RC_A8														:=	0.0;
	DECIMAL6_3	Percent_RC_A9														:=	0.0;
	DECIMAL6_3	Percent_RC_B0														:=	0.0;
	DECIMAL6_3	Percent_RC_BO														:=	0.0;
	DECIMAL6_3	Percent_RC_CL														:=	0.0;
	DECIMAL6_3	Percent_RC_CO														:=	0.0;
	DECIMAL6_3	Percent_RC_CR														:=	0.0;
	DECIMAL6_3	Percent_RC_CZ														:=	0.0;
	DECIMAL6_3	Percent_RC_DD														:=	0.0;
	DECIMAL6_3	Percent_RC_DF														:=	0.0;
	DECIMAL6_3	Percent_RC_DM														:=	0.0;
	DECIMAL6_3	Percent_RC_DV														:=	0.0;
	DECIMAL6_3	Percent_RC_EV														:=	0.0;
	DECIMAL6_3	Percent_RC_FB														:=	0.0;
	DECIMAL6_3	Percent_RC_FM														:=	0.0;
	DECIMAL6_3	Percent_RC_FQ														:=	0.0;
	DECIMAL6_3	Percent_RC_FR														:=	0.0;
	DECIMAL6_3	Percent_RC_FV														:=	0.0;
	DECIMAL6_3	Percent_RC_IA														:=	0.0;
	DECIMAL6_3	Percent_RC_IB														:=	0.0;
	DECIMAL6_3	Percent_RC_IC														:=	0.0;
	DECIMAL6_3	Percent_RC_ID														:=	0.0;
	DECIMAL6_3	Percent_RC_IE														:=	0.0;
	DECIMAL6_3	Percent_RC_IF														:=	0.0;
	DECIMAL6_3	Percent_RC_IG														:=	0.0;
	DECIMAL6_3	Percent_RC_IH														:=	0.0;
	DECIMAL6_3	Percent_RC_II														:=	0.0;
	DECIMAL6_3	Percent_RC_IJ														:=	0.0;
	DECIMAL6_3	Percent_RC_IK														:=	0.0;
	DECIMAL6_3	Percent_RC_IS														:=	0.0;
	DECIMAL6_3	Percent_RC_IT														:=	0.0;
	DECIMAL6_3	Percent_RC_MI														:=	0.0;
	DECIMAL6_3	Percent_RC_MN														:=	0.0;
	DECIMAL6_3	Percent_RC_MO														:=	0.0;
	DECIMAL6_3	Percent_RC_MS														:=	0.0;
	DECIMAL6_3	Percent_RC_PA														:=	0.0;
	DECIMAL6_3	Percent_RC_PO														:=	0.0;
	DECIMAL6_3	Percent_RC_PV														:=	0.0;
	DECIMAL6_3	Percent_RC_RS														:=	0.0;
	DECIMAL6_3	Percent_RC_SR														:=	0.0;
	DECIMAL6_3	Percent_RC_U1														:=	0.0;
	DECIMAL6_3	Percent_RC_U2														:=	0.0;
	DECIMAL6_3	Percent_RC_WL														:=	0.0;
	DECIMAL6_3	Percent_RC_ZI														:=	0.0;
END;

totalTransactions := COUNT(DEDUP(SORT(yesterdaysLogs, transaction_id), transaction_id));
totalModelScores := COUNT(parsedRecords);
uniqueIDs := COUNT(DEDUP(SORT(yesterdaysLogs, customer_id), customer_id));
firstNamePopulated := COUNT(parsedRecords (FirstName != ''));
lastNamePopulated := COUNT(parsedRecords (LastName != ''));
ssnPopulated := COUNT(parsedRecords (SSN != ''));
dobPopulated := COUNT(parsedRecords (DOB != ''));
addressPopulated := COUNT(parsedRecords (Address != ''));
cityPopulated := COUNT(parsedRecords (City != ''));
statePopulated := COUNT(parsedRecords (State != ''));
zipPopulated := COUNT(parsedRecords (Zip != ''));
dlPopulated := COUNT(parsedRecords (DL != ''));
homePhonePopulated := COUNT(parsedRecords (HomePhone != ''));

scored100 := COUNT(parsedRecords (Score = '100'));
scored101 := COUNT(parsedRecords (Score = '101'));
scored102 := COUNT(parsedRecords (Score = '102'));
scored103 := COUNT(parsedRecords (Score = '103'));
scored104 := COUNT(parsedRecords (Score = '104'));
scored200 := COUNT(parsedRecords (Score = '200'));
scored222 := COUNT(parsedRecords (Score = '222'));
scored501_540 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 501 AND 540));
scored541_580 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 541 AND 580));
scored581_620 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 581 AND 620));
scored621_660 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 621 AND 660));
scored661_700 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 661 AND 700));
scored701_740 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 701 AND 740));
scored741_780 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 741 AND 780));
scored781_820 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 781 AND 820));
scored821_860 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 821 AND 860));
scored861_900 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 861 AND 900));
scoredAbove900 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 901 AND 1000));
scoredBelow100 := COUNT(parsedRecords ((UNSIGNED2)Score BETWEEN 0 AND 99));
averageScoreRecs := parsedRecords ((UNSIGNED2)Score BETWEEN 223 AND 900);
averageScore := ROUND(SUM(averageScoreRecs, (UNSIGNED2)Score) / COUNT(averageScoreRecs));

filterReasonCode (rc) := MACRO
 parsedRecords (TRIM(RC1) = TRIM(rc) OR TRIM(RC2) = TRIM(rc) OR TRIM(RC3) = TRIM(rc) OR TRIM(RC4) = TRIM(rc) OR TRIM(RC5) = TRIM(rc) OR TRIM(RC6) = TRIM(rc) OR TRIM(RC7) = TRIM(rc) OR TRIM(RC8) = TRIM(rc) OR TRIM(RC9) = TRIM(rc) OR TRIM(RC10) = TRIM(rc))
ENDMACRO;

PRC01 := COUNT(filterReasonCode('01')); 
PRC02 := COUNT(filterReasonCode('02')); 
PRC03 := COUNT(filterReasonCode('03')); 
PRC04 := COUNT(filterReasonCode('04')); 
PRC05 := COUNT(filterReasonCode('05')); 
PRC06 := COUNT(filterReasonCode('06')); 
PRC07 := COUNT(filterReasonCode('07')); 
PRC08 := COUNT(filterReasonCode('08')); 
PRC09 := COUNT(filterReasonCode('09')); 
PRC10 := COUNT(filterReasonCode('10')); 
PRC11 := COUNT(filterReasonCode('11')); 
PRC12 := COUNT(filterReasonCode('12')); 
PRC13 := COUNT(filterReasonCode('13')); 
PRC14 := COUNT(filterReasonCode('14')); 
PRC15 := COUNT(filterReasonCode('15')); 
PRC16 := COUNT(filterReasonCode('16')); 
PRC17 := COUNT(filterReasonCode('17')); 
PRC19 := COUNT(filterReasonCode('19')); 
PRC20 := COUNT(filterReasonCode('20')); 
PRC21 := COUNT(filterReasonCode('21')); 
PRC22 := COUNT(filterReasonCode('22')); 
PRC23 := COUNT(filterReasonCode('23')); 
PRC24 := COUNT(filterReasonCode('24')); 
PRC25 := COUNT(filterReasonCode('25')); 
PRC26 := COUNT(filterReasonCode('26')); 
PRC27 := COUNT(filterReasonCode('27')); 
PRC28 := COUNT(filterReasonCode('28'));
PRC29 := COUNT(filterReasonCode('29')); 
PRC30 := COUNT(filterReasonCode('30')); 
PRC31 := COUNT(filterReasonCode('31')); 
PRC32 := COUNT(filterReasonCode('32')); 
PRC33 := COUNT(filterReasonCode('33')); 
PRC34 := COUNT(filterReasonCode('34')); 
PRC35 := COUNT(filterReasonCode('35')); 
PRC36 := COUNT(filterReasonCode('36')); 
PRC37 := COUNT(filterReasonCode('37')); 
PRC38 := COUNT(filterReasonCode('38')); 
PRC39 := COUNT(filterReasonCode('39')); 
PRC40 := COUNT(filterReasonCode('40')); 
PRC41 := COUNT(filterReasonCode('41')); 
PRC42 := COUNT(filterReasonCode('42')); 
PRC43 := COUNT(filterReasonCode('43')); 
PRC44 := COUNT(filterReasonCode('44')); 
PRC45 := COUNT(filterReasonCode('45')); 
PRC46 := COUNT(filterReasonCode('46')); 
PRC47 := COUNT(filterReasonCode('47')); 
PRC48 := COUNT(filterReasonCode('48')); 
PRC49 := COUNT(filterReasonCode('49')); 
PRC50 := COUNT(filterReasonCode('50')); 
PRC51 := COUNT(filterReasonCode('51')); 
PRC52 := COUNT(filterReasonCode('52')); 
PRC53 := COUNT(filterReasonCode('53')); 
PRC54 := COUNT(filterReasonCode('54')); 
PRC55 := COUNT(filterReasonCode('55')); 
PRC56 := COUNT(filterReasonCode('56')); 
PRC57 := COUNT(filterReasonCode('57')); 
PRC58 := COUNT(filterReasonCode('58')); 
PRC59 := COUNT(filterReasonCode('59')); 
PRC5Q := COUNT(filterReasonCode('5Q')); 
PRC60 := COUNT(filterReasonCode('60')); 
PRC61 := COUNT(filterReasonCode('61')); 
PRC62 := COUNT(filterReasonCode('62')); 
PRC63 := COUNT(filterReasonCode('63'));
PRC64 := COUNT(filterReasonCode('64')); 
PRC65 := COUNT(filterReasonCode('65')); 
PRC66 := COUNT(filterReasonCode('66')); 
PRC67 := COUNT(filterReasonCode('67')); 
PRC68 := COUNT(filterReasonCode('68')); 
PRC69 := COUNT(filterReasonCode('69')); 
PRC70 := COUNT(filterReasonCode('70')); 
PRC71 := COUNT(filterReasonCode('71')); 
PRC72 := COUNT(filterReasonCode('72')); 
PRC73 := COUNT(filterReasonCode('73')); 
PRC74 := COUNT(filterReasonCode('74')); 
PRC75 := COUNT(filterReasonCode('75')); 
PRC76 := COUNT(filterReasonCode('76')); 
PRC77 := COUNT(filterReasonCode('77')); 
PRC78 := COUNT(filterReasonCode('78')); 
PRC79 := COUNT(filterReasonCode('79')); 
PRC80 := COUNT(filterReasonCode('80')); 
PRC81 := COUNT(filterReasonCode('81')); 
PRC82 := COUNT(filterReasonCode('82')); 
PRC83 := COUNT(filterReasonCode('83')); 
PRC84 := COUNT(filterReasonCode('84')); 
PRC85 := COUNT(filterReasonCode('85')); 
PRC86 := COUNT(filterReasonCode('86')); 
PRC87 := COUNT(filterReasonCode('87')); 
PRC88 := COUNT(filterReasonCode('88')); 
PRC89 := COUNT(filterReasonCode('89'));
PRC90 := COUNT(filterReasonCode('90')); 
PRC91 := COUNT(filterReasonCode('91')); 
PRC92 := COUNT(filterReasonCode('92')); 
PRC93 := COUNT(filterReasonCode('93')); 
PRC94 := COUNT(filterReasonCode('94')); 
PRC95 := COUNT(filterReasonCode('95')); 
PRC96 := COUNT(filterReasonCode('96')); 
PRC97 := COUNT(filterReasonCode('97')); 
PRC98 := COUNT(filterReasonCode('98')); 
PRC99 := COUNT(filterReasonCode('99')); 
PRC9A := COUNT(filterReasonCode('9A')); 
PRC9B := COUNT(filterReasonCode('9B')); 
PRC9C := COUNT(filterReasonCode('9C')); 
PRC9D := COUNT(filterReasonCode('9D')); 
PRC9E := COUNT(filterReasonCode('9E')); 
PRC9F := COUNT(filterReasonCode('9F')); 
PRC9G := COUNT(filterReasonCode('9G')); 
PRC9H := COUNT(filterReasonCode('9H')); 
PRC9I := COUNT(filterReasonCode('9I')); 
PRC9J := COUNT(filterReasonCode('9J')); 
PRC9K := COUNT(filterReasonCode('9K')); 
PRC9L := COUNT(filterReasonCode('9L')); 
PRC9M := COUNT(filterReasonCode('9M')); 
PRC9N := COUNT(filterReasonCode('9N')); 
PRC9O := COUNT(filterReasonCode('9O')); 
PRC9P := COUNT(filterReasonCode('9P')); 
PRC9Q := COUNT(filterReasonCode('9Q')); 
PRC9R := COUNT(filterReasonCode('9R')); 
PRC9S := COUNT(filterReasonCode('9S')); 
PRC9T := COUNT(filterReasonCode('9T')); 
PRC9U := COUNT(filterReasonCode('9U')); 
PRC9V := COUNT(filterReasonCode('9V')); 
PRC9W := COUNT(filterReasonCode('9W')); 
PRC9X := COUNT(filterReasonCode('9X')); 
PRCA0 := COUNT(filterReasonCode('A0')); 
PRCA1 := COUNT(filterReasonCode('A1')); 
PRCA2 := COUNT(filterReasonCode('A2')); 
PRCA3 := COUNT(filterReasonCode('A3')); 
PRCA4 := COUNT(filterReasonCode('A4')); 
PRCA5 := COUNT(filterReasonCode('A5')); 
PRCA6 := COUNT(filterReasonCode('A6')); 
PRCA7 := COUNT(filterReasonCode('A7')); 
PRCA8 := COUNT(filterReasonCode('A8')); 
PRCA9 := COUNT(filterReasonCode('A9')); 
PRCB0 := COUNT(filterReasonCode('B0')); 
PRCBO := COUNT(filterReasonCode('BO')); 
PRCCL := COUNT(filterReasonCode('CL')); 
PRCCO := COUNT(filterReasonCode('CO')); 
PRCCR := COUNT(filterReasonCode('CR')); 
PRCCZ := COUNT(filterReasonCode('CZ')); 
PRCDD := COUNT(filterReasonCode('DD')); 
PRCDF := COUNT(filterReasonCode('DF')); 
PRCDM := COUNT(filterReasonCode('DM')); 
PRCDV := COUNT(filterReasonCode('DV')); 
PRCEV := COUNT(filterReasonCode('EV')); 
PRCFB := COUNT(filterReasonCode('FB')); 
PRCFM := COUNT(filterReasonCode('FM')); 
PRCFQ := COUNT(filterReasonCode('FQ')); 
PRCFR := COUNT(filterReasonCode('FR')); 
PRCFV := COUNT(filterReasonCode('FV')); 
PRCIA := COUNT(filterReasonCode('IA')); 
PRCIB := COUNT(filterReasonCode('IB')); 
PRCIC := COUNT(filterReasonCode('IC')); 
PRCID := COUNT(filterReasonCode('ID')); 
PRCIE := COUNT(filterReasonCode('IE')); 
PRCIF := COUNT(filterReasonCode('IF')); 
PRCIG := COUNT(filterReasonCode('IG')); 
PRCIH := COUNT(filterReasonCode('IH')); 
PRCII := COUNT(filterReasonCode('II')); 
PRCIJ := COUNT(filterReasonCode('IJ')); 
PRCIK := COUNT(filterReasonCode('IK')); 
PRCIS := COUNT(filterReasonCode('IS')); 
PRCIT := COUNT(filterReasonCode('IT')); 
PRCMI := COUNT(filterReasonCode('MI')); 
PRCMN := COUNT(filterReasonCode('MN')); 
PRCMO := COUNT(filterReasonCode('MO')); 
PRCMS := COUNT(filterReasonCode('MS')); 
PRCPA := COUNT(filterReasonCode('PA')); 
PRCPO := COUNT(filterReasonCode('PO')); 
PRCPV := COUNT(filterReasonCode('PV')); 
PRCRS := COUNT(filterReasonCode('RS')); 
PRCSR := COUNT(filterReasonCode('SR')); 
PRCU1 := COUNT(filterReasonCode('U1')); 
PRCU2 := COUNT(filterReasonCode('U2')); 
PRCWL := COUNT(filterReasonCode('WL')); 
PRCZI := COUNT(filterReasonCode('ZI')); 

Monitor_Layout getReport(ut.ds_oneRecord le) := TRANSFORM
	SELF.Date_Of_Report														:= ut.date_math(currentDate, -1 - dataLoadDelayDays); // We always run the report on the previous days records
	SELF.Date_Report_Was_Run											:= currentDate;
	SELF.Total_Number_Of_Transactions							:= totalTransactions;
	SELF.Total_Number_Of_Model_Scores							:= totalModelScores;
	SELF.Number_Of_Unique_Account_IDs_Transacted	:= uniqueIDs;
	SELF.Percent_First_Name_Populated							:= (firstNamePopulated / totalModelScores) * 100;
	SELF.Percent_Last_Name_Populated							:= (lastNamePopulated / totalModelScores) * 100;
	SELF.Percent_SSN_Populated										:= (ssnPopulated / totalModelScores) * 100;
	SELF.Percent_DOB_Populated										:= (dobPopulated / totalModelScores) * 100;
	SELF.Percent_Address_Populated								:= (addressPopulated / totalModelScores) * 100;
	SELF.Percent_City_Populated										:= (cityPopulated / totalModelScores) * 100;
	SELF.Percent_State_Populated									:= (statePopulated / totalModelScores) * 100;
	SELF.Percent_Zip_Populated										:= (zipPopulated / totalModelScores) * 100;
	SELF.Percent_DL_Populated											:= (dlPopulated / totalModelScores) * 100;
	SELF.Percent_Home_Phone_Populated							:= (homePhonePopulated / totalModelScores) * 100;
	SELF.Percent_Scored_100												:= (scored100 / totalModelScores) * 100;
	SELF.Percent_Scored_101												:= (scored101 / totalModelScores) * 100;
	SELF.Percent_Scored_102												:= (scored102 / totalModelScores) * 100;
	SELF.Percent_Scored_103												:= (scored103 / totalModelScores) * 100;
	SELF.Percent_Scored_104												:= (scored104 / totalModelScores) * 100;
	SELF.Percent_Scored_200												:= (scored200 / totalModelScores) * 100;
	SELF.Percent_Scored_222												:= (scored222 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_501_540						:= (scored501_540 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_541_580						:= (scored541_580 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_581_620						:= (scored581_620 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_621_660						:= (scored621_660 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_661_700						:= (scored661_700 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_701_740						:= (scored701_740 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_741_780						:= (scored741_780 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_781_820						:= (scored781_820 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_821_860						:= (scored821_860 / totalModelScores) * 100;
	SELF.Percent_Scored_Between_861_900						:= (scored861_900 / totalModelScores) * 100;
	SELF.Percent_Scored_Above_900									:= (scoredAbove900 / totalModelScores) * 100;
	SELF.Percent_Scored_Below_100									:= (scoredBelow100 / totalModelScores) * 100;
	SELF.Average_Score_Excluding_Exceptions				:= averageScore;
	
	SELF.Percent_RC_01														:= (PRC01 / totalModelScores) * 100;
	SELF.Percent_RC_02														:= (PRC02 / totalModelScores) * 100;
	SELF.Percent_RC_03														:= (PRC03 / totalModelScores) * 100;
	SELF.Percent_RC_04														:= (PRC04 / totalModelScores) * 100;
	SELF.Percent_RC_05														:= (PRC05 / totalModelScores) * 100;
	SELF.Percent_RC_06														:= (PRC06 / totalModelScores) * 100;
	SELF.Percent_RC_07														:= (PRC07 / totalModelScores) * 100;
	SELF.Percent_RC_08														:= (PRC08 / totalModelScores) * 100;
	SELF.Percent_RC_09														:= (PRC09 / totalModelScores) * 100;
	SELF.Percent_RC_10														:= (PRC10 / totalModelScores) * 100;
	SELF.Percent_RC_11														:= (PRC11 / totalModelScores) * 100;
	SELF.Percent_RC_12														:= (PRC12 / totalModelScores) * 100;
	SELF.Percent_RC_13														:= (PRC13 / totalModelScores) * 100;
	SELF.Percent_RC_14														:= (PRC14 / totalModelScores) * 100;
	SELF.Percent_RC_15														:= (PRC15 / totalModelScores) * 100;
	SELF.Percent_RC_16														:= (PRC16 / totalModelScores) * 100;
	SELF.Percent_RC_17														:= (PRC17 / totalModelScores) * 100;
	SELF.Percent_RC_19														:= (PRC19 / totalModelScores) * 100;
	SELF.Percent_RC_20														:= (PRC20 / totalModelScores) * 100;
	SELF.Percent_RC_21														:= (PRC21 / totalModelScores) * 100;
	SELF.Percent_RC_22														:= (PRC22 / totalModelScores) * 100;
	SELF.Percent_RC_23														:= (PRC23 / totalModelScores) * 100;
	SELF.Percent_RC_24														:= (PRC24 / totalModelScores) * 100;
	SELF.Percent_RC_25														:= (PRC25 / totalModelScores) * 100;
	SELF.Percent_RC_26														:= (PRC26 / totalModelScores) * 100;
	SELF.Percent_RC_27														:= (PRC27 / totalModelScores) * 100;
	SELF.Percent_RC_28														:= (PRC28 / totalModelScores) * 100;
	SELF.Percent_RC_29														:= (PRC29 / totalModelScores) * 100;
	SELF.Percent_RC_30														:= (PRC30 / totalModelScores) * 100;
	SELF.Percent_RC_31														:= (PRC31 / totalModelScores) * 100;
	SELF.Percent_RC_32														:= (PRC32 / totalModelScores) * 100;
	SELF.Percent_RC_33														:= (PRC33 / totalModelScores) * 100;
	SELF.Percent_RC_34														:= (PRC34 / totalModelScores) * 100;
	SELF.Percent_RC_35														:= (PRC35 / totalModelScores) * 100;
	SELF.Percent_RC_36														:= (PRC36 / totalModelScores) * 100;
	SELF.Percent_RC_37														:= (PRC37 / totalModelScores) * 100;
	SELF.Percent_RC_38														:= (PRC38 / totalModelScores) * 100;
	SELF.Percent_RC_39														:= (PRC39 / totalModelScores) * 100;
	SELF.Percent_RC_40														:= (PRC40 / totalModelScores) * 100;
	SELF.Percent_RC_41														:= (PRC41 / totalModelScores) * 100;
	SELF.Percent_RC_42														:= (PRC42 / totalModelScores) * 100;
	SELF.Percent_RC_43														:= (PRC43 / totalModelScores) * 100;
	SELF.Percent_RC_44														:= (PRC44 / totalModelScores) * 100;
	SELF.Percent_RC_45														:= (PRC45 / totalModelScores) * 100;
	SELF.Percent_RC_46														:= (PRC46 / totalModelScores) * 100;
	SELF.Percent_RC_47														:= (PRC47 / totalModelScores) * 100;
	SELF.Percent_RC_48														:= (PRC48 / totalModelScores) * 100;
	SELF.Percent_RC_49														:= (PRC49 / totalModelScores) * 100;
	SELF.Percent_RC_50														:= (PRC50 / totalModelScores) * 100;
	SELF.Percent_RC_51														:= (PRC51 / totalModelScores) * 100;
	SELF.Percent_RC_52														:= (PRC52 / totalModelScores) * 100;
	SELF.Percent_RC_53														:= (PRC53 / totalModelScores) * 100;
	SELF.Percent_RC_54														:= (PRC54 / totalModelScores) * 100;
	SELF.Percent_RC_55														:= (PRC55 / totalModelScores) * 100;
	SELF.Percent_RC_56														:= (PRC56 / totalModelScores) * 100;
	SELF.Percent_RC_57														:= (PRC57 / totalModelScores) * 100;
	SELF.Percent_RC_58														:= (PRC58 / totalModelScores) * 100;
	SELF.Percent_RC_59														:= (PRC59 / totalModelScores) * 100;
	SELF.Percent_RC_5Q														:= (PRC5Q / totalModelScores) * 100;
	SELF.Percent_RC_60														:= (PRC60 / totalModelScores) * 100;
	SELF.Percent_RC_61														:= (PRC61 / totalModelScores) * 100;
	SELF.Percent_RC_62														:= (PRC62 / totalModelScores) * 100;
	SELF.Percent_RC_63														:= (PRC63 / totalModelScores) * 100;
	SELF.Percent_RC_64														:= (PRC64 / totalModelScores) * 100;
	SELF.Percent_RC_65														:= (PRC65 / totalModelScores) * 100;
	SELF.Percent_RC_66														:= (PRC66 / totalModelScores) * 100;
	SELF.Percent_RC_67														:= (PRC67 / totalModelScores) * 100;
	SELF.Percent_RC_68														:= (PRC68 / totalModelScores) * 100;
	SELF.Percent_RC_69														:= (PRC69 / totalModelScores) * 100;
	SELF.Percent_RC_70														:= (PRC70 / totalModelScores) * 100;
	SELF.Percent_RC_71														:= (PRC71 / totalModelScores) * 100;
	SELF.Percent_RC_72														:= (PRC72 / totalModelScores) * 100;
	SELF.Percent_RC_73														:= (PRC73 / totalModelScores) * 100;
	SELF.Percent_RC_74														:= (PRC74 / totalModelScores) * 100;
	SELF.Percent_RC_75														:= (PRC75 / totalModelScores) * 100;
	SELF.Percent_RC_76														:= (PRC76 / totalModelScores) * 100;
	SELF.Percent_RC_77														:= (PRC77 / totalModelScores) * 100;
	SELF.Percent_RC_78														:= (PRC78 / totalModelScores) * 100;
	SELF.Percent_RC_79														:= (PRC79 / totalModelScores) * 100;
	SELF.Percent_RC_80														:= (PRC80 / totalModelScores) * 100;
	SELF.Percent_RC_81														:= (PRC81 / totalModelScores) * 100;
	SELF.Percent_RC_82														:= (PRC82 / totalModelScores) * 100;
	SELF.Percent_RC_83														:= (PRC83 / totalModelScores) * 100;
	SELF.Percent_RC_84														:= (PRC84 / totalModelScores) * 100;
	SELF.Percent_RC_85														:= (PRC85 / totalModelScores) * 100;
	SELF.Percent_RC_86														:= (PRC86 / totalModelScores) * 100;
	SELF.Percent_RC_87														:= (PRC87 / totalModelScores) * 100;
	SELF.Percent_RC_88														:= (PRC88 / totalModelScores) * 100;
	SELF.Percent_RC_89														:= (PRC89 / totalModelScores) * 100;
	SELF.Percent_RC_90														:= (PRC90 / totalModelScores) * 100;
	SELF.Percent_RC_91														:= (PRC91 / totalModelScores) * 100;
	SELF.Percent_RC_92														:= (PRC92 / totalModelScores) * 100;
	SELF.Percent_RC_93														:= (PRC93 / totalModelScores) * 100;
	SELF.Percent_RC_94														:= (PRC94 / totalModelScores) * 100;
	SELF.Percent_RC_95														:= (PRC95 / totalModelScores) * 100;
	SELF.Percent_RC_96														:= (PRC96 / totalModelScores) * 100;
	SELF.Percent_RC_97														:= (PRC97 / totalModelScores) * 100;
	SELF.Percent_RC_98														:= (PRC98 / totalModelScores) * 100;
	SELF.Percent_RC_99														:= (PRC99 / totalModelScores) * 100;
	SELF.Percent_RC_9A														:= (PRC9A / totalModelScores) * 100;
	SELF.Percent_RC_9B														:= (PRC9B / totalModelScores) * 100;
	SELF.Percent_RC_9C														:= (PRC9C / totalModelScores) * 100;
	SELF.Percent_RC_9D														:= (PRC9D / totalModelScores) * 100;
	SELF.Percent_RC_9E														:= (PRC9E / totalModelScores) * 100;
	SELF.Percent_RC_9F														:= (PRC9F / totalModelScores) * 100;
	SELF.Percent_RC_9G														:= (PRC9G / totalModelScores) * 100;
	SELF.Percent_RC_9H														:= (PRC9H / totalModelScores) * 100;
	SELF.Percent_RC_9I														:= (PRC9I / totalModelScores) * 100;
	SELF.Percent_RC_9J														:= (PRC9J / totalModelScores) * 100;
	SELF.Percent_RC_9K														:= (PRC9K / totalModelScores) * 100;
	SELF.Percent_RC_9L														:= (PRC9L / totalModelScores) * 100;
	SELF.Percent_RC_9M														:= (PRC9M / totalModelScores) * 100;
	SELF.Percent_RC_9N														:= (PRC9N / totalModelScores) * 100;
	SELF.Percent_RC_9O														:= (PRC9O / totalModelScores) * 100;
	SELF.Percent_RC_9P														:= (PRC9P / totalModelScores) * 100;
	SELF.Percent_RC_9Q														:= (PRC9Q / totalModelScores) * 100;
	SELF.Percent_RC_9R														:= (PRC9R / totalModelScores) * 100;
	SELF.Percent_RC_9S														:= (PRC9S / totalModelScores) * 100;
	SELF.Percent_RC_9T														:= (PRC9T / totalModelScores) * 100;
	SELF.Percent_RC_9U														:= (PRC9U / totalModelScores) * 100;
	SELF.Percent_RC_9V														:= (PRC9V / totalModelScores) * 100;
	SELF.Percent_RC_9W														:= (PRC9W / totalModelScores) * 100;
	SELF.Percent_RC_9X														:= (PRC9X / totalModelScores) * 100;
	SELF.Percent_RC_A0														:= (PRCA0 / totalModelScores) * 100;
	SELF.Percent_RC_A1														:= (PRCA1 / totalModelScores) * 100;
	SELF.Percent_RC_A2														:= (PRCA2 / totalModelScores) * 100;
	SELF.Percent_RC_A3														:= (PRCA3 / totalModelScores) * 100;
	SELF.Percent_RC_A4														:= (PRCA4 / totalModelScores) * 100;
	SELF.Percent_RC_A5														:= (PRCA5 / totalModelScores) * 100;
	SELF.Percent_RC_A6														:= (PRCA6 / totalModelScores) * 100;
	SELF.Percent_RC_A7														:= (PRCA7 / totalModelScores) * 100;
	SELF.Percent_RC_A8														:= (PRCA8 / totalModelScores) * 100;
	SELF.Percent_RC_A9														:= (PRCA9 / totalModelScores) * 100;
	SELF.Percent_RC_B0														:= (PRCB0 / totalModelScores) * 100;
	SELF.Percent_RC_BO														:= (PRCBO / totalModelScores) * 100;
	SELF.Percent_RC_CL														:= (PRCCL / totalModelScores) * 100;
	SELF.Percent_RC_CO														:= (PRCCO / totalModelScores) * 100;
	SELF.Percent_RC_CR														:= (PRCCR / totalModelScores) * 100;
	SELF.Percent_RC_CZ														:= (PRCCZ / totalModelScores) * 100;
	SELF.Percent_RC_DD														:= (PRCDD / totalModelScores) * 100;
	SELF.Percent_RC_DF														:= (PRCDF / totalModelScores) * 100;
	SELF.Percent_RC_DM														:= (PRCDM / totalModelScores) * 100;
	SELF.Percent_RC_DV														:= (PRCDV / totalModelScores) * 100;
	SELF.Percent_RC_EV														:= (PRCEV / totalModelScores) * 100;
	SELF.Percent_RC_FB														:= (PRCFB / totalModelScores) * 100;
	SELF.Percent_RC_FM														:= (PRCFM / totalModelScores) * 100;
	SELF.Percent_RC_FQ														:= (PRCFQ / totalModelScores) * 100;
	SELF.Percent_RC_FR														:= (PRCFR / totalModelScores) * 100;
	SELF.Percent_RC_FV														:= (PRCFV / totalModelScores) * 100;
	SELF.Percent_RC_IA														:= (PRCIA / totalModelScores) * 100;
	SELF.Percent_RC_IB														:= (PRCIB / totalModelScores) * 100;
	SELF.Percent_RC_IC														:= (PRCIC / totalModelScores) * 100;
	SELF.Percent_RC_ID														:= (PRCID / totalModelScores) * 100;
	SELF.Percent_RC_IE														:= (PRCIE / totalModelScores) * 100;
	SELF.Percent_RC_IF														:= (PRCIF / totalModelScores) * 100;
	SELF.Percent_RC_IG														:= (PRCIG / totalModelScores) * 100;
	SELF.Percent_RC_IH														:= (PRCIH / totalModelScores) * 100;
	SELF.Percent_RC_II														:= (PRCII / totalModelScores) * 100;
	SELF.Percent_RC_IJ														:= (PRCIJ / totalModelScores) * 100;
	SELF.Percent_RC_IK														:= (PRCIK / totalModelScores) * 100;
	SELF.Percent_RC_IS														:= (PRCIS / totalModelScores) * 100;
	SELF.Percent_RC_IT														:= (PRCIT / totalModelScores) * 100;
	SELF.Percent_RC_MI														:= (PRCMI / totalModelScores) * 100;
	SELF.Percent_RC_MN														:= (PRCMN / totalModelScores) * 100;
	SELF.Percent_RC_MO														:= (PRCMO / totalModelScores) * 100;
	SELF.Percent_RC_MS														:= (PRCMS / totalModelScores) * 100;
	SELF.Percent_RC_PA														:= (PRCPA / totalModelScores) * 100;
	SELF.Percent_RC_PO														:= (PRCPO / totalModelScores) * 100;
	SELF.Percent_RC_PV														:= (PRCPV / totalModelScores) * 100;
	SELF.Percent_RC_RS														:= (PRCRS / totalModelScores) * 100;
	SELF.Percent_RC_SR														:= (PRCSR / totalModelScores) * 100;
	SELF.Percent_RC_U1														:= (PRCU1 / totalModelScores) * 100;
	SELF.Percent_RC_U2														:= (PRCU2 / totalModelScores) * 100;
	SELF.Percent_RC_WL														:= (PRCWL / totalModelScores) * 100;
	SELF.Percent_RC_ZI														:= (PRCZI / totalModelScores) * 100;
	
	SELF := [];
END;

todaysFile := PROJECT(ut.ds_oneRecord, getReport(LEFT));

// If we have a previous file to append to, use it.  Otherwise this must be a new file run!
previousFile := IF(previousFilePath != '', DATASET(previousFilePath, Monitor_Layout, CSV(HEADING(single), QUOTE('"'))), 
																					 DATASET([], Monitor_Layout));

combinedFile := previousFile (Date_Of_Report <> ut.date_math(currentDate, -1 - dataLoadDelayDays)) + todaysFile;

OUTPUT(CHOOSEN(todaysFile, eyeball), NAMED('Current_Report'));
OUTPUT(CHOOSEN(SORT(previousFile, -Date_Of_Report), eyeball), NAMED('Sample_Previous_Report'));
OUTPUT(CHOOSEN(SORT(combinedFile, -Date_Of_Report), eyeball), NAMED('Sample_Combined_Report'));
OUTPUT(COUNT(combinedFile), NAMED('Number_of_Days_in_Report'));
comboFile := SORT(combinedFile, Date_Of_Report);
SEQUENTIAL(IF(STD.File.FileExists(currentDateFile), STD.File.ProtectLogicalFile(currentDateFile, FALSE)),
OUTPUT(comboFile,, currentDateFile, CSV(HEADING(single), QUOTE('"')), OVERWRITE, EXPIRE(91))) : SUCCESS(SEQUENTIAL(STD.File.SetFileDescription(currentDateFile, 'Score and Attribute Outcome Tracking - RiskView Daily Score Monitor CSV File - ' + currentDate), STD.File.ProtectLogicalFile(currentDateFile, TRUE)));

/* *********************************************************************
 *                           EMAIL REPORT                              *
 ***********************************************************************
 * If today is the 1st of the month, email last months CSV file. If    *
 * not, just e-mail the normal report.                                 *
 ***********************************************************************/
firstOfMonthTemp := IF(currentDate[7..8] = '02', TRUE, FALSE);
// firstOfMonthTemp := TRUE;
// firstOfMonthTemp := FALSE;
#UNIQUENAME(firstOfMonth);
#SET(firstOfMonth, firstOfMonthTemp);

// Get the most recent month's worth of transactions
attachmentTemp := IF(%firstOfMonth%, CHOOSEN(SORT(combinedFile, -Date_Of_Report), ut.Month_Days((UNSIGNED)ut.date_math(currentDate, -1)[1..6])), 
																	DATASET([], Monitor_Layout));

// Handle generation of the CSV File
csvHeading := (DATA)
'Date_Of_Report,' + 
'Date_Report_Was_Run,' + 
'Total_Number_Of_Transactions,' + 
'Total_Number_Of_Model_Scores,' + 
'Number_Of_Unique_Account_IDs_Transacted,' + 
'Percent_First_Name_Populated,' + 
'Percent_Last_Name_Populated,' + 
'Percent_SSN_Populated,' + 
'Percent_DOB_Populated,' + 
'Percent_Address_Populated,' + 
'Percent_City_Populated,' + 
'Percent_State_Populated,' + 
'Percent_Zip_Populated,' + 
'Percent_DL_Populated,' + 
'Percent_Home_Phone_Populated,' + 
'Percent_Scored_100,' + 
'Percent_Scored_101,' + 
'Percent_Scored_102,' + 
'Percent_Scored_103,' + 
'Percent_Scored_104,' + 
'Percent_Scored_200,' + 
'Percent_Scored_222,' + 
'Percent_Scored_Between_501_540,' + 
'Percent_Scored_Between_541_580,' + 
'Percent_Scored_Between_581_620,' + 
'Percent_Scored_Between_621_660,' + 
'Percent_Scored_Between_661_700,' + 
'Percent_Scored_Between_701_740,' + 
'Percent_Scored_Between_741_780,' + 
'Percent_Scored_Between_781_820,' + 
'Percent_Scored_Between_821_860,' + 
'Percent_Scored_Between_861_900,' + 
'Percent_Scored_Above_900,' + 
'Percent_Scored_Below_100,' + 
'Average_Score_Excluding_Exceptions,' + 
'Percent_RC_01,' +
'Percent_RC_02,' +
'Percent_RC_03,' +
'Percent_RC_04,' +
'Percent_RC_05,' +
'Percent_RC_06,' +
'Percent_RC_07,' +
'Percent_RC_08,' +
'Percent_RC_09,' +
'Percent_RC_10,' +
'Percent_RC_11,' +
'Percent_RC_12,' +
'Percent_RC_13,' +
'Percent_RC_14,' +
'Percent_RC_15,' +
'Percent_RC_16,' +
'Percent_RC_17,' +
'Percent_RC_19,' +
'Percent_RC_20,' +
'Percent_RC_21,' +
'Percent_RC_22,' +
'Percent_RC_23,' +
'Percent_RC_24,' +
'Percent_RC_25,' +
'Percent_RC_26,' +
'Percent_RC_27,' +
'Percent_RC_28,' +
'Percent_RC_29,' +
'Percent_RC_30,' +
'Percent_RC_31,' +
'Percent_RC_32,' +
'Percent_RC_33,' +
'Percent_RC_34,' +
'Percent_RC_35,' +
'Percent_RC_36,' +
'Percent_RC_37,' +
'Percent_RC_38,' +
'Percent_RC_39,' +
'Percent_RC_40,' +
'Percent_RC_41,' +
'Percent_RC_42,' +
'Percent_RC_43,' +
'Percent_RC_44,' +
'Percent_RC_45,' +
'Percent_RC_46,' +
'Percent_RC_47,' +
'Percent_RC_48,' +
'Percent_RC_49,' +
'Percent_RC_50,' +
'Percent_RC_51,' +
'Percent_RC_52,' +
'Percent_RC_53,' +
'Percent_RC_54,' +
'Percent_RC_55,' +
'Percent_RC_56,' +
'Percent_RC_57,' +
'Percent_RC_58,' +
'Percent_RC_59,' +
'Percent_RC_5Q,' +
'Percent_RC_60,' +
'Percent_RC_61,' +
'Percent_RC_62,' +
'Percent_RC_63,' +
'Percent_RC_64,' +
'Percent_RC_65,' +
'Percent_RC_66,' +
'Percent_RC_67,' +
'Percent_RC_68,' +
'Percent_RC_69,' +
'Percent_RC_70,' +
'Percent_RC_71,' +
'Percent_RC_72,' +
'Percent_RC_73,' +
'Percent_RC_74,' +
'Percent_RC_75,' +
'Percent_RC_76,' +
'Percent_RC_77,' +
'Percent_RC_78,' +
'Percent_RC_79,' +
'Percent_RC_80,' +
'Percent_RC_81,' +
'Percent_RC_82,' +
'Percent_RC_83,' +
'Percent_RC_84,' +
'Percent_RC_85,' +
'Percent_RC_86,' +
'Percent_RC_87,' +
'Percent_RC_88,' +
'Percent_RC_89,' +
'Percent_RC_90,' +
'Percent_RC_91,' +
'Percent_RC_92,' +
'Percent_RC_93,' +
'Percent_RC_94,' +
'Percent_RC_95,' +
'Percent_RC_96,' +
'Percent_RC_97,' +
'Percent_RC_98,' +
'Percent_RC_99,' +
'Percent_RC_9A,' +
'Percent_RC_9B,' +
'Percent_RC_9C,' +
'Percent_RC_9D,' +
'Percent_RC_9E,' +
'Percent_RC_9F,' +
'Percent_RC_9G,' +
'Percent_RC_9H,' +
'Percent_RC_9I,' +
'Percent_RC_9J,' +
'Percent_RC_9K,' +
'Percent_RC_9L,' +
'Percent_RC_9M,' +
'Percent_RC_9N,' +
'Percent_RC_9O,' +
'Percent_RC_9P,' +
'Percent_RC_9Q,' +
'Percent_RC_9R,' +
'Percent_RC_9S,' +
'Percent_RC_9T,' +
'Percent_RC_9U,' +
'Percent_RC_9V,' +
'Percent_RC_9W,' +
'Percent_RC_9X,' +
'Percent_RC_A0,' +
'Percent_RC_A1,' +
'Percent_RC_A2,' +
'Percent_RC_A3,' +
'Percent_RC_A4,' +
'Percent_RC_A5,' +
'Percent_RC_A6,' +
'Percent_RC_A7,' +
'Percent_RC_A8,' +
'Percent_RC_A9,' +
'Percent_RC_B0,' +
'Percent_RC_BO,' +
'Percent_RC_CL,' +
'Percent_RC_CO,' +
'Percent_RC_CR,' +
'Percent_RC_CZ,' +
'Percent_RC_DD,' +
'Percent_RC_DF,' +
'Percent_RC_DM,' +
'Percent_RC_DV,' +
'Percent_RC_EV,' +
'Percent_RC_FB,' +
'Percent_RC_FM,' +
'Percent_RC_FQ,' +
'Percent_RC_FR,' +
'Percent_RC_FV,' +
'Percent_RC_IA,' +
'Percent_RC_IB,' +
'Percent_RC_IC,' +
'Percent_RC_ID,' +
'Percent_RC_IE,' +
'Percent_RC_IF,' +
'Percent_RC_IG,' +
'Percent_RC_IH,' +
'Percent_RC_II,' +
'Percent_RC_IJ,' +
'Percent_RC_IK,' +
'Percent_RC_IS,' +
'Percent_RC_IT,' +
'Percent_RC_MI,' +
'Percent_RC_MN,' +
'Percent_RC_MO,' +
'Percent_RC_MS,' +
'Percent_RC_PA,' +
'Percent_RC_PO,' +
'Percent_RC_PV,' +
'Percent_RC_RS,' +
'Percent_RC_SR,' +
'Percent_RC_U1,' +
'Percent_RC_U2,' +
'Percent_RC_WL,' +
'Percent_RC_ZI,' +
'\r\n';
attachmentLayout := RECORD
	DATA thisRow;
END;
attachmentLayout getData(attachmentTemp le) := TRANSFORM
thisRowS := (STRING)le.Date_Of_Report + ',' + 
						(STRING)le.Date_Report_Was_Run + ',' +
						(STRING)le.Total_Number_Of_Transactions + ',' +
						(STRING)le.Total_Number_Of_Model_Scores + ',' +
						(STRING)le.Number_Of_Unique_Account_IDs_Transacted + ',' +
						(STRING)le.Percent_First_Name_Populated + ',' +
						(STRING)le.Percent_Last_Name_Populated	 + ',' +
						(STRING)le.Percent_SSN_Populated				 + ',' +
						(STRING)le.Percent_DOB_Populated				 + ',' +
						(STRING)le.Percent_Address_Populated		 + ',' +
						(STRING)le.Percent_City_Populated			 + ',' +
						(STRING)le.Percent_State_Populated			 + ',' +
						(STRING)le.Percent_Zip_Populated				 + ',' +
						(STRING)le.Percent_DL_Populated				 + ',' +
						(STRING)le.Percent_Home_Phone_Populated + ',' +
						(STRING)le.Percent_Scored_100					 + ',' +
						(STRING)le.Percent_Scored_101					 + ',' +
						(STRING)le.Percent_Scored_102					 + ',' +
						(STRING)le.Percent_Scored_103					 + ',' +
						(STRING)le.Percent_Scored_104					 + ',' +
						(STRING)le.Percent_Scored_200					 + ',' +
						(STRING)le.Percent_Scored_222					 + ',' +
						(STRING)le.Percent_Scored_Between_501_540 + ',' +
						(STRING)le.Percent_Scored_Between_541_580 + ',' +
						(STRING)le.Percent_Scored_Between_581_620 + ',' +
						(STRING)le.Percent_Scored_Between_621_660 + ',' +
						(STRING)le.Percent_Scored_Between_661_700 + ',' +
						(STRING)le.Percent_Scored_Between_701_740 + ',' +
						(STRING)le.Percent_Scored_Between_741_780 + ',' +
						(STRING)le.Percent_Scored_Between_781_820 + ',' +
						(STRING)le.Percent_Scored_Between_821_860 + ',' +
						(STRING)le.Percent_Scored_Between_861_900 + ',' +
						(STRING)le.Percent_Scored_Above_900 + ',' +
						(STRING)le.Percent_Scored_Below_100 + ',' +
						(STRING)le.Average_Score_Excluding_Exceptions + ',' +
						(STRING)le.Percent_RC_01 + ',' +
						(STRING)le.Percent_RC_02 + ',' +
						(STRING)le.Percent_RC_03 + ',' +
						(STRING)le.Percent_RC_04 + ',' +
						(STRING)le.Percent_RC_05 + ',' +
						(STRING)le.Percent_RC_06 + ',' +
						(STRING)le.Percent_RC_07 + ',' +
						(STRING)le.Percent_RC_08 + ',' +
						(STRING)le.Percent_RC_09 + ',' +
						(STRING)le.Percent_RC_10 + ',' +
						(STRING)le.Percent_RC_11 + ',' +
						(STRING)le.Percent_RC_12 + ',' +
						(STRING)le.Percent_RC_13 + ',' +
						(STRING)le.Percent_RC_14 + ',' +
						(STRING)le.Percent_RC_15 + ',' +
						(STRING)le.Percent_RC_16 + ',' +
						(STRING)le.Percent_RC_17 + ',' +
						(STRING)le.Percent_RC_19 + ',' +
						(STRING)le.Percent_RC_20 + ',' +
						(STRING)le.Percent_RC_21 + ',' +
						(STRING)le.Percent_RC_22 + ',' +
						(STRING)le.Percent_RC_23 + ',' +
						(STRING)le.Percent_RC_24 + ',' +
						(STRING)le.Percent_RC_25 + ',' +
						(STRING)le.Percent_RC_26 + ',' +
						(STRING)le.Percent_RC_27 + ',' +
						(STRING)le.Percent_RC_28 + ',' +
						(STRING)le.Percent_RC_29 + ',' +
						(STRING)le.Percent_RC_30 + ',' +
						(STRING)le.Percent_RC_31 + ',' +
						(STRING)le.Percent_RC_32 + ',' +
						(STRING)le.Percent_RC_33 + ',' +
						(STRING)le.Percent_RC_34 + ',' +
						(STRING)le.Percent_RC_35 + ',' +
						(STRING)le.Percent_RC_36 + ',' +
						(STRING)le.Percent_RC_37 + ',' +
						(STRING)le.Percent_RC_38 + ',' +
						(STRING)le.Percent_RC_39 + ',' +
						(STRING)le.Percent_RC_40 + ',' +
						(STRING)le.Percent_RC_41 + ',' +
						(STRING)le.Percent_RC_42 + ',' +
						(STRING)le.Percent_RC_43 + ',' +
						(STRING)le.Percent_RC_44 + ',' +
						(STRING)le.Percent_RC_45 + ',' +
						(STRING)le.Percent_RC_46 + ',' +
						(STRING)le.Percent_RC_47 + ',' +
						(STRING)le.Percent_RC_48 + ',' +
						(STRING)le.Percent_RC_49 + ',' +
						(STRING)le.Percent_RC_50 + ',' +
						(STRING)le.Percent_RC_51 + ',' +
						(STRING)le.Percent_RC_52 + ',' +
						(STRING)le.Percent_RC_53 + ',' +
						(STRING)le.Percent_RC_54 + ',' +
						(STRING)le.Percent_RC_55 + ',' +
						(STRING)le.Percent_RC_56 + ',' +
						(STRING)le.Percent_RC_57 + ',' +
						(STRING)le.Percent_RC_58 + ',' +
						(STRING)le.Percent_RC_59 + ',' +
						(STRING)le.Percent_RC_5Q + ',' +
						(STRING)le.Percent_RC_60 + ',' +
						(STRING)le.Percent_RC_61 + ',' +
						(STRING)le.Percent_RC_62 + ',' +
						(STRING)le.Percent_RC_63 + ',' +
						(STRING)le.Percent_RC_64 + ',' +
						(STRING)le.Percent_RC_65 + ',' +
						(STRING)le.Percent_RC_66 + ',' +
						(STRING)le.Percent_RC_67 + ',' +
						(STRING)le.Percent_RC_68 + ',' +
						(STRING)le.Percent_RC_69 + ',' +
						(STRING)le.Percent_RC_70 + ',' +
						(STRING)le.Percent_RC_71 + ',' +
						(STRING)le.Percent_RC_72 + ',' +
						(STRING)le.Percent_RC_73 + ',' +
						(STRING)le.Percent_RC_74 + ',' +
						(STRING)le.Percent_RC_75 + ',' +
						(STRING)le.Percent_RC_76 + ',' +
						(STRING)le.Percent_RC_77 + ',' +
						(STRING)le.Percent_RC_78 + ',' +
						(STRING)le.Percent_RC_79 + ',' +
						(STRING)le.Percent_RC_80 + ',' +
						(STRING)le.Percent_RC_81 + ',' +
						(STRING)le.Percent_RC_82 + ',' +
						(STRING)le.Percent_RC_83 + ',' +
						(STRING)le.Percent_RC_84 + ',' +
						(STRING)le.Percent_RC_85 + ',' +
						(STRING)le.Percent_RC_86 + ',' +
						(STRING)le.Percent_RC_87 + ',' +
						(STRING)le.Percent_RC_88 + ',' +
						(STRING)le.Percent_RC_89 + ',' +
						(STRING)le.Percent_RC_90 + ',' +
						(STRING)le.Percent_RC_91 + ',' +
						(STRING)le.Percent_RC_92 + ',' +
						(STRING)le.Percent_RC_93 + ',' +
						(STRING)le.Percent_RC_94 + ',' +
						(STRING)le.Percent_RC_95 + ',' +
						(STRING)le.Percent_RC_96 + ',' +
						(STRING)le.Percent_RC_97 + ',' +
						(STRING)le.Percent_RC_98 + ',' +
						(STRING)le.Percent_RC_99 + ',' +
						(STRING)le.Percent_RC_9A + ',' +
						(STRING)le.Percent_RC_9B + ',' +
						(STRING)le.Percent_RC_9C + ',' +
						(STRING)le.Percent_RC_9D + ',' +
						(STRING)le.Percent_RC_9E + ',' +
						(STRING)le.Percent_RC_9F + ',' +
						(STRING)le.Percent_RC_9G + ',' +
						(STRING)le.Percent_RC_9H + ',' +
						(STRING)le.Percent_RC_9I + ',' +
						(STRING)le.Percent_RC_9J + ',' +
						(STRING)le.Percent_RC_9K + ',' +
						(STRING)le.Percent_RC_9L + ',' +
						(STRING)le.Percent_RC_9M + ',' +
						(STRING)le.Percent_RC_9N + ',' +
						(STRING)le.Percent_RC_9O + ',' +
						(STRING)le.Percent_RC_9P + ',' +
						(STRING)le.Percent_RC_9Q + ',' +
						(STRING)le.Percent_RC_9R + ',' +
						(STRING)le.Percent_RC_9S + ',' +
						(STRING)le.Percent_RC_9T + ',' +
						(STRING)le.Percent_RC_9U + ',' +
						(STRING)le.Percent_RC_9V + ',' +
						(STRING)le.Percent_RC_9W + ',' +
						(STRING)le.Percent_RC_9X + ',' +
						(STRING)le.Percent_RC_A0 + ',' +
						(STRING)le.Percent_RC_A1 + ',' +
						(STRING)le.Percent_RC_A2 + ',' +
						(STRING)le.Percent_RC_A3 + ',' +
						(STRING)le.Percent_RC_A4 + ',' +
						(STRING)le.Percent_RC_A5 + ',' +
						(STRING)le.Percent_RC_A6 + ',' +
						(STRING)le.Percent_RC_A7 + ',' +
						(STRING)le.Percent_RC_A8 + ',' +
						(STRING)le.Percent_RC_A9 + ',' +
						(STRING)le.Percent_RC_B0 + ',' +
						(STRING)le.Percent_RC_BO + ',' +
						(STRING)le.Percent_RC_CL + ',' +
						(STRING)le.Percent_RC_CO + ',' +
						(STRING)le.Percent_RC_CR + ',' +
						(STRING)le.Percent_RC_CZ + ',' +
						(STRING)le.Percent_RC_DD + ',' +
						(STRING)le.Percent_RC_DF + ',' +
						(STRING)le.Percent_RC_DM + ',' +
						(STRING)le.Percent_RC_DV + ',' +
						(STRING)le.Percent_RC_EV + ',' +
						(STRING)le.Percent_RC_FB + ',' +
						(STRING)le.Percent_RC_FM + ',' +
						(STRING)le.Percent_RC_FQ + ',' +
						(STRING)le.Percent_RC_FR + ',' +
						(STRING)le.Percent_RC_FV + ',' +
						(STRING)le.Percent_RC_IA + ',' +
						(STRING)le.Percent_RC_IB + ',' +
						(STRING)le.Percent_RC_IC + ',' +
						(STRING)le.Percent_RC_ID + ',' +
						(STRING)le.Percent_RC_IE + ',' +
						(STRING)le.Percent_RC_IF + ',' +
						(STRING)le.Percent_RC_IG + ',' +
						(STRING)le.Percent_RC_IH + ',' +
						(STRING)le.Percent_RC_II + ',' +
						(STRING)le.Percent_RC_IJ + ',' +
						(STRING)le.Percent_RC_IK + ',' +
						(STRING)le.Percent_RC_IS + ',' +
						(STRING)le.Percent_RC_IT + ',' +
						(STRING)le.Percent_RC_MI + ',' +
						(STRING)le.Percent_RC_MN + ',' +
						(STRING)le.Percent_RC_MO + ',' +
						(STRING)le.Percent_RC_MS + ',' +
						(STRING)le.Percent_RC_PA + ',' +
						(STRING)le.Percent_RC_PO + ',' +
						(STRING)le.Percent_RC_PV + ',' +
						(STRING)le.Percent_RC_RS + ',' +
						(STRING)le.Percent_RC_SR + ',' +
						(STRING)le.Percent_RC_U1 + ',' +
						(STRING)le.Percent_RC_U2 + ',' +
						(STRING)le.Percent_RC_WL + ',' +
						(STRING)le.Percent_RC_ZI + ',' +
						'\r\n';
	SELF.thisRow := (DATA)thisRowS;
END;
rowified := PROJECT(attachmentTemp, getData(LEFT));

attachment := csvHeading + rowified[1].thisRow + rowified[2].thisRow + rowified[3].thisRow + rowified[4].thisRow + rowified[5].thisRow + rowified[6].thisRow + rowified[7].thisRow + rowified[8].thisRow + rowified[9].thisRow + rowified[10].thisRow + rowified[11].thisRow + rowified[12].thisRow + rowified[13].thisRow + rowified[14].thisRow + rowified[15].thisRow + rowified[16].thisRow + rowified[17].thisRow + rowified[18].thisRow + rowified[19].thisRow + rowified[20].thisRow + rowified[21].thisRow + rowified[22].thisRow + rowified[23].thisRow + rowified[24].thisRow + rowified[25].thisRow + rowified[26].thisRow + rowified[27].thisRow + rowified[28].thisRow + rowified[29].thisRow + rowified[30].thisRow + rowified[31].thisRow;
// End of the CSV File Generation

// Generate the body of the e-mail
firstRun := SORT(combinedFile, Date_Of_Report);
pastWeek := CHOOSEN(SORT(combinedFile, -Date_Of_Report), 7);
// It's possible we missed a day... Which is why all these filters are needed
day1 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -1 - dataLoadDelayDays));
day2 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -2 - dataLoadDelayDays));
day3 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -3 - dataLoadDelayDays));
day4 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -4 - dataLoadDelayDays));
day5 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -5 - dataLoadDelayDays));
day6 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -6 - dataLoadDelayDays));
day7 := pastWeek (Date_Of_Report = ut.date_math(currentDate, -7 - dataLoadDelayDays));
dashes := '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n';
STRING padNumber (STRING number, BOOLEAN exist) := MAP(exist = FALSE 																	=> ' \t\t|',
																												LENGTH(number) >= 0 AND LENGTH(number) <= 5 	=> ' ' + number + '\t\t|',
																												LENGTH(number) >= 6 AND LENGTH(number) <= 12 	=> ' ' + number + '\t|',
																												LENGTH(number) >= 13 AND LENGTH(number) <= 13 => ' ' + number + '|',
																																																					number + '|');

genRowRound (field) := MACRO
	padNumber((STRING)day1[1].field, EXISTS(day1)) + 
	padNumber((STRING)day2[1].field, EXISTS(day2)) + 
	padNumber((STRING)day3[1].field, EXISTS(day3)) + 
	padNumber((STRING)day4[1].field, EXISTS(day4)) + 
	padNumber((STRING)day5[1].field, EXISTS(day5)) + 
	padNumber((STRING)day6[1].field, EXISTS(day6)) + 
	padNumber((STRING)day7[1].field, EXISTS(day7)) + 
	padNumber((STRING)firstRun[1].field, EXISTS(firstRun)) + 
	padNumber((STRING)ROUND(AVE(firstRun, firstRun.field)), EXISTS(firstRun)) + '\n' +
	dashes
ENDMACRO;

genRowPercent (field) := MACRO
	padNumber((STRING)day1[1].field, EXISTS(day1)) + 
	padNumber((STRING)day2[1].field, EXISTS(day2)) + 
	padNumber((STRING)day3[1].field, EXISTS(day3)) + 
	padNumber((STRING)day4[1].field, EXISTS(day4)) + 
	padNumber((STRING)day5[1].field, EXISTS(day5)) + 
	padNumber((STRING)day6[1].field, EXISTS(day6)) + 
	padNumber((STRING)day7[1].field, EXISTS(day7)) + 
	padNumber((STRING)firstRun[1].field, EXISTS(firstRun)) + 
	padNumber((STRING)(DECIMAL6_3)AVE(firstRun, firstRun.field), EXISTS(firstRun)) + '\n' +
	dashes
ENDMACRO;

emailBody := 
'RiskView Daily Score Monitor' + '\n\n' +
'Records Date: ' + (STRING)ut.date_math(currentDate, -1 - dataLoadDelayDays) + '\n' +
'Report Run Date: ' + (STRING)currentDate + '\n' +
'Previous Run Date: ' + (STRING)comboFile[1].Date_Report_Was_Run + '\n\n' +
'\t\t\t\t\t| ' + (STRING)ut.date_math(currentDate, -1 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -2 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -3 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -4 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -5 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -6 - dataLoadDelayDays) + '\t| ' + 
(STRING)ut.date_math(currentDate, -7 - dataLoadDelayDays) + '\t| 1st-' + 
firstRun[1].Date_Of_Report + '\t| ' +
'All Time Average\n' +
dashes +
'Total Number of Transactions\t\t|' + genRowRound(Total_Number_Of_Transactions) +
'Total Number of Model Scores\t\t|' + genRowRound(Total_Number_Of_Model_Scores) +
'Number of Unique Account IDs\t\t|' + genRowRound(Number_Of_Unique_Account_IDs_Transacted) +
'% First Name Populated\t\t|' + genRowPercent(Percent_First_Name_Populated) +
'% Last Name Populated\t\t|' + genRowPercent(Percent_Last_Name_Populated) +
'% SSN Populated\t\t\t|' + genRowPercent(Percent_SSN_Populated) +
'% Date of Birth Populated\t\t|' + genRowPercent(Percent_DOB_Populated) +
'% Address Populated\t\t\t|' + genRowPercent(Percent_Address_Populated) +
'% City Populated\t\t\t|' + genRowPercent(Percent_City_Populated) +
'% State Populated\t\t\t|' + genRowPercent(Percent_State_Populated) +
'% Zip Code Populated\t\t\t|' + genRowPercent(Percent_Zip_Populated) +
'% Drivers License Populated\t\t|' + genRowPercent(Percent_DL_Populated) +
'% Home Phone Populated\t\t|' + genRowPercent(Percent_Home_Phone_Populated) +
'% Scored 100\t\t\t\t|' + genRowPercent(Percent_Scored_100) +
'% Scored 101\t\t\t\t|' + genRowPercent(Percent_Scored_101) +
'% Scored 102\t\t\t\t|' + genRowPercent(Percent_Scored_102) +
'% Scored 103\t\t\t\t|' + genRowPercent(Percent_Scored_103) +
'% Scored 104\t\t\t\t|' + genRowPercent(Percent_Scored_104) +
'% Scored 200\t\t\t\t|' + genRowPercent(Percent_Scored_200) +
'% Scored 222\t\t\t\t|' + genRowPercent(Percent_Scored_222) +
'% Scored Between 501 - 540\t\t|' + genRowPercent(Percent_Scored_Between_501_540) +
'% Scored Between 541 - 580\t\t|' + genRowPercent(Percent_Scored_Between_541_580) +
'% Scored Between 581 - 620\t\t|' + genRowPercent(Percent_Scored_Between_581_620) +
'% Scored Between 621 - 660\t\t|' + genRowPercent(Percent_Scored_Between_621_660) +
'% Scored Between 661 - 700\t\t|' + genRowPercent(Percent_Scored_Between_661_700) +
'% Scored Between 701 - 740\t\t|' + genRowPercent(Percent_Scored_Between_701_740) +
'% Scored Between 741 - 780\t\t|' + genRowPercent(Percent_Scored_Between_741_780) +
'% Scored Between 781 - 820\t\t|' + genRowPercent(Percent_Scored_Between_781_820) +
'% Scored Between 821 - 860\t\t|' + genRowPercent(Percent_Scored_Between_821_860) +
'% Scored Between 861 - 900\t\t|' + genRowPercent(Percent_Scored_Between_861_900) +
'% Scored Above 900\t\t\t|' + genRowPercent(Percent_Scored_Above_900) +
'% Scored Below 100\t\t\t|' + genRowPercent(Percent_Scored_Below_100) +
'% Average Score Excluding Exceptions\t|' + genRowRound(Average_Score_Excluding_Exceptions) +
'% Returned Reason Code 01\t\t|' + genRowPercent(Percent_RC_01) +
'% Returned Reason Code 02\t\t|' + genRowPercent(Percent_RC_02) +
'% Returned Reason Code 03\t\t|' + genRowPercent(Percent_RC_03) +
'% Returned Reason Code 04\t\t|' + genRowPercent(Percent_RC_04) +
'% Returned Reason Code 05\t\t|' + genRowPercent(Percent_RC_05) +
'% Returned Reason Code 06\t\t|' + genRowPercent(Percent_RC_06) +
'% Returned Reason Code 07\t\t|' + genRowPercent(Percent_RC_07) +
'% Returned Reason Code 08\t\t|' + genRowPercent(Percent_RC_08) +
'% Returned Reason Code 09\t\t|' + genRowPercent(Percent_RC_09) +
'% Returned Reason Code 10\t\t|' + genRowPercent(Percent_RC_10) +
'% Returned Reason Code 11\t\t|' + genRowPercent(Percent_RC_11) +
'% Returned Reason Code 12\t\t|' + genRowPercent(Percent_RC_12) +
'% Returned Reason Code 13\t\t|' + genRowPercent(Percent_RC_13) +
'% Returned Reason Code 14\t\t|' + genRowPercent(Percent_RC_14) +
'% Returned Reason Code 15\t\t|' + genRowPercent(Percent_RC_15) +
'% Returned Reason Code 16\t\t|' + genRowPercent(Percent_RC_16) +
'% Returned Reason Code 17\t\t|' + genRowPercent(Percent_RC_17) +
'% Returned Reason Code 19\t\t|' + genRowPercent(Percent_RC_19) +
'% Returned Reason Code 20\t\t|' + genRowPercent(Percent_RC_20) +
'% Returned Reason Code 21\t\t|' + genRowPercent(Percent_RC_21) +
'% Returned Reason Code 22\t\t|' + genRowPercent(Percent_RC_22) +
'% Returned Reason Code 23\t\t|' + genRowPercent(Percent_RC_23) +
'% Returned Reason Code 24\t\t|' + genRowPercent(Percent_RC_24) +
'% Returned Reason Code 25\t\t|' + genRowPercent(Percent_RC_25) +
'% Returned Reason Code 26\t\t|' + genRowPercent(Percent_RC_26) +
'% Returned Reason Code 27\t\t|' + genRowPercent(Percent_RC_27) +
'% Returned Reason Code 28\t\t|' + genRowPercent(Percent_RC_28) +
'% Returned Reason Code 29\t\t|' + genRowPercent(Percent_RC_29) +
'% Returned Reason Code 30\t\t|' + genRowPercent(Percent_RC_30) +
'% Returned Reason Code 31\t\t|' + genRowPercent(Percent_RC_31) +
'% Returned Reason Code 32\t\t|' + genRowPercent(Percent_RC_32) +
'% Returned Reason Code 33\t\t|' + genRowPercent(Percent_RC_33) +
'% Returned Reason Code 34\t\t|' + genRowPercent(Percent_RC_34) +
'% Returned Reason Code 35\t\t|' + genRowPercent(Percent_RC_35) +
'% Returned Reason Code 36\t\t|' + genRowPercent(Percent_RC_36) +
'% Returned Reason Code 37\t\t|' + genRowPercent(Percent_RC_37) +
'% Returned Reason Code 38\t\t|' + genRowPercent(Percent_RC_38) +
'% Returned Reason Code 39\t\t|' + genRowPercent(Percent_RC_39) +
'% Returned Reason Code 40\t\t|' + genRowPercent(Percent_RC_40) +
'% Returned Reason Code 41\t\t|' + genRowPercent(Percent_RC_41) +
'% Returned Reason Code 42\t\t|' + genRowPercent(Percent_RC_42) +
'% Returned Reason Code 43\t\t|' + genRowPercent(Percent_RC_43) +
'% Returned Reason Code 44\t\t|' + genRowPercent(Percent_RC_44) +
'% Returned Reason Code 45\t\t|' + genRowPercent(Percent_RC_45) +
'% Returned Reason Code 46\t\t|' + genRowPercent(Percent_RC_46) +
'% Returned Reason Code 47\t\t|' + genRowPercent(Percent_RC_47) +
'% Returned Reason Code 48\t\t|' + genRowPercent(Percent_RC_48) +
'% Returned Reason Code 49\t\t|' + genRowPercent(Percent_RC_49) +
'% Returned Reason Code 50\t\t|' + genRowPercent(Percent_RC_50) +
'% Returned Reason Code 51\t\t|' + genRowPercent(Percent_RC_51) +
'% Returned Reason Code 52\t\t|' + genRowPercent(Percent_RC_52) +
'% Returned Reason Code 53\t\t|' + genRowPercent(Percent_RC_53) +
'% Returned Reason Code 54\t\t|' + genRowPercent(Percent_RC_54) +
'% Returned Reason Code 55\t\t|' + genRowPercent(Percent_RC_55) +
'% Returned Reason Code 56\t\t|' + genRowPercent(Percent_RC_56) +
'% Returned Reason Code 57\t\t|' + genRowPercent(Percent_RC_57) +
'% Returned Reason Code 58\t\t|' + genRowPercent(Percent_RC_58) +
'% Returned Reason Code 59\t\t|' + genRowPercent(Percent_RC_59) +
'% Returned Reason Code 5Q\t\t|' + genRowPercent(Percent_RC_5Q) +
'% Returned Reason Code 60\t\t|' + genRowPercent(Percent_RC_60) +
'% Returned Reason Code 61\t\t|' + genRowPercent(Percent_RC_61) +
'% Returned Reason Code 62\t\t|' + genRowPercent(Percent_RC_62) +
'% Returned Reason Code 63\t\t|' + genRowPercent(Percent_RC_63) +
'% Returned Reason Code 64\t\t|' + genRowPercent(Percent_RC_64) +
'% Returned Reason Code 65\t\t|' + genRowPercent(Percent_RC_65) +
'% Returned Reason Code 66\t\t|' + genRowPercent(Percent_RC_66) +
'% Returned Reason Code 67\t\t|' + genRowPercent(Percent_RC_67) +
'% Returned Reason Code 68\t\t|' + genRowPercent(Percent_RC_68) +
'% Returned Reason Code 69\t\t|' + genRowPercent(Percent_RC_69) +
'% Returned Reason Code 70\t\t|' + genRowPercent(Percent_RC_70) +
'% Returned Reason Code 71\t\t|' + genRowPercent(Percent_RC_71) +
'% Returned Reason Code 72\t\t|' + genRowPercent(Percent_RC_72) +
'% Returned Reason Code 73\t\t|' + genRowPercent(Percent_RC_73) +
'% Returned Reason Code 74\t\t|' + genRowPercent(Percent_RC_74) +
'% Returned Reason Code 75\t\t|' + genRowPercent(Percent_RC_75) +
'% Returned Reason Code 76\t\t|' + genRowPercent(Percent_RC_76) +
'% Returned Reason Code 77\t\t|' + genRowPercent(Percent_RC_77) +
'% Returned Reason Code 78\t\t|' + genRowPercent(Percent_RC_78) +
'% Returned Reason Code 79\t\t|' + genRowPercent(Percent_RC_79) +
'% Returned Reason Code 80\t\t|' + genRowPercent(Percent_RC_80) +
'% Returned Reason Code 81\t\t|' + genRowPercent(Percent_RC_81) +
'% Returned Reason Code 82\t\t|' + genRowPercent(Percent_RC_82) +
'% Returned Reason Code 83\t\t|' + genRowPercent(Percent_RC_83) +
'% Returned Reason Code 84\t\t|' + genRowPercent(Percent_RC_84) +
'% Returned Reason Code 85\t\t|' + genRowPercent(Percent_RC_85) +
'% Returned Reason Code 86\t\t|' + genRowPercent(Percent_RC_86) +
'% Returned Reason Code 87\t\t|' + genRowPercent(Percent_RC_87) +
'% Returned Reason Code 88\t\t|' + genRowPercent(Percent_RC_88) +
'% Returned Reason Code 89\t\t|' + genRowPercent(Percent_RC_89) +
'% Returned Reason Code 90\t\t|' + genRowPercent(Percent_RC_90) +
'% Returned Reason Code 91\t\t|' + genRowPercent(Percent_RC_91) +
'% Returned Reason Code 92\t\t|' + genRowPercent(Percent_RC_92) +
'% Returned Reason Code 93\t\t|' + genRowPercent(Percent_RC_93) +
'% Returned Reason Code 94\t\t|' + genRowPercent(Percent_RC_94) +
'% Returned Reason Code 95\t\t|' + genRowPercent(Percent_RC_95) +
'% Returned Reason Code 96\t\t|' + genRowPercent(Percent_RC_96) +
'% Returned Reason Code 97\t\t|' + genRowPercent(Percent_RC_97) +
'% Returned Reason Code 98\t\t|' + genRowPercent(Percent_RC_98) +
'% Returned Reason Code 99\t\t|' + genRowPercent(Percent_RC_99) +
'% Returned Reason Code 9A\t\t|' + genRowPercent(Percent_RC_9A) +
'% Returned Reason Code 9B\t\t|' + genRowPercent(Percent_RC_9B) +
'% Returned Reason Code 9C\t\t|' + genRowPercent(Percent_RC_9C) +
'% Returned Reason Code 9D\t\t|' + genRowPercent(Percent_RC_9D) +
'% Returned Reason Code 9E\t\t|' + genRowPercent(Percent_RC_9E) +
'% Returned Reason Code 9F\t\t|' + genRowPercent(Percent_RC_9F) +
'% Returned Reason Code 9G\t\t|' + genRowPercent(Percent_RC_9G) +
'% Returned Reason Code 9H\t\t|' + genRowPercent(Percent_RC_9H) +
'% Returned Reason Code 9I\t\t|' + genRowPercent(Percent_RC_9I) +
'% Returned Reason Code 9J\t\t|' + genRowPercent(Percent_RC_9J) +
'% Returned Reason Code 9K\t\t|' + genRowPercent(Percent_RC_9K) +
'% Returned Reason Code 9L\t\t|' + genRowPercent(Percent_RC_9L) +
'% Returned Reason Code 9M\t\t|' + genRowPercent(Percent_RC_9M) +
'% Returned Reason Code 9N\t\t|' + genRowPercent(Percent_RC_9N) +
'% Returned Reason Code 9O\t\t|' + genRowPercent(Percent_RC_9O) +
'% Returned Reason Code 9P\t\t|' + genRowPercent(Percent_RC_9P) +
'% Returned Reason Code 9Q\t\t|' + genRowPercent(Percent_RC_9Q) +
'% Returned Reason Code 9R\t\t|' + genRowPercent(Percent_RC_9R) +
'% Returned Reason Code 9S\t\t|' + genRowPercent(Percent_RC_9S) +
'% Returned Reason Code 9T\t\t|' + genRowPercent(Percent_RC_9T) +
'% Returned Reason Code 9U\t\t|' + genRowPercent(Percent_RC_9U) +
'% Returned Reason Code 9V\t\t|' + genRowPercent(Percent_RC_9V) +
'% Returned Reason Code 9W\t\t|' + genRowPercent(Percent_RC_9W) +
'% Returned Reason Code 9X\t\t|' + genRowPercent(Percent_RC_9X) +
'% Returned Reason Code A0\t\t|' + genRowPercent(Percent_RC_A0) +
'% Returned Reason Code A1\t\t|' + genRowPercent(Percent_RC_A1) +
'% Returned Reason Code A2\t\t|' + genRowPercent(Percent_RC_A2) +
'% Returned Reason Code A3\t\t|' + genRowPercent(Percent_RC_A3) +
'% Returned Reason Code A4\t\t|' + genRowPercent(Percent_RC_A4) +
'% Returned Reason Code A5\t\t|' + genRowPercent(Percent_RC_A5) +
'% Returned Reason Code A6\t\t|' + genRowPercent(Percent_RC_A6) +
'% Returned Reason Code A7\t\t|' + genRowPercent(Percent_RC_A7) +
'% Returned Reason Code A8\t\t|' + genRowPercent(Percent_RC_A8) +
'% Returned Reason Code A9\t\t|' + genRowPercent(Percent_RC_A9) +
'% Returned Reason Code B0\t\t|' + genRowPercent(Percent_RC_B0) +
'% Returned Reason Code BO\t\t|' + genRowPercent(Percent_RC_BO) +
'% Returned Reason Code CL\t\t|' + genRowPercent(Percent_RC_CL) +
'% Returned Reason Code CO\t\t|' + genRowPercent(Percent_RC_CO) +
'% Returned Reason Code CR\t\t|' + genRowPercent(Percent_RC_CR) +
'% Returned Reason Code CZ\t\t|' + genRowPercent(Percent_RC_CZ) +
'% Returned Reason Code DD\t\t|' + genRowPercent(Percent_RC_DD) +
'% Returned Reason Code DF\t\t|' + genRowPercent(Percent_RC_DF) +
'% Returned Reason Code DM\t\t|' + genRowPercent(Percent_RC_DM) +
'% Returned Reason Code DV\t\t|' + genRowPercent(Percent_RC_DV) +
'% Returned Reason Code EV\t\t|' + genRowPercent(Percent_RC_EV) +
'% Returned Reason Code FB\t\t|' + genRowPercent(Percent_RC_FB) +
'% Returned Reason Code FM\t\t|' + genRowPercent(Percent_RC_FM) +
'% Returned Reason Code FQ\t\t|' + genRowPercent(Percent_RC_FQ) +
'% Returned Reason Code FR\t\t|' + genRowPercent(Percent_RC_FR) +
'% Returned Reason Code FV\t\t|' + genRowPercent(Percent_RC_FV) +
'% Returned Reason Code IA\t\t|' + genRowPercent(Percent_RC_IA) +
'% Returned Reason Code IB\t\t|' + genRowPercent(Percent_RC_IB) +
'% Returned Reason Code IC\t\t|' + genRowPercent(Percent_RC_IC) +
'% Returned Reason Code ID\t\t|' + genRowPercent(Percent_RC_ID) +
'% Returned Reason Code IE\t\t|' + genRowPercent(Percent_RC_IE) +
'% Returned Reason Code IF\t\t|' + genRowPercent(Percent_RC_IF) +
'% Returned Reason Code IG\t\t|' + genRowPercent(Percent_RC_IG) +
'% Returned Reason Code IH\t\t|' + genRowPercent(Percent_RC_IH) +
'% Returned Reason Code II\t\t|' + genRowPercent(Percent_RC_II) +
'% Returned Reason Code IJ\t\t|' + genRowPercent(Percent_RC_IJ) +
'% Returned Reason Code IK\t\t|' + genRowPercent(Percent_RC_IK) +
'% Returned Reason Code IS\t\t|' + genRowPercent(Percent_RC_IS) +
'% Returned Reason Code IT\t\t|' + genRowPercent(Percent_RC_IT) +
'% Returned Reason Code MI\t\t|' + genRowPercent(Percent_RC_MI) +
'% Returned Reason Code MN\t\t|' + genRowPercent(Percent_RC_MN) +
'% Returned Reason Code MO\t\t|' + genRowPercent(Percent_RC_MO) +
'% Returned Reason Code MS\t\t|' + genRowPercent(Percent_RC_MS) +
'% Returned Reason Code PA\t\t|' + genRowPercent(Percent_RC_PA) +
'% Returned Reason Code PO\t\t|' + genRowPercent(Percent_RC_PO) +
'% Returned Reason Code PV\t\t|' + genRowPercent(Percent_RC_PV) +
'% Returned Reason Code RS\t\t|' + genRowPercent(Percent_RC_RS) +
'% Returned Reason Code SR\t\t|' + genRowPercent(Percent_RC_SR) +
'% Returned Reason Code U1\t\t|' + genRowPercent(Percent_RC_U1) +
'% Returned Reason Code U2\t\t|' + genRowPercent(Percent_RC_U2) +
'% Returned Reason Code WL\t\t|' + genRowPercent(Percent_RC_WL) +
'% Returned Reason Code ZI\t\t|' + genRowPercent(Percent_RC_ZI) +
'\n\n' +
'';

OUTPUT(emailBody, NAMED('E_Mail_Body'));
// End of body generation

subject := 'RiskView Daily Score Monitor';

// Now send out the e-mails.  If this is the first of the month, attach the report.  If not just send the normal email.
#IF(%firstOfMonth%)
FileServices.SendEmailAttachData(Risk_Reporting.Constants.emailRiskViewReportsTo, subject,
																		emailBody,
																		(DATA)attachment,
																		'text/csv',
																		'RiskView - ' + TRIM(Risk_Reporting.Constants.month((UNSIGNED1)((STRING)ut.date_math(currentDate, -1)[5..6]))) + ', ' + ((STRING)ut.date_math(currentDate, -1)[1..4]) + ' Report.csv',
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');
#ELSE
FileServices.SendEmail(Risk_Reporting.Constants.emailRiskViewReportsTo, subject,
																		emailBody,
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');		
#END