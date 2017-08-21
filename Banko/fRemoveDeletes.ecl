


IMPORT BANKO;

export fRemoveDeletes(DATASET(Banko.BankoJoinRecord) ds) := 
function

layout_deletefile := Record
QSTRING1  	DRActivityTypeCode;
STRING10000 	DocketEntryID;
end; 

Banko_DeleteRecords := dataset('~thor_data400::in::bankoadditionalevents',layout_deletefile,
					CSV(HEADING(0),SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'),MAXLENGTH(100000)))(DRActivityTypeCode='D');

//Layout_BankoFile_FixedRec_EventSort := SORT(Banko_DeleteRecords,DocketEntryID);
//Layout_BankoFile_FixedRec_EventDist := DISTRIBUTE(Layout_BankoFile_FixedRec_EventSort,HASH32(DocketEntryID));

//Banko_Additional_EventSort := SORT(ds,docketentryid);
//Banko_Additional_EventDist := DISTRIBUTE(Banko_Additional_EventSort,HASH32(docketentryid));

typeof(Banko.BankoJoinRecord) CourtID_C3CourtID_Rec(Banko.BankoJoinRecord L
										,layout_deletefile R) := TRANSFORM
   	
	SELF := L;
	
END;

CourtID_C3CourtID_RecJoin := JOIN(ds,
					Banko_DeleteRecords,
					LEFT.docketentryid = RIGHT.docketentryid,
					CourtID_C3CourtID_Rec(LEFT,RIGHT),LEFT ONLY,LOOKUP);
                                                                                        
return CourtID_C3CourtID_RecJoin;
end;