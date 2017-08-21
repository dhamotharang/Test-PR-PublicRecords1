import roxiekeybuild, _control, business_header;
export Email_Notificaton_Lists :=
module
	export verntext 		:= if(regexfind('lbentley', thorlib.jobowner(), nocase), '5615731227@txt.att.net', '');

	export BuildFailure := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';lbentley@seisint.com;jtolbert@seisint.com');

	export BuildSuccess := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';qualityassurance@seisint.com');

	export Roxie  			:= if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';vniemela@seisint.com;lbentley@seisint.com');

end;