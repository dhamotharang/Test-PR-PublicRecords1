/*
tools.fun_CopyModule_Fuzzy(

	 pSourceModuleName      := 'BIPV2_ProxID_mj6_dev'
	,pDestinationModuleName := 'BIPV2_ProxID_mj6'
	,pAttNamesRegex	        := '^_(.*)$'
	,pAttNamesReplacement	  := '$1'
	,pShouldSaveAtts				:= true 
	,pSandboxed				      := false 
  ,pShouldRemoveDups      := true

);
  so what i need is this:
  copy a module
  for attributes that exist in the destination module, copy over normally(remove dups though)
  if source attribute doesn't exist in destination module, look for it again.
    what you want is a way to specify how to get the new name.  prefix, suffix, regex.
    if you find it, then rename that destination attribute, then copy it over to that name(names should be the same)
  for source atts that you don't find in either of the above ways, copy them over normally.
  for destination ones that you don't find in the source module in any of the above ways, rename them by prepending with triple underscores to group them together to make easier to delete.  

*/
export fun_CopyModule_Fuzzy(

	 string		pSourceModuleName
	,string		pDestinationModuleName
	,string 	pAttNamesRegex	      = ''
	,string 	pAttNamesReplacement	= ''
	,boolean	pShouldSaveAtts				= false 
	,boolean	pSandboxed				    = false 
  ,boolean  pShouldRemoveDups     = true

) :=
function

	datts_Source      := tools.mod_Soapcalls.fFindAttributes(pSourceModuleName      ,,,,pSandboxed) : independent;
	datts_Destination := tools.mod_Soapcalls.fFindAttributes(pDestinationModuleName ,,,,pSandboxed) : independent;
	
	lmap(string pString)	:= if(regexfind(pSourceModuleName,pString,nocase)
																,regexreplace(pSourceModuleName,pString,pDestinationModuleName,nocase)	
																,pString
													);

	datts_Source_proj := project(datts_Source, transform(
	{string sourcemodulename,string destmodulename,string attributename,string sourceatt, string destatt,string regexatt,string regexfullname, string importtext {maxlength(1000000)}, string actualtext {maxlength(1000000)}}
	,
   attname              := lmap(left.fullname);	
	 self.importtext 		  := 	  	'//Import:' + attname + '\n'
                            + lmap(left.text)
                            ;
	 self.actualtext 		  := lmap(left.text);
	 self.sourceatt 		  := left.fullname;
	 self.destatt 				:= attname;
	 self.attributename	  := left.attributename;
	 self.destmodulename	:= pDestinationModuleName;
   self.regexatt        := if(pAttNamesRegex != '' and regexfind(pAttNamesRegex,self.attributename,nocase) ,regexreplace(pAttNamesRegex,self.attributename,pAttNamesReplacement,nocase)  ,self.attributename);
   self.regexfullname   := trim(self.destmodulename) + '.' + trim(self.regexatt);
   self.sourcemodulename  := pSourceModuleName;
	));
  
  fremovespaces(string pstring) := trim(regexreplace('[[:space:]]',pstring,''));
  
  dAtts_In_Common         := join(datts_Source_proj,datts_Destination,left.destatt     = right.fullname and fremovespaces(left.actualtext) != fremovespaces(right.text)  ,transform(recordof(left ),self := left )           ) : independent;//for att that do exist in Destination module
  dSource_Atts_Only       := join(datts_Source_proj,datts_Destination,left.destatt     = right.fullname                                                                  ,transform(recordof(left ),self := left ),left  only) : independent;//for Source atts that don't exist in Destination module
  dDestination_Atts_Only  := join(datts_Source_proj,datts_Destination,left.destatt     = right.fullname                                                                  ,transform(recordof(right),self := right),right only) : independent;//for Destination atts that don't exist in Source module

  dSource_Atts_regex      := join(dSource_Atts_Only,datts_Destination,left.regexfullname = right.fullname                                                                ,transform(recordof(left ),self := left )) : independent;//rename these destination atts before copying over source 
  dSource_Atts_Only2      := join(dSource_Atts_Only,datts_Destination,left.regexfullname = right.fullname                                                                ,transform(recordof(left ),self := left ),left  only) : independent;//copy over normally, don't exist in dest 
  dDestination_Atts_Only2 := join(dSource_Atts_Only,dDestination_Atts_Only,left.regexfullname = right.fullname                                                           ,transform(recordof(right),self := right),right only) : independent;//rename with double underscore, don't exist in source 
  

//tools.mod_Soapcalls.fRenameAttribute('zz_lbentley','testatt2','zz_lbentley','_testatt');


  dStandard_Copy := dAtts_In_Common + dSource_Atts_Only2 + dSource_Atts_regex;

  dDestAtts_To_Rename := dSource_Atts_regex;
  
	saveatts              := apply(dStandard_Copy	        ,output(tools.mod_Soapcalls.fSaveAttribute  (destmodulename,attributename,pText := actualtext      ),NAMED('SaveAtts'  ),EXTEND));
	rename_dest_Atts      := apply(dDestAtts_To_Rename	  ,output(tools.mod_Soapcalls.fRenameAttribute(destmodulename,regexatt,destmodulename ,attributename ),NAMED('RenameAtts'),EXTEND)); //rename dest atts that fine with regex
	rename_dest_Only_Atts := apply(dDestination_Atts_Only2,output(tools.mod_Soapcalls.fRenameAttribute(pDestinationModuleName ,attributename   ,pDestinationModuleName     ,'___' + attributename  ),NAMED('RenameDestOnlyAtts'),EXTEND)); //rename dest att that can't find at all
  
  outputresults := parallel(
     output(datts_Source_proj      ,named('datts_Source_proj'     ),all)
    ,output(dAtts_In_Common        ,named('dAtts_In_Common'       ),all)
    ,output(dSource_Atts_Only      ,named('dSource_Atts_Only'     ),all)
    ,output(dDestination_Atts_Only ,named('dDestination_Atts_Only'),all)

    ,output(dSource_Atts_regex     ,named('dSource_Atts_regex'     ),all)
    ,output(dSource_Atts_Only2     ,named('dSource_Atts_Only2'     ),all)
    ,output(dDestination_Atts_Only2,named('dDestination_Atts_Only2'),all)

  );
  
  doit := sequential(
     rename_dest_Atts
    ,saveatts
    ,rename_dest_Only_Atts  
  );
 
	return iff(pShouldSaveAtts	= false	,outputresults
																			,doit
				);
	
end;
