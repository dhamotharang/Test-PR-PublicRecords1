import tools;

export Files(string pversion = '',boolean pUseOtherEnvironment = false) := module

     export crosswalkFile    := filenames(pversion,pUseOtherEnvironment).crossWalkFile;
	
     export FILE_LOGICAL     := crosswalkFile.New;
     export FILE_BASE        := crosswalkFile.QA;
     export FILE_FATHER      := crosswalkFile.Father;
     export FILE_GRANDFATHER := crosswalkFile.GrandFather;
	
	export DS_LOGICAL           := tools.macf_FilesBase(crosswalkFile, Layouts.CrossWalkRec).New;
	export DS_BASE              := tools.macf_FilesBase(crosswalkFile, Layouts.CrossWalkRec).QA;
	export DS_FATHER            := tools.macf_FilesBase(crosswalkFile, Layouts.CrossWalkRec).Father;
	export DS_GRANDFATHER       := tools.macf_FilesBase(crosswalkFile, Layouts.CrossWalkRec).Grandfather;
	
     export updateSuperFiles(string inFile) := function
          action := SEQUENTIAL(
               FileServices.PromoteSuperFileList([FILE_BASE,
                                                  FILE_FATHER,
                                                  FILE_GRANDFATHER], inFile, true)
		);
		return action;
	end;
end;
