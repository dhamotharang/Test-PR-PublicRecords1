import ut; 
LiensV2.Layout_liens_party_ssn refLiensParty(LiensV2.layout_liens_party_ssn_BIPV2 l) := transform
	self := l;
end;

export file_liens_party := project(LiensV2.file_Liens_party_BIPV2, refLiensParty(left));