/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		Declares an attribute definition, for the payload, two fields are added to the
					orginal attribute definition, court_code and Cat_Event.
					If more attributes are needed, add here ,and define in BWR_Banko_JoinCaseIDCourtID
					
	Requirements:   N/A
*/

export BankoJoinRecord := RECORD
Layout_BankoFile_FixedRec.DRActivityTypeCode;
Layout_BankoFile_FixedRec.DocketEntryID;
Layout_BankoFile_FixedRec.CourtID;
Layout_BankoFile_FixedRec.CaseKey;
Layout_BankoFile_FixedRec.CaseType;
Layout_BankoFile_FixedRec.BKCaseNumber;
Layout_BankoFile_FixedRec.BKCaseNumberURL;
Layout_BankoFile_FixedRec.ProceedingsCaseNumber ;
Layout_BankoFile_FixedRec.ProceedingsCaseNumberURL;
Layout_BankoFile_FixedRec.CaseID ;
Layout_BankoFile_FixedRec.PacerCaseID ;
Layout_BankoFile_FixedRec.AttachmentURL;
Layout_BankoFile_FixedRec.EntryNumber;
Layout_BankoFile_FixedRec.EnteredDate;
Layout_BankoFile_FixedRec.Pacer_EnteredDate;
Layout_BankoFile_FixedRec.FiledDate;
Layout_BankoFile_FixedRec.Score ;
Layout_BankoFile_FixedRec.DRCategoryEventID;
Layout_BankoFile_FixedRec.DocketText;
STRING5 court_code;
STRING40 district;
STRING5 boca_court;
STRING200 CatEvent_Description;
STRING200 CatEvent_Category;
END;