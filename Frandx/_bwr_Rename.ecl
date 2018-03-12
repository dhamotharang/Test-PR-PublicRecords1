pversion					:= '';
pJustKeys					:= true	;// only rename the keys(not files)?
pIsTesting				:= true	;// set to false to actually rename the keys
pFilesToRename		:= if(pJustKeys	, Frandx.keynames	(pversion).dall_filenames
																	, Frandx.keynames	(pversion).dall_filenames
																	+ Frandx.filenames(pversion).dall_filenames
											);
pSuperfileVersion	:= 'qa';																							

#workunit('name', Frandx._Dataset().Name + ' Rename Build Files ' + pversion);

Frandx.Rename_Keys(
	 pversion						:= pversion					 
	,pJustKeys					:= pJustKeys					
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);
