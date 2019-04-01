import data_services,ut,fcra,STD;
EXPORT Fn_GetCourtID (DATASET(LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main) dMain) := FUNCTION

// dMain := dataset('~thor_data400::base::liens::main::Hogan_w20190324-131056',LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main,flat);//(~REGEXFIND('MSHINC3',TMSID));

GrpCourtDesc  :=  GROUP(SORT(liensv2.file_lookup_in(desc<>'' AND Court_ID<>''),desc),desc);
UnqDesc  := HAVING(GrpCourtDesc,COUNT(ROWS(LEFT)) = 1);								 

rMainWCourtIDs := record
dMain;
string courtId_Backfill := '';
string courtId_lookup := '';
string courtId_derived := '';
string courtId := '';
end;

rBackfillCourt := record
string RMSID;
string CourtID;
end;

dBackfillCourtLookupFix := dataset(data_services.foreign_prod +'thor_data400::lookup::liens::BackfillRMSIDcourt_20190325',rBackfillCourt, CSV(SEPARATOR('\t'), QUOTE('"'), TERMINATOR('\n')));

rMainWCourtIDs tgetCourtIDfromBAckfill(dMain L,dBackfillCourtLookupFix R) :=Transform
self.courtId_Backfill := r.courtID;
self:=L; 
end;
dMainWCourtidBF := join(distribute(dMain,HASH(orig_RMSID)), distribute(dBackfillCourtLookupFix,HASH(RMSID)), 
     left.orig_RMSID =right.rmsid, tgetCourtIDfromBAckfill(left,right),local,left outer);

rMainWCourtIDs t_court_id1(dMainWCourtidBF l) := transform

	HG_CourtDict	:= DICTIONARY(UnqDesc, {desc => court_id});
  HG_Court(string desc) := HG_CourtDict[desc].court_id;


 STRING7 CourtId      :=  l.tmsid[length(TRIM(l.tmsid,LEFT,RIGHT))-6..];
 STRING7 ValidCourtid :=  MAP(regexfind('[A-Z\\.]{6}[A-Z0-9]',CourtId ) and courtid[1..2] in ut.Set_State_Abbrev => CourtId,
                                             CourtId in ['IAO\'BD1','IAO\'BC1'] => CourtId,
                                                                                                                                                                                                                                                '');
                  
 self.courtId_derived   := ValidCourtid;
 STRING7 courtId_lookup := HG_Court(TRIM(L.agency,left,right));
 self.courtId_lookup    := courtId_lookup;
 self.courtId     := MAP( ValidCourtid <> '' => ValidCourtid,
                          courtId_lookup = L.courtId_Backfill => courtId_lookup,
													L.courtId_Backfill ='' and courtId_lookup <> '' => courtId_lookup,
																'');                                       
 self := l;
 end;


All_records2 := project(dMainWCourtidBF, t_court_id1 (left));

return(All_records2);

End;
/*
// count(dMain);
// count(dMainWCourtidBF);
output(count(All_records2 (courtId_derived <> '')),named('Cnt_Courtderived'));
output(count(All_records2 (courtId_lookup <> '')),named('Cnt_CourtLookup'));
output(count(All_records2 (courtId_Backfill <> '')),named('Cnt_CourtdBackfill'));

// count (All_records2 (courtId_derived = courtId_lookup));
// output(All_records2(courtId_derived <> '' and courtId_lookup <> '' and courtId_derived <> courtId_lookup));
output(count (All_records2(courtId_derived <> '' and courtId_lookup <> '' and courtId_derived <> courtId_lookup)),named('Cnt_derivedNOTEQUALlookup'));

//count(All_records2 (courtId_derived = courtId_Backfill));
 // output(All_records2(courtId_derived <> '' and courtId_Backfill <> '' and courtId_derived <> courtId_Backfill));
output(count(All_records2(courtId_derived <> '' and courtId_Backfill <> '' and courtId_derived <> courtId_Backfill)),named('Cnt_derivedNOTEQUALcourtId_Backfill'));

output(count(All_records2 (courtId_derived ='' and courtId_Backfill = courtId_lookup )),named('Cnt_derivedBlankLookupEqualtocourtId_Backfill'));
// count(All_records2 (courtId_derived ='' and courtId_Backfill = '' and courtId_lookup <> ''));

output(count(All_records2),named('CntTotalMain'));
output(count(All_records2(courtId ='')),named('CntTotMainWOCourtID'));
output(count(All_records2(courtId ='' and fcra.bankrupt_is_ok((string)STD.Date.Today(),orig_filing_date,true))),named('Cnt_TotalMainwihtoutCourtFCRA'));
output(count(All_records2(courtId ='' and (courtId_Backfill <> '' or courtId_lookup <> '' ))),named('CntTotNOCrtIDFinalpluslookupOrbackfill'));
output(count(All_records2(courtId ='' and (courtId_Backfill <> '' and courtId_lookup <> '' ))),named('CntTotNOCrtIDFinalpluslookupAndbackfill'));

output(All_records2(courtId ='' and (courtId_Backfill <> '' and courtId_lookup <> '' )));

output(All_records2(courtId ='' and (courtId_Backfill <> '' or courtId_lookup <> '' )));

*/

