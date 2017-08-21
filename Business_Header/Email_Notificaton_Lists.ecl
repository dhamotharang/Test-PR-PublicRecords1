import roxiekeybuild, _control;
export Email_Notificaton_Lists :=
module
	export verntext 		:= if(regexfind('lbentley', thorlib.jobowner(), nocase), '5615731227@txt.att.net', '');

	export BuildFailure := if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;jtolbert@seisint.com;GIRI.RAJULAPALLI@lexisnexis.com');

	export BuildSuccess := if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;jtolbert@seisint.com;GIRI.RAJULAPALLI@lexisnexis.com;Charles.Pettola@lexisnexis.com');

	export Roxie  			:= if(Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';vniemela@seisint.com;lbentley@seisint.com;GIRI.RAJULAPALLI@lexisnexis.com');

end;