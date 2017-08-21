//The fFixOperatorName function tries to handle name fields where multiple names exist and ensures that the
//last names are associated with both names IF the last name is common to both.  For Operator_Name the format
//expected is as follows: Firstname, Initial(optional), Lastname(optional) AND Firstname, Initial(optional),
//Lastname.  If the lastname is missing for the first person, the last person's name for the second person
//is added as the first person's last name.  
//For example, RON AND BARB SMITH is returned as RON SMITH;BARB SMITH.
//This allows the macro Address.Mac_Is_Business to work correctly.
export fFixOperatorName(string Name) := function	
		trimName	 		:= trim(Name,LEFT,RIGHT);
		ANDcnt  	 		:= StringLib.StringFindCount(trimName,' AND ');
		ANDloc		 		:= StringLib.StringFind(trimName,' AND ',1);		
		totNoBlanks		:= StringLib.StringFindCount(trimName,' ');
		//Break down the name components of the first person
		blankloc1_1 := StringLib.StringFind(trimName,' ',1);
		blankloc2_1 := StringLib.StringFind(trimName,' ',2);		
		fullname1			:= trimName[1..Andloc-1];
		MI_Exists1		:= IF (StringLib.StringFindCount(fullname1,' ') > 1
												,true
												,IF (blankloc1_1+1 = Andloc-1
													,true
													,false
													 )
												);
		firstname1		:= IF (blankloc1_1<>0
												,fullname1[1..blankloc1_1-1]
												,fullname1
												);	
		initial1			:= IF (MI_Exists1
											,trim(trimName[blankloc1_1+1..blankloc2_1-1])
											,''
											);													
		lastname1  		:= IF (MI_Exists1
												,trimName[blankloc2_1+1..ANDloc-1]
												,trimName[blankloc1_1+1..ANDloc-1]
												);
		//Break down the name components of the second person
		fullname2			:= trim(IF (ANDcnt > 0,trimName[ANDloc+5..],trimName),LEFT,RIGHT);
		blankloc1_2 	:= StringLib.StringFind(fullname2,' ',1);
		blankloc2_2 	:= StringLib.StringFind(fullname2,' ',2);	
		MI_Exists2		:= IF (StringLib.StringFindCount(fullname2,' ') > 1
												,true
												,false
												);									
		firstname2		:= IF (blankloc1_2<>0
												,fullname2[1..blankloc1_2-1]
												,fullname2
												);			
		initial2			:= IF (MI_Exists2
											,fullname2[blankloc1_2+1..blankloc2_2-1]
											,''
											);												
		lastname2  		:= IF (MI_Exists2
												,fullname2[blankloc2_2+1..]
												,fullname2[blankloc1_2+1..]												
												);								
		tempname			:= IF (lastname1 = ''
												,firstname1+' '+initial1+' '+lastname2+';'+firstname2+' '+initial2+' '+lastname2
												,firstname1+' '+initial1+' '+lastname1+';'+firstname2+' '+initial2+' '+lastname2
												);
		returnname		:= IF (blankloc1_2 <> 0 			//No last name for second person so send original name
												,StringLib.StringCleanSpaces(trim(tempname))
												,StringLib.StringCleanSpaces(trim(trimName))
												);
		return(returnname);
end;