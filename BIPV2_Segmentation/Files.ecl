import tools;

export Files(string pversion = '',boolean pUseOtherEnvironment = false) := module

     export segmentationFile     := filenames(pversion,pUseOtherEnvironment).BIPSeleIDSegs;
	
     export FILE_LOGICAL     := segmentationFile.New;
     export FILE_BASE        := segmentationFile.QA;
     export FILE_FATHER      := segmentationFile.Father;
     export FILE_GRANDFATHER := segmentationFile.GrandFather;
	
	export DS_LOGICAL           := tools.macf_FilesBase(segmentationFile, Layouts.SegmentationLayout).New;
	export DS_BASE              := tools.macf_FilesBase(segmentationFile, Layouts.SegmentationLayout).QA;
	export DS_FATHER            := tools.macf_FilesBase(segmentationFile, Layouts.SegmentationLayout).Father;
	export DS_GRANDFATHER       := tools.macf_FilesBase(segmentationFile, Layouts.SegmentationLayout).Grandfather;
	
     export updateSuperFiles(string inFile) := function
          action := SEQUENTIAL(
               FileServices.PromoteSuperFileList([FILE_BASE,
                                                  FILE_FATHER,
                                                  FILE_GRANDFATHER], inFile, true)
		);
		return action;
	end;
end;