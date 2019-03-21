EXPORT proc_build_all(string version) :=  function

build_name := 'Cortera';

build_all := SEQUENTIAL(
	Cortera.Spray(version),
	Cortera.BuildData(version),
	Cortera.BuildKeys(version),
	Cortera.UpdateDops(version,build_name),
     Cortera.UpdateOrbit(version,build_name),
	OUTPUT(Cortera.out_STRATA_population_stats(Cortera.Files.Hdr_Out, version), named('hdr_pops')),
	OUTPUT(Cortera.out_STRATA_attributes_stats(Cortera.Files.Attributes, version), named('attr_pops')),

	Cortera.BuildHeaderScrubsReport(Cortera.File_Header_In, version),
	Cortera.BuildAttributesScrubsReport(Cortera.File_Attributes_In, version)
)  : success(Cortera.Send_Email(version,build_name).buildsuccess), failure(Cortera.Send_Email(version,build_name).buildfailure);
return build_all;
end;
