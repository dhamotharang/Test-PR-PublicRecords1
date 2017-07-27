export Email_Notification_Lists :=
module
	export BuildSuccess := if(Flags.IsTesting, 'lbentley@seisint.com', 'lbentley@seisint.com;jtrost@seisint.com');
	
	export BuildFailure := if(Flags.IsTesting, 'lbentley@seisint.com', 'lbentley@seisint.com;jtrost@seisint.com');
	
	export Spray := if(Flags.IsTesting, 'lbentley@seisint.com', 'lbentley@seisint.com;jtrost@seisint.com');
	
	export Roxie := if(Flags.IsTesting, 'lbentley@seisint.com; ehalper-stromberg@seisint.com', 
										'roxiedeployment@seisint.com;avenkata@seisint.com;vniemela@seisint.com');

end;