#workunit('name', 'PremiseAssociation_Daily_Monitor');

#option('allowedClusters', 'thor400_20,thor400_30,thor400_60'); // This workunit can run on these clusters
#option('AllowAutoSwitchQueue', TRUE); // If the current queue is full, use an available cluster from above

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

// Pull logs for the past year to do our rolling Average on
EndDate := ut.GetDate;
BeginDateTemp := ut.date_math(EndDate, -365);
BeginDate := IF(BeginDateTemp >= '20140815', BeginDateTemp, '20140815'); // Tracking didn't fully start until this date, eliminate the "test" days before this date.

eyeball := 100;

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

LogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['PREMISEASSOCIATION'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND StringLib.StringToLowerCase(TRIM(login_id)) NOT IN Risk_Reporting.Constants.IgnoredLogins AND customer_id NOT IN Risk_Reporting.Constants.IgnoredAccountIDs)));

// In order to join the parsed input and output together I need to force the transaction id into the inputxml, and I needed a root XML node for the outputxml.  This seemed like the most reasonable way to do that.
Logs := PROJECT(LogsRaw, TRANSFORM({RECORDOF(LogsRaw), STRING30 TransactionID, STRING10 AccountID, STRING8 TransactionDate}, 
				SELF.inputxml := StringLib.StringFindReplace(LEFT.inputxml, '<PremiseAssociation>', '<PremiseAssociation><TransactionId>' + LEFT.Transaction_Id + '</TransactionId>'); 
				SELF.outputxml := '<PremiseAssociation>' + LEFT.outputxml + '</PremiseAssociation>';
				SELF.TransactionID := LEFT.Transaction_ID;
				SELF.AccountID := LEFT.customer_id;
				SELF.TransactionDate := LEFT.DateTime[1..8];
				SELF := LEFT));
				
OUTPUT(CHOOSEN(Logs, eyeball), NAMED('Sample_Raw_Logs'));

Parsed_Layout := RECORD
	STRING30	TransactionID	:= ''; // Forced into the record so I can join it all together
	STRING10	AccountID			:= '';
	STRING8		TransactionDate := '';
	STRING150	CompanyName		:= '';
	STRING30	FirstName			:= '';
	STRING30	LastName			:= '';
	STRING70	FullName			:= '';
	STRING9		SSN						:= '';
	STRING8		DOB						:= '';
	STRING120	Address				:= '';
	STRING25	City					:= '';
	STRING2		State					:= '';
	STRING9		Zip						:= '';
	STRING10	HomePhone			:= '';
	STRING10	WorkPhone			:= '';
	
	STRING2		AddressReportingSourceIndex			:= '';
	STRING2		AddressReportingHistoryIndex		:= '';
	STRING2		AddressSearchHistoryIndex				:= '';
	STRING2		AddressUtilityHistoryIndex			:= '';
	STRING2		AddressAssociationIndex					:= '';
	STRING2		AddressPropertyTypeIndex				:= '';
	STRING2		AddressValidityIndex						:= '';
	STRING2		RelativesConfirmingAddressIndex	:= '';
	STRING2		AddressAssociationMailAddrIndex	:= '';
	STRING2		PriorAddressMoveIndex						:= '';
	STRING2		PriorResidentMoveIndex					:= '';
	STRING6		AddressDateFirstSeen						:= '';
	STRING6		AddressDateLastSeen							:= '';
	STRING2		OccupancyOverride								:= '';
	STRING2		PremiseAssociationScore					:= '';
END;

