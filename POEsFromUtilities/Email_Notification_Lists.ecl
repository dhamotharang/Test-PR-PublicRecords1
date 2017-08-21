import roxiekeybuild, _control;
export Email_Notification_Lists :=
module

	export BuildFailure := if(_Constants().IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;');

	export BuildSuccess := if(_Constants().IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';laverne.bentley@lexisnexis.com;');

	export Roxie  			:= if(_Constants().IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';laverne.bentley@lexisnexis.com');

end;