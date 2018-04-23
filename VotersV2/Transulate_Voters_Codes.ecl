import VotersV2, Codes;

Cleaned_Norm_vbase := VotersV2.Norm_Voters_Cleaned_Base;

Layout_outfile := VotersV2.Layouts_Voters.Layout_Voters_base_new;

CleanedNormVbaseAndBase := Cleaned_Norm_vbase;

//*** Code to explode the description values for Race Ethnicity, Active Status, 
//*** Age Category, Political Party, Voter Status
Layout_outfile  getRaceEthnicity(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.race_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self          := L;
end;

//Clean_file_Race_Exp := join(Cleaned_Norm_vbase,
Clean_file_Race_Exp := join(CleanedNormVbaseAndBase,
		                    codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'RACEETHNICITY'),
		                    trim(left.race, left, right) = trim(right.code, left, right),
		                    getRaceEthnicity(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getActiveStatus(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.active_status_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                   := L;
end;

Clean_file_active_status_exp := join(Clean_file_Race_Exp,
		                             codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'ACTIVEORINACTIVE'),
		                             trim(left.active_status, left, right) = trim(right.code, left, right),
		                             getActiveStatus(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getAgeCat(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.ageCat_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self            := L;
end;

Clean_file_AgeCat_exp := join(Clean_file_active_status_exp,
		                      codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'AGECATEGORY'),
		                      trim(left.ageCat, left, right) = trim(right.code, left, right),
		                      getAgeCat(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getPoliticalParty(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.politicalparty_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                    := L;
end;

Clean_file_PoliticalParty_exp := join(Clean_file_AgeCat_exp,
		                              codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'POLITICALPARTY'),
		                              trim(left.political_party, left, right) = trim(right.code, left, right),
		                              getPoliticalParty(LEFT,RIGHT),left outer, lookup);

Layout_outfile  getVoterStatus(Layout_outfile L, codes.File_Codes_V3_In R) := transform
	self.Voter_status_exp := IF(trim(R.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(R.long_desc,left, right)), '');
	self                  := L;
end;

Clean_file_Voter_Status_exp := join(Clean_file_PoliticalParty_exp,
		                            codes.File_Codes_V3_In(trim(file_name, left, right) = 'EMERGES_HVC',trim(field_name, left, right) = 'VOTERSTATUS'),
		                            trim(left.voter_status, left, right) = trim(right.code, left, right),
		                            getVoterStatus(LEFT,RIGHT),left outer, lookup);
//*** End of code transulations.

/* per #Bug: 174413 / Received a complaint against one female individual being reported as Male, data set will be passed 
   Below VotersV2.Filters module to handle accordingly / wrong value(s) will be blanked out  */

//Barb O'Neill modified for DOPS-461
VoteRegBase_File := VotersV2.File_Voters_Base;
	 
ds_Clean_file_Voter_Status_exp := VotersV2.Filters.Base(Clean_file_Voter_Status_exp + VoteRegBase_File);
export Transulate_Voters_Codes := ds_Clean_file_Voter_Status_exp: persist(VotersV2.Cluster+ 'persisit::Cleaned_Voter_base');