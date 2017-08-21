import TopBusiness,tools;

export Proc_Build_Files_External(
	dataset(TopBusiness.Layout_Linking.Linked) in_linking_0,
	string version) := function
	
	in_linking := in_linking_0;

	sourcefile := dedup(
		distribute(
			project(
				in_linking(source != '' and source_docid != ''),
				TopBusiness_External.Layouts.Source),
			hash(source,source_docid,source_party)),
		source,source_docid,source_party,bid,all,local);
	
	addressfile_0 := dedup(
		distribute(
			project(
				in_linking((unsigned3)zip != 0 and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and company_name != ''),
				TopBusiness_External.Layouts.Address),
			hash(zip,prim_name,prim_range)),
		zip,prim_name,prim_range,company_name,bid,all,local);
	TopBusiness.Macro_CleanCompanyName(addressfile_0,company_name,company_name,addressfile);
	
	feinfile_0 := dedup(
		distribute(
			project(
				in_linking(fein != '' and company_name != ''),
				TopBusiness_External.Layouts.FEIN),
			hash(fein)),
		fein,company_name,bid,all,local);
	TopBusiness.Macro_CleanCompanyName(feinfile_0,company_name,company_name,feinfile);
	
	phonefile_0 := dedup(
		distribute(
			project(
				in_linking(phone != '' and company_name != ''),
				TopBusiness_External.Layouts.Phone),
			hash(phone)),
		phone,company_name,bid,all,local);
	TopBusiness.Macro_CleanCompanyName(phonefile_0,company_name,company_name,phonefile);
	
	tools.mac_WriteFile(Filenames(version).Source.New,sourcefile,Build_External_Source_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Address.New,addressfile,Build_External_Address_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).FEIN.New,feinfile,Build_External_FEIN_File,pShouldExport := false);
	tools.mac_WriteFile(Filenames(version).Phone.New,phonefile,Build_External_Phone_File,pShouldExport := false);

	return
		if(tools.fun_IsValidVersion(version)
			,sequential(
				parallel(
					Build_External_Source_File,
					Build_External_Address_File,
					Build_External_FEIN_File,
					Build_External_Phone_File),
				Promote(version).buildfiles.New2Built
			)		
			,output('No Valid version parameter passed, skipping BRM_External.Proc_Build_Files_External atribute')
		);

end;
