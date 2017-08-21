import roxiekeybuild, _control;
export mod_Email_Notification_Lists(

	 string		pEmailAddressTesting
	,string		pEmailAddressSuccess
	,string		pEmailAddressFailure
	,string		pEmailAddressRoxie
	,boolean	pIsTesting						= tools._Constants.IsDataland
	,string		pEmailAddressStats		= pEmailAddressSuccess

) :=
module

	export BuildFailure := if(pIsTesting, pEmailAddressTesting, pEmailAddressFailure);

	export BuildSuccess := if(pIsTesting, pEmailAddressTesting, pEmailAddressSuccess);

	export Roxie  			:= if(pIsTesting, pEmailAddressTesting, pEmailAddressRoxie	);

	export Stats  			:= if(pIsTesting, pEmailAddressTesting, pEmailAddressStats	);

end;