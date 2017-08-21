/*  Gets all attributes for specified module
tools.fun_GetAttributes(
	 pModuleName          := 'oldmod'
	,pAttributeNamesRegex	:= ''   
	,pSandboxed				    := false 
);
*/
export fun_GetAttributes(

	 string		pModuleName
	,string 	pAttributeNamesRegex	= ''    //filter for specific attributes
	,boolean	pSandboxed				    = false 
  ,boolean  pGetHistory           = false

) :=
function
  

	datts     := tools.mod_Soapcalls.fFindAttributes(pModuleName,pAttributeNamesRegex,,,pSandboxed,pShouldIncludeHistory := pGetHistory) ;//: independent;
	
	datts_proj := project(datts, transform(
	{string modulename,string attributename,string fullname,string ModifiedBy,string ModifiedDate,string Description, string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,attname := left.fullname;
	
	 self.importtext 		:= 		
                            '//Import:'       + attname           + '\n'
                          // + '//ModifiedBy:'   + left.ModifiedBy   + '\n'
                          // + '//ModifiedDate:' + left.ModifiedDate + '\n'
                          // + '//Description:'  + left.Description  + '\n'
													+ left.text
													;
	 self.actualtext 		:= left.text;
	 self.fullname 		  := attname;
	 self.attributename	:= left.attributename;
	 self.modulename   	:= pModuleName;
   self               := left;
	));
  
  dresult := datts_proj;	

  return dresult;
  	
end;
