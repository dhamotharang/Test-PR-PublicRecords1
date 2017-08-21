import tools;

export Standardize_Phone(dataset(Layouts.Base.Main) pRawFileInput) :=
function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- add unique id
	// -- add proprietary dates
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Base.Main tPreProcessIndividuals(Layouts.Base.Main l) :=
	transform

		self.clean_phones.Phone									:= ''	;
		self.clean_phones.Fax										:= ''	;
		self																		:= l	;
		
	end;
	
	dPreProcess := project(pRawFileInput, tPreProcessIndividuals(left));

	tools.mac_AppendCleanPhone(dPreProcess		,rawaddressfields.Phone	,dzoomwithphone	,clean_phones.Phone	,,true);
	tools.mac_AppendCleanPhone(dzoomwithphone	,rawaddressfields.Fax		,dzoomwithfax		,clean_phones.Fax		,,true);

	return dzoomwithfax;


end;
