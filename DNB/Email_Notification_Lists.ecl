import roxiekeybuild;
export Email_Notification_Lists := 
module

	export SprayCompletion	:= if(Flags.IsTesting = true, 'lbentley@seisint.com;tedman@seisint.com', 'lbentley@seisint.com;tedman@seisint.com');
	export BuildSuccess	:= if(Flags.IsTesting = true, 'lbentley@seisint.com;tedman@seisint.com', 'lbentley@seisint.com;qualityassurance@seisint.com;tedman@seisint.com');
	export BuildFailure	:= if(Flags.IsTesting = true, 'lbentley@seisint.com;tedman@seisint.com', 'lbentley@seisint.com;tedman@seisint.com');
	export Roxie			:= if(Flags.IsTesting = true, 'lbentley@seisint.com', roxiekeybuild.Email_Notification_List + ';lbentley@seisint.com; vniemela@seisint.com;tedman@seisint.com');

end;