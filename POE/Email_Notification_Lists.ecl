import roxiekeybuild, _control;
export Email_Notification_Lists :=
module

	export BuildFailure := if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com');

	export BuildSuccess := if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com');

	export Roxie  			:= if(_Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';GIRI.RAJULAPALLI@lexisnexis.com;laverne.bentley@lexisnexis.com');

end;