pversion					:= '';

pIsTesting				:= true	;// set to false to actually rename files
pFilesToRename		:= QA_Data.filenames(pversion).dall_filenames
											
pSuperfileVersion	:= 'qa';																							

#workunit('name', QA_Data._Dataset().Name + ' Rename Build Files ' + pversion);

QA_Data.Rename_Files(
	 pversion						:= pversion					 
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);