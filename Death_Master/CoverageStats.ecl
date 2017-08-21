import header, death_master, ut;

dsDeath := header.File_Death_Master_Plus;

deathFilterRec := record
	dsDeath.state;
	dsDeath.dod8;
	dsDeath.state_death_flag;
end;

deathFilterRec cleanFilingDate(dsDeath deathInput) := transform
	self.dod8 := if(regexfind('^[0-9]{8}$',trim(deathInput.dod8)),deathInput.dod8,'');
	self := deathInput;
end;

cleanDeathStats := project(dsDeath, cleanFilingDate(left));

deathStatsRec := record
	cleanDeathStats.state;
	cleanDeathStats.state_death_flag;
	minFilingDate := min(group,if(cleanDeathStats.dod8 <= ut.GetDate and cleanDeathStats.dod8 != '', cleanDeathStats.dod8, '99999999'));
	maxFilingDate := max(group,if(cleanDeathStats.dod8 <= ut.GetDate and cleanDeathStats.dod8 != '', cleanDeathStats.dod8, '00000000'));
	countRecords := count(group);
end;

deathStats := table(cleanDeathStats,
					deathStatsRec,
					state,state_death_flag,
					few);
					  
deathStats cleanStats(deathStats statsInput) := transform
	self.minFilingDate := if(statsInput.minFilingDate = '99999999', '', statsInput.minFilingDate);
	self.maxFilingDate := if(statsInput.maxFilingDate = '00000000', '', statsInput.maxFilingDate);
	self := statsInput;
end;

export CoverageStats := project(deathStats, cleanStats(left));