EXPORT BuildData(string version) := FUNCTION

		hdrin := cortera.Files.File_Header_In;

		ds := Cortera.proc_processHeader(hdrin, version) : INDEPENDENT;
		exec := Cortera.proc_createExecutives(ds) : INDEPENDENT;
		linkid := Cortera.proc_createExecLinkID(ds) : INDEPENDENT;
		attr := Cortera.proc_processAttributes(ds, Cortera.Files.File_Attributes_In, version);

		lfnHdr := Cortera.Constants.sfCorteraHdr + '::' + version;
		lfnexecutives := Cortera.Constants.sfExecutives + '::' + version;
		lfnexeclinkid := Cortera.Constants.sfExecLinkID + '::' + version;
		lfnAttributes := Cortera.Constants.sfAttributes + '::' + version;

		return SEQUENTIAL(
			PARALLEL(
				OUTPUT(ds,,lfnHdr, COMPRESSED, OVERWRITE),				
				OUTPUT(exec,,lfnexecutives, COMPRESSED, OVERWRITE),
				OUTPUT(linkid,,lfnexeclinkid, COMPRESSED, OVERWRITE),
				OUTPUT(attr,,lfnAttributes, COMPRESSED, OVERWRITE)
			)
			,
			PARALLEL(
				Cortera.Promote().CorteraHeader(lfnHdr),
				Cortera.Promote().Executives(lfnexecutives),
				Cortera.Promote().Execlinkid(lfnexeclinkid),
				Cortera.Promote().Attributes(lfnAttributes)
			)
		);
	
END;