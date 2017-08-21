import USPIS_HotList,ut;

export Prep_USPIS_HotList(

	 dataset(USPIS_HotList.Layouts.Base	) pUSPIS_HotList	= USPIS_HotList.Files().base.qa
	,string																pFilterDate			= _Dataset().CurrentDate
	,boolean															pShouldRecaculatePersist	= _Dataset().ShouldRecaculatePersist

) :=
function

	dRecent := pUSPIS_HotList(
			 (unsigned8)dt_first_reported != 0
			,(unsigned8)(dt_first_reported[1..6]) <= (unsigned8)pFilterDate[1..6]
	);
	
	dreturn := dedup(project(dRecent	,transform(layouts.temporary.PrepUSPISHotList, self := left)), ace_aid,all)
		: persist(persistnames().PrepUSPIS_HotList);

	return if(pShouldRecaculatePersist,dreturn,persists().PrepUSPIS_HotList);
	
end;