IMPORT tools, Corp2_Raw_NY;

EXPORT Filenames(STRING  pversion = '',
	               BOOLEAN pUseOtherEnvironment = FALSE) := MODULE
								 
	EXPORT Input := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NY._Dataset(pUseOtherEnvironment).InputTemplate + tag;
		
		EXPORT MasterLatest := tools.mod_FilenamesInput(Template('Master::NY'), pversion);		
		EXPORT MergerLatest := tools.mod_FilenamesInput(Template('Merger::NY'), pversion);	
		
		EXPORT MasterSuper  := tools.mod_FilenamesInput(Template('ny::vendor_master'), pversion);		
		EXPORT MergerSuper  := tools.mod_FilenamesInput(Template('ny::vendor_merger'), pversion);
	END;

	EXPORT Base := MODULE
		SHARED Template(STRING tag) := Corp2_Raw_NY._Dataset(pUseOtherEnvironment).FileTemplate + tag;
		
		EXPORT Master   := tools.mod_FilenamesBuild(Template('Master::NY')  , pversion);
		EXPORT ProcAddr := tools.mod_FilenamesBuild(Template('ProcAddr::NY'), pversion);
		EXPORT RegAgent := tools.mod_FilenamesBuild(Template('RegAgent::NY'), pversion);
		EXPORT FictName := tools.mod_FilenamesBuild(Template('FictName::NY'), pversion);
		EXPORT Stock    := tools.mod_FilenamesBuild(Template('Stock::NY')   , pversion);
		EXPORT Chairman := tools.mod_FilenamesBuild(Template('Chairman::NY'), pversion);
		EXPORT ExecOff  := tools.mod_FilenamesBuild(Template('ExecOff::NY') , pversion);
		EXPORT OrigPart := tools.mod_FilenamesBuild(Template('OrigPart::NY'), pversion);
		EXPORT CurrPart := tools.mod_FilenamesBuild(Template('CurrPart::NY'), pversion);
		EXPORT Merger   := tools.mod_FilenamesBuild(Template('Merger::NY')  , pversion);

		EXPORT dAll_Master   := Master.dAll_filenames;
		EXPORT dAll_ProcAddr := ProcAddr.dAll_filenames;
		EXPORT dAll_RegAgent := RegAgent.dAll_filenames;
		EXPORT dAll_FictName := FictName.dAll_filenames;
		EXPORT dAll_Stock    := Stock.dAll_filenames;
		EXPORT dAll_Chairman := Chairman.dAll_filenames;
		EXPORT dAll_ExecOff  := ExecOff.dAll_filenames;
		EXPORT dAll_OrigPart := OrigPart.dAll_filenames;
		EXPORT dAll_CurrPart := CurrPart.dAll_filenames;
		EXPORT dAll_Merger   := Merger.dAll_filenames;
	END;
	
	EXPORT dAll_filenames :=  Base.dAll_Master   + 
														Base.dAll_ProcAddr + 
														Base.dAll_RegAgent +
														Base.dAll_FictName +
														Base.dAll_Stock    +
														Base.dAll_Chairman +	
														Base.dAll_ExecOff  +
														Base.dAll_OrigPart +	
														Base.dAll_CurrPart +														
														Base.dAll_Merger;
	
END;
