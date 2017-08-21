pversion					:= '';
pJustKeys					:= true	;// only rename the keys(not files)?
pIsTesting				:= true	;// set to false to actually rename the keys
pFilesToRename		:= if(pJustKeys	, Jigsaw.keynames	(pversion).dall_filenames
																	, Jigsaw.keynames	(pversion).dall_filenames
																	+ Jigsaw.filenames(pversion).dall_filenames
											);
pSuperfileVersion	:= 'qa';																							

#workunit('name', Jigsaw._Dataset().Name + ' Rename Build Files ' + pversion);

Jigsaw.Rename_Keys(
	 pversion						:= pversion					 
	,pJustKeys					:= pJustKeys					
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);