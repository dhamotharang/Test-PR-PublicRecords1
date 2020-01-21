import roxiekeybuild, _control, business_header;
export Email_Notificaton_Lists :=
module

	export BuildFailure := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';GIRI.RAJULAPALLI@lexisnexisrisk.com;julie.ellison@lexisnexisrisk.com');

	export BuildSuccess := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';qualityassurance@seisint.com');

	export Roxie  			:= if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';julie.ellison@lexisnexisrisk.com;GIRI.RAJULAPALLI@lexisnexisrisk.com');

end;