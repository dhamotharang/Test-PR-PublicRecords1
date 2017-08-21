IMPORT doxie, PRTE2_VotersV2, BIPV2,  VotersV2,mdr, codes;

EXPORT keys := MODULE

EXPORT key_voters_did := INDEX(FILES.VotersV2_Base ((integer)did != 0),  {did},  {did,vtid, rid}, constants.KeyName_voters + '@version@::did');

EXPORT key_voters_vtid := INDEX(FILES.DS_VotersV2_vtid,  {vtid},  {FILES.DS_votersV2_vtid}, '~prte::key::voters::@version@::vtid');

EXPORT key_voters_history_vtid := INDEX(FILES.DS_Voters_Hist (vtid !=0),  {vtid},  {Files.DS_Voters_Hist}, '~prte::key::voters::@version@::history_vtid');

export Keys_temp(boolean IsFCRA = false) := function
VoterFile := if (IsFCRA,
								 Files.VotersV2_Base(codes.valid_st(source_state) and (source_state != 'HI' and source_state != 'NJ')),
								 Files.VotersV2_Base(codes.valid_st(source_state)));
											
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
  constants.KeyName_voters + 'fcra::' + doxie.Version_SuperKey + '::bocashell_voters_source_states_lookup',
  constants.KeyName_voters + doxie.Version_SuperKey + '::bocashell_voters_source_states_lookup');	
	
return index(VoterAvailSt, {state}, {VoterAvailSt}, filename);								
								
end;

 

END;

































































