import business_header;

export Persists(

	boolean	pUseOtherEnvironment = false

) :=
module

	export Organizations						:= dataset(Persistnames(pUseOtherEnvironment).ParseInput.Organizations						,layouts.Input.Parsed.Organizations								,flat);
	export Affiliated_Individuals		:= dataset(Persistnames(pUseOtherEnvironment).ParseInput.AffiliatedIndividuals		,layouts.Input.Parsed.Affiliated_Individuals			,flat);
	export Unaffiliated_Individuals	:= dataset(Persistnames(pUseOtherEnvironment).ParseInput.UnaffiliatedIndividuals	,layouts.Input.Parsed.Unaffiliated_Individuals		,flat);
	export AsBusinessContact				:= dataset(Persistnames(pUseOtherEnvironment).AsBusinessContact										,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export AsBusinessHeader					:= dataset(Persistnames(pUseOtherEnvironment).AsBusinessHeader										,business_header.Layout_Business_Header_New				,flat);

end;