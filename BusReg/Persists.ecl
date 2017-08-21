import business_header;
export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
	
	shared pname := Persistnames(pUseOtherEnvironment);
	
	export StandardizeOldFile		:= Dataset(pname.StandardizeOldFile				,Layouts.Base.full,flat);
	export StandardizeInput			:= Dataset(pname.StandardizeInput					,Layouts.Base.full,flat);
//	export UpdateBase						:= Dataset(pname.UpdateBase								,Layout_Business_Contacts_Temp,flat);
//	export AppendIdsDid					:= Dataset(pname.AppendIdsDid							,Layout_Business_Contacts_Temp,flat);
//	export AppendIdsBdid				:= Dataset(pname.AppendIdsBdid						,Layout_BH_Best,flat);
	export AsBusinessHeader			:= Dataset(pname.AsBusinessHeader					,Business_Header.Layout_Business_Header_new		,flat);
	export AsBusinessContact		:= Dataset(pname.AsBusinessContact				,Business_Header.Layout_Business_Contact_Full	,flat);
        
end;