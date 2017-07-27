Import ut, doxie, Data_Services;

export Key_Voters_States(boolean IsFCRA = false) := function
VoterFile := VotersV2.File_Voters_Building(ut.valid_st(source_state));

VoterSrcStates_layout := RECORD
	string2 state := VoterFile.source_state;
	string8 date_first_seen := (string) MIN(group, (INTEGER) if(VoterFile.date_first_seen = '', '999999999', VoterFile.date_first_seen));

END;

VoterStatesAvail_tmp := table(VoterFile, VoterSrcStates_layout, VoterFile.source_state);
VoterStatesAvail := project(VoterStatesAvail_tmp, 
	transform(VoterSrcStates_layout,
		tmpDate := trim(left.date_first_seen);
		yy := tmpDate[0..4];
		mmChange := if(tmpDate[5..6] = '00', '01', tmpDate[5..6] );
		ddChange := if(tmpDate[7..8] = '00', '01', tmpDate[7..8] );
		self.date_first_seen := yy+mmChange+ddChange;
		self := left));
VoterAvailSt := sort(VoterStatesAvail, state);

filename := if (IsFCRA, 
					Data_Services.Data_location.Prefix('DEFAULT') + 'thor_data400::key::votersv2::fcra::'+ doxie.Version_SuperKey +'::bocashell_voters_source_states_lookup',
					Data_Services.Data_location.Prefix('DEFAULT') + 'thor_data400::key::votersv2::'+ doxie.Version_SuperKey +'::bocashell_voters_source_states_lookup');

return index(VoterAvailSt, {state}, {VoterAvailSt}, filename);								
								
end;
