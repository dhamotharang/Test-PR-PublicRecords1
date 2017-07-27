export constants := module

export max_phonesplus := 10;
export max_Relocation := 10;
export max_workphones := 50;
export max_associates := 10;
export max_neighbors  := 100;
export neighbors_per_address := 6;
export max_finders := 50;
export max_indicators := 1;
export max_bankruptcies := 20;
export max_subject_info_names := 1;
export max_imposters:= 20;
export max_phoneSection_phones := 50;
export max_addresses := 100;
export min_number_cohabits := 6;
export max_subject := 10;
export max_relatives := 100;
export max_AgeOfData := 10;  //years
export min_PhonesPlusConfidencescore := 10;
export min_PAWConfidencescore := 0;
export min_PAWRecencyInDays := 0;//0 means dont filter on date

export default_DialContactPrecision := 5;
export default_RelativeDepth := 1;

export boolean AllowMinors := false;
export boolean IncludeRelocation := true;

export default_PhonesPerPerson := 4;
export max_PhonesPerPerson := 4;
export default_AddrsPerPerson := 2;
export max_AddrsPerPerson := 4;
export max_AddrsAtHome := 1;
export max_PhonesPerAddr := 2; //used if no PhonesPlus for RNA is requested
export max_TotalPhonesPerAddr := 5; //total from gong and PhonesPlus
export max_WhoToAskFor := 10;
export max_Try := 20;
export max_akas := 20;

export priority_Deceased := 0;
export priority_Subject := 1;
export priority_WorkPhone := 3;
export priority_Relative := 4;
export priority_Associate := 5;
export priority_PhonesPlus := 2;
export priority_neighbor := 6;
export priority_Relocation := 7;

export set_restricted_for_rollup := [priority_neighbor, priority_phonesplus, priority_WorkPhone];

export str_phonesPlusType		:= 'Possible Cell Phone';
export str_unlisted 				:= 'UNPUB';
export str_publish_code_yes := 'P';
export str_publish_code_no 	:= 'U';

shared str_ReachMeDeceased 	:= 'Deceased';
EXPORT str_ReachMeSubject 	:= 'At Home';
shared str_ReachMeWorkPhone := 'At Work';
shared str_ReachMeRelative 	:= 'Through Family';
shared str_ReachMeAssociate := 'Through Associates';
shared str_ReachMeNeighbor 	:= 'Through Neighbors';
shared str_ReachMePhonesPlus := 'PhonesPlus';
shared str_ReachMeRelocation := 'Possible Relocation';

export str_ReachMe(unsigned1 pri) := map(
	pri = priority_Deceased		=> str_ReachMeDeceased,
	pri = priority_Subject		=> str_ReachMeSubject,
	pri = priority_WorkPhone	=> str_ReachMeWorkPhone,
	pri = priority_Relative		=> str_ReachMeRelative,
	pri = priority_Associate	=> str_ReachMeAssociate,
	pri = priority_Neighbor		=> str_ReachMeNeighbor,
	pri = priority_PhonesPlus	=> str_ReachMePhonesPlus,
	pri = priority_Relocation	=> str_ReachMeRelocation,
	'');

export str_Subject   := 'Subject';
export str_PossibleSubject   := 'Possible Subject';
export str_Relative  := 'Relative';
export str_Associate := 'Associate';
export str_Neighbor := 'Neighbor';

export ds_AptWords := dataset([ {'APARTMENT'},
																{'VILLAGE'},
																{'PROPERT'},
																{'BUILDING'},
																{'TOWER'},
																{'LOFTS'},
																{'COURT'},
																{'PLACE'},
																{'RESIDENCES'},
																{'CONDO'},
																{'MGMT'},
																{'MANAGEMENT'}],
															 {string100 word});
		
END;