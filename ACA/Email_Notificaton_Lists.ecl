import roxiekeybuild, _control;
export Email_Notificaton_Lists :=
module

	export BuildFailure := if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com');

	export BuildSuccess := if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com');

	export Roxie  			:= if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';laverne.bentley@lexisnexis.com');

end;