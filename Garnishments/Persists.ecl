import business_header;

export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module

	shared pname := Persistnames(pUseOtherEnvironment);
	
	export StandardizeInput				:= Dataset(pname.StandardizeInput					,Layouts.Base																			,flat);
	export AsPOE									:= Dataset(pname.AsBusinessHeader					,business_header.Layout_Business_Header_New				,flat);
	export AsBusinessHeader				:= Dataset(pname.AsBusinessHeader					,business_header.Layout_Business_Header_New				,flat);
	export AsBusinessContact			:= Dataset(pname.AsBusinessContact				,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export AppendIdsfAppendDid		:= Dataset(pname.AppendIdsfAppendDid			,Layouts.Base																			,flat);
	export AppendIdsfAppendBdid		:= Dataset(pname.AppendIdsfAppendBdid			,Layouts.Base																			,flat);


end;