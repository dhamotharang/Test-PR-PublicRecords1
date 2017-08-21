import LaborActions_MSHA, versioncontrol, _control, ut;

//This function determines if there are duplicate mine_ids in the mine file.  If duplicate
//mine_ids exist, fail the job and contact the vendor.
export fIs_MineIds_Unique(dataset(Layouts_Mine.Input)	pMine) := FUNCTION

	CNT_Unique_MineIds 	:= COUNT(DEDUP(SORT(pMine,Mine_Id),Mine_Id));
	CNT_Mine_MineIds 		:= COUNT(pMine);

	Return(IF (CNT_Mine_MineIds = CNT_Unique_MineIds,True,False));

end;