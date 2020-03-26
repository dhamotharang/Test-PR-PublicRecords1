export Email_Notificaton_Lists :=
module

	export BuildFailure := if(Flags.IsTesting, 'lbentley@seisint.com', 'lbentley@seisint.com;tedman@seisint.com;albert.metzmaier@lexisnexis.com');

	export BuildSuccess := if(Flags.IsTesting, 'lbentley@seisint.com', 'lbentley@seisint.com;tedman@seisint.com;albert.metzmaier@lexisnexis.com;qualityassurance@seisint.com');

	export Roxie  		  := if(Flags.IsTesting, 'lbentley@seisint.com', 'roxiedeployment@seisint.com;vniemela@seisint.com;lbentley@seisint.com;tedman@seisint.com;albert.metzmaier@lexisnexis.com');
  
	export Scrubs  		  := if(Flags.IsTesting, 'saritha.myana@lexisnexis.com', 'qualityassurance@seisint.com;randy.reyes@lexisnexis.com;saritha.myana@lexisnexis.com');

end;