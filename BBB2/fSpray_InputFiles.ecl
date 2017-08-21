import ut,bbb2, lib_fileservices, _control, versioncontrol;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- fSpray_InputFiles() function:
// -- 	Sprays all BBB Member and Non-Member Input files located in specified directory
// --	and adds them to the appropriate superfiles.
// -- 	Parameters:
// -- 		string	pSourceIP			-- Remote Server's IP address
// -- 		string	pSourceDirectory	-- Absolute path of directory on Remote Server where files are located
// -- 		string	pReceivedDate		-- Receiving Date of files in Directory
// -- 		string	pGroupName			-- Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
// -- 		boolean	pIsTesting			-- Testing flag, ex. true = no spray, just output dataset.
// -- 		string	pMemberFilter		-- Regular expression for matching all Member filenames in directory.  Default 'member*out'
// -- 		string	pNonMemberFilter	-- Regular expression for matching all Nonmember filenames in directory.  Default 'nonmember*out'
// --
// -- Please run on hthor for maximum speed
// -- 
// -- Example spray using this function(to dataland400):
// -- 	bbb2.fSpray_InputFiles('192.168.0.39','/thor_back5/bbb/build/20060327/','20060327','thor_data400');
// --
// -- That same spray to production400:
// -- 	bbb2.fSpray_InputFiles('192.168.0.39','/thor_back5/bbb/build/20060327/','20060327');
//////////////////////////////////////////////////////////////////////////////////////////////
export fSpray_InputFiles(
	 
	 string		pDirectory					= '/data/thor_back5/bbb/build/'
	,string		pServerIP						= _control.IPAddress.bctlpedata10
	,string		pMemberFilename			= 'member*xml.out'
	,string		pNonMemberFilename	= 'nonmember*xml.out'
	,string		pGroupName					= _dataset().groupname																		
	,boolean	pIsTesting					= false
	,boolean	pOverwrite					= false
	,string		pNameOutput					= _Dataset().Name + ' Spray Info'

) :=
function
	
	//get version of files from the subdirectory they are in
	lversion	:= regexreplace('^(.*?/)([^/]*?)/?$'	,pDirectory	, '$2');

	FilesToSpray := DATASET([

		{	 
		 pServerIP												
		,pDirectory                             
		,pMemberFilename                                          
		,0                                                             
		,Filenames(lversion).Input.Member.Template    
		,[{Filenames().Input.Member.Sprayed}]    
		,pGroupName                                                
		,lversion                                                    
		,''                                                            
		,'XML'                                                         
		,'listing'                                                     
		}

		,{	 
		 pServerIP												
		,pDirectory                             
		,pNonMemberFilename                                          
		,0                                                             
		,Filenames(lversion).Input.NonMember.Template    
		,[{Filenames().Input.NonMember.Sprayed}]    
		,pGroupName                                                
		,lversion                                                    
		,''                                                            
		,'XML'                                                         
		,'listing'                                                     
		}

	], VersionControl.Layout_Sprays.Info);

	return VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,,pIsTesting,,_Dataset().Name + ' ' + lversion,pNameOutput);

end;