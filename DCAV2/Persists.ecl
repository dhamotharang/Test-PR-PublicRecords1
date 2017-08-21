import poe,business_header;

export Persists(
	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland
) :=
module
	shared pname := Persistnames(pUseOtherEnvironment);
	
//	export AsPOE										:= Dataset(pname.AsPOE									,POE.Layouts.Base														,flat);
	export AsBusinessHeader					:= Dataset(pname.AsBusinessHeader				,business_header.Layout_Business_Header_New				,flat);
	export AsBusinessContact				:= Dataset(pname.AsBusinessContact			,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export IngestCompanies					:= Dataset(pname.IngestCompanies				,layouts.temporary.companies_aid_prep				,flat);
	export IngestContacts						:= Dataset(pname.IngestContacts					,layouts.temporary.contacts_aid_prep				,flat);
	export AppendAIDCompanies				:= Dataset(pname.AppendAIDCompanies			,layouts.temporary.companies_aid_prep				,flat);
	export AppendBDIDCompanies			:= Dataset(pname.AppendBDIDCompanies		,layouts.temporary.companies_aid_prep				,flat);
	export AppendPhonesCompanies		:= Dataset(pname.AppendPhonesCompanies	,layouts.temporary.companies_aid_prep				,flat);
//	export PrepInputAppendDates			:= Dataset(pname.PrepInputAppendDates		,{unsigned8 maxlncaGHID,string levels,string lncaGHIDs {maxlength(100000)},layouts.temporary.big}				,flat);
	export SplitInputCompanies			:= Dataset(pname.SplitInputCompanies		,layouts.temporary.companies_aid_prep				,flat);
	export SplitInputContacts				:= Dataset(pname.SplitInputContacts			,layouts.temporary.contacts_aid_prep				,flat);
	export PrepInput								:= Dataset(pname.PrepInput							,layouts.temporary.big											,flat);
	export AppendAIDContacts				:= Dataset(pname.AppendAIDContacts			,layouts.temporary.contacts_aid_prep				,flat);
	export AppendDIDContacts				:= Dataset(pname.AppendDIDContacts			,layouts.temporary.contacts_aid_prep				,flat);
	export AppendBDIDContacts				:= Dataset(pname.AppendBDIDContacts			,layouts.temporary.contacts_aid_prep				,flat);
	export AppendPhonesContacts			:= Dataset(pname.AppendPhonesContacts		,layouts.temporary.contacts_aid_prep				,flat);
  export UpdateContacts     		  := Dataset(pname.UpdateContacts         ,layouts.base.contacts                      ,flat);
	export FileKeybuild							:= Dataset(pname.FileKeybuild						,layouts.base.keybuild											,flat);
	export FileHierarchy						:= Dataset(pname.FileHierarchy					,layouts.temporary.hierarchy								,flat);

end;
