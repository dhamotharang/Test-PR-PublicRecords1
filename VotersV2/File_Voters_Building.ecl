voters_suppress_DID := VotersV2.File_Voters_Base(intformat(did,12,1) not in VotersV2.Suppress_DID and intformat(vtid,9,1) not in VotersV2.Suppress_VTID );

// Added code to suppress invalid occupation codes and maiden names - Bug 31376

typeof(voters_suppress_DID) suppress_occupation_codes(voters_suppress_DID l) := transform
	self.occupation := if(regexfind('^[Ss][Ww][0-9]*$',trim(l.occupation,left,right)),'',l.occupation);
	self.maiden_name := if(regexfind('^[Uu][Rr][0-9]*$',trim(l.maiden_name,left,right)),'',l.maiden_name);
	self := l;
end;

export File_Voters_Building := project(voters_suppress_DID, suppress_occupation_codes(left));