


IMPORT BANKO, Data_services;

export fRemoveDeletes(DATASET(banko.Layout_Banko_Base) ds) := 
function

layout_deletefile := Record
QSTRING1  	DRActivityTypeCode;
STRING10000 	DocketEntryID;
end; 
// thor_data400::in::bankoadditionalevents
Banko_DeleteRecords := dataset(Data_services.foreign_prod+'thor_data400::in::bankoadditionalevents',layout_deletefile,
					CSV(HEADING(0),SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'),MAXLENGTH(100000)))(DRActivityTypeCode='D');

//Layout_BankoFile_FixedRec_EventSort := SORT(Banko_DeleteRecords,DocketEntryID);
//Layout_BankoFile_FixedRec_EventDist := DISTRIBUTE(Layout_BankoFile_FixedRec_EventSort,HASH32(DocketEntryID));

//Banko_Additional_EventSort := SORT(ds,docketentryid);
//Banko_Additional_EventDist := DISTRIBUTE(Banko_Additional_EventSort,HASH32(docketentryid));

banko.Layout_Banko_Base CourtID_C3CourtID_Rec(banko.Layout_Banko_Base L
										,layout_deletefile R) := TRANSFORM
   	
	SELF := L;
	
END;

CourtID_C3CourtID_RecJoin := JOIN(ds,
					Banko_DeleteRecords,
					LEFT.docketentryid = RIGHT.docketentryid,
					CourtID_C3CourtID_Rec(LEFT,RIGHT),LEFT ONLY,LOOKUP);
                                                                                        
return CourtID_C3CourtID_RecJoin;
end;