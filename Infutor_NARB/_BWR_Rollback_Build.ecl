#workunit('name', 'Rollback ' + Infutor_NARB._Dataset().name + ' Build');
Infutor_NARB.Rollback(
	 pversion						:=	''			//version of build you are rolling back
	,pDeleteInputFiles	:= 	false		//Are the input files bad and need to be deleted?
	,pDeleteBuildFiles	:= 	false		//are the build files bad(base and key files) and need to be deleted?
	,pIsTesting					:= 	true		//if false, will perform rollback and optional deletion.  
																	//If true, just output dataset of information gathered.
	,pFilter						:= 	''			//regex filter to use if u want to rollback only specific files/keys
).fullbuild;
