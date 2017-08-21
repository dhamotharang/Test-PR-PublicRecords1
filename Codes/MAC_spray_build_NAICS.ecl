import Codes,lib_fileservices,tools,_control,RoxieKeyBuild,ut;

export MAC_spray_build_NAICS(
	 string		pversion			= ''
	,string		pServerIP			= _control.IPAddress.edata12
	,string		pDirectory		= '/hds_4/oshair/data/lookup'
	,string		pFilename			= 'naics07_prepped.txt'
	,string		pGroupName		= tools.fun_Groupname()																		
	,boolean	pIsTesting		= false
	,boolean	pOverwrite		= false
	,string		pNameOutput		= 'NAICS Spray Info'	

) := 
function

	lversiondate := pversion;
	
	Inputname			:= tools.mod_FilenamesInput('~thor_data400::in::NAICS::@version@::temp_data'			,lversiondate);
	basename			:= tools.mod_FilenamesBuild('~thor_data400::base::NAICS::@version@::Codes_Lookup'	,lversiondate);
	keyname				:= tools.mod_FilenamesBuild('~thor_data400::key::NAICS::Codes_Lookup'							,lversiondate,'~thor_data400::key::NAICS::@version@::Codes_Lookup');
	
	promoteinput	:= tools.mod_PromoteInput(pversion,Inputname.dall_filenames,,true);
	promotebase		:= tools.mod_PromoteBuild(pversion,basename.dall_filenames + keyname.dall_filenames	);

	tools.mac_FilesInput(Inputname	,Codes.Layout_NAICS_Codes	,InputFile	,pfiletype := 'CSV',pTerminator := '\n',pSeparator := '\t');
	tools.mac_FilesBase	(basename		,Codes.Layout_NAICS_Codes	,BaseFile		);
	
	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename
	 	,0
	 	,Inputname.logical
	 	,[ {Inputname.sprayed	}	]
	 	,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,4096
		,'\t'
	 	}
	], tools.Layout_Sprays.Info);
		
	Spray_file :=  if(					pDirectory != ''
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,pNameOutput + ' ' + pversion,pNameOutput));

	Codes.Layout_NAICS_Codes trfProject(Codes.Layout_NAICS_Codes l) := transform
		self := l;
	end;

	outfile := project(InputFile.using,trfProject(left));

	tools.mac_WriteFile(basename.new,outfile,WriteFile,pOverwrite := true);

	tools.mac_WriteIndex('Codes.Key_NAICS, keyname.new'	,WriteKey	);

	emailN := fileservices.sendemail(_Control.MyInfo.EmailAddressNormal,
									'NAICS: BUILD Key SUCCESS '+ pversion ,
									'keys: ' + keyname.qa + '(' + keyname.logical + '),\n');

	return sequential(
		 Spray_file
		,promoteinput.sprayed2using
		,WriteFile
		,promotebase.new2built
		,promotebase.built2qa
		,WriteKey
		,promotebase.new2built
		,promotebase.built2qa
		,promoteinput.using2used
		,emailN
	);

end;
