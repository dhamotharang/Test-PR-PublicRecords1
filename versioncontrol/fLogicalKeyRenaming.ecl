import doxie, lib_fileservices;
///////////////////////////////////////////////////////////////////////////
// -- Renames the logical keys contained in the superkeys passed in the dataset
// -- Finds all superkeys.
// -- according to the template passed in the dataset
// -- Can also pass in the version date to be stamped on the files/keys, overriding the default
// -- Also can pass in the regular expression to extract a string from the old filename(tries to get date by default)
//////////////////////////////////////////////////////////////////////////
/*
all_superkeynames := DATASET([

	 {'~thor_data400::key::busreg_company_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg::@version@::company.bdid'},
	 {'~thor_data400::key::busreg_contact_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg::@version@::contact.bdid'}

], versioncontrol.Layout_Superkeynames.InputLayout);

VersionControl.fLogicalKeyRenaming(all_superkeynames, false);
*/
///////////////////////////////////////////////////////////////////////////


export fLogicalKeyRenaming(

	 dataset(Layout_Superkeynames.InputLayout)	pAll_superkeynames
	,boolean 																		pIsTesting 					= true
	,string																			pVersion						= ''
	,string																			pRegex							= ''		//regex to pull string from old filename

) := FUNCTION


	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- fSetLogicalFilenames function
	////////////////////////////////////////////////////////////////////////////////////////////////////
	fSetLogicalFilenames(
						  dataset(layout_names)	pSubfiles
						 ,string 								plogicalkeynameversion
	) :=
	function
		
		layout_superkeynames.superfilerenaming tSetLogicalFilenames(pSubfiles l) :=
		transform
			
			dSuperkeyContainers		:= fileservices.LogicalFileSuperOwners(l.name);
			NumSuperKeycontainers	:= count(dSuperkeyContainers);

		
			superkeycontents := '~' + l.name;

			IsPoppRegex									:= pRegex		!= '';
			IsPoppVersion								:= pVersion != '';

			found_workunit_date_on_file := regexfind('w[0-9]{8}',superkeycontents	);
			found_date_on_file					:= regexfind('[0-9]{8}'	,superkeycontents	);
			found_pRegex_on_file 				:= regexfind(pRegex			,superkeycontents	);

			workunit_date_on_file 			:= regexfind('w[0-9]{8}',superkeycontents	,0)[2..];
			date_on_file								:= regexfind('[0-9]{8}'	,superkeycontents	,0)[1..];
			pRegex_on_file							:= regexfind(pRegex			,superkeycontents	,0)			;
			
			replacement_string := map(	 IsPoppVersion														=> pVersion
																	,IsPoppRegex		and found_pRegex_on_file	=> pRegex_on_file
																	,found_workunit_date_on_file							=> workunit_date_on_file
																	,found_date_on_file												=> date_on_file
																	,''
														);
			newname			:= regexreplace('@version@',plogicalkeynameversion,replacement_string);
											
									
			self.oldname								:= l.name								;
			self.newname								:= newname							;
			self.dSuperkeyContainers		:= dSuperkeyContainers	;
			self.NumSuperKeycontainers	:= NumSuperKeycontainers;
			     
		end;
		
		doproject := project(pSubfiles, tSetLogicalFilenames(left));
		
		return doproject;
		
	end;



	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get Subfiles, superfiles that contain that subfile, number of superfile containers, new logical keyname
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Layout_Superkeynames.OutputLayout tGetContents(Layout_Superkeynames.InputLayout l) :=
	transform
		
		dSuperfilecontents := fileservices.superfilecontents(l.superkeyname);

		self.dRenamingInfo	:= fSetLogicalFilenames(dSuperfilecontents, l.logicalkeynameversion);
	end;

	mySuperkeycontents			:= project(pAll_superkeynames, tGetContents(left));

	outputmySuperkeycontents	:= output(mySuperkeycontents);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tClearsuperfiles(DATASET(Layout_Superkeynames.superfilerenaming) pRenamingInfo) := 
		apply(pRenamingInfo, apply(dSuperkeyContainers, fileservices.ClearSuperFile('~' + name)));

	tRenameLogicalFile(DATASET(layout_superkeynames.superfilerenaming) pRenamingInfo) :=
		apply(pRenamingInfo(stringlib.stringtouppercase(oldname) != stringlib.stringtouppercase(newname) and newname != '' and NumSuperKeycontainers != 0)
			,fileservices.RenameLogicalFile(oldname,	newname));

	tAddSuperfile2(DATASET(layout_names) pSuperkeynames, string pNewName) :=
		apply(pSuperkeynames, fileservices.AddSuperFile('~' + Name,pNewname));
		
	tAddsuperfile(DATASET(layout_superkeynames.superfilerenaming) pRenamingInfo) := 
		apply(pRenamingInfo, tAddSuperfile2(dSuperkeyContainers, newname));

	Convert2NewNamingconvention := 
		APPLY(mySuperkeycontents,
			sequential(	tClearsuperfiles(	dRenamingInfo), 
						tRenameLogicalFile(	dRenamingInfo), 
						tAddsuperfile(		dRenamingInfo)));
				
				
	return if(pIsTesting = true, sequential(outputmySuperkeycontents), 
		sequential(
			 outputmySuperkeycontents
			,nothor(Convert2NewNamingconvention)));

end;