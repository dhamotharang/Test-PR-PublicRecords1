import _control,RoxieKeyBuild;
export Email_Notification_Lists :=
module
	shared emailaddressep := if(Corp2.IsTesting, ',', ';');
	
	export all_hands := 'kevin.reeder@lexisnexisrisk.com' 						
											+ emailaddressep +	'julie.ellison@lexisnexisrisk.com' 		
											+ emailaddressep +	'julianne.franzer@lexisnexisrisk.com' 
											+ emailaddressep +  'gregory.rose@lexisnexisrisk.com'
											+ emailaddressep +  'audra.mireles@lexisnexisrisk.com'
											+ emailaddressep +  'saritha.myana@lexisnexisrisk.com'
											+ emailaddressep +  'rosemary.murphy@lexisnexisrisk.com'
											+ emailaddressep +  'lucinda.sibille@lexisnexisrisk.com'
											+ emailaddressep +  'lindsey.decot@lexisnexisrisk.com'
											+ emailaddressep +	_control.MyInfo.EmailAddressNotify
											;
											
	export allScrubs := 'julianne.franzer@lexisnexis.com' 		
											+ emailaddressep +  'kevin.reeder@lexisnexisrisk.com'
											+ emailaddressep +	'gregory.rose@lexisnexisrisk.com'
											+ emailaddressep +	'julie.ellison@lexisnexisrisk.com' 		
											+ emailaddressep +	'rosemary.murphy@lexisnexisrisk.com'
											+ emailaddressep +  'lindsey.decot@lexisnexisrisk.com'
											+ emailaddressep +	_control.MyInfo.EmailAddressNotify
											;
											
											
	export all_Sprays :=  'kevin.reeder@lexisnexisrisk.com'
											+ emailaddressep + 'gregory.rose@lexisnexisrisk.com'
											+ emailaddressep + _control.MyInfo.EmailAddressNotify; 
											
  export all_SpraysC :=  'kevin.reeder@lexisnexisrisk.com'
											+ ',' + 'gregory.rose@lexisnexisrisk.com'
											+ ',' + _control.MyInfo.EmailAddressNotify; 
							
											
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
			,'julianne.franzer@lexisnexisrisk.com' + emailaddressep + _control.MyInfo.EmailAddressNotify
			,allScrubs
		);		
	
	export Spray := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,all_Sprays
		);
		
		
		export AttachedList := 
		if(Flags.IsTesting
			,_control.MyInfo.EmailAddressNotify
			,all_SpraysC
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