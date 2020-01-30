// import roxiekeybuild, _control, business_header;
// export Email_Notification_Lists :=
// module

	// export BuildFailure := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';Sudhir.Kasavajjala@lexisnexisrisk.com;barbara.oneill@lexisnexisrisk.com');

	// export BuildSuccess := if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';qualityassurance@seisint.com');

	// export Roxie  			:= if(business_header.Flags.IsTesting, _Control.MyInfo.EmailAddressNotify, _Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';Sudhir.Kasavajjala@lexisnexisrisk.com;barbara.oneill@lexisnexisrisk.com');

// end;

IMPORT _control,tools,roxiekeybuild;

EXPORT Email_Notification_Lists(

	BOOLEAN	pIsTesting = Cortera._Constants().IsTesting ) := 
			
  tools.mod_Email_Notification_Lists(
		 _Control.MyInfo.EmailAddressNotify	
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;' + 'Sudhir.Kasavajjala@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';barbara.oneill@lexisnexisrisk.com;' + 'Sudhir.Kasavajjala@lexisnexisrisk.com;'
	  ,_Control.MyInfo.EmailAddressNotify + ';' + roxiekeybuild.Email_Notification_List + ';barbara.oneill@lexisnexisrisk.com;' + 'Sudhir.Kasavajjala@lexisnexisrisk.com;'	
	  ,pIsTesting
	 );