/*
	Author: 		Gavin Witz
	Date:   		05/06/2009
	Revision:		1.1
	Purpose:		To create an INDEX for Court_code and Cat_Event and payload the rest of the info
					from File_Banko_FixedJoinRec.
	Requirements:   N/A
*/
IMPORT ut;
export Key_Banko_courtcode_casenumber(boolean isFCRA = false) := function

key_name := Banko.BuildKeyName(isFCRA);

return INDEX(File_Banko_FixedJoinRec(isFCRA),
					{court_code,casekey,CaseID},
					{DRCategoryEventID,DocketEntryID,CourtID,district,boca_court,CaseKey,CaseType,BKCaseNumber,BKCaseNumberURL
					,ProceedingsCaseNumber,ProceedingsCaseNumberURL,PacerCaseID,AttachmentURL
					,EntryNumber,EnteredDate,Pacer_EnteredDate,FiledDate,Score,DocketText,CatEvent_Description,CatEvent_Category,RecPos},
												key_name);
												
END;