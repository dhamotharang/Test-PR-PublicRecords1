import doxie, lib_fileservices,std;
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
], Tools.Layout_SuperFilenames.InputLayout);
Tools.fun_RenameFiles(all_superkeynames, false);
*/
///////////////////////////////////////////////////////////////////////////
export fun_RenameFiles(

	 dataset(Layout_SuperFilenames.InputLayout)	pAll_superkeynames
	,boolean 																		pIsTesting 					= true
	,string																			pVersion						= ''
	,string																			pRegex							= ''		//regex to pull string from old filename
	,string																			pSubfilefilterRegex	= ''		//regex to filter subfile(s)

) :=
FUNCTION
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- fSetLogicalFilenames function
	////////////////////////////////////////////////////////////////////////////////////////////////////
	fSetLogicalFilenames(
						  dataset(Layout_Names)	pSubfiles
						 ,string 								plogicalkeynameversion
	) :=
	function
		
		Layout_SuperFilenames.superfilerenaming tSetLogicalFilenames(pSubfiles l) :=
		transform
			
			dSuperkeyContainers		:= fileservices.LogicalFileSuperOwners('~' + l.name);
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
											
									
			self.oldname								:= superkeycontents			;
			self.newname								:= newname							;
			self.dSuperkeyContainers		:= dSuperkeyContainers	;
			self.NumSuperKeycontainers	:= NumSuperKeycontainers;
      self.exists_new_name        := std.file.fileexists(self.newname);
      self.will_rename            := not self.exists_new_name;
			     
		end;
		
		doproject := project(pSubfiles, tSetLogicalFilenames(left));
		
		return doproject;
		
	end;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get Subfiles, superfiles that contain that subfile, number of superfile containers, new logical keyname
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	Layout_SuperFilenames.OutputLayout tGetContents(Layout_SuperFilenames.InputLayout l) :=
	transform
		
		dSuperfilecontents := fileservices.superfilecontents(l.superkeyname);
		dsetlogicalfns := fSetLogicalFilenames(dSuperfilecontents, l.logicalkeynameversion)(if(pSubfilefilterRegex != '',regexfind(pSubfilefilterRegex	,oldname, nocase),true));
		self.dRenamingInfo	:= if(exists(dsetlogicalfns), dsetlogicalfns, dataset([],Layout_SuperFilenames.superfilerenaming));
	end;
	
	mySuperkeycontents				:= global(nothor(project(pAll_superkeynames, tGetContents(left))(exists(dRenamingInfo))),few);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Clear Child Dataset of superfile containers, rename logical file, add back to Child dataset of superfile containers
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	tClearsuperfiles(DATASET(Layout_SuperFilenames.superfilerenaming) pRenamingInfo) := 
		apply(pRenamingInfo, apply(dSuperkeyContainers, fileservices.ClearSuperFile('~' + name)));
	tRenameLogicalFile(DATASET(Layout_SuperFilenames.superfilerenaming) pRenamingInfo) :=
		apply(pRenamingInfo	,fileservices.RenameLogicalFile(oldname,	newname));
	tAddSuperfile2(DATASET(Layout_Names) pSuperkeynames, string pNewName) :=
		apply(pSuperkeynames, fileservices.AddSuperFile('~' + Name,pNewname));
		
	tAddsuperfile(DATASET(Layout_SuperFilenames.superfilerenaming) pRenamingInfo) := 
		apply(pRenamingInfo, tAddSuperfile2(dSuperkeyContainers, newname));
	
	loldname := if(mySuperkeycontents.dRenamingInfo.oldname[1] = '~'
								,stringlib.stringtouppercase(mySuperkeycontents.dRenamingInfo.oldname[2..])
								,stringlib.stringtouppercase(mySuperkeycontents.dRenamingInfo.oldname)
							);
	
	lnewname := if(mySuperkeycontents.dRenamingInfo.newname[1] = '~'
								,stringlib.stringtouppercase(mySuperkeycontents.dRenamingInfo.newname[2..])
								,stringlib.stringtouppercase(mySuperkeycontents.dRenamingInfo.newname)
							);
	filterdups := 		loldname																								!= lnewname 
								and mySuperkeycontents.dRenamingInfo.newname								!= '' 
								and mySuperkeycontents.dRenamingInfo.NumSuperKeycontainers	!= 0
                and mySuperkeycontents.dRenamingInfo.will_rename            = true
								;
	
	Convert2NewNamingconvention := 
		APPLY(mySuperkeycontents,
			sequential(
				 tClearsuperfiles		(	dRenamingInfo(filterdups))
				,tRenameLogicalFile	(	dRenamingInfo(filterdups))
				,tAddsuperfile			(	dRenamingInfo(filterdups))
			)
		);
				
	outputmySuperkeycontents	:= output(mySuperkeycontents,all);
				
	return 
	sequential(
		 outputmySuperkeycontents
		,if(not pIsTesting
			,nothor(Convert2NewNamingconvention)
		)
	);
	
end;
