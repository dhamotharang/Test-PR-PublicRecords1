import CrimSrch;

set_off := ['V','C','T'];

Offenses_Joined_temp := DOC_Offenses_as_CrimSrch_Offenses;

	Offenses_Joined_temp trecs(Offenses_Joined_temp L) := transform
		self.fcra_traffic_flag 	:= if(L.offense_score in set_Off,
										'Y',
										L.fcra_traffic_flag );
		self 					:= L;
	end;

export Offenses_DOC_Joined := project(Offenses_Joined_temp,trecs(left)):persist('~thor_data200::persist::CrimSrch_Offenses_Joined');
