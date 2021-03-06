import _control,RoxieKeyBuild;
export Email_Notification_Lists :=
module
	
	export all_hands := 'lbentley@seisint.com; tedman@seisint.com;' + 
											_control.MyInfo.EmailAddressNotify
											;
											
	export BuildSuccess := 
		if(_Flags.IsTesting
			,all_hands
			,all_hands
		);
	
	export BuildFailure := BuildSuccess;
	
	export Spray				:= BuildSuccess;
	
	export Statistics		:= BuildSuccess;

	export Roxie :=
		if(_Flags.IsTesting
			,'lbentley@seisint.com;' + _control.MyInfo.EmailAddressNotify
			,RoxieKeyBuild.Email_Notification_List + ';avenkata@seisint.com;vniemela@seisint.com;' + all_hands
		);
	
	
end;