pversion					:= '';
pJustKeys					:= true	;// only rename the keys(not files)?
pIsTesting				:= true	;// set to false to actually rename the keys
pFilesToRename		:= if(pJustKeys	, Zoom.keynames	(pversion).dall_filenames
																	, Zoom.keynames	(pversion).dall_filenames
																	+ Zoom.filenames(pversion).dall_filenames
											);
pSuperfileVersion	:= 'qa';																							

#workunit('name', Zoom._Dataset().Name + ' Rename Build Files ' + pversion);

Zoom.Rename_Keys(
	 pversion						:= pversion					 
	,pJustKeys					:= pJustKeys					
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);