import business_header,poe;
export Persists(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	shared pname := Persistnames(pUseOtherEnvironment);
	
//	export StandardizeInput				:= Dataset(pname.StandardizeInput					,Layouts.Base																			,flat);
	export PrepFile								:= Dataset(pname.PrepFile									,Layouts.input.Sprayed				,flat);
	export AppendAID							:= Dataset(pname.AppendAID								,Layouts.base				,flat);
	export AppendWorkPhone				:= Dataset(pname.AppendWorkPhone					,Layouts.base			,flat);
	export AppendBdid							:= Dataset(pname.AppendBdid								,Layouts.base				,flat);
	export AppendBdidSupplemental	:= Dataset(pname.AppendBdidSupplemental		,Layouts.base				,flat);

end;
