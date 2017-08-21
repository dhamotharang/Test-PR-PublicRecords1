import business_header,poe;

export Persists(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	shared pname := Persistnames(pUseOtherEnvironment);
	
//	export StandardizeInput				:= Dataset(pname.StandardizeInput					,Layouts.Base																			,flat);
	export PrepFile								:= Dataset(pname.PrepFile									,Layouts.input.Sprayed				,flat);
	export AppendAID							:= Dataset(pname.AppendAID								,Layouts.base.companies				,flat);
	export AsBusinessHeader				:= Dataset(pname.AsBusinessHeader					,business_header.Layout_Business_Header_New				,flat);
	export AsBusinessContact			:= Dataset(pname.AsBusinessContact				,Business_Header.Layout_Business_Contact_Full_New	,flat);
//	export AppendIdsfAppendDid		:= Dataset(pname.AppendIdsfAppendDid			,Layouts.Base																			,flat);
//	export AppendIdsfAppendBdid		:= Dataset(pname.AppendIdsfAppendBdid			,Layouts.Base																			,flat);
	export IngestCompanies				:= Dataset(pname.IngestCompanies					,Layouts.base.companies										,flat);
	export IngestContacts					:= Dataset(pname.IngestContacts						,Layouts.base.contacts														,flat);
	export FileCompaniesV1Input		:= Dataset(pname.FileCompaniesV1Input			,Layouts.base.companies												,flat);
	export FileContactsV1Input		:= Dataset(pname.FileContactsV1Input			,Layouts.base.contacts														,flat);
end;
