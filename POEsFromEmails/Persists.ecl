import business_header;

export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

) :=
module

	shared pname := Persistnames(pUseOtherEnvironment);
	
	//export AsBusinessHeader				:= Dataset(pname.AsBusinessHeader					,business_header.Layout_Business_Header_New				,flat);
	//export AsBusinessContact			:= Dataset(pname.AsBusinessContact				,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export AsPOE									:= Dataset(pname.AsPOE										,Business_Header.Layout_Business_Contact_Full_New	,flat);
	export GetUidPatterns					:= Dataset(pname.GetUidPatterns						,layouts.EmailWithUidPatternTagAndCount																			,flat);
	export AddDomainBDID2Emails		:= Dataset(pname.AddDomainBDID2Emails			,layouts.EmailsWithRegistrantInfo																			,flat);
	//export AttachBestBDIDAddrPh		:= Dataset(pname.AttachBestBDIDAddrPh			,Layouts.Base																			,flat);


end;