pversion		:= '20080425b'			;
PackageName	:= 'BusinessHeader'	;	
IsTesting		:= false						;	//Set to false to actually rename

#workunit ('name', 'Rebuild Business Relatives files/keys' + pversion);
#workunit ('protect', true);

sequential(

	 Business_Header.proc_build_business_header_base_files(pversion).BuildRelatives
	,Business_Header.Strata_Population_Stats							(pversion).Business_Relatives	
	,Business_Header.proc_build_business_header_base_files(pversion).BuildRelativesGroup
	,Business_Header.proc_build_business_header_base_files(pversion,,,,Business_Header.BH_Stat(pversion,Business_Header.Files().Base.Business_Headers.qa)).BuildStat
	,Business_Header.promote															(pversion,'base').new2built
	,Business_Header_SS.proc_build_Business_Header_Keys		(pversion).Build_Supergroup_File
	,business_header.promote															(pversion,'base').new2built
	,Business_Header_SS.proc_build_Business_Header_Keys		(pversion).Build_Relatives_Bdid1_Key
	,Business_Header_SS.proc_build_Business_Header_Keys		(pversion).Build_RelativesGroup_Groupid_Key
	,Business_Header_SS.proc_build_Business_Header_Keys		(pversion).Build_Supergroup_Groupid_Key	
	,Business_Header_SS.proc_build_Business_Header_Keys		(pversion).Build_Supergroup_Bdid_Key		
	,business_header.promote															(pversion,'^(?!.*moxie)(.*?)key(.*?)$').new2built
	,business_header.Promote2QA
	,Business_Header.Proc_Rename_Logical_Keys							(pversion, PackageName,IsTesting)

) : success(Business_Header.Send_Email(pversion).Roxie.BusinessEmail), failure(Business_Header.Send_Email(pversion).BuildFailure);