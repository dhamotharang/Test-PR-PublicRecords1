import BIPV2, BIPV2_Build, VersionControl;

EXPORT Proc_Build_BIP_Business_Contact(
					 string		pversion
					,dataset(recordof(BIPV2_Build.key_contact_linkids.key)		) pKey_Business_Contacts	= BIPV2_Build.key_contact_linkids.key
) := module

	shared Layout_BC := record
			BIPV2.IDlayouts.l_xlink_ids; 
			BIPV2.Layout_Business_Linking_Full;
			boolean executive_ind:='';
			integer executive_ind_order:=0;
	end;

	shared dBip_BC_base := project(pKey_Business_Contacts, Layout_BC);
	
	shared logicalfile_name := '~thor_data400::base::bipv2::business_header::'+pversion+'::contacts';
	
	VersionControl.macBuildNewLogicalFile(logicalfile_name	,dBip_BC_base	,Build_BIP_BizContact);

	export all := 
	sequential(
			Build_BIP_BizContact
			,promote(pversion,'^.*?base::BIPV2::business_header*').buildBasefiles.new2built
			,promote(pversion,'^.*?base::BIPV2::business_header*').buildBasefiles.built2qa
	);

end;