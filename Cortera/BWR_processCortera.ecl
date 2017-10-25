#stored('did_add_force', 'thor');
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera Build');

version := '';

SEQUENTIAL(
	Cortera.Spray(version),
	Cortera.BuildData(version),
	Cortera.BuildKeys(version),
	Cortera.UpdateDops(version),
	
	Cortera.out_STRATA_population_stats(Cortera.Files.Hdr_Out, version),
	Cortera.out_STRATA_attributes_stats(Cortera.Files.Attributes, version),

	Cortera.BuildHeaderScrubsReport(Cortera.File_Header_In, version),
	Cortera.BuildAttributesScrubsReport(Cortera.File_Attributes_In, version)
);
