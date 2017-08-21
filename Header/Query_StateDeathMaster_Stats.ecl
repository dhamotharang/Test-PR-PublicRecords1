state_death_master_base := File_Did_StateDeath_Master;


layout_state_death_master := record
state_death_master_base.source_state;
state_death_master_base.DOD;
end;

state_death_master_stat := table(state_death_master_base(DOD <> ''),layout_state_death_master);

Layout_state_death_master_Stat := RECORD
	state_death_master_stat.source_state;
	string8 min_DOD := min(group,state_death_master_stat.DOD);
	string8 max_DOD := max(group,state_death_master_stat.DOD);
	reccnt := COUNT(GROUP);
END;

state_death_master_Stat2 := TABLE(state_death_master_stat(source_state <> ''), Layout_state_death_master_Stat,source_state, FEW);

sort_state_death_master := sort(state_death_master_stat2,source_state);

OUTPUT(CHOOSEN(sort_state_death_master(trim(source_state,left,right) <> ''),ALL));

export Query_StateDeathMaster_Stats := OUTPUT(CHOOSEN(sort_state_death_master(trim(source_state,left,right) <> ''),ALL));
