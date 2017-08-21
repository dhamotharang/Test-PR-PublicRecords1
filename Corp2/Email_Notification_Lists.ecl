import _control,RoxieKeyBuild;
export Email_Notification_Lists :=
module
	shared emailaddressep := if(Corp2.IsTesting, ',', ';');
	
	export all_hands := 'michael.gould@lexisnexis.com' 						
											+ emailaddressep +	'julie.ellison@lexisnexis.com' 		
											+ emailaddressep +	'julianne.franzer@lexisnexis.com' 
											+ emailaddressep +  'valerie.minnis@lexisnexis.com'
											+ emailaddressep +  'kevin.reeder@lexisnexis.com'
											+ emailaddressep +  'audra.mireles@lexisnexis.com'
											+ emailaddressep +  'sandy.butler@lexisnexis.com'
											+ emailaddressep +  'saritha.myana@lexisnexis.com'
											+ emailaddressep +  'rosemary.murphy@lexisnexis.com'
											+ emailaddressep +  'lucinda.sibille@lexisnexis.com'
											+ emailaddressep +	_control.MyInfo.EmailAddressNotify
											;
											
	export allScrubs := 'julianne.franzer@lexisnexis.com' 						
											+ emailaddressep +	'michael.gould@lexisnexis.com'
											+ emailaddressep +  'kevin.reeder@lexisnexis.com'
											+ emailaddressep +	'julie.ellison@lexisnexis.com' 		
											+ emailaddressep +	'rosemary.murphy@lexisnexis.com' 
											+ emailaddressep +	_control.MyInfo.EmailAddressNotify
											;
											
	export BuildSuccess := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,all_hands
		);
	
	export BuildFailure := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,all_hands
		);
		
	export Scrubs := 
		if(Flags.IsTesting
			,'julianne.franzer@lexisnexis.com' + emailaddressep + _control.MyInfo.EmailAddressNotify
			,allScrubs
		);		
	
	export Spray := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,_control.MyInfo.EmailAddressNotify
		);
	
	export Roxie := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,	RoxieKeyBuild.Email_Notification_List 
			+ emailaddressep + 'avenkata@seisint.com'
			+ emailaddressep + all_hands
		);
		
	export Stats := Spray;
end;