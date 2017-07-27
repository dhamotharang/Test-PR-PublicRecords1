/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		We create a FIXED LENGTH dataset from the CSV dataset previously created
	Requirements:   Should contain all the fields in the dataset.
*/


//Define the new fixed length as per the specs
Layout_OutRec_BankoFile_temp := Record
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
STRING24  	FiledDate;
STRING5   	Score ;
STRING5   	DRCategoryEventID;
STRING5000  DocketText;
STRING24  	Pacer_EnteredDate;
END;


//Uses a transform to set each attribute to its fixed length
Layout_OutRec_BankoFile_temp reformat(Layout_BankoFile l) := transform
self.DRActivityTypeCode 		:= l._DRActivityTypeCode;
self.DocketEntryID      		:= l._DocketEntryID;
self.CourtID    				:= l._CourtID;
self.CaseKey 					:= l._CaseKey[1..2]+l._CaseKey[4..8];
self.CaseType    				:= l._CaseType;
self.BKCaseNumber 				:= l._BKCaseNumber;
self.BKCaseNumberURL 			:= l._BKCaseNumberURL;
self.ProceedingsCaseNumber 		:= l._ProceedingsCaseNumber;
self.ProceedingsCaseNumberURL 	:= l._ProceedingsCaseNumberURL;
self.CaseID 					:= l._CaseID;
self.PacerCaseID 				:= l._PacerCaseID;
self.AttachmentURL 				:= l._AttachmentURL;
self.EntryNumber 				:= l._EntryNumber;
self.EnteredDate 				:= '';
self.Pacer_EnteredDate			:= l._EnteredDate[5..8]+l._EnteredDate[1..2]+l._EnteredDate[3..4]+l._EnteredDate[9..14];
self.FiledDate 					:= l._FiledDate[5..8]+l._FiledDate[1..2]+l._FiledDate[3..4];
self.Score 						:= l._Score;
self.DRCategoryEventID 			:= l._DRCategoryEventID;
self.DocketText 				:= l._DocketText;
end;

export Layout_BankoFile_FixedRec := project(Banko_FileDataset,reformat(left));

