IMPORT tools, _control, ut, std, Scrubs, Scrubs_Cortera;

EXPORT proc_build_all(string pversion, boolean pIsTesting = false) :=  function

build_name := 'Cortera';

build_all := SEQUENTIAL(
	Cortera.Spray(pversion)
	,Cortera.BuildData(pversion)
	,Cortera.BuildKeys(pversion)
	,Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Input', 'Input', pversion,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	,Cortera.UpdateDops(pversion,build_name)
  ,Cortera.UpdateOrbit(pversion,build_name)
	,OUTPUT(Cortera.out_STRATA_population_stats(Cortera.Files.Hdr_Out, pversion), named('hdr_pops'))
	,OUTPUT(Cortera.out_STRATA_attributes_stats(Cortera.Files.Attributes, pversion), named('attr_pops'))
	,Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Executives', 'Executives', pversion,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	,Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_cortera_Header', 'Header', pversion,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	,Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Attributes', 'Attributes', pversion,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false)
	) 
	: 
	success(Cortera.send_emails(pversion,,not pIsTesting).buildsuccess), 
	    failure(Cortera.send_emails(pversion,,not pIsTesting).buildfailure)
			;
return build_all;
end;
