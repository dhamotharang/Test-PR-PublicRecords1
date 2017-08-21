import PromoteSupers;

EXPORT UpdateCheckPt(unsigned1 pos, boolean pDelta = false) := function

	BldChkPt := dataset([{pos}], {unsigned1 pos});
	PromoteSupers.MAC_SF_BuildProcess(BldChkPt
												,bair.Superfile_List(pDelta).BldChkPt
												,PostBldChkPt
												,2
												,
												,true,thorlib.wuid()+pos);

	return PostBldChkPt;

End;