export DM_stats(getretval) := macro

import header,codes,ut,lib_fileservices,_Control;

dssup := distribute(header.file_death_master_supplemental,hash(state_death_id));
dsmast := distribute(header.File_DID_Death_MasterV2,hash(state_death_id));

string_rec := record
	string source_state := 'National';
	string dod;
end;

string_rec getrecs(dsmast l,dssup r) := transform
	self.dod := l.dod8;
end;

join_out := join(dsmast,dssup,left.state_death_id = right.state_death_id,
								getrecs(left,right),
								left only,
								local);
								
// tab_rec := record
	// join_out.state;
	// string maxdate := max(group,join_out.death_date)[5..6] +  '/' + max(group,join_out.death_date)[7..8] + '/' + max(group,join_out.death_date)[1..4];
	// count(group);
// end;
		
// tab_out := table(join_out,tab_rec,state,few);

dsfilsup := header.file_death_master_supplemental(SOURCE_STATE <> '' and DOD <> '');

string_rec getsuprecs(dsfilsup l) := transform
	self.source_state := l.source_state;
	self.dod := l.dod[5..8]+l.dod[1..2]+l.dod[3..4];
end;

tab_out1 := project(dsfilsup(dod[5..8] != '0000' and dod[1..2] != '00' and dod[3..4] != '00'),getsuprecs(left));

fulldmds := join_out + tab_out1;

Orbit_Report.Run_Stats('dm',fulldmds,source_state,dod,'emailme','st',getretval,'true');

endmacro;
