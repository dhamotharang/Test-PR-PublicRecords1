import tools;

EXPORT BuildData(string pversion) := FUNCTION

		In_Hdr  := Cortera.Files().Input.In_Hdr.using;
		In_Attr := Cortera.Files().Input.In_stats.using;

		NewHdrBase 				:= Cortera.proc_processHeader(In_Hdr, pversion) : INDEPENDENT;
		NewExecBase 			:= Cortera.proc_createExecLinkID(NewHdrBase) : INDEPENDENT;
		NewAttrBase 			:= Cortera.proc_processAttributes(NewHdrBase, In_Attr, pversion);

		tools.mac_WriteFile(Filenames(pversion).base.Header.new			,NewHdrBase					,Build_Hdr_Base_File				,pShouldExport := false);
		tools.mac_WriteFile(Filenames(pversion).base.Executives.new	,NewExecBase				,Build_Exec_Base_File				,pShouldExport := false);
		tools.mac_WriteFile(Filenames(pversion).base.Attributes.new	,NewAttrBase				,Build_Attr_Base_File				,pShouldExport := false);

		return if(tools.fun_IsValidVersion(pversion)
							,sequential(
													Cortera.Promote().Inputfiles.Sprayed2Using,
													Build_Hdr_Base_File,
													parallel(
														Build_Exec_Base_File,
														Build_Attr_Base_File
														),
													Promote(pversion,'base').buildfiles.New2Built;													
												)
							,output('No Valid version parameter passed, skipping Cortera.BuildData atribute') 
					 );
END;