//The fFixControllerName function tries to handle name fields where multiple names exist and ensures that the
//last names are associated with both names IF the last name is common to both.  For Controller_Name the format
//expected is as follows: Firstname, Initial(optional), Lastname(optional) AND Firstname, Initial(optional),
//Lastname.  If the lastname is missing for the first person, the last person's name for the second person
//is added as the first person's last name.  
//For example, RON AND BARB SMITH is returned as RON SMITH;BARB SMITH.
//This allows the macro Address.Mac_Is_Business to work correctly.
export fFixControllerName(string Name) := function		
		trimName	 		:= TRIM(Name);
		ANDcnt  	 		:= StringLib.StringFindCount(trimName,' AND ');		//If "AND" exists, there are multiple names
		totNoBlanks		:= StringLib.StringFindCount(trimName,' ');			
		firstblankloc := StringLib.StringFind(trimName,' ',1);
		ANDloc		 		:= StringLib.StringFind(trimName,' AND ',1);
		lastname  		:= IF (firstblankloc > 0
												,trimName[1..firstblankloc-1]							 	//In this data the lastname precedes the  
												,''																				 	//first name for the first person's name.
												);
		tempname2			:= IF (ANDcnt > 0,trimName[ANDloc+5..],trimName);	//This loads the second person's first name.
		blankcnt2 		:= stringlib.stringfindcount(tempname2,' ');	 	 	//This determines if a middle initial/name exists .
		blankloc2   	:= StringLib.StringFind(tempname2,' ',1);				 
		initials			:= IF(LENGTH(TRIM(tempname2[blankloc2+1..]))=1,tempname2[blankloc2..],''); //This loads middle initials/name.		
		tempname			:= IF (blankcnt2 = 0 OR initials <> ''					 	//This loads the common last name to the second
											,StringLib.StringFindReplace(trimName+' '+lastname,' AND ',';')  //person's name in the input field.
											,IF (firstblankloc = 2											 	//If there is an initial in column one followed by a blank
												,trimName																	 	//then this is typically a business; don't change input.
												,StringLib.StringFindReplace(trimName,' AND ',';')
												)
											);
		return(tempname);
end;