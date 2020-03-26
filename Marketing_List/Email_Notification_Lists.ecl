import roxiekeybuild, _control,tools,BIPV2_Build;

export Email_Notification_Lists( boolean	pIsTesting = _Config().IsTesting ) := 
module
	
	export myInfo       := 'laverne.bentley@lexisnexisrisk.com';
	export all_hands    := myInfo + ',' + BIPV2_Build.mod_email.emailList 
                          + ',Emily.VanHeel@lexisnexisrisk.com'
                          + ',Benjamin.Weiner@lexisnexisrisk.com'
                          + ',Nicholas.Montpetit@lexisnexisrisk.com'
                          + ',Mallory.weber@lexisnexisrisk.com'
                          ;
	// export all_hands    := myInfo + ';laverne.bentley@lexisnexisrisk.com;';
	
	export BuildSuccess := if(pIsTesting, myInfo, all_hands);
	export BuildFailure := all_hands;
	export Roxie        := if(pIsTesting, myInfo, RoxieKeyBuild.Email_Notification_List + all_hands);
	export ScrubsPlus   := if(pIsTesting, myInfo, all_hands + '');

end;