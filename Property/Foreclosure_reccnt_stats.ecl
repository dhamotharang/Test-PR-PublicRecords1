import lib_fileservices;

#workunit('name','Foreclosure Stats');

LK := dataset('~thor_data400::base::foreclosure',Property.Layout_Fares_Foreclosure,thor);
LK1 := dataset('~thor_data400::base::foreclosure_father',Property.Layout_Fares_Foreclosure,thor);

// Project Deeds File  to Slim Records
Layout_Foreclosure_County_Codes := RECORD
	string2 mstate;
	string8	m_process_date;
	string8 min_record_date;
	string8 max_record_date;
END;

Layout_Foreclosure_County_Codes GetCountyCodes(LK L) := TRANSFORM
	self.mstate := Property.Map_FIPS_Code_to_State(L.state);
	self.m_process_date := L.process_date;
	self.min_record_date := L.recording_date;
	self.max_record_date := L.recording_date;
END;

Foreclosure_County_Codes := PROJECT(LK(deed_category = 'U' and process_date <> '' and recording_date <> ''), GetCountyCodes(LEFT));
Foreclosure_County_Codes1 := PROJECT(LK1(deed_category = 'U' and process_date <> '' and recording_date <> ''), GetCountyCodes(LEFT));


Layout_County_Code_Stat := RECORD
	Foreclosure_County_Codes.mstate;
	string8 max_process_date := max(group,Foreclosure_County_Codes.m_process_date);
	string8 min_rec_date := min(group,Foreclosure_County_Codes.min_record_date);
	string8 max_rec_date := max(group,
															if(regexfind('^[0-9]{8}$',Foreclosure_County_Codes.max_record_date) and Foreclosure_County_Codes.max_record_date[1..4] <= '2007',
																 Foreclosure_County_Codes.max_record_date, '99999999')
														 );
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat := TABLE(Foreclosure_County_Codes, Layout_County_Code_Stat, mstate, FEW);

Layout_County_Code_Stat1 := RECORD
	Foreclosure_County_Codes1.mstate;
	string8 max_process_date := max(group,Foreclosure_County_Codes1.m_process_date);
	string8 min_rec_date := min(group,Foreclosure_County_Codes1.min_record_date);
	string8 max_rec_date := max(group,if(regexfind('^[0-9]{8}$',Foreclosure_County_Codes1.max_record_date) and Foreclosure_County_Codes1.max_record_date[1..4] <= '2007',
																 Foreclosure_County_Codes1.max_record_date, '99999999')
														 );
	reccnt := COUNT(GROUP);
END;

County_Codes_Stat1 := TABLE(Foreclosure_County_Codes1, Layout_County_Code_Stat1, mstate, FEW);

Layout_rec := record
	string2 mstate;
	string8 process_date;
	string8 min_recording_date;
	string8 max_recording_date;
	string10 present_cnt;
	string10 past_cnt;
	string10 difference;
	string1 lf := '\n';
end;

Layout_rec join_count(County_Codes_Stat L,County_Codes_Stat1 R) := transform
	self.mstate := if(L.mstate <> '',L.mstate,R.mstate);
	self.process_date := if(L.max_process_date <> '',L.max_process_date,R.max_process_date);
	self.min_recording_date := if(L.min_rec_date <> '',L.min_rec_date,R.min_rec_date);
	self.max_recording_date := if(L.max_rec_date <> '',L.max_rec_date,R.max_rec_date);
	self.present_cnt := (string10)L.reccnt;
	self.past_cnt := (string10)R.reccnt;
	self.difference := (string10)if(L.reccnt > R.reccnt,L.reccnt-R.reccnt,R.reccnt-L.reccnt);
end;

join_rec := join(County_Codes_Stat,County_Codes_Stat1,
				left.mstate = right.mstate,
				join_count(left,right),FULL OUTER);

sort_county := sort(join_rec,-process_date,mstate);

fore_stats_out := OUTPUT(sort_county(trim(mstate,left,right) <> ''),,'~thor_data400::out::foreclosure_reccnt_stats',overwrite);

fore_file_despray := lib_fileservices.fileservices.Despray('~thor_data400::out::foreclosure_reccnt_stats','192.168.0.39',
 									'/thor_back5/fares/foreclosure/stats/foreclosure_stats.d00',,,,TRUE);

export Foreclosure_reccnt_Stats := sequential(fore_stats_out,fore_file_despray);