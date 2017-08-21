pversion					:= '';
pJustKeys					:= true	;// only rename the keys(not files)?
pIsTesting				:= true	;// set to false to actually rename the keys
pFilesToRename		:= if(pJustKeys	, YellowPages.keynames	(pversion).dall_filenames
																	, YellowPages.keynames	(pversion).dall_filenames
																	+ YellowPages.filenames	(pversion).dall_filenames
											);
pSuperfileVersion	:= 'qa';																							

#workunit('name', YellowPages.Constants().Name + ' Rename Build Files ' + pversion);

YellowPages.Rename_Keys(
	 pversion						:= pversion					 
	,pJustKeys					:= pJustKeys					
	,pIsTesting					:= pIsTesting				
	,pFilesToRename			:= pFilesToRename		
	,pSuperfileVersion	:= pSuperfileVersion	
);