Parsed_Layout parseInput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('TransactionId')); // Forced into the record so I can join it all together
	SELF.CompanyName		:= TRIM(XMLTEXT('User/EndUser/CompanyName'));
	SELF.FirstName			:= TRIM(XMLTEXT('SearchBy/Name/First'));
	SELF.LastName				:= TRIM(XMLTEXT('SearchBy/Name/Last'));
	SELF.FullName				:= TRIM(XMLTEXT('SearchBy/Name/Full'));
	SELF.SSN						:= Risk_Reporting.Common.ParseSSN(XMLTEXT('SearchBy/SSN'));
	SELF.DOB						:= TRIM(XMLTEXT('SearchBy/DOB')) + Risk_Reporting.Common.ParseDate(XMLTEXT('SearchBy/DOB/Year'), XMLTEXT('SearchBy/DOB/Month'), XMLTEXT('SearchBy/DOB/Day'));
	SELF.Address				:= Risk_Reporting.Common.ParseAddress(XMLTEXT('SearchBy/Address/StreetAddress1'), XMLTEXT('SearchBy/Address/StreetAddress2'), XMLTEXT('SearchBy/Address/StreetNumber'), XMLTEXT('SearchBy/Address/StreetPreDirection'), XMLTEXT('SearchBy/Address/StreetName'),
															XMLTEXT('SearchBy/Address/StreetSuffix'), XMLTEXT('SearchBy/Address/StreetPostDirection'), XMLTEXT('SearchBy/Address/UnitDesignation'), XMLTEXT('SearchBy/Address/UnitNumber'));
	SELF.City						:= TRIM(XMLTEXT('SearchBy/Address/City'));
	SELF.State					:= TRIM(XMLTEXT('SearchBy/Address/State'));
	SELF.Zip						:= Risk_Reporting.Common.ParseZIP(XMLTEXT('SearchBy/Address/Zip5'));
	SELF.HomePhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/HomePhone'));
	SELF.WorkPhone			:= Risk_Reporting.Common.ParsePhone(XMLTEXT('SearchBy/WorkPhone'));
	
	SELF := [];
END;
parsedInput := PARSE(Logs, inputxml, parseInput(), XML('PremiseAssociation'));

OUTPUT(CHOOSEN(parsedInput, eyeball), NAMED('Sample_Parsed_Input'));

Parsed_Layout_Temp := RECORD
	Parsed_Layout;
END;

Parsed_Layout_Temp parseOutput () := TRANSFORM
	SELF.TransactionID	:= TRIM(XMLTEXT('Header/TransactionId')); // Forced into the record so I can join it all together
	SELF.AddressReportingSourceIndex			:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[1]/Value'));
	SELF.AddressReportingHistoryIndex			:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[2]/Value'));
	SELF.AddressSearchHistoryIndex				:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[3]/Value'));
	SELF.AddressUtilityHistoryIndex				:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[4]/Value'));
	SELF.AddressAssociationIndex					:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[5]/Value'));
	SELF.AddressPropertyTypeIndex					:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[6]/Value'));
	SELF.AddressValidityIndex							:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[7]/Value'));
	SELF.RelativesConfirmingAddressIndex	:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[8]/Value'));
	SELF.AddressAssociationMailAddrIndex	:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[9]/Value'));
	SELF.PriorAddressMoveIndex						:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[10]/Value'));
	SELF.PriorResidentMoveIndex						:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[11]/Value'));
	SELF.AddressDateFirstSeen							:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[12]/Value'));
	SELF.AddressDateLastSeen							:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[13]/Value'));
	SELF.OccupancyOverride								:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[14]/Value'));
	SELF.PremiseAssociationScore					:= TRIM(XMLTEXT('Result/AttributeGroup/Attributes/Attribute[15]/Value'));
	SELF := [];
END;
parsedOutput := PARSE(Logs, outputxml, parseOutput(), XML('PremiseAssociation'));

OUTPUT(CHOOSEN(parsedOutput, eyeball), NAMED('Sample_Parsed_Output'));

Parsed_Layout combineParsedRecords(Parsed_Layout le, Parsed_Layout ri) := TRANSFORM
	SELF.AddressReportingSourceIndex			:= ri.AddressReportingSourceIndex;
	SELF.AddressReportingHistoryIndex			:= ri.AddressReportingHistoryIndex;
	SELF.AddressSearchHistoryIndex				:= ri.AddressSearchHistoryIndex;
	SELF.AddressUtilityHistoryIndex				:= ri.AddressUtilityHistoryIndex;
	SELF.AddressAssociationIndex					:= ri.AddressAssociationIndex;
	SELF.AddressPropertyTypeIndex					:= ri.AddressPropertyTypeIndex;
	SELF.AddressValidityIndex							:= ri.AddressValidityIndex;
	SELF.RelativesConfirmingAddressIndex	:= ri.RelativesConfirmingAddressIndex;
	SELF.AddressAssociationMailAddrIndex	:= ri.AddressAssociationMailAddrIndex;
	SELF.PriorAddressMoveIndex						:= ri.PriorAddressMoveIndex;
	SELF.PriorResidentMoveIndex						:= ri.PriorResidentMoveIndex;
	SELF.AddressDateFirstSeen							:= ri.AddressDateFirstSeen;
	SELF.AddressDateLastSeen							:= ri.AddressDateLastSeen;
	SELF.OccupancyOverride								:= ri.OccupancyOverride;
	SELF.PremiseAssociationScore					:= ri.PremiseAssociationScore;
	SELF := le;
