import POE,mdr,gong_v2,utilfile;

export As_POE(

	 dataset(layouts.base	) pPOEUtilityBase	= Files().base.qa

) :=
function
	
	return project(pPOEUtilityBase	,transform(POE.Layouts.Base, self := left));

end;