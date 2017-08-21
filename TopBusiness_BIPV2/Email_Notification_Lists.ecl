import _control,RoxieKeyBuild;

export Email_Notification_Lists :=
module
	
	export all_hands := 'krishna.turlapathi@lexisnexis.com;' + _control.MyInfo.EmailAddressNotify;
											
	export BuildSuccess := 
		if(_Flags.IsTesting
			,all_hands
			,all_hands
		);
	
	export BuildFailure := BuildSuccess;
	
	export Spray				:= BuildSuccess;
	
	export Stats				:= BuildSuccess;

	export Roxie :=
		if(_Flags.IsTesting
			,all_hands
			,RoxieKeyBuild.Email_Notification_List + ';avenkata@seisint.com;' + all_hands
		);
	
	
end;