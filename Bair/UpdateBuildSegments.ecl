import PromoteSupers;

EXPORT UpdateBuildSegments(unsigned no, boolean status = false, boolean pDelta = false) := function

	BldSegFull := dataset(bair.Superfile_List().BldStatusFull, Bair.layouts.rBldSegmentStatus, flat, opt);
	BldSegDelta := dataset(bair.Superfile_List().BldStatusDelta, Bair.layouts.rBldSegmentStatus, flat, opt);
	
	BldSeg := if(pDelta, BldSegDelta, BldSegFull);
	
	SegmentDS := BldSeg(seg <> no) + dataset([{no, status}], Bair.layouts.rBldSegmentStatus);
	PromoteSupers.MAC_SF_BuildProcess(SegmentDS
												,if(pDelta, bair.Superfile_List().BldStatusDelta, bair.Superfile_List().BldStatusFull)
												,PostBldSegmentStatus
												,2
												,
												,true,thorlib.wuid()+no);

	return PostBldSegmentStatus;

End;