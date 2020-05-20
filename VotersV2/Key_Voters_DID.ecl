Import Data_Services, doxie, header_services, Data_Services;

base := PROJECT(VotersV2.File_Voters_Building, VotersV2.Layouts_Voters.Layout_Voters_Base);


base2 := VotersV2.Prep_Build.applyVoters(base(did <> 0));				   

export Key_Voters_DID := index(base2,
															 {did},
														   {did, vtid, rid},
															Data_Services.Data_location.Prefix('Voter')+'thor_data400::key::voters::'+doxie.Version_SuperKey+'::did');