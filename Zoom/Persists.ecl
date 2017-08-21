import business_header;

export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module

	shared pname := Persistnames;
	
	export StandardizeInput		:= Dataset(pname.StandardizeInput			,Layouts.Base																			,flat);
	export UpdateBase					:= Dataset(pname.UpdateBase						,Layouts.Base																			,flat);
	export AppendIdsDid				:= Dataset(pname.AppendIdsDid					,Layouts.Base																			,flat);
	export AppendIdsBdid			:= Dataset(pname.AppendIdsBdid				,Layouts.Base																			,flat);
	export AsBusinessHeader		:= Dataset(pname.AsBusinessHeader			,business_header.Layout_Business_Header_New				,flat);
	export AsBusinessContact	:= Dataset(pname.AsBusinessContact		,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export AsBusinessLinking	:= Dataset(pname.AsBusinessLinking		,Business_Header.Layout_Business_Linking.Linking_Interface	,flat);


end;