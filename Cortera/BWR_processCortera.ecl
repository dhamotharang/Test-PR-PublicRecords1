#stored('did_add_force', 'thor');
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera Build');

version := '';

SEQUENTIAL(
	Cortera.Spray(version),
	Cortera.BuildData(version),
	Cortera.BuildKeys(version),
	Cortera.UpdateDops(version),
	Cortera.CreateOrbitEntry(version),
	
	OUTPUT(Cortera.out_STRATA_population_stats(Cortera.Files.Hdr_Out, version), named('hdr_pops')),
	OUTPUT(Cortera.out_STRATA_attributes_stats(Cortera.Files.Attributes, version), named('attr_pops')),

	Cortera.BuildHeaderScrubsReport(Cortera.File_Header_In, version),
	Cortera.BuildAttributesScrubsReport(Cortera.File_Attributes_In, version)
);
