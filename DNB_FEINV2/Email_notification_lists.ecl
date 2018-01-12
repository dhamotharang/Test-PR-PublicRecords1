import _control,RoxieKeyBuild; 

export Email_Notification_Lists(boolean	pIsTesting = _Constants().IsTesting ) := module
	
	export myInfo       := _Control.MyInfo.EmailAddressNotify;
	export all_hands    := myInfo + ';Harry.Gist@lexisnexisrisk.com;';
	
	export BuildSuccess := if(pIsTesting, myInfo, all_hands + ';qualityassurance@seisint.com');
	export BuildFailure := if(pIsTesting, myInfo, all_hands + ';akayttala@seisint.com');
	export Roxie        := if(pIsTesting, myInfo, all_hands + RoxieKeyBuild.Email_Notification_List);
	export ScrubsPlus   := if(pIsTesting, myInfo, all_hands + ';Rosemary.Murphy@lexisnexisrisk.com;Kent.Wolf@lexisnexisrisk.com');

end; 
