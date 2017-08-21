EXPORT Rollback(DATASET(bair.layouts.rBldSegmentStatus) failedseg, boolean pDelta) := module
	
	FileSnapDS 	:= dataset(bair.Superfile_List().FilesSnap, Bair.layouts.rFileList, thor) : GLOBAL(FEW);
	
	FailedSegments := join(FileSnapDS, failedseg, left.seg = right.seg);
	uniqSF 				 := dedup(FailedSegments, supername, all) : GLOBAL(FEW);
	
	ClearSF := sequential(
						fileservices.StartSuperFileTransaction(),
						nothor(apply(FailedSegments, FileServices.ClearSuperFile('~'+ supername))),
						fileservices.FinishSuperFileTransaction()
						);
						
	AddLFtoSF := sequential(
						fileservices.StartSuperFileTransaction(),						
						nothor(apply(uniqSF(seg = 5), FileServices.AddSuperFile('~'+ supername, '~' + subname))),
						fileservices.FinishSuperFileTransaction()
						);
						
	EXPORT prev_state := sequential(ClearSF, AddLFtoSF);

End;