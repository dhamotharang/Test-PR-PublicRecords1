/*
	Author: 		Vaani Chikte
	Date:   		08/12/2020
	Revision:		1.0
	Purpose:		Declare new base layout with additional fields for Delta update
	Requirements:   Should contain all the fields in the input dataset plus additional fields.
*/
import dx_common;

EXPORT Layout_Banko_Base := RECORD
QSTRING1  	DRActivityTypeCode;
STRING100 	DocketEntryID;
STRING10  	CourtID;
STRING7  	  CaseKey;
STRING2     CaseType;	
STRING24  	BKCaseNumber;
STRING200 	BKCaseNumberURL;
STRING24  	ProceedingsCaseNumber ;
STRING200 	ProceedingsCaseNumberURL;
STRING10  	CaseID ;
STRING10  	PacerCaseID ;
STRING200 	AttachmentURL;
STRING10  	EntryNumber;
STRING24  	EnteredDate;
STRING24  	Pacer_EnteredDate;
STRING24  	FiledDate;
STRING5   	Score ;
STRING5   	DRCategoryEventID;
STRING5000  DocketText;	
STRING5     court_code;	
STRING40    district;	
STRING5     boca_court;	
STRING200   CatEvent_Description;	
STRING200   CatEvent_Category;	
//New Fields DF-27858 will be used for Azure Delta updates	
dx_common.layout_metadata;	

END;