END;

// Join the parsed input/output
parsedRecordsTemp := JOIN(parsedInput, parsedOutput, LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost));

parsedRecords := JOIN(parsedRecordsTemp, Logs, LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT));

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(parsedRecords, TransactionDate);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                                    CALCULATE PERCENTAGES/COUNTS                               *
 *************************************************************************************************
 *********************************************************************************************** */
 
trackingLayout := RECORD
	// General Statistics
	STRING8 Date_Of_Report															:= finalRecords.TransactionDate;
	UNSIGNED8 Total_Number_Of_Transactions							:= COUNT(GROUP);
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted		:= 0;
	
	// Input Population Statistics
	DECIMAL6_3	Percent_First_Name_Populated := (COUNT(GROUP, finalRecords.FirstName <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Last_Name_Populated := (COUNT(GROUP, finalRecords.LastName <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Full_Name_Populated := (COUNT(GROUP, finalRecords.FullName <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_SSN_Populated		:= (COUNT(GROUP, finalRecords.SSN <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_DOB_Populated		:= (COUNT(GROUP, finalRecords.DOB <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Address_Populated:= (COUNT(GROUP, finalRecords.Address <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_City_Populated	:= (COUNT(GROUP, finalRecords.City <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_State_Populated	:= (COUNT(GROUP, finalRecords.State <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Zip_Populated		:= (COUNT(GROUP, finalRecords.Zip <> '') / COUNT(GROUP)) * 100;
	DECIMAL6_3	Percent_Home_Phone_Populated := (COUNT(GROUP, finalRecords.HomePhone <> '') / COUNT(GROUP)) * 100;

	// PremiseAssociationScore Buckets
	DECIMAL6_3	PremiseAssociationScore_0		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 0) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_10		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 10) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_20		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 20) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_30		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 30) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_40		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 40) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_50		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 50) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_60		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 60) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_70		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 70) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_80		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 80) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_90		:= (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore = 90) / COUNT(GROUP)) * 100;
	UNSIGNED2		Average_PremiseAssociationScore	:= ROUND(SUM(GROUP, (INTEGER)finalRecords.PremiseAssociationScore / 10) / COUNT(GROUP)) * 10;
	DECIMAL6_3	PremiseAssociationScore_10_30 := (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore in [10, 20, 30]) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_40_60 := (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore in [40, 50, 60]) / COUNT(GROUP)) * 100;
	DECIMAL6_3	PremiseAssociationScore_70_90 := (COUNT(GROUP, (INTEGER)finalRecords.PremiseAssociationScore in [70, 80, 90]) / COUNT(GROUP)) * 100;

	//OccupanceOverride buckets
	DECIMAL6_3	OccupancyOverride_1		:= (COUNT(GROUP, (INTEGER)finalRecords.OccupancyOverride = 1));

	// DID not found bucket
	DECIMAL6_3	DIDsNotFound					:= (COUNT(GROUP, (INTEGER)finalRecords.AddressReportingSourceIndex = -1));

END;

trackingLayout2 := RECORD 
	STRING8 Date_Of_Report															:= finalRecords.TransactionDate;
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted		:= COUNT(GROUP);
END;

mainStats := TABLE(finalRecords, trackingLayout, TransactionDate);
OUTPUT(CHOOSEN(mainStats, eyeball), NAMED('Main_Stats'));
uniqueIDRecs := DEDUP(SORT(finalRecords, TransactionDate, AccountID), TransactionDate, AccountID);
uniqueIDs := TABLE(uniqueIDRecs, trackingLayout2, TransactionDate);
OUTPUT(CHOOSEN(uniqueIDs, eyeball), NAMED('Unique_IDs'));

stats := JOIN(mainStats, uniqueIDs, LEFT.Date_Of_Report = RIGHT.Date_Of_Report, TRANSFORM(RECORDOF(LEFT), SELF.Number_Of_Unique_Account_IDs_Transacted := RIGHT.Number_Of_Unique_Account_IDs_Transacted; SELF := LEFT)) (Total_Number_Of_Transactions >= 50); // If the total number of transactions for the day is less than 50, assume it's a bad key build

MostRecent := SORT(stats, -Date_Of_Report); // Sort most recent dates to the front
Oldest := SORT(stats, Date_Of_Report);

day1 := MostRecent[1];
day2 := MostRecent[2];
day3 := MostRecent[3];
day4 := MostRecent[4];
day5 := MostRecent[5];
day6 := MostRecent[6];
day7 := MostRecent[7];

OUTPUT(CHOOSEN(MostRecent, eyeball), NAMED('Sample_Stats'));

averageTrackingLayout := RECORD
	// General Statistics
	STRING8 Date_Of_Report := '';							
	UNSIGNED8 Total_Number_Of_Transactions;							
	UNSIGNED8 Number_Of_Unique_Account_IDs_Transacted;		
	
	// Input Population Statistics
	DECIMAL6_3	Percent_First_Name_Populated;
	DECIMAL6_3	Percent_Last_Name_Populated;
	DECIMAL6_3	Percent_Full_Name_Populated;
	DECIMAL6_3	Percent_SSN_Populated;
	DECIMAL6_3	Percent_DOB_Populated;
	DECIMAL6_3	Percent_Address_Populated;
	DECIMAL6_3	Percent_City_Populated;
	DECIMAL6_3	Percent_State_Populated;
	DECIMAL6_3	Percent_Zip_Populated;
	DECIMAL6_3	Percent_Home_Phone_Populated;
	
	// PremiseAssociationScore Buckets
	DECIMAL6_3	PremiseAssociationScore_0;
	DECIMAL6_3	PremiseAssociationScore_10;
	DECIMAL6_3	PremiseAssociationScore_20;
	DECIMAL6_3	PremiseAssociationScore_30;
	DECIMAL6_3	PremiseAssociationScore_40;
	DECIMAL6_3	PremiseAssociationScore_50;
	DECIMAL6_3	PremiseAssociationScore_60;
	DECIMAL6_3	PremiseAssociationScore_70;
	DECIMAL6_3	PremiseAssociationScore_80;
	DECIMAL6_3	PremiseAssociationScore_90;
	UNSIGNED2		Average_PremiseAssociationScore;
	DECIMAL6_3	PremiseAssociationScore_10_30;
	DECIMAL6_3	PremiseAssociationScore_40_60;
	DECIMAL6_3	PremiseAssociationScore_70_90;

	//OccupanceOverride buckets
	UNSIGNED2		OccupancyOverride_1;

	// DID not found bucket
	UNSIGNED2		DIDsNotFound;

END;

rounded (field) := FUNCTIONMACRO
	RETURN(ROUND(AVE(MostRecent, MostRecent.field)));
ENDMACRO;

percented (field) := FUNCTIONMACRO
	RETURN((DECIMAL6_3)AVE(MostRecent, MostRecent.field));
ENDMACRO;

averageTrackingLayout getAverages(ut.ds_oneRecord le) := TRANSFORM
	// General Statistics
	SELF.Date_Of_Report := 'AVERAGE';							
	SELF.Total_Number_Of_Transactions := rounded(Total_Number_Of_Transactions);							
	SELF.Number_Of_Unique_Account_IDs_Transacted := rounded(Number_Of_Unique_Account_IDs_Transacted);		
	
	// Input Population Statistics
	SELF.Percent_First_Name_Populated := percented(Percent_First_Name_Populated);						
	SELF.Percent_Last_Name_Populated := percented(Percent_Last_Name_Populated);							
	SELF.Percent_Full_Name_Populated := percented(Percent_Full_Name_Populated);							
	SELF.Percent_SSN_Populated := percented(Percent_SSN_Populated);		
	SELF.Percent_DOB_Populated := percented(Percent_DOB_Populated);		
	SELF.Percent_Address_Populated := percented(Percent_Address_Populated);
	SELF.Percent_City_Populated := percented(Percent_City_Populated);	
	SELF.Percent_State_Populated := percented(Percent_State_Populated);	
	SELF.Percent_Zip_Populated := percented(Percent_Zip_Populated);		
	SELF.Percent_Home_Phone_Populated := percented(Percent_Home_Phone_Populated);						
	
	// PremiseAssociationScore Bucket Statistics
	SELF.PremiseAssociationScore_0 := percented(PremiseAssociationScore_0);
	SELF.PremiseAssociationScore_10 := percented(PremiseAssociationScore_10);
	SELF.PremiseAssociationScore_20 := percented(PremiseAssociationScore_20);
	SELF.PremiseAssociationScore_30 := percented(PremiseAssociationScore_30);
	SELF.PremiseAssociationScore_40 := percented(PremiseAssociationScore_40);
	SELF.PremiseAssociationScore_50 := percented(PremiseAssociationScore_50);
	SELF.PremiseAssociationScore_60 := percented(PremiseAssociationScore_60);
	SELF.PremiseAssociationScore_70 := percented(PremiseAssociationScore_70);
	SELF.PremiseAssociationScore_80 := percented(PremiseAssociationScore_80);
	SELF.PremiseAssociationScore_90 := percented(PremiseAssociationScore_90);
	SELF.Average_PremiseAssociationScore := rounded(Average_PremiseAssociationScore);
	SELF.PremiseAssociationScore_10_30 := self.PremiseAssociationScore_10 + self.PremiseAssociationScore_20 + self.PremiseAssociationScore_30;
	SELF.PremiseAssociationScore_40_60 := self.PremiseAssociationScore_40 + self.PremiseAssociationScore_50 + self.PremiseAssociationScore_60;
	SELF.PremiseAssociationScore_70_90 := self.PremiseAssociationScore_70 + self.PremiseAssociationScore_80 + self.PremiseAssociationScore_90;
	SELF.OccupancyOverride_1 := rounded(OccupancyOverride_1);
	SELF.DIDsNotFound := rounded(DIDsNotFound);
	
END;

Averaged := PROJECT(ut.ds_oneRecord, getAverages(LEFT))[1];
OUTPUT(Averaged, NAMED('Averages'));

difference (field) := FUNCTIONMACRO
	RETURN(ABS(day1.field - Averaged.field));
ENDMACRO;

averageTrackingLayout getDifferences(ut.ds_oneRecord le) := TRANSFORM
		// General Statistics
	SELF.Date_Of_Report := 'DIFFERS';							
	SELF.Total_Number_Of_Transactions := difference(Total_Number_Of_Transactions);							
	SELF.Number_Of_Unique_Account_IDs_Transacted := difference(Number_Of_Unique_Account_IDs_Transacted);		
	
	// Input Population Statistics
	SELF.Percent_First_Name_Populated := difference(Percent_First_Name_Populated);
	SELF.Percent_Last_Name_Populated := difference(Percent_Last_Name_Populated);	
	SELF.Percent_Full_Name_Populated := difference(Percent_Full_Name_Populated);	
	SELF.Percent_SSN_Populated := difference(Percent_SSN_Populated);
	SELF.Percent_DOB_Populated := difference(Percent_DOB_Populated);
	SELF.Percent_Address_Populated := difference(Percent_Address_Populated);
	SELF.Percent_City_Populated := difference(Percent_City_Populated);
	SELF.Percent_State_Populated := difference(Percent_State_Populated);
	SELF.Percent_Zip_Populated := difference(Percent_Zip_Populated);
	SELF.Percent_Home_Phone_Populated := difference(Percent_Home_Phone_Populated);
	
	// PremiseAssociationScore Bucket Statistics
	SELF.PremiseAssociationScore_0 := difference(PremiseAssociationScore_0);
	SELF.PremiseAssociationScore_10 := difference(PremiseAssociationScore_10);
	SELF.PremiseAssociationScore_20 := difference(PremiseAssociationScore_20);
	SELF.PremiseAssociationScore_30 := difference(PremiseAssociationScore_30);
	SELF.PremiseAssociationScore_40 := difference(PremiseAssociationScore_40);
	SELF.PremiseAssociationScore_50 := difference(PremiseAssociationScore_50);
	SELF.PremiseAssociationScore_60 := difference(PremiseAssociationScore_60);
	SELF.PremiseAssociationScore_70 := difference(PremiseAssociationScore_70);
	SELF.PremiseAssociationScore_80 := difference(PremiseAssociationScore_80);
	SELF.PremiseAssociationScore_90 := difference(PremiseAssociationScore_90);
	SELF.Average_PremiseAssociationScore := difference(Average_PremiseAssociationScore);
	SELF.PremiseAssociationScore_10_30 := difference(PremiseAssociationScore_10_30);
	SELF.PremiseAssociationScore_40_60 := difference(PremiseAssociationScore_40_60);
	SELF.PremiseAssociationScore_70_90 := difference(PremiseAssociationScore_70_90);
	SELF.OccupancyOverride_1 := difference(OccupancyOverride_1);
	SELF.DIDsNotFound := difference(DIDsNotFound);	

END;

Differs := PROJECT(ut.ds_oneRecord, getDifferences(LEFT))[1];

OUTPUT(Differs, NAMED('Differences'));

/* ***********************************************************************************************
 *************************************************************************************************
 *                                        GENERATE E-MAIL BODY                                   *
 *************************************************************************************************
 *********************************************************************************************** */

dashes := '-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n';
STRING padNumber (STRING number, BOOLEAN exist) := MAP(exist = FALSE 	=> ' \t\t|',
				LENGTH(number) >= 0 AND LENGTH(number) <= 5 	=> ' ' + number + '\t\t|',
				LENGTH(number) >= 6 AND LENGTH(number) <= 12 	=> ' ' + number + '\t|',
				LENGTH(number) >= 13 AND LENGTH(number) <= 13 => ' ' + number + '|',
					number + '|');

genRow (field, disablePercent = FALSE, disableDiffers = FALSE) := MACRO
	padNumber((STRING)day1.field + IF(disablePercent = TRUE, '', '%'), day1.Date_Of_Report <> '') + 
	padNumber((STRING)day2.field + IF(disablePercent = TRUE, '', '%'), day2.Date_Of_Report <> '') + 
	padNumber((STRING)day3.field + IF(disablePercent = TRUE, '', '%'), day3.Date_Of_Report <> '') + 
	padNumber((STRING)day4.field + IF(disablePercent = TRUE, '', '%'), day4.Date_Of_Report <> '') + 
	padNumber((STRING)day5.field + IF(disablePercent = TRUE, '', '%'), day5.Date_Of_Report <> '') + 
	padNumber((STRING)Oldest[1].field + IF(disablePercent = TRUE, '', '%'), COUNT(Oldest) > 0) + 
	padNumber((STRING)Averaged.field + IF(disablePercent = TRUE, '', '%'), Averaged.Date_Of_Report <> '') +
	IF(disableDiffers = TRUE, '', padNumber((STRING)Differs.field + IF(disablePercent = TRUE, '', '%'), Differs.Date_Of_Report <> '')) +
	'\n' +
	dashes
ENDMACRO;

potentialProblems (field, fieldName, thresh) := MACRO
	IF(Differs.field >= thresh, fieldName + ':\t' + (STRING)Differs.field + '%\t(' + (STRING)thresh + '% Threshold)\n', '')
ENDMACRO;

emailBody := 
'PremiseAssociation Daily Monitor' + '\n' +
'==================\n' +
'Report Run Date: ' + EndDate + '\n' + 
'SAOT Key Latest Date: ' + day1.Date_Of_Report + '\n\n' +
// Highlight any potential issues at the top of the email, so you don't have to look at the whole thing if you don't want to
'Potential Problems - Percent Change Between ' + day1.Date_Of_Report + ' and Average >= Threshold' + '\n' + 
'===============================================================\n' + 
// potentialProblems(Percent_First_Name_Populated, 'Percent_First_Name_Populated', 1.000) +
// potentialProblems(Percent_Last_Name_Populated, 'Percent_Last_Name_Populated', 1.000) +
// potentialProblems(Percent_SSN_Populated, 'Percent_SSN_Populated', 1.000) +
// potentialProblems(Percent_DOB_Populated, 'Percent_DOB_Populated', 1.000) +
// potentialProblems(Percent_Address_Populated, 'Percent_Address_Populated', 1.000) +
// potentialProblems(Percent_City_Populated, 'Percent_City_Populated', 1.000) +
// potentialProblems(Percent_State_Populated, 'Percent_State_Populated', 1.000) +
// potentialProblems(Percent_Zip_Populated, 'Percent_Zip_Populated', 1.000) +
// potentialProblems(Percent_DL_Populated, 'Percent_DL_Populated', 1.000) +
// potentialProblems(Percent_Home_Phone_Populated, 'Percent_Home_Phone_Populated', 1.000) +
potentialProblems(PremiseAssociationScore_0, 'PremiseAssociationScore_0', Risk_Reporting.Constants.ThreshPercent_PremiseAssociationScore_00) +
potentialProblems(PremiseAssociationScore_10_30, 'PremiseAssociationScore_10_30', Risk_Reporting.Constants.ThreshPercent_PremiseAssociationScore_10_30) +
potentialProblems(PremiseAssociationScore_40_60, 'PremiseAssociationScore_40_60', Risk_Reporting.Constants.ThreshPercent_PremiseAssociationScore_40_60) +
potentialProblems(PremiseAssociationScore_70_90, 'PremiseAssociationScore_70_90', Risk_Reporting.Constants.ThreshPercent_PremiseAssociationScore_70_90) +
// Generate the table
'\n\nRolling 5 Day Window Stats:\n' +
'=====================\n' +
'\t\t\t\t\t| ' + day1.Date_Of_Report + '\t| ' + 
day2.Date_Of_Report + '\t| ' + 
day3.Date_Of_Report + '\t| ' + 
day4.Date_Of_Report + '\t| ' + 
day5.Date_Of_Report + '\t| ' + 
'1st-' + Oldest[1].Date_Of_Report + '\t| ' +
'1 Year Avg\t| ' +
'% Differ Col 1/Avg\n' +
dashes +
'Total Number of Transactions\t\t|' + genRow(Total_Number_Of_Transactions, TRUE, TRUE) +
'Number of Unique Account IDs\t\t|' + genRow(Number_Of_Unique_Account_IDs_Transacted, TRUE, TRUE) +
'% First Name Populated\t\t|' + genRow(Percent_First_Name_Populated) +
'% Last Name Populated\t\t|' + genRow(Percent_Last_Name_Populated) +
'% Full Name Populated\t\t\t|' + genRow(Percent_Full_Name_Populated) +
'% SSN Populated\t\t\t|' + genRow(Percent_SSN_Populated) +
'% Date of Birth Populated\t\t|' + genRow(Percent_DOB_Populated) +
'% Address Populated\t\t\t|' + genRow(Percent_Address_Populated) +
'% City Populated\t\t\t|' + genRow(Percent_City_Populated) +
'% State Populated\t\t\t|' + genRow(Percent_State_Populated) +
'% Zip Code Populated\t\t\t|' + genRow(Percent_Zip_Populated) +
'% Home Phone Populated\t\t|' + genRow(Percent_Home_Phone_Populated) +
'% PremiseAssociation 00\t\t|' + genRow(PremiseAssociationScore_0) +
'% PremiseAssociation 10\t\t|' + genRow(PremiseAssociationScore_10) +
'% PremiseAssociation 20\t\t|' + genRow(PremiseAssociationScore_20) +
'% PremiseAssociation 30\t\t|' + genRow(PremiseAssociationScore_30) +
'% PremiseAssociation 40\t\t|' + genRow(PremiseAssociationScore_40) +
'% PremiseAssociation 50\t\t|' + genRow(PremiseAssociationScore_50) +
'% PremiseAssociation 60\t\t|' + genRow(PremiseAssociationScore_60) +
'% PremiseAssociation 70\t\t|' + genRow(PremiseAssociationScore_70) +
'% PremiseAssociation 80\t\t|' + genRow(PremiseAssociationScore_80) +
'% PremiseAssociation 90\t\t|' + genRow(PremiseAssociationScore_90) +
'Number of Occupancy Override 1\t|' + genRow(OccupancyOverride_1, true) +
'Number of DIDs Not Found\t\t|' + genRow(DIDsNotFound, true) +
'\n\n' +
'Workunit ' + StringLib.StringToUpperCase(ThorLib.wuid()) + '\n  http://10.173.84.202:8010/?inner=../WsWorkunits/WUInfo?Wuid=' + StringLib.StringToUpperCase(ThorLib.wuid());

OUTPUT(emailBody, NAMED('E_Mail_Body'));


/* ***********************************************************************************************
 *************************************************************************************************
 *                                         SEND THE EMAIL                                        *
 *************************************************************************************************
 *********************************************************************************************** */

subject := 'Premise Association Daily Monitor';

FileServices.SendEmail(Risk_Reporting.Constants.emailPremiseAssociationReportsTo, subject,
																		emailBody,
																		GETENV('SMTPserver'),
																		(UNSIGNED4)GETENV('SMTPport', '25'),
																		'ThorReport@lexisnexis.com');		
