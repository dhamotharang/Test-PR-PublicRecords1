import BIPV2, VersionControl;

EXPORT Proc_Build_BIP_Business_Contact(
					 string		pversion
					,dataset(PRTE2_BIPV2_BusHeader.Layouts.Base.Layout_Contacts) 	pBC_Final	= BC_Init_Final()
) := module

	shared dBip_BC_base := pBC_Final;
	
	shared names := filenames(pversion).base;
	
	shared logicalfile_name := names.ContactBase.new;
	
	VersionControl.macBuildNewLogicalFile(logicalfile_name	,dBip_BC_base	,Build_BIP_BizContact);

	export all := 
	sequential(
			Build_BIP_BizContact
			,promote(pversion,'^.*?base::BIPV2_business_header*').new2built
			,promote(pversion,'^.*?base::BIPV2_business_header*').built2qa
	);

end;