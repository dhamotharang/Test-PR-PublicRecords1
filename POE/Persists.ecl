export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module

	shared lpersistnames := persistnames(pUseOtherEnvironment);

	export AppendIdsfAppendDid	:= dataset(lpersistnames.AppendIdsfAppendDid		,Layouts.Base,flat);
	export AppendIdsfAppendBdid	:= dataset(lpersistnames.AppendIdsfAppendBdid		,Layouts.Base,flat);
	export AppendIdsfAppendSSN	:= dataset(lpersistnames.AppendIdsfAppendSSN		,Layouts.Base,flat);
	export AppendIdsfAppendFein	:= dataset(lpersistnames.AppendIdsfAppendFein		,Layouts.Base,flat);
	export RollupBase						:= dataset(lpersistnames.RollupBase							,Layouts.Base,flat);

end;