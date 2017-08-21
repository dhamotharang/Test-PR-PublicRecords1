import poe;

export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module

	shared pname := Persistnames(pUseOtherEnvironment);
	
	export AsPOE		:= Dataset(pname.AsPOE					,POE.Layouts.Base				,flat);


end;