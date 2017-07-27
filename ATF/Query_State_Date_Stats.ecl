// do populatioh stats on all mapped fields before mapping, and after mapping
atf_base := atf.file_firearms_explosives_base_BIP;


layout_atf := record
atf_base.premise_st;
atf_base.date_last_seen;
atf_base.date_first_seen;
end;

atf_stat := table(atf_base,layout_atf);

Layout_atf_Stat := RECORD
	atf_stat.premise_st;
	string8 min_recording_date := min(group,atf_stat.date_first_seen);
	string8 max_recording_date := max(group,atf_stat.date_last_seen);
	reccnt := COUNT(GROUP);
END;

atf_Stat2 := TABLE(atf_stat(premise_st <> ''), Layout_atf_Stat,premise_st, FEW);

sort_atf := sort(atf_stat2,premise_st);

export Query_State_Date_Stats := OUTPUT(CHOOSEN(sort_atf(trim(premise_st,left,right) <> ''),ALL),
							named('State_Date_Stats'),all);
