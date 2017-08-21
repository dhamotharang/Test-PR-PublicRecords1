/*
tools.fun_CreateModule(
	 pOldModuleName       := 'oldmod'
	,pNewModuleName       := 'newmod'
	,pAttributeNamesRegex	:= ''
	,pShouldSaveAtts			:= false 
	,pSandboxed				    := false 
  ,pShouldRemoveDups    := false
);
*/
export fun_CreateModule(

	 string		pOldModuleName
	,string		pNewModuleName
	,string 	pAttributeNamesRegex	= ''
	,boolean	pShouldSaveAtts				= false 
	,boolean	pSandboxed				    = false 
  ,boolean  pShouldRemoveDups     = false

) :=
function

	datts     := tools.mod_Soapcalls.fFindAttributes(pOldModuleName,pAttributeNamesRegex,,,pSandboxed) : independent;
	dattsnew  := tools.mod_Soapcalls.fFindAttributes(pNewModuleName,pAttributeNamesRegex,,,pSandboxed) : independent;
	
	lmap(string pString)	:= if(regexfind(pOldModuleName,pString,nocase)
																,regexreplace(pOldModuleName,pString,pNewModuleName,nocase)	
																,pString
													);

	datts_proj := project(datts, transform(
	{string newmodulename,string attributename,string oldatt, string newatt, string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,attname := lmap(left.fullname);
	
	 self.importtext 		:= 		'//Import:' + attname + '\n'
													+ lmap(left.text)
													;
	 self.actualtext 		:= lmap(left.text);
	 self.oldatt 				:= left.fullname;
	 self.newatt 				:= attname;
	 self.attributename	:= left.attributename;
	 self.newmodulename	:= pNewModuleName
	));
  
  fremovespaces(string pstring) := trim(regexreplace('[[:space:]]',pstring,''));
  
  djoin  := join(datts_proj,dattsnew,left.newatt = right.fullname and fremovespaces(left.actualtext) != fremovespaces(right.text)  ,transform(recordof(left),self := left)          ) : independent;//for att that do exist in new module
  djoin2 := join(datts_proj,dattsnew,left.newatt = right.fullname                                                                  ,transform(recordof(left),self := left),left only) : independent;//for atts that don't exist in the new module

  dresult := if(pShouldRemoveDups ,djoin + djoin2 ,datts_proj);
  
	saveatts := apply(dresult	,output(tools.mod_Soapcalls.fSaveAttribute(newmodulename,attributename,pText := actualtext),NAMED('SaveAtts'),EXTEND));
	

	return iff(pShouldSaveAtts	= false	,output(dresult,all)
																			,saveatts
				);
	
end;
