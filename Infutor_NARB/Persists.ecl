
export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module

	shared pname := Persistnames(pUseOtherEnvironment);
	
	export StandardizeInput				:= Dataset(pname.StandardizeInput			,Layouts.Base	,flat);
	export StandardizeNameAddr		:= Dataset(pname.StandardizeNameAddr	,Layouts.Base	,flat);
	export AppendIds							:= Dataset(pname.AppendIds						,Layouts.Base	,flat);

end;