import versioncontrol;
export Files(

	 string		pversion = ''
	,boolean	pUseOtherEnvironment = false

) :=
module

	shared lnames := Filenames(pversion,pUseOtherEnvironment);

	export Input :=
	module
	
		versioncontrol.macInputFileVersions(lnames.Input.Dell, layouts.Input.Dell, Dell);
	
	end;

	versioncontrol.macInputFileVersions(lnames.Dell_return, layouts.Dell_return, Dell_return,'CSV',pHeading := 1);
	
	versioncontrol.macBuildFileVersions(lnames.Address_Summary 	,Layouts.layaddr 	,Address_Summary 	);
	versioncontrol.macBuildFileVersions(lnames.Business_Summary	,Layouts.laybus		,Business_Summary	);
	versioncontrol.macBuildFileVersions(lnames.Contact_Summary 	,Layouts.laycont 	,Contact_Summary 	);
	versioncontrol.macBuildFileVersions(lnames.dell_out 				,layouts.Base 		,Dell_out				 	);
	versioncontrol.macBuildFileVersions(lnames.dell_out_append	,Layouts.OutAppend,Dell_out_Append 	);
	versioncontrol.macBuildFileVersions(lnames.dell_out_append_csv	,Layouts.OutAppend,Dell_out_Append_csv 	);

end;