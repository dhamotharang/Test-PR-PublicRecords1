import ut; 
LiensV2.Layout_Liens_party_HeaderIngest refLiensParty(LiensV2.layout_liens_party_ssn_BIPV2 l) := transform
	self := l;
end;

export File_liens_party_headerIngest := project(LiensV2.file_Liens_party_BIPV2, refLiensParty(left));