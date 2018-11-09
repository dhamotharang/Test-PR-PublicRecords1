import roxiekeybuild, _control,tools;

export Email_Notification_Lists( boolean	pIsTesting = _Constants().IsTesting ) := module
	
	export myInfo       := _Control.MyInfo.EmailAddressNotify;
	export all_hands    := myInfo + ';laverne.bentley@lexisnexis.com;';
	
	export BuildSuccess := if(pIsTesting, myInfo, all_hands);
	export BuildFailure := all_hands;
	export Roxie        := if(pIsTesting, myInfo, RoxieKeyBuild.Email_Notification_List + all_hands);
	export ScrubsPlus   := if(pIsTesting, myInfo, all_hands + 'Rosemary.Murphy@lexisnexisrisk.com;Melanie.Jackson@lexisnexisrisk.com;Audra.Mireles@lexisnexisrisk.com');

end; 
 