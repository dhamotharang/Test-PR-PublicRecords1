import _control,RoxieKeyBuild;
export Email_Notification_Lists :=
module
	
	export all_hands := 'lbentley@seisint.com;' + 
											_control.MyInfo.EmailAddressNotify
											;
											
	export BuildSuccess := all_hands;
	
	export BuildFailure := BuildSuccess;
	
	export Spray				:= BuildSuccess;
	
	export Stats				:= BuildSuccess;

end;