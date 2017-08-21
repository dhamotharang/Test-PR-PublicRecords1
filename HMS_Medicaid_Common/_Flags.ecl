import _control, VersionControl, HMS_Medicaid_Common;

export _Flags(STRING2 Medicaid_State,string pInput_Name='', string pBase_Name='')  := module
	export IsTesting								:= VersionControl._Flags.IsDataland;
	export UseStandardizePersists		:= not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
	export ExistCurrentSprayed			:= fileservices.superfileexists(HMS_Medicaid_Common.FileNames(Medicaid_State,pInput_Name,).lInputTemplate) and 
																		 count(fileservices.superfilecontents(HMS_Medicaid_Common.FileNames(Medicaid_State,pInput_Name,).lInputTemplate  )) > 0  ;
	export ExistBaseFile						:= count(nothor(fileservices.superfilecontents(HMS_Medicaid_Common.FileNames(Medicaid_State,pBase_name,).base.qa))) > 0;	
	export Update										:= ExistCurrentSprayed and ExistBaseFile;
	export IsUpdateFullFile					:= false;
end;
