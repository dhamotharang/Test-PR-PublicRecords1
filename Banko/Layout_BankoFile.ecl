/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		This is the original RECORD layout of the CSV file which was sprayed to thor
	Requirements:   Should contain all the fields in the dataset.
*/


export Layout_BankoFile := RECORD

QSTRING  	_DRActivityTypeCode;
STRING  	_DocketEntryID;
STRING  	_CourtID;
STRING   	_CaseKey;
STRING   	_CaseType;
STRING   	_BKCaseNumber;
STRING 		_BKCaseNumberURL;
STRING  	_ProceedingsCaseNumber;
STRING 		_ProceedingsCaseNumberURL;
STRING  	_CaseID;
STRING  	_PacerCaseID;
STRING 		_AttachmentURL;
STRING  	_EntryNumber;
STRING  	_EnteredDate;
STRING  	_FiledDate;
STRING   	_Score;
STRING   	_DRCategoryEventID;
STRING5000	_DocketText;
END;