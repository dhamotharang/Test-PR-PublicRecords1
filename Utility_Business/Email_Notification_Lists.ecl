import _control;
export Email_Notification_Lists :=
module
	
	export all_hands := 'giri.rajulapalli@lexisnexis.com;' + 
											_control.MyInfo.EmailAddressNotify
											;
											
	export BuildSuccess := all_hands;
	
	export BuildFailure := BuildSuccess;
	
	export Spray				:= BuildSuccess;
	
end;