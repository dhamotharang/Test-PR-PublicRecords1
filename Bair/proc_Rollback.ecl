import PromoteSupers;

EXPORT proc_Rollback(boolean pDelta) := module
	
	//1 - Payload Base Full, 2 - Payload Key Full, 3 - PS Base Full, 4 - PS Key Full, 5 - Boolean Key Full
	//1 - Payload Base Delta, 2 - Payload Key Delta, 3 - PS Base Delta, 4 - PS Key Delta, 5 - Boolean Key Delta
	
	FailedSegmentDS := Dataset([{1,true}, {2,true}, {3,true}, {4,true}, {5,true}], bair.layouts.rBldSegmentStatus);
	PromoteSupers.MAC_SF_BuildProcess(FailedSegmentDS
												,if(pDelta, bair.Superfile_List().BldStatusDelta, bair.Superfile_List().BldStatusFull)
												,Post_DefaultSegStatusToFail
												,2
												,
												,true);
	
	FailedDeltaSeg 	:= dataset(bair.Superfile_List().BldStatusDelta, bair.layouts.rBldSegmentStatus, flat, opt);
	FailedFullSeg 	:= dataset(bair.Superfile_List().BldStatusFull, bair.layouts.rBldSegmentStatus, flat, opt);
	
	FailedSegments := if(pDelta, FailedDeltaSeg, FailedFullSeg)(failed = true);
											
	EXPORT req_segs := if(count(FailedSegments) > 0
											,sequential(
												 output('Prev Build Failed, Rollback Required', named('RollbackReq'))
												// ,Bair.Rollback(FailedSegments, pDelta).prev_state
											 )
											,sequential(
												output('Prev Build Succeeded, Rollback Not Required', named('RollbackNotReq'))
											 ,Bair.Post_FilesSnap.all
											 ,Post_DefaultSegStatusToFail
											 )
											);
	
End;