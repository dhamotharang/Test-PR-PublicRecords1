EXPORT BuildData(string version) := FUNCTION

		hdrin := cortera.File_Header_In(version);

		ds := Cortera.proc_processHeader(hdrin, version) : INDEPENDENT;
		exec := Cortera.proc_createExecutives(ds) : INDEPENDENT;
		bizlinking := Cortera.As_Business_Linking(exec(country='US'));
		industry := Cortera.As_Industry(exec(country='US'));
		attr := Cortera.proc_processAttributes(ds, Cortera.File_Attributes_In(version), version);

		lfnHdr := Cortera.Constants.sfCorteraHdr + '::' + version;
		lfnexecutives := Cortera.Constants.sfExecutives + '::' + version;
		lfnLinking := Cortera.Constants.sfLinking + '::' + version;
		lfnIndustry := Cortera.Constants.sfIndustry + '::' + version;
		lfnAttributes := Cortera.Constants.sfAttributes + '::' + version;

		return SEQUENTIAL(
			PARALLEL(
				OUTPUT(ds,,lfnHdr, COMPRESSED, OVERWRITE),
				OUTPUT(exec,,lfnexecutives, COMPRESSED, OVERWRITE),
				OUTPUT(bizlinking,,lfnLinking, COMPRESSED, OVERWRITE),
				OUTPUT(industry,,lfnIndustry, COMPRESSED, OVERWRITE),
				OUTPUT(attr,,lfnAttributes, COMPRESSED, OVERWRITE)
			),
			PARALLEL(
				Cortera.Promote.CorteraHeader(lfnHdr),
				Cortera.Promote.Executives(lfnexecutives),
				Cortera.Promote.CorteraAsLinking(lfnLinking),
				Cortera.Promote.industry(lfnIndustry),
				Cortera.Promote.Attributes(lfnAttributes)
			)
		);
	
END;