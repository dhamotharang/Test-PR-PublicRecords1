export Update_Base(

	 string									pversion
	,boolean								pPullSourceDataFromProd	= false													
	,dataset(layouts.base)	pSource_Data						= Source_Data(pPullSourceDataFromProd)

) :=
function

	dConcat						:= _Filters.SourceData(pSource_Data);

	dAppend_Ids				:= Append_Ids.fall	(dConcat			);
	dFilter 					:= _Filters.Base_out(dAppend_Ids	);
	dRollup_Base 			:= Rollup_Base			(dFilter			);
	dAdd_Dummy	 			:= Add_Dummy				(pversion,dRollup_Base	);

	return dAdd_Dummy;

end;