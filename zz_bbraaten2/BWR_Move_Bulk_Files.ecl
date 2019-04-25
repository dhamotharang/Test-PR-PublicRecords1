// EXPORT BWR_Move_Bulk_Files := 'todo';

ds := fileservices.logicalfilelist()(
																			(regexfind('scoring_project::in::',name) 
																					and (regexfind('2016',name) or regexfind('2017',name))
																				)
																		or (
																					(regexfind('scoringqa::out::nonfcra::',name)  
																						or regexfind('scoringqa::out::fcra::',name)
																						)
																						and
																						regexfind('2017',name)
																				)
																		);

dops.Layout_filelist xProjCopy(ds l) := transform
	self.cmd := '';
	self := l;
end;

dProjCopy := project(ds, xProjCopy(left));

dops.CopyFiles('dataland_esp.br.seisint.com'
								,'dataland_esp.br.seisint.com'
								,'10.241.12.201'
								,'10.241.12.201'
								,'thor400_sta'
								,['thor400_dev']
								,
								,dProjCopy
								,'scoringcopy'
								,'copyforscoring').run;

// Scoring_Project::in::*2017*
// scoringqa::out::nonfcra::*2017*
// scoringqa::out::fcra::*2017*
// ));