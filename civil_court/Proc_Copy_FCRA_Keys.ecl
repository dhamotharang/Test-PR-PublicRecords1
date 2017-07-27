import _Control,ut,lib_fileservices;

// Purpose: Copy a nonfcra key to FCRA key with same version

export Proc_Copy_FCRA_Keys(string filedate,string datasetname,string keysuffix) := function


STRING destination_cluster := 'thor_data400';

	clearallsuperfiles(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSuperkeys) := 
		apply(pSetSuperkeys, fileservices.ClearSuperFile('~' + name));

	addtoallsuperfiles(DATASET(lib_fileservices.FsLogicalFileNameRecord) pSetSuperkeys,string dname) := 
		apply(pSetSuperkeys, fileservices.addsuperfile('~' + name,dname));


	movekey(string fdate,string dsname,string ks) := 
		sequential(
				if ( NOT fileservices.superfileexists('~thor_data400::key::'+dsname+'::fcra::delete::'+ks),
					fileservices.createsuperfile('~thor_data400::key::'+dsname+'::fcra::delete::'+ks)),
				if ( NOT fileservices.superfileexists('~thor_data400::key::'+dsname+'::fcra::father::'+ks),
					fileservices.createsuperfile('~thor_data400::key::'+dsname+'::fcra::father::'+ks)),
				if ( NOT fileservices.superfileexists('~thor_data400::key::'+dsname+'::fcra::qa::'+ks),
					fileservices.createsuperfile('~thor_data400::key::'+dsname+'::fcra::qa::'+ks)),
				fileservices.startsuperfiletransaction(),
				fileservices.addsuperfile('~thor_data400::key::'+dsname+'::fcra::delete::'+ks,
										'~thor_data400::key::'+dsname+'::fcra::father::'+ks,,true),
				fileservices.clearsuperfile('~thor_data400::key::'+dsname+'::fcra::father::'+ks),
				fileservices.addsuperfile('~thor_data400::key::'+dsname+'::fcra::father::'+ks,
										'~thor_data400::key::'+dsname+'::fcra::qa::'+ks,,true),
				fileservices.clearsuperfile('~thor_data400::key::'+dsname+'::fcra::qa::'+ks),
				fileservices.addsuperfile('~thor_data400::key::'+dsname+'::fcra::qa::'+ks,
										'~thor_data400::key::'+dsname+'::fcra::'+filedate+'::'+ks),
				fileservices.finishsuperfiletransaction(),
				fileservices.clearsuperfile('~thor_data400::key::'+dsname+'::fcra::delete::'+ks,true)
		);
	

	sourcekeyname := '~thor_data400::key::'+datasetname+'::'+filedate+'::'+keysuffix;
	destkeyname := '~thor_data400::key::'+datasetname+'::fcra::'+filedate+'::'+keysuffix;
	superkeys := fileservices.LogicalFileSuperOwners(destkeyname);
	
	email_me := fileservices.sendemail(
													'gavin.witz@lexisNexis.com',
													'Civil Court NonFCRA-FCRA Copy Failed ' + filedate,
													sourcekeyname + ' does not exist, check ' + WORKUNIT
													);
	
	copyfile := nothor(if (
					// If sourcekey doesn't exist - no copy
					fileservices.fileexists(sourcekeyname),
						// If sourcekey exists, check if the destkeyname exists
						// if exists, remove/clear this destkey from all superfiles
						if (fileservices.fileexists(destkeyname),
							sequential(
								output(destkeyname + ' already exists, clearing superfiles to copy'),
								// Clearing superkeys
								clearallsuperfiles(superkeys),
								// Copy file
								fileservices.copy(sourcekeyname,_control.TargetGroup.BDL_400,destkeyname,,,,,true,true),
								// perform superfile transacation
								movekey(filedate,datasetname,keysuffix)
								),
							// if destkey doesn't exist, copy and perform superfile transaction
							sequential(
								output('Copying ' + sourcekeyname + ' to ' + destkeyname),
								// Copy file
								fileservices.copy(sourcekeyname,_control.TargetGroup.BDL_400,destkeyname,,,,,true,true),
              
                // perform superfile transaction
								movekey(filedate,datasetname,keysuffix)
								)
							),
					email_me
					));
	
	return copyfile;
		
end;