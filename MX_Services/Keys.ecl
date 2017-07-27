import MXD_MXDocket, MXD_Names, MXD_Professions;
export Keys := module

	export Key_DocketNum 						:= MXD_MXDocket.Key_DocketNum;	
	export Key_DocketSearch 				:= MXD_MXDocket.Key_DocketSearch;	
	export Key_DocketMPHSearch 			:= MXD_MXDocket.Key_DocketMPHSearch;	
	export Key_DocketParty					:= MXD_MXDocket.Key_DocketParty;
	export Key_Docket								:= MXD_MXDocket.Key_Docket;

	export Key_ProfessionSearch 		:= MXD_Professions.Key_ProfSearch;	
	export Key_ProfessionMPHSearch 	:= MXD_Professions.Key_ProfMPHSearch;	
 	export Key_Profession						:= MXD_Professions.Key_Profession;

	export Key_Synonym							:= MXD_Names.Key_Synonym;
	
	export test() := function
		// dockets
		output(choosen(Key_DocketNum, 100), named('Key_DocketNum'));
		output(choosen(Key_DocketSearch, 100), named('Key_DocketSearch'));
		output(choosen(Key_DocketMPHSearch, 100), named('Key_DocketMPHSearch'));
		output(choosen(Key_DocketParty, 100), named('Key_DocketParty'));
		output(choosen(Key_Docket, 100), named('Key_Docket'));
		
		// licenses
		output(choosen(Key_ProfessionSearch, 100), named('Key_ProfessionSearch'));
		output(choosen(Key_ProfessionMPHSearch, 100), named('Key_ProfessionMPHSearch'));
		output(choosen(Key_Profession, 100), named('Key_Profession'));		
		
		// synonym
		output(choosen(Key_Synonym, 100), named('Key_Synonym'));
		
		return true;
	end;

end;

