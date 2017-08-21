import lib_fileservices,_control;

#workunit('name','Liens Daily Stats');

LK := dataset('~thor_data400::base::liens',Bankrupt.Layout_Liens,thor);
LK1 := dataset('~thor_data400::base::liens_father',Bankrupt.Layout_Liens,thor);

// Project Deeds File  to Slim Records
Layout_Liens_Codes := RECORD
	string2 mstate;
	string8	m_uploaddate;
	string8 m_filing_date
END;

Layout_Liens_Codes GetCodes(LK L) := TRANSFORM
	self.mstate := L.courtid[1..2];
	self.m_uploaddate := L.uploaddate;
	self.m_filing_date := L.filing_date;
END;

Liens_Codes := PROJECT(LK(uploaddate <> '' and sourcecode not in ['I','J','F','C']), GetCodes(LEFT));
Liens_Codes1 := PROJECT(LK1(uploaddate <> '' and sourcecode not in ['I','J','F','C']), GetCodes(LEFT));


Layout_Code_Stat := RECORD
	Liens_Codes.mstate;
	string8 max_uploaddate := max(group,Liens_Codes.m_uploaddate);
	reccnt := COUNT(GROUP);
END;

Codes_Stat := TABLE(Liens_Codes(m_filing_date <> ''), Layout_Code_Stat, mstate, FEW);

Layout_Code_Stat1 := RECORD
	Liens_Codes1.mstate;
	string8 max_uploaddate := max(group,Liens_Codes1.m_uploaddate);
	reccnt := COUNT(GROUP);
END;

Codes_Stat1 := TABLE(Liens_Codes1(m_filing_date <> ''), Layout_Code_Stat1, mstate, FEW);

Layout_rec := record
	string2 court_state;
	string8 uploaddate;
	string10 present_cnt;
	string10 past_cnt;
	string10 difference;
	string1 lf := '\n';
end;

Layout_rec join_count(Codes_Stat L,Codes_Stat1 R) := transform
	self.court_state := if(L.mstate <> '',L.mstate,R.mstate);
	self.uploaddate := if(L.max_uploaddate <> '',L.max_uploaddate,R.max_uploaddate);
	self.present_cnt := (string10)L.reccnt;
	self.past_cnt := (string10)R.reccnt;
	self.difference := (string10)if(L.reccnt > R.reccnt,L.reccnt-R.reccnt,R.reccnt-L.reccnt);
end;

join_rec := join(Codes_Stat,Codes_Stat1,
				left.mstate = right.mstate,
				join_count(left,right),FULL OUTER);

sort_rec := sort(join_rec,-uploaddate,court_state);

liens_stats_out := OUTPUT(sort_rec(trim(court_state,left,right) not in ['','TC','NT']),,'~thor_data400::out::liens_reccnt_stats',overwrite);

liens_file_despray := lib_fileservices.fileservices.Despray('~thor_data400::out::liens_reccnt_stats',_control.IPAddress.edata12,
 									'/thor_back5/liens/stats/liens_stats.d00',,,,TRUE);

export Liens_Daily_Stats := sequential(liens_stats_out,liens_file_despray);