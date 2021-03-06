#workunit('name', 'PremiseAssociation_Pull_SAOT_Logs');

IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT;

BeginDate := '20140701';
EndDate := '20140730';

AccountIDs := ['118436']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids
// AccountIDs := ['']; // Set to a blank string dataset [''] to pull all records except for test transaction login ids

companyNameFilter := ''; // Set to BLANK '' to not filter by company name.  This filter is typically only needed for companies such as Experian who resell our products.
// companyNameFilter := StringLib.StringToUpperCase('DIRECTV'); // Set to BLANK '' to not filter by company name.  This filter is typically only needed for companies such as Experian who resell our products.

outputFile := '~bpahl::out::PremiseAssoc_SAOT_' + BeginDate + '-' + EndDate + '_' + AccountIDs[1];

eyeball := 100;

/* ***********************************************************************************************
 *************************************************************************************************
 *             GATHER AND PARSE SCORE AND ATTRIBUTE OUTCOME TRACKING LOGS                        *
 *************************************************************************************************
 *********************************************************************************************** */

LogFile := Score_Logs.Key_ScoreLogs_XMLTransactionID;

LogsRaw := DISTRIBUTE(PULL(LogFile (StringLib.StringToUpperCase(TRIM(Product)) IN ['PREMISEASSOCIATION'] AND datetime[1..8] BETWEEN BeginDate AND EndDate AND customer_id IN AccountIDs)));

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
parsedInput := DISTRIBUTE(PARSE(Logs, inputxml, parseInput(), XML('PremiseAssociation')), HASH64(TransactionID));

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
parsedRecordsTemp := JOIN(DISTRIBUTE(parsedInput, HASH64(TransactionID)), DISTRIBUTE(parsedOutput, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, combineParsedRecords(LEFT, RIGHT), KEEP(1), ATMOST(RiskWise.max_atmost), LOCAL);

parsedRecords := JOIN(DISTRIBUTE(parsedRecordsTemp, HASH64(TransactionID)), DISTRIBUTE(Logs, HASH64(TransactionID)), LEFT.TransactionID = RIGHT.TransactionID, TRANSFORM(RECORDOF(LEFT), SELF.TransactionDate := RIGHT.TransactionDate; SELF.AccountID := RIGHT.AccountID; SELF := LEFT), LOCAL);

OUTPUT(CHOOSEN(parsedRecords, eyeball), NAMED('Sample_Fully_Parsed_Records'));
OUTPUT(COUNT(parsedRecords), NAMED('Total_Fully_Parsed_Records'));

finalRecords := SORT(DISTRIBUTE(parsedRecords, HASH64(TransactionDate)), TransactionDate, LOCAL);
OUTPUT(CHOOSEN(finalRecords, eyeball), NAMED('Sample_Final_Records'));

OUTPUT(finalRecords,, outputFile + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);

#if(companyNameFilter = '')
#else
	companyFilteredRecords := finalRecords (StringLib.StringToUpperCase(CompanyName) = companyNameFilter);
	OUTPUT(COUNT(companyFilteredRecords), NAMED('Total_Company_Records'));
	OUTPUT(companyFilteredRecords,, outputFile + '_' + companyNameFilter + '_' + ThorLib.Wuid() + '.csv', CSV(HEADING(single), QUOTE('"')), EXPIRE(30), OVERWRITE);
#end

/* ***********************************************************************************************
 *************************************************************************************************
 *             MODIFY EVERYTHING BELOW AS NEEDED TO PERFORM SAOT ANALYSIS                        *
 *************************************************************************************************
 *********************************************************************************************** */