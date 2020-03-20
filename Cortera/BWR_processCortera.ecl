IMPORT Scrubs, Scrubs_Cortera;
#stored('did_add_force', 'thor');
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera Build');

version := '';
boolean pIsTesting := false;
build_name := 'Cortera';

SEQUENTIAL(
	Cortera.Spray(version),
	Cortera.BuildData(version),
	Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Input', 'Input', version,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false),
	Cortera.BuildKeys(version),
	Cortera.UpdateDops(version,build_name),
  Cortera.UpdateOrbit(version,build_name),
	
	OUTPUT(Cortera.out_STRATA_population_stats(Cortera.Files.Hdr_Out, version), named('hdr_pops')),
	OUTPUT(Cortera.out_STRATA_attributes_stats(Cortera.Files.Attributes, version), named('attr_pops')),

	Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Executives', 'Executives', version,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false),
	Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_cortera_Header', 'Header', version,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false),
	Scrubs.ScrubsPlus('Cortera','Scrubs_Cortera','Scrubs_Cortera_Attributes', 'Attributes', version,Cortera.Email_Notification_Lists(pIsTesting).BuildFailure,false)
);
