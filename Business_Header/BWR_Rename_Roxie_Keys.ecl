pversion				:= ''			;	//set to new version
PackageName			:= 'All'	;	//set to package to rename
IsTesting				:= true		;	//Set to false to actually rename
pJustKeys				:= false	;	//true = just rename the roxie keys, false = rename the roxie keys + the base files(everything)
pSuperVersion		:= 'qa'		;	//superfiles that contain the logical files to be renamed
pLogicalVersion	:= ''			;	//set to old version(if u only want a certain build version to be renamed)

#workunit ('name', 'Rename ' + PackageName + ' package to ' + pversion);

Business_Header.Proc_Rename_Logical_Keys(pversion, PackageName,IsTesting,pJustKeys,pSuperVersion,pLogicalVersion);

/* List of package names:
'ACA'									
'AddressHRI|hri'				
'BusinessHeader|bh'		
'BusinessBest|execs|bb'
'Govdata|gov'	
'Peopleatwork|paw'				
'All'
*/							
