pversion					:= '';
pJustKeys					:= true	;// only rename the keys(not files)?
pIsTesting				:= true	;// set to false to actually rename the keys
pFilesToRename		:= if(pJustKeys	, One_Click_Data.keynames	(pversion).dall_filenames
																	, One_Click_Data.keynames	(pversion).dall_filenames
																	+ One_Click_Data.filenames(pversion).dall_filenames
											);
pSuperfileVersion	:= 'qa';																							

#workunit('name', Teletrack._Dataset().Name + ' Rename Build Files ' + pversion);

Teletrack.Rename_Keys(
	 pversion						:= pversion					 
	,pJustKeys					:= pJustKeys					
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);