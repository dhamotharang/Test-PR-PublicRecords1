import CrimSrch;


set_off := ['V','I','C','T'];

Offenses_Joined_temp := Court_Offenses_Step3_Offense_Score
 +	DOC_Offenses_as_CrimSrch_Offenses(vendor not in CrimSrch.sCourt_Vendors_To_Omit)
 +	Sex_Pred_2_as_CrimSrch_Offenses;

Offenses_Joined_temp trecs(Offenses_Joined_temp L) := transform
self.fcra_traffic_flag := if(L.offense_score in set_Off,'Y',L.fcra_traffic_flag );
self := L;

end;

 
#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export Offenses_Joined := project(Offenses_Joined_temp,trecs(left)) :persist('persist::CrimSrch_Offenses_Joined');
#else
export Offenses_Joined := project(Offenses_Joined_temp,trecs(left));
#end