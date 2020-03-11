EXPORT BuildData(string version) := FUNCTION

		hdrin := cortera.File_Header_In;

		ds := Cortera.proc_processHeader(hdrin, version) : INDEPENDENT;
		exec := Cortera.proc_createExecutives(ds) : INDEPENDENT;
		attr := Cortera.proc_processAttributes(ds, Cortera.File_Attributes_In, version);

		lfnHdr := Cortera.Constants.sfCorteraHdr + '::' + version;
		lfnexecutives := Cortera.Constants.sfExecutives + '::' + version;
		lfnAttributes := Cortera.Constants.sfAttributes + '::' + version;

		return SEQUENTIAL(
			PARALLEL(
				OUTPUT(ds,,lfnHdr, COMPRESSED, OVERWRITE),
				OUTPUT(exec,,lfnexecutives, COMPRESSED, OVERWRITE),
				OUTPUT(attr,,lfnAttributes, COMPRESSED, OVERWRITE)
			)
			,
			PARALLEL(
				Cortera.Promote().CorteraHeader(lfnHdr),
				Cortera.Promote().Executives(lfnexecutives),
				Cortera.Promote().Attributes(lfnAttributes)
			)
		);
	
END